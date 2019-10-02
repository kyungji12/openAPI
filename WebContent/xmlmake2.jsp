<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>

<%
	//DB연결
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo14","root","ykj0112");
	Statement stmt = conn.createStatement();

	ResultSet rset = stmt.executeQuery("select *from examtable");
	out.println("<datas>");
	while(rset.next()){
		out.println("<data>");
		out.println("<name>"+rset.getString(1)+"</name>");
		out.println("<studentid>"+Integer.toString(rset.getInt(2))+"</studentid>");
		out.println("<kor>"+rset.getString(3)+"</kor>");
		out.println("<eng>"+rset.getString(4)+"</eng>");
		out.println("<mat>"+rset.getString(5)+"</mat>");
		out.println("</data>");
	}
	out.println("</datas>");
	stmt.close();
	conn.close();
%>
