# Network Forensic Analysis Report


## Time Thieves 
You must inspect your traffic capture to answer the following questions:

1. What is the domain name of the users' custom site?

*Answer:* `Frank-n-Ted-DC.frank-ted.com`

*Filter:* `ip.addr==10.6.12.0/24`

![Domain Name](/Images/domain.jpg)

2. What is the IP address of the Domain Controller (DC) of the AD network?

*Answer:* `10.6.12.12` `(Frank-n-Ted-DC.frank-n-ted.com)`

*Filter:* `ip.addr==10.6.12.0/24`

![DC IP Address](/Images/dcip.jpg)

3. What is the name of the malware downloaded to the 10.6.12.203 machine?
   - Once you have found the file, export it to your Kali machine's desktop.

*Answer:* `june11.dll`

*Filter:* `ip.addr==10.16.12.203 and http.request.method==GET`

*Export:* `File`>`Export Objects`>`HTTP`

![Malware](/Images/malware.jpg)

4. Upload the file to [VirusTotal.com](https://www.virustotal.com/gui/). 

![VirusTotal](/Images/virustotal.jpg)

5. What kind of malware is this classified as?

*Answer:* It was classfied as a `Trojan`

---

## Vulnerable Windows Machine

1. Find the following information about the infected Windows machine:
    - Host name `ROTTERDAM-PC`
    - IP address `172.16.4.205`
    - MAC address `00:59:07:b0:63:a4`
  
*Filter:* `ip.src==172.16.4.4 and kerberos.CNameString`  

![PC info](/Images/pcinfo.jpg)
    
2. What is the username of the Windows user whose computer is infected?

*Answer:* `matthijs.devries`

*Filter:* `ip.src==172.16.4.205 and kerberos.CNameString`

![Username](/Images/user.jpg)

3. What are the IP addresses used in the actual infection traffic?

*Answer:* Based on the Conversations statistics and then filtering by highest amount of packets between ip’s `172.16.4.205` / `185.243.115.84` / `166.62.11.64` are infected traffic.

Referencing `185.243.115.84` `(b569023.green.mattingsolutions.co)` there are a large amount of `POST` methods of empty.gif being sent without any originating `GET` requests. This is suspicious activity.

*Filter:* `ip.addr==172.16.4.205 and ip.addr==185.243.115.84`

![Results](/Images/wiresharkconversations.jpg)

4. As a bonus, retrieve the desktop background of the Windows host.

![Background](/Images/background.jpg)

---

## Illegal Downloads

1. Find the following information about the machine with IP address `10.0.0.201`:
    - MAC address `00:16:17:18:66:c8`
    - Windows username `elmer.blanco`
    - OS version `BLANCO-DESKTOP`

*Filter:* `ip.src==10.0.0.201 and kerberos.CNameString`

![Blanco](/Images/blanco.jpg)

2. Which torrent file did the user download?

*Answer:* `Betty_Boop_Rhythm_on_the_Reservation.avi.torrent`

*Filter:* `ip.addr==10.0.0.201 and (http.request.uri contains “.torrent”)`

![Torrent](/Images/torrent.jpg)
