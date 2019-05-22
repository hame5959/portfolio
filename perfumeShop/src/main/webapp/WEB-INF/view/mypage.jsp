<%@page import="jenkim49.jumun.Jumun"%>
<%@page import="java.util.List"%>
<%@page import="jenkim49.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="member_login_check.jspf"/>

<%
	Member member = (Member)session.getAttribute("sMember");
	if(member==null){
		response.sendRedirect("1index");
		return;
	}
	request.setAttribute("member", member);
	System.err.println(member.getM_address());
	System.err.println("mypage");
%>

<%@include file="api/daumapi.jsp"%>
<!DOCTYPE html>
<html lang="zxx" class="no-js">
<head>

<script src="js/vendor/jquery-2.2.4.min.js"></script>
<script type="text/javascript">


$(function() {
	jumun_list();
});

function jumun_list() {
    $.ajax({
	url : "jumun_list_member",
	method : "GET",
	data : {},
	dataType : "json",
	success : function(textData) {
		var html = "";
		var jsonArray = textData;
		html += "<table class=\"table table-hover\">";
		html +=	"<thead>";
		html += "<th>번호</th>";
		html += "<th>주문명</th>";
		html +=	"<th>전체수량</th>";
		html +=	"<th>전체금액</th>";
		html +=	"<th>주문날짜</th>";
		html +=	"<th>회원아이디</th>";
		html +=	"</thead>";
		for (var i = 0; i < jsonArray.length; i++) {
			var jumunJsonObject = jsonArray[i];
			html += "<tr>";
			html += "<th>" + jumunJsonObject.j_no + "</td>";
			html += "<td><a data-name='"+jumunJsonObject.j_no+"' href='jd_list_jno?j_no="+jumunJsonObject.j_no+"'>" + jumunJsonObject.j_name + "</a></td>";
			html += "<td>" + jumunJsonObject.j_total_qty + "</td>";
			html += "<td>" + jumunJsonObject.j_total_price + "</td>";
			html += "<td>" + jumunJsonObject.j_date + "</td>";
			html += "<td>" + jumunJsonObject.m_id + "</td>";
			html += "</tr>";
		}
			html += "</table>";
			$('#list').html(html);
	}
});
}

function jumun_detail() {
	
}

</script>
<!-- Mobile Specific Meta -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Favicon-->
<link rel="shortcut icon" href="img/fav.png">
<!-- Author Meta -->
<meta name="author" content="CodePixar">
<!-- Meta Description -->
<meta name="description" content="">
<!-- Meta Keyword -->
<meta name="keywords" content="">
<!-- meta character set -->
<meta charset="UTF-8">
<!-- Site Title -->
<title>Shop</title>

<link
	href="https://fonts.googleapis.com/css?family=Poppins:100,200,400,300,500,600,700"
	rel="stylesheet">
<!--
            CSS
            ============================================= -->
<link rel="stylesheet" href="css/linearicons.css">
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/nice-select.css">
<link rel="stylesheet" href="css/ion.rangeSlider.css" />
<link rel="stylesheet" href="css/ion.rangeSlider.skinFlat.css" />
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">
</head>
<body>

	<!-- Start Header Area -->
	<jsp:include page="1include_common_header.jsp" />
	<!-- End Header Area -->

	<!-- Start Banner Area -->
	<section class="banner-area organic-breadcrumb">
	<div class="container">
		<div class="breadcrumb-banner d-flex flex-wrap align-items-center">
			<div class="col-first">
				<h1>My Page</h1>
				<nav class="d-flex align-items-center justify-content-start">
					<a href="1index">Home<i class="fa fa-caret-right"
						aria-hidden="true"></i></a><a href="mypage">My Page</a>
				</nav>
			</div>
		</div>
	</div>
</section>
	<!-- End Banner Area -->

	<!-- Start My Account -->
	<div class="container">
		
			<div class="col-md-12">
				
					<h3 class="billing-title text-center">My Page</h3>
					<p class="text-center mt-40 mb-40">Welcome! This is your account</p>
					<form name="f" method="post">
					<input type="hidden" name="m_no" value="${member.m_no}">
					<input type="hidden" name="m_id" value="${member.m_id}">
						<div class="form-group">
							<label class="col-sm-2 control-label">ID</label>
							<div class="col-sm-10">
								<p class="form-control-static">${member.m_id}</p>
							</div>
						</div>

						<div class="form-group">
							<label for="inputPassword" class="col-sm-2 control-label">Password</label>
							<div class="col-sm-10">
								<input name="m_password" type="password" class="form-control" id="inputPassword"
									placeholder="Password" required="required">
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">이름</label>
							<div class="col-sm-10">
								<input name="m_name" type="text" class="form-control" id="m_name"
									value="${member.m_name}" readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">연락처</label>
							<div class="col-sm-10">
								<input name="m_contact" type="text" class="form-control" id="m_contact"
									value="${member.m_contact}">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">이메일</label>
							<div class="col-sm-10">
								<input name="m_email" type="text" class="form-control" id="m_eamil"
									value="${member.m_email}">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">주소</label>
							<div class="col-sm-10">
								<input name="m_address" type="text" class="form-control" id="m_address"
									value="${member.m_address}" readonly="readonly">
							</div>
						</div>
							
					</form>
					
      
      
      
    </div>
			<div class="button-group" align="center">
				<button class="view-btn color-2 mt-20 w-40" onclick="member_update_action()"><span>회원정보 수정</span></button>
				<button class="view-btn color-2 mt-20 w-40" onclick="member_delete_action()"><span>회원탈퇴</span></button>
			</div>
			
			<br>
	<br>
	<br>
	<br>
	<br>
			<h3 class="billing-title text-center">Order List</h3>
					<p class="text-center mt-40 mb-40">This is your order list</p>
						<div class="col-md-12">
					<div id="list">
					</div>
						</div>
			
				
			</div>
	
	<!-- End My Account -->
	
	<br>
	<br>
	<br>

	<!-- start footer Area -->
	<jsp:include page="footer.jsp" />
	<!-- End footer Area -->

	
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
		integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
		crossorigin="anonymous"></script>
	<script src="js/vendor/bootstrap.min.js"></script>
	<script src="js/jquery.ajaxchimp.min.js"></script>
	<script src="js/jquery.nice-select.min.js"></script>
	<script src="js/jquery.sticky.js"></script>
	<script src="js/ion.rangeSlider.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/main.js"></script>
	<script src="js/member.js"></script>

</body>
</html>