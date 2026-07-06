# Sequence Diagrams — All Application Flows

## Flow 1 — User Login

**Servlet:** `LoginServlet` (`POST /login`)  
**DAO Used:** `AdminDAO → AdminDAOImpl`

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant LoginServlet
    participant AdminDAOImpl
    participant DBConnection
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Opens app (/ or /loginPage)
    Browser->>Browser: index.jsp forwards → login.jsp
    Browser-->>User: Renders Login Form

    User->>Browser: Enters username + password → Submit
    Browser->>LoginServlet: POST /login {username, password}

    LoginServlet->>AdminDAOImpl: login(username, password)
    AdminDAOImpl->>DBConnection: getConnection()
    DBConnection->>MySQL: DriverManager.getConnection(url, user, pass)
    MySQL-->>DBConnection: Connection
    DBConnection-->>AdminDAOImpl: Connection object

    AdminDAOImpl->>MySQL: SELECT * FROM admins WHERE username=? AND password=?
    MySQL-->>AdminDAOImpl: ResultSet

    alt Credentials Valid
        AdminDAOImpl-->>LoginServlet: Admin object
        LoginServlet->>LoginServlet: Create HttpSession
        LoginServlet->>LoginServlet: session.setAttribute("loggedInAdmin", admin)
        LoginServlet->>Browser: redirect → /dashboard
    else Invalid Credentials
        AdminDAOImpl-->>LoginServlet: null
        LoginServlet->>LoginServlet: request.setAttribute("errorMessage", "Invalid Username or Password!")
        LoginServlet->>Browser: forward → /WEB-INF/views/login.jsp
        Browser-->>User: Shows Error Message
    end
```

---

## Flow 2 — User Logout

**Servlet:** `LogoutServlet` (`GET /logout`)

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant LogoutServlet

    User->>Browser: Clicks Logout
    Browser->>LogoutServlet: GET /logout

    LogoutServlet->>LogoutServlet: session = request.getSession(false)

    alt Session Exists
        LogoutServlet->>LogoutServlet: session.invalidate()
    end

    LogoutServlet->>Browser: redirect → / (index.jsp)
    Browser->>Browser: Forwards to login.jsp
    Browser-->>User: Login Page
```

---

## Flow 3 — Dashboard Load

**Servlet:** `DashboardServlet` (`GET /dashboard`)  
**DAOs Used:** `ProductDAO`, `CategoryDAO`, `StockHistoryDAO`

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant DashboardServlet
    participant ProductDAOImpl
    participant CategoryDAOImpl
    participant StockHistoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Navigate to /dashboard
    Browser->>DashboardServlet: GET /dashboard

    DashboardServlet->>DashboardServlet: Validate session (loggedInAdmin?)

    alt Session Invalid
        DashboardServlet->>Browser: redirect → /loginPage
    else Session Valid
        DashboardServlet->>ProductDAOImpl: getAllProducts()
        ProductDAOImpl->>MySQL: SELECT * FROM products
        MySQL-->>ProductDAOImpl: ResultSet
        ProductDAOImpl-->>DashboardServlet: List~Product~

        DashboardServlet->>StockHistoryDAOImpl: getAllStockHistory()
        StockHistoryDAOImpl->>MySQL: SELECT * FROM stock_history
        MySQL-->>StockHistoryDAOImpl: ResultSet
        StockHistoryDAOImpl-->>DashboardServlet: List~StockHistory~

        DashboardServlet->>CategoryDAOImpl: getAllCategories()
        CategoryDAOImpl->>MySQL: SELECT * FROM categories
        MySQL-->>CategoryDAOImpl: ResultSet
        CategoryDAOImpl-->>DashboardServlet: List~Category~

        DashboardServlet->>ProductDAOImpl: getLowStockProducts()
        ProductDAOImpl->>MySQL: SELECT * FROM products WHERE quantity <= min_stock
        MySQL-->>ProductDAOImpl: ResultSet
        ProductDAOImpl-->>DashboardServlet: List~Product~ (low stock)

        DashboardServlet->>DashboardServlet: Calculate totalInventoryValue, productNames, productQuantities
        DashboardServlet->>DashboardServlet: request.setAttribute(totalProducts, totalCategories,\nlowStockCount, totalStockUpdates, totalInventoryValue,\nhistoryList, productList, productNames, productQuantities)

        DashboardServlet->>Browser: forward → /WEB-INF/views/dashboard.jsp
        Browser-->>User: Dashboard with Charts & Stats
    end
