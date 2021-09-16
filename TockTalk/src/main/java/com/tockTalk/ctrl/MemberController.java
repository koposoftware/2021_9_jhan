package com.tockTalk.ctrl;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tockTalk.domain.MemberVO;
import com.tockTalk.domain.PageVO;
import com.tockTalk.handler.PagingHandler;
import com.tockTalk.service.member.MemberServiceRule;
import com.tockTalk.service.stock.StockServiceRule;

@RequestMapping("/member/*")
@Controller
public class MemberController {

	@Inject
	private MemberServiceRule msv;

	@ResponseBody
	@PostMapping("/chkTester")
	public String chkTester(@RequestParam("email") String email, HttpSession ses) {
		int result = msv.chkTester(email);
		if (result > 0) {
			ses.setAttribute("ses", email);
			String[] array = email.split("@");
			String ses_id = array[0];
			ses.setAttribute("ses_id", ses_id);
			String ses_tester = array[0].substring(0, 6);
			ses.setAttribute("ses_tester", ses_tester);
			ses.setMaxInactiveInterval(15 * 60);
			return "1";
		}
		return "0";
	}

	@ResponseBody
	@PostMapping("/chkEmail")
	public String chkEmail(@RequestParam("email") String email) {
		int result = msv.chkEmail(email);
		return result > 0 ? "1" : "0";
	}

	@PostMapping("/join")
	public String join(MemberVO mvo, Model model) {
		
		// 암호화 처리 후 DB 저장
		BCryptPasswordEncoder pwEnc = new BCryptPasswordEncoder();
		String encPwd = pwEnc.encode(mvo.getPwd());
		mvo.setPwd(encPwd);
		
		
		int result = msv.join(mvo);
		if (result > 0) {
			model.addAttribute("msg", "회원가입 완료");
			model.addAttribute("url", "/");
		}
		return "detour";
	}
	@GetMapping("/loginPage")
	public String loginPage(HttpSession ses) {

		return "loginPage";	
	}
	
	@PostMapping("/login")
	public String login(MemberVO mvo, HttpSession ses, Model model) {

		// 암호화 처리된 pw와 비교
		BCryptPasswordEncoder pwEnc = new BCryptPasswordEncoder();
		String curEncPwd = msv.getEncPwd(mvo);

		if (pwEnc.matches(mvo.getPwd(), curEncPwd)) {
			MemberVO member = mvo;

			if (member != null) {

				// 1.세션 처리
				ses.setAttribute("ses", member.getEmail());
				String[] array = member.getEmail().split("@");
				String ses_id = array[0];
				String ses_name = msv.getUserName(mvo);
				ses.setAttribute("ses_id", ses_id);
				ses.setAttribute("ses_name", ses_name);
//				ses.setMaxInactiveInterval(15 * 60);

				// 2.예수금, 보유종목, 관심종목 현황
				model.addAttribute("deposit", msv.chkDeposit(mvo.getEmail()));
				model.addAttribute("h_list", msv.chk_h_list(mvo.getEmail()));

				if (msv.hasWatchList(mvo.getEmail()) > 0) {
					model.addAttribute("w_list", msv.chk_w_list(mvo.getEmail()));
				}
				return "main";
			}
		} 
		model.addAttribute("msg", "아이디나 비밀번호가 올바르지 않습니다.");
		model.addAttribute("url", "/");
		return "detour";
	}

	@GetMapping("/logout")
	public String logout(HttpSession ses) {
		ses.invalidate();
		return "redirect:/";
	}


	@GetMapping("/main")
	public String main(Model model, @RequestParam(value = "email", required=false) String email, HttpSession ses) {
				
		if(email != null) {
			model.addAttribute("deposit", msv.chkDeposit(email));
			model.addAttribute("h_list", msv.chk_h_list(email));				

			if(msv.hasWatchList(email) > 0) {
				model.addAttribute("w_list", msv.chk_w_list(email)); 
			}
		}
		return "main";	
	}

	@ResponseBody
	@PostMapping("/chkDeposit")
	public String chkDeposit(@RequestParam("email") String email) {
		return msv.chkDeposit(email);
	}

	@RequestMapping(value = { "/admin" }, method = { RequestMethod.POST })
	public String admin(Model model) {

		model.addAttribute("r_list", msv.getReportList());

		return "admin/admin";
	}

}
