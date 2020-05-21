package org.shoppingmall.utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import jdk.internal.jline.internal.Log;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Log4j
public class UploadFileUtils {
	static final int THUMB_WIDTH = 300;
	static final int THUMB_HEIGHT = 300;
	
	public static String fileUpload(String uploadPath, String fileName, byte[] fileData, String ymdPath) throws Exception {
		UUID uid = UUID.randomUUID();
		
		String newFileName = uid + "_" + fileName;
		String imgPath = uploadPath + "/" + ymdPath;
		
		File target = new File(imgPath, newFileName);
		FileCopyUtils.copy(fileData, target);
		//fileData를 지정한 target에 복사.
		//FileCopyUtils : 파일 및 스트림 복사를 위한 유틸리티 메소드 집합체
		//사용후에 스트림을 무조건 닫음.
		
		String thumbFileName = "s_" + newFileName;
									//uid + fileName
		
		File image = new File(imgPath + "/" + newFileName);
										//\\의 의미
		File thumbnail = new File(imgPath + "/" + "s" + "/" + thumbFileName);
		
		if(image.exists()) {
			thumbnail.getParentFile().mkdirs();
			Thumbnails.of(image).size(THUMB_WIDTH, THUMB_HEIGHT).toFile(thumbnail);
		}
		return newFileName;
	}
	
	public static String calcPath(String uploadPath) {
										//C://imgUpload
		Calendar cal = Calendar.getInstance();
		String yearPath = Integer.toString(cal.get(Calendar.YEAR));
// 							year
		String monthPath = yearPath + "/" + new DecimalFormat("00").format(cal.get(Calendar.MONTH));
// 							year\\month
		String datePath = monthPath + "/" + new DecimalFormat("00").format(cal.get(Calendar.DATE));
//							year\\month\\date
		log.info("datePath : " + datePath);
		makeDir(uploadPath,  "/" + yearPath, "/" +  monthPath, "/" + datePath);
		makeDir(uploadPath,  "/" + yearPath, "/" +  monthPath, "/" + datePath + "\\s");
		
		return datePath;
	}
	
	private static void makeDir(String uploadPath, String... paths) {
													//String형의 파라메터를 몇개를 받아도 처리가능.
		if(new File(paths[paths.length -1]).exists()) {
			return;
		}
		
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			if(!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
}
