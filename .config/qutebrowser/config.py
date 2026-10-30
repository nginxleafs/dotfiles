import os

config.load_autoconfig(False)  # всё живёт только в этом файле

# ── Цвета из DMS ──────────────────────────────────────
_dms = os.path.join(config.configdir, "dms-colors.py")
if os.path.exists(_dms):
    config.source("dms-colors.py")

# ── Загрузки: без вопросов ────────────────────────────
c.downloads.location.directory = "~/Downloads"
c.downloads.location.prompt = False
c.downloads.remove_finished = 10000  # мс, убирать из панели
c.downloads.position = "bottom"
c.content.pdfjs = True  # PDF открывать в браузере
c.content.tls.certificate_errors = "load-insecurely"
RU_LOW = "йцукенгшщзхъфывапролджэячсмитьбю"
EN_LOW = "qwertyuiop[]asdfghjkl;'zxcvbnm,."
RU_UP = "ЙЦУКЕНГШЩЗФЫВАПРОЛДЯЧСМИТЬ"
EN_UP = "QWERTYUIOPASDFGHJKLZXCVBNM"

km = c.bindings.key_mappings
km.update(dict(zip(RU_LOW, EN_LOW)))
km.update(dict(zip(RU_UP, EN_UP)))
km.update({"Ж": ":", "Х": "{", "Ъ": "}", "ё": "`"})

# комбинации с модификаторами: Ctrl-у → Ctrl-e, Alt-з → Alt-p и т. д.
for ru, en in zip(RU_LOW, EN_LOW):
    km[f"<Ctrl-{ru}>"] = f"<Ctrl-{en}>"
    km[f"<Alt-{ru}>"] = f"<Alt-{en}>"
# ── Bitwarden (через userscript qute-bitwarden) ───────
BW_MENU = "fuzzel --dmenu"
BW_PASS = "fuzzel --dmenu --password --prompt 'Master password: '"
BW = (
    f"spawn --userscript qute-bitwarden "
    f"--dmenu-invocation '{BW_MENU}' "
    f"--password-prompt-invocation '{BW_PASS}'"
)

for mode in ("normal", "insert"):
    key = ",p" if mode == "normal" else "<Alt-p>"
    config.bind(key, BW, mode)
config.bind(",u", BW + " --username-only")
config.bind(",P", BW + " --password-only")
config.bind(",t", BW + " --totp-only")

# ── Прочее ────────────────────────────────────────────
config.bind(",r", "config-source")
c.tabs.show = "multiple"
c.statusbar.show = "in-mode"
c.auto_save.session = True
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "yt": "https://www.youtube.com/results?search_query={}",
}

c.colors.webpage.preferred_color_scheme = "dark"
# ── Adblock ───────────────────────────────────────────
c.content.blocking.enabled = True
c.content.blocking.method = "both"  # adblock + hosts

# Если задаёшь свой список, дефолтные списки заменяются, поэтому easylist тоже нужен
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
    # русскоязычный список, для gdz.ru и подобных сайтов он важен
    "https://easylist-downloads.adblockplus.org/advblock.txt",
]

# Если блокировка где-то ломает сайт:
# c.content.blocking.whitelist = ["*://*.example.com/*"]

# Реклама часто тащит автоплей, попапы и уведомления
c.content.autoplay = False
c.content.javascript.can_open_tabs_automatically = False
c.content.notifications.enabled = False
config.bind(",f", "spawn zen-browser {url}")
# ── Против зависаний: включай по одному и проверяй ────
# 1) самый частый виновник на Wayland/niri, особенно с NVIDIA:
# c.qt.force_software_rendering = "chromium"
# 2) баг с service workers:
c.qt.workarounds.remove_service_workers = True
# 3) отключить hang monitor Chromium:
