package Device;

import org.testng.annotations.Test;

/**
 * @author yanbingHuang
 * @create 2020-10-2020/10/20 8:20 下午
 **/
public class EvenNumTest {
@Test
    public void TestIntIsEvent(){
        for (int i=Integer.MIN_VALUE;i<=Integer.MAX_VALUE;++i){
            boolean isEven=(i%2==0);
            System.out.println(String.format("i=%d,isEven=%b",i,isEven));

        }
    }

    @Test
    public void Test_flag(){
        System.out.println("负数"+(-1));
        System.out.println("取反操作符"+(~2));
        System.out.println(Integer.toBinaryString(2));
        System.out.println(Integer.toBinaryString(-3));
    }
}
