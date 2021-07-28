package www.dream.com.bulletinBoard.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

public class hi {

	public static void main(String[] args) throws FileNotFoundException, IOException {
		MultipartFile multipartFile = new MockMultipartFile("a.jpg", new FileInputStream(new File("C:\\Users\\User\\Desktop\\a.png")));
		
		System.out.println(multipartFile.getOriginalFilename().toString());
		System.out.println("z");
	}

}
