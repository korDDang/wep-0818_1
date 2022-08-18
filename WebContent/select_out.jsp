<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="header.jsp" %>
<%@include file="nav.jsp" %>
<%@include file="DBConn.jsp" %>
<section class="sec1">
<br>
<h2>출고 정보(금액)목록</h2>
<%
DecimalFormat fo=new DecimalFormat("###,###");

%>
<hr>
<table border="1" class="tab2">
<tr>
	<th class="th1">no</th>
	<th class="th1">입.출고<br>일자</th>
	<th class="th1">매장코드</th>
	<th class="th1">매 장 명</th>
	<th class="th1">상품코드</th>
	<th class="th1">상 품 명</th>
	<th class="th1">출고수량</th>
	<th class="th1">단가</th>
	<th class="th1">출고금액</th>
	<th class="th1">할인된금<br>액(10%)</th>
</tr>
<%
int no=0;
int total=0;
double total1=0;
try{
	String sql="select to_char(i.inOutDate,'YYYY-MM-DD'),i.storeCode,s.storeName,i.productCode,p.productName,i.saleQty,p.unitPrice from product08182 p,store08182 s,inOut0818 i where i.productCode=p.productCode and i.storeCode=s.storeCode and gubun=2 order by i.inOutDate asc,s.storeCode asc";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	while(rs.next()){
		String inOutDate=rs.getString(1);
		String storeCode=rs.getString(2);
		String storeName=rs.getString(3);
		String productCode=rs.getString(4);
		String productName=rs.getString(5);
		int saleQty=rs.getInt(6);
		int unitPrice=rs.getInt(7);
		total=saleQty*unitPrice;
		double saleQty1=rs.getDouble(6);
		double unitPrice1=rs.getDouble(7);
		
		if(saleQty>4){
		total1=(saleQty1*unitPrice1)*0.9;
		}else{
			total1=saleQty1*unitPrice1;
		}
		no++;
%>
<tr>
	<td class="td1"><%=no %></td>
	<td class="td1"><%=inOutDate %></td>
	<td class="td1"><%=storeCode%></td>
	<td class="td1"><%=storeName%></td>
	<td class="td1"><%=productCode%></td>
	<td class="td1"><%=productName %></td>
	<td class="td1"><%=fo.format(saleQty)%></td>
	<td class="td1"><%=fo.format(unitPrice)%></td>
	<td class="td1"><%=fo.format(total)%></td>
	<td class="td1"><%=fo.format(total1)%></td>
</tr>
<%
	}
	}catch(Exception e){
		e.printStackTrace();
		System.out.println("조회 실패");
	}
%>
</table>
<br>
<div class="td1"><input type="button" value="입출고 정보 추가" onclick="location.href='insert_inOut.jsp'" class="bt3"></div>
</section>
<%@include file="footer.jsp" %>
</body>
</html>