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

rp_module_id="lr-pokemini"
rp_module_desc="Pokemon Mini emulator - PokeMini port for libretro"
rp_module_help="ROM Extensions: .min .zip\n\nCopy your Pokemon Mini roms to $romdir/pokemini"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/PokeMini/master/LICENSE"
rp_module_section="exp"

function sources_lr-pokemini() {
    gitPullOrClone "$md_build" https://github.com/libretro/pokemini.git
}

function build_lr-pokemini() {
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
    md_ret_require="$md_build/pokemini_libretro.so"
}

function install_lr-pokemini() {
    md_ret_files=(
        'pokemini_libretro.so'
    )
}


function configure_lr-pokemini() {
    mkRomDir "pokemini"
    ensureSystemretroconfig "pokemini"

    addEmulator 1 "$md_id" "pokemini" "$md_inst/pokemini_libretro.so"
    addSystem "pokemini"
}
