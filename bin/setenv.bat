@echo off

rem ---------------------------------------------------------------------------
rem Environment script for MActor
rem ---------------------------------------------------------------------------

rem Set up the classpath

rem MActor core dependencies
set CLASSPATH=%MACTOR_HOME%/lib;%MACTOR_HOME%/lib/dom4j-1.6.1.jar;%MACTOR_HOME%/lib/log4j-1.2.14.jar;%MACTOR_HOME%/lib/commons-logging-1.1.jar

rem MActor 'very useful functionality' dependendecies
set CLASSPATH=%CLASSPATH%;%MACTOR_HOME%/lib/jaxen-1.1.jar;%MACTOR_HOME%/lib/bsh-2.0b4.jar;%MACTOR_HOME%/lib/wsdl4j.jar

rem libraries requiered when using MActor with IBM Series (NOTE: use the com.ibm.mq.jar from your copy of MQ Series!) 
set CLASSPATH=%CLASSPATH%;%MACTOR_HOME%/lib/j2ee.jar;%MACTOR_HOME%/lib/com.ibm.mq.jar

rem libraries requiered when using MActor with WebLogic (JMS)
set CLASSPATH=%CLASSPATH%;%MACTOR_HOME%/lib/wlclient.jar;%MACTOR_HOME%/lib/wljmsclient.jar

rem libraries requiered when using MActor with Oracle DB (NOTE: use the file from your copy)
set CLASSPATH=%CLASSPATH%;%MACTOR_HOME%/lib/ojdbc14_g.jar

rem libraries requiered when using MActor with HSQLDB (NOTE: use the file from your download)
set CLASSPATH=%CLASSPATH%;%MACTOR_HOME%/hsqldb.jar

rem libraries requiered when using MActor with ActiveMQ (NOTE: use the file from your download)
set CLASSPATH=%CLASSPATH%;%MACTOR_HOME%/lib/activemq-all-5.0.0.jar

rem libraries requiered when using MActor with TIBCO Rv (NOTE: use the file from your copy)
set CLASSPATH=%CLASSPATH%;%MACTOR_HOME%/lib/tibrvj.jar


:checkJre12
"%JAVA_HOME%\bin\java" -version 2>&1 | findstr "1.2" >NUL
IF ERRORLEVEL 1 goto checkJre13
@echo "Mactor requieres JRE 1.5 or newer, JRE 1.2 found"
goto end

:checkJre13
"%JAVA_HOME%\bin\java" -version 2>&1 | findstr "1.3" >NUL
IF ERRORLEVEL 1 goto checkJre14
@echo "Mactor requieres JRE 1.5 or newer, JRE 1.3 found" 
goto end

:checkJre14
"%JAVA_HOME%\bin\java" -version 2>&1 | findstr "1.4" >NUL
IF ERRORLEVEL 1 goto checkJre15
@echo "Mactor requieres JRE 1.5 or newer, JRE 1.4 found"
goto end

:checkJre15
"%JAVA_HOME%\bin\java" -version 2>&1 | findstr "1.5" >NUL
IF ERRORLEVEL 1 goto useDefaultJre
set CLASSPATH=%MACTOR_HOME%/lib/mactor_jre15.jar;%CLASSPATH%
goto end

:end
:useDefaultJre
set CLASSPATH=%MACTOR_HOME%/lib/mactor_jre16.jar;%CLASSPATH%

set CLASSPATH="%CLASSPATH%"

