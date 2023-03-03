import requests
from bs4 import BeautifulSoup

query = "primate fossil species"
url = f"https://scholar.google.com/scholar?q={query}&hl=en"

response = requests.get(url)
soup = BeautifulSoup(response.content, "html.parser")

results = soup.find_all("div", {"class": "gs_ri"})

for result in results:
    title = result.find("h3", {"class": "gs_rt"}).text
    citation = result.find("div", {"class": "gs_a"}).text
    
    if "fossil" in title.lower() and "primate" in title.lower():
        date_range, locality = None, None
        
        for item in citation.split(" - "):
            if item.startswith("20"):
                date_range = item
            elif "," in item:
                locality = item
        
        print(title)
        print("Date Range:", date_range)
        print("Locality:", locality)
        print("Primary Citation:", citation)
        print()
