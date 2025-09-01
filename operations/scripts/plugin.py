from pathlib import Path
from typing import Any

import base64
import ipaddress
import makejinja
import re
import json


# Return the filename of a path without the j2 extension
def basename(value: str) -> str:
    return Path(value).stem


# Return the nth host in a CIDR range
def nthhost(value: str, query: int) -> str:
    try:
        network = ipaddress.ip_network(value, strict=False)
        if 0 <= query < network.num_addresses:
            return str(network[query])
    except ValueError:
        pass
    return False


# Return the age public or private key from age.key
def age_key(key_type: str, file_path: str = 'age.key') -> str:
    try:
        with open(file_path, 'r') as file:
            file_content = file.read().strip()
        if key_type == 'public':
            key_match = re.search(r"# public key: (age1[\w]+)", file_content)
            if not key_match:
                raise ValueError("Could not find public key in the age key file.")
            return key_match.group(1)
        elif key_type == 'private':
            key_match = re.search(r"(AGE-SECRET-KEY-[\w]+)", file_content)
            if not key_match:
                raise ValueError("Could not find private key in the age key file.")
            return key_match.group(1)
        else:
            raise ValueError("Invalid key type. Use 'public' or 'private'.")
    except FileNotFoundError:
        raise FileNotFoundError(f"File not found: {file_path}")
    except Exception as e:
        raise RuntimeError(f"Unexpected error while processing {file_path}: {e}")

# Return the GitHub deploy key from github-deploy.key
def github_deploy_key(file_path: str = 'github-deploy.key') -> str:
    try:
        with open(file_path, 'r') as file:
            return file.read().strip()
    except FileNotFoundError:
        raise FileNotFoundError(f"File not found: {file_path}")
    except Exception as e:
        raise RuntimeError(f"Unexpected error while reading {file_path}: {e}")


# Return the Flux / GitHub push token from github-push-token.txt
def github_push_token(file_path: str = 'github-push-token.txt') -> str:
    try:
        with open(file_path, 'r') as file:
            return file.read().strip()
    except FileNotFoundError:
        raise FileNotFoundError(f"File not found: {file_path}")
    except Exception as e:
        raise RuntimeError(f"Unexpected error while reading {file_path}: {e}")

class Plugin(makejinja.plugin.Plugin):
    def __init__(self, data: dict[str, Any]):
        self._data = data


    def data(self) -> makejinja.plugin.Data:
        data = self._data

        # Set default values for optional fields
        data.setdefault('node_default_gateway', nthhost(data.get('node_cidr'), 1))
        data.setdefault('node_dns_servers', ['100.64.37.204'])
        data.setdefault('cluster_pod_cidr', '100.96.0.0/12')
        data.setdefault('cluster_svc_cidr', '100.64.0.0/12')
        data.setdefault('repository_branch', 'main')
        data.setdefault('repository_visibility', 'public')
        data.setdefault('calico_loadbalancer_mode', 'IPIP')


        # If there is more than one node, enable spegel
        spegel_enabled = len(data.get('nodes')) > 1
        data.setdefault('spegel_enabled', spegel_enabled)

        return data


    def filters(self) -> makejinja.plugin.Filters:
        return [
            basename,
            nthhost
        ]


    def functions(self) -> makejinja.plugin.Functions:
        return [
            age_key,
            github_deploy_key,
            github_push_token,
        ]
