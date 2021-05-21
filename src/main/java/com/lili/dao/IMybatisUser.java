package com.lili.dao;

import com.lili.domain.MybatisUser;

import java.util.List;

/**
 * @author yanbingHuang
 * @create 2021-01-2021/1/9 4:04 下午
 **/
public interface IMybatisUser {
      List<MybatisUser> getall();
      int  saveUser(MybatisUser mybatisUser);
      int  delUser(int id);

}
