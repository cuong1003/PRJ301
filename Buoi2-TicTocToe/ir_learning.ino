#include <IRremote.h>
#include <EEPROM.h>

// Định nghĩa chân
const int IR_RECEIVE_PIN = A0;  // Chân nhận tín hiệu hồng ngoại
const int IR_SEND_PIN = 10;     // Chân phát tín hiệu hồng ngoại

// Địa chỉ EEPROM để lưu mã
const int EEPROM_ADDRESS_ON = 0;
const int EEPROM_ADDRESS_OFF = 4;
const int EEPROM_ADDRESS_PROTOCOL = 8;  // Lưu protocol

// Biến lưu trữ tín hiệu đã học
unsigned long learnedCodeOn = 0;
unsigned long learnedCodeOff = 0;
decode_type_t learnedProtocol = UNKNOWN;  // Protocol đã học
bool isLearningMode = true;
bool isFirstCodeLearned = false;
bool isACOn = false;  // Biến theo dõi trạng thái điều hòa

void setup() {
  Serial.begin(9600);
  
  // Khởi tạo bộ thu hồng ngoại
  IrReceiver.begin(IR_RECEIVE_PIN);
  
  // Khởi tạo bộ phát hồng ngoại
  IrSender.begin(IR_SEND_PIN);
  
  // Đọc mã đã lưu từ EEPROM
  EEPROM.get(EEPROM_ADDRESS_ON, learnedCodeOn);
  EEPROM.get(EEPROM_ADDRESS_OFF, learnedCodeOff);
  EEPROM.get(EEPROM_ADDRESS_PROTOCOL, learnedProtocol);
  
  if (learnedCodeOn != 0 && learnedCodeOff != 0 && learnedProtocol != UNKNOWN) {
    isLearningMode = false;
    Serial.println("Đã tìm thấy mã đã lưu!");
    Serial.print("Protocol: ");
    Serial.println(getProtocolString(learnedProtocol));
    Serial.print("Mã BẬT: 0x");
    Serial.println(learnedCodeOn, HEX);
    Serial.print("Mã TẮT: 0x");
    Serial.println(learnedCodeOff, HEX);
  } else {
    Serial.println("Chương trình học tín hiệu hồng ngoại");
    Serial.println("1. Đặt điều khiển điều hòa gần bộ thu và nhấn nút bật/tắt LẦN 1");
    Serial.println("2. Sau đó nhấn nút bật/tắt LẦN 2");
    Serial.println("3. Sau khi học xong, bạn có thể sử dụng bất kỳ điều khiển nào");
  }
}

// Hàm phát tín hiệu dựa trên protocol
void sendIRCode(unsigned long code) {
  switch (learnedProtocol) {
    case NEC:
      IrSender.sendNEC(code, 32);
      break;
    case SONY:
      IrSender.sendSony(code, 20);
      break;
    case RC5:
      IrSender.sendRC5(code, 8);
      break;
    case RC6:
      IrSender.sendRC6(code, 20);
      break;
    case PANASONIC:
      IrSender.sendPanasonic(0x4004, (uint8_t)(code & 0xFF), 0);
      break;
    case LG:
      IrSender.sendLG(code, 32);
      break;
    case JVC:
      IrSender.sendJVC(code, 16, false);
      break;
    case SAMSUNG:
      IrSender.sendSAMSUNG(code, 32);
      break;
    default:
      // Thử các protocol phổ biến nhất
      Serial.println("Thử các protocol phổ biến...");
      IrSender.sendNEC(code, 32);
      delay(100);
      IrSender.sendSony(code, 20);
      delay(100);
      IrSender.sendRC5(code, 8);
      delay(100);
      IrSender.sendRC6(code, 20);
      delay(100);
      IrSender.sendLG(code, 32);
      delay(100);
      IrSender.sendSAMSUNG(code, 32);
      break;
  }
}

void loop() {
  if (isLearningMode) {
    if (IrReceiver.decode()) {
      if (!isFirstCodeLearned) {
        // Lưu mã BẬT và protocol
        learnedCodeOn = IrReceiver.decodedIRData.decodedRawData;
        learnedProtocol = IrReceiver.decodedIRData.protocol;
        
        Serial.println("\n=== THÔNG TIN TÍN HIỆU BẬT ===");
        Serial.print("Protocol: ");
        Serial.println(getProtocolString(learnedProtocol));
        Serial.print("Mã HEX: 0x");
        Serial.println(learnedCodeOn, HEX);
        Serial.print("Number of bits: ");
        Serial.println(IrReceiver.decodedIRData.numberOfBits);
        
        isFirstCodeLearned = true;
        Serial.println("\nVui lòng nhấn nút bật/tắt LẦN 2 để học mã TẮT");
      } else {
        // Lưu mã TẮT
        learnedCodeOff = IrReceiver.decodedIRData.decodedRawData;
        
        Serial.println("\n=== THÔNG TIN TÍN HIỆU TẮT ===");
        Serial.print("Protocol: ");
        Serial.println(getProtocolString(learnedProtocol));
        Serial.print("Mã HEX: 0x");
        Serial.println(learnedCodeOff, HEX);
        Serial.print("Number of bits: ");
        Serial.println(IrReceiver.decodedIRData.numberOfBits);
        
        // Lưu cả hai mã và protocol vào EEPROM
        EEPROM.put(EEPROM_ADDRESS_ON, learnedCodeOn);
        EEPROM.put(EEPROM_ADDRESS_OFF, learnedCodeOff);
        EEPROM.put(EEPROM_ADDRESS_PROTOCOL, learnedProtocol);
        
        // Tắt chế độ học
        isLearningMode = false;
        Serial.println("\nĐã hoàn thành học tín hiệu!");
        Serial.println("Bây giờ bạn có thể sử dụng bất kỳ điều khiển nào");
      }
      
      IrReceiver.resume();
    }
  } else {
    // Kiểm tra tín hiệu từ điều khiển mới
    if (IrReceiver.decode()) {
      // Bất kỳ tín hiệu nào cũng sẽ được xử lý
      Serial.println("\n=== NHẬN TÍN HIỆU TỪ ĐIỀU KHIỂN ===");
      Serial.print("Mã HEX nhận được: 0x");
      Serial.println(IrReceiver.decodedIRData.decodedRawData, HEX);
      
      // Đảo trạng thái điều hòa và phát mã tương ứng
      if (isACOn) {
        Serial.println("Đang TẮT điều hòa...");
        sendIRCode(learnedCodeOff);
        isACOn = false;
      } else {
        Serial.println("Đang BẬT điều hòa...");
        sendIRCode(learnedCodeOn);
        isACOn = true;
      }
      
      IrReceiver.resume();
    }
  }
} 