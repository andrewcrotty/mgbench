CREATE TABLE logs (
  log_time    TIMESTAMP NOT NULL,
  client_ip   IP NOT NULL,
  request     STRING NOT NULL,
  status_code SHORT NOT NULL,
  object_size LONG NOT NULL
)
WITH (
  number_of_replicas = 0,
  refresh_interval = 0
);
