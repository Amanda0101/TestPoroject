package BEAN;

import java.sql.Timestamp;

public class StructrualDefinitionMappingBean{

	private	Integer	uuid;
	private	String	definitionType;
	private	String	structrualDefinitionName;
	private	String	targetDefinitionName;
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
	public	String	getStructrualDefinitionName(){
		return	structrualDefinitionName;
	}
	public	String	getTargetDefinitionName(){
		return	targetDefinitionName;
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
	public void	setStructrualDefinitionName(String structrualDefinitionName){
		this.structrualDefinitionName = structrualDefinitionName;
	}
	public void	setTargetDefinitionName(String targetDefinitionName){
		this.targetDefinitionName = targetDefinitionName;
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
	public	StructrualDefinitionMappingBean(){
		super();
	}
	public StructrualDefinitionMappingBean(Integer uuid,String definitionType,String structrualDefinitionName,String targetDefinitionName,Timestamp createTs,String createUser,Timestamp lastModTs,String lastModUser){
		super();
		this.uuid = uuid;
		this.definitionType = definitionType;
		this.structrualDefinitionName = structrualDefinitionName;
		this.targetDefinitionName = targetDefinitionName;
		this.createTs = createTs;
		this.createUser = createUser;
		this.lastModTs = lastModTs;
		this.lastModUser = lastModUser;
	}
}