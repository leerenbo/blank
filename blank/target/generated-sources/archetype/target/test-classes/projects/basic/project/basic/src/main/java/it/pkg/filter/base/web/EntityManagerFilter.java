package it.pkg.filter.base.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter;

public class EntityManagerFilter extends OpenEntityManagerInViewFilter{

	@Override
	protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
		return request.getRequestURI().contains("_noSe_");
	}
}
