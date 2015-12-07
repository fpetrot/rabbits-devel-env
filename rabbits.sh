#!/bin/bash
#
# This file is part of Rabbits
# Copyright (C) 2015  Clement Deschamps and Luc Michel
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

srcs_dir() {
    (cd $(dirname "$1"); pwd)
}

SRCS_DIR="$(srcs_dir $0)"
REPOS="${SRCS_DIR}"/repos

if [[ ! -x $REPOS ]] ; then
    echo "repos script not found."
    exit 1
fi

if [[ "$(basename $0)" != "rabbits.sh" ]]; then
    pname=$(basename $0)
    pname=${pname/.sh/}
    platform="-platform $pname"
fi

BUILD="$("$REPOS" build-dir)"

RABBITS="$BUILD"/rabbits/rabbits/rabbits

if [[ ! -x "$RABBITS" ]] ; then
    echo "rabbits not found. Did you build the project?"
    exit 1
fi

export SYSTEMC_DISABLE_COPYRIGHT_MESSAGE=1
export RABBITS_DYNLIB_PATH="$("$REPOS" print-dynlib-path)"

exec $RABBITS_EXEC_PREFIX "$RABBITS" \
    -global.config-dir "$SRCS_DIR"/config $platform \
    -global.resource-dir "$SRCS_DIR"/build/.res \
    "$@"

# vim: ts=4 sw=4 sts=0 expandtab
