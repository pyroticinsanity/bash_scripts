#!/bin/bash -x

set -e

INPUT="${1%/}"
OUTPUT="${2%/}"
DRYRUN=

if [ -z "${INPUT}" ] || [ -z "${OUTPUT}" ]; then
	echo "Invalid parameters"
	exit 1
fi

move_file()
{
	EXTENSION="$1"
	
	if [ -f "${INPUT}${EXTENSION}" ]; then
		${DRYRUN} mv "${INPUT}${EXTENSION}" "${OUTPUT}${EXTENSION}"
		
		if [ -f "${INPUT}.sm" ]; then
			${DRYRUN} sed "s/${INPUT}${EXTENSION}/${OUTPUT}${EXTENSION}/g" "${INPUT}.sm" > "${INPUT}".sm.bak
			${DRYRUN} mv "${INPUT}".sm.bak "${INPUT}".sm
		fi
	fi
}

if [ -d "${INPUT}" ]; then
	pushd "${INPUT}"
	
	move_file ".png"
	move_file "-bg.png"
	move_file "-jacket.png"
	move_file "-bn.png"
	move_file ".mp3"
	move_file ".sm"
	move_file ".dwi"
	move_file ".avi"
	
	popd
	
	${DRYRUN} mv "${INPUT}" "${OUTPUT}"
fi

