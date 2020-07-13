package kh.pingpong.controller;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kh.pingpong.dao.FileDAO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.FilesDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.NewsDTO;

@Controller
@RequestMapping("file")
public class FileController {
	
	@Autowired
	public HttpSession session;
	
	@Autowired
	public FileDAO fdao = new FileDAO();
	
	/* 맴버 파일 업로드 */
	public FileDTO fileOneInsert(MemberDTO mdto, FileDTO fdto, String realPath) throws Exception{
		
		MultipartFile profile = mdto.getProfile();
		
		System.out.println(realPath + " :: 리얼패스");
		File filePath = new File(realPath);
		
		//폴더 존재여부
		if(!filePath.exists()) {
			filePath.mkdirs(); //하위폴더를 만들려고 했는데 상위폴더가 없어! 그럼 자동으로 만들어줌			
		}
		
		//현재시간
		String write_date = new SimpleDateFormat("YYYY-MM-dd-ss").format(System.currentTimeMillis());
		
		/* 하드디스크 파일 업로드 */		
		fdto.setOriname(profile.getOriginalFilename());
		fdto.setSysname(write_date + "_" + profile.getOriginalFilename());
		fdto.setRealpath(realPath + fdto.getSysname());
		fdto.setCategory(fdto.getCategory());
		String systemFileName = write_date +"_"+fdto.getOriname(); 
		
		//파일을 저장하기 위한 파일 객체 생성
		File fileDownload = new File(realPath + "/" + systemFileName);		
		profile.transferTo(fileDownload); //파일 저장
		
		//MemberDTO
		mdto.setProfile(profile);
		
		return fdto;
	}	
	
	/* news 썸네일 파일 업로드 */
	public FileDTO newsFileOneInsert(NewsDTO ndto, FileDTO ftndto, String realPath) throws Exception{
		
		MultipartFile thumbnail = ndto.getThumbnail();
		
		//System.out.println(realPath + " :: 리얼패스");
		File filePath = new File(realPath);
		
		//폴더 존재여부
		if(!filePath.exists()) {
			filePath.mkdirs(); //하위폴더를 만들려고 했는데 상위폴더가 없어! 그럼 자동으로 만들어줌			
		}
		
		//현재시간
		String write_date = new SimpleDateFormat("YYYY-MM-dd-ss").format(System.currentTimeMillis());
		
		
		System.out.println(thumbnail.getOriginalFilename());
		/* 하드디스크 파일 업로드 */		
		ftndto.setOriname(thumbnail.getOriginalFilename());
		ftndto.setSysname(write_date + "_" + thumbnail.getOriginalFilename());
		ftndto.setRealpath(realPath + ftndto.getSysname());
		ftndto.setCategory("news_thumb");
		String systemFileName = write_date +"_"+ftndto.getOriname(); 
		
		//파일을 저장하기 위한 파일 객체 생성
		File fileDownload = new File(realPath + "/" + systemFileName);		
		thumbnail.transferTo(fileDownload); //파일 저장
		
		return ftndto;
	}
	
	/* news 파일 업로드 */
	public List<FileDTO> newsFileInsert(FilesDTO fsdto, String realPath) throws Exception{
		
		System.out.println(realPath + " :: 리얼패스");
		File filePath = new File(realPath);
		
		//폴더 존재여부
		if(!filePath.exists()) {
			filePath.mkdirs(); //하위폴더를 만들려고 했는데 상위폴더가 없어! 그럼 자동으로 만들어줌			
		}
		
		/* 파일 업로드 */
		List<FileDTO> filelist = new ArrayList<FileDTO>();
		if(fsdto.getFiles().length != 0) {
			int count = 0;
			for(MultipartFile file : fsdto.getFiles()) {				
				if(!file.isEmpty()) {
					FileDTO singlefdto = new FileDTO();
					String write_date = new SimpleDateFormat("YYYY-MM-dd-ss").format(System.currentTimeMillis());
					
					/* 하드디스크 파일 업로드 */		
					singlefdto.setOriname(file.getOriginalFilename());
					singlefdto.setSysname(write_date + "_"+"("+(++count)+")" + file.getOriginalFilename());
					System.out.println("카운트 들어오나 ? " + count);
					singlefdto.setRealpath(realPath + file.getOriginalFilename());
					singlefdto.setCategory("news");
					String systemFileName = write_date + "_"+"("+(count)+")" + file.getOriginalFilename(); 
					
					File fileDownload = new File(realPath + "/" + systemFileName);
					file.transferTo(fileDownload);
					filelist.add(singlefdto);
					
				}				
			}
		}		
		return filelist;
	}
	
	//뉴스 파일 다운로드
	@RequestMapping("downloadFile")
	public void downloadFile(NewsDTO ndto, HttpServletResponse resp) throws Exception{
		FileDTO fdto = fdao.downloadFile(ndto);
		String filePath = session.getServletContext().getRealPath("upload/news/files/");
		
		File target = new File(filePath + "/"+ fdto.getSysname()); // 서버경로
		System.out.println(target);
		
		try(	DataInputStream dis = new DataInputStream(new FileInputStream(target));
				ServletOutputStream sos = resp.getOutputStream();
				){
			String fileName = new String (fdto.getOriname().getBytes("utf-8"),"iso-8859-1");
			
			byte[] fileContents = new byte[(int)target.length()];
			dis.readFully(fileContents);
			
			resp.reset();
			resp.setContentType("application/pctet-stream");
			resp.setHeader("Content-disposition", "attachment;filename=" + fileName + ";");
			
			sos.write(fileContents);
			sos.flush();
		}
		
	}
	

}
