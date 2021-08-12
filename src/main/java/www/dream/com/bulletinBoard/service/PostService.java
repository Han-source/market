package www.dream.com.bulletinBoard.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.IOUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import www.dream.com.bulletinBoard.model.BoardVO;
import www.dream.com.bulletinBoard.model.PostVO;
import www.dream.com.bulletinBoard.persistence.ReplyMapper;
import www.dream.com.common.attachFile.model.AttachFileVO;
import www.dream.com.common.attachFile.persistence.AttachFileVOMapper;
import www.dream.com.common.dto.Criteria;
import www.dream.com.framework.lengPosAnalyzer.PosAnalyzer;
import www.dream.com.hashTag.service.HashTagService;
import www.dream.com.party.model.Party;

// 1. 홈페이지에서 Service를 제공하는 부분

@Service // 2. 서비스 부분은 @Service 달기, 이건 Control또한 맟찬가지
// 3. 그리고 root-context에 scan 부분 추가해주고
// 4.  BoardVO에서 가져올 Board 목록을 보여주는getList 함수 작성
/**
 * 이는 ReplyVo와 PostVO의 Class 설계도를 기반으로 하는 것이며 해당 Table을 Top 전략으로 통합하여 만들었기에
 * ReplyMapper는 통합해 놓았다. 그리고 PostService를 ReplyService와 분리하고
 */
public class PostService {
	@Autowired
	private ReplyMapper replyMapper;

	@Autowired
	private HashTagService hashTagService;

	@Autowired
	private AttachFileVOMapper attachFileVOMapper;

	// post번호 가져오기
	public String getPostIdWithUserId(@Param("userId") String userId) {
		return replyMapper.getPostIdWithUserId(userId);
	};

	// 이전 버전에 있던 getTotalCount getList 함수는 더이상 사용하지 않음 06.07

	// 이전 버전에 있던 getTotalCount getList 함수는 더이상 사용하지 않음 06.07
	   public List<PostVO> getListByHashTag(Party curUser, int boardId, int child, Criteria cri){
	      if (cri.hasSearching()) {
	         String[] searchingHashtags = cri.getSearchingHashtags();
	         if (curUser != null) {
	            mngPersonalSearFavorite(curUser, searchingHashtags);
	         }
	         return replyMapper.getListByHashTag(boardId, child, cri);
	      } else if (cri.getListFromLike() == 1){
	         return replyMapper.getListFromLike(boardId, child, cri);   //좋아요순의 따른 게시글 보여주기
	      } else {
	         return replyMapper.getList(boardId, child, cri);         //전체글 보여주기
	      }
	   }

	public long getSearchTotalCount(int boardId, int child, Criteria cri) {

		if (cri.hasSearching()) {
			return replyMapper.getSearchTotalCount(boardId, child, cri);
		} else {
			// return postMapper.getTotalCount(boardId, PostVO.DESCRIM4POST);
			return replyMapper.getTotalCount(boardId, child);
		}
	}
	
	public long getProductSearchTotalCount(int boardId, int child, Criteria cri) {

	      if (cri.hasSearching()) {
	         return replyMapper.getSearchTotalCount(boardId, child, cri);
	      } else {
	         // return postMapper.getTotalCount(boardId, PostVO.DESCRIM4POST);
	         return replyMapper.getProductTotalCount(boardId, child);
	      }
	   }

	/** id 값으로 Post 객체 조회 */
	public PostVO findPostById(String id, int child) {
		return (PostVO) replyMapper.findReplyById(id, child);
	}

	public List<PostVO> findReplyByBoardId(int boardId, int child) {
		return replyMapper.findReplyByBoardId(boardId, child);
	}

	public List<PostVO> findProductList(Party curUser, int boardId, int child, Criteria cri) {
	      if (cri.hasSearching()) {
	         String[] searchingHashtags = cri.getSearchingHashtags();
	         if (curUser != null) {
	            mngPersonalSearFavorite(curUser, searchingHashtags);
	         }
	         return replyMapper.getProductListByHashTag(boardId, child, cri);
	      } else if (cri.getFindSelledProdutList() == 1) {
	         return replyMapper.getfindSelledProdutList(boardId, cri);      //거래완료된 글
	      } else {
	         return replyMapper.findProductList(boardId, child, cri);   //거래중인 글 
	      }   
	   }

