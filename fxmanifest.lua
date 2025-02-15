fx_version "adamant"
game "gta5"
dependency "vrp"
author "NFR#1824"
description "NFR HUDS."
shared_script "config.lua"

client_scripts {
    "client/*.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server/*.lua"
}
ui_page {
    "html/index.html"
}

files {
    "html/*.*"
}

export 'Notify'