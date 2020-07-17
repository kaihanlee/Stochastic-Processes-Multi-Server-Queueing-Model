## Project 1

# Background
A scheduler on a workstation accepts jobs and dispatches them to processing units which complete them. We would like to understand the utilization of an existing workstation and the optimal number of processing units.

# Modelling Assumptions
To help you with the report you are provided you with the following information:
- The workstation has n=7 processing units and has an internal scheduler that maintains a queue of Waiting jobs.
- When a new job arrives, the scheduler checks:
    - If there are any Idle processing units, the job is assigned to a processing unit (picked randomly).
    - Otherwise, the job is added to the Waiting queue.
- When a processing unit is done processing the job it was assigned to, the scheduler assigns another job to it from the queue (picked randomly), if one exists.
- The length of each job is exponentially distributed with mean length 6 sec.
- Jobs arrival follows a Poisson process with rate 2 sec􀀀1.
- Jobs arrival is independent from their processing times.
- It is estimated that a delayed job costs 1:25 pence for every second it spends in the Waiting queue.
- The operating cost of a processing unit is 1:5 pence per second if it is Working and 1 pence if it is idle.

# Points to address
We are interested in understanding the performance metrics of the current workstation which has n=7 processing units. Then, we want to select the optimal number of cores, n, to minimize the total operational cost.
When reporting results, we are interested in the following metrics:
- The utilization of the processing units, i.e. the proportion of time they are working.
- The average number of idle processors in a second.
- The average number of jobs in the queue in a second.
- The operational cost of the system.
HINT: Assume that the scheduler has a maximum number of jobs m after which it simply rejects jobs. Then investigate what large value of m is sufficient to get a correct answer.
