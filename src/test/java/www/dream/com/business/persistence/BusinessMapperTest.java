package www.dream.com.business.persistence;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import www.dream.com.bulletinBoard.model.PostVO;
import www.dream.com.bulletinBoard.service.PostService;
import www.dream.com.business.model.ProductVO;
import www.dream.com.common.dto.Criteria;
import www.dream.com.party.model.Member;
import www.dream.com.party.model.Party;

// 17. Test를 하기위한 @의 모임. 
@RunWith(SpringJUnit4ClassRunner.class) // 5. test 하기위해서 아까했던 TestDI를 가져오고
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
//0521 Board의 속성 Data 값을 확인하기 위한 Junit Test

/**
 * JUnit Test를 할때, 함수의 선언 결과가 오름차순 순으로 정렬이 되어 출력이 된다.
 * 그래서 밑에 testgetB , testgetL B가 더 높기때문에 B쪽 함수가 먼저 출력됨.
 * @author Park
 */
public class BusinessMapperTest { 
	
	@Autowired // . 
	private BusinessMapper businessMapper;  // 
	@Autowired
	private PostService postService;
	@Test
	public void testgetList() {
		assertNotNull(businessMapper); // 
		try {
			ProductVO pro = new ProductVO();
//			pro.setId(5);
//			pro.setParentId(4);
//			pro.setUserId("addr");
			pro.setProductPrice(1000);
			PostVO post12 = new PostVO();
			Party pa = new Member();
			pa.setUserId("addr");
			post12.setWriter(pa);
			post12.setTitle("hi");
			post12.setContent("에이치아이");
//			businessMapper.insertCommonProduct(pro, post12, 4, 7);
		} catch(Exception e) {
			e.printStackTrace(); // 
		}
	}
	
	@Test
	public void testgetSearchList() {
		assertNotNull(businessMapper); // 
		try {
			ProductVO pro = new ProductVO();
			pro.setId(5);
			pro.setParentId(4);
			pro.setUserId("addr");
			pro.setProductPrice(1000);
			PostVO post12 = new PostVO();
			Party pa = new Member();
			pa.setUserId("addr");
			post12.setWriter(pa);
			post12.setTitle("hi");
			post12.setContent("에이치아이");
//			businessMapper.insertCommonProduct(pro, post12, 4, 7);
			Criteria userCriteria = new Criteria();
			userCriteria.setAmount(10);
			userCriteria.setEndPage(0);
			userCriteria.setNext(false);
			userCriteria.setPageNumber(1);
			userCriteria.setPrev(false);
			userCriteria.setSearching("즐라탄");
			userCriteria.setStartPage(0);
			userCriteria.setTotal(0);
			List<PostVO> a = postService.findProductList(null, 4, 5, userCriteria);
			for(PostVO p : a  ) {
				System.out.println(p.getListAttach());
			}
		} catch(Exception e) {
			e.printStackTrace(); // 
		}
	}
	
	

}
