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

rp_module_id="lr-snes9x"
rp_module_desc="Super Nintendo emu - Snes9x (current) port for libretro"
rp_module_help="ROM Extensions: .bin .smc .sfc .fig .swc .mgd .zip\n\nCopy your SNES roms to $romdir/snes"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/snes9x/master/docs/snes9x-license.txt"
rp_module_section="opt"

function sources_lr-snes9x() {
    gitPullOrClone "$md_build" https://github.com/libretro/snes9x.git
}

function build_lr-snes9x() {
    cd libretro
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
    md_ret_require="$md_build/libretro/snes9x_libretro.so"
}

function install_lr-snes9x() {
    md_ret_files=(
        'libretro/snes9x_libretro.so'
        'docs'
    )
}

function configure_lr-snes9x() {
    mkRomDir "snes"
    ensureSystemretroconfig "snes"

    addEmulator 0 "$md_id" "snes" "$md_inst/snes9x_libretro.so"
    addSystem "snes"
}
