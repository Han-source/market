package www.dream.com.chat.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import www.dream.com.chat.model.ChatVO;

/**
 * Mybatis를 활용하여 Party 종류의 객체를 관리하는 인터페이스
 * @author Park
 *
 */
public interface ChatMapper { 


   // 개별 객체 조회
   public List<ChatVO> getChatListByID(@Param("chat") ChatVO chatVO);
   public List<ChatVO> getChatListByRecent(@Param("chat") ChatVO chatVO);
   
   //채팅창 목록 조회
   public List<ChatVO> getChatBox(@Param("userId") String userId);
   //읽지 않은 메시지 가져오기
   public int getUnreadChat(String toId);
   
   // Insert
   public int submit(@Param("chat") ChatVO chatVO);
   
   // Update
   /*읽은 메세지에 대해서 readCount를 1증가*/
   public void readChatUpdate(@Param("chat") ChatVO chatVO);
   
   // Delete
   /*수락 or 거절을 눌렀을때 해당 메세지 지우기*/
   public void deleteSugChat(@Param("chat") ChatVO chatVO, @Param("postId") String postId);
   
}