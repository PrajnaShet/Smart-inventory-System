# System Diagrams — Inventory System

---

## 1. System Architecture Diagram

> Shows the three-layer MVC structure and how each layer communicates.

```mermaid
flowchart TD
    Browser["🌐 Browser / Client"]

    subgraph C["Controller Layer · Servlets"]
        direction LR
        S1[Login] --- S2[Dashboard] --- S3[Categories]
        S4[Products] --- S5[Stock] --- S6[LowStock] --- S7[AIInsights]
    end

    subgraph M["Model Layer"]
        direction LR
        E["Entities\nAdmin · Category\nProduct · StockHistory"]
        DAO["DAOs\nAdminDAO · CategoryDAO\nProductDAO · StockHistoryDAO"]
        DB2["DBConnection\n(JDBC Utility)"]
        E --- DAO --- DB2
    end

    subgraph V["View Layer · JSP"]
        direction LR
        V1[login.jsp] --- V2[dashboard.jsp] --- V3[categories.jsp]
        V4[products.jsp] --- V5[stock.jsp] --- V6[low_stock.jsp] --- V7[ai_insights.jsp]
    end

    DB[("MySQL DB\ninventory_system")]

    Browser -->|HTTP Request| C
    C -->|Delegates data ops| M
    M -->|SQL via JDBC| DB
    DB -->|ResultSet| M
    M -->|Entity objects| C
    C -->|setAttribute + forward| V
    V -->|HTML Response| Browser
```

---

## 2. User Workflow Flowchart

> Traces the full user journey through the application.

```mermaid
flowchart TD
    Start([Start]) --> Login["Login Page\n/login"]
    Login -->|POST credentials| Auth{Valid\nCredentials?}
    Auth -->|No| Login
    Auth -->|Yes - Session created| Dashboard["Dashboard\n/dashboard"]

    Dashboard --> A["Manage Categories\n/categories"]
    Dashboard --> B["Manage Products\n/products"]
    Dashboard --> C["Stock Adjustment\n/stock"]
    Dashboard --> D["Low Stock Alerts\n/low-stock"]
    Dashboard --> E["AI Insights\n/ai-insights"]

    A -->|Add / Edit / Delete| Dashboard
    B -->|Add / Edit / Delete| Dashboard
    C -->|IN / OUT transaction| Dashboard
    D -->|View alerts| Dashboard
    E -->|View recommendations| Dashboard

    Dashboard --> Logout["Logout\n/logout"]
    Logout -->|Session invalidated| Login
```

---

## Key Components Summary

| Component | Technology | Role |
|---|---|---|
| **View** | JSP + JSTL | Renders HTML pages |
| **Controller** | Jakarta Servlet | Handles HTTP, session auth |
| **Model / DAO** | Java POJOs + JDBC | Business entities & DB queries |
| **Database** | MySQL 8 | Persistent data store |
| **Container** | Apache Tomcat | Servlet runtime |
