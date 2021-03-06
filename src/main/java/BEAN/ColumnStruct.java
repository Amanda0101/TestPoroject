package BEAN;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/2 8:13 下午
 * 数据表的列结构
 **/
public class ColumnStruct {
    private String columnName;//字段名称
    private String dataType;//字段类型
    public String getColumnName() {
        return columnName;
    }
    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }
    public String getDataType() {
        return dataType;
    }
    public void setDataType(String dataType) {
        this.dataType = dataType;
    }
    public ColumnStruct(String columnName, String dataType) {
        super();
        this.columnName = columnName;
        this.dataType = dataType;
    }
    public ColumnStruct() {
        super();
    }
    @Override
    public String toString() {
        return "ColumnStruct [columnName=" + columnName + ", dataType="
                + dataType + "]";
    }
}
