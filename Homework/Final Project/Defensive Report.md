# Blue Team: Summary of Operations

## Table of Contents
- Network Topology
- Description of Targets
- Monitoring the Targets
- Patterns of Traffic & Behavior
- Suggestions for Going Further

### Network Topology

The following machines were identified on the network:
- Kali
  - **Operating System**: Debian Kali Linux 5.4.0
  - **Purpose**: Attacker Machine
  - **IP Address**: 192.168.1.90
- Capstone
  - **Operating System**: Ubuntu 18.04
  - **Purpose**: Vulnerable Web Server Host
  - **IP Address**: 192.168.1.105
- ELK
  - **Operating System**: Ubuntu 18.04
  - **Purpose**: ELK Stack Machine
  - **IP Address**: 192.168.1.100
- Target Machine 1
  - **Operating System**: Debian Linux 8
  - **Purpose**: WordPress Host
  - **IP Address**: 192.168.1.110

Network Diagram:


### Description of Targets

The target of this attack was: `Target 1` (192.168.1.110).

Target 1 is an Apache web server and has SSH enabled, so ports 80 and 22 are possible ports of entry for attackers. As such, the following alerts have been implemented:
- Excessive HTTP Errors
- HTTP Request Size Monitor
- CPU Usage Monitor

### Monitoring the Targets

Traffic to these services should be carefully monitored. To this end, we have implemented the alerts below:

#### Excessive HTTP Errors

Excessive HTTP Errors is implemented as follows:
  - **Metric**: WHEN count() GROUPED OVER top 5 'http.response.status_code'
  - **Threshold**: IS ABOVE 400 FOR THE LAST 5 minutes
  - **Vulnerability Mitigated**: Enumeration/Brute Force
  - **Reliability**: This alert is highly reliable as it will only be triggered if there are a high number of HTTP 400 response codes being generated. This threshold will filter out any normal traffic on the network.

#### HTTP Request Size Monitor
HTTP Request Size Monitor is implemented as follows:
  - **Metric**: WHEN sum() OF http.request.bytes OVER all documents
  - **Threshold**: IS ABOVE 3500 FOR THE LAST 1 minute
  - **Vulnerability Mitigated**: Code injection in HTTP requests (XSS and CRLF) or DDOS
  - **Reliability**: This alert's reliability is medium as some normal network activity may create false positives.

#### CPU Usage Monitor
CPU Usage Monitor is implemented as follows:
  - **Metric**: WHEN max() OF system.process.cpu.total.pct OVER all documents
  - **Threshold**: IS ABOVE 0.5 FOR THE LAST 5 minutes
  - **Vulnerability Mitigated**: Mitigates any software that may take up an excessive amount of resources.
  - **Reliability**: This alert's reliablitiy is medium as it can't differentiate between malicious annd benign software, creating false positivies however this still may be useful to identify issues with any software taking up too many resources.

### Suggestions for Going Further (Optional)
- Each alert above pertains to a specific vulnerability/exploit. Recall that alerts only detect malicious behavior, but do not stop it. For each vulnerability/exploit identified by the alerts above, suggest a patch. E.g., implementing a blocklist is an effective tactic against brute-force attacks. It is not necessary to explain _how_ to implement each patch.

The logs and alerts generated during the assessment suggest that this network is susceptible to several active threats, identified by the alerts above. In addition to watching for occurrences of such threats, the network should be hardened against them. The Blue Team suggests that IT implement the fixes below to protect the network:
- WordPress User Enumeration Vulnerability
  - **Patch**: Download `WP-Hardening` from `https://wordpress.org/plugins/wp-security-hardening/` and install it on the WordPress installation. Once installed, go to the `Security Fixers` tab and select `Stop user enumeration`.
  - **Why It Works**: This plugin automatically stops attackers and bots from using tools, such as wpscan or manual enumeration, from enumerating users on the WordPress installation.
- Bruteforce & DDoS via XMLRPC
  - **Patch**: Download `WP-Hardening` from `https://wordpress.org/plugins/wp-security-hardening/` and install it on the WordPress installation. Once installed, go to the `Security Fixers` tab to disable XMLRPC.
  - **Why It Works**: With XMLRPC disabled this completely removes the possibility for bruteforce or DDoS attacks via XMLRPC.
- Intrusion Detection
  - **Patch**: Download and install an Intrusion Detection System (IDS), such as Snort.
  - **Why It Works**: This will detect any intrusion attempts and take action against the traffic to ensure the integrity and availability of the web server.
