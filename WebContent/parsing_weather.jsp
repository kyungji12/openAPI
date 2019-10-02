<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.*, org.w3c.dom.*" %>
<html>
	<head>
	<title>기상청 동네예보</title>
	</head>
	<body>
		<h1>우리동네 날씨예보</h1>
		<%
			String url = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123";
			//파싱을 위한 준비과정
			DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			//파일을 읽을때 서버내부 local path(전체 경로)로 지정 ..이 문장이 xml파싱을 한다.
			Document doc = docBuilder.parse(url);
			
			String seq=""; 		//48시간중 몇번째 인지 가르킴 
			String hour="";  	//동네예보 3시간 단위 7/1번째날 (0 : 오늘/1: 내일/2: 모레) 
			String day=""; 		//1번째날 (0:오늘/1:내일/2:모레)
			String temp=""; 	// 현재 시간온도.
			String tmx=""; 		// 최고 온도
			String tmn=""; 		//최저 온도 
			String sky=""; 		//하늘 상태코드 (1: 맑음, 2: 구름조금, 3 : 구름많음, 4 : 흐림) 
			String pty=""; 		//강수 상태코드 (0: 없음, 1: 비, 2: 비/눈, 3: 눈/비, 4: 눈) 
			String wfKor=""; 	//날씨 한국어
			String wfEn="";  	//날씨 영어 
			String pop=""; 		//강수 확률 %
			String r12=""; 		//12시간 예상 강수량
			String s12=""; 		//12시간 예상 적설량
			String ws=""; 		// 풍속 (m/s) 
			String wd=""; 		// 풍향 (0~7:북, 북동, 동, 남동, 남, 남서, 서, 북서)
			String wdKor=""; 	// 풍향 한국어 
			String wdEn=""; 	// 풍향 영어 
			String reh=""; 		//습도 용
			String r06=""; 		//6시간 예상 강수량 
			String s06="";		//6시간 예상 적설량

			
			out.println("<table border=1>");
			out.println("<tr>");
			out.println("<td>순번</td>");
			out.println("<td>시간</td>");
