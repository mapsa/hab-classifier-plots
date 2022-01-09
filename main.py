"""
Download IFCB class cores files
"""
from urllib.parse import urlencode, urlparse, urlunparse
import requests

IFCB_DASHBOARD_URL = "https://ifcb-data.sams.ac.uk"
URL_PARAMS = {'dataset': 'NAFC', 'skip_filter': 'exclude',
            'start_date': '2021-05-12', 'end_date': '2021-05-14'}

def get_bins_list():
    """Get a list of bins from the IFCB dashboard"""
    api_url = f'{IFCB_DASHBOARD_URL}/api/list_bins?'
    url_parts = list(urlparse(api_url))
    url_parts[4] = urlencode(URL_PARAMS)

    url = urlunparse(url_parts)

    response = requests.get(url)
    data = response.json()['data']
    for row in data:
        get_class_scores(row['pid'],row['sample_time'],row['skip'])

def get_class_scores(pid, sample_time, skip):
    """Download class scores csv files"""
    url = f'{IFCB_DASHBOARD_URL}/{URL_PARAMS["dataset"]}/{pid}_class_scores.csv'
    print(url, sample_time, skip)

if __name__ == "__main__":
    get_bins_list()
