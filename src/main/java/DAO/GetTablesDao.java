package DAO;

import java.util.List;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/2 8:14 下午
 * 获取数据表及其结构的dao层接口
 **/
public interface GetTablesDao {
    //获得数据库的所有表名
    public List getTablesName();

    //获得数据表中的字段名称、字段类型
    public List getTablesStruct();
}
