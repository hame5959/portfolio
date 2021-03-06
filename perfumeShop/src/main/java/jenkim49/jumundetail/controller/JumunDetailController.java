package jenkim49.jumundetail.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jenkim49.brand.Brand;
import jenkim49.jumun.Jumun;
import jenkim49.jumundetail.JumunDetail;
import jenkim49.jumundetail.JumunDetailService;
import jenkim49.product.Product;

@Controller
public class JumunDetailController {

	private JumunDetailService jumundetailservice;

	public JumunDetailController() {
		System.out.println("########################JDCONTROLLER");
	}

	public JumunDetailController(JumunDetailService jumundetailservice) {
		super();
	}

	@Autowired
	public void setJumunDetailservice(JumunDetailService jumundetailservice) {
		this.jumundetailservice = jumundetailservice;
	}

	@RequestMapping("jd_list_all")
	public String product_list(Model model) {
		String forwardPath = "";
		try {
			List<HashMap> jdList = jumundetailservice.jumundetail_readAll();
			model.addAttribute("jdList", jdList);
			forwardPath = "jd_list_all";
		} catch (Exception e) {
			e.printStackTrace();
			forwardPath = "jd_list_all";
		}
		return forwardPath;

	}

	/*
	 * @RequestMapping("jd_list_id") public String jumun_view(@RequestParam("m_id")
	 * String m_id,Model model) { String forwardPath="";
	 * if(m_id==null||m_id.equals("")) { forwardPath="redirect:jd_list_id"; }else {
	 * List<JumunDetail> jumundetail=null; try { jumundetail =
	 * jumundetailservice.jumundetail_readId(m_id); if(jumundetail==null) {
	 * model.addAttribute("ERROR_MSG","존재하지않는 게시물입니다.");
	 * forwardPath="forward:jd_list"; }else { model.addAttribute("jd",jumundetail);
	 * forwardPath="jd_list_id"; }
	 * 
	 * }catch(Exception e) { forwardPath = "jd_error"; e.printStackTrace();
	 * 
	 * 
	 * } } return forwardPath; }
	 */
	@RequestMapping("jd_list_no")
	public String jd_list_id(@RequestParam("jd_no") int jd_no, Model model) {
		String forwardPath = "";
		if (jd_no == 0) {
			forwardPath = "redirect:jd_list_no";
		} else {
			List<HashMap> jd = null;
			try {
				jd = jumundetailservice.jumundetail_readJdNo(jd_no);
				if (jd == null) {
					model.addAttribute("ERROR_MSG", "존재하지않는 게시물입니다.");
					forwardPath = "forward:jd_list_no";
				} else {
					model.addAttribute("jd_list_no", jd);
					forwardPath = "jd_list_no";
				}

			} catch (Exception e) {
				forwardPath = "jd_error";
				e.printStackTrace();

			}
		}
		return forwardPath;
	}
	
	@RequestMapping(value="jd_list_jno",method=RequestMethod.GET)
	public String jd_list_jno(@RequestParam("j_no") int j_no, Model model) {
		String forwardPath = "";
		if (j_no == 0) {
			forwardPath = "redirect:admin";
		} else {
			List<HashMap> jd = null;
			try {
				jd = jumundetailservice.jumundetail_readJNo(j_no);
				if (jd == null) {
					model.addAttribute("ERROR_MSG", "상세주문이 존재하지 않습니다.");
					forwardPath = "admin";
				} else {
					model.addAttribute("jd_list_jno", jd);
					forwardPath = "jd_list_jno";
				}
				
			} catch (Exception e) {
				forwardPath = "jd_error";
				e.printStackTrace();
			}
		}
		return forwardPath;
	}
	
	

	@RequestMapping("jd_write_form")
	public String jd_write_form() {
		String forwardPath = "jd_write_form";
		return forwardPath;
	}

	@RequestMapping("jd_insert_action")
	public String jumun_write_action_post(@ModelAttribute JumunDetail jd) {
		System.out.println(jd);
		String forwardPath = "";
		boolean insertOK = false;
		try {

			insertOK = jumundetailservice.jumundetail_insert(jd);
			if (insertOK) {
				forwardPath = "redirect:checkout_readone_by_id";
			} else {
				forwardPath = "jd_error";
			}
		} catch (Exception e) {

			e.printStackTrace();
			forwardPath = "jd_error";

		}
		return forwardPath;
	}

	@RequestMapping(value = "jd_update_form", method = RequestMethod.POST)
	public String brand_update_form(@RequestParam("jd_no") int jd_no, Map map) {
		String forwardPath = "";
		try {
			List<HashMap> jumundetail = jumundetailservice.jumundetail_readJdNo(jd_no);
			map.put("jd", jumundetail);
			forwardPath = "jd_update_form";

		} catch (Exception e) {
			e.printStackTrace();
			forwardPath = "jd_error";
		}

		return forwardPath;

	}

	@RequestMapping(value = "jd_update_form_action", method = RequestMethod.POST)
	public String brand_update_action(@ModelAttribute JumunDetail updateJumunDetail) {
		String forwardPath = "";
		boolean updateOK;
		try {
			updateOK = jumundetailservice.jumundetail_update(updateJumunDetail);

			if (updateOK) {
				// forwardPath = "redirect:guest_view.do?guest_no="+updateGuest.getGuest_no();
				forwardPath = "forward:jd_list_id";
			} else {
				forwardPath = "jd_error";
			}
		} catch (Exception e) {
			forwardPath = "jd_error";
			e.printStackTrace();
		}

		return forwardPath;

	}

	@RequestMapping(value = "jd_delete_action", method = RequestMethod.POST)
	public String brand_delete_action_post(@RequestParam("jd_no") String jd_noStr) {
		String forwardPath = "";
		boolean insertOK;

		try {
			insertOK = jumundetailservice.jumundetail_delete(Integer.parseInt(jd_noStr));
			if (insertOK) {
				forwardPath = "redirect:jd_list_id";
			} else {
				forwardPath = "jd_error";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return forwardPath;

	}
	
}
