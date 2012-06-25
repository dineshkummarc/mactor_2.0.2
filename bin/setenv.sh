# ---------------------------------------------------------------------------
# Environment script for MActor
# ---------------------------------------------------------------------------

# MActor core dependencies
CLASSPATH=$MACTOR_HOME/lib:$MACTOR_HOME/lib/dom4j-1.6.1.jar:$MACTOR_HOME/lib/log4j-1.2.14.jar:$MACTOR_HOME/lib/commons-logging-1.1.jar

# MActor 'very useful functionality' dependendecies
CLASSPATH=$CLASSPATH:$MACTOR_HOME/lib/jaxen-1.1.jar:$MACTOR_HOME/lib/bsh-2.0b4.jar:$MACTOR_HOME/lib/wsdl4j.jar

# libraries requiered when using MActor with IBM Series (NOTE: use the com.ibm.mq.jar from your copy of MQ Series!) 
CLASSPATH=$CLASSPATH:$MACTOR_HOME/lib/j2ee.jar:$MACTOR_HOME/lib/com.ibm.mq.jar

# libraries requiered when using MActor with WebLogic (JMS)
CLASSPATH=$CLASSPATH:$MACTOR_HOME/lib/wlclient.jar:$MACTOR_HOME/lib/wljmsclient.jar

# libraries requiered when using MActor with Oracle DB (NOTE: use the file from your copy)
CLASSPATH=$CLASSPATH:$MACTOR_HOME/lib/ojdbc14_g.jar

# libraries requiered when using MActor with HSQLDB (NOTE: use the file from your download)
CLASSPATH=$CLASSPATH:$MACTOR_HOME/hsqldb.jar

# libraries requiered when using MActor with ActiveMQ (NOTE: use the file from your download)
CLASSPATH=$CLASSPATH:$MACTOR_HOME/lib/activemq-all-5.0.0.jar

# libraries requiered when using MActor with TIBCO Rv (NOTE: use the file from your copy)
CLASSPATH=$CLASSPATH:$MACTOR_HOME/lib/tibrvj.jar

jre_12=`$JAVA_HOME/bin/java -version 2>&1 | grep 1.2
jre_13=`$JAVA_HOME/bin/java -version 2>&1 | grep 1.3
jre_14=`$JAVA_HOME/bin/java -version 2>&1 | grep 1.4
jre_15=`$JAVA_HOME/bin/java -version 2>&1 | grep 1.5
jre_16=`$JAVA_HOME/bin/java -version 2>&1 | grep 1.6`



if [ "$jre_12" ]; then
echo "Mactor requieres JRE 1.5 or newer, JRE 1.2 found"
  exit 1
elif [ "$jre_13" ]; then
  echo "Mactor requieres JRE 1.5 or newer, JRE 1.3 found"
  exit 1
elif [ "$jre_14" ]; then
 echo "Mactor requieres JRE 1.5 or newer, JRE 1.4 found"
 exit 1
elif [ "$jre_15" ]; then
  CLASSPATH=$MACTOR_HOME/lib/mactor_jre15.jar:$CLASSPATH
else
  CLASSPATH=$MACTOR_HOME/lib/mactor_jre16.jar:$CLASSPATH
fi
