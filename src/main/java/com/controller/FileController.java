package com.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.entity.Employees;
import com.service.EmpLoyeeService;
import com.service.FileService;

import tools.Auth;

@Controller
@RequestMapping("/file")
public class FileController {

	@Autowired
	private FileService fileService;
	@Autowired
	private EmpLoyeeService eService;

	@RequestMapping("/show")
	@Auth("least")
	public String testShow() {
		return "fileUpload";

	}

	@RequestMapping("/fileUpload")
	@Auth("least")
	public String fileUpload(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request,
			ModelMap model, int fileTo, String fileText) {

		String fileName = file.getOriginalFilename();
		System.out.println("文件名:" + fileName);

		String newFileName = (int) (Math.random() * 999 + 10) + fileName;
		System.out.println(newFileName);
		ServletContext sc = request.getSession().getServletContext();
		String path = sc.getRealPath("/upload") + "/";
		File f = new File(path);
		if (!f.exists())
			f.mkdirs();
		if (!file.isEmpty()) {
			try {
				FileOutputStream fos = new FileOutputStream(path + newFileName);
				InputStream in = file.getInputStream();
				int b = 0;
				while ((b = in.read()) != -1) {
					fos.write(b);
				}
				fos.close();
				in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("文件保存地址:" + path + newFileName);
		com.entity.File fileUpload = new com.entity.File();
		Employees user = (Employees) request.getSession().getAttribute("user");
		Employees employees1 = eService.getEmployeesByID(user.getEmployeeId());
		Employees employees2 = new Employees();
		employees2.setEmployeeId(fileTo);
		fileUpload.setEmployeesByFileFrom(employees1);
		fileUpload.setEmployeesByFileTo(employees2);
		fileUpload.setFileName(newFileName);
		fileUpload.setFileText(fileText);
		fileUpload.setFileTime(new Date());
		fileService.addFile(fileUpload);
		return "redirect:show";
	}

	@RequestMapping("/getFiles")
	@ResponseBody
	public List<com.entity.File> getFiles(HttpServletRequest request) {
		Employees user = (Employees) request.getSession().getAttribute("user");
		int employeeId = user.getEmployeeId();
		List<com.entity.File> list = fileService.getFiles(employeeId);
		return list;
	}

	@RequestMapping("/download")
	@Auth("least")
	public String download(String fileName, HttpServletRequest request, HttpServletResponse response) {
		try {
			fileName = URLDecoder.decode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println(fileName);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
		try {

			ServletContext sc = request.getSession().getServletContext();
			String path = sc.getRealPath("/upload");

			InputStream inputStream = new FileInputStream(new File(path + File.separator + fileName));

			OutputStream os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = inputStream.read(b)) > 0) {
				os.write(b, 0, length);
			}

			os.close();

			inputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	public void addFile(File file) {

	}

	@RequestMapping("/delete")
	@ResponseBody
	public String deleteFileById(int fileId, String fileName, HttpServletRequest request) {
		ServletContext sc = request.getSession().getServletContext();
		String path = sc.getRealPath("/upload");

		File file = new File(path + File.separator + fileName);

		if (file.isFile() && file.exists()) {
			file.delete();
		}
		fileService.deleteFileById(fileId);
		return "success";
	}
}
