package com.petmeeting.joy.store.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petmeeting.joy.store.dao.QnaDao;
import com.petmeeting.joy.store.model.AnswerDto;
import com.petmeeting.joy.store.model.QnaBean;
import com.petmeeting.joy.store.model.QnaParam;
import com.petmeeting.joy.store.model.QuestionDto;
import com.petmeeting.joy.store.service.QnaService;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	QnaDao qnaDao;

	@Override
	public void qnawrite(QuestionDto que) {
		qnaDao.qnawrite(que);
	}

	@Override
	public List<QnaBean> getQnalist(QnaParam param) {
		List<QnaBean> qlist = qnaDao.getQnalist(param);
		
		return qlist;
	}
	
	@Override
	public int getQnaCount(QnaParam param) {
		return qnaDao.getQnaCount(param);
	}

	@Override
	public List<QnaBean> getQnalistAll(QnaParam param) {
		return qnaDao.getQnalistAll(param);
	}

	@Override
	public void answerwrite(AnswerDto ans) {
		qnaDao.answerwrite(ans);
	}

	@Override
	public List<QnaBean> getMyqnalistLatest(String email) {
		return qnaDao.getMyqnalistLatest(email);
	}

	@Override
	public List<QnaBean> getMyqnaList(QnaParam param) {
		return qnaDao.getMyqnaList(param);
	}

	@Override
	public int getMyqnaCount(QnaParam param) {
		return qnaDao.getMyqnaCount(param);
	}

	@Override
	public int getQnaAllCount(QnaParam param) {
		return qnaDao.getQnaAllCount(param);
	}

	@Override
	public void deleteQna(int seq) {
		qnaDao.deleteAnswer(seq);
		qnaDao.deleteQuestion(seq);
	}

	@Override
	public void updateAnswer(AnswerDto ans) {
		qnaDao.updateAnswer(ans);
	}
	
	@Override
	public int getTodayQuestion() {
		return qnaDao.getTodayQuestion();
	}
	
}
