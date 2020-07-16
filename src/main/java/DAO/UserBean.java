package DAO;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/1 5:30 下午
 * 作用相当于把mysql table中的每个column的name都拿出来，打包成一个class方便后续调用。
 **/
public class UserBean {
    private int id ;
    private String name ;
    private int age;
    private String birthday;
    private int money;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
        this.money = money;
    }
}
