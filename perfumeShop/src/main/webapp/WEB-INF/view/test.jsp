<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="jenkim49.jumun.Jumun"%>
<%@page import="jenkim49.member.Member"%>
<%@page import="jenkim49.checkout.Checkout"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	Member member = (Member) request.getAttribute("member");
	Jumun jumun = (Jumun) request.getAttribute("jumun");
	List<HashMap> jdList = (List<HashMap>) request.getAttribute("jdList");
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

$(document).ready(function () {
    // 콤보박스가 변경될 때 
    $('#lstFavorites').change(function () {
        // 드롭다운리스트에서 선택된 값을 텍스트박스에 출력
        var selectedText = // $("#lstFavorites option:selected").text();
            // $("option:selected").text();
            $(":selected").text();  // 드롭다운리스트가 하나밖에 없다면 이렇게 써도 됨
        $('#txtFavorite').val(selectedText);
    });
});

	function checkoutInsert() {
		alert($("option:selected").text());
		if (confirm("Do you want to proceed?")) {
			var Params = 'checkout_insert_action?j_total_qty='
					+ $("[name=j_total_qty]").val();
			Params += '&j_total_price=' + $("[name=j_total_price]").val();
			Params += '&m_id=' + $("[name=m_id]").val();
			Params += '&j_no=' + $("[name=j_no]").val();
			Params += '&co_method='
					+ $("input[name=brand]:radio:checked").val()
			Params += '&co_address=' + $("[name=address_line_01]").val() + " "
					+ $("[name=address_line_02]").val() + " "
					+ $("[name=town_city]").val() + " "
					+ $("[name=postcode]").val() + " " 
					+ $("option:selected").text();
			alert(Params);
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
					co_address : '&co_address=' + $("[name=address_line_01]").val() + " "
					+ $("[name=address_line_02]").val() + " "
					+ $("[name=town_city]").val() + " "
					+ $("[name=postcode]").val() + " " + $("option:selected").text()
				},
				success : function(data) {
					alert("success");
				}
			})
		}
	}
</script>
</head>
<body>
	<!-- Start Checkout Area -->
	<div class="container">
		<div class="checkput-login">
			<div class="top-title">
				<p>
					Returning Customer? <a data-toggle="collapse"
						href="#checkout-login" aria-expanded="false"
						aria-controls="checkout-login">Click here to login</a>
				</p>
			</div>
			<div class="collapse" id="checkout-login">
				<div class="checkout-login-collapse d-flex flex-column">
					<p>If you have shopped with us before, please enter your
						details in the boxes below. If you are a new customer, please
						proceed to the Billing & Shipping section.</p>
					<form action="#" class="d-block">
						<div class="row">
							<div class="col-lg-4">
								<input type="text" placeholder="Username or Email*"
									onfocus="this.placeholder=''"
									onblur="this.placeholder = 'Username or Email*'" required
									class="common-input mt-10">

							</div>
							<div class="col-lg-4">
								<input type="password" placeholder="Password*"
									onfocus="this.placeholder=''"
									onblur="this.placeholder = 'Password*'" required
									class="common-input mt-10">
							</div>
						</div>
						<div class="d-flex align-items-center flex-wrap">
							<button class="view-btn color-2 mt-20 mr-20">
								<span>Login</span>
							</button>
							<div class="mt-20">
								<input type="checkbox" class="pixel-checkbox" id="login-1">
								<label for="login-1">Remember me</label>
							</div>
						</div>
					</form>
					<a href="#" class="mt-10">Lost your password?</a>
				</div>
			</div>
		</div>
	</div>
	<!-- End Checkout Area -->
	<!-- Start Billing Details Form -->
	<div class="container">
		<form action="#" class="billing-form" name="sm1">
			<div class="row">
				<div class="col-lg-8 col-md-6">
					<h3 class="billing-title mt-20 mb-10">Billing Details</h3>
					<div class="row">
						<!-- hidden : m_id -->
						<div class="col-lg-6">
							<input type="hidden" id="m_id" name="m_id"
								value="<%=member.getM_id()%>"> <input type="text"
								placeholder="Name*" onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Name*'" required
								class="common-input" value="<%=member.getM_name()%>">
						</div>
						<div class="col-lg-6">
							<input type="text" placeholder="Phone number*"
								onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Phone number*'" required
								class="common-input" value="<%=member.getM_email()%>">
						</div>
						<div class="col-lg-6">
							<input type="email" placeholder="Email Address*"
								onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Email Address*'" required
								class="common-input" value="<%=member.getM_address()%>">
						</div>
						<!-- hidden : co_address -->
						<div class="col-lg-12">
							<input type="text" name="address_line_01"
								placeholder="Address line 01*" onfocus="this.placeholder=''"
								onblur="this.placeholder = 'Address line 01*'" required
								class="common-input">
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
									<option value="United States of America">United States of America</option>
									<option value="United Kingdom">United Kingdom</option>
								</select>
							</div>
						</div>
					</div>
					<div class="mt-20">
						<input type="checkbox" class="pixel-checkbox" id="login-3">
						<label for="login-3">Create an account?</label>
					</div>
					<h3 class="billing-title mt-20 mb-10">Billing Details</h3>
					<div class="mt-20">
						<input type="checkbox" class="pixel-checkbox" id="login-6">
						<label for="login-6">Ship to a different address?</label>
					</div>
					<textarea placeholder="Order Notes" onfocus="this.placeholder=''"
						onblur="this.placeholder = 'Order Notes'" required
						class="common-textarea">
                            </textarea>
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
								for (HashMap jd : jdList) {
							%>
							<div class="list-row d-flex justify-content-between">
								<div><%=jd.get("p_name")%></div>
								<div><%=jd.get("jd_item_qty")%></div>
								<div><fmt:formatNumber value='<%=jd.get("jd_items_price")%>' pattern="###,###,###"></fmt:formatNumber></div>
							</div>
							<%
								}
							%>
							<div class="list-row d-flex justify-content-between"
								id="substotal1">
								<!-- hidden : j_total_qty -->
								<div>
									<input type="hidden" id="j_total_qty" name="j_total_qty"
										value="<%=jumun.getJ_total_qty()%>">
								</div>
							</div>
							<!-- hidden : j_total_price -->
							<div class="list-row d-flex justify-content-between"
								id="substotal2">
								<h6>Total</h6>
								<div>
									<input type="hidden" id="j_total_price" name="j_total_price" value="<%=jumun.getJ_total_price()%>">
									<fmt:formatNumber value="<%=jumun.getJ_total_price() %>" pattern="###,###,###"></fmt:formatNumber>
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
</body>
</html>