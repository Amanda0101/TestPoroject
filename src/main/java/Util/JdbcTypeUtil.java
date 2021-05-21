package Util;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/6 11:10 上午
 * mybatis的JdbcType处理工具类
 **/
public class JdbcTypeUtil {
    public static String getJdbcType(String dataType) {
        String type = "";
        if ("String".equals(dataType)) {
            type = "VARCHAR";
        }
        if ("BigDecimal".equals(dataType)) {
            type = "NUMERIC";
        }
        if ("boolean".equals(dataType)) {
            type = "BOOLEAN";
        }
        if ("byte".equals(dataType)) {
            type = "TINYINT";
        }
        if ("short".equals(dataType)) {
            type = "SMALLINT";
        }
        if ("int".equals(dataType)) {
            type = "INTEGER";
        }
        if ("Integer".equals(dataType)) {
            type = "INTEGER";
        }
        if ("long".equals(dataType)) {
            type = "BIGINT";
        }
        if ("float".equals(dataType)) {
            type = "DOUBLE";
        }
        if ("double".equals(dataType)) {
            type = "DOUBLE";
        }
        if ("Date".equals(dataType)) {
            type = "DATE";
        }
        if ("Time".equals(dataType)) {
            type = "TIME";
        }
        if ("Timestamp".equals(dataType)) {
            type = "TIMESTAMP";
        }
        return type;
    }

}
