package com.petmeeting.joy.store.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petmeeting.joy.store.dao.ReviewDao;
import com.petmeeting.joy.store.model.OrderInfoDto;
import com.petmeeting.joy.store.model.ReviewBean;
import com.petmeeting.joy.store.model.ReviewDto;
import com.petmeeting.joy.store.model.ReviewParam;
import com.petmeeting.joy.store.service.ReviewService;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewDao reviewDao;

	@Override
	public void writeReview(ReviewDto review) {
		reviewDao.writeReview(review);
	}

	@Override
	public double getReviewScoreAvg(String pcode) {
		return reviewDao.getReviewScoreAvg(pcode);
	}

	@Override
	public List<ReviewBean> getReviewList(ReviewParam param) {
		return reviewDao.getReviewList(param);
	}
	
	@Override
	public int getReviewCount(ReviewParam param) {
		return reviewDao.getReviewCount(param);
	}

	@Override
	public List<ReviewBean> getMyReviewListLatest(String email) {
		return reviewDao.getMyReviewListLatest(email);
	}

	@Override
	public List<ReviewBean> getMyReviewList(ReviewParam param) {
		return reviewDao.getMyReviewList(param);
	}

	@Override
	public int getMyReviewCount(ReviewParam param) {
		return reviewDao.getMyReviewCount(param);
	}

	@Override
	public void deleteReview(int seq) {
		reviewDao.deleteReview(seq);
	}

	@Override
	public ReviewBean getReview(int seq) {
		return reviewDao.getReview(seq);
	}

	@Override
	public void updateReview(ReviewDto review) {
		reviewDao.updateReview(review);
	}
	
	
	
}
