package com.petmeeting.joy.main.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petmeeting.joy.main.service.MainService;
import com.petmeeting.joy.playboard.model.PlayboardDto;
import com.petmeeting.joy.admin.model.EventboardDto;
import com.petmeeting.joy.admin.service.AdminService;
import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.main.dao.MainDao;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	MainDao mainDao;

	@Override
	public List<PlayboardDto> getTodayPlayboards() {
		return mainDao.getTodayPlayboards();
	}

	@Override
	public List<FreeboardDto> getTodayFreeboards() {
		return mainDao.getTodayFreeboards();
	}

	@Override
	public List<EventboardDto> getThisMonthEvents() {
		return mainDao.getThisMonthEvents();
	}
	
	
}
