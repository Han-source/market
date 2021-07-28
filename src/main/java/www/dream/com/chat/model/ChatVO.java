package www.dream.com.chat.model;

import java.util.Date;

import lombok.Data;

@Data
public class ChatVO {
   
   private int chatID;
   private String fromID;
   private String toID;
   private String chatContent;
   private Date chatTime;
   private int chatRead;
   
}