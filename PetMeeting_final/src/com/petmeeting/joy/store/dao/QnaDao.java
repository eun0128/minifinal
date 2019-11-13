package com.petmeeting.joy.store.dao;

import java.util.List;

import com.petmeeting.joy.store.model.AnswerDto;
import com.petmeeting.joy.store.model.QnaBean;
import com.petmeeting.joy.store.model.QnaParam;
import com.petmeeting.joy.store.model.QuestionDto;

public interface QnaDao {

	public void qnawrite(QuestionDto que);	// 문의글 쓰기
	
	public List<QnaBean> getQnalist(QnaParam param);	// 해당 제품의 문의글 가져오기
	
	public int getQnaCount(QnaParam param);	// 해당 제품의 문의글 개수 카운트
	
	public List<QnaBean> getQnalistAll(QnaParam param);	// 전체 문의글 가져오기
	
	public void answerwrite(AnswerDto ans);	// 문의글 답변하기
	
	/**
	 * 나의 최근 문의글 목록 5개 불러오기
	 */
	public List<QnaBean> getMyqnalistLatest(String email);
	
	/**
	 * 나의 문의글 가져오기
	 */
	public List<QnaBean> getMyqnaList(QnaParam param);
	
	/**
	 * 나의 문의글 개수 가져오기
	 */
	public int getMyqnaCount(QnaParam param);
	
	/**
	 * 전체 문의글 갯수 가져오기
	 */
	public int getQnaAllCount(QnaParam param);
	
	/**
	 * 문의글 삭제 - 답변삭제
	 */
	public void deleteAnswer(int seq);
	
	/**
	 * 문의글 삭제 - 질문 삭제
	 */
	public void deleteQuestion(int seq);
	
	/**
	 * 답변 수정
	 */
	public void updateAnswer(AnswerDto ans);
	
	
	/**
	 * 오늘의 문의 내역 수
	 */
	public int getTodayQuestion();
}
