#include <amxmodx>
#include <cstrike>
#include <fun>

// Health limit
#define LIMIT 100

// Delay after kill to get hp/armor
#define DELAY 0.1

new g_round;

public plugin_init()
{
    register_plugin("HP+AP After Kill", "0.1", "IGOROT");
    register_event("DeathMsg", "event_DeathMsg", "a");
    register_event("HLTV", "event_NewRound", "a", "1=0", "2=0");
}

public event_DeathMsg()
{
    static killer, victim;
    killer = read_data(1);
    victim = read_data(2);
    if(!is_user_connected(killer) || !is_user_connected(victim) || !is_user_alive(killer))
        return;
    
    static data[2];
    data[0] = g_round;
    set_task(DELAY, "task_GiveHealthAndArmor", killer, data, 2);
}

public event_NewRound()
    g_round++;

public task_GiveHealthAndArmor(data[], killer)
{
    if(data[0] != g_round)
        return;
    
    cs_set_user_armor(killer, 100, CS_ARMOR_VESTHELM);
    set_user_health(killer, min(LIMIT, get_user_health(killer) + 35));
}
