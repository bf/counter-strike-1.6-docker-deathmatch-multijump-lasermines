FROM hlds-amxmodx:latest

LABEL maintainer = "Dmitry Zarva <zarv1k@gmail.com>"

USER cstrike

# Install Deathbeams AMX plugin
COPY --chown=cstrike:cstrike mod/deathbeams/deathbeams.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/deathbeams.amxx

# Install HeadShot Only AMX Plugin
COPY --chown=cstrike:cstrike mod/hsonly/hsonly.sma /opt/hlds/cstrike/addons/amxmodx/scripting/hsonly.sma
COPY --chown=cstrike:cstrike mod/hsonly/hsonly.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/hsonly.amxx
COPY --chown=cstrike:cstrike mod/hsonly/hs_only.txt /opt/hlds/cstrike/addons/amxmodx/data/lang/hs_only.txt

# Install multijump AMX plugin
COPY --chown=cstrike:cstrike mod/multijump/multijump.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/multijump.amxx

# laser mines plugin
COPY --chown=cstrike:cstrike mod/lasermine/lasermine.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/lasermine.amxx

# bullet damage plugin, see https://forums.alliedmods.net/showpost.php?p=1131441&postcount=45
COPY --chown=cstrike:cstrike mod/bullet-damage/bullet-damage.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/bullet-damage.amxx

# hp-ap-after-kill plugin, see https://forums.alliedmods.net/showthread.php?p=919795
COPY --chown=cstrike:cstrike mod/hp-ap-after-kill/hp-ap-after-kill.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/hp-ap-after-kill.amxx

# client-checker plugin, see https://forums.alliedmods.net/showthread.php?p=393427
COPY --chown=cstrike:cstrike mod/client-checker/client-checker.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/client-checker.amxx
COPY --chown=cstrike:cstrike mod/client-checker/ClientChecker.cfg /opt/hlds/cstrike/addons/amxmodx/configs/ClientChecker.cfg
COPY --chown=cstrike:cstrike mod/client-checker/chk_cvars.cfg /opt/hlds/cstrike/addons/amxmodx/configs/chk_cvars.cfg

# Install YaPB Bots
COPY --chown=cstrike:cstrike mod/yapb /opt/hlds/cstrike/addons/yapb
COPY --chown=cstrike:cstrike mod/yapbmenu/amxx_yapbmenu.sma /opt/hlds/cstrike/addons/amxmodx/scripting/amxx_yapbmenu.sma
COPY --chown=cstrike:cstrike mod/yapbmenu/amxx_yapbmenu.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/amxx_yapbmenu.amxx

# fire in the hole remover, see https://forums.alliedmods.net/showthread.php?t=98922
COPY --chown=cstrike:cstrike mod/fire-in-the-hole-remover/fire-in-the-hole-remover.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/fire-in-the-hole-remover.amxx

# csdm ammo refill, see https://forums.alliedmods.net/showpost.php?p=2193293&postcount=23
COPY --chown=cstrike:cstrike mod/ammo-refill/ammo-refill.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/ammo-refill.amxx

# # antiblock, see https://forums.alliedmods.net/showpost.php?p=1955532&postcount=123
# COPY --chown=cstrike:cstrike mod/antiblock/antiblock.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/antiblock.amxx

# no oibjectives, from https://forums.alliedmods.net/showthread.php?t=53812
COPY --chown=cstrike:cstrike mod/no-objectives/no-objectives.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/no-objectives.amxx

# admin online, see https://forums.alliedmods.net/showthread.php?t=92762
COPY --chown=cstrike:cstrike mod/admin-online/admin-online.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/admin-online.amxx

# install parachute plugin
COPY --chown=cstrike:cstrike mod/parachute/parachute.sma /opt/hlds/cstrike/addons/amxmodx/scripting/parachute.sma
COPY --chown=cstrike:cstrike mod/parachute/parachute.amxx /opt/hlds/cstrike/addons/amxmodx/plugins/parachute.amxx
COPY --chown=cstrike:cstrike mod/parachute/parachute.mdl /opt/hlds/cstrike/models/parachute.mdl

# Apply metamod default plugins
COPY --chown=cstrike:cstrike image/cs16-server/plugins.ini /opt/hlds/cstrike/addons/metamod/plugins.ini

# Dproto config
COPY --chown=cstrike:cstrike mod/dproto/dproto.cfg /opt/hlds/cstrike/dproto.cfg

# add team semi clip, see https://forums.alliedmods.net/showthread.php?t=137980
# add ultimate sounds pack, see https://forums.alliedmods.net/attachment.php?attachmentid=67247&d=1275855421
COPY --chown=cstrike:cstrike packages/amxmodx/ /opt/hlds/cstrike/addons/amxmodx/
COPY --chown=cstrike:cstrike packages/sound/ /opt/hlds/cstrike/sound/

# Add maps
COPY --chown=cstrike:cstrike maps/* /opt/hlds/cstrike/maps/
COPY --chown=cstrike:cstrike config/mapcycle.txt /opt/hlds/cstrike/mapcycle.txt
COPY --chown=cstrike:cstrike config/maps.ini /opt/hlds/cstrike/addons/amxmodx/configs/maps.ini

# Add Entrypoint script
COPY --chown=cstrike:cstrike hlds_run.sh /bin/hlds_run.sh

# Add default server config
COPY --chown=cstrike:cstrike config/server.cfg /opt/hlds/cstrike/server.cfg

WORKDIR /opt/hlds

ENTRYPOINT ["/bin/hlds_run.sh"]
