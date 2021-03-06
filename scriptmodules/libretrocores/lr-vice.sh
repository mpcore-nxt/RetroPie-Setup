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

rp_module_id="lr-vice"
rp_module_desc="C64 emulator - port of VICE for libretro"
rp_module_help="ROM Extensions: .crt .d64 .g64 .prg .t64 .tap .x64 .zip .vsf\n\nCopy your Commodore 64 games to $romdir/c64"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vice-libretro/master/vice/COPYING"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-vice() {
    gitPullOrClone "$md_build" https://github.com/libretro/vice-libretro.git
}

function build_lr-vice() {
    if isPlatform "sun8i"; then
        make -f Makefile.libretro clean
        make -f Makefile.libretro platform=classic_armv7_a7 ARCH=arm
    elif isPlatform "sun50i"; then
        make -f Makefile.libretro clean
        make -f Makefile.libretro platform=sun50i
    else
        make -f Makefile.libretro clean
        make -f Makefile.libretro
    fi
    md_ret_require="$md_build/vice_x64_libretro.so"
}

function install_lr-vice() {
    md_ret_files=(
        'vice/data'
        'vice/COPYING'
        'vice_x64_libretro.so'
    )
}

function configure_lr-vice() {
    mkRomDir "c64"
    ensureSystemretroconfig "c64"

    cp -R "$md_inst/data" "$biosdir"
    chown -R $user:$user "$biosdir/data"

    addEmulator 1 "$md_id" "c64" "$md_inst/vice_x64_libretro.so"
    addSystem "c64"
}
