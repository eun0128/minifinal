package com.petmeeting.joy.freeboard.model;

import java.io.Serializable;

public class FbParam implements Serializable {

	
	// search
		private String s_category;	// 제목, 내용, 작성자
		private String s_keyword;	// 검색어
		private String sorting;
		private String category;
		
		private String board_code;
		
		// paging
		private int pageNumber = 0;				// 현재 페이지
		private int recordCountPerPage = 10;	// 표현할 한 페이지의 글수
		
		// [1] -> 1 ~ 10 DB용
		private int start = 1;
		private int end = 10;

		
		public FbParam() {
		}


		public FbParam(String s_category, String s_keyword, String sorting, String category, int pageNumber,
				int recordCountPerPage, int start, int end) {
			super();
			this.s_category = s_category;
			this.s_keyword = s_keyword;
			this.sorting = sorting;
			this.category = category;
			this.pageNumber = pageNumber;
			this.recordCountPerPage = recordCountPerPage;
			this.start = start;
			this.end = end;
		}


		public String getS_category() {
			return s_category;
		}


		public void setS_category(String s_category) {
			this.s_category = s_category;
		}


		public String getS_keyword() {
			return s_keyword;
		}


		public void setS_keyword(String s_keyword) {
			this.s_keyword = s_keyword;
		}


		public String getSorting() {
			return sorting;
		}


		public void setSorting(String sorting) {
			this.sorting = sorting;
		}


		public String getCategory() {
			return category;
		}


		public void setCategory(String category) {
			this.category = category;
		}


		public int getPageNumber() {
			return pageNumber;
		}


		public void setPageNumber(int pageNumber) {
			this.pageNumber = pageNumber;
		}


		public int getRecordCountPerPage() {
			return recordCountPerPage;
		}


		public void setRecordCountPerPage(int recordCountPerPage) {
			this.recordCountPerPage = recordCountPerPage;
		}


		public int getStart() {
			return start;
		}


		public void setStart(int start) {
			this.start = start;
		}


		public int getEnd() {
			return end;
		}


		public void setEnd(int end) {
			this.end = end;
		}

		public String getBoard_code() {
			return board_code;
		}

		public void setBoard_code(String board_code) {
			this.board_code = board_code;
		}


		@Override
		public String toString() {
			return "FbParam [s_category=" + s_category + ", s_keyword=" + s_keyword + ", sorting=" + sorting
					+ ", category=" + category + ", pageNumber=" + pageNumber + ", recordCountPerPage="
					+ recordCountPerPage + ", start=" + start + ", end=" + end + "]";
		}


	
	
}
