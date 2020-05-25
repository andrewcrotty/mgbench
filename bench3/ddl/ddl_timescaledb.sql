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

SELECT CREATE_HYPERTABLE('logs', 'log_time');

CREATE INDEX idx_device_id ON logs (device_id);
CREATE INDEX idx_device_name ON logs (device_name);
CREATE INDEX idx_device_type ON logs (device_type);
CREATE INDEX idx_device_floor ON logs (device_floor);
CREATE INDEX idx_event_type ON logs (event_type);
CREATE INDEX idx_event_unit ON logs (event_unit);
CREATE INDEX idx_event_value ON logs (event_value);