```

---

## Flow 4 — List All Categories

**Servlet:** `CategoryServlet` (`GET /categories`)  
**DAO Used:** `CategoryDAO`

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant CategoryServlet
    participant CategoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Navigate to /categories
    Browser->>CategoryServlet: GET /categories (action=null → defaults to "list")

    CategoryServlet->>CategoryServlet: Validate session
    CategoryServlet->>CategoryDAOImpl: getAllCategories()
    CategoryDAOImpl->>MySQL: SELECT * FROM categories
    MySQL-->>CategoryDAOImpl: ResultSet
    CategoryDAOImpl-->>CategoryServlet: List~Category~

    CategoryServlet->>CategoryServlet: request.setAttribute("categoryList", categoryList)
    CategoryServlet->>Browser: forward → /WEB-INF/views/categories.jsp
    Browser-->>User: Category List Page
```

---

## Flow 5 — Add Category

**Servlet:** `CategoryServlet` (`POST /categories`)

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant CategoryServlet
    participant CategoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Fills Add Category form → Submit
    Browser->>CategoryServlet: POST /categories {categoryName, description} (action=null → "add")

    CategoryServlet->>CategoryServlet: Read categoryName, description from request
    CategoryServlet->>CategoryServlet: new Category(categoryName, description)

    CategoryServlet->>CategoryDAOImpl: addCategory(category)
    CategoryDAOImpl->>MySQL: INSERT INTO categories(category_name, description) VALUES(?,?)
    MySQL-->>CategoryDAOImpl: rowsAffected
    CategoryDAOImpl-->>CategoryServlet: true/false

    CategoryServlet->>Browser: redirect → /categories
    Browser->>CategoryServlet: GET /categories (list all)
    Browser-->>User: Updated Category List
```

---

## Flow 6 — Edit / Update Category

**Servlet:** `CategoryServlet` (`GET /categories?action=edit` → `POST /categories?action=update`)

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant CategoryServlet
    participant CategoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Clicks Edit on a category
    Browser->>CategoryServlet: GET /categories?action=edit&id={categoryId}

    CategoryServlet->>CategoryDAOImpl: getCategoryById(categoryId)
    CategoryDAOImpl->>MySQL: SELECT * FROM categories WHERE category_id=?
    MySQL-->>CategoryDAOImpl: ResultSet
    CategoryDAOImpl-->>CategoryServlet: Category object

    CategoryServlet->>CategoryServlet: request.setAttribute("category", category)
    CategoryServlet->>CategoryDAOImpl: getAllCategories()
    CategoryDAOImpl->>MySQL: SELECT * FROM categories
    MySQL-->>CategoryDAOImpl: List~Category~
    CategoryDAOImpl-->>CategoryServlet: List~Category~
    CategoryServlet->>Browser: forward → categories.jsp (with edit form pre-filled)
    Browser-->>User: Edit form pre-filled

    User->>Browser: Modifies data → Submit
    Browser->>CategoryServlet: POST /categories {action=update, categoryId, categoryName, description}

    CategoryServlet->>CategoryServlet: new Category(categoryId, categoryName, description)
    CategoryServlet->>CategoryDAOImpl: updateCategory(category)
    CategoryDAOImpl->>MySQL: UPDATE categories SET category_name=?, description=? WHERE category_id=?
    MySQL-->>CategoryDAOImpl: rowsAffected
    CategoryDAOImpl-->>CategoryServlet: true/false

    CategoryServlet->>Browser: redirect → /categories
    Browser-->>User: Updated Category List
```

---

## Flow 7 — Delete Category

**Servlet:** `CategoryServlet` (`GET /categories?action=delete&id={id}`)

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant CategoryServlet
    participant CategoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Clicks Delete on a category
    Browser->>CategoryServlet: GET /categories?action=delete&id={categoryId}

    CategoryServlet->>CategoryDAOImpl: deleteCategory(categoryId)
    CategoryDAOImpl->>MySQL: DELETE FROM categories WHERE category_id=?
    MySQL-->>CategoryDAOImpl: rowsAffected
    CategoryDAOImpl-->>CategoryServlet: true/false

    CategoryServlet->>Browser: redirect → /categories
    Browser-->>User: Updated Category List
