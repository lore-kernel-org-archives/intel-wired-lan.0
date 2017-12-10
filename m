From: Pavel Machek <pavel@ucw.cz>
Date: Sun, 10 Dec 2017 09:39:49 +0100
Subject: [Intel-wired-lan] v4.15-rc2 on thinkpad x60: ethernet stopped
 working
Message-ID: <20171210083949.GA3872@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi!

In v4.15-rc2+, network manager can not see my ethernet card, and
manual attempts to ifconfig it up did not really help, either.

Card is:

02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
Controller

Dmesg says:

  dmesg | grep eth
[    0.648931] e1000e 0000:02:00.0 eth0: (PCI Express:2.5GT/s:Width
x1) 00:16:d3:25:19:04
[    0.648934] e1000e 0000:02:00.0 eth0: Intel(R) PRO/1000 Network
Connection
[    0.649012] e1000e 0000:02:00.0 eth0: MAC: 2, PHY: 2, PBA No:
005302-003
[    0.706510] usbcore: registered new interface driver cdc_ether
[    6.557022] e1000e 0000:02:00.0 eth1: renamed from eth0
[    6.577554] systemd-udevd[2363]: renamed network interface eth0 to
eth1

Any ideas?
									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171210/d9e8d378/attachment.asc>
