From: M.R. <marianrobert@yahoo.com>
Date: Thu, 6 Apr 2017 08:16:17 +0000 (UTC)
Subject: [Intel-wired-lan] Intel FM10000
References: <1303627756.1972773.1491466577944.ref@mail.yahoo.com>
Message-ID: <1303627756.1972773.1491466577944@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff, Intel Wired LAN team,
I have 2 FM10420 cards in our lab and cannot make them work.
Here are the details:- the environment is Linux 4.4, but if needed I can switch to 4.6+.- I used Silicom's redirector daemon + fm10k-0.19.2 from sourceforge and got link up and packets being passed between the 2 PCs- I used matchd and IES from github (not sure I found the "official" Intel backed code, maybe you have a hint for me where are the official ones) and cannot make the link up
On the DPDK site it is stated that there is a driver for the internal hardware switch inside the card. Where can this be found?
In this message I found [http://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20160530/005483.html], you stated the in-kernel driver was the most up-to-date.I would prefer the in-kernel driver, how to make it work?
Thanks in advance,Robert



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170406/98afadb8/attachment-0001.html>
