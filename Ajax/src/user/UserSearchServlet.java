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
        StringBuffer result = new StringBuffer("");    //result��� ���� ����
        result.append("{\"result\":[");        //result�� ���ڿ��� ����
        UserDAO userDAO=new UserDAO();
        ArrayList<User> userList = userDAO.search(userName);    //�˻��� userName�� search �޼ҵ忡 �ְ� ���ϰ��� ������
        for(int i=0; i<userList.size(); i++) {    //�˻��� �ش�Ǵ� userList�� ���̸�ŭ
            result.append("[{\"value\": \""+userList.get(i).getUserName()+"\"},");    //�ش� user���� ������ result�� ����
            result.append("{\"value\": \""+userList.get(i).getUserAge()+"\"},");
            result.append("{\"value\": \""+userList.get(i).getUserGender()+"\"},");
            result.append("{\"value\": \""+userList.get(i).getUserEmail()+"\"}],");
        }
        result.append("]}");
        return result.toString();
    }
 
}
