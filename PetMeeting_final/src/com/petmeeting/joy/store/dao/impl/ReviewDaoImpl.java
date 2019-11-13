package com.petmeeting.joy.store.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petmeeting.joy.store.dao.ReviewDao;
import com.petmeeting.joy.store.model.ReviewBean;
import com.petmeeting.joy.store.model.ReviewDto;
import com.petmeeting.joy.store.model.ReviewParam;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	SqlSession sqlSession;
	
	String ns = "Review.";

	@Override
	public void writeReview(ReviewDto review) {
		sqlSession.insert(ns + "writeReview", review);
	}

	@Override
	public double getReviewScoreAvg(String pcode) {
		return sqlSession.selectOne(ns + "getReviewScoreAvg", pcode);
	}

	@Override
	public List<ReviewBean> getReviewList(ReviewParam param) {
		return sqlSession.selectList(ns + "getReviewList", param);
	}
	
	@Override
	public int getReviewCount(ReviewParam param) {
		return sqlSession.selectOne(ns + "getReviewCount", param);
	}

	@Override
	public List<ReviewBean> getMyReviewListLatest(String email) {
		return sqlSession.selectList(ns + "getMyReviewListLatest", email);
	}

	@Override
	public List<ReviewBean> getMyReviewList(ReviewParam param) {
		return sqlSession.selectList(ns + "getMyReviewList", param);
	}

	@Override
	public int getMyReviewCount(ReviewParam param) {
		return sqlSession.selectOne(ns + "getMyReviewCount", param);
	}

	@Override
	public void deleteReview(int seq) {
		sqlSession.delete(ns + "deleteReview", seq);
	}

	@Override
	public ReviewBean getReview(int seq) {
		return sqlSession.selectOne(ns + "getReviewParamSeq", seq);
	}

	@Override
	public void updateReview(ReviewDto review) {
		sqlSession.update(ns + "updateReview", review);
	}
	
}