```

---

## Flow 8 — List All Products

**Servlet:** `ProductServlet` (`GET /products`)  
**DAOs Used:** `ProductDAO`, `CategoryDAO`

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant ProductServlet
    participant ProductDAOImpl
    participant CategoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Navigate to /products
    Browser->>ProductServlet: GET /products (action=null → "list")

    ProductServlet->>ProductServlet: Validate session

    ProductServlet->>ProductDAOImpl: getAllProducts()
    ProductDAOImpl->>MySQL: SELECT * FROM products
    MySQL-->>ProductDAOImpl: ResultSet
    ProductDAOImpl-->>ProductServlet: List~Product~

    ProductServlet->>CategoryDAOImpl: getAllCategories()
    CategoryDAOImpl->>MySQL: SELECT * FROM categories
    MySQL-->>CategoryDAOImpl: ResultSet
    CategoryDAOImpl-->>ProductServlet: List~Category~

    ProductServlet->>ProductServlet: request.setAttribute("productList", "categoryList")
    ProductServlet->>Browser: forward → /WEB-INF/views/products.jsp
    Browser-->>User: Products Page with Category Dropdown
```

---

## Flow 9 — Add Product

**Servlet:** `ProductServlet` (`POST /products`)

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant ProductServlet
    participant ProductDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Fills Add Product form → Submit
    Browser->>ProductServlet: POST /products {productName, categoryId, price,\nquantity, minStock, description}

    ProductServlet->>ProductServlet: Parse parameters
    ProductServlet->>ProductServlet: new Product(productName, categoryId, price, quantity, minStock, description)

    ProductServlet->>ProductDAOImpl: addProduct(product)
    ProductDAOImpl->>MySQL: INSERT INTO products(product_name, category_id, price,\nquantity, min_stock, description) VALUES(?,?,?,?,?,?)
    MySQL-->>ProductDAOImpl: rowsAffected
    ProductDAOImpl-->>ProductServlet: true/false

    ProductServlet->>ProductServlet: session.setAttribute("successMessage", "Product added successfully!")
    ProductServlet->>Browser: redirect → /products
    Browser-->>User: Updated Product List with Success Toast
```

---

## Flow 10 — Edit / Update Product

**Servlet:** `ProductServlet` (`GET /products?action=edit` → `POST /products?action=update`)

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant ProductServlet
    participant ProductDAOImpl
    participant CategoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Clicks Edit on a product
    Browser->>ProductServlet: GET /products?action=edit&id={productId}

    ProductServlet->>ProductDAOImpl: getProductById(productId)
    ProductDAOImpl->>MySQL: SELECT * FROM products WHERE product_id=?
    MySQL-->>ProductDAOImpl: ResultSet
    ProductDAOImpl-->>ProductServlet: Product object

    ProductServlet->>ProductDAOImpl: getAllProducts()
    ProductDAOImpl->>MySQL: SELECT * FROM products
    MySQL-->>ProductDAOImpl: List~Product~

    ProductServlet->>CategoryDAOImpl: getAllCategories()
    CategoryDAOImpl->>MySQL: SELECT * FROM categories
    MySQL-->>CategoryDAOImpl: List~Category~

    ProductServlet->>ProductServlet: setAttribute(product, productList, categoryList)
    ProductServlet->>Browser: forward → products.jsp (edit form pre-filled)
    Browser-->>User: Edit form pre-filled

    User->>Browser: Modifies data → Submit
    Browser->>ProductServlet: POST /products {action=update, productId, productName,...}

    ProductServlet->>ProductServlet: new Product(productId, productName, ...)
    ProductServlet->>ProductDAOImpl: updateProduct(product)
    ProductDAOImpl->>MySQL: UPDATE products SET product_name=?, category_id=?,\nprice=?, quantity=?, min_stock=?, description=? WHERE product_id=?
    MySQL-->>ProductDAOImpl: rowsAffected
    ProductDAOImpl-->>ProductServlet: true/false

    ProductServlet->>ProductServlet: session.setAttribute("successMessage", "Product updated successfully!")
    ProductServlet->>Browser: redirect → /products
    Browser-->>User: Updated Product List
```

