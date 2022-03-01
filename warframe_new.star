load("render.star", "render")
load("http.star", "http")

WF_STATUS_URL = "https://api.warframestat.us/pc"

def main():
    rep = http.get(WF_STATUS_URL)
    if rep.status_code != 200:
        fail("Warframe request failed with status %d", rep.status_code)

    cetus = rep.json()["cetusCycle"]["shortString"]

    cambionactive = rep.json()["cambionCycle"]["active"]
    cambionremaining = rep.json()["cambionCycle"]["timeLeft"]
    cambion = "%s in %s" % (cambionremaining, cambionactive)

    vallis = rep.json()["vallisCycle"]["shortString"]

    final_string = """
    
    Cetus: %s

    Cambion: %s
    
    Vallis: %s
    """ % (cetus,cambion,vallis)

    return render.Root(
       delay = 100,
       child = render.Marquee(
            width=64,
            height=32,
            offset_start=0,
            offset_end=0,
            scroll_direction="horizontal",
            child = render.Column(
                children = [
                    render.Text("C: %s" % cetus),
                    render.Text("D: %s" % cambion),
                    render.Text("V: %s" % vallis),
                ],
            ),
       ),
    )