package AmandaApIMaven;


import Util.DbUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Hello world!
 *
 */
public class App 
{


    public static void main ( String[] args )
    {
        String sql="SELECT uuid,policy_name,policy_type FROM policy_monitor.monitoring_policy where uuid='1271961172387565569'";
//        String sql_1="delete from  monitoring_policy where uuid='1271961783829008386'";
        DbUtil dbUtil=new DbUtil();
        Connection connection=dbUtil.openConnection() ;

        try {
            Statement statement=connection.createStatement();
            ResultSet result=statement.executeQuery(sql);
//            int result1=statement.executeUpdate(sql_1);
//            System.out.println("result1="+result1);
            while(result.next()){
                String uuid=result.getString(1);
                String policy_name=result.getString(2);
                String policy_type=result.getString(3);
                System.out.println("uuid结果是："+uuid+"name="+policy_name+"type="+policy_type);
            }

            result.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }




}
