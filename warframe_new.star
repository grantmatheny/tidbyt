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
    cambion = "%s remaining in %s" % (cambionremaining, cambionactive)

    vallis = rep.json()["vallisCycle"]["shortString"]

    final_string = """
    
    Cetus: %s

    Cambion: %s
    
    Vallis: %s
    """ % (cetus,cambion,vallis)

    return render.Root(
        child = render.Column(
            children = [
                render.Text("Cetus: %s" % cetus),
                render.Text("Cambion: %s" % cambion),
                render.Text("Vallis: %s" % vallis),
            ],
        ),
    )