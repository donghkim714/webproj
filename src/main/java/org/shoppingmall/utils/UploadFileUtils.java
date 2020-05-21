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
		
		String thumbFileName = "s_" + newFileName;
		
		File image = new File(imgPath + "/" + newFileName);
		File thumbnail = new File(imgPath + "/" + "s" + "/" + thumbFileName);
		
		if(image.exists()) {
			thumbnail.getParentFile().mkdirs();
			Thumbnails.of(image).size(THUMB_WIDTH, THUMB_HEIGHT).toFile(thumbnail);
		}
		return newFileName;
	}
	
	public static String calcPath(String uploadPath) {
									
		Calendar cal = Calendar.getInstance();
		String yearPath = Integer.toString(cal.get(Calendar.YEAR));
		String monthPath = yearPath + "/" + new DecimalFormat("00").format(cal.get(Calendar.MONTH));
		String datePath = monthPath + "/" + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		log.info("datePath : " + datePath);
		makeDir(uploadPath,  "/" + yearPath, "/" +  monthPath, "/" + datePath);
		makeDir(uploadPath,  "/" + yearPath, "/" +  monthPath, "/" + datePath + "\\s");
		
		return datePath;
	}
	
	private static void makeDir(String uploadPath, String... paths) {
													
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
