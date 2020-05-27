CREATE TABLE logs (
  log_time     TIMESTAMP NOT NULL,
  device_id    TEXT NOT NULL,
  device_name  TEXT NOT NULL,
  device_type  TEXT NOT NULL,
  device_floor SMALLINT NOT NULL,
  event_type   TEXT NOT NULL,
  event_unit   TEXT,
  event_value  FLOAT
)
WITH (
  number_of_replicas = 0,
  refresh_interval = 0
);