// 			out.println("<td>day</td>");
			out.println("<td>현재 시간온도</td>");
			out.println("<td>최고 온도</td>");
			out.println("<td>최저 온도</td>");
			out.println("<td>하늘 상태코드</td>");
			out.println("<td>강수 상태코드</td>");
			out.println("<td>날씨 한국어</td>");
			out.println("<td>날씨 영어</td>");
			out.println("<td>강수 확률 %</td>");
			out.println("<td>12시간 예상 강수량</td>");
			out.println("<td>12시간 예상 적설량</td>");
			out.println("<td>풍속 (m/s) </td>");
			out.println("<td>풍향</td>");
			out.println("<td>풍향 한국어</td>");
			out.println("<td>풍향 영어</td>");
			out.println("<td>습도 용</td>");
			out.println("<td>6시간 예상 강수량</td>");
			out.println("<td>6시간 예상 적설량</td>");
			out.println("</tr>");
			
			Element root = doc.getDocumentElement(); //root태그를 가져오기도 하지만 이 소스는 쓰이는 곳이 없다. 
			NodeList tag_001 = doc.getElementsByTagName("data");//xml의 루트를 기준으로  data테그를 찾는다.	
			for (int i=0; i<tag_001.getLength(); i++){
				// data 테그가 여러 개 있는데 하나를 선택(item(i)) 하여 어트리뷰트가 seq를 찾고 그것의 값을 찾는다
				// data seq=“0”, data seq=“1”등을 보고 결국 0,1,2,3 값이 나온다. 

				seq = tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();
				//아래 hour테그는 전체 xml이 아니라 현재 data테그 하나를 기준으로 하위의  hour를 찾아 
			    //그놈의 노드값을 보여준다
				Element elmt=(Element)tag_001.item(i);
				
				hour = elmt.getElementsByTagName("hour").item (0).getFirstChild().getNodeValue();
				day = elmt.getElementsByTagName("day").item (0).getFirstChild().getNodeValue();
				temp = elmt.getElementsByTagName("temp").item (0).getFirstChild().getNodeValue();
				tmx = elmt.getElementsByTagName("tmx").item (0).getFirstChild().getNodeValue();
				tmn = elmt.getElementsByTagName("tmn").item (0).getFirstChild().getNodeValue();
				sky = elmt.getElementsByTagName("sky").item (0).getFirstChild().getNodeValue();
				if(sky.equals("1")){sky="맑음";}
	            else if(sky.equals("2")){sky="구름조금";} 
	            else if(sky.equals("3")){sky="구름많음";} 
	            else if(sky.equals("4")){sky="흐림";}  
				pty=elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
	            if(pty.equals("0")){pty="없음";}
	            else if(pty.equals("1")){pty="비";} 
	            else if(pty.equals("2")){pty="비/눈";} 
	            else if(pty.equals("3")){pty="눈/비";} 
	            else if(pty.equals("4")){pty="눈";} 
				wfKor = elmt.getElementsByTagName("wfKor").item (0).getFirstChild().getNodeValue();
				wfEn = elmt.getElementsByTagName("wfEn").item(0).getFirstChild().getNodeValue();
				pop = elmt.getElementsByTagName ("pop").item (0).getFirstChild().getNodeValue();
				r12 = elmt.getElementsByTagName ("r12").item (0).getFirstChild().getNodeValue();
				s12 = elmt.getElementsByTagName("s12").item (0).getFirstChild().getNodeValue();
				ws = elmt.getElementsByTagName("ws").item (0).getFirstChild().getNodeValue();
				wd = elmt.getElementsByTagName("wd").item (0).getFirstChild().getNodeValue(); 
				if(wd.equals("0")){wd="북";}
	            else if(wd.equals("1")){wd="북동";} 
	            else if(wd.equals("2")){wd="동";} 
	            else if(wd.equals("3")){wd="남동";} 
	            else if(wd.equals("4")){wd="남";} 
	            else if(wd.equals("5")){wd="남서";} 
	            else if(wd.equals("6")){wd="서";} 
	            else if(wd.equals("7")){wd="북서";} 
				wdKor=elmt.getElementsByTagName("wdKor").item (0).getFirstChild().getNodeValue();
				wdEn=elmt.getElementsByTagName("wdEn").item (0).getFirstChild().getNodeValue();
				reh=elmt.getElementsByTagName("reh").item (0).getFirstChild().getNodeValue();
				r06=elmt.getElementsByTagName("r06").item (0).getFirstChild().getNodeValue();
				s06=elmt.getElementsByTagName("s06").item (0).getFirstChild().getNodeValue();

				
				
				out.println("<tr>");
				out.println("<td>"+seq+"</td>");
				
				if(day.equals("0")){
					out.println("<td>오늘"+hour+"시</td>");
				}else if(day.equals("1")){
					out.println("<td>내일"+hour+"시</td>");
				}else if(day.equals("2")){
					out.println("<td>모레"+hour+"시</td>");
				}
				
// 				if(day.equals("0")){
// 					out.println("<td>오늘</td>");
// 				}else if(day.equals("1")){
// 					out.println("<td>내일</td>");
// 				}else if(day.equals("2")){
// 					out.println("<td>모레</td>");
// 				}
				
				out.println("<td>"+temp+"℃</td>");
				out.println("<td>"+tmx+"℃</td>");
				out.println("<td>"+tmn+"℃</td>");
				out.println("<td>"+sky+"</td>");
				out.println("<td>"+pty+"</td>");
				
				if(wfKor.equals("맑음")){
		            out.println("<td width=100><img src='image/sunny.png'></td>");
		         }
		         else if(wfKor.equals("구름 조금")){
		            out.println("<td width=100><img src='image/partlycloudy.png'></td>");
		            } 
		         else if(wfKor.equals("구름 많음")){
		            out.println("<td width=100><img src='image/mostlycloudy.png'></td>");
		            } 
		         else if(wfKor.equals("흐림")){
		            out.println("<td width=100><img src='image/cloudy.png'></td>");
		            } 
				
				out.println("<td>"+wfEn+"</td>");
				out.println("<td>"+pop+"%</td>");
				out.println("<td>"+r12+"</td>");
				out.println("<td>"+s12+"</td>");
				out.println("<td>"+ws.substring(0,3)+"m/s</td>");
				out.println("<td>"+wd+"</td>");
				out.println("<td>"+wdKor+"</td>");
				out.println("<td>"+wdEn+"</td>");
				out.println("<td>"+reh+"</td>");
				out.println("<td>"+r06+"</td>");
				out.println("<td>"+s06+"</td>");
				out.println("</tr>");

				
			}
			out.println("</table>");
		%>	
	</body>
</html>

