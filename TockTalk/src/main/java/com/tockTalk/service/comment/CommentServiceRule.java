package com.tockTalk.service.comment;

import java.util.List;

import com.tockTalk.domain.CommentVO;
import com.tockTalk.domain.ReportVO;

public interface CommentServiceRule {
	public int insert(CommentVO cvo);
	public List<CommentVO> getList(String symbol);
	public int t_up(int cNum, String writer);
	public int delete(int cNum);
	public int report(ReportVO rvo);
	public CommentVO getReportedComment(int cNum);
}
