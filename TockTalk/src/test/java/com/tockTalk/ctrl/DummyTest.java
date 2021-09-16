package com.tockTalk.ctrl;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.tockTalk.domain.StockVO;
import com.tockTalk.domain.WatchVO;
import com.tockTalk.persistence.member.MemberDAORule;
import com.tockTalk.persistence.stock.StockDAORule;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class DummyTest {
		
	@Inject
	private MemberDAORule mdao;
	
	@Test
	public void test() throws Exception {
		String email = "dybe15@naver.com";
		List<WatchVO> wlist = mdao.chk_w_list(email);
	}
}
