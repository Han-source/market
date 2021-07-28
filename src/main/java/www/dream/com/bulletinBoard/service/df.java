package www.dream.com.bulletinBoard.service;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.IOUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class df {

	public static void main(String[] args) throws IOException {

		File file = new File("C:\\Users\\User\\Desktop\\a.png");
		DiskFileItem fileItem = new DiskFileItem("file", Files.probeContentType(file.toPath()), false, file.getName(), (int) file.length() , file.getParentFile());
		InputStream input = new FileInputStream(file);
		OutputStream os = fileItem.getOutputStream();
		IOUtils.copy(input, os);
			        
		MultipartFile multipartFile = new CommonsMultipartFile(fileItem);
		System.out.println(multipartFile.getOriginalFilename());

	}

}
