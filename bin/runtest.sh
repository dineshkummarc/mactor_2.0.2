#!/bin/sh
# -----------------------------------------------------------------------------
#  Script for running MActor tests (files of type test, test_run and mock_battery) 
# 
#  Required Environment Variables
# 
#    JAVA_HOME       Points to the Java Development Kit installation.
# 
#  Optional Environment Variables
#  
#    MACTOR_HOME    Points to the MActor installation directory.
# 
#  ---------------------------------------------------------------------------

cygwin=false
case "`uname`" in
CYGWIN*) cygwin=true;;
esac

# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin; then
  [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
  [ -n "$MACTOR_HOME" ] && MACTOR_HOME=`cygpath --unix "$MACTOR_HOME"`
  [ -n "$CLASSPATH" ] && CLASSPATH=`cygpath --path --unix "$CLASSPATH"`
fi

if [ -z "$JAVA_HOME" ]; then
  echo "The JAVA_HOME environment variable is not set."
  echo "This is required to run MActor."
  exit 1
fi
if [ ! -r "$JAVA_HOME"/bin/java ]; then
  echo "The JAVA_HOME environment variable is not set correctly."
  echo "This is required to run MActor."
  exit 1
fi
_RUNJAVA="$JAVA_HOME"/bin/java


# Guess MACTOR_HOME if it is not set
if [ -z "$MACTOR_HOME" ]; then
# resolve links - $0 may be a softlink
  PRG="$0"
  while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '.*/.*' > /dev/null; then
      PRG="$link"
    else
      PRG=`dirname "$PRG"`/"$link"
    fi
  done

  PRGDIR=`dirname "$PRG"`
  MACTOR_HOME=`cd "$PRGDIR/.." ; pwd`
elif [ ! -r "$MACTOR_HOME"/bin/setenv.sh ]; then
  echo "The MACTOR_HOME environment variable is not set correctly."
  echo "This is required to run MActor."
  exit 1
fi

# Set CLASSPATH to empty by default. User jars can be added via the setenv.sh
# script
CLASSPATH=

if [ -r "$MACTOR_HOME"/bin/setenv.sh ]; then
  . "$MACTOR_HOME"/bin/setenv.sh
fi

# For Cygwin, switch paths to Windows format before running java
if $cygwin; then
  JAVA_HOME=`cygpath --path --windows "$JAVA_HOME"`
  MACTOR_HOME=`cygpath --path --windows "$MACTOR_HOME"`
  CLASSPATH=`cygpath --path --windows "$CLASSPATH"`
fi

echo "Using MACTOR_HOME: $MACTOR_HOME"
echo "Using JAVA_HOME:    $JAVA_HOME"
echo "Using CLASSPATH:    $CLASSPATH"

echo "Note that MActor 2.0.1 or newer requieres Java Runtime 1.6 or newer"

exec "$_RUNJAVA" -classpath "$CLASSPATH" -Xmx500M -Dfile.encoding=UTF-8 org.mactor.ui.cmd.MActorCmd "$@"

