package com.petmeeting.joy.main.dao;

import java.util.List;

import com.petmeeting.joy.admin.model.EventboardDto;
import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.playboard.model.PlayboardDto;

public interface MainDao {

	public List<PlayboardDto> getTodayPlayboards();
	public List<FreeboardDto> getTodayFreeboards();
	public List<EventboardDto> getThisMonthEvents();
}
