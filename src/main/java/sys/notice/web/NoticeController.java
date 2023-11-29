package sys.notice.web;

import java.io.Console;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import sys.notice.service.NoticeService;


/**
 * Handles requests for the application home page.
 */
@Controller("noticeController")
public class NoticeController {

   @Resource(name = "noticeService")
   private NoticeService noticeService; 
   
   @RequestMapping(value = "/sys/notice/notice.view", method = RequestMethod.GET)
   public String noticeInfo(@RequestParam HashMap<String, Object> reqMap, Model model) throws Exception {
      model.addAttribute("page","WEB-INF/jsp/sys/notice/notice.jsp");
      return "/sys/notice/notice"; 
   }
   
   @RequestMapping(value = "/sys/notice/noticeSearch.json", method = {RequestMethod.POST, RequestMethod.GET})
   public String noticeSearch(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
      List<HashMap<String, Object>> result = noticeService.noticeSearch(reqMap);
      model.addAttribute("noticeInfo", result);
      return "jsonTemplate";
   }
   
   @RequestMapping(value = "/sys/notice/noticeSave.json", method = {RequestMethod.POST, RequestMethod.GET})
   public String noticeSave(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
	   HashMap<String, Object> result = noticeService.noticeSave(reqMap);
	   model.addAttribute("noticeInfo", result);
	   return "jsonTemplate";
   }
}