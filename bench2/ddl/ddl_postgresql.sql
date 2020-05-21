CREATE TABLE logs (
  log_time    TIMESTAMP NOT NULL,
  client_ip   INET NOT NULL,
  request     VARCHAR(1000) NOT NULL,
  status_code SMALLINT NOT NULL,
  object_size BIGINT NOT NULL
);

CREATE INDEX idx_log_time ON logs (log_time);

CREATE INDEX idx_client_ip ON logs (client_ip);
CREATE INDEX idx_request ON logs (request);
CREATE INDEX idx_status_code ON logs (status_code);
CREATE INDEX idx_object_size ON logs (object_size);
