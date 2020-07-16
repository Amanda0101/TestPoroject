package Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * @author yanbingHuang
 * @create 2020-06-2020/6/30 8:06 下午
 * myql DB的各种util 都在这个类中了
 **/
public class DbUtil {

    //通过配置文件mysql.properties连接数据库
    public Connection openConnection(){
        Properties prop=new Properties();
        String driver=null;
        String username=null;
        String url=null;
        String pwd=null;
        try{
          //properties文件这里要注意:
            // 1.target class目录下要有这个文件，
            // 2、modules 配置中，务必加上resource folder路径，才可以在target中出现
            // 3、getResourceAsStream的入参string是这个配置文件的相对路径不能以'/'开头，这个函数对应的根目录是target/classes
            prop.load(this.getClass().getClassLoader().getResourceAsStream("Common/mysql.properties"));
            driver=prop.getProperty("jdbc.driverClass");
            url=prop.getProperty("jdbc.url");
            username=prop.getProperty("jdbc.username");
            pwd=prop.getProperty("jdbc.password");
            Class.forName(driver);
            return DriverManager.getConnection(url,username,pwd);
        }catch(ClassNotFoundException e){
            e.printStackTrace();
        }catch(SQLException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    //之间获取202机器的connection
    public  Connection getconnection(){
        String driver="com.mysql.cj.jdbc.Driver";
        String jdbcurl="jdbc:mysql://10.151.3.203:3306/";
        String username="root";
        String password="qa@sensetime";
        Connection connection=null;
        try {
            Class.forName(driver);
             connection= DriverManager.getConnection(jdbcurl,username,password);
        } catch (Exception exception){
            System.out.println("发现加载mysql driver or获取链接异常，请排查！");
        }
        return connection;
    }

    //关闭数据库
    public void closeConn(Connection conn){
        try {
            if (conn!=null)
            {
                conn.close();
                System.out.println("数据库已关闭");
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            System.out.println("数据库关闭异常");
            e.printStackTrace();
        }
    }

}
