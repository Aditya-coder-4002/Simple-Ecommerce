package com.giet.servlets;

import com.giet.utils.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        List<Map<String, Object>> cart =
                (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            req.setAttribute("msg", "Cart is empty");
            req.getRequestDispatcher("cart.jsp").forward(req, resp);
            return;
        }

        double total = 0;
        for (Map<String, Object> item : cart) {
            total += (double) item.get("price") * (int) item.get("qty");
        }

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            String insertOrder =
                    "INSERT INTO orders (user_id, total, status) VALUES (?, ?, 'Processing')";
            try (PreparedStatement ps = con.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setDouble(2, total);
                ps.executeUpdate();

                ResultSet keys = ps.getGeneratedKeys();
                int orderId = -1;
                if (keys.next()) {
                    orderId = keys.getInt(1);
                }

                String insertItem =
                        "INSERT INTO order_items (order_id, product_id, qty, price) VALUES (?, ?, ?, ?)";
                try (PreparedStatement pis = con.prepareStatement(insertItem)) {
                    for (Map<String, Object> it : cart) {
                        pis.setInt(1, orderId);
                        pis.setInt(2, (int) it.get("productId"));
                        pis.setInt(3, (int) it.get("qty"));
                        pis.setDouble(4, (double) it.get("price"));
                        pis.addBatch();
                    }
                    pis.executeBatch();
                }
            }

            con.commit();
            session.removeAttribute("cart");
            resp.sendRedirect(req.getContextPath() + "/orders");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("checkout.jsp").forward(req, resp);
    }
}
