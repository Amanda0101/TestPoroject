package BEAN;

import java.util.List;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/2 8:12 下午
 * 数据表的表结构
 **/
public class TableStruct {
    private String tableName;//表名
    private List Columns;//所有的列
    public String getTableName() {
        return tableName;
    }
    public void setTableName(String tableName) {
        this.tableName = tableName;
    }
    public List getColumns() {
        return Columns;
    }
    public void setColumns(List columns) {
        Columns = columns;
    }
    public TableStruct(String tableName, List columns) {
        super();
        this.tableName = tableName;
        Columns = columns;
    }
    public TableStruct() {
        super();
    }
    @Override
    public String toString() {
        return "TableStruct [tableName=" + tableName + ", Columns=" + Columns
                + "]";
    }
}
