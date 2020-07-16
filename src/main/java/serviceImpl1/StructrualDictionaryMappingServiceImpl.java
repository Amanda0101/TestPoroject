package main.java.serviceImpl1;

import main.java.DAO1.StructrualDictionaryMappingService;

import main.java.BEAN1.StructrualDictionaryMappingBean;

import DAO.StructrualDictionaryMappingDao;

import java.util.List;

public class StructrualDictionaryMappingServiceImpl	 implements StructrualDictionaryMappingService{

	private StructrualDictionaryMappingDao	StructrualDictionaryMappingDao;

	public StructrualDictionaryMappingDao getStructrualDictionaryMappingDao(){
		return	StructrualDictionaryMappingDao;
	}

	public StructrualDictionaryMappingDao setStructrualDictionaryMappingDao(StructrualDictionaryMappingDao StructrualDictionaryMappingDao){
		return this.StructrualDictionaryMappingDao=StructrualDictionaryMappingDao;
	}

	//添加一条完整记录
	public int insertRecord(StructrualDictionaryMappingBean record){
		return	StructrualDictionaryMappingDao.insertRecord(record);
	}

	//添加指定列的数据
	public int insertSelective(StructrualDictionaryMappingBean record){
		return	StructrualDictionaryMappingDao.insertSelective(record);
	}

	//通过Id(主键)删除一条记录
	public int deleteById(Integer uuid){
		return	StructrualDictionaryMappingDao.deleteById(uuid);
	}

	//按Id(主键)修改指定列的值
	public int updateByIdSelective(StructrualDictionaryMappingBean record){
		return	StructrualDictionaryMappingDao.updateByIdSelective(record);
	}

	//按Id(主键)修改指定列的值
	public int updateById(StructrualDictionaryMappingBean record){
		return	StructrualDictionaryMappingDao.updateById(record);
	}

	//计算表中的总记录数
	public int countRecord(){
		return	StructrualDictionaryMappingDao.countRecord();
	}

	//根据条件计算记录条数
	public int countSelective(StructrualDictionaryMappingBean record){
		return	StructrualDictionaryMappingDao.countSelective(record);
	}

	//获得表中的最大Id
	public int maxId(){
		return	StructrualDictionaryMappingDao.maxId();
	}

	//通过Id(主键)查询一条记录
	public	StructrualDictionaryMappingBean	selectById(Integer	uuid){
		return	StructrualDictionaryMappingDao.selectById(uuid);
	}

	//查询所有记录
	public List selectAll(){
		return	StructrualDictionaryMappingDao.selectAll();
	}


}