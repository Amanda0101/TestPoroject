package main.java.serviceImpl1;

import main.java.DAO1.StructrualDefinitionMappingService;

import main.java.BEAN1.StructrualDefinitionMappingBean;

import DAO.StructrualDefinitionMappingDao;

import java.util.List;

public class StructrualDefinitionMappingServiceImpl	 implements StructrualDefinitionMappingService{

	private StructrualDefinitionMappingDao	StructrualDefinitionMappingDao;

	public StructrualDefinitionMappingDao getStructrualDefinitionMappingDao(){
		return	StructrualDefinitionMappingDao;
	}

	public StructrualDefinitionMappingDao setStructrualDefinitionMappingDao(StructrualDefinitionMappingDao StructrualDefinitionMappingDao){
		return this.StructrualDefinitionMappingDao=StructrualDefinitionMappingDao;
	}

	//添加一条完整记录
	public int insertRecord(StructrualDefinitionMappingBean record){
		return	StructrualDefinitionMappingDao.insertRecord(record);
	}

	//添加指定列的数据
	public int insertSelective(StructrualDefinitionMappingBean record){
		return	StructrualDefinitionMappingDao.insertSelective(record);
	}

	//通过Id(主键)删除一条记录
	public int deleteById(Integer uuid){
		return	StructrualDefinitionMappingDao.deleteById(uuid);
	}

	//按Id(主键)修改指定列的值
	public int updateByIdSelective(StructrualDefinitionMappingBean record){
		return	StructrualDefinitionMappingDao.updateByIdSelective(record);
	}

	//按Id(主键)修改指定列的值
	public int updateById(StructrualDefinitionMappingBean record){
		return	StructrualDefinitionMappingDao.updateById(record);
	}

	//计算表中的总记录数
	public int countRecord(){
		return	StructrualDefinitionMappingDao.countRecord();
	}

	//根据条件计算记录条数
	public int countSelective(StructrualDefinitionMappingBean record){
		return	StructrualDefinitionMappingDao.countSelective(record);
	}

	//获得表中的最大Id
	public int maxId(){
		return	StructrualDefinitionMappingDao.maxId();
	}

	//通过Id(主键)查询一条记录
	public	StructrualDefinitionMappingBean	selectById(Integer	uuid){
		return	StructrualDefinitionMappingDao.selectById(uuid);
	}

	//查询所有记录
	public List selectAll(){
		return	StructrualDefinitionMappingDao.selectAll();
	}


}