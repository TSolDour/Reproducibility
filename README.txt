PROJET REPRODUCIBILITY

Auteur : Thomas Sol Dourdin

Ce projet vise à découvrir les bonnes pratiques de la reproductibilité dans le cadre d'analyses numériques réalisées avec R.

-> Research Compendum : organisation standardisée du projet de recherche;
-> packages 'targets' et 'renv' : gestion de workflow et maintien des versions de packages ;
-> Git/GitHub : suivi de version et travail collaboratif ;
-> Rmarkdown : production de manuscripts.

Le contenu pédagogique du projet est localisé dans le fichier Reproducibility_report.pdf.

Le projet utilise un jeu de données unique, Allo.tsv contenant 6 variables et 201 observations :
- Station : nom des stations d'échantillonnage - character
- Espece : nom des espèces échantillonnées - character
- Lot : numéro du lot d'échantillonnage - integer
- Longueurs : longueur mesuré de la coquille (cm) - numeric
- PSI : valeur de quelque chose... - numeric
- IC : Indice de condition des individus - numeric

Le nettoyage, traitement, visualisation des données ont été réalisés sous R :

   R version 4.5.2 (2025-10-31)
   Platform: x86_64-apple-darwin20
   Running under: macOS Tahoe 26.5