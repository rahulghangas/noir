use dep::std;

fn sort(mut a: [4]u32) -> [4]u32{ 
    for i in 0..3 {
        for j in 0..3-i {
            if(a[j] > a[j+1])
            {
                let c = a[j];
                a[j] = a[j+1];
                a[j+1]= c;
            }
        };
    };
    a
}

fn call_intrinsic(x : [5]u8, result : [32]u8) {

    let mut digest = std::hash::sha256(x);
    digest[0] = 5 as u8;
    digest = std::hash::sha256(x);
    constrain digest == result;
}

fn must_be_zero(x: u8) {
    constrain x == 0;
}

fn test3 (x: u8) {
    if x == 0 {
        must_be_zero(x);
    }
}

fn test4() -> [4]u32 {
    let b: [4]u32 = [1,2,3,4];
    b
}

fn main(a: u32, mut c: [4]u32, x : [5]u8, result : pub [32]u8
    ){

    if a == 3 {
        c=test4();
    }
    constrain c[1]!=2;
    call_intrinsic(x, result);

    if a==0 {
        must_be_zero(0);
        c[0]=3;
    }
    else {
        must_be_zero(1);
        c[0]=1;
    }
    constrain c[0]==3;

    let mut y = 0;
    if a == 0 {
        let digest = std::hash::sha256(x);
        y = digest[0];
    } else {
            y=5;
    }
    constrain y == result[0];
    c = sort(c);
    constrain c[0]==0;

    //test 1
    let mut x: u32 = 0;
    if a == 0 {
        c[0]=12;
        if a!=0 {
            x=6;
        }
        else {
            x=2;
            constrain x == 2;
        }
    } else {
        x = 5;
        constrain x == 5;
    }
    constrain x == 2;

    //test2: loops!
    x = 0;
    x= a-a;
    for i in 0..4 {
        if c[i] == 0
        {
            x=i as u32 +2;
        }
    };
    constrain x==0;

    test3(1);

    if a == 0 {
        c=test4();
    } else {
        constrain c[1]!=2;
    }
    if false {
        c[1]=5;
    }
    constrain c[1]==2;
}
