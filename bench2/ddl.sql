CREATE TABLE logs (
  log_time timestamp NOT NULL,
  client_ip inet NOT NULL,
  request varchar(1000) NOT NULL,
  status_code smallint NOT NULL,
  object_size bigint NOT NULL
);
