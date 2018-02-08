#!/bin/bash
# downloads a websites content to a directory specified by user via command line arguments

displayUsage () {
cat <<-EOF


    Usage: ${0:2} [options]

    example: download-web-content.sh -dn=<website url> -p=<full website url path>

      -dn | --domain-name            | restrict the website to pull content from
       -p | --page                   | restrict the content downloaded to the page
       -w | --wait                   | wait some time before downloading 




EOF

exit 1
}

for i in "$@"
do
  case $i in
    -dn=*|--domain-name=*)
    DOMAIN_NAME="${i#*=}"
    shift # past argument=value
    ;;
    -p=*|--page=*)
    PAGE="${i#*=}"
    shift # past argument=value
    ;;
    -w=*|--wait=*)
    WAIT="${i#*=}"
    shift # past argument=value
    ;;
    *) # unknown option
    ;;
  esac
done

# validate required variables have been set
if [ -z "$DOMAIN_NAME" ]; then echo "No domain was specified." && displayUsage; fi
if [ -z "$PAGE" ]; then echo "No page was specified." && displayUsage; fi
if [ -z "$WAIT" ]; then echo "No wait was specified." && displayUsage; fi

wget \
     --continue \
     --recursive \
     --no-clobber \
     --page-requisites \
     --html-extension \
     --convert-links \
     --restrict-file-names=windows \
     --domains $DOMAIN_NAME \
     --no-parent www.$PAGE/ \
     --wait=$WAIT \
     ––random-wait \
