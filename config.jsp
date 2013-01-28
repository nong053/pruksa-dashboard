<%@page import="java.sql.*"%>
<%@page import="connectionPackage.*"%>
<%@ page language="java" import="net.sf.json.JSONArray" %>
<%
	ConnectionDb mysqlConn = new ConnectionDb();
/*
	mysqlConn.setDriver("oracle.jdbc.driver.OracleDriver");
	mysqlConn.setUrl("jdbc:oracle:thin:@172.18.88.205:1525:prod");
	mysqlConn.setUser("apps");
	mysqlConn.setPass("apps");
*/
	mysqlConn.setDriver("com.mysql.jdbc.Driver");
	mysqlConn.setUrl("jdbc:mysql://localhost:3306/pruksa_dwh");
	mysqlConn.setUser("root");
	mysqlConn.setPass("root");
	
    Connection conn;
    ResultSet rs=null;
    conn=mysqlConn.testConnect();
    
    if(!conn.isClosed()){
    	//out.print("ok connect database is sucessfully");
   /*
    	String query="select * from kpi_result LIMIT 5";
    	rs=mysqlConn.selectData(query);
    	while(rs.next()){
    		System.out.println(""+rs.getString(1));
    		
    	}
    */	
    }
    
%>