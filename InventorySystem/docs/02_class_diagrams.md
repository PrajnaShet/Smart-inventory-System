# Class Diagrams — Inventory System

## 1. Model (Entity) Classes

These are plain Java objects (POJOs) representing the domain entities. Each entity maps directly to a database table.

```mermaid
classDiagram
    class Admin {
        -int adminId
        -String username
        -String email
        -String password
        +Admin()
        +Admin(int, String, String, String)
        +Admin(String, String, String)
        +getAdminId() int
        +setAdminId(int) void
        +getUsername() String
        +setUsername(String) void
        +getEmail() String
        +setEmail(String) void
        +getPassword() String
        +setPassword(String) void
    }

    class Category {
        -int categoryId
        -String categoryName
        -String description
        +Category()
        +Category(int, String, String)
        +Category(String, String)
        +getCategoryId() int
        +setCategoryId(int) void
        +getCategoryName() String
        +setCategoryName(String) void
        +getDescription() String
        +setDescription(String) void
    }

    class Product {
        -int productId
        -String productName
        -int categoryId
        -double price
        -int quantity
        -int minStock
        -String description
        -Timestamp createdAt
        +Product()
        +Product(int, String, int, double, int, int, String, Timestamp)
        +Product(String, int, double, int, int, String)
        +getProductId() int
        +setProductId(int) void
        +getProductName() String
        +setProductName(String) void
        +getCategoryId() int
        +setCategoryId(int) void
        +getPrice() double
        +setPrice(double) void
        +getQuantity() int
        +setQuantity(int) void
        +getMinStock() int
        +setMinStock(int) void
        +getDescription() String
        +setDescription(String) void
        +getCreatedAt() Timestamp
        +setCreatedAt(Timestamp) void
    }

    class StockHistory {
        -int historyId
        -int productId
        -String changeType
        -int quantityChanged
        -Timestamp updatedAt
        +StockHistory()
        +StockHistory(int, int, String, int, Timestamp)
        +StockHistory(int, String, int)
        +getHistoryId() int
        +setHistoryId(int) void
        +getProductId() int
        +setProductId(int) void
        +getChangeType() String
        +setChangeType(String) void
        +getQuantityChanged() int
        +setQuantityChanged(int) void
        +getUpdatedAt() Timestamp
        +setUpdatedAt(Timestamp) void
    }

    Product "many" --> "1" Category : belongs to (categoryId FK)
    StockHistory "many" --> "1" Product : references (productId FK)
```

---

## 2. DAO Interface Layer

```mermaid
classDiagram
    class AdminDAO {
        <<interface>>
        +login(String username, String password) Admin
    }

    class CategoryDAO {
        <<interface>>
        +addCategory(Category category) boolean
        +updateCategory(Category category) boolean
        +deleteCategory(int categoryId) boolean
        +getCategoryById(int categoryId) Category
        +getAllCategories() List~Category~
    }

    class ProductDAO {
        <<interface>>
        +addProduct(Product product) boolean
        +updateProduct(Product product) boolean
        +deleteProduct(int productId) boolean
        +getProductById(int productId) Product
        +getAllProducts() List~Product~
        +searchProducts(String keyword) List~Product~
        +getLowStockProducts() List~Product~
        +updateStock(int productId, int quantity) boolean
    }

    class StockHistoryDAO {
        <<interface>>
        +addStockHistory(StockHistory stockHistory) boolean
        +getStockHistoryByProductId(int productId) List~StockHistory~
        +getAllStockHistory() List~StockHistory~
    }
```

---

## 3. DAO Implementation Layer

```mermaid
classDiagram
    class DBConnection {
        -String URL$
        -String USERNAME$
        -String PASSWORD$
        +getConnection()$ Connection
    }

    class AdminDAOImpl {
        +login(String, String) Admin
    }

    class CategoryDAOImpl {
        +addCategory(Category) boolean
        +updateCategory(Category) boolean
        +deleteCategory(int) boolean
        +getCategoryById(int) Category
        +getAllCategories() List~Category~
    }

    class ProductDAOImpl {
        +addProduct(Product) boolean
        +updateProduct(Product) boolean
        +deleteProduct(int) boolean
        +getProductById(int) Product
        +getAllProducts() List~Product~
        +searchProducts(String) List~Product~
        +getLowStockProducts() List~Product~
        +updateStock(int, int) boolean
        -mapResultSetToProduct(ResultSet) Product
    }

    class StockHistoryDAOImpl {
        +addStockHistory(StockHistory) boolean
        +getStockHistoryByProductId(int) List~StockHistory~
        +getAllStockHistory() List~StockHistory~
        -mapResultSetToStockHistory(ResultSet) StockHistory
    }

    AdminDAO <|.. AdminDAOImpl : implements
    CategoryDAO <|.. CategoryDAOImpl : implements
    ProductDAO <|.. ProductDAOImpl : implements
    StockHistoryDAO <|.. StockHistoryDAOImpl : implements

    AdminDAOImpl --> DBConnection : uses
    CategoryDAOImpl --> DBConnection : uses
    ProductDAOImpl --> DBConnection : uses
    StockHistoryDAOImpl --> DBConnection : uses
```

---

## 4. Controller Layer (Servlets)

