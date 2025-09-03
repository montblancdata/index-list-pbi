# 📐 Calcul *i+1 – i* dans Power Query (Power BI)

## 🎯 Objectif  
Sous **Excel**, comparer une valeur à la ligne précédente est immédiat avec une formule du type :  
```excel
= AUJOURD'HUI - HIER
```  

Dans **Power BI / Power Query**, ce concept de "ligne précédente" n’existe pas directement. On doit alors recourir à un **pattern générique** : *Index + List*.  

Ce projet illustre cette approche à travers un cas concret : le suivi de la **variation quotidienne de neige** mesurée par la station météo de l’Aigleton (massif de Belledonne).  

---

## ⚙️ Méthode  
1. **Créer un index**  
   Chaque ligne reçoit un identifiant unique (0, 1, 2, …).  

2. **Utiliser la colonne comme liste**  
   Dans Power Query, une colonne peut être manipulée comme une **liste**. On peut alors comparer la valeur de la ligne *i* avec celle de la ligne *i-1*.  

---

## 💻 Code clé  

```m
each if [Index] = 0 
     then null 
     else #"Index ajouté"[NEIGETOTX]{[Index]} 
        - #"Index ajouté"[NEIGETOTX]{[Index] - 1}
```

👉 Cela génère une nouvelle colonne qui calcule automatiquement :  
- `+15 cm` → chute de neige  
- `-5 cm` → fonte  
- `0 cm` → stabilité  

---

## 📂 Contenu du dépôt  
- `FULL_DATA_AIGLETON_CSV.csv` → données sources (hauteur quotidienne de neige en cm).  
- `ListIndex.pq` → script Power Query appliquant le pattern *Index + List*.  
- `README.md` → documentation du projet.  

---

## 🔄 Cas d’usage du pattern  
Au-delà de la météo, cette approche peut être utilisée pour :  
- Suivi de stocks  
- Évolution d’indicateurs financiers  
- Variation de fréquentation (commerce, tourisme, web)  

---

## 👤 Auteur  
Projet proposé par **Pierrick Girard – Data Analyst**  
Exploration, transformation et valorisation de données avec Power BI & Power Query.  
