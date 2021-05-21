import com.github.kevinsawicki.http.HttpRequest;
import org.testng.annotations.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/22 8:02 下午
 **/
public class httpRequestTest {
    @Test
    public void requesttest() {
        String response = HttpRequest.get("http://www.baidu.com").body();
        System.out.println("Response was: " + response);
    }

    @Test
    public void gettest() {
        HttpRequest request = HttpRequest.get("http://www.baidu.com", true, 'q', "baseball gloves", "size", 100);
        System.out.println(request.toString());// GET http://www.baidu.com?q=baseball%20gloves&size=100

    }
@Test
    public void posttest(){
        Map data = new HashMap();
        data.put("q", "baseball gloves");
        data.put("size", "100");
        String resp =HttpRequest.get("http://www.baidu.com").form(data).body();
        System.out.println("---------------response parameter:" + resp);
    }
}
