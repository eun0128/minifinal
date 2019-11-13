package com.petmeeting.joy.store.service;

import java.util.List;

import com.petmeeting.joy.store.model.ReviewBean;
import com.petmeeting.joy.store.model.ReviewDto;
import com.petmeeting.joy.store.model.ReviewParam;

public interface ReviewService {

	public void writeReview(ReviewDto review);
	
	public double getReviewScoreAvg(String pcode);
	
	public List<ReviewBean> getReviewList(ReviewParam param);

	public int getReviewCount(ReviewParam param);
	
	public List<ReviewBean> getMyReviewListLatest(String email);
	
	public List<ReviewBean> getMyReviewList(ReviewParam param);
	
	public int getMyReviewCount(ReviewParam param);
	
	public void deleteReview(int seq);
	
	public ReviewBean getReview(int seq);
	
	public void updateReview(ReviewDto review);
	
}
