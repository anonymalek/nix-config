config.load_autoconfig(False)

c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]
c.window.title_format = "[{id}] {perc}{current_title}{title_sep}qutebrowser"
config.bind("<ctrl-v>", "spawn mpv {url}", mode="normal")
config.bind("J", "tab-prev", mode="normal")
config.bind("K", "tab-next", mode="normal")
