package www.dream.com.chat.service;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import www.dream.com.chat.model.ChatVO;
import www.dream.com.party.model.Party;

@Service
@AllArgsConstructor
@NoArgsConstructor
public class ChatMethode {
   @Autowired // 10. Autowired @ 생성
   private ChatService chatService;
   
   public String getChatList(ChatVO chat, Party curUser) {
      StringBuffer result = new StringBuffer("");
      // json 형태
      result.append("{\"result\":[");
      List<ChatVO> chatList = chatService.getChatListByRecent(chat);
      SimpleDateFormat SDF = new SimpleDateFormat("MM월dd일 a h:mm");
      if (chatList.size() == 0)
         return "";
      for (int i = 0; i < chatList.size(); i++) {
         result.append("[{\"value\": \"" + chatList.get(i).getFromID() + "\"},");
         result.append("{\"value\": \"" + chatList.get(i).getToID() + "\"},");
         if (curUser.getUserId() == chatList.get(i).getFromID()) {
            result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
         }else {
            result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
         }
         result.append("{\"value\": \"" + SDF.format(chatList.get(i).getChatTime()) + "\"}]");
         // 마지막 원소가 아니라면 다음 원소가 있다는 것을 알려준다.
         if (i != chatList.size() - 1)
            result.append(",");
      }
      result.append("], \"last\":\"" + chatList.get(chatList.size() - 1).getChatID() + "\"}");
      chatService.readChatUpdate(chat);
      return result.toString();
   }
   
   
   // 메시지의 리스트의 결과를 바로 출력
      public String getChatBox(String userId) {
         StringBuffer result = new StringBuffer("");
         SimpleDateFormat SDF = new SimpleDateFormat("MM월dd일 a h:mm");
         // json 형태
         result.append("{\"result\":[");
         List<ChatVO> chatList = chatService.getChatBox(userId);
         if (chatList.size() == 0)
            return "";
         for (int i = 0; i < chatList.size(); i++) {
            result.append("[{\"value\": \"" + chatList.get(i).getFromID() + "\"},");
            result.append("{\"value\": \"" + chatList.get(i).getToID() + "\"},");
            result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
            result.append("{\"value\": \"" + SDF.format(chatList.get(i).getChatTime()) + "\"}]");
            // 마지막 원소가 아니라면 다음 원소가 있다는 것을 알려준다.
            if (i != chatList.size() - 1)
               result.append(",");
         }
         result.append("], \"last\":\"" + chatList.get(chatList.size() - 1).getChatID() + "\"}");
         return result.toString();
      }
}