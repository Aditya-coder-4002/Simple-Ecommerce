<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 50px auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            font-size: 14px;
        }
        th {
            background: #343a40;
            color: #fff;
        }
        tr:hover {
            background: #f1f1f1;
        }
        p {
            text-align: center;
            font-size: 16px;
            color: #777;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>My Orders</h2>
    <%
        List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("orders");
        if (orders == null || orders.isEmpty()) {
    %>
        <p>No orders yet.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Total</th>
                <th>Status</th>
                <th>Placed</th>
            </tr>
            <%
                for (Map<String, Object> o : orders) {
            %>
                <tr>
                    <td><%= o.get("id") %></td>
                    <td>₹<%= o.get("total") %></td>
                    <td><%= o.get("status") %></td>
                    <td><%= o.get("created_at") %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
</div>
</body>
</html>
