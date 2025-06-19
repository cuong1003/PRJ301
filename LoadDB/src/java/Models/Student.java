package Models;
import java.sql.Date;
public class Student {
    private int id;
    private String name;
    private boolean gender;
    private String departId;
    private Date dob;
    private float gpa;

    public Student() {
    }

    public Student(int id, String name, boolean gender, String departId, Date dob, float gpa) {
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.departId = departId;
        this.dob = dob;
        this.gpa = gpa;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getDepartId() {
        return departId;
    }

    public void setDepartId(String departId) {
        this.departId = departId;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public float getGpa() {
        return gpa;
    }

    public void setGpa(float gpa) {
        this.gpa = gpa;
    }

    @Override
    public String toString() {
        return "id=" + id + ", name=" + name + ", gender=" + gender + ", departId=" + departId + ", dob=" + dob + ", gpa=" + gpa;
    }
    
    
}
