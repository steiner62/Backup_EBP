# Backup_EBP
Script Powershell + bat pour copie de sauvegarde des fichiers écriture et compte avant import dans EBP Comptabilité


# Conseils : 
  - regrouper les fichier dans un même dossier.
  - ce dossier doit contenir obligatoirement les fichiers backupEBP.ps1, config.ini, run_powershell.bat et NOM_DOSSIER_COMPTABILITE.ebp (ce dernier n'est pas mis à disposition sur le github)
  
  
# Le fichier config.ini
Ce dernier contient cinq variables : 
  - client qui doit être le NOM_DOSIER_COMPTABILITE
  - path est le chemin où sont enregistrer les fichiers ecritures.txt et comptes.txt généré par votre logiciel de facturation.
  - pathsauve est le chemin où sera copie les fichiers ecritures.txt et comptes.txt.
  - timeout délai durant lequelle les fichiers ne seront pas supprimer du dossier d'export (par défaut 10 minutes sous la forme 00:10:00)
  - version est la version actuel du script prévu pour un update automatique (prévu pour une version ultérieur)


# Pourquoi ce script :
Dans le logiciel de facturation tier, les exports d’écritures au format SAGE ont une copie automatique dans le dossier C:\*****\Maestria\SAUVE mais aucune copie n’est faite s’il y a un autre format d’export.


# Principe de fonctionnement
Le script vérifie la présence des fichiers ecritures.txt et comptes.txt dans le dossier C:\*****\Maestria et en fait une copie dans C:\*****\Maestria\SAUVE ou copie et supprime les fichiers si ils ont un temps de présence trop important (10 minutes par défaut) puis ouvre la comptabilité EBP et génération de logs de traitement dans un fichier backupEBP_logs.txt. 


# Installation
 - cloner dans un sous-dossier les fichiers du github
 - copier / coller dans ce même dossier le .ebp du dossier de comptabilité de votre client (on le trouve généralement dans Mes documents ou dans C:\Users\Administrateur\Documents)
 - Modifier le fichier config.ini selon vos besoins
 - créer un raccourcie sur le bureau du fichier run_powershell.bat et changer son icône pour avoir l'icône d'EBP
 - faite un test de fonctionnement en créent des fichiers comptes.txt et ecritures.txt vide
 
 
 
