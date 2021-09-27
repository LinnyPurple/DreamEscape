/// @description Initialize enemy

// As enemies are added, give them an instance number
inst_num = instance_number(obj_enemy) - 1;
// Check if HP <= 0, then consider it dead
enemy_state_alive = true;