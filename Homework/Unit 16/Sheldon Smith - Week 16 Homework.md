## Week 16 Homework Submission File: Penetration Testing 1

#### Step 1: Google Dorking


- Using Google, can you identify who the Chief Executive Officer of Altoro Mutual is: Karl Fitzgerald

- How can this information be helpful to an attacker: This will help narrow down argets for spear phishing attacks.


#### Step 2: DNS and Domain Discovery

Enter the IP address for `demo.testfire.net` into Domain Dossier and answer the following questions based on the results:

  1. Where is the company located: Sunnyvale, California, United States 94085

  2. What is the NetRange IP address: 65.61.137.64 - 65.61.137.127

  3. What is the company they use to store their infrastructure: Rackspace

  4. What is the IP address of the DNS server: 65.61.137.117

#### Step 3: Shodan

- What open ports and running services did Shodan find: Ports 80, 443 and 8080 running Apache-Coyote/1.1.

#### Step 4: Recon-ng

- Install the Recon module `xssed`: marketplace install xssed
- Set the source to `demo.testfire.net`: options set SOURCE demo.testfire.net
- Run the module: run

Is Altoro Mutual vulnerable to XSS: Yes.

### Step 5: Zenmap

Your client has asked that you help identify any vulnerabilities with their file-sharing server. Using the Metasploitable machine to act as your client's server, complete the following:

- Command for Zenmap to run a service scan against the Metasploitable machine: nmap -T4 -A -v 192.168.0.10
 
- Bonus command to output results into a new text file named `zenmapscan.txt`:  nmap -T4 -A -v 192.168.0.10 -o zenmapscan.txt

- Zenmap vulnerability script command: nmap -T4 -A -v --script smb-enum-shares 192.168.0.10

- Once you have identified this vulnerability, answer the following questions for your client:
  1. What is the vulnerability: Zenmap was able to enumerate all shares on the vulnerable machine and identify the VSFTPD 2.3.4 backdoor vulnerability.

  2. Why is it dangerous: These are dangerous as it will allow an attacker to gain access to the backend of the server and move laterally throughout the network via connected services.

  3. What mitigation strategies can you recommendations for the client to protect their server: The best recommendation is to patch Samba on the server, as this vulnerability doesn't exist in newer versions of Samba.
