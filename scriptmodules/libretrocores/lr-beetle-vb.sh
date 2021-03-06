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

rp_module_id="lr-beetle-vb"
rp_module_desc="Virtual Boy emulator - Mednafen VB (optimised) port for libretro"
rp_module_help="ROM Extensions: .vb .zip\n\nCopy your Virtual Boy roms to $romdir/virtualboy"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-vb-libretro/master/COPYING"
rp_module_section="opt"
rp_module_flags=""

function sources_lr-beetle-vb() {
    gitPullOrClone "$md_build" https://github.com/libretro/beetle-vb-libretro.git
}

function build_lr-beetle-vb() {
    local params=(NEED_STEREO_SOUND=1 FRONTEND_SUPPORTS_RGB565=1)
    if isPlatform "sun8i"; then
        make clean
        make platform=classic_armv7_a7 ARCH=arm "${params[@]}"
    elif isPlatform "sun50i"; then
        make clean
        make platform=sun50i "${params[@]}"
    else
        make clean
        make "${params[@]}"
    fi
    make clean
    make "${params[@]}"
    md_ret_require="$md_build/mednafen_vb_libretro.so"
}

function install_lr-beetle-vb() {
    md_ret_files=(
        'mednafen_vb_libretro.so'
    )
}

function configure_lr-beetle-vb() {
    mkRomDir "virtualboy"
    ensureSystemretroconfig "virtualboy"

    addEmulator 1 "$md_id" "virtualboy" "$md_inst/mednafen_vb_libretro.so"
    addSystem "virtualboy"
}
