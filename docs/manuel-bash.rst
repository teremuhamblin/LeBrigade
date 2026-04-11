===========================================================
 Manuel Bash — EBrigade OS V2
 Unité OPS – Automatisation & Scripts tactiques
===========================================================

Ce document constitue la référence officielle (fictive) de l’Unité
LeBrigade pour l’écriture, la maintenance et l’exploitation de scripts
Bash dans l’environnement **EBrigade OS V2**.

Il couvre :

- la définition d’un script Bash
- les fondamentaux du langage
- les bonnes pratiques OPS
- la structure recommandée
- les modules dynamiques
- un template militaire standard
- les normes COMSEC & sécurité

-----------------------------------------------------------
1. Définition d’un script Bash
-----------------------------------------------------------

Un script Bash est un fichier texte contenant une suite d’instructions
interprétées par **Bash** (*Bourne Again SHell*). Il permet d’automatiser
des tâches, d’administrer un système, de manipuler des fichiers, de
gérer des processus ou de créer des interfaces TUI.

Caractéristiques :

- interprété (pas compilé)
- portable sur la majorité des distributions Linux
- puissant grâce aux utilitaires GNU
- idéal pour l’automatisation système
- extensible via fonctions, modules, pipes, redirections

Un script commence toujours par un *shebang* ::

    #!/usr/bin/env bash

-----------------------------------------------------------
2. Fondamentaux Bash
-----------------------------------------------------------

2.1 Variables
=============

Variables simples ::

    NAME="EBrigade"
    echo "$NAME"

Tableaux ::

    arr=("alpha" "bravo" "charlie")
    echo "${arr[1]}"

Variables d’environnement ::

    export PATH="/usr/local/bin:$PATH"

2.2 Conditions
==============

::

    if [ "$x" -gt 10 ]; then
        echo "Supérieur"
    elif [ "$x" -eq 10 ]; then
        echo "Égal"
    else
        echo "Inférieur"
    fi

2.3 Boucles
===========

Boucle *for* ::

    for f in *.txt; do
        echo "Fichier : $f"
    done

Boucle *while* ::

    while true; do
        echo "Boucle infinie"
        sleep 1
    done

2.4 Fonctions
=============

::

    log() {
        echo "[LOG] $1"
    }

2.5 Gestion des erreurs
=======================

::

    set -euo pipefail
    trap 'echo "[ERREUR] Ligne $LINENO"' ERR

2.6 Lecture utilisateur
=======================

::

    read -rp "Entrez votre nom : " NAME

2.7 Couleurs ANSI
=================

::

    GREEN="\e[32m"
    RESET="\e[0m"
    echo -e "${GREEN}Succès${RESET}"

2.8 Arguments
=============

::

    if [ "${1-}" = "-h" ]; then
        echo "Aide"
    fi

2.9 Logs
========

::

    logfile="/var/log/ebrigade.log"
    echo "$(date) - Action" >> "$logfile"

-----------------------------------------------------------
3. Modules dynamiques
-----------------------------------------------------------

EBrigade OS V2 charge automatiquement les modules présents dans
``modules/`` ::

    MODULES_DIR="./modules"

    for module in "$MODULES_DIR"/*.sh; do
        source "$module"
    done

Chaque module doit respecter :

- un en-tête militaire
- une fonction principale
- un nom cohérent (ex : ``system.sh``)

-----------------------------------------------------------
4. Structure recommandée d’un script OPS
-----------------------------------------------------------

::

    #!/usr/bin/env bash
    # ============================================================
    #  Script : system_scan.sh
    #  Unité  : LeBrigade / EBrigade OS V2
    #  Objet  : Analyse système militaire-fictive
    # ============================================================
    set -euo pipefail

    C_GREEN="\e[32m"
    C_RED="\e[31m"
    C_RESET="\e[0m"

    log() {
        echo -e "${C_GREEN}[OPS]${C_RESET} $1"
    }

    error() {
        echo -e "${C_RED}[ERREUR]${C_RESET} $1" >&2
    }

    scan_disk() {
        log "Analyse des disques..."
        df -h
    }

    scan_cpu() {
        log "Analyse CPU..."
        lscpu
    }

    main() {
        log "Démarrage du scan complet"
        scan_disk
        scan_cpu
        log "Scan terminé"
    }

    main "$@"

-----------------------------------------------------------
5. Normes OPS & COMSEC
-----------------------------------------------------------

- ``set -euo pipefail`` obligatoire
- aucune donnée sensible en clair
- logs horodatés
- validation stricte des entrées utilisateur
- permissions minimales
- modules isolés et contrôlés
- cohérence militaire-fictive obligatoire

-----------------------------------------------------------
6. Template universel pour scripts Bash
-----------------------------------------------------------

::

    #!/usr/bin/env bash
    # ============================================================
    #  Script : <nom_du_script>.sh
    #  Unité  : LeBrigade / EBrigade OS V2
    #  Objet  : <description>
    # ============================================================
    set -euo pipefail

    # --- Couleurs ---
    C_GREEN="\e[32m"
    C_RED="\e[31m"
    C_YELLOW="\e[33m"
    C_RESET="\e[0m"

    # --- Fonctions OPS ---
    log()    { echo -e "${C_GREEN}[OPS]${C_RESET} $1"; }
    warn()   { echo -e "${C_YELLOW}[ALERTE]${C_RESET} $1"; }
    error()  { echo -e "${C_RED}[ERREUR]${C_RESET} $1" >&2; }

    # --- Point d’entrée ---
    main() {
        log "Initialisation du module <nom>"
        # Code ici
        log "Opération terminée"
    }

    main "$@"

-----------------------------------------------------------
7. Licence
-----------------------------------------------------------

Projet publié sous licence **LeBrigade Public Domain – FOMECBLOT**.
