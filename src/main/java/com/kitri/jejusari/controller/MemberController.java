package com.kitri.jejusari.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kitri.jejusari.common.KakaoLoginAPI;
import com.kitri.jejusari.dto.MemberDto;
import com.kitri.jejusari.service.MemberService;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService memberService;
	
	// 메인 리다이렉트
	@RequestMapping(value="/")
	public String home() {
		
		return "redirect:main";
	}
	
	// 메인
	@RequestMapping(value="/main")
	public String main() {
		
		return "main/main.tiles";
	}
	
	
	// 회원 탈퇴
	@RequestMapping(value="/member/withdraw1")
	public String withdraw() {
		
		return "member/member_withdraw1.tiles";
	}
	// 회원 탈퇴
	@RequestMapping(value="/member/withdraw2")
	public String withdrawOk(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		String member_id = (String) session.getAttribute("member_id");
		
		int check = memberService.member_delete(member_id);
		model.addAttribute("check", check);
		
		session.invalidate();
		
		return "member/member_withdraw2.tiles";
	}
		
	// 로그인 뷰
	@RequestMapping(value="/member/login")
	public String loginView(HttpSession session) {
		
		return "member/member_login.tiles";
	}
	
	// 임시 로그인 뷰
	@RequestMapping(value="/member/templogin")
	public String tempLoginView(HttpSession session) {
		
		return "member/member_tempLogin.tiles";
	}
	
	// 임시 로그인 
	@RequestMapping(value="/member/templogin", method=RequestMethod.POST)
	public String temLogin(HttpServletRequest request, MemberDto memberDto, Model model) {
		
		logger.info("templogin");
		System.out.println(memberDto.toString());
		HttpSession session = request.getSession();
		MemberDto member = memberService.tempLogin(memberDto);
		
		if (member == null) {
			model.addAttribute("msg", "아이디가 잘못 되었습니다.");
			return "main/main.tiles";
		}
		
		session.setAttribute("member_id", member.getMember_id());
		session.setAttribute("member_name", member.getMember_name());
		model.addAttribute("msg", "로그인 되었습니다.");
		
		return "main/main.tiles";
	}
	
	// 임시회원가입 뷰
	@RequestMapping(value="/member/tempjoin", method=RequestMethod.GET)
	public String temJoin(HttpSession session) {
		
		return "member/member_tempSignup.tiles";
	}
	
	// 임시 회원가입
	@RequestMapping(value="/member/tempjoin", method=RequestMethod.POST)
	public ModelAndView temJoinDo(HttpServletRequest request, MemberDto memberDto) {
		ModelAndView mav = new ModelAndView();
		
		String member_phone = request.getParameter("no1") 
				  + "-" + request.getParameter("no2") 
				  + "-" + request.getParameter("no3");
		
		String member_email = memberDto.getMember_email() + "@" + request.getParameter("email");
		
		logger.info(memberDto.toString());
		memberDto.setMember_phone(member_phone);
		memberDto.setMember_email(member_email);
		int check = memberService.memberJoin(memberDto);
		
		mav.addObject("check", check);
		mav.setViewName("member/member_signupOk.tiles");
		
		return mav;
	}
	
	// 카카오로 로그인 or 회원가입
	@RequestMapping("/test/join")
	public ModelAndView kakaoLogin(HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();

		// 카카오의 인증과정
		String authorize_code = request.getParameter("code");
		String access_Token = KakaoLoginAPI.kakaoAccessToken(authorize_code);

		// access_token으로 사용자의 카카오 로그인 정보를 가져온다.
		HashMap<String, Object> userInfo = KakaoLoginAPI.getUserInfo(access_Token);
		
		String member_id = (String)userInfo.get("id");
		String member_name = (String)userInfo.get("nickname");
		String member_email = (String)userInfo.get("email");

		// 이미 가입되어있는 회원인지 확인한다.
		int id_check = memberService.member_id_check(member_id);
		if (id_check > 0) {
			// 이미 가입된 회원일 경우 바로 로그인
			HttpSession session = request.getSession();
			if (userInfo.get("id") != null) {
				
				session.setAttribute("member_id", member_id);
				session.setAttribute("member_name", member_name);
				session.setAttribute("access_Token", access_Token);
			}
			mav.setViewName("main/main.tiles");
			return mav;
		}

		mav.addObject("member_id", member_id);
		mav.addObject("member_name", member_name);
		mav.addObject("member_email", member_email);
		mav.setViewName("member/member_signup.tiles");

		return mav;
	}
	
	// 회원가입
	@RequestMapping("/member/joinOk")
	public ModelAndView memberJoin(HttpServletRequest request, MemberDto memberDto) {
		ModelAndView mav = new ModelAndView();
		
		String member_phone = request.getParameter("no1") 
					  + "-" + request.getParameter("no2") 
					  + "-" + request.getParameter("no3");
		
		String email = memberDto.getMember_email() + "@" + request.getParameter("email");
		
		memberDto.setMember_email(email);
		
		// 회원가입자가 일반회원인 경우, 핸드폰 번호를 입력 안했을때
		if (request.getParameter("no2").length() == 0 || request.getParameter("no3").length() == 0) {
			memberDto.setMember_phone(null);
		} else {
		// 중개업자인 경우
			memberDto.setMember_phone(member_phone);
		}
		
//		System.out.println(memberDto.toString());
		
		int check = memberService.memberJoin(memberDto);
		mav.addObject("check", check);
		mav.setViewName("member/member_signupOk.tiles");
		
		return	mav;
	}
	
	// 로그아웃
	@RequestMapping(value="/member/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("access_Token");
		session.removeAttribute("member_id");
		session.removeAttribute("member_name");
		return "redirect:/";
	}
	
	// 마이페이지
	@RequestMapping(value="/member/mypage")
	public ModelAndView myPage(HttpServletRequest request, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		
		String member_name=(String) session.getAttribute("member_name");
		String member_level=(String) session.getAttribute("member_level");
		
		mav.addObject("member_name", member_name);
		mav.addObject("member_level", member_level);
		mav.addObject("request", request);
		
		memberService.myPage(mav);
		
		return mav;
	}
	
	@RequestMapping(value="/member/mypage/scrap")
	public ModelAndView deleteScrap(HttpServletRequest request) {
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request", request);
		
//		memberService.deleteScrap(mav);
		
		return mav;
	}
	
	// 회원수정
	@RequestMapping(value="/member/update")
	public String update() {
		
		return "member/member_update.tiles";
	}
	
	// 회원 관리
	@RequestMapping(value = "/member/admin")
	public ModelAndView adminMemberList() {
		ModelAndView mav = new ModelAndView();

		memberService.getMemberList(mav);

		return mav;

	}

	// 관리자 회원 삭제
	@ResponseBody
	@RequestMapping(value ="/member/drop", method = RequestMethod.POST)
	public int dropMember(@RequestParam(value="drop[]") List<String> list, HttpServletResponse response) {
	
		//System.out.println(list); 
		
		int dropUser = memberService.dropMember(list);
		
		//System.out.println(dropUser);
		
		return dropUser;

	}
	
}
