# Test all ports connection


<p align="center">  
    <a href="https://github.com/matichewer/test-all-ports-connection/issues">
        <img src="https://img.shields.io/github/issues/matichewer/test-all-ports-connection?style=flat-square&color=red&label=open&query=is%3Aopen">
    </a> 
    <a href="https://github.com/matichewer/test-all-ports-connection/issues?q=is%3Aissue+is%3Aclosed+" target="_blank" rel="noopener noreferrer">
        <img src="https://img.shields.io/github/issues-closed/matichewer/test-all-ports-connection?style=flat-square&color=success&label=closed&query=is%3Aclosed">
    </a>
    <a href="https://github.com/matichewer/test-all-ports-connection/stargazers">
        <img src="https://img.shields.io/github/stars/matichewer/test-all-ports-connection?color=success&style=flat">
    </a>    
    <a href="https://github.com/matichewer/test-all-ports-connection/forks">
        <img src="https://img.shields.io/github/forks/matichewer/test-all-ports-connection?color=blue&style=flat">
    </a>
    <a href="https://github.com/matichewer/test-all-ports-connection/contributors">
        <img src="https://img.shields.io/github/contributors/matichewer/test-all-ports-connection?color=blue&style=flat">
    </a>
    <a>
        <img src="https://img.shields.io/github/repo-size/matichewer/test-all-ports-connection?color=blue&style=flat">
    </a>   
</p>

## Overview
This repository contains bash scripts designed to test the connectivity of all ports on a network. The main objective is to identify which ports are not blocked by the network, specifically tested at my university.

## Open Ports on 'WiFi UNS'
After executing the script in June 2022, I discovered that the only ports not blocked by the university are listed in the table below:


| Port   | Service | Usage (According to ChatGPT) |
|--------|---------|------------------------------|
| 21     | FTP     | File Transfer                |
| 22     | SSH     | Secure Remote Access         |
| 80     | HTTP    | Web Browsing                 |
| 110    | POP3    | Email Reception              |
| 143    | IMAP    | Email Reception              |
| 443    | HTTPS   | Secure Web Browsing          |
| 465    | SMTPS   | Secure Email Sending         |
| 568    | METER   | File Sharing                 |
| 993    | IMAPS   | Secure Email Reception       |
| 995    | POP3S   | Secure Email Reception       |
| 4070   | ARD     | Apple Remote Desktop         |
| 4244   | ARD     | Apple Remote Desktop         |
| 5222   | XMPP    | Instant Messaging            |
| 5223   | XMPP    | Instant Messaging            |
| 5242   | EA      | File Sharing                 |
| 5828   | UPnP    | Device Discovery             |
| 10983  | NS      | Notification Service         |
| 11360  | JAMF    | Apple Device Management      |
| 11371  | OpenPGP | Email Encryption             |
| 50318  | XCP     | File Sharing                 |
| 59234  | BOINC   | Distributed Computing        |

## Contributions
Contributions are welcome! Please contact me, open an issue or submit a pull request for any improvements or additions.