/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */
let flag = true;
canMove = true;
function fun(x, y, n) {
    var obj = document.getElementById("tb1_" + x + "_" + y);
    if (canMove && obj.innerHTML ==="" ) {
        obj.innerHTML = flag? "X" : "O";
        obj.classList.add(flag?"red":"blue");
        canMove = !checkWin(x,y,n,flag);
        flag=!flag;
    }
}
function check(x,n) {
    return x>=0 && x<n;
}
function checkWin(x,y,n,flag) {
    c = flag?"X":"O";
    count = 0;
    //check duong cheo /
    for(i=-4;i<5;i++) {
        if (check(x+i,n)&&check(y-i,n)) {
            if (document.getElementById("tb1_"+(x+i)+"_"+(y-i)).innerHTML ===c) {
                count++;
                if (count==5) return true;
            } else { count=0;}
        }
    }
    // check duong cheo \
    for(i=-4;i<5;i++) {
        if (check(x+i,n)&&check(y+i,n)) {
            if (document.getElementById("tb1_"+(x+i)+"_"+(y+i)).innerHTML ===c) {
                count++;
                if (count==5) return true;
            } else { count=0;}
        }
    }
    // duong cheo doc
    for(i=-4;i<5;i++) {
        if (check(x+i,n)&&check(y,n)) {
            if (document.getElementById("tb1_"+(x+i)+"_"+y).innerHTML ===c) {
                count++;
                if (count==5) return true;
            } else { count=0;}
        }
    }
    // duong cheo ngang
    for(i=-4;i<5;i++) {
        if (check(x,n)&&check(y+i,n)) {
            if (document.getElementById("tb1_"+x+"_"+(y+i)).innerHTML ===c) {
                count++;
                if (count==5) return true;
            } else { count=0;}
        }
    }
}




