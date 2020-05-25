CREATE TABLE logs (
  log_time    TIMESTAMP NOT NULL,
  client_ip   IP NOT NULL,
  request     TEXT NOT NULL,
  status_code SMALLINT NOT NULL,
  object_size BIGINT NOT NULL
)
WITH (
  number_of_replicas = 0,
  refresh_interval = 0
);
