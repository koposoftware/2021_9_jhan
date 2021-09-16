package com.tockTalk.persistence.stock;

import java.util.List;

import com.tockTalk.domain.AccountVO;
import com.tockTalk.domain.EarningVO;
import com.tockTalk.domain.PageVO;
import com.tockTalk.domain.StockVO;
import com.tockTalk.domain.WatchVO;

public interface StockDAORule {

	public int insert(StockVO svo);
	public int insert(EarningVO evo);
	public int createRawData(String symbol);

	public List<StockVO> selectList(PageVO pgvo);
	public StockVO selectOne(String symbol);

	public List<EarningVO> getEarningList(String symbol);
	
	public int selectOne(PageVO pgvo);
	
	public int updatePrice(StockVO svo);
	public int updatePrice(AccountVO avo);
	public int insert(WatchVO wvo);
	public int remove(WatchVO wvo);
	
	public List<StockVO> getStockList();
	public int hasSymbol(String symbol);
}
