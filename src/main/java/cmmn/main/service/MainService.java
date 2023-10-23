package cmmn.main.service;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmmn.common.dao.CommonDAO;


/**
 * Handles requests for the application home page.
 */
@Service("mainService")
public class MainService {
	
	@Resource(name = "commonDAO")
	private CommonDAO comDao;
	
}
 