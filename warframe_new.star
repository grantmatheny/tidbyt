load("render.star", "render")
load("http.star", "http")
load("cache.star", "cache")

WF_STATUS_URL = "https://api.warframestat.us/pc"
REFRESH_CACHE = False

def main():
    wf_cetus_cached = cache.get("cetus")
    wf_earth_cached = cache.get("earth")
    wf_cambion_cached = cache.get("cambion")
    wf_vallis_cached = cache.get("vallis")
    if wf_cetus_cached != None:
        print("Hit! Displaying cached data.")
        cetus = wf_cetus_cached
    else:
        REFRESH_CACHE = True

    if wf_earth_cached != None:
        print("Hit! Displaying cached data.")
        earth = wf_earth_cached
    else:
        REFRESH_CACHE = True

    if wf_cambion_cached != None:
        print("Hit! Displaying cached data.")
        cambion = wf_cambion_cached
    else:
        REFRESH_CACHE = True

    if wf_vallis_cached != None:
        print("Hit! Displaying cached data.")
        vallis = wf_vallis_cached
    else:
        REFRESH_CACHE = True    
    
    if REFRESH_CACHE == True:
        rep = http.get(WF_STATUS_URL)
        if rep.status_code != 200:
            fail("Warframe request failed with status %d", rep.status_code)

        cetus = rep.json()["cetusCycle"]["shortString"].replace(' to ', '>').replace('Night','Nite')
        cache.set("wf_cetus_cached", str(cetus), ttl_seconds=60)

        earthactive = rep.json()["earthCycle"]["state"].title()
        if earthactive == "Night":
            earthactive = "Day"
        else:
            earthactive = "Nite"
        earthremaining = rep.json()["earthCycle"]["timeLeft"].split()
        for part in earthremaining:
            if "s" in part:
                part_to_remove = part
        earthremaining.remove(part)
        earthremaining = ' '.join(earthremaining)
        earth = "%s>%s" % (earthremaining, earthactive)
        cache.set("wf_earth_cached", str(earth), ttl_seconds=60)

        cambionactive = rep.json()["cambionCycle"]["active"].title()
        if cambionactive == "Fass":
            cambionactive = "Vome"
        else:
            cambionactive = "Fass"
        cambionremaining = rep.json()["cambionCycle"]["timeLeft"].split()
        for part in cambionremaining:
            if "s" in part:
                part_to_remove = part
        cambionremaining.remove(part_to_remove)
        cambionremaining = ' '.join(cambionremaining)
        cambion = "%s>%s" % (cambionremaining, cambionactive)
        cache.set("wf_cambion_cached", str(cambion), ttl_seconds=60)

        vallis = rep.json()["vallisCycle"]["shortString"].replace(' to ', '>')
        cache.set("wf_vallis_cached", str(vallis), ttl_seconds=60)

    return render.Root(
       child = render.Column(
                children = [
                    render.Text("C: %s" % cetus),
                    render.Text("E: %s" % earth),
                    render.Text("D: %s" % cambion),
                    render.Text("V: %s" % vallis),
                ],
                ),
    )