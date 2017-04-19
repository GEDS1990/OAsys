package tools;

import java.io.PrintWriter;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	public static final String SESSION_USERID = "kUSERID";
	public static final String SESSION_AUTHS = "kAUTHS";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean flag = true;
		if (handler instanceof HandlerMethod) {
			Auth auth = ((HandlerMethod) handler).getMethod().getAnnotation(Auth.class);
			if (auth != null) {
				if (request.getSession().getAttribute("user") == null) {
					response.setStatus(HttpStatus.FORBIDDEN.value());
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.write("您还没有登陆！");
					out.flush();
					out.close();
					flag = false;
				} else {
					if (!"".equals(auth.value())) {
						Set<String> auths = (Set<String>) request.getSession().getAttribute(SESSION_AUTHS);
						if (!auths.contains(auth.value())) {// 提示用户没权限
							response.setStatus(HttpStatus.FORBIDDEN.value());
							response.setContentType("text/html; charset=UTF-8");
							PrintWriter out = response.getWriter();
							out.write("{\"type\":\"noauth\",\"msg\":\"您没有" + auth.name() + "权限!\"}");
							out.flush();
							out.close();
							flag = false;
						}
					}
				}
			}
		}
		return flag;
	}
}
