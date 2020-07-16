package main.java.BEAN1;

import java.sql.Timestamp;

import java.sql.Timestamp;

public class StructrualDictionaryMappingBean{

	private	Integer	uuid;
	private	String	definitionType;
	private	String	definitionName;
	private	String	structrualDictionaryName;
	private	String	targetDictionaryName;
	private	Timestamp	createTs;
	private	String	createUser;
	private	Timestamp	lastModTs;
	private	String	lastModUser;
	public	Integer	getUuid(){
		return	uuid;
	}
	public	String	getDefinitionType(){
		return	definitionType;
	}
	public	String	getDefinitionName(){
		return	definitionName;
	}
	public	String	getStructrualDictionaryName(){
		return	structrualDictionaryName;
	}
	public	String	getTargetDictionaryName(){
		return	targetDictionaryName;
	}
	public	Timestamp	getCreateTs(){
		return	createTs;
	}
	public	String	getCreateUser(){
		return	createUser;
	}
	public	Timestamp	getLastModTs(){
		return	lastModTs;
	}
	public	String	getLastModUser(){
		return	lastModUser;
	}
	public void	setUuid(Integer uuid){
		this.uuid = uuid;
	}
	public void	setDefinitionType(String definitionType){
		this.definitionType = definitionType;
	}
	public void	setDefinitionName(String definitionName){
		this.definitionName = definitionName;
	}
	public void	setStructrualDictionaryName(String structrualDictionaryName){
		this.structrualDictionaryName = structrualDictionaryName;
	}
	public void	setTargetDictionaryName(String targetDictionaryName){
		this.targetDictionaryName = targetDictionaryName;
	}
	public void	setCreateTs(Timestamp createTs){
		this.createTs = createTs;
	}
	public void	setCreateUser(String createUser){
		this.createUser = createUser;
	}
	public void	setLastModTs(Timestamp lastModTs){
		this.lastModTs = lastModTs;
	}
	public void	setLastModUser(String lastModUser){
		this.lastModUser = lastModUser;
	}
	public	StructrualDictionaryMappingBean(){
		super();
	}
	public StructrualDictionaryMappingBean(Integer uuid,String definitionType,String definitionName,String structrualDictionaryName,String targetDictionaryName,Timestamp createTs,String createUser,Timestamp lastModTs,String lastModUser){
		super();
		this.uuid = uuid;
		this.definitionType = definitionType;
		this.definitionName = definitionName;
		this.structrualDictionaryName = structrualDictionaryName;
		this.targetDictionaryName = targetDictionaryName;
		this.createTs = createTs;
		this.createUser = createUser;
		this.lastModTs = lastModTs;
		this.lastModUser = lastModUser;
	}
}