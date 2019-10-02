<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.*, org.w3c.dom.*" %>
<!DOCTYPE html>
<html>
	<head>	
	</head>
	<body>
		<h1>성적 조회</h1>
		<%
			//파싱을 위한 준비과정
			DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		
			//파일을 읽을때 서버내부 local path(전체 경로)로 지정 ..이 문장이 xml파싱을 한다.
			Document doc = docBuilder.parse(new File("C:/Users/user/eclipse-workspace/190809xml/WebContent/testdata.xml"));
			
			Element root = doc.getDocumentElement(); //root태그를 가져오기도 하지만 이 소스는 쓰이는 곳이 없다. 
			NodeList tag_name = doc.getElementsByTagName("name");
			NodeList tag_studentid = doc.getElementsByTagName("studentid");
			NodeList tag_kor = doc.getElementsByTagName("kor");
			NodeList tag_eng = doc.getElementsByTagName("eng");
			NodeList tag_mat = doc.getElementsByTagName("mat");
			
			out.println("<table cellspacing=1 width=500 border=1>");
			out.println("<tr>");
			out.println("<td width=100>이름</td>");
			out.println("<td width=100>학번</td>");
			out.println("<td width=100>국어</td>");
			out.println("<td width=100>영어</td>");
			out.println("<td width=100>수학</td>");
			out.println("</tr>");
			
			for(int i=0; i<tag_name.getLength(); i++){
				out.println("<td width=100>"+tag_name.item(i).getFirstChild().getNodeValue()+"</td>");
				out.println("<td width=100>"+tag_studentid.item(i).getFirstChild().getNodeValue()+"</td>");
				out.println("<td width=100>"+tag_kor.item(i).getFirstChild().getNodeValue()+"</td>");
				out.println("<td width=100>"+tag_eng.item(i).getFirstChild().getNodeValue()+"</td>");
				out.println("<td width=100>"+tag_mat.item(i).getFirstChild().getNodeValue()+"</td>");
				out.println("</tr>");
			}
		%>	
	</body>
</html>

