<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home - Simple Ecommerce</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .header {
            background: #007bff;
            padding: 15px 0;
        }
        .header .container {
            width: 90%;
            margin: 0 auto;
            text-align: center;
        }
        .header a {
            color: aquamarine;
            text-decoration: none;
            margin: 0 10px;
            font-weight: bold;
        }
        .header a:hover {
            text-decoration: underline;
        }
        .container {
            width: 90%;
            margin: 30px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .product-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }
        .product {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
            background: #fafafa;
        }
        .product:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .product-img {
            max-width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 6px;
        }
        .product h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #007bff;
        }
        .product p {
            font-size: 16px;
            color: #333;
            margin-bottom: 10px;
        }
        .product form {
            margin: 10px 0;
        }
        .product button {
            padding: 8px 12px;
            background: #28a745;
            border: none;
            border-radius: 6px;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }
        .product button:hover {
            background: #218838;
        }
        .product a {
            display: inline-block;
            margin-top: 5px;
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
        }
        .product a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <a href="<%=request.getContextPath()%>/index">Home</a> |
        <a href="cart">Cart</a> |
        <a href="orders">My Orders</a> |
        <a href="login.jsp">Login</a>
    </div>
</div>

<div class="container">
    <h2>Featured Products</h2>
    <div class="product-list">
        <%
            List<Map<String, Object>> products = (List<Map<String, Object>>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for (Map<String, Object> p : products) {
        %>
        <div class="product">
<img src="<%= request.getContextPath() + "/" + p.get("image") %>"
     alt="<%= p.get("name") %>" class="product-img"/>

            <h3><%= p.get("name") %></h3>
            <p>₹<%= p.get("price") %></p>
            <form action="cart" method="post">
                <input type="hidden" name="productId" value="<%= p.get("id") %>">
                <input type="hidden" name="name" value="<%= p.get("name") %>">
                <input type="hidden" name="price" value="<%= p.get("price") %>">
                <button type="submit">Add to Cart</button>
            </form>
            <a href="product?id=<%= p.get("id") %>">View</a>
        </div>
        <%
                }
            } else {
        %>
        <p>No products found.</p>
        <% } %>
    </div>
</div>
</body>
</html>
