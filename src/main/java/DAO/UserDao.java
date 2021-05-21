package DAO;


import Util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/1 5:34 下午
 * Dao 类主要用途，实现对mysql表的处理
 **/
public class UserDao {

    //    功能insert
    public int insert(UserBean users) {
        int i = 0;
        DbUtil util = new DbUtil();
        Connection conn = util.openConnection();//创建数据库连接
        String sql = "insert into Users (id , name, age, birthday, money) values(?,?,?,?,?)";//定义sql语句
        PreparedStatement pstmt = null;
        try {
            pstmt = (PreparedStatement) conn.prepareStatement(sql);
            pstmt.setInt(1, users.getId());
            pstmt.setString(2, users.getName());
            pstmt.setInt(3, users.getAge());
            pstmt.setString(4, users.getBirthday());
            pstmt.setInt(5, users.getMoney());
            i = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conn.rollback();
            } catch (SQLException el) {
                el.printStackTrace();
            }
        } finally {
            util.closeConn(conn);
        }
        return i;

    }

    //    删除表中的某一条数据，返回删除条数int
    public int delete(String id) {
        int i = 0;
        DbUtil util = new DbUtil();
        PreparedStatement pstmt = null;
        Connection conn = util.openConnection();//创建数据库连接
//        Connection conn=util.getconnection();
        String sql = "delete from policy_monitor.monitoring_policy where uuid='" + id + "'";//定义sql语句

        try {
            pstmt = (PreparedStatement) conn.prepareStatement(sql);
            i = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;

    }

    // 更新表字段
    public int update(UserBean users) {
        int i = 0;
        DbUtil util = new DbUtil();
        PreparedStatement pstmt;
        Connection conn = util.openConnection();//创建数据库连接
        String sql = "update Users set age='" + users.getAge() + "' where name='" + users.getName() + "'";
//        String sql1="update policy_monitor.monitoring_policy set policy_name='"+users.getName()+"' where uuid='"+users.getId()+"'";
        try {
            pstmt = (PreparedStatement) conn.prepareStatement(sql);
            i = pstmt.executeUpdate();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;

    }

    //创建list方法  用途list 当前表中的内容，并且以表格的形式打印出来哦
    public Integer list() {
        DbUtil util = new DbUtil();
        Connection conn = util.openConnection();
        String sql = "select * from Users";
        PreparedStatement pstmt;
        try {
            pstmt = (PreparedStatement) conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            int col = rs.getMetaData().getColumnCount();//列数
            System.out.println("============================");
            System.out.println("id\tname\tage\tbirthday\t\tmoney");
            while (rs.next()) {//一行一行输出
                for (int i = 1; i <= col; i++) {
                    System.out.print(rs.getString(i) + "\t");//输出
                    if ((i == 2) && (rs.getString(i).length() < 8)) {//输出制表符
                        System.out.print("\t");
                    }
                }
                System.out.println("");
            }
            System.out.println("============================");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}


