# grab-banner
Bash script that performs generic banner grabbing, multiple ports per host


## Features
* Performs generic banner grabbing
* Uses protocol-appropriate tools to dissect banners on well-known ports
* Looks up canonical service names for well-known ports
* Scans multiple ports during the same run
* Runs on any OS having a Bash environment


## Environment
* Any OS having a Bash environment
* The following tools must be installed, executable, and in the PATH:
    * `awk`
* The following tools should be installed, executable, and in the PATH:
    * `curl` (for HTTP and HTTPS)
    * `openssl` (for other TLS/SSL ports)
    * `nc` (for everything else)
* For canonical service names the following file should be available and readable:  `/etc/services`


## Usage
```
./grab_banner.sh <host> <tcp_port> [tcp_port] [tcp_port...]
```
Example:
```
./grab_banner.sh google.com 80 443
```


### Example usage
On Ubuntu:
```
user@computer:~$ ./grab_banner.sh google.com 80 443
[*] =====================================================
[+] Grabbing banner from google.com:80 [http] ...
[*] =====================================================
HTTP/1.1 301 Moved Permanently
Location: http://www.google.com/
Content-Type: text/html; charset=UTF-8
Date: Sun, 31 Jan 2016 21:31:11 GMT
Expires: Tue, 01 Mar 2016 21:31:11 GMT
Cache-Control: public, max-age=2592000
Server: gws
Content-Length: 219
X-XSS-Protection: 1; mode=block
X-Frame-Options: SAMEORIGIN


[*] =====================================================
[+] Grabbing banner from google.com:443 [https] ...
[*] =====================================================
* Rebuilt URL to: https://google.com/
* Hostname was NOT found in DNS cache
*   Trying 216.58.216.206...
* Connected to google.com (216.58.216.206) port 443 (#0)
* successfully set certificate verify locations:
*   CAfile: none
  CApath: /etc/ssl/certs
* SSLv3, TLS handshake, Client hello (1):
} [data not shown]
* SSLv3, TLS handshake, Server hello (2):
{ [data not shown]
* SSLv3, TLS handshake, CERT (11):
{ [data not shown]
* SSLv3, TLS handshake, Server key exchange (12):
{ [data not shown]
* SSLv3, TLS handshake, Server finished (14):
{ [data not shown]
* SSLv3, TLS handshake, Client key exchange (16):
} [data not shown]
* SSLv3, TLS change cipher, Client hello (1):
} [data not shown]
* SSLv3, TLS handshake, Finished (20):
} [data not shown]
* SSLv3, TLS change cipher, Client hello (1):
{ [data not shown]
* SSLv3, TLS handshake, Finished (20):
{ [data not shown]
* SSL connection using ECDHE-ECDSA-AES128-GCM-SHA256
* Server certificate:
* 	 subject: C=US; ST=California; L=Mountain View; O=Google Inc; CN=*.google.com
* 	 start date: 2016-01-20 12:30:11 GMT
* 	 expire date: 2016-04-19 00:00:00 GMT
* 	 issuer: C=US; O=Google Inc; CN=Google Internet Authority G2
* 	 SSL certificate verify ok.
> GET / HTTP/1.1
> User-Agent: curl/7.35.0
> Host: google.com
> Accept: */*
> 
< HTTP/1.1 301 Moved Permanently
< Location: https://www.google.com/
< Content-Type: text/html; charset=UTF-8
< Date: Sun, 31 Jan 2016 21:31:11 GMT
< Expires: Tue, 01 Mar 2016 21:31:11 GMT
< Cache-Control: public, max-age=2592000
* Server gws is not blacklisted
< Server: gws
< Content-Length: 220
< X-XSS-Protection: 1; mode=block
< X-Frame-Options: SAMEORIGIN
< Alternate-Protocol: 443:quic,p=1
< Alt-Svc: quic=":443"; ma=604800; v="30,29,28,27,26,25"
< 
{ [data not shown]
* Connection #0 to host google.com left intact
```
