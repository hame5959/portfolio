package jenkim49.checkout.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.bouncycastle.cert.ocsp.Req;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jenkim49.cart.Cart;
import jenkim49.checkout.Checkout;
import jenkim49.checkout.CheckoutService;
import jenkim49.jumun.Jumun;
import jenkim49.jumun.JumunService;
import jenkim49.jumundetail.JumunDetailService;
import jenkim49.member.Member;
import jenkim49.member.MemberService;
import jenkim49.product.Product;

@Controller
public class CheckoutController {
	private CheckoutService checkoutService;
	private MemberService memberService;
	private JumunService jumunService;
	private JumunDetailService jumunDetailService;

	public CheckoutController() {
		// TODO Auto-generated constructor stub
		System.err.println("## CheckoutController ##");
	}
	
	@Autowired
	public void setMemberService(MemberService memberService) {
		System.err.println("## setMemberService ##");
		this.memberService = memberService;
	}
	
	@Autowired
	public void setCheckoutService(CheckoutService checkoutService) {
		System.err.println("## setCheckoutService ##");
		this.checkoutService = checkoutService;
	}

	@Autowired
	public void setJumunService(JumunService jumunService) {
		System.err.println("## setJumunService ##");
		this.jumunService = jumunService;
	}

	@Autowired
	public void setJumunDetailService(JumunDetailService jumunDetailService) {
		System.err.println("## setJumunDetailService ##");
		this.jumunDetailService = jumunDetailService;
	}
	
	@RequestMapping("1checkout_process")
	public String checkout_process() {
		return "1checkout_process";
	}

	
	// Show Member Information, Order Detail, Order Total price
	/// use memberService, jumunService, jumundetailService
	@RequestMapping("1checkout")
	public String checkout_list(
							    HttpSession session,
							    Model model, Map map) {
		String forwardPath = "";
		String m_id = (String)session.getAttribute("sMemberId");
		int j_no = (int)session.getAttribute("j_no");
		System.out.println(m_id+j_no);
		if (m_id == null || m_id.equals("")) {
			model.addAttribute("ERROR_MSG", "로그인해주세요");
			forwardPath = "forward:login";
		} else {
			Member member = null;
			Jumun jumun = null;
			List<HashMap> jdList = null;
			try {
				member = memberService.member_readOneById(m_id);
				jumun = jumunService.jumun_readNo(j_no);
				jdList = jumunDetailService.jumundetail_readJNo(j_no);
				/*
				 * jenkim49265
					9	jenkim49	1234	jenkim	서울특별시	01012345678	jenkim@naver.com
					265,알뤼르 옴므 스포츠 오 드 뚜왈렛 스프레이 외 1품목 ,3,352000,2019-05-01,jenkim49,null
					[{jd_no=300, jd_item_qty=1, p_name=롬브르단로 퍼퓸 오일, j_no=265, jd_items_price=72000, p_image=1402650466146.jpg, m_id=jenkim49}, 
					{jd_no=300, jd_item_qty=1, p_name=롬브르단로 퍼퓸 오일, j_no=265, jd_items_price=72000, p_image=1402650466146.jpg, m_id=jenkim49}]
				 */
				System.err.println(member);
				System.err.println(jumun);
				System.err.println(jdList);
				if (jumun == null) {
					model.addAttribute("ERROR_MSG", "There is no order");
					forwardPath = "product_error";
				} else {
					model.addAttribute("member", member);
					model.addAttribute("jumun", jumun);
					map.put("jdList", jdList);
					forwardPath = "1checkout";
				}
			} catch (Exception e) {
				forwardPath = "product_error";
				e.printStackTrace();
			}
		}
		return forwardPath;
	}
	
	// Insert checkout when a customer click the 'proceed to checkout' button
	@RequestMapping(value="checkout_insert_action", method=RequestMethod.GET)
	public String checkout_insert_action_get() {
		String forwardPath = "redirect:1checkout";
		return forwardPath;
	}
	
	//근데 주소 입력칸이 여러개 있어서 (address line, zip code) 여기서 합쳐서 넣어야 할 듯... 그건 아직 안함 
	@RequestMapping(value = "checkout_insert_action", method = RequestMethod.POST)
	public String checkout_insert_action_post(@ModelAttribute Checkout checkout) {
		System.out.println(checkout);
		Checkout checkout1 = new Checkout(-999, checkout.getJ_total_qty(), checkout.getJ_total_price(), checkout.getM_id(),
										  checkout.getJ_no(), new java.sql.Date(System.currentTimeMillis()), checkout.getCo_method(), checkout.getCo_address());
		System.out.println(checkout1);
		String forwardPath = "";
		boolean insertOK = false;
		try {
			insertOK = checkoutService.checkout_insert(checkout1);
			if (insertOK) {
				forwardPath= "1confirmation";
			} else {
				forwardPath = "product_error";
			}
		} catch (Exception e) {
			e.printStackTrace();
			forwardPath = "product_error";
		}
		return forwardPath;
	}
	
	@RequestMapping("1confirmation")
	public String confirmation() {
		return "1confirmation";
	}

}
