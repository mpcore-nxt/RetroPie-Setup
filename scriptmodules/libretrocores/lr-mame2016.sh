#!/usr/bin/env bash

# This file is part of The Microplay Project 
# based on The RetroPie Project
#
# only for sun8i, sun50i (like Allwinner H2+/H3/A64/H5)
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-mame2016"
rp_module_desc="MAME emulator - MAME 0.174 port for libretro"
rp_module_help="ROM Extension: .zip\n\nCopy your MAME roms to either $romdir/mame-libretro or\n$romdir/arcade"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/mame2016-libretro/master/LICENSE.md"
rp_module_section="exp"

function sources_lr-mame2016() {
    gitPullOrClone "$md_build" https://github.com/libretro/mame2016-libretro.git
}

function build_lr-mame2016() {
    rpSwap on 1200
    local params=($(_get_params_lr-mame) SUBTARGET=arcade)
    if isPlatform "sun8i"; then
        make -f Makefile.libretro clean
        make -f Makefile.libretro "${params[@]}"
    elif isPlatform "sun50i"; then
        make -f Makefile.libretro clean
        make -f Makefile.libretro "${params[@]}"
    else
        make -f Makefile.libretro clean
        make -f Makefile.libretro "${params[@]}"
    fi
    rpSwap off
    md_ret_require="$md_build/mamearcade2016_libretro.so"
}

function install_lr-mame2016() {
    md_ret_files=(
        'mamearcade2016_libretro.so'
    )
}

function configure_lr-mame2016() {
    local system
    for system in arcade mame-libretro; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 0 "$md_id" "$system" "$md_inst/mamearcade2016_libretro.so"
        addSystem "$system"
    done
}
