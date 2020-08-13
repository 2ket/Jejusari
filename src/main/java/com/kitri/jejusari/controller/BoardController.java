package com.kitri.jejusari.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.jejusari.dto.ReportDto;
import com.kitri.jejusari.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	// 사이트소개
	@RequestMapping(value="/introduce")
	public String introduce() {
		
		return "main/introduce.tiles";
	}
	
	// 뉴스리스트
	@RequestMapping(value="/news")
	public ModelAndView news() {
		ModelAndView mav=new ModelAndView();
		
		boardService.newsList(mav);
//		System.out.println(mav);
		
		return mav;
	}
	
	// 공지사항 목록
	@RequestMapping(value="/notice")
	public String notice() {
		
		return "notice/notice_list.tiles";
	}
	
	// 공지사항 상세보기
	@RequestMapping(value="/notice/detail")
	public String noticeDetail() {
		
		return "notice/notice_read.tiles";
	}
	
	// 공지사항 작성 화면
	@RequestMapping(value="/notice/write")
	public String noticeWrite() {
		
		return "notice/notice_write.tiles";
	}
	
	// 공지사항 작성
	@RequestMapping(value="/notice/write", method=RequestMethod.POST)
	public String noticeWriteDo() {
		
		return "notice/notice_writeOk.tiles";
	}
	
	// 공지사항 수정 화면
	@RequestMapping(value="/notice/update")
	public String noticeUpdate() {
		
		return "notice/notice_update.tiles";
	}
	
	// 공지사항 수정
	@RequestMapping(value="/notice/update", method=RequestMethod.POST)
	public String noticeUpdateDo() {
		
		return "notice/notice_updateOk.tiles";
	}
	
	// 공지사항 삭제화면
	@RequestMapping(value="/notice/delete")
	public String noticeDelete() {
		
		return "notice/notice_delete.tiles";
	}
	
	// 공지사항 삭제
	@RequestMapping(value="/notice/delete", method=RequestMethod.POST)
	public String noticeDeleteDo() {
		
		return "notice/notice_deleteOk.tiles";
	}
	
	// 신고 작성
	@RequestMapping(value="/report/write", method = RequestMethod.GET)
	public ModelAndView report(HttpServletRequest request, HttpServletResponse response) {
		
		return new ModelAndView("report/report_write.empty");
	}
	
	// 신고작성 ok
	@RequestMapping(value="/report/write", method=RequestMethod.POST)
	public ModelAndView memberRegisterOk(HttpServletRequest request, HttpServletResponse response, ReportDto reportDto) {
		System.out.println( "memberDto : " + reportDto.toString());			// 넘어오는지 확인
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("reportDto", reportDto);
		mav.setViewName("report/report_writeOk");
		
	   boardService.reportWriteOk(mav);		// controller의 함수명과 같게 하는게 좋다.
	   
	    return mav;
	}
	
	// 신고 관리자
	@RequestMapping(value="/report/admin")
	public String reportAdmin() {
		
		return "admin/report_admin.tiles";
	}
}
