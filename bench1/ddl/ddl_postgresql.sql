CREATE TABLE logs (
  log_time      TIMESTAMP NOT NULL,
  machine_name  VARCHAR(25) NOT NULL,
  machine_group VARCHAR(15) NOT NULL,
  cpu_idle      FLOAT,
  cpu_nice      FLOAT,
  cpu_system    FLOAT,
  cpu_user      FLOAT,
  cpu_wio       FLOAT,
  disk_free     FLOAT,
  disk_total    FLOAT,
  part_max_used FLOAT,
  load_fifteen  FLOAT,
  load_five     FLOAT,
  load_one      FLOAT,
  mem_buffers   FLOAT,
  mem_cached    FLOAT,
  mem_free      FLOAT,
  mem_shared    FLOAT,
  swap_free     FLOAT,
  bytes_in      FLOAT,
  bytes_out     FLOAT
);

CREATE INDEX idx_log_time ON logs (log_time);

CREATE INDEX idx_machine_name ON logs (machine_name);
CREATE INDEX idx_machine_group ON logs (machine_group);
CREATE INDEX idx_cpu_idle ON logs (cpu_idle);
CREATE INDEX idx_cpu_nice ON logs (cpu_nice);
CREATE INDEX idx_cpu_system ON logs (cpu_system);
CREATE INDEX idx_pu_user ON logs (cpu_user);
CREATE INDEX idx_cpu_wio ON logs (cpu_wio);
CREATE INDEX idx_disk_free ON logs (disk_free);
CREATE INDEX idx_disk_total ON logs (disk_total);
CREATE INDEX idx_part_max_used ON logs (part_max_used);
CREATE INDEX idx_load_fifteen ON logs (load_fifteen);
CREATE INDEX idx_load_five ON logs (load_five);
CREATE INDEX idx_load_one ON logs (load_one);
CREATE INDEX idx_mem_buffers ON logs (mem_buffers);
CREATE INDEX idx_mem_cached ON logs (mem_cached);
CREATE INDEX idx_mem_free ON logs (mem_free);
CREATE INDEX idx_mem_shared ON logs (mem_shared);
CREATE INDEX idx_swap_free ON logs (swap_free);
CREATE INDEX idx_bytes_in ON logs (bytes_in);
CREATE INDEX idx_bytes_out ON logs (bytes_out);