	/** boardId, childBoardId, userId로 내가 장바구니에 담은 상품 조회 */
	public List<PostVO> findProductShoppingCart(String userId) {
		return replyMapper.findProductShoppingCart(userId);
	}

	/**
	 * 게시글 수정 처리 첨부 파일 정보
	 * 
	 * @param post
	 * @return
	 * @throws IOException
	 */
	@Transactional
	public int insert(BoardVO board, int child, PostVO post) throws IOException {
		int affectedRows = replyMapper.insert(board, child, post); // 게시글 자체를 등록
		Map<String, Integer> mapOccur = PosAnalyzer.getHashTags(post); // 06.01에 만든 PosAnalyzer FrameWork
		// 수 많은 단어가 들어왔는데, 기존의 단어와 새롭게 들어올 단어를 분리해야할것 같음
		hashTagService.CreateHashTagAndMapping(post, mapOccur);
		// 최악을 고려해야 고품질의 코드를 만들어낼 수있다.

		// 첨부 파일 정보도 관리를 해야합니다. 고성능
		List<AttachFileVO> listAttach = post.getListAttach();
		if (listAttach != null && !listAttach.isEmpty()) {
			attachFileVOMapper.insertAttachFile2PostId(post.getId(), listAttach);
		}
		return affectedRows;
	}

	public static String getFolderName() {
		SimpleDateFormat simpledf = new SimpleDateFormat("yyyy-MM-dd");
		return simpledf.format(new Date()).replace('-', File.separatorChar); // 문자의 자료형으로 replace
	}
	// 06.04 검색기능을 추가한 화면을 만들기 위해서 새로운 기능 선언

	/** 게시글 수정 처리 */
	// boolean은 if처리를 하기때문에 변경해준것
	@Transactional
	public boolean updatePost(PostVO post) {
		attachFileVOMapper.delete(post.getId());
		// 첨부파일 정보고 관리 합니다.
		List<AttachFileVO> listAttach = post.getListAttach();
		if (listAttach != null && !listAttach.isEmpty()) {
			attachFileVOMapper.insertAttachFile2PostId(post.getId(), listAttach);
		}

		hashTagService.deleteMap(post);
		Map<String, Integer> mapOccur = PosAnalyzer.getHashTags(post);
		hashTagService.CreateHashTagAndMapping(post, mapOccur);

		return replyMapper.updatePost(post) == 1;
	}

	/** id 값으로 Post 객체 삭제 */
	@Transactional
	public boolean deletePostById(String id) { // int -> boolean 변경 Redirect 하기위해서
		PostVO post = new PostVO();
		post.setId(id);
		hashTagService.deleteMap(post);
		attachFileVOMapper.delete(id);
		return replyMapper.deleteReplyById(id) == 1; // == 1 추가
	}

	// 기존 단어와 신규 단어로 분할
	// 기존 단어는 활용 횟수 올리기

	private void mngPersonalSearFavorite(Party curUser, String[] searchingHashtags) {
		Map<String, Integer> mapOccur = new HashMap<>();

		Arrays.stream(searchingHashtags).forEach(word -> {
			mapOccur.put(word, 1);
		});

		hashTagService.mngHashTagAndMapping(curUser, mapOccur);

		hashTagService.CreateHashTagAndMapping(curUser, mapOccur);
	}

	/* 게시글 조회수 증가 처리 */
	public int cntPlus(String id) {
		return replyMapper.cntPlus(id);
	}

	/** ddl 좋아요 검사 테이블에 해당하는 값 넣기 */
	public int checkLike(String id, String userId) {
		return replyMapper.checkLike(id, userId);
	}

	public void upcheckLike(String id, String userId) {
		replyMapper.upcheckLike(id, userId);
	}

	/* 좋아요 증가 및 감소 처리 */
	public void uplike(String id) {
		replyMapper.uplike(id);
	}

	public void deleteCheckLike(String id, String userId) {
		replyMapper.deleteCheckLike(id, userId);
	}

	public void downlike(String id) {
		replyMapper.downlike(id);
	}

	/** 게시글 실시간 좋아요 처리 */
	public int getLike(String id, String userId) {
		return replyMapper.getLike(id, userId);
	}

	// Manager Mode Delete
	public void batchDeletePost(ArrayList<String> postIds) {
		replyMapper.batchDeletePost(postIds);
	}
}
