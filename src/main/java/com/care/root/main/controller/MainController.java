package com.care.root.main.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.care.root.common.sessionName.SessionCommonName;
import com.care.root.main.dto.MainDTO;
import com.care.root.main.dto.MyListDTO;
import com.care.root.main.dto.ReplyDTO;
import com.care.root.main.service.MainService;

@RequestMapping("main")
@Controller
public class MainController implements SessionCommonName {

	@Autowired MainService ms;
	
	@GetMapping("themeList")
	public String themeList(@RequestParam String theme, Model model) {
		ms.themeList(model, theme);
		model.addAttribute("theme", theme);
		return "main/themeList";
	}
	
	@GetMapping("addPlace")
	public String addFormView(@RequestParam String theme, Model model) {
		model.addAttribute("theme", theme);
		return "main/addForm";
	}
	
	@PostMapping("register")
	   public void register(MultipartHttpServletRequest mul,HttpServletResponse response,
	                                    HttpServletRequest request) throws Exception {
	      ms.register(mul, response, request);
	   }
	
	@GetMapping("themeView")
	public String themeView(String placeName, Model model) {
		ms.themeView(placeName, model);		
		return "main/themeView";
	}
	
	@GetMapping("download")
	public void download(@RequestParam String mainImageFile, HttpServletResponse response)
										throws Exception{
		ms.download(mainImageFile, response);
	}
	
	@RequestMapping(value = "/modifyView", produces="text/plain; charset=UTF-8")
	public String modifyView(MultipartHttpServletRequest mul) {
		ms.modifyView(mul);
		String theme = mul.getParameter("mainCategory");
		try {
			theme = URLEncoder.encode(theme, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "redirect:themeList?theme="+theme;
	}
	
	
	@DeleteMapping(value ="deleteView",  produces = "application/json;charset=utf-8" )
	@ResponseBody
	public String deleteView(@RequestParam String placeName) {		
		return ms.deleteView(placeName);
	}
	
	
	@PostMapping(value="addMyList", produces = "application/json;charset=utf-8")
	@ResponseBody
	   public String addMyList(@RequestBody MyListDTO dto) {
	      return ms.addMyList(dto);
	   }
	
	@GetMapping(value = "getMyList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<MyListDTO> getMyList(HttpSession session) {
		return ms.getMyList(session);
	}
	
	@DeleteMapping(value = "deleteList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String deleteList(@RequestParam int listNo) {
		return ms.deleteMyList(listNo);
	}
	
	// 댓글 
	
	@PostMapping(value ="addReply", produces="application/json;charset=utf-8")
	@ResponseBody
	public String addReply(@RequestBody ReplyDTO dto) {
		return ms.addReply(dto);
	}
	
	@GetMapping(value ="getReply", produces="application/json;charset=utf-8")
	@ResponseBody
	public List<ReplyDTO> getReply(@RequestParam String placeName) {
		return ms.getReply(placeName);
	}
	
	@DeleteMapping(value = "deleteReply", produces="application/json;charset=utf-8")
	@ResponseBody
	public String deleteReply(@RequestParam int repNo) {
		return ms.deleteReply(repNo);
	}
	
}
