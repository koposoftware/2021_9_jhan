package com.tockTalk.service.member;

import java.util.List;

import com.tockTalk.domain.AccountVO;
import com.tockTalk.domain.MemberVO;
import com.tockTalk.domain.PageVO;
import com.tockTalk.domain.ReportVO;
import com.tockTalk.domain.StockVO;
import com.tockTalk.domain.WatchVO;

public interface MemberServiceRule {
	public int join(MemberVO mvo);
	public int chkEmail(String email);
	public MemberVO login(MemberVO mvo);
	public int chkTester(String email);
	
	public String chkDeposit(String email); 
	public List<AccountVO> chk_h_list(String email);
	public void updatePrice(List<StockVO> s_list);
	public List<StockVO> chk_w_list(String email);
	public int hasWatchList(String email);
	public int hasHoldList(String email);
	
	public List<WatchVO> getWatchList(String email);
	public int inYourWatchList(String email, String symbol);
	
	public List<ReportVO> getReportList();
	public int deleteReport_all(int cNum);
	public int deleteReport_one(int reportNum);
	public int getReportCnt(PageVO pgvo);
	
	public AccountVO getSpecificSymbol(String keyword, String email);
	public StockVO getSpecificSymbol_new(String keyword);
	
	public int newBuy(AccountVO avo);
	public int additionalBuy(AccountVO new_avo);
	public int sell(AccountVO avo);
	public String getEncPwd(MemberVO mvo);
	public String getUserName(MemberVO mvo);
	
}
