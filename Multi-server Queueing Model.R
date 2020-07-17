lambda=0.5        #per second
lengthjob=6       #unit: second
mu=1/lengthjob    #parameter for exponential distribution
idlecost=1        #cost per second of an IDLE machine
workcost=1.5      #cost per second of a WORKING machine
waitcost=1.25     #cost per second of a WAITING job

j=100     #number of cores
Finalidlenum=rep(0,j)     #empty vector of average number of IDLE processors per second
Finalworknum=rep(0,j)     #empty vector of average number of WORKING processors per second
Finalwaitnum=rep(0,j)     #empty vector of average number of WAITING jobs per second
TotalExpectedCost=rep(0,j)      #empty vector of TotalExpectedCost
Finalutil=rep(0,j)

for(k in 1:j){    #repeat for different number of cores

m=k              #assumption
n=5               #number of processing units

#generate empty transition rate matrix Q
Q=matrix(data=0,nrow=n+m+1,ncol=n+m+1,dimnames=list(c(0:(n+m)),c(0:(n+m))),byrow=T)

#fill in Q matrix with transition rates
for(j in 1:(n+m+1)){
  for(i in 1:(n+m+1)){
    if(i+1==j){
      Q[i,j]=lambda
    }
    if(i==j+1 & i<=(n+1)){
      Q[i,j]=(i-1)*mu
    }
    if(i==j+1 & i>(n+1)){
      Q[i,j]=(n)*mu
    }
  }
}

for(j in 1:(n+m+1)){          #fill in diagonal with compliments
  for(i in 1:(n+m+1)){
    if(i==j){
      Q[i,j]=-1*sum(Q[i,])
      }
    }
  }

QT=t(Q)       #transpose of Q matrix

QT[(n+m+1),]=1      #replace the last row of matrix QT with 1

#solve utilization of the processing units
stndist=solve(QT)%*%(matrix(data=(c(rep(0,(n+m)),1)),(n+m+1),1))
stndist=c(stndist)        #get utilization in vector form

#plot graph of utilization as state increases
plot(stndist,type="l", main="Stationary Distribution")
min(stndist)        #get minimum of stationary distribution

idlenum=rep(0,n+m+1)        #empty vector for number of IDLE machines per second
worknum=rep(0,(n+m+1))      #empty vector for number of WORKING machines per second
waitnum=rep(0,m+1)          #empty vector for number of WAITING jobs per second

for(i in 1:(n+m+1)){        #calculate number of IDLE,WORKING,WAITING per second
  if(i<=(n+1)){
  idlenum[i]=((n+1)-i)*stndist[i]
  worknum[i]=(i-1)*stndist[i]
  }
  else{
  worknum[i]=n*stndist[i]
  waitnum[i]=(i-n-1)*stndist[i]
  }
}

#calculate the average number of IDLE and WORKING processors and WAITING jobs per second of the system
totalidlenum=sum(idlenum)
totalworknum=sum(worknum)
totalwaitnum=sum(waitnum)
util=totalworknum/n

totalcost=(totalidlenum*idlecost)+(totalworknum*workcost)+(totalwaitnum*waitcost)

Finalidlenum[k]=totalidlenum        #average number of IDLE processors per second for each k
Finalworknum[k]=totalworknum        #average number of WORKING processors per second for each k
Finalwaitnum[k]=totalwaitnum        #average number of WAITING jobs per second for each k
Finalutil[k]=util
TotalExpectedCost[k]=totalcost      #total expected cost for each k

}
Finalidlenum              #vector of average number of IDLE processors per second
Finalworknum              #vector of average number of WORKING processors per second
Finalwaitnum              #vector of average number of WAITING jobs per second
Finalutil
TotalExpectedCost         #vector of expected costs


#plot graph of Finalidlenum,Finalworknum,Fianlwaitnum,TotalExpectedCost against n
plot(Finalidlenum,xlab="n", type="l")
plot(Finalworknum,xlab="n", type="l")
plot(Finalwaitnum,xlab="n", type="l")
plot(Finalutil,xlab="n", type="l")
plot(TotalExpectedCost,xlab="m",type="l")

min(TotalExpectedCost)            #get minimum operational cost
which.min(TotalExpectedCost)      #get optimal number of cores