import DAO.UserDao;
import Util.DbUtil;
import org.testng.annotations.Test;


import java.sql.Connection;


/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/2 3:57 下午
 **/
public class TestMysql {
    @Test
    public void deletepolicy(){
        UserDao userDao=new UserDao();
       int result= userDao.delete("1266624605154447361");
        System.out.println("result="+result);
    }

    @Test
    public void testConnect(){
        DbUtil dbUtil=new DbUtil();
        Connection connection=dbUtil.openConnection();
    }

}
