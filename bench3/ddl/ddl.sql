CREATE TABLE logs (
  log_time     TIMESTAMP NOT NULL,
  device_id    CHAR(15) NOT NULL,
  device_name  VARCHAR(25) NOT NULL,
  device_type  VARCHAR(15) NOT NULL,
  device_floor SMALLINT NOT NULL,
  event_type   VARCHAR(15) NOT NULL,
  event_unit   CHAR(1),
  event_value  FLOAT
);
