<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 400px;
            margin: 60px auto;
            background: #fff;
            padding: 25px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }
        form p {
            margin: 15px 0;
            font-size: 15px;
            color: #555;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            background: #28a745;
            border: none;
            border-radius: 6px;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Checkout</h2>
    <form method="post" action="<%= request.getContextPath() %>/checkout">
        <p>Name: 
            <input type="text" name="name" required>
        </p>
        <p>Address: 
            <input type="text" name="address" required>
        </p>
        <p>Phone: 
            <input type="text" name="phone" required>
        </p>
        <button type="submit">Confirm Order</button>
    </form>
</div>
</body>
</html>
