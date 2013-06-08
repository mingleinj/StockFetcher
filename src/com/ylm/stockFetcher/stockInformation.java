package com.ylm.stockFetcher;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
 
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
 
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class stockInformation
 */
public class stockInformation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public stockInformation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    //String stockCode = request.getParameter("countryCode");
			//double peMin = Double.parseDouble(request.getParameter("amount1"));
			//double peMax = Double.parseDouble(request.getParameter("amount2"));
			
			//double mcMin = Double.parseDouble(request.getParameter("amount3"));
			//double mcMax = Double.parseDouble(request.getParameter("amount4"));
			
			//double prMin = Double.parseDouble(request.getParameter("amount5"));
			//double prMax = Double.parseDouble(request.getParameter("amount6"));
			
			//double chMin = Double.parseDouble(request.getParameter("amount7"));
			//double chMax = Double.parseDouble(request.getParameter("amount8"));
			
			//double voMin = Double.parseDouble(request.getParameter("amount9"));
			//double voMax = Double.parseDouble(request.getParameter("amount10"));
			
			double peMin = Double.parseDouble(request.getParameter("pe[1]"));
			double peMax = Double.parseDouble(request.getParameter("pe[2]"));
			
			double mcMin = Double.parseDouble(request.getParameter("marketcap[1]"));
			double mcMax = Double.parseDouble(request.getParameter("marketcap[2]"));
			
			double prMin = Double.parseDouble(request.getParameter("price[1]"));
			double prMax = Double.parseDouble(request.getParameter("price[2]"));
			
			double chMin = Double.parseDouble(request.getParameter("change[1]"));
			double chMax = Double.parseDouble(request.getParameter("change[2]"));
			
			double voMin = Double.parseDouble(request.getParameter("value[1]"));
			double voMax = Double.parseDouble(request.getParameter("value[2]"));
		   
			CretireaInfo ci=new CretireaInfo();
			ci.pemin=peMin;
			ci.pemax=peMax;
			ci.mcmin=mcMin;
			ci.mcmax=mcMax;
			ci.prmin=prMin;
			ci.prmax=prMax;
			ci.chmin=chMin;
			ci.chmax=chMax;
			ci.vomin=voMin;
			ci.vomax=voMax;
			System.out.println(peMin+"--"+peMax+"--"+mcMin+"--"+mcMax+"--"+prMin+"--"+prMax+"--"+chMin+"--"+chMax+"--"+voMin+"--"+voMax);
		    //String stockCode = "ge";
	        PrintWriter out = response.getWriter();
	        response.setContentType("text/html");
	        response.setHeader("Cache-control", "no-cache, no-store");
	        response.setHeader("Pragma", "no-cache");
	        response.setHeader("Expires", "-1");
	 
	        response.setHeader("Access-Control-Allow-Origin", "*");
	        response.setHeader("Access-Control-Allow-Methods", "POST");
	        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
	        response.setHeader("Access-Control-Max-Age", "86400");
	 
	        Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();
	 
	        //List<StockInfo> stockInfos = getInfo(peMin, peMax);
	        
	        //创建实体参数方法，将所有参数信息以实体形式传进去
	        //List<StockInfo> stockInfos = getInfoByEntity(ci);
	        //JsonElement stockObj = gson.toJsonTree(stockInfos);
	        
	        //myObj.addProperty("success", true);
	      
	        //myObj.add("stockInfo", stockObj);
	        //out.println(myObj.toString());
	 
	        out.close();
	}
	
	//Get Ticker Information
    private List<StockInfo> getInfo(double peMin, double peMax) {
 
    	List<StockInfo> stocks = new ArrayList<StockInfo>();
        Connection conn = null;            
        PreparedStatement stmt = null;     
        String sql = null;
 
        try {      
            Context ctx = (Context) new InitialContext().lookup("java:comp/env");
            conn = ((DataSource) ctx.lookup("jdbc/mysql")).getConnection(); 
 
            sql = "Select * from stock.m_overview where pe> ? and pe< ?"; 
            stmt = conn.prepareStatement(sql);
            stmt.setDouble(1, peMin/10);
            stmt.setDouble(2, peMax/10);
            ResultSet rs = stmt.executeQuery(); 
 
            while(rs.next()){ 
            	StockInfo stock = new StockInfo();
            	stock.setTicker(rs.getString("ticker").trim());
            	stock.setPe(rs.getString("PE").trim());
            	stock.setMarketcap(rs.getString("marketCap").trim());
            	stock.setPrice(rs.getString("Price").trim());
            	stocks.add(stock);
            }                                                                         
 
            rs.close();                                                               
            stmt.close();                                                             
            stmt = null;                                                              
 
 
            conn.close();                                                             
            conn = null;                                                   
 
        }                                                               
        catch(Exception e){System.out.println(e);}                      
 
        finally {                                                       
  
            if (stmt != null) {                                            
                try {                                                         
                    stmt.close();                                                
                } catch (SQLException sqlex) {                                
                    // ignore -- as we can't do anything about it here           
                }                                                             
 
                stmt = null;                                            
            }                                                        
 
            if (conn != null) {                                      
                try {                                                   
                    conn.close();                                          
                } catch (SQLException sqlex) {                          
                    // ignore -- as we can't do anything about it here     
                }                                                       
 
                conn = null;                                            
            }                                                        
        }              
 
        return stocks;
 
    }   
    private List<StockInfo> getInfoByEntity(CretireaInfo ci) {
    	 
    	List<StockInfo> stocks = new ArrayList<StockInfo>();
        Connection conn = null;            
        PreparedStatement stmt = null;     
        String sql = null;
 
        try {      
            Context ctx = (Context) new InitialContext().lookup("java:comp/env");
            conn = ((DataSource) ctx.lookup("jdbc/mysql")).getConnection(); 
 
            //sql = "Select * from stock.m_overview where pe>= ? and pe<= ? and marketcap >= ? and marketcap <=? and price>=? and price<=? and changes>=? and changes<=? and volume>=? and volume<=?"; 
            sql = "Select * from stock.m_overview";
            stmt = conn.prepareStatement(sql);
            /*stmt.setDouble(1, ci.pemin);
            stmt.setDouble(2, ci.pemax);
            stmt.setDouble(3, ci.mcmin);
            stmt.setDouble(4, ci.mcmax);
            stmt.setDouble(5, ci.prmin);
            stmt.setDouble(6, ci.prmax);
            stmt.setDouble(7, ci.chmin);
            stmt.setDouble(8, ci.chmax);
            stmt.setDouble(9, ci.vomin);
            stmt.setDouble(10, ci.vomax);*/
            ResultSet rs = stmt.executeQuery(); 
            while(rs.next()){ 
            	StockInfo stock = new StockInfo();
            	stock.setTicker(rs.getString("ticker").trim());
            	stock.setPe(rs.getString("PE").trim());
            	stock.setMarketcap(rs.getString("marketCap").trim());
            	stock.setPrice(rs.getString("Price").trim());
            	stocks.add(stock);
            }                                                                         
 
            rs.close();                                                               
            stmt.close();                                                             
            stmt = null;                                                              
 
 
            conn.close();                                                             
            conn = null;                                                   
 
        }                                                               
        catch(Exception e){System.out.println(e);}                      
 
        finally {                                                       
  
            if (stmt != null) {                                            
                try {                                                         
                    stmt.close();                                                
                } catch (SQLException sqlex) {                                
                    // ignore -- as we can't do anything about it here           
                }                                                             
 
                stmt = null;                                            
            }                                                        
 
            if (conn != null) {                                      
                try {                                                   
                    conn.close();                                          
                } catch (SQLException sqlex) {                          
                    // ignore -- as we can't do anything about it here     
                }                                                       
 
                conn = null;                                            
            }                                                        
        }              
 
        return stocks;
 
    }   

}
