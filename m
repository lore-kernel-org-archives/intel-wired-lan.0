From: Gabriel C <nix.or.die@gmail.com>
Date: Sun, 10 Dec 2017 13:44:12 +0100
Subject: [Intel-wired-lan] v4.15-rc2 on thinkpad x60: ethernet stopped
 working
In-Reply-To: <20171210083949.GA3872@amd>
References: <20171210083949.GA3872@amd>
Message-ID: <d1ae924b-4d8f-a787-4c07-1f2db91482e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10.12.2017 09:39, Pavel Machek wrote:
> Hi!

Hi,

> In v4.15-rc2+, network manager can not see my ethernet card, and
> manual attempts to ifconfig it up did not really help, either.
> 
> Card is:
> 
> 02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
> Controller
> 
> Dmesg says:
> 
>    dmesg | grep eth
> [    0.648931] e1000e 0000:02:00.0 eth0: (PCI Express:2.5GT/s:Width
> x1) 00:16:d3:25:19:04
> [    0.648934] e1000e 0000:02:00.0 eth0: Intel(R) PRO/1000 Network
> Connection
> [    0.649012] e1000e 0000:02:00.0 eth0: MAC: 2, PHY: 2, PBA No:
> 005302-003
> [    0.706510] usbcore: registered new interface driver cdc_ether
> [    6.557022] e1000e 0000:02:00.0 eth1: renamed from eth0
> [    6.577554] systemd-udevd[2363]: renamed network interface eth0 to
> eth1
> 
> Any ideas ?

Yes , 19110cfbb34d4af0cdfe14cd243f3b09dc95b013 broke it.

See:
https://bugzilla.kernel.org/show_bug.cgi?id=198047

Fix there :
https://marc.info/?l=linux-kernel&m=151272209903675&w=2

Regards,

Gabriel C
