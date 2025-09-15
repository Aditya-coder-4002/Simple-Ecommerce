<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 40px auto;
            background: #fff;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .cart-table th,
        .cart-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        .cart-table th {
            background: #007bff;
            color: #fff;
            text-transform: uppercase;
            font-size: 14px;
        }
        .cart-table tr:nth-child(even) {
            background: #f2f2f2;
        }
        .cart-table tr:hover {
            background: #f9f9f9;
        }
        a[href="checkout.jsp"] {
            display: inline-block;
            padding: 10px 18px;
            background: #28a745;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background 0.3s;
        }
        a[href="checkout.jsp"]:hover {
            background: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Your Cart</h2>
    <%
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <p>Cart is empty.</p>
    <%
        } else {
            double total = 0;
    %>
        <table class="cart-table">
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Qty</th>
                <th>Subtotal</th>
            </tr>
            <%
                for (Map<String, Object> it : cart) {
                    int qty = (int) it.get("qty");
                    double price = (double) it.get("price");
                    total += price * qty;
            %>
                <tr>
                    <td><%= it.get("name") %></td>
                    <td>₹<%= price %></td>
                    <td><%= qty %></td>
                    <td>₹<%= price * qty %></td>
                </tr>
            <%
                }
            %>
            <tr>
                <td colspan="3">Total</td>
                <td>₹<%= total %></td>
            </tr>
        </table>
        <a href="checkout.jsp">Proceed to Checkout</a>
    <%
        }
    %>
</div>
</body>
</html>
