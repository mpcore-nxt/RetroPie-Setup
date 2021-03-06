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

rp_module_id="lr-px68k"
rp_module_desc="SHARP X68000 Emulator"
rp_module_help="You need to copy a X68000 bios file (iplrom30.dat, iplromco.dat, iplrom.dat, or iplromxv.dat), and the font file (cgrom.dat or cgrom.tmp) to $romdir/BIOS/keropi. Use F12 to access the in emulator menu."
rp_module_section="exp"
rp_module_flags=""

function sources_lr-px68k() {
    gitPullOrClone "$md_build" https://github.com/libretro/px68k-libretro.git
}

function build_lr-px68k() {
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
    md_ret_require="$md_build/px68k_libretro.so"
}

function install_lr-px68k() {
    md_ret_files=(
        'px68k_libretro.so'
        'README.MD'
        'readme.txt'
    )
}

function configure_lr-px68k() {
    mkRomDir "x68000"
    ensureSystemretroconfig "x68000"

    mkUserDir "$biosdir/keropi"

    addEmulator 1 "$md_id" "x68000" "$md_inst/px68k_libretro.so"
    addSystem "x68000"
}
