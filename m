From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 6 Apr 2022 12:09:31 +0200
Subject: [Intel-wired-lan] I218-LM uses > 1 W with low traffic
Message-ID: <bff5f4d7-bb85-e3fa-b8b1-76d1b8e0133a@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


On a Dell Latitude E7250 with Debian sid/unstable, PowerTOP 2.14 reports 
the network device uses over 1.5 Watt, which is almost ten percent of 
the whole system.

       1.62 W    435,9 pkts/s                Device 
Netzwerkschnittstelle: eno1 (e1000e)

     $ lspci -nn | grep Ether
     00:19.0 Ethernet controller [0200]: Intel Corporation Ethernet 
Connection (3) I218-LM [8086:15a2] (rev 03)
     $ uname -a
     Linux ersatz 5.17.0-trunk-amd64 #1 SMP PREEMPT Debian 5.17.1-1~exp1 
(2022-03-29) x86_64 GNU/Linux

 From atop:

     NET |  eno1      0% |  pcki    2421 |  pcko    2194 |  sp 1000 Mbps 
|  si 1501 Kbps  | so  140 Kbps  | erri       0  | erro       0  | drpo 
      0  |

So I receive 1.5 Mbps, and send 0.14 Mbps.

Is such high energy usage expected of the network hardware?


Kind regards,

Paul
