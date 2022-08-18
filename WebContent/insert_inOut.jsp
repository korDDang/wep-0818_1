<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function ch(){
	var doc=document.form;
	doc.submit();
}
function check() {
	var doc=document.form;
	if(doc.storeCode.value==""){
		alert("매장코드가 입력되지 않았습니다.");
		doc.storeCode.focus();
		return false;
	}if(doc.storeName.value==""){
		alert("매장명이 입력되지 않았습니다.");
		doc.storeName.focus();
		return false;
	}if(doc.productCode.value==""){
		alert("상품코드가 입력되지 않았습니다.");
		doc.productCode.focus();
		return false;
	}else{
		form.action="insert_inOutProcess.jsp";
		doc.submit();
		
	}
}
</script>
</head>
<body>
<%@include file="header.jsp" %>
<%@include file="nav.jsp" %>
<%@include file="DBConn.jsp" %>
<section class="sec1">
<%
String storeName="";
String productName="";
int qty=0;
int total=0;

String saleQty=request.getParameter("saleQty");
if(saleQty==null){
	saleQty="0";
}else{
	qty=Integer.parseInt(saleQty);
}
String inOutDate=request.getParameter("inOutDate");
if(inOutDate==null){
	inOutDate="";
}


String storeCode=request.getParameter("storeCode");
if(storeCode==null){
	storeCode="";}

String productCode=request.getParameter("productCode");
if(productCode==null){
	productCode="";
}else{
	try{
		String sql="select productName from product08182 where productCode=? and storeCode=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, productCode);
		pstmt.setString(2, storeCode);
		rs=pstmt.executeQuery();
		if(rs.next()){
			productName=rs.getString(1);
		}
		
	}catch(SQLException e){
		e.printStackTrace();
	}
}
try{
	String sql="select storeName from store08182 where productCode=? and storeCode=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, productCode);
	pstmt.setString(2, storeCode);
	rs=pstmt.executeQuery();
	if(rs.next()){
		storeName=rs.getString(1);
	}
	
}catch(SQLException e){
	e.printStackTrace();
}

%>
<h2>입출고 정보 등록</h2>
<form name="form" method="post" action="insert_inOut.jsp">
<table border="1" class="tab2">
<tr>
	<th class="th1">입출고일자</th>
		<td colspan="3">
			<input type="text" name="inOutDate" value="<%=inOutDate%>">
		</td>
</tr>


<tr>
	<th class="th1">매장코드</th>
		<td>
			<input type="text" name="storeCode"  value="<%=storeCode%>"> 
		</td>
	<th class="th1">매 장 명</th>
		<td>
			<input type="text" name="storeName" value="<%=storeName%>">
		</td>
</tr>

<tr>
	<th class="th1">상품코드</th>
		<td>
			<input type="text" name="productCode" onchange="ch()" value="<%=productCode%>"> 
		</td>
		<th class="th1">상 품 명</th>
		<td>
			<input type="text" name="productName" value="<%=productName%>">
		</td>
</tr>



<tr>
	<th class="th1">일출고 구분</th>
		<td colspan="3">
			<input type="radio" name="gubun" value="1">입고
			<input type="radio" name="gubun" value="2">출고
		</td>
</tr>
<tr>
	<th class="th1">입출고 수량</th>
		<td>
			<input type="text" name="saleQty" value="<%=saleQty%>"> 
		</td>
		<th class="th1">입출고 금액</th>
		<td>
			<input type="text" name="total" value="<%=total%>">
		</td>
</tr>


<tr>
	<td colspan="4" class="td1">
		<input type="button" value="목록" onclick="location.href='select_inOut.jsp'" class="bt3">
		<input type="button" value="저장" onclick="check()" class="bt3">
	</td>
</tr>
</table>
</form>
<hr>
</section>
<%@include file="footer.jsp" %>
</body>
</html>