package www.dream.com.chat.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import www.dream.com.chat.model.ChatVO;
import www.dream.com.chat.persistence.ChatMapper;

@Service
@AllArgsConstructor
@NoArgsConstructor
public class ChatService {
   @Autowired //
   private ChatMapper chatMapper;

   /* 최근 대화 내용 불러오기 */
   public List<ChatVO> getChatListByID(ChatVO chatVO) {
      return chatMapper.getChatListByID(chatVO);
   }

   /* 최근 100개 대화 내용 불러오기 */
   public List<ChatVO> getChatListByRecent(ChatVO chatVO) {
      return chatMapper.getChatListByRecent(chatVO);
   };
   
   /* 채팅방 내용 */
   public List<ChatVO> getChatBox(String userId) {
       List<ChatVO> chatList = new ArrayList<ChatVO>();
       chatList.addAll(chatMapper.getChatBox(userId));
       for (int i = 0; i < chatList.size(); i++) {
           ChatVO x = chatList.get(i);
           
           for (int j = 0; j < chatList.size(); j++) {
               ChatVO y = chatList.get(j);
               if (x.getFromID().equals(y.getToID()) && x.getToID().equals(y.getFromID())) {
            	   x.setChatTime(x.getChatTime());
            	   if (x.getChatID() < y.getChatID()) {
                       chatList.remove(x);
                       i--;
                       break;
                   } else {
                       chatList.remove(y);
                       j--;
                   }
               }
           }
       }
       return chatList;
   }

   // 읽지 않은 메시지 가져오기
   public int getUnreadChat(String toId) {
      return chatMapper.getUnreadChat(toId);
   }

   public int submit(ChatVO chatVO) {
      return chatMapper.submit(chatVO);
   }

   /* 읽은 메세지에 대해서 readCount를 1증가 */
   public void readChatUpdate(ChatVO chatVO) {
      chatMapper.readChatUpdate(chatVO);
   }
   
   public void deleteSugChat(ChatVO chatVO, String postId) {
	   chatMapper.deleteSugChat(chatVO, postId);
   }
}