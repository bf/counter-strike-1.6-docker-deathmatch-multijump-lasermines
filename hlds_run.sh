#!/usr/bin/env bash

set -axe
HLDS="/opt/hlds"

CONFIG_FILE="${HLDS}/startup.cfg"

if [ -r "${CONFIG_FILE}" ]; then
    # TODO: make config save/restore mechanism more solid
    set +e
    # shellcheck source=/dev/null
    source "${CONFIG_FILE}"
    set -e
fi

EXTRA_OPTIONS=( "$@" )

EXECUTABLE="${HLDS}/hlds_run"
GAME="${GAME:-cstrike}"
MAXPLAYERS="${MAXPLAYERS:-32}"
START_MAP="${START_MAP:-de_dust2}"
SERVER_NAME="${SERVER_NAME:-Counter-Strike 1.6 Server}"
CSDM_MODE="${CSDM_MODE:-0}"

OPTIONS=( "-game" "${GAME}" "+maxplayers" "${MAXPLAYERS}" "+map" "${START_MAP}" "+hostname" "\"${SERVER_NAME}\"")


if [ -z "${RESTART_ON_FAIL}" ]; then
    OPTIONS+=('-norestart')
fi

# AMX Admin Users by IP
if [ -n "${ADMIN_IP}" ]; then
    for ip in ${ADMIN_IP//,/ }
    do
        echo "\"${ip}\" \"\"  \"abcdefghijklmnopqrstu\" \"de\"" >> "${HLDS}/cstrike/addons/amxmodx/configs/users.ini"
    done
fi

# AMX Admin Users by Name
if [ -n "${ADMIN_NAME}" ] && [ -n "${ADMIN_PASSWORD}" ]; then
    for name in ${ADMIN_NAME//,/ }
    do
	if [[ $name = STEAM* ]]; then
	        echo "\"${name}\" \"\"  \"abcdefghijklmnopqrstu\" \"ce\"" >> "${HLDS}/cstrike/addons/amxmodx/configs/users.ini"
	else
		echo "\"${name}\" \"${ADMIN_PASSWORD}\"  \"abcdefghijklmnopqrstu\" \"a\"" >> "${HLDS}/cstrike/addons/amxmodx/configs/users.ini"
	fi
    done
    echo "rcon_password \"${ADMIN_PASSWORD}\"" >> "${HLDS}/cstrike/server.cfg"
fi

# Set Server Password
if [ -n ${SERVER_PASSWORD} ]; then
    echo "sv_password \"${SERVER_PASSWORD}\"" >> "${HLDS}/cstrike/server.cfg"
fi

# Enable AMX Plugins
# echo "restmenu.amxx             ; Restrict Weapons" >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
#echo "deathbeams.amxx           ; Death Beams" >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "multijump.amxx		; Multijump" >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "bullet-damage.amxx	; Bullet damage" >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
#echo "hsonly.amxx               ; HeadShot Only" >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "parachute.amxx            ; Parachute" >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "hp-ap-after-kill.amxx	; HP & AP After Kill" >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "client-checker.amxx	; Client Checker" >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "fire-in-the-hole-remover.amxx	; removes chat messages " >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "ammo-refill.amxx		; csdm refill ammo after kill " >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
#echo "antiblock.amxx		; antiblock " >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
#echo "cs_team_semiclip.amxx		; cs team semiclip " >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "no-objectives.amxx	; no objectives " >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "admin-online.amxx		; admin online status " >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "ultimate_sounds.amxx	; ultimate sound package " >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
echo "lasermine.amxx		; lasermine " >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"

# enable geoip module for client-checker
sed -ri "s/;geoip.*/geoip/g; s/;fakemeta.*/fakemeta/g; s/;engine.*/engine/g; s/;hamsandwich.*/hamsandwich/;" "${HLDS}/cstrike/addons/amxmodx/configs/modules.ini"


# Disable AMX Messages
#sed -ri 's/(adminhelp|multilingual|adminchat|antiflood|scrollmsg|imessage|adminvote)\.amxx.*//g' "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
sed -ri 's/amx_scrollmsg .*/amx_scrollmsg "\%hostname\%" 600/g; s/amx_imessage .*/amx_imessage "\%hostname\%" "000100255"/g' "${HLDS}/cstrike/addons/amxmodx/configs/amxx.cfg"
sed -ri 's/(multilingual|statsx)\.amxx.*//g; s/;miscstats.*/miscstats.amxx/g; ' "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"


# Enable YaPB Bots
if [ "${YAPB_ENABLED}" -eq 1 ];then
    YAPB_PASSWORD="${YAPB_PASSWORD:-yapb}"

    echo "linux addons/yapb/bin/yapb.so" >> "${HLDS}/cstrike/addons/metamod/plugins.ini"
    echo "yb_password \"${YAPB_PASSWORD}\"" >> "${HLDS}/cstrike/addons/yapb/conf/yapb.cfg"
    echo "amxx_yapbmenu.amxx      ; YAPB Menu" >> "${HLDS}/cstrike/addons/amxmodx/configs/plugins.ini"
fi

# Enable CSDM
if [ "${CSDM_MODE}" -ge 1 ]; then
     echo 'csdm_active "1"' >> "${HLDS}/cstrike/server.cfg"
     sed -ri 's/^menus =.*/menus = ps/; s/^autoitems =.*/autoitems = ahg/; s/^grenades =.*/grenades = hs/g;' "${HLDS}/cstrike/addons/amxmodx/configs/csdm.cfg"
else
    echo 'csdm_active "0"' >> "${HLDS}/cstrike/server.cfg"
fi

if [ "${CSDM_MODE}" -ge 2 ]; then
     echo 'csdm_ffa_enable "1"' >> "${HLDS}/cstrike/server.cfg"
     echo 'mp_freeforall "1"' >> "${HLDS}/cstrike/server.cfg"
fi

set > "${CONFIG_FILE}"

exec "${EXECUTABLE}" "${OPTIONS[@]}" "${EXTRA_OPTIONS[@]}"
