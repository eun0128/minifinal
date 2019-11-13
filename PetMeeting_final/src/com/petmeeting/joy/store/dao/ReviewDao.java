package com.petmeeting.joy.store.dao;

import java.util.List;

import com.petmeeting.joy.store.model.ReviewBean;
import com.petmeeting.joy.store.model.ReviewDto;
import com.petmeeting.joy.store.model.ReviewParam;

public interface ReviewDao {
	/**
	 * 리뷰쓰기 메소드
	 */
	public void writeReview(ReviewDto review);
	
	/**
	 * 상품의 평점 평균을 구하는 메소드
	 */
	public double getReviewScoreAvg(String pcode);
	
	/**
	 * 상품의 리뷰 리스트를 가져오는 메소드
	 */
	public List<ReviewBean> getReviewList(ReviewParam param);
	
	/**
	 * 상품의 리뷰 리스트 카운트
	 */
	public int getReviewCount(ReviewParam param);
	
	/**
	 * 나의 최근 작성 5개 리뷰를 가져오는 메소드
	 */
	public List<ReviewBean> getMyReviewListLatest(String email);
	
	/**
	 * 나의 리뷰리스트 가져오기
	 */
	public List<ReviewBean> getMyReviewList(ReviewParam param);
	
	/**
	 * 나의 리뷰리스트 카운트
	 */
	public int getMyReviewCount(ReviewParam param);
	
	/**
	 * 리뷰 삭제하기
	 */
	public void deleteReview(int seq);
	
	/**
	 * 시퀀스로 리뷰 정보 불러오기
	 */
	public ReviewBean getReview(int seq);
	
	/**
	 * 리뷰 업데이트
	 */
	public void updateReview(ReviewDto review);
}
