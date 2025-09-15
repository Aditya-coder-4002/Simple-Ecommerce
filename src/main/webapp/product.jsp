<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product - Simple Ecom</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 60%;
            margin: 50px auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 15px;
        }
        .product-img {
            width: 250px;
            height: auto;
            border-radius: 8px;
            margin: 15px 0;
        }
        p {
            font-size: 15px;
            color: #555;
            margin: 10px 0;
        }
        p:last-of-type {
            font-size: 18px;
            font-weight: bold;
            color: #000;
        }
        form {
            margin-top: 20px;
        }
        button {
            padding: 10px 20px;
            background: #28a745;
            border: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        Object obj = request.getAttribute("product");
        Map<String, Object> p = null;
        if (obj instanceof Map) {
            p = (Map<String, Object>) obj;
        }

        if (p != null) {
    %>
        <h2><%= p.get("name") %></h2>
        <img src="<%= p.get("image") %>" alt="<%= p.get("name") %>" class="product-img"/>
        <p><%= p.get("description") %></p>
        <p>₹<%= p.get("price") %></p>

        <form action="cart" method="post">
            <input type="hidden" name="productId" value="<%= p.get("id") %>">
            <input type="hidden" name="name" value="<%= p.get("name") %>">
            <input type="hidden" name="price" value="<%= p.get("price") %>">
            <button type="submit">Add to Cart</button>
        </form>
    <%
        } else {
    %>
        <p>Product not found.</p>
    <%
        }
    %>
</div>
</body>
</html>
