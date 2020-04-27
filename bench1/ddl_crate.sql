CREATE TABLE logs (
  log_time timestamp NOT NULL,
  machine_name string NOT NULL,
  machine_group string NOT NULL,
  cpu_idle float,
  cpu_nice float,
  cpu_system float,
  cpu_user float,
  cpu_wio float,
  disk_free float,
  disk_total float,
  part_max_used float,
  load_fifteen float,
  load_five float,
  load_one float,
  mem_buffers float,
  mem_cached float,
  mem_free float,
  mem_shared float,
  swap_free float,
  bytes_in float,
  bytes_out float
)
WITH (
  number_of_replicas = 0,
  refresh_interval = 0
);
