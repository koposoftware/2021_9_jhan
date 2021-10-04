package com.tockTalk.ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChattingController {
	
	@RequestMapping("/chat")
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chatting");
		return mv;
	}
	
	@RequestMapping("/messenger")
	public ModelAndView messenger() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("messenger");
		return mv;
	}
}