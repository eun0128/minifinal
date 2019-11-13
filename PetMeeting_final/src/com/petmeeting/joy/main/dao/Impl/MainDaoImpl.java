package com.petmeeting.joy.main.dao.Impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petmeeting.joy.admin.model.EventboardDto;
import com.petmeeting.joy.freeboard.model.FreeboardDto;
import com.petmeeting.joy.main.dao.MainDao;
import com.petmeeting.joy.playboard.model.PlayboardDto;

@Repository
public class MainDaoImpl implements MainDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	String namespace = "Main.";

	@Override
	public List<PlayboardDto> getTodayPlayboards() {
		return sqlSession.selectList(namespace+"getTodayPlayboards");
	}

	@Override
	public List<FreeboardDto> getTodayFreeboards() {
		return sqlSession.selectList(namespace+"getTodayFreeboards");
	}

	@Override
	public List<EventboardDto> getThisMonthEvents() {
		return sqlSession.selectList(namespace+"getThisMonthEvents");
	}

}
