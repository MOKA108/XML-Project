# 🏡 DataPipeline Project – ESTATEPLATEFORME

## 📌 Overview

This project is a collaborative academic effort aimed at designing and querying an XML-based database simulating a real estate platform operating in the French Riviera. It involves modeling, schema definition (XSD), and a series of data transformations and queries using **XSLT**, **Python**, and **XML tools**.

The platform, named `ESTATEPLATEFORME`, centralizes data from key real estate entities: **prospects, properties, sellers/lessors, suppliers**, and **transactions**.

---

## 🧱 Structure

The XML database is composed of five main branches:

- `PROSPECTS` – Registered user profiles with preferences and contact info  
- `IMMOPRODUCTS` – Real estate offers (rental/sale)  
- `SELLERS` – Individuals/entities listing the properties  
- `SUPPLIERS` – Service providers for property maintenance  
- `TRANSACTIONS` – Log of completed or in-progress transactions  

Each section uses **unique keys** and **foreign key references** to ensure data consistency and relational integrity.

---

## 📐 Schema (XSD)

- Extensive use of `xs:key`, `xs:keyref` for entity linking  
- Custom `xs:simpleType` and `xs:complexType` definitions (e.g., `ADDRESStype`, `IMMOPRICEtype`)  
- Restrictions applied using `xs:restriction`, `enumeration`, and regex patterns for better data control  
- Trade-off decisions made between schema control and transformation functionality (e.g., date types)

---

## 🔍 Queries & Transformations

### ✅ Implemented Use Cases

| Query | Description | Technology |
|-------|-------------|------------|
| a.| Recursive listing of suppliers in Monaco area | XSLT |
| b.| Market analysis: studio prices by city (no parking) | XSLT (Muenchian grouping) |
| c.| Transaction history sorted by date & prospect | XSLT |
| d.| Matching offers to user preferences (Nice rentals) | XSLT |
| e.| Extract on-call suppliers and output HTML | Python (ElementTree) |
| f.| Seller profile builder with conditional logic | XSLT |
| g.| Transaction data converted to structured JSON | XSLT |

---

## 💡 Highlights

- XSLT 1.0 used with advanced techniques such as **recursion** and **Muenchian grouping**
- Schema-first approach ensuring **data consistency** and **interoperability**
- Combination of business logic and technical XML/XSLT skills
- Output formats: **HTML**, **JSON**, **XML**

---

## 🔧 Tools & Technologies

- **Languages**: XML, XSD, XSLT, Python  
- **Tools**: Visual Studio Code, Notepad++, ElementTree (Python), web browsers  
- **Reference Models**: logic-immo.com, bienici.com, leboncoin.fr  

---

## 👨‍💻 Authors

- Marie-Caroline Bertheau  
- Arnaud G.  
- Ronald L.
- Damien Rondet 

---

## 📂 Project Files

- Schema – XML Schema Definition (XSD)  
- Database – Sample XML database  
- Queries – XSLT files for HTML/JSON transformations, Python scripts for data extraction, Generated HTML / JSON / XML result files  
- Report 

---

## 📈 Future Enhancements

- Implement grouping and sorting using XSLT 2.0 or XQuery
- Integrate with a lightweight front-end viewer for live queries
- Convert to hybrid data pipeline using SQL + XML for faster analytics

---

## 🧠 Learn More

- [XSLT by Doug Tidwell](https://www.oreilly.com/library/view/xslt/0596000537/)  
- [XSLT Cookbook by Sal Mangano](https://learning.oreilly.com/library/view/xslt-cookbook-2nd/0596009747/)

