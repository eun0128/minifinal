package com.petmeeting.joy.store.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petmeeting.joy.store.dao.QnaDao;
import com.petmeeting.joy.store.model.AnswerDto;
import com.petmeeting.joy.store.model.QnaBean;
import com.petmeeting.joy.store.model.QnaParam;
import com.petmeeting.joy.store.model.QuestionDto;

@Repository
public class QnaDaoImpl implements QnaDao {

	@Autowired
	SqlSession sqlSession;
	String ns = "Qna.";
	
	@Override
	public void qnawrite(QuestionDto que) {
		sqlSession.insert(ns + "qnawrite", que);
	}

	@Override
	public List<QnaBean> getQnalist(QnaParam param) {
		return sqlSession.selectList(ns + "getQnalist", param);
	}
	
	@Override
	public int getQnaCount(QnaParam param) {
		return sqlSession.selectOne(ns + "getQnaCount", param);
	}

	@Override
	public List<QnaBean> getQnalistAll(QnaParam param) {
		return sqlSession.selectList(ns + "getQnalistAll", param);
	}
	
	@Override
	public void answerwrite(AnswerDto ans) {
		sqlSession.insert(ns + "answerwrite", ans);
	}

	@Override
	public List<QnaBean> getMyqnalistLatest(String email) {
		return sqlSession.selectList(ns + "getMyqnalistLatest", email);
	}

	@Override
	public List<QnaBean> getMyqnaList(QnaParam param) {
		return sqlSession.selectList(ns + "getMyqnaList", param);
	}

	@Override
	public int getMyqnaCount(QnaParam param) {
		return sqlSession.selectOne(ns + "getMyqnaCount", param);
	}

	@Override
	public int getQnaAllCount(QnaParam param) {
		return sqlSession.selectOne(ns + "getQnaAllCount", param);
	}

	@Override
	public void deleteAnswer(int seq) {
		sqlSession.delete(ns + "deleteAnswer", seq);
	}

	@Override
	public void deleteQuestion(int seq) {
		sqlSession.delete(ns + "deleteQuestion", seq);
	}

	@Override
	public void updateAnswer(AnswerDto ans) {
		sqlSession.update(ns + "updateAnswer", ans);
	}
	
	@Override
	public int getTodayQuestion() {
		return sqlSession.selectOne(ns + "getTodayQuestion");
	}
	
}
