# MgBench
A new analytical benchmark for machine-generated log data.

## Data

1. **bench1:** http://cs.brown.edu/people/acrotty/mgbench/bench1.tar.gz
2. **bench2:** http://cs.brown.edu/people/acrotty/mgbench/bench2.tar.gz
3. **bench3:** http://cs.brown.edu/people/acrotty/mgbench/bench3.tar.gz

## Preliminary Results

### Benchmark 1

| System       | Load       | Q1        | Q2        | Q3        | Q4        | Q5        | Q6        |
| :----------- | :--------: | :-------: | :-------: | :-------: | :-------: | :-------: | :-------: |
| ClickHouse   | 35.811     | 0.019     | 0.046     | 0.065     | 0.035     | 0.058     | **0.047** |
| CrateDB      | 1088.347   | 0.013     | 0.011     | 0.023     | 0.015     | 1.387     | 0.337     |
| Druid        |  |  |  |  |  |  |  |
| Hyper        | 32.561     | 0.029     | 0.023     | 0.029     | 0.025     | 0.026     | 0.054     |
| MonetDB      | 31.042     | 0.021     | 0.007     | 0.025     | **0.012** | **0.018** | 0.180     |
| PostgreSQL   | 133.738    | 0.879     | 0.766     | 0.958     | 0.868     | 1.198     | 2.574     |
|  +Index Time | 145.596    | 0.876     | 0.765     | 0.958     | 1.292     | 1.202     | 2.575     |
|  +Index All  | 403.432    | 0.129     | 0.005     | 0.047     | 0.563     | 1.501     | 0.457     |
| SparkSQL     | **1.247**  | 4.234     | 7.127     | 4.786     | 3.891     | 3.867     | 4.006     |
| TimescaleDB  | 164.904    | 0.376     | 0.417     | 0.757     | 0.408     | 1.622     | 3.581     |
|  +Index All  | 375.263    | **0.010** | **0.001** | **0.015** | 0.071     | 1.341     | 0.188     |

### Benchmark 2

| System       | Load       | Q1        | Q2        | Q3        | Q4        | Q5        | Q6        |
| :----------- | :--------: | :-------: | :-------: | :-------: | :-------: | :-------: | :-------: |
| ClickHouse   | 32.006     | 0.032     | 0.116     | N/A       | 0.067     | 0.238     | **0.345** |
| CrateDB      | N/A        | 0.009     | 0.089     | 3.699     | 1.789     | 13.619    | 11.282    |
| Druid        |  |  |  |  |  |  |  |
| Hyper        | 26.421     | 0.049     | 0.056     | N/A       | **0.061** | **0.208** | 0.390     |
| MonetDB      | 26.446     | 0.012     | **0.052** | 3.233     | 0.150     | 0.828     | 2.262     |
| PostgreSQL   | 145.774    | 1.123     | 1.866     | 2.019     | 2.044     | 54.801    | 17.835    |
|  +Index Time | 213.160    | 0.287     | 0.174     | **1.124** | 2.042     | 53.386    | 17.835    |
|  +Index All  | 610.496    | 0.281     | 2.172     | 4.099     | 2.043     | 53.389    | 17.834    |
| SparkSQL     | **4.167**  | 14.850    | 7.542     | N/A       | 6.158     | 6.671     | 6.929     |
| TimescaleDB  | 276.865    | 0.080     | 0.125     | N/A       | 1.451     | 57.758    | 17.376    |
|  +Index All  | 522.875    | **0.001** | 0.117     | N/A       | 1.449     | 57.694    | 17.374    |

### Benchmark 3

| System       | Load       | Q1        | Q2        | Q3        | Q4        | Q5        | Q6        |
| :----------- | :--------: | :-------: | :-------: | :-------: | :-------: | :-------: | :-------: |
| ClickHouse   |  |  |  |  |  |  |  |
| CrateDB      |  |  |  |  |  |  |  |
| Druid        |  |  |  |  |  |  |  |
| Hyper        |  |  |  |  |  |  |  |
| MonetDB      |  |  |  |  |  |  |  |
| PostgreSQL   |  |  |  |  |  |  |  |
|  +Index Time |  |  |  |  |  |  |  |
|  +Index All  |  |  |  |  |  |  |  |
| SparkSQL     |  |  |  |  |  |  |  |
| TimescaleDB  |  |  |  |  |  |  |  |
|  +Index All  |  |  |  |  |  |  |  |
