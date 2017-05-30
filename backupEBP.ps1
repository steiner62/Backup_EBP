##################################################
#                                                #
#    Traitement des fichiers d'export ICAR       #
#    Version : 1.10 du 22/05/2017                #
#    Réalisé par : Alexandre MANTEL (am@c-e-i.fr)#
#    Mis a disposition de la société CEI         #
#                                                #
##################################################

#### Les variables personnalisable récupéré dans le fichier config.ini ####
$chemin = Get-Location
$file = "$chemin"+"\config.ini"

$ini = @{}
switch -regex -file $file
{
     "^\[(.+)\]$"
     {
            $section = $matches[1]
            $ini[$section] = @{}
     }
     "(.+)=(.*)"
     {
            $name, $value = $matches[1..2]
            $ini[$section][$name] = $value
     }
}

$local:version = $ini.Variables.version        #La version du script pour la gestion interne
$local:client = $ini.Variables.client          #Nom du client pour l'ouverture du dossier
$local:path = $ini.Variables.path              #le chemin où sont enregistré les fichiers généré d'icar
$local:pathSauve=$ini.Variables.pathsauve      #le chemin où sont enregistré les fichiers copier
$local:timeout = $ini.Variables.timeout        #Le temps avant que les fichiers ne soit supprimer du dossier $path

## test des variables pour DEBUG ##
#write-host $version
#write-host $client
#write-host $path
#write-host $pathSauve
#write-host $timeout

####    Les variables pour le pré-post EBP    ####
$listefichiers = "ecritures","comptes"  #liste des noms de fichier à traiter
$appli = "$path"+"\powershell\"+"$client"+".ebp"  #chemin du raccourcie EBP

#Partie pour la gestion de logs des traitements
$date_systeme= get-date
$date_logs= $date_systeme.tostring('dd/MM/yyyy H:mm:ss')
$logs = "$path"+"\powershell\backupEBP_Logs.txt"
ADD-content -path $logs -value "#######################################"
ADD-content -path $logs -value "# Traitement du : $date_logs #"
ADD-content -path $logs -value "#######################################"

#pour éviter des messages d'erreur dans le .bat contrôle de la présence de certain fichier
If ((Test-Path "$path\ecritures.txt")){

#On récupère la date de modification du fichier en 2 étapes
$c= get-item "$path\ecritures.txt" 
$d = $c.LastWriteTime 

$date_lastwrite = $d.tostring('ddMMyy_Hmmss') #On formate la date  pour la datation des fichiers déplacé et copier

$date_systeme= get-date #on récupère la date système
#write-host $date_systeme
$date_modif =  (($date_systeme) - ($d)) #on calcul la différence entre la date système et la date de modification du fichier
#write-host $date_modif

if ($date_modif -gt $timeout) {
 #si le fichier à plus de 10 minutes il ai déplacer et renommé par rapport à sa date de modification 
    #Pour chaque fichier de la liste on fait le traitement suivant
    # 1°)on le déplace dans le dosier SAUVE
    # 2°)On le renomme avec la datation au format jour mois année puis Heure minutes et secondes
    foreach ($fichier in $listefichiers)
    {
        $rename = "$fichier"+"_"+"$date_lastwrite.txt" 
        #Vérification de l'existance des fichiers dans le dossier SAUVE si il sont présent on supprime les fichiers ecritures et comptes
        If (-not (Test-Path "$pathSauve\$rename")){
            move-item -path "$path\$fichier.txt" -destination $pathSauve 
            rename-item "$pathSauve\$fichier.txt" -newname $rename
            write-host "Fichier copier sous le nom $rename et supprimé. `n`r"
            ADD-content -path $logs -value " Fichier copier sous le nom $rename et supprimé. `n`r"
            }
        else{
            #write-host "$rename EXISTE..."
            remove-item -path "$path\$fichier.txt" -force
            write-host "Fichier déjà copier sous le nom $rename et supprimé. `n`r"
            ADD-content -path $logs -value " Fichier déjà copier sous le nom $rename et supprimé. `n`r"
            }
    }
 
} 
else {
    #write-host "jeune fichier"
        #Pour chaque fichier de la liste on fait le traitement suivant
        # 1°)on le copie dans le dosier SAUVE
        # 2°)On le renomme avec la datation au format jour mois année puis Heure minutes et secondes
        foreach ($fichier in $listefichiers)
        {
            $rename = "$fichier"+"_"+"$date_lastwrite.txt"
            If (-not (Test-Path "$pathSauve\$rename")){
            copy-item -path "$path\$fichier.txt" -destination $pathSauve 
            rename-item "$pathSauve\$fichier.txt" -newname $rename -force
            write-host "Fichier copier sous le nom $rename avant import. `n`r"
            ADD-content -path $logs -value " Fichier copier sous le nom $rename avant import. `n`r"
            }
            else{
            write-host "$fichier.txt est en attente d'importation dans la comptabilité.`n`r"
            ADD-content -path $logs -value " $fichier.txt est en attente d'importation dans la comptabilité.`n`r"
            }
        }
    }

#On lance la comptabilité EBP

Start-Process $appli
ADD-content -path $logs -value " Lancement de la comptabilité. `n`r"
ADD-content -path $logs -value "  `n`r"
write-host "Lancement de la comptabilité. `r"
} 
else {
#si le fichier ecritures.txt n'ai pas présent on lance l'application directement
write-host "Aucun fichier ecritures.txt ou comptes.txt trouvé.`n`r"
ADD-content -path $logs -value " Aucun fichier ecritures.txt ou comptes.txt trouvé.`n`r"
write-host "Lancement de la comptabilité. `n`r"
ADD-content -path $logs -value " Lancement de la comptabilité. `n`r"
ADD-content -path $logs -value "  `n`r"

#On lance la comptabilité EBP
Start-Process $appli

}
