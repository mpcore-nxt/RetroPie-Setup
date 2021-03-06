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

rp_module_id="lr-pcsx-rearmed"
rp_module_desc="Playstation emulator - PCSX (arm optimised) port for libretro"
rp_module_help="ROM Extensions: .bin .cue .cbn .img .iso .m3u .mdf .pbp .toc .z .znx\n\nCopy your PSX roms to $romdir/psx\n\nCopy the required BIOS file SCPH1001.BIN to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/pcsx_rearmed/master/COPYING"
rp_module_section="main"

function depends_lr-pcsx-rearmed() {
    local depends=(libpng-dev)
    isPlatform "x11" && depends+=(libx11-dev)
    getDepends "${depends[@]}"
}

function sources_lr-pcsx-rearmed() {
    gitPullOrClone "$md_build" https://github.com/libretro/pcsx_rearmed.git
}

function build_lr-pcsx-rearmed() {
    local params=(ARCH=arm USE_DYNAREC=1 HAVE_NEON=1 BUILTIN_GPU=neon)
    if isPlatform "sun8i"; then
        make -f Makefile.libretro "${params[@]}" clean
        make -f Makefile.libretro "${params[@]}"
    elif isPlatform "sun50i"; then
        make -f Makefile.libretro "${params[@]}" clean
        make -f Makefile.libretro "${params[@]}"
    else
        make -f Makefile.libretro "${params[@]}" clean
        make -f Makefile.libretro "${params[@]}"
    fi
    md_ret_require="$md_build/pcsx_rearmed_libretro.so"
}

function install_lr-pcsx-rearmed() {
    md_ret_files=(
        'AUTHORS'
        'ChangeLog.df'
        'COPYING'
        'pcsx_rearmed_libretro.so'
        'NEWS'
        'README.md'
        'readme.txt'
    )
}

function configure_lr-pcsx-rearmed() {
    mkRomDir "psx"
    ensureSystemretroconfig "psx"

    addEmulator 1 "$md_id" "psx" "$md_inst/pcsx_rearmed_libretro.so"
    addSystem "psx"
}
