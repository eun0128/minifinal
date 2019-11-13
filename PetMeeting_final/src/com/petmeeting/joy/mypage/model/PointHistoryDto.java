package com.petmeeting.joy.mypage.model;

import java.io.Serializable;

/*

CREATE TABLE PM_POINT_HISTORY(
   EMAIL VARCHAR2(50), --유저이메일
   USEDINFO VARCHAR2(50),   --적립/사용 내용(후원, 출석이벤트, 프로필등록, 펫프로필등록)
   USEPOINT NUMBER,   --적립/사용 포인트
   RESULTPOINT NUMBER,   --적립/사용 결과 잔여포인트
   REGDATE DATE,   --변동기록일자(연월일)
   USEDTYPE NUMBER   --적립 0 , 사용 1
);
*/
public class PointHistoryDto implements Serializable{
   
   private String email;
   private String usedinfo;
   private int usepoint;
   private int resultpoint;
   private String regdate;
   private int usedtype;
   
   public PointHistoryDto(){  
	   
   }

   public PointHistoryDto(String email, String usedinfo, int usepoint, int resultpoint, String regdate,
         int usedtype) {
      super();
      this.email = email;
      this.usedinfo = usedinfo;
      this.usepoint = usepoint;
      this.resultpoint = resultpoint;
      this.regdate = regdate;
      this.usedtype = usedtype;
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public String getusedinfo() {
      return usedinfo;
   }

   public void setusedinfo(String usedinfo) {
      this.usedinfo = usedinfo;
   }

   public int getUsepoint() {
      return usepoint;
   }

   public void setUsepoint(int usepoint) {
      this.usepoint = usepoint;
   }

   public int getResultpoint() {
      return resultpoint;
   }

   public void setResultpoint(int resultpoint) {
      this.resultpoint = resultpoint;
   }

   public String getRegdate() {
      return regdate;
   }

   public void setRegdate(String regdate) {
      this.regdate = regdate;
   }

   public int getUsedtype() {
      return usedtype;
   }

   public void setUsedtype(int usedtype) {
      this.usedtype = usedtype;
   }

   @Override
   public String toString() {
      return "PointHIstoryParam [email=" + email + ", usedinfo=" + usedinfo + ", usepoint=" + usepoint
            + ", resultpoint=" + resultpoint + ", regdate=" + regdate + ", usedtype=" + usedtype + "]";
   }
   

}