#!/bin/bash

# Runs the Melissa Business Coder Cloud API Python 3 sample.
#
# This script runs BusinessCoderPython3.py with python3, passing along the license and
# (if supplied) the lookup fields.
#
# Overall flow:
#   1. Parse the command-line options below.
#   2. Resolve the license (--license, then a prompt, then the MD_LICENSE environment variable).
#   3. Run BusinessCoderPython3.py: with the lookup fields if any was supplied, otherwise
#      with only the license (the Python program prompts for each field).
#
# Options (each takes a value):
#   --company        Business/company name to test.
#   --addressline1   Street address to test.
#   --city           City to test.
#   --state          State to test.
#   --postal         Postal code to test.
#   --country        Country to test.
#   --license        License string. If omitted, the script prompts for it; if the prompt
#                    is left blank, it falls back to MD_LICENSE. Running without --license
#                    always prompts, even when MD_LICENSE is set.
#
# Examples:
#   ./BusinessCoderPython3.sh --license "your-license"
#   ./BusinessCoderPython3.sh --company "Melissa" --addressline1 "22382 Avenida Empresa" --city "Rancho Santa Margarita" --state "CA" --postal "92688" --country "United States" --license "your-license"


######################### Constants ##########################

RED='\033[0;31m' #RED
NC='\033[0m' # No Color

######################### Parameters ##########################

company=""
addressline1=""
city=""
state=""
postal=""
country=""
license=""

# Read each --flag and its value. A flag with no value, or whose value starts with "-",
# is an error. Unrecognized options are ignored.
while [ $# -gt 0 ] ; do
  case $1 in
    --company) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'company\'.${NC}\n"  
            exit 1
        fi 

        company="$2"
        shift
        ;;
    --addressline1)  
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'addressline1\'.${NC}\n"  
            exit 1
        fi 

        addressline1="$2"
        shift
        ;;
    --city) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'city\'.${NC}\n"  
            exit 1
        fi 

        city="$2"
        shift
        ;;
    --state)         
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'state\'.${NC}\n"  
            exit 1
        fi 
        
        state="$2"
        shift
        ;;
    --postal) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'postal\'.${NC}\n"  
            exit 1
        fi 

        postal="$2"
        shift
        ;;
    --country) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'country\'.${NC}\n"  
            exit 1
        fi 

        country="$2"
        shift
        ;;
    --license) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'license\'.${NC}\n"  
            exit 1
        fi 

        license="$2"
        shift 
        ;;
  esac
  shift
done

########################## Main ############################
printf "\n===================== Melissa Business Coder Cloud API =====================\n"

# Get license (either from parameters or user input)
if [ -z "$license" ];
then
  printf "Please enter your license string: "
  read license
fi

# Check for License from Environment Variables 
if [ -z "$license" ];
then
  license=`echo $MD_LICENSE` 
fi

if [ -z "$license" ];
then
  printf "\nLicense String is invalid!\n"
  exit 1
fi

# Run project
# No lookup fields supplied -> run with only the license (the program prompts for each field);
# otherwise pass them all through. Unsupplied fields arrive as empty strings, and the
# program prompts for them.
# The postal code is passed as --postal, which argparse accepts as an abbreviation of --postalcode.
# Note: if only --company is given, the program ignores it and prompts for every field.
if [ -z "$company" ] && [ -z "$addressline1" ] && [ -z "$city" ] && [ -z "$state" ] && [ -z "$postal" ] && [ -z "$country" ];
then
    python3 BusinessCoderPython3.py --license "$license"
else
    python3 BusinessCoderPython3.py \
		--license "$license" \
		--company "$company" \
		--addressline1 "$addressline1" \
		--city "$city" \
		--state "$state" \
		--postal "$postal" \
		--country "$country"
fi
