package com.giet.servlets;

import com.giet.utils.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "INSERT INTO users (username, password, email) VALUES (?, ?, ?)",
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, username);
            
            ps.setString(2, password);
            ps.setString(3, email);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                HttpSession session = req.getSession();
                session.setAttribute("userId", id);
                session.setAttribute("username", username);
                resp.sendRedirect(req.getContextPath() + "/index");
                return;
            }

        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) { 
                req.setAttribute("error", "Username already exists");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }
            throw new ServletException(e);
        }

        req.setAttribute("error", "Registration failed");
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }
}
