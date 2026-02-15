# MSBA-Portfolio-UgoAchara

# 📊 Case Competition Modeling Overview  
This repository contains the full analytical workflow used to understand customer behavior, quantify churn risk, and build a high‑performance prediction system. The project integrates **K‑Means Clustering**, **Logistic Regression**, and **XGBoost**, combining segmentation, interpretability, and predictive accuracy.

---

## 🔹 1. K‑Means Clustering: Customer Segmentation  
**Objective:** Identify natural customer groups based on behavior, service usage, and account characteristics.

### **Process**
- Applied one‑hot encoding to categorical variables and standardized numeric features.  
- Selected features representing engagement, service adoption, and billing patterns.  
- Tested multiple values of *k* using the **Elbow Method** and **Silhouette Score**.  
- Used **PCA** to visualize clusters and improve interpretability.

### **Outcome**
K‑Means revealed distinct customer personas, such as:  
- Short‑tenure, month‑to‑month customers with high churn risk  
- Long‑tenure, contract‑based customers with low churn risk  
- Moderate‑tenure customers with high tech‑support usage  

These segments informed targeted retention strategies and validated patterns seen in supervised models.

---

## 🔹 2. Logistic Regression: Interpretable Churn Prediction  
**Objective:** Quantify the direction and strength of churn drivers using a transparent, business‑friendly model.

### **Process**
- Split data into training and testing sets.  
- Applied class balancing to address churn imbalance.  
- Standardized numeric variables and encoded categorical features.  
- Trained logistic regression with L2 regularization to prevent overfitting.

### **Key Insights**
- Month‑to‑month contracts significantly increase churn probability.  
- Lack of tech support is a major churn driver.  
- Higher monthly charges correlate with higher churn risk.  
- Longer tenure strongly reduces churn likelihood.

Logistic Regression provided clear interpretability and validated the behavioral patterns identified in clustering.

---

## 🔹 3. XGBoost: High‑Performance Predictive Modeling  
**Objective:** Build a powerful, non‑linear model capable of accurately identifying high‑risk customers.

### **Process**
- Tuned hyperparameters (learning rate, max depth, number of estimators).  
- Used cross‑validation to ensure generalization.  
- Evaluated performance using AUC, accuracy, precision, and recall.  
- Extracted feature importance to understand model behavior.

### **Results**
XGBoost delivered the strongest predictive performance, capturing complex interactions and ranking the most influential features, including:  
- Contract type  
- Tenure  
- Monthly charges  
- Tech support  
- Internet service type  

These results aligned with both the logistic regression coefficients and the K‑Means cluster profiles.

---

## 🔹 Integrated Interpretation  
Using all three models together created a comprehensive analytical framework:

| Model | Purpose | Strength |
|-------|---------|----------|
| **K‑Means** | Discover customer personas | Unsupervised segmentation |
| **Logistic Regression** | Explain churn drivers | High interpretability |
| **XGBoost** | Predict churn with high accuracy | Captures complex patterns |

This combined approach enabled targeted, data‑driven retention strategies with measurable business impact.

---

If you want, I can also format:

- A shorter README version  
- A slide‑ready version  
- A technical appendix version  
- A version with code blocks included  

Just tell me the style you want next.
