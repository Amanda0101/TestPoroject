package daoImpl;


import BEAN.ColumnStruct;
import BEAN.TableStruct;
import DAO.GetTablesDao;
import Util.DataSourceUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/2 8:16 下午
 * refer:https://www.cnblogs.com/hwf2029/p/7810766.html
 **/
public class GetTablesDaoImpl extends DataSourceUtil implements GetTablesDao {
    //获得数据库的所有数据库的名字

//    public List getDatabasesName() {
//        List dataDBs = new ArrayList();
////        获取当前ip下所有的database名字
//        String sql = "show databases";
//        ResultSet rs = this.query(sql);
//        try {
//            while (rs.next()) {
////将获得的所有表名装进List
//                dataDBs.add(rs.getString(1));
//            }
//        } catch (SQLException e) {
////
//            e.printStackTrace();
//        }
//        return dataDBs;
//    }


    //获得数据库的所有表名
    @Override
    public List getTablesName() {
        List tables = new ArrayList();
        String sql = "show tables";
        ResultSet rs = this.query(sql);
        try {
            while (rs.next()) {
//将获得的所有表名装进List
                tables.add(rs.getString(1));
            }
        } catch (SQLException e) {
// TODO Auto-generated catch block
            e.printStackTrace();
        }
        return tables;
    }

    //探索如何添加上database的名字
// @Override
//    public List<String> getTablesName_new() {
//        List tables = new ArrayList();
//        String sql = "show tables";
//        ResultSet rs = this.query(sql);
//        try {
//            while (rs.next()) {
////将获得的所有表名装进List
//                tables.add(rs.getString(1));
//            }
//        } catch (SQLException e) {
///
//            e.printStackTrace();
//        }
//        return tables;
//    }




    //获得数据表中的字段名称、字段类型
    @Override
    public List getTablesStruct() {
        //获得装有所有表名的List
        List tables = this.getTablesName();
        String sqls = null;
        //装所有的表结构（表名+字段名称+字段类型）
        List tablesStruct = new ArrayList();
        for (int i = 0; i < tables.size(); i++) {
            sqls = "show columns from " + tables.get(i).toString();
            ResultSet rs = this.query(sqls);
            //装所有的列结构(字段名称+字段类型)
            List list = new ArrayList();
            try {
                while (rs.next()) {
                    ColumnStruct cs = new ColumnStruct(rs.getString(1), rs.getString(2));
            //找到一列装进List
                    list.add(cs);
                }
            } catch (SQLException e) {
//        TODO Auto-generated catch block
                e.printStackTrace();
            }
//遍历完一张表，封装成对象
            TableStruct ts = new TableStruct(tables.get(i).toString(), list);
//将对象（一张表）装进集合
            tablesStruct.add(ts);
        }
        return tablesStruct;
    }


}
