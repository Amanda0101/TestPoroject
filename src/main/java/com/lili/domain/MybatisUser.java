package com.lili.domain;

import java.io.Serializable;

/**
 * @author yanbingHuang
 * @create 2021-01-2021/1/9 4:01 下午
 **/
public class MybatisUser implements Serializable {
    private Integer id;
    private String user;
    private String name;
    private String age;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "MybatisUser{" +
                "id=" + id +
                ", user='" + user + '\'' +
                ", name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}
