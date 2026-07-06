# Architecture Overview — Inventory System

## Technology Stack

| Layer | Technology |
|---|---|
| Language | Java 21 |
| Web Framework | Jakarta Servlet / JSP (Jakarta EE 10) |
| View Engine | JSP + JSTL 3.x |
| Database | MySQL 8.x |
| JDBC Driver | MySQL Connector/J 9.0.0 |
| Build Tool | Maven 3.x (WAR packaging) |
| Deployment | Apache Tomcat (Servlet Container) |

---

## MVC Design Pattern

The application strictly follows the **Model-View-Controller (MVC)** architectural pattern implemented using the **Jakarta Servlet + JSP** stack. All routing is annotation-driven (`@WebServlet`).

```mermaid
flowchart TD
    Browser["🌐 Browser / Client"]

    subgraph Controller["Controller Layer — Servlets"]
        LS[LoginServlet\n/login]
        LOS[LogoutServlet\n/logout]
        DS[DashboardServlet\n/dashboard]
        CS[CategoryServlet\n/categories]
        PS[ProductServlet\n/products]
        SS[StockServlet\n/stock]
        LSS[LowStockServlet\n/low-stock]
        AIS[AIInsightsServlet\n/ai-insights]
    end

    subgraph Model["Model Layer"]
        subgraph Entities["Entity Classes"]
            AM[Admin]
            CM[Category]
            PM[Product]
            SH[StockHistory]
        end
        subgraph DAOLayer["DAO Interfaces + Implementations"]
            ADAO[AdminDAO / AdminDAOImpl]
            CDAO[CategoryDAO / CategoryDAOImpl]
            PDAO[ProductDAO / ProductDAOImpl]
            SHDAO[StockHistoryDAO / StockHistoryDAOImpl]
        end
        subgraph Utility["Utility"]
            DBC[DBConnection]
        end
    end

    subgraph View["View Layer — JSP"]
        V1[login.jsp]
        V2[dashboard.jsp]
        V3[categories.jsp]
        V4[products.jsp]
        V5[stock.jsp]
        V6[low_stock.jsp]
        V7[ai_insights.jsp]
        P1[navbar.jsp — Partial]
        P2[sidebar.jsp — Partial]
    end

    DB[(MySQL Database\ninventory_system)]

    Browser -->|HTTP Request| Controller
    Controller -->|Uses| Model
    Model --> DAOLayer
    DAOLayer -->|JDBC| DBC
    DBC -->|SQL| DB
    DB -->|ResultSet| DBC
    DAOLayer -->|Returns Entity Objects| Controller
    Controller -->|Sets Attributes &\nForwards/Redirects| View
    View -->|HTML Response| Browser
```

---

## Layer Responsibilities

### Controller Layer (Servlets)
- Receives HTTP requests (GET / POST)
- Validates session authentication
- Reads request parameters
- Delegates all data operations to DAOs
- Sets response attributes and forwards to the appropriate JSP view

### Model Layer
**Entities** — Plain Java Objects (POJOs) representing domain objects:
- `Admin`, `Category`, `Product`, `StockHistory`

**DAO Interfaces** — Define the data contract (what operations are available):
- `AdminDAO`, `CategoryDAO`, `ProductDAO`, `StockHistoryDAO`

**DAO Implementations** — Contain all SQL logic using JDBC `PreparedStatement`:
- Located under `dao/impl/` package

**DBConnection** — Singleton-style static utility that opens a new JDBC connection per call using `DriverManager`.

### View Layer (JSP)
- Renders HTML using JSTL and EL (Expression Language)
- Receives data as `request.setAttribute(...)` from controllers
- Shared layout components: `navbar.jsp`, `sidebar.jsp` (included via `<%@ include %>`)
- All JSPs are secured under `WEB-INF/` (not directly accessible by URL)

---

## Application Entry Point & Routing

```mermaid
flowchart LR
    Root["/ (index.jsp)"] -->|forward| Login["login.jsp"]
    Login -->|POST /login| LoginCtrl["LoginServlet"]
    LoginCtrl -->|Success → redirect| Dashboard["/dashboard"]
    LoginCtrl -->|Failure → forward| Login
    Dashboard -->|Links| Categories["/categories"]
    Dashboard -->|Links| Products["/products"]
    Dashboard -->|Links| Stock["/stock"]
    Dashboard -->|Links| LowStock["/low-stock"]
    Dashboard -->|Links| AIInsights["/ai-insights"]
    AnyPage -->|GET /logout| Logout["LogoutServlet → /"]
```

**Session-based Authentication:**
All protected servlets check for `session.getAttribute("loggedInAdmin")`. If `null`, they redirect to the login page. The session is invalidated on logout.

---

## Package Structure

```
com.inventorysystem
├── controller/          ← 8 Servlets (Controllers)
│   ├── LoginServlet.java
│   ├── LogoutServlet.java
│   ├── DashboardServlet.java
│   ├── CategoryServlet.java
│   ├── ProductServlet.java
│   ├── StockServlet.java
│   ├── LowStockServlet.java
│   └── AIInsightsServlet.java
├── dao/                 ← 4 DAO Interfaces
│   ├── AdminDAO.java
│   ├── CategoryDAO.java
│   ├── ProductDAO.java
│   ├── StockHistoryDAO.java
│   └── impl/           ← 4 DAO Implementations
│       ├── AdminDAOImpl.java
│       ├── CategoryDAOImpl.java
│       ├── ProductDAOImpl.java
│       └── StockHistoryDAOImpl.java
├── model/               ← 4 Entity Classes
│   ├── Admin.java
│   ├── Category.java
│   ├── Product.java
│   └── StockHistory.java
└── utility/             ← Infrastructure
    ├── DBConnection.java
    ├── CategoryDAOTest.java
    └── TestDBConnection.java

webapp/
├── index.jsp            ← Entry point (forwards to login)
├── WEB-INF/
│   ├── web.xml          ← Deployment descriptor
│   ├── views/           ← JSP Views (7 pages)
│   │   ├── login.jsp
│   │   ├── dashboard.jsp
│   │   ├── categories.jsp
│   │   ├── products.jsp
│   │   ├── stock.jsp
│   │   ├── low_stock.jsp
│   │   └── ai_insights.jsp
│   └── partials/        ← Reusable JSP fragments
│       ├── navbar.jsp
│       └── sidebar.jsp
└── assets/
    ├── css/
    ├── js/
    └── images/
```
