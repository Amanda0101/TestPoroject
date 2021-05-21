import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.testng.annotations.Test;

import java.io.FileInputStream;
import java.util.Properties;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/20 5:59 下午
 **/
public class LogTest {
    Properties prop = null;
    FileInputStream fileInputStream=null;

    @Test
    public void Testlog() {
        Logger logger = Logger.getLogger(LogTest.class.getName());
//        try {
//            prop.load(this.getClass().getClassLoader().getResourceAsStream("log4j.properties"));
////            PropertyConfigurator.configure("log4j.properties");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        try {
            prop=new Properties();
            fileInputStream=new FileInputStream("Common/log4j.properties");
            prop.load(fileInputStream);
            PropertyConfigurator.configure(prop);//
        }catch (Exception e){
            e.printStackTrace();
        }

        logger.debug("debug log msg");
        logger.info("info log msg");
        logger.warn("warn log msg");
        logger.error("error log msg");

    }
}
