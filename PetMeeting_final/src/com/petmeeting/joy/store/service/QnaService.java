package com.petmeeting.joy.store.service;

import java.util.List;

import com.petmeeting.joy.store.model.AnswerDto;
import com.petmeeting.joy.store.model.QnaBean;
import com.petmeeting.joy.store.model.QnaParam;
import com.petmeeting.joy.store.model.QuestionDto;

public interface QnaService {
	
	public void qnawrite(QuestionDto que);
	
	public List<QnaBean> getQnalist(QnaParam param);
	
	public int getQnaCount(QnaParam param);
	
	public List<QnaBean> getQnalistAll(QnaParam param);
	
	public void answerwrite(AnswerDto ans);
	
	public List<QnaBean> getMyqnalistLatest(String email);
	
	public List<QnaBean> getMyqnaList(QnaParam param);
	
	public int getMyqnaCount(QnaParam param);
	
	public int getQnaAllCount(QnaParam param);
	
	public void deleteQna(int seq);
	
	public void updateAnswer(AnswerDto ans);
	
	public int getTodayQuestion();

}
