import org.testng.annotations.Test;

public class AppTest {

    @Test// 倒序打印字符，没提示真的做不出来，希望多加练习，可以多记忆一些常用的函数才行。
    public void printstring(){
        String str="I love shanghai.";
        String[] lstr=str.split(" ");
        String newstr="";
        for(int i=lstr.length-1;i>=0;i--){
             newstr=newstr+" "+lstr[i];
        }
        System.out.println(newstr);// 倒着输出
    }
@Test// 素数也就是质数：指在大于1的自然数中，除了1和该数自身外，无法被其他自然数整除的数
public void print2() {
        int total=0;
    for (int i = 2; i < 100; i++) {
        boolean flag = true;
        // i以此近来验证下，如果不符合定义，之间flag=false 并且之间跳出j的for循环。
        for (int j = 2; j < i; j++) {
            if (i % j == 0) {
                flag = false;
                break;
            }
        }
        if (flag) {
            System.out.print(" " + i);
            total++;
        }
    }
    System.out.println("total="+total);
}
    @Test// 素数也就是质数：指在大于1的自然数中，除了1和该数自身外，无法被其他自然数整除的数
    public void print3() {
        int total=0;
        for(int i=2;i<100;i++){
            boolean flag=true;
            for(int j=2;j<= Math.sqrt(i);j+=1){// 和取根号下的数据依次比对，然后看结果
                if(i%j==0){
                    flag=false;
                    break;
                }
            }
            if(flag){
                System.out.print(i+" ");
                total++;
            }
        }
        System.out.println("total="+total);

    }



}
