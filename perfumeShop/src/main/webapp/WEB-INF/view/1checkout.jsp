<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="jenkim49.jumun.Jumun"%>
<%@page import="jenkim49.member.Member"%>
<%@page import="jenkim49.checkout.Checkout"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	Member member = (Member) request.getAttribute("member");
	Jumun jumun = (Jumun) request.getAttribute("jumun");
	List<Map<String,Object>> jdList = (List<Map<String,Object>>) request.getAttribute("jdList");
	 List<Map<String, Object>>  jd= jdList;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS ============================================= -->
<link rel="stylesheet" href="css/linearicons.css">
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/nice-select.css">
<link rel="stylesheet" href="css/ion.rangeSlider.css" />
<link rel="stylesheet" href="css/ion.rangeSlider.skinFlat.css" />
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">

<!-- JavasScript Function ============================================= -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">

	function checkoutInsert() {
	if (confirm("Do you want to proceed?")) {
		$.ajax({
			url : 'checkout_insert_action',
			type : 'POST',
			dataType : 'text',
			data : {
				j_total_qty : $("[name=j_total_qty]").val(),
				j_total_price : $("[name=j_total_price]").val(),
				m_id : $("[name=m_id]").val(),
				j_no : $("[name=j_no]").val(),
				co_method : $("input[name=brand]:radio:checked").val(),
				co_address : '&co_address='
						+ $("[name=address_line_01]").val() + " "
						+ $("[name=address_line_02]").val() + " "
						+ $("[name=town_city]").val() + " "
						+ $("[name=postcode]").val() + " "
						+ $("option:selected").text()
			},
			success : function(data) {
				document.sm1.action = "1confirmation";
				document.sm1.submit();
			}
		})
	}
}

	
</script>
</head>
<body>

	<!-- include_common_top.jsp start-->
	<jsp:include page="1include_common_header.jsp" />
	<!-- include_common_top.jsp end-->

	<!-- Start Banner Area -->
	<section class="banner-area organic-breadcrumb">
		<div class="container">
			<div class="breadcrumb-banner d-flex flex-wrap align-items-center">
				<div class="col-first">
					<h1>Product Checkout</h1>
					<nav class="d-flex align-items-center justify-content-start">
						<a href="1index">Home<i class="fa fa-caret-right"
							aria-hidden="true"></i></a> <a href="1checkout">Product Checkout</a>
					</nav>
				</div>
			</div>
		</div>
	</section>
	<!-- End Banner Area -->
	<!-- Start Checkout Area -->
	<!-- End Checkout Area -->
	<!-- Start Billing Details Form -->
	<div class="container">
		<form class="billing-form" name="sm1">
			<div class="row">
				<div class="col-lg-8 col-md-6">
					<h3 class="billing-title mt-20 mb-10">Billing Details</h3>
					<div class="row">
						<!-- hidden : m_id -->
						<div class="col-lg-6">
							<input type="hidden" id="m_id" name="m_id"
								value="<%=member.getM_name()%>"> <input type="text" name="m_id"
								placeholder="Name*" onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Name*'" required
								class="common-input" value="<%=member.getM_name()%>">
						</div>
						<div class="col-lg-6">
							<input type="text" name="m_email" placeholder="Phone number*"
								onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Phone number*'" required
								class="common-input" value="<%=member.getM_contact()%>">
						</div>
						<div class="col-lg-6">
							<input type="email" name="m_address" placeholder="Email Address*"
								onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Email Address*'" required
								class="common-input" value="<%=member.getM_email()%>">
						</div>
						<!-- hidden : co_address -->
						<div class="col-lg-12">
							<input type="text" name="address_line_01"
								placeholder="Address line 01*" onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Address line 01*'" required
								class="common-input" value="<%=member.getM_address() %>">
						</div>
						<div class="col-lg-12">
							<input type="text" name="address_line_02"
								placeholder="Address line 02*" onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Address line 02*'" required
								class="common-input">
						</div>
						<div class="col-lg-12">
							<input type="text" name="town_city" placeholder="Town/City*"
								onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Town/City*'" required
								class="common-input">
						</div>
						<div class="col-lg-12">
							<input type="text" name="postcode" placeholder="Postcode/ZIP"
								onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Postcode/ZIP'" class="common-input">
						</div>
						<div class="col-lg-12">
							<div class="sorting">
								<select id="country">
									<option value="Default">Country*</option>
									<option value="China">China</option>
									<option value="South">South Korea</option>
									<option value="United States of America">United States
										of America</option>
									<option value="United Kingdom">United Kingdom</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<!-- order list -->
				<div class="col-lg-4 col-md-6">
					<div class="order-wrapper mt-50">
						<h3 class="billing-title mb-10">Your Order</h3>
						<div class="order-list">
							<div class="list-row d-flex justify-content-between">
								<!-- hidden : j_no -->
								<input type="hidden" id="j_no" name="j_no"
									value="<%=jumun.getJ_no()%>">
								<div>Product</div>
								<div>Total</div>
							</div>
							<%
								for(int i=0;i<jdList.size() ;i++) {
							%>
							<div class="list-row d-flex justify-content-between">
								<div><%=jd.get(i).get("p_name")%></div>
								<div><%=jd.get(i).get("jd_item_qty")%></div>
								<div>
									<fmt:formatNumber value='<%=jd.get(i).get("jd_items_price")%>'
										pattern="###,###,###"></fmt:formatNumber>
								</div>
							</div>
							<%
								}
							%>
							<div class="list-row d-flex justify-content-between"
								id="substotal1">
								<!-- hidden : j_total_qty -->
								<div>
									<input type="text" id="j_total_qty" name="j_total_qty"
										value="<%=jumun.getJ_total_qty()%>">
								</div>
							</div>
							<!-- hidden : j_total_price -->
							<div class="list-row d-flex justify-content-between"
								id="substotal2">
								<h6>Total</h6>
								<div>
									<input type="hidden" id="j_total_price" name="j_total_price"
										value="<%=jumun.getJ_total_price()%>">
									<fmt:formatNumber value="<%=jumun.getJ_total_price()%>"
										pattern="###,###,###"></fmt:formatNumber>
								</div>
							</div>
							<!-- hidden : co_method -->
							<div class="d-flex align-items-center mt-10">
								<input type="hidden" id="co_method" name="co_method"
									value="co_method"> <input class="pixel-radio"
									type="radio" id="check" name="brand" value="Check" checked>
								<label for="check" class="bold-lable">Check payments</label>
							</div>
							<p class="payment-info">Please send a check to Store Name,
								Store Street, Store Town, Store State / County, Store Postcode.</p>
							<div class="d-flex justify-content-between">
								<div class="d-flex align-items-center">
									<input class="pixel-radio" type="radio" id="paypal"
										name="brand" value="Paypal"> <label for="paypal"
										class="bold-lable">Paypal</label>
								</div>
								<img src="img/organic-food/pm.jpg" alt="" class="img-fluid">
							</div>
							<p class="payment-info">Pay via Paypal; you can pay with your
								credit card if you don't have a PayPal account.</p>
							<div class="d-flex justify-content-between">
								<div class="d-flex align-items-center">
									<input class="pixel-radio" type="radio" id="credit"
										name="brand" value="Credit"> <label for="paypal"
										class="bold-lable">Credit</label>
								</div>
								<img src="img/organic-food/pm.jpg" alt="" class="img-fluid">
							</div>
							<p class="payment-info">Pay via Credit; you can pay with your
								credit card directly.</p>
							<div class="mt-20 d-flex align-items-start">
								<input type="checkbox" class="pixel-checkbox" id="login-4">
								<label for="login-4">Read and accept the <a href="#"
									class="terms-link">terms & conditions*</a></label>
							</div>
							<button class="view-btn color-2 w-100 mt-20"
								onClick="checkoutInsert();">
								<span>Proceed to Checkout</span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- End Billing Details Form -->

	<!-- include_common_top.jsp start-->
	<jsp:include page="1include_common_footer.jsp" />
	<!-- include_common_top.jsp end-->

	<script src="js/vendor/jquery-2.2.4.min.js"></script>
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
	<script src="js/main.js"></script>
</body>
</html>