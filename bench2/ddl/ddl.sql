CREATE TABLE logs (
  log_time    TIMESTAMP NOT NULL,
  client_ip   VARCHAR(15) NOT NULL,
  request     VARCHAR(1000) NOT NULL,
  status_code SMALLINT NOT NULL,
  object_size BIGINT NOT NULL
);
