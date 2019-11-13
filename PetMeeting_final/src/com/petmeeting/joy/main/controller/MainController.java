package com.petmeeting.joy.main.controller;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.petmeeting.joy.admin.model.EventboardDto;
import com.petmeeting.joy.admin.service.AdminService;
import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.main.service.MainService;
import com.petmeeting.joy.playboard.model.PlayboardDto;

@Controller
public class MainController {
	
	@Autowired
	MainService mainService;
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "main.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String main(Model model) {
		List<PlayboardDto> todayPboard = mainService.getTodayPlayboards();
		List<FreeboardDto> todayFboard = mainService.getTodayFreeboards();
		
		List<EventboardDto> eventList = mainService.getThisMonthEvents();
		
		
		
		model.addAttribute("todayPlayboard", todayPboard);
		model.addAttribute("todayFreeboard", todayFboard);
		model.addAttribute("eventList", eventList);
		return "main";
	}
	
	@RequestMapping(value = "eventBoard.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String eventBoard(String date, Model model) {
		System.out.println("처음 date가 들어오나 : " + date);
		
		Calendar today = Calendar.getInstance();
		String year = "";
		String month = "";
		
		if(month.length() == 1) {
			month = "0"+month;
		}
		if(date == null) {	
			year = today.get(Calendar.YEAR)+"";
			month = (today.get(Calendar.MONTH)+1)+"";
			
			if(month.length() == 1) {
				month = "0"+month;
			}
			date = year+month;
		}else {
			year = date.substring(0, 4);
			System.out.println("year : " + year);
			month = date.substring(4);
			if(month.length() == 1) {
				month = "0"+month;
			}
			System.out.println("month : " + month);
		}
		
		List<EventboardDto> eventList = adminService.getMonthlyEventList(date);
		model.addAttribute("monthlyEvents", eventList);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		return"eventboard/eventList";
	}
	
	@RequestMapping(value = "eventDetail.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String eventDetail(int seq, Model model) {
		//System.out.println("이벤트 seq : " + seq);
		
		EventboardDto eventDto = adminService.getEventDetail(seq);
		System.out.println(eventDto.toString());
		model.addAttribute("detail", eventDto);
		return"eventboard/eventDetail";
	}
}
