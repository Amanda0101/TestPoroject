import com.lili.dao.IMybatisUser;
import com.lili.domain.MybatisUser;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.testng.annotations.Test;

import java.io.InputStream;
import java.util.List;

/**
 * @author yanbingHuang
 * @create 2021-01-2021/1/9 4:51 下午
 **/
public class mybatisTest {
    @Test
    public void test01() throws Exception{
//        获取sql基本配置文件
        InputStream inputStream= Resources.getResourceAsStream("sqlmapconfig.xml");
        SqlSessionFactoryBuilder sqlBuilder=new SqlSessionFactoryBuilder();
        SqlSessionFactory sqlfactory=sqlBuilder.build(inputStream);
        SqlSession sqlSession=sqlfactory.openSession();
        IMybatisUser iMybatisUser=sqlSession.getMapper(IMybatisUser.class);

        List<MybatisUser> users=iMybatisUser.getall();
        for(MybatisUser user:users){
            System.out.println("the user is:"+user);
        }
        sqlSession.close();
        inputStream.close();
    }


    @Test
    public void test02() throws Exception{
//        获取sql基本配置文件
        InputStream inputStream= Resources.getResourceAsStream("sqlmapconfig.xml");
        SqlSessionFactory sqlfactory=sqlBuilder.build(inputStream);
        SqlSession sqlSession=sqlfactory.openSession();
        IMybatisUser iMybatisUser=sqlSession.getMapper(IMybatisUser.class);
        MybatisUser mybatisUser=new MybatisUser();
        mybatisUser.setAge("20");
        mybatisUser.setName("aha");
        mybatisUser.setUser("admin");

       iMybatisUser.saveUser( mybatisUser);
        sqlSession.commit();
        sqlSession.close();
        inputStream.close();
    }
}
