#!/usr/bin/env python3
#
# Do not use, this is only for testing

from os import listdir
import json

json_file_name = 'metadata.json'

aarch64_folder = 'build/prefix/lib/wine/aarch64-windows'
i368_folder = 'build/prefix/lib/wine/i386-windows'

json_template = {
    "uuid": "00000000-0000-0000-0000-000000000000",
    "name": "Canela Runtime",
    "version": 1,
    "author": "MixedVictor",
    "description": "This runtime links all the DLL files available to inside the prefix",
    "prefixLinks": {
        "runtime.reg": "runtime.reg",
        "dlls/aarch64-w64-mingw32/bin/libwow64fex.dll": "drive_c/windows/system32/libwow64fex.dll",
        "dlls/aarch64-w64-mingw32/bin/d3d9.dll": "drive_c/windows/system32/d3d9.dll",
        "dlls/aarch64-w64-mingw32/bin/d3d10core.dll": "drive_c/windows/system32/d3d10core.dll",
        "dlls/aarch64-w64-mingw32/bin/d3d11.dll": "drive_c/windows/system32/d3d11.dll",
        "dlls/aarch64-w64-mingw32/bin/dxgi.dll": "drive_c/windows/system32/dxgi.dll",
        "dlls/aarch64-w64-mingw32/bin/libgallium_wgl.dll": "drive_c/windows/system32/libgallium_wgl.dll",
        "dlls/aarch64-w64-mingw32/bin/libz.dll": "drive_c/windows/system32/libz.dll",
        "dlls/aarch64-w64-mingw32/bin/opengl32.dll": "drive_c/windows/system32/opengl32.dll",
        "dlls/i686-w64-mingw32/bin/d3d9.dll": "drive_c/windows/syswow64/d3d9.dll",
        "dlls/i686-w64-mingw32/bin/d3d10core.dll": "drive_c/windows/syswow64/d3d10core.dll",
        "dlls/i686-w64-mingw32/bin/d3d11.dll": "drive_c/windows/syswow64/d3d11.dll",
        "dlls/i686-w64-mingw32/bin/dxgi.dll": "drive_c/windows/syswow64/dxgi.dll",
        "dlls/i686-w64-mingw32/bin/libgallium_wgl.dll": "drive_c/windows/syswow64/libgallium_wgl.dll",
        "dlls/i686-w64-mingw32/bin/libz.dll": "drive_c/windows/syswow64/libz.dll",
        "dlls/i686-w64-mingw32/bin/opengl32.dll": "drive_c/windows/syswow64/opengl32.dll",
    }
}

files_aarch64_folder = [file for file in listdir(aarch64_folder) if not file.endswith('.a')]
files_i368_folder = [file for file in listdir(i368_folder) if not file.endswith('.a')]

for file in files_aarch64_folder:
    json_template['prefixLinks'][f"lib/wine/aarch64-windows/{file}"] = f"drive_c/windows/system32/{file}"

for file in files_i368_folder:
    json_template['prefixLinks'][f"lib/wine/i386-windows/{file}"] = f"drive_c/windows/syswow64/{file}"

with open(json_file_name, 'w') as json_file:
    json.dump(json_template, json_file, indent=4)

print("JSON file and saved as: ", json_file_name)