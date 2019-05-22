<%@page import="jenkim49.survey.Survey"%>
<%@page import="jenkim49.product.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<%
	List<Product> productList = (List<Product>)request.getAttribute("productList");
	List<Product> productKeywordRecommend = (List<Product>)request.getAttribute("productKeywordRecommend");
	List<Product> productMostPopular = (List<Product>)request.getAttribute("productMostPopular");
	String m_id=(String)session.getAttribute("sMemberId");
	boolean isLogin=false;
	if(m_id!=null){
		isLogin=true;
	}
	Survey surveyResult = (Survey)request.getAttribute("surveyResult");
	boolean isSurvey=false;
	if(surveyResult!=null){
		isSurvey=true;
	}
%>
<html lang="zxx" class="no-js">
<head>
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
<!-- CSS ============================================= -->
<link rel="stylesheet" href="css/linearicons.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/nice-select.css">
<link rel="stylesheet" href="css/ion.rangeSlider.css" />
<link rel="stylesheet" href="css/ion.rangeSlider.skinFlat.css" />
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">
</head>

<!-- JavaScript ============================================= -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">

</script>
<body>
	<!-- include_common_top.jsp start-->
	<jsp:include page="1include_common_header.jsp"/>	

	<!-- start banner Area -->
	<section class="banner-area relative" id="home">
		<div class="container-fluid">
			<div class="row fullscreen align-items-center justify-content-center">
				<div class="banner-content col-lg-6 col-md-12">
					<h1 class="title-top">
						<span>Perfume Recommendation Survey</span>
					</h1>
					<h1 class="text-uppercase">
						Find Your Perfume! <br> Find Yourself!
					</h1>
					<a href="1survey"><button class="primary-btn text-uppercase">
						Start
					</button></a>
				</div>
			</div>
		</div>
	</section>
	<!-- End banner Area -->

	<!-- Start category Area -->
	<section class="category-area section-gap section-gap" id="catagory">
		<div class="container">
			<div class="row d-flex justify-content-center">
				<div class="menu-content pb-40">
					<div class="title text-center">
						<h1 class="mb-10">Shop for Different Categories</h1>
						<p>Who are in extremely love with eco friendly system.</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-8 col-md-8 mb-10">
					<div class="row category-bottom">
						<div class="col-lg-6 col-md-6 mb-30">
							<div class="content">
								<a href="1category_women" target="_blank">
									<div class="content-overlay"></div> <img
									class="content-image img-fluid d-block mx-auto"
									src="./img/women.jpeg" style="width:290px; height:174px;" alt="">
									<div class="content-details fadeIn-bottom">
										<h3 class="content-title">Women</h3>
									</div>
								</a>
							</div>
						</div>
						<div class="col-lg-6 col-md-6 mb-30">
							<div class="content">
								<a href="1category_men" target="_blank">
									<div class="content-overlay"></div> <img
									class="content-image img-fluid d-block mx-auto"
									src="./img/men.jpeg" style="width:580px; height:174px;" alt="">
									<div class="content-details fadeIn-bottom">
										<h3 class="content-title">Men</h3>
									</div>
								</a>
							</div>
						</div>
						<div class="col-lg-12">
							<div class="content">
								<a href="1category_all" target="_blank">
									<div class="content-overlay"></div> <img
									class="content-image img-fluid d-block mx-auto"
									src="./img/category.jpeg" style="max-width: 100%; height:auto;" alt="">
									<div class="content-details fadeIn-bottom">
										<h3 class="content-title">Shop New Release</h3>
									</div>
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-4 mb-10">
					<div class="content">
						<a href="serviceChat" target="_blank">
							<div class="content-overlay"></div> <img
							class="content-image img-fluid d-block mx-auto" src="img/c4.jpg"
							alt="" style="height:630px;">
							<div class="content-details fadeIn-bottom">
								<h3 class="content-title">Chat Service</h3>
							</div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End category Area -->

	<!-- Start New-released Area -->
	<section class="men-product-area section-gap relative" id="men">
		<div class="overlay overlay-bg"></div>
		<div class="container">
			<div class="row d-flex justify-content-center">
				<div class="menu-content pb-40">
					<div class="title text-center">
						<h1 class="text-white mb-10">New realeased Products</h1>
						<p class="text-white">신제품을 만나보세요~</p>
					</div>
				</div>
			</div>
			<div class="row">
				<% for(Product product:productList) { %>
				<div class="col-lg-3 col-md-6 single-product">
					<div class="content" >
						<div class="content-overlay"></div>
						<img class="content-image img-fluid d-block mx-auto" src="./img/product/<%=product.getP_image() %>" alt=""/>
					</div>
					<div class="price">
						<h5 class="text-white">
						<a href="1product_view1?p_no=<%=product.getP_no()%>" style="color:#ffffff;">
						<%=product.getP_name() %></a></h5>
						<h3 class="text-white"> 
							₩ <fmt:formatNumber value='<%=product.getP_price()%>' pattern="###,###,###"/>
						</h3>
					</div>
				</div>
				<% } %>
			</div>
		</div>
	</section>
	<!-- End New-released Area -->

	<!-- Start Keyword Recommend or Most Popular Item Area -->
	<section class="women-product-area section-gap" id="women">
		<div class="container">
			<div class="countdown-content pb-40">
				<div class="title text-center">
					<h1 class="mb-10">Related Product for you</h1>
					<p>과감히 추천하는 상품입니다~</p>
				</div>
			</div>
			<div class="row">
				<%if(isLogin && isSurvey){ %>
					<% for(Product product:productKeywordRecommend) { %>
					<div class="col-lg-3 col-md-6 single-product">
						<div class="content">
							<div class="content-overlay"></div>
							<img class="content-image img-fluid d-block mx-auto" src="./img/product/<%=product.getP_image() %>" alt="">
							<div class="content-details fadeIn-bottom">
								<div class="bottom d-flex align-items-center justify-content-center">
									<a href="#"><span class="lnr lnr-heart"></span></a> 
									<a href="#"><span class="lnr lnr-cart"></span></a> 
								</div>
							</div>
						</div>
						<div class="price">
							<h5 class="text-black"><a
										href="1product_view1?p_no=<%=product.getP_no()%>"><%=product.getP_name() %></a></h5>
							<h3 class="text-black"> 
								₩ <fmt:formatNumber value='<%=product.getP_price()%>' pattern="###,###,###"/>
							</h3>
						</div>
					</div>
					<% } %>
				<%}else{ %>
					<% for(Product product:productMostPopular) { %>
					<div class="col-lg-3 col-md-6 single-product">
						<div class="content">
							<div class="content-overlay"></div>
							<img class="content-image img-fluid d-block mx-auto" src="./img/product/<%=product.getP_image() %>" alt="">
						</div>
						<div class="price">
							<h5 class="text-white">
							<a href="1product_view1?p_no=<%=product.getP_no()%>" style="color:#000000;">
							<%=product.getP_name() %></a></h5>
							<h3 class="text-black"> 
								₩ <fmt:formatNumber value='<%=product.getP_price()%>' pattern="###,###,###"/>
							</h3>
						</div>
					</div>
					<% } %>
				<% } %>	
			</div>
		</div>
	</section>
	<!-- End Keyword Recommend or Most Popular Item Area -->
	
	<!-- include_common_top.jsp start-->
	<jsp:include page="1include_common_footer.jsp"/>			
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
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/main.js"></script>

</body>
</html>