---

## Flow 11 — Search Products

**Servlet:** `ProductServlet` (`GET /products?action=search&keyword={keyword}`)

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant ProductServlet
    participant ProductDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Types keyword in Search bar → Search
    Browser->>ProductServlet: GET /products?action=search&keyword={keyword}

    ProductServlet->>ProductDAOImpl: searchProducts(keyword)
    ProductDAOImpl->>MySQL: SELECT * FROM products WHERE product_name LIKE '%keyword%'
    MySQL-->>ProductDAOImpl: ResultSet (matching products)
    ProductDAOImpl-->>ProductServlet: List~Product~

    ProductServlet->>ProductServlet: setAttribute("productList", "categoryList")
    ProductServlet->>Browser: forward → products.jsp
    Browser-->>User: Filtered Product List
```

---

## Flow 12 — Delete Product

**Servlet:** `ProductServlet` (`GET /products?action=delete&id={id}`)

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant ProductServlet
    participant ProductDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Clicks Delete on a product
    Browser->>ProductServlet: GET /products?action=delete&id={productId}

    ProductServlet->>ProductDAOImpl: deleteProduct(productId)
    ProductDAOImpl->>MySQL: DELETE FROM products WHERE product_id=?
    MySQL-->>ProductDAOImpl: rowsAffected
    ProductDAOImpl-->>ProductServlet: true/false

    ProductServlet->>ProductServlet: session.setAttribute("successMessage", "Product deleted successfully!")
    ProductServlet->>Browser: redirect → /products
    Browser-->>User: Updated Product List
```

---

## Flow 13 — Stock Management (IN / OUT)

**Servlet:** `StockServlet` (`GET /stock` → `POST /stock`)  
**DAOs Used:** `ProductDAO`, `StockHistoryDAO`

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant StockServlet
    participant ProductDAOImpl
    participant StockHistoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Navigate to /stock
    Browser->>StockServlet: GET /stock

    StockServlet->>ProductDAOImpl: getAllProducts()
    ProductDAOImpl->>MySQL: SELECT * FROM products
    MySQL-->>ProductDAOImpl: List~Product~
    ProductDAOImpl-->>StockServlet: List~Product~

    StockServlet->>StockHistoryDAOImpl: getAllStockHistory()
    StockHistoryDAOImpl->>MySQL: SELECT * FROM stock_history
    MySQL-->>StockHistoryDAOImpl: List~StockHistory~
    StockHistoryDAOImpl-->>StockServlet: List~StockHistory~

    StockServlet->>Browser: forward → stock.jsp
    Browser-->>User: Stock Management Form + History Table

    User->>Browser: Selects Product, changeType (IN/OUT), quantity → Submit
    Browser->>StockServlet: POST /stock {productId, changeType, quantity}

    StockServlet->>ProductDAOImpl: getProductById(productId)
    ProductDAOImpl->>MySQL: SELECT * FROM products WHERE product_id=?
    MySQL-->>ProductDAOImpl: Product
    ProductDAOImpl-->>StockServlet: Product

    alt changeType = OUT and quantity > currentQuantity
        StockServlet->>StockServlet: request.setAttribute("errorMessage", "Insufficient stock!")
        StockServlet->>StockServlet: doGet(request, response)
        StockServlet->>Browser: forward → stock.jsp with error
    else Valid Stock Update
        StockServlet->>StockServlet: finalQuantity = (changeType==IN) ? +qty : -qty
        StockServlet->>ProductDAOImpl: updateStock(productId, finalQuantity)
        ProductDAOImpl->>MySQL: UPDATE products SET quantity = quantity + ? WHERE product_id=?
        MySQL-->>ProductDAOImpl: rowsAffected
        ProductDAOImpl-->>StockServlet: true/false

        StockServlet->>StockServlet: new StockHistory(productId, changeType, quantity)
        StockServlet->>StockHistoryDAOImpl: addStockHistory(history)
        StockHistoryDAOImpl->>MySQL: INSERT INTO stock_history(product_id, change_type, quantity_changed) VALUES(?,?,?)
        MySQL-->>StockHistoryDAOImpl: rowsAffected
        StockHistoryDAOImpl-->>StockServlet: true/false

        StockServlet->>Browser: redirect → /stock
        Browser-->>User: Updated Stock Page
    end
