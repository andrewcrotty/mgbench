CREATE TABLE logs (
  log_time timestamp NOT NULL,
  client_ip ip NOT NULL,
  request string NOT NULL,
  status_code short NOT NULL,
  object_size long NOT NULL
)
WITH (
  number_of_replicas = 0,
  refresh_interval = 0
);
