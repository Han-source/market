package www.dream.com.bulletinBoard.persistence;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import www.dream.com.bulletinBoard.model.BoardVO;
import www.dream.com.bulletinBoard.model.PostVO;
import www.dream.com.bulletinBoard.model.ReplyVO;
import www.dream.com.common.dto.Criteria;
import www.dream.com.party.model.Party;

// PostVO -> PostMapper 작성
public interface ReplyMapper { // 추후 Data를 가져오기 위해서 Interface -> Mapper 생성
	//LRCUD Data건수는 많으니까 long으로 int로 return하면 안됨
	/**--------------------------- 게시글 처리 함수 정의 영역------------------------- */
	/** public long  getTotalCount(@Param("boardId") int boardId, @Param("descrim") String descrim); 
	 * @param child */
	public long  getTotalCount(@Param("boardId") int boardId, @Param("child") int child);
	
	public long  getSearchTotalCount(@Param("boardId") int boardId,@Param("child") int child, @Param("cri") Criteria cri);
	
	public String getPostIdWithUserId(@Param("userId") String userId);
	
	/* Mapper에 들어가는 인자의 개수가 여러 개 일때는 필수적으로 @Param을 넣어줘야 합니다.
	 * 이를 실수하지 않기위하여 변수가 한 개여도 그냥 명시적으로 넣을 것 */
	public List<PostVO> getList(@Param("boardId") int boardId, @Param("child") int child, @Param("cri") Criteria cri); // 1. 새로운 함수 하나 만들어주기, PostMapper.xml 에서 Data 전달을 표현하기위한
	// xml에서 쓰이기 위해 @Param도 사용
	
	// 초기 화면 띄울때 활용 
	public List<PostVO> getListByHashTag(@Param("boardId") int boardId , @Param("child") int child, @Param("cri") Criteria cri);
	
	// id 값으로 Post및 Reply, Reply of Reply 객체 조회
	public PostVO findReplyById(@Param("id") String id, @Param("child") int child); // 조회
	
	public PostVO findProductById(@Param("productId") String id, @Param("child") int child);
	
	public PostVO findProductPurchaseRepresentById(@Param("productId") String id, @Param("child") int child);

	/**boardId, childBoardId, userId로 내가 장바구니에 담은 상품 조회 */
	public List<PostVO> findProductShoppingCart(@Param("userId") String userId);
	
	
	// boardId 값으로 Post및 Reply, Reply of Reply 객체 조회
	public List<PostVO> findReplyByBoardId(@Param("boardId") int boardId, @Param("child") int child); // 조회
	//상품 조회
	public List<PostVO> findProductList(@Param("boardId") int boardId, @Param("child") int child, @Param("cri") Criteria cri); // 조회
	// 상품 게시판에서 검색하는 것
	public List<PostVO> getProductListByHashTag(@Param("boardId") int boardId, @Param("child") int child, @Param("cri") Criteria cri);
	
	/** 조회수 증가 처리 */
	public int cntPlus(String id);
	
	/** ddl 좋아요 검사 테이블에 해당하는 값 넣기 */
	public int checkLike(@Param("id") String id, @Param("userId") String userId);
	public void upcheckLike(@Param("id") String id, @Param("userId") String userId);
	
	/** 좋아요 증가 처리 */
	public void uplike(String id);
	
	/** 좋아요 감소 처리 */
	public void downlike(@Param("id") String id);
	public int deleteCheckLike(@Param("id") String id, @Param("userId") String userId);	
	
	/** 게시글 실시간 좋아요 처리 */
	public int getLike(@Param("id") String id, @Param("userId") String userId);
	
	
	/** 게시글 등록 */
	public int insert(@Param("board") BoardVO board, @Param("child") int child, @Param("post") PostVO post);
	// PostVO를 객체로 받는 insert 함수 객체 이름은 post @Param의 이름도 "post" 그리고 BoardVO에서 board id를 가져온다. 

	public PostVO findPostById(String id);
	
	/** 게시글 수정 처리 */
	public int updatePost(PostVO post);
	
	/** id 값으로 Post 객체 삭제*/
	public int deleteReplyById(String id);
	
	// Manager Mode 일괄 삭제
	public void batchDeletePost(@Param("postIds") ArrayList<String> postIds);
	
	/**--------------------------- 댓글 처리 함수 정의 영역 06.10------------------------- */
	
	public int getAllReplyCount(@Param("replyId") String replyId,
			@Param("idLength") int idLength);
	
	public int getReplyCount(@Param("originalId") String originalId,
			@Param("idLength") int idLength);
	
	
	public List<ReplyVO> getReplyListWithPaging(@Param("originalId") String originalId,
			@Param("idLength") int idLength, @Param("cri") Criteria cri);
	
	/** 특정 댓글의 모든 후손 대댓글을 작성 순서에 따라 조회 해줍니다. */
	public List<ReplyVO> getReplyListOfReply(@Param("originalId")String originalId, @Param("idLength")int idLength);
	
	/* Id값으로 Post객체 조회*/
	public int insertReply(@Param("originalId") String originalId,@Param("reply") ReplyVO reply); // js에서 original이였음
	/* 댓글 수정 처리 */
	public int updateReply(ReplyVO reply);

	public List<PostVO> getFavorite(@Param("boardId")int boardId, @Param("curUser") Party curUser);
	
	/**-------------------------------카테고리 가져오기-----------------------------------*/
	public List<String> getCategoryList();
	
	/**-------------------------------경매 관련 함수-----------------------------------*/
}