```

---

## Flow 14 — Low Stock Alert View

**Servlet:** `LowStockServlet` (`GET /low-stock`)  
**DAOs Used:** `ProductDAO`, `CategoryDAO`

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant LowStockServlet
    participant ProductDAOImpl
    participant CategoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Navigate to /low-stock
    Browser->>LowStockServlet: GET /low-stock

    LowStockServlet->>LowStockServlet: Validate session

    LowStockServlet->>ProductDAOImpl: getLowStockProducts()
    ProductDAOImpl->>MySQL: SELECT * FROM products WHERE quantity <= min_stock
    MySQL-->>ProductDAOImpl: ResultSet
    ProductDAOImpl-->>LowStockServlet: List~Product~ (low stock items)

    LowStockServlet->>CategoryDAOImpl: getAllCategories()
    CategoryDAOImpl->>MySQL: SELECT * FROM categories
    MySQL-->>CategoryDAOImpl: ResultSet
    CategoryDAOImpl-->>LowStockServlet: List~Category~

    LowStockServlet->>LowStockServlet: setAttribute("lowStockProducts", "categoryList")
    LowStockServlet->>Browser: forward → /WEB-INF/views/low_stock.jsp
    Browser-->>User: Low Stock Alert Page
```

---

## Flow 15 — AI Insights View

**Servlet:** `AIInsightsServlet` (`GET /ai-insights`)  
**DAOs Used:** `ProductDAO`, `CategoryDAO`, `StockHistoryDAO`

```mermaid
sequenceDiagram
    actor User as 👤 Admin User
    participant Browser
    participant AIInsightsServlet
    participant ProductDAOImpl
    participant CategoryDAOImpl
    participant StockHistoryDAOImpl
    participant MySQL as 🗄️ MySQL DB

    User->>Browser: Navigate to /ai-insights
    Browser->>AIInsightsServlet: GET /ai-insights

    AIInsightsServlet->>AIInsightsServlet: Validate session

    AIInsightsServlet->>ProductDAOImpl: getAllProducts()
    ProductDAOImpl->>MySQL: SELECT * FROM products
    MySQL-->>ProductDAOImpl: List~Product~
    ProductDAOImpl-->>AIInsightsServlet: List~Product~

    AIInsightsServlet->>CategoryDAOImpl: getAllCategories()
    CategoryDAOImpl->>MySQL: SELECT * FROM categories
    MySQL-->>CategoryDAOImpl: List~Category~
    CategoryDAOImpl-->>AIInsightsServlet: List~Category~

    AIInsightsServlet->>StockHistoryDAOImpl: getAllStockHistory()
    StockHistoryDAOImpl->>MySQL: SELECT * FROM stock_history
    MySQL-->>StockHistoryDAOImpl: List~StockHistory~
    StockHistoryDAOImpl-->>AIInsightsServlet: List~StockHistory~

    AIInsightsServlet->>ProductDAOImpl: getLowStockProducts()
    ProductDAOImpl->>MySQL: SELECT * FROM products WHERE quantity <= min_stock
    MySQL-->>ProductDAOImpl: List~Product~
    ProductDAOImpl-->>AIInsightsServlet: lowStockCount

    AIInsightsServlet->>AIInsightsServlet: Compute totalInventoryValue (price × quantity per product)
    AIInsightsServlet->>AIInsightsServlet: Compute healthyStockCount (total - lowStockCount)
    AIInsightsServlet->>AIInsightsServlet: Build activityMap (productId → count of stock history entries)
    AIInsightsServlet->>AIInsightsServlet: Find mostActiveProduct (max activity count)

    AIInsightsServlet->>AIInsightsServlet: setAttribute(totalInventoryValue, lowStockCount,\nhealthyStockCount, mostActiveProduct,\ntotalProducts, totalCategories, historyList, productList, categoryList)

    AIInsightsServlet->>Browser: forward → /WEB-INF/views/ai_insights.jsp
    Browser-->>User: AI Insights Dashboard with KPIs
```
