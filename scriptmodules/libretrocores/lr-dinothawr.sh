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

rp_module_id="lr-dinothawr"
rp_module_desc="Dinothawr - standalone libretro puzzle game"
rp_module_help="Dinothawr game assets are automatically installed to $romdir/ports/dinothawr/"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/Dinothawr/master/LICENSE"
rp_module_section="exp"

function sources_lr-dinothawr() {
    gitPullOrClone "$md_build" https://github.com/libretro/Dinothawr.git
}

function build_lr-dinothawr() {
    if isPlatform "sun8i"; then
        make clean
        make platform=classic_armv7_a7 ARCH=arm
    elif isPlatform "sun50i"; then
        make clean
        make platform=sun50i
    else
        make clean
        make
    fi
    md_ret_require="$md_build/dinothawr_libretro.so"
}

function install_lr-dinothawr() {
    md_ret_files=(
        'dinothawr_libretro.so'
        'dinothawr'
    )
}


function configure_lr-dinothawr() {
    setConfigRoot "ports"

    addPort "$md_id" "dinothawr" "Dinothawr" "$md_inst/dinothawr_libretro.so" "$romdir/ports/dinothawr/dinothawr.game"

    mkRomDir "ports/dinothawr"
    ensureSystemretroconfig "ports/dinothawr"

    cp -Rv "$md_inst/dinothawr" "$romdir/ports"

    chown $user:$user -R "$romdir/ports/dinothawr"
}
