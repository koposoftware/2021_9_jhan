package com.tockTalk.service.stock;

import java.util.List;

import com.tockTalk.domain.AccountVO;
import com.tockTalk.domain.EarningVO;
import com.tockTalk.domain.PageVO;
import com.tockTalk.domain.StockVO;
import com.tockTalk.domain.WatchVO;

public interface StockServiceRule {
  public int register(StockVO svo);
  public int register(EarningVO evo);
  
  public List<StockVO> getList(PageVO pgvo);
  public StockVO detail(String symbol);
  
  public List<EarningVO> getEarningList(String symbol);
  
  public int getTotalCnt(PageVO pgvo);
  
  public int update(StockVO svo);
  public int update(AccountVO avo);
  
  public int insert(WatchVO wvo);
  public int delete(WatchVO wvo);
  
  public List<StockVO> getStockList();
  public int hasSymbol(String symbol);
}