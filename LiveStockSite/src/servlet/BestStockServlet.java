package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import general.Stock;
import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/best_stocks" })
public class BestStockServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public BestStockServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        List<Stock> list = new ArrayList<Stock>();
        Connection conn = MyUtils.getStoredConnection(request);
        int id = loginedUser.getId();
        String table = "Best Sellers";
        System.out.println(table);
        System.out.println("Userid: "+id);
        
        try{
			String sql01 = "DROP VIEW IF EXISTS BestSellers2;";
			PreparedStatement pstm01 = conn.prepareStatement(sql01);
			pstm01.executeUpdate();
        	
			sql01 = "CREATE VIEW BestSellers2(StockSymbol, StockName, StockType, SharePrice, NumAvailShares, TotalShares) AS "
					+ "SELECT S.StockSymbol, S.StockName, S.StockType, S.SharePrice, S.NumAvailShares, SUM(O.NumShares) AS TotalShares "
					+ "FROM Order_ O, Stock S "
					+ "WHERE O.StockSymbol = S.StockSymbol "
					+ "GROUP BY O.StockSymbol;";
			pstm01 = conn.prepareStatement(sql01);
			pstm01.executeUpdate();
			
        	String sql1 = "CALL getBestSellers2()";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	java.sql.ResultSet rs  = pstm1.executeQuery();
            
            while (rs.next()) {
                String sksym = rs.getString("StockSymbol");
                String sknm = rs.getString("StockName");
                String sktp = rs.getString("StockType");
                float shpr = rs.getFloat("SharePrice");
                int numsh = rs.getInt("NumAvailShares");
                Stock data = new Stock(sksym, sknm, sktp, shpr, numsh);
                list.add(data);
                System.out.println("Obtained Data: "+sksym+" "+sknm+" "+sktp+" "+shpr+" "+numsh);
            }
            
			sql01 = "DROP VIEW BestSellers2;";
			pstm01 = conn.prepareStatement(sql01);
			pstm01.executeUpdate();
			
        } catch (Exception e) {
			e.printStackTrace();
		}
			
        request.setAttribute("stocks", list);
        request.setAttribute("table", table);
        request.setAttribute("userType", loginedUser.getUserType());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/cust_stocks.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
