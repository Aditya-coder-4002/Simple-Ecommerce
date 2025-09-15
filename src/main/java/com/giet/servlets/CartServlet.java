package com.giet.servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        List<Map<String, Object>> cart =
                (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        String pid = req.getParameter("productId");
        String name = req.getParameter("name");
        String price = req.getParameter("price");
        int qty = 1;
        boolean found = false;

        for (Map<String, Object> item : cart) {
            if (item.get("productId").toString().equals(pid)) {
                int existing = (int) item.get("qty");
                item.put("qty", existing + 1);
                found = true;
                break;
            }
        }

        if (!found) {
            Map<String, Object> item = new HashMap<>();
            item.put("productId", Integer.parseInt(pid));
            item.put("name", name);
            item.put("price", Double.parseDouble(price));
            item.put("qty", qty);
            cart.add(item);
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect(req.getContextPath() + "/cart.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }
}
