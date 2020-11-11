package user;

import java.io.IOException;
import java.util.ArrayList;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
/**
 * Servlet implementation class UserSearchServlet
 */
@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String userName = request.getParameter("userName");
        response.getWriter().write(getJSON(userName));
    }
    
    public String getJSON(String userName) {
        if(userName == null) userName="";
        StringBuffer result = new StringBuffer("");    //result라는 변수 생성
        result.append("{\"result\":[");        //result에 문자열을 담음
        UserDAO userDAO=new UserDAO();
        ArrayList<User> userList = userDAO.search(userName);    //검색할 userName을 search 메소드에 넣고 리턴값을 저장함
        for(int i=0; i<userList.size(); i++) {    //검색에 해당되는 userList의 길이만큼
            result.append("[{\"value\": \""+userList.get(i).getUserName()+"\"},");    //해당 user들의 정보를 result에 넣음
            result.append("{\"value\": \""+userList.get(i).getUserAge()+"\"},");
            result.append("{\"value\": \""+userList.get(i).getUserGender()+"\"},");
            result.append("{\"value\": \""+userList.get(i).getUserEmail()+"\"}],");
        }
        result.append("]}");
        return result.toString();
    }
 
}
