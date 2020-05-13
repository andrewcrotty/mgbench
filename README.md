# MgBench
A new analytical benchmark for machine-generated log data.

## Data

1. **bench1:** http://cs.brown.edu/people/acrotty/mgbench/bench1.tar.gz
2. **bench2:** http://cs.brown.edu/people/acrotty/mgbench/bench2.tar.gz
3. **bench3:** http://cs.brown.edu/people/acrotty/mgbench/bench3.tar.gz

## Preliminary Results

### Benchmark 1

| System      | Load   | Q1    | Q2    | Q3    | Q4    | Q5    | Q6    |
| :---:       | :---:  | :---: | :---: | :---: | :---: | :---: | :---: |
| CrateDB     |  |  |  |  |  |  |  |
| Druid       |  |  |  |  |  |  |  |
| Hyper       | 32.561 | 0.029 | 0.023 | 0.029 | 0.025 | 0.026 | 0.054 |
| MonetDB     | 31.042 | 0.021 | 0.007 | 0.025 | 0.012 | 0.018 | 0.180 |
| MySQL       |  |  |  |  |  |  |  |
| PostgreSQL  |  |  |  |  |  |  |  |
| SparkSQL    |  |  |  |  |  |  |  |
| TimescaleDB |  |  |  |  |  |  |  |

### Benchmark 2

| System      | Load   | Q1    | Q2    | Q3    | Q4    | Q5    | Q6    |
| :---:       | :---:  | :---: | :---: | :---: | :---: | :---: | :---: |
| CrateDB     |  |  |  |  |  |  |  |
| Druid       |  |  |  |  |  |  |  |
| Hyper       | 26.421 | 0.049 | 0.056 | ERROR | 0.061 | 0.208 | 0.390 |
| MonetDB     | 26.446 | 0.012 | 0.052 | 3.233 | 0.150 | 0.828 | 2.262 |
| MySQL       |  |  |  |  |  |  |  |
| PostgreSQL  |  |  |  |  |  |  |  |
| SparkSQL    |  |  |  |  |  |  |  |
| TimescaleDB |  |  |  |  |  |  |  |

### Benchmark 3

| System      | Load | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 |
| :---:       | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| CrateDB     |  |  |  |  |  |  |  |
| Druid       |  |  |  |  |  |  |  |
| Hyper       |  |  |  |  |  |  |  |
| MonetDB     |  |  |  |  |  |  |  |
| MySQL       |  |  |  |  |  |  |  |
| PostgreSQL  |  |  |  |  |  |  |  |
| SparkSQL    |  |  |  |  |  |  |  |
| TimescaleDB |  |  |  |  |  |  |  |
