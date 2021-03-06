package Util;
 import org.apache.commons.lang3.StringUtils;
 import java.util.Date;
/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/6 11:04 上午
 * mysql数据类型处理工具类
 **/
public class DataTypeUtil {
    public static String getType(String dataType){
        String type="";
        if("tinyint".equals(StringUtils.substringBefore(dataType, "("))){
            type="Byte";
        }
        if("smallint".equals(StringUtils.substringBefore(dataType, "("))){
            type="Short";
        }
        if("mediumint".equals(StringUtils.substringBefore(dataType, "("))){
            type="Integer";
        }
        if("int".equals(StringUtils.substringBefore(dataType, "("))){
            type="Integer";
        }
        if("integer".equals(StringUtils.substringBefore(dataType, "("))){
            type="Integer";
        }
        if("bigint".equals(StringUtils.substringBefore(dataType, "("))){
            type="Long";
        }
        if("bit".equals(StringUtils.substringBefore(dataType, "("))){
            type="Boolean";
        }
        if("double".equals(StringUtils.substringBefore(dataType, "("))){
            type="Double";
        }
        if("float".equals(StringUtils.substringBefore(dataType, "("))){
            type="Float";
        }
        if("decimal".equals(StringUtils.substringBefore(dataType, "("))){
            type="Long";
        }
        if("char".equals(StringUtils.substringBefore(dataType, "("))){
            type="String";
        }
        if("varchar".equals(StringUtils.substringBefore(dataType, "("))){
            type="String";
        }
        if("date".equals(StringUtils.substringBefore(dataType, "("))){
            type="Date";
        }
        if("time".equals(StringUtils.substringBefore(dataType, "("))){
            type="Date";
        }
        if("year".equals(StringUtils.substringBefore(dataType, "("))){
            type="Date";
        }
        if("timestamp".equals(StringUtils.substringBefore(dataType, "("))){
            type="Timestamp";
        }
        if("datetime".equals(StringUtils.substringBefore(dataType, "("))){
            type="Timestamp";
        }
        if("tinytext".equals(StringUtils.substringBefore(dataType, "("))){
            type="String";
        }
        if("enum".equals(StringUtils.substringBefore(dataType, "("))){
            type="String";
        }
        if("set".equals(StringUtils.substringBefore(dataType, "("))){
            type="String";
        }
        if("text".equals(StringUtils.substringBefore(dataType, "("))){
            type="String";
        }
        if("mediumtext".equals(StringUtils.substringBefore(dataType, "("))){
            type="String";
        }
        if("longtext".equals(StringUtils.substringBefore(dataType, "("))){
            type="String";
        }
        return type;
    }
}