```mermaid
classDiagram
    class HttpServlet {
        <<abstract>>
        +doGet(HttpServletRequest, HttpServletResponse) void
        +doPost(HttpServletRequest, HttpServletResponse) void
        +init() void
    }

    class LoginServlet {
        -AdminDAO adminDAO
        +init() void
        +doPost(HttpServletRequest, HttpServletResponse) void
    }

    class LogoutServlet {
        +doGet(HttpServletRequest, HttpServletResponse) void
    }

    class DashboardServlet {
        -ProductDAO productDAO
        -CategoryDAO categoryDAO
        -StockHistoryDAO stockHistoryDAO
        +init() void
        +doGet(HttpServletRequest, HttpServletResponse) void
    }

    class CategoryServlet {
        -CategoryDAO categoryDAO
        +init() void
        +doGet(HttpServletRequest, HttpServletResponse) void
        +doPost(HttpServletRequest, HttpServletResponse) void
        -listCategories(HttpServletRequest, HttpServletResponse) void
        -addCategory(HttpServletRequest, HttpServletResponse) void
        -deleteCategory(HttpServletRequest, HttpServletResponse) void
        -showEditCategory(HttpServletRequest, HttpServletResponse) void
        -updateCategory(HttpServletRequest, HttpServletResponse) void
    }

    class ProductServlet {
        -ProductDAO productDAO
        -CategoryDAO categoryDAO
        +init() void
        +doGet(HttpServletRequest, HttpServletResponse) void
        +doPost(HttpServletRequest, HttpServletResponse) void
        -listProducts(HttpServletRequest, HttpServletResponse) void
        -addProduct(HttpServletRequest, HttpServletResponse) void
        -deleteProduct(HttpServletRequest, HttpServletResponse) void
        -showEditProduct(HttpServletRequest, HttpServletResponse) void
        -updateProduct(HttpServletRequest, HttpServletResponse) void
        -searchProducts(HttpServletRequest, HttpServletResponse) void
    }

    class StockServlet {
        -ProductDAO productDAO
        -StockHistoryDAO stockHistoryDAO
        +init() void
        +doGet(HttpServletRequest, HttpServletResponse) void
        +doPost(HttpServletRequest, HttpServletResponse) void
    }

    class LowStockServlet {
        -ProductDAO productDAO
        -CategoryDAO categoryDAO
        +init() void
        +doGet(HttpServletRequest, HttpServletResponse) void
    }

    class AIInsightsServlet {
        -ProductDAO productDAO
        -CategoryDAO categoryDAO
        -StockHistoryDAO stockHistoryDAO
        +init() void
        +doGet(HttpServletRequest, HttpServletResponse) void
    }

    HttpServlet <|-- LoginServlet
    HttpServlet <|-- LogoutServlet
    HttpServlet <|-- DashboardServlet
    HttpServlet <|-- CategoryServlet
    HttpServlet <|-- ProductServlet
    HttpServlet <|-- StockServlet
    HttpServlet <|-- LowStockServlet
    HttpServlet <|-- AIInsightsServlet

    LoginServlet --> AdminDAO : uses
    DashboardServlet --> ProductDAO : uses
    DashboardServlet --> CategoryDAO : uses
    DashboardServlet --> StockHistoryDAO : uses
    CategoryServlet --> CategoryDAO : uses
    ProductServlet --> ProductDAO : uses
    ProductServlet --> CategoryDAO : uses
    StockServlet --> ProductDAO : uses
    StockServlet --> StockHistoryDAO : uses
    LowStockServlet --> ProductDAO : uses
    LowStockServlet --> CategoryDAO : uses
    AIInsightsServlet --> ProductDAO : uses
    AIInsightsServlet --> CategoryDAO : uses
    AIInsightsServlet --> StockHistoryDAO : uses
```

---

## 5. Complete System Class Diagram (Condensed)

```mermaid
classDiagram
    direction TB

    %% Models
    Admin --> AdminDAO
    Category --> CategoryDAO
    Product --> ProductDAO
    StockHistory --> StockHistoryDAO

    %% DAO Interfaces to Impls
    AdminDAO <|.. AdminDAOImpl
    CategoryDAO <|.. CategoryDAOImpl
    ProductDAO <|.. ProductDAOImpl
    StockHistoryDAO <|.. StockHistoryDAOImpl

    %% Impls use DBConnection
    AdminDAOImpl --> DBConnection
    CategoryDAOImpl --> DBConnection
    ProductDAOImpl --> DBConnection
    StockHistoryDAOImpl --> DBConnection

    %% Servlets use DAOs
    LoginServlet --> AdminDAOImpl
    DashboardServlet --> ProductDAOImpl
    DashboardServlet --> CategoryDAOImpl
    DashboardServlet --> StockHistoryDAOImpl
    CategoryServlet --> CategoryDAOImpl
    ProductServlet --> ProductDAOImpl
    ProductServlet --> CategoryDAOImpl
    StockServlet --> ProductDAOImpl
    StockServlet --> StockHistoryDAOImpl
    LowStockServlet --> ProductDAOImpl
    LowStockServlet --> CategoryDAOImpl
    AIInsightsServlet --> ProductDAOImpl
    AIInsightsServlet --> CategoryDAOImpl
    AIInsightsServlet --> StockHistoryDAOImpl
```
