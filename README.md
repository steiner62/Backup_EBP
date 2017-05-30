# Backup_EBP
Script Powershell + bat pour copie de sauvegarde des fichiers écriture et compte avant import dans EBP Comptabilité


# Conseils : 
  - regrouper les fichier dans un même dossier nommé powershell.
  - ce dossier doit contenir obligatoirement les fichiers backupEBP.ps1, config.ini, run_powershell.bat et NOM_DOSSIER_COMPTABILITE.ebp (ce dernier n'est pas mis à disposition sur le github)
  
  
# Le fichier config.ini
Ce dernier contient six variables : 
  - client qui doit être le NOM_DOSIER_COMPTABILITE
  - path est le chemin où sont enregistrer les fichiers ecritures.txt et comptes.txt généré par votre logiciel de facturation.
  - pathsauve est le chemin où sera copie les fichiers ecritures.txt et comptes.txt.
  - pathscript est le chemin où sont stocker les fichiers a exécuter
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
 - Modifier le fichier run_powershell.bat et run_powershell_DEBUG_MODE.bat pour éditer le chemin du script powershell
 - créer un raccourcie sur le bureau du fichier run_powershell.bat et changer son icône pour avoir l'icône d'EBP
 - faite un test de fonctionnement en créent des fichiers comptes.txt et ecritures.txt vide
 
 
# Licence
Script à la disposition de tous seul contraite garder l'identité de son créateur dans l'entête du script


EN translation :
# Backup_EBP
Script Powershell + beats for backup of files and accounts before importing into EBP Accounting

# Advice:
    - Group the files in the same folder named powershell.
    - This folder must contain the files backupEBP.ps1, config.ini, run_powershell.bat and NOM_DOSSIER_COMPTABILITE.ebp (the latter is not available on the github)

# The config.ini file
The latter contains six variables:

    - Client that must be the NOM_DOSIER_COMPTABILITE
    - Path is the path where the files writes.txt and accounts.txt generated by your billing software are saved.
    - Pathsauve is the path where the files writes.txt and accounts.txt will be copied.
    - Pathscript is the path where the files to run
    - Timeout delay during which the files will not be deleted from the export folder (by default 10 minutes as 00:10:00)
    - Version is the current version of the script intended for an automatic update (intended for a later version)

# Why this script:
In the third-party billing software, SAGE formatted exports have an automatic copy in the C: ***** \ Maestria \ SAUVE folder, but no copy is made if there is another format of the " export.

# Principle of operation
The script checks for the existence of the files writes.txt and accounts.txt in the folder C: * \ Maestria and makes a copy of it in C: * \ Maestria \ SAUVE or copies and deletes the files if they have an excessive presence time (10 minutes by default) and then opens the EBP accounting and generates processing logs in a file backupEBP_logs.txt.

# Installation

    - Clone the github files in a subfolder
    - Copy / paste the .ebp file from your customer's accounting folder into the same folder (usually found in My Documents or in C: \ Users \ Administrator \ Documents)
    - Edit config.ini file according to your needs
    - Modify the file run_powershell.bat and run_powershell_DEBUG_MODE.bat to edit the path of the powershell script
    - Create a shortcut on the desktop of the run_powershell.bat file and change its icon to have the EBP icon
    - Made a test of operation by creating empty accounts.txt and writes.txt files

# Licence
Script available to all alone to keep the identity of its creator in the header of the script
