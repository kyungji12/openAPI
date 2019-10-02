<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.*, org.w3c.dom.*" %>
<!DOCTYPE html>
<html>
	<head>	
	</head>
	<body>
		<h1>광주광역시 무료 와이파이</h1>
		<%
			//파싱을 위한 준비과정
			DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		
			//파일을 읽을때 서버내부 local path(전체 경로)로 지정 ..이 문장이 xml파싱을 한다.
			Document doc = docBuilder.parse(new File("C:/Users/user/eclipse-workspace/190809xml/WebContent/gwangju_freewifi.xml"));
			
			Element root = doc.getDocumentElement(); //root태그를 가져오기도 하지만 이 소스는 쓰이는 곳이 없다. 
			NodeList tag_name = doc.getElementsByTagName("설치장소명");
			NodeList tag_address = doc.getElementsByTagName("소재지지번주소");
			NodeList tag_lat = doc.getElementsByTagName("위도");
			NodeList tag_long = doc.getElementsByTagName("경도");
			
			
			out.println("<table cellspacing=1 width=500 border=1>");
			out.println("<tr>");
			out.println("<td width=200>설치장소명</td>");
			out.println("<td width=450>소재지지번주소</td>");
			out.println("<td width=100>위도</td>");
			out.println("<td width=100>경도</td>");
			out.println("</tr>");
			
			for(int i=0; i<tag_name.getLength(); i++){
				out.println("<td width=200>"+tag_name.item(i).getFirstChild().getNodeValue()+"</td>");
				out.println("<td width=450>"+tag_address.item(i).getFirstChild().getNodeValue()+"</td>");
				out.println("<td width=100>"+tag_lat.item(i).getFirstChild().getNodeValue()+"</td>");
				out.println("<td width=100>"+tag_long.item(i).getFirstChild().getNodeValue()+"</td>");
				out.println("</tr>");
			}
		%>	
	</body>
</html>

