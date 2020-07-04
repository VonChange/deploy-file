

-XX:MaxRAMFraction=1

java -server -XX:+PrintCommandLineFlags Benchmark 

java -XX:+PrintCommandLineFlags -version 

java -XX:+PrintFlagsFinal <GC options> -version | grep MaxHeapSize
java -server -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+PrintFlagsFinal Benchmark

export JAVA_TOOL_OPTIONS="-XX:-OmitStackTraceInFastThrow -XX:ActiveProcessorCount=1  -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMPercentage=95.0 -XX:InitialRAMPercentage=50.0 -XX:MinRAMPercentage=50.0 $JAVA_OPTS"
-XX:-UseAdaptiveSizePolicy

xms 1/64 xmx 1/4

-XX:MaxRAMPercentage=90 -XX:InitialRAMPercentage=50
-XX:MinRAMPercentage=50

java11  -XX:+UseContainerSupport 

-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap

-XX:MaxRAMFraction

-XX:+HeapDumpOnOutOfMemoryError
```
FROM maven:3.5-jdk-11 as BUILD

COPY . /usr/src/app
RUN mvn --batch-mode -f /usr/src/app/pom.xml clean package

FROM openjdk:11-jdk
ENV PORT 4567
EXPOSE 4567
COPY --from=BUILD /usr/src/app/target /opt/target
WORKDIR /opt/target

CMD ["/bin/bash", "-c", "find -type f -name '*-with-dependencies.jar' | xargs java -jar"]

```
find -type f -name '*.jar' | xargs 

test=$(find target -name '*.jar'|head -n 1) 

app=${test##*/}
```
#!/bin/bash
limit_in_bytes=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)

# If not default limit_in_bytes in cgroup
if [ "$limit_in_bytes" -ne "9223372036854771712" ]
then
    limit_in_megabytes=$(expr $limit_in_bytes \/ 1048576)
    heap_size=$(expr $limit_in_megabytes - $RESERVED_MEGABYTES)
    export JAVA_OPTS="-Xmx${heap_size}m $JAVA_OPTS"
    echo JAVA_OPTS=$JAVA_OPTS
fi

exec catalina.sh run

``


```
/sys/fs/cgroup/memory/ memory.limit_in_bytes(limit) cpu.cfs_period_us
cpu.cfs_quota_us cpu.shares(request)

```