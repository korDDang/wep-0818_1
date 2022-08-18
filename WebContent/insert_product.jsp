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
	if(doc.productCode.value==""){
		alert("상품코드가 입력되지 않았습니다.");
		doc.productCode.focus();
		return false;
	}if(doc.productName.value==""){
		alert("상품명이 입력되지 않았습니다.");
		doc.productName.focus();
		return false;
	}if(doc.storeCode.value==""){
		alert("매장코드가 입력되지 않았습니다.");
		doc.storeCode.focus();
		return false;
	}else{
		form.action="insert_productProcess.jsp";
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
int ma=0;
try{
	String sql="select max(productCode) from product08182";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	if(rs.next()){
		ma=rs.getInt(1)+1;
	}
}catch(SQLException e){
	e.printStackTrace();
}

String productCode=request.getParameter("productCode");
if(productCode==null){
	productCode="";
}
String productName=request.getParameter("productName");
if(productName==null){
	productName="";
}

String unitPrice=request.getParameter("unitPrice");
if(unitPrice==null){
	unitPrice="";
}
String stockQty=request.getParameter("stockQty");
if(stockQty==null){
	stockQty="";
}
String storeName="";




String storeCode=request.getParameter("storeCode");
if(storeCode==null){
	storeCode="";
}else{
	try{
		String sql="select storeName from store08182 where storeCode=? ";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, storeCode);
		rs=pstmt.executeQuery();
		if(rs.next()){
			storeName=rs.getString(1);
		}else{
			%>
			<script>
			alert("등록되지 않은 매장코드 입니다.");
			</script>
			
			<%
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
}
%>
<h2>상품 등록 화면</h2>
<hr>
<form name="form" method="post" action="insert_product.jsp">
<table border="1" class="tab2">
<tr>
	<th class="th1">상품코드(자동생성)</th>
		<td>
			<input type="text" name="productCode" value="<%=ma%>">(마지막번호 +1)
		</td>
</tr>

<tr>
	<th class="th1">상 품 명</th>
		<td>
			<input type="text" name="productName" value="<%=productName%>">
		</td>
</tr>

<tr>
	<th class="th1">매장코드</th>
		<td>
			<input type="text" name="storeCode" onchange="ch()" value="<%=storeCode%>"> 
		</td>
</tr>

<tr>
	<th class="th1">매 장 명</th>
		<td>
			<input type="text" name="storeName" value="<%=storeName%>">
		</td>
</tr>


<tr>
	<th class="th1">단가</th>
		<td>
			<input type="text" name="unitPrice" value="<%=unitPrice%>">
		</td>
</tr>

<tr>
	<th class="th1">재고수량</th>
		<td>
			<input type="text" name="stockQty" value="<%=stockQty%>">
		</td>
</tr>


<tr>
	<td colspan="2" class="td1">
		<input type="button" value="등록" onclick="check()" class="bt1">
		<input type="button" value="취소" onclick="location.href='index.jsp'" class="bt1">
	</td>
</tr>
</table>
</form>
<hr>
</section>
<%@include file="footer.jsp" %>
</body>
</html>