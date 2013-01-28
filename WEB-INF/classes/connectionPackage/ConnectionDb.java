package connectionPackage;
import java.sql.*;

public class ConnectionDb {
		String driver="";
		String url="";
		String query="";
		String user="";
		String pass="";
		ResultSet rs=null;
		Connection conn=null;
		Statement st=null;
		
	public Connection testConnect(){
		try{
		Class.forName(getDriver());
		conn = DriverManager.getConnection(getUrl(),getUser(),getPass());
		
		return conn;
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
		
	}
	public ResultSet selectData(String query){
		try{
		Class.forName(getDriver());
		conn = DriverManager.getConnection(getUrl(),getUser(),getPass());
		st = conn.createStatement();
		rs=st.executeQuery(query);
		//conn.close();
		return rs;
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return rs;
	}
	public void setUser(String argUser){
		user=argUser;
	}
	public String getUser(){
		return user;
	}
	public void setPass(String argPass){
		pass=argPass;
	}
	public String getPass(){
		return pass;
	}
	public void setDriver(String argDriver){
		driver=argDriver;
	}
	public String getDriver(){
		return driver;
	}
	public void setUrl(String argUrl){
		url=argUrl;
	}
	public String getUrl(){
		return url;
	}
	
	
}
