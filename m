From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 15 Dec 2017 17:29:06 +0000
Subject: [Intel-wired-lan] v4.15-rc2 on thinkpad x60: ethernet stopped
 working
In-Reply-To: <d1ae924b-4d8f-a787-4c07-1f2db91482e5@gmail.com>
References: <20171210083949.GA3872@amd>
 <d1ae924b-4d8f-a787-4c07-1f2db91482e5@gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB5882B5FB2A@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Gabriel C
> Sent: Sunday, December 10, 2017 4:44 AM
> To: Pavel Machek <pavel@ucw.cz>; kernel list <linux-kernel@vger.kernel.org>
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: Re: v4.15-rc2 on thinkpad x60: ethernet stopped working
> 
> On 10.12.2017 09:39, Pavel Machek wrote:
> > Hi!
> 
> Hi,
> 
> > In v4.15-rc2+, network manager can not see my ethernet card, and
> > manual attempts to ifconfig it up did not really help, either.
> >
> > Card is:
> >
> > 02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
> > Controller
> >
> > Dmesg says:
> >
> >    dmesg | grep eth
> > [    0.648931] e1000e 0000:02:00.0 eth0: (PCI Express:2.5GT/s:Width
> > x1) 00:16:d3:25:19:04
> > [    0.648934] e1000e 0000:02:00.0 eth0: Intel(R) PRO/1000 Network
> > Connection
> > [    0.649012] e1000e 0000:02:00.0 eth0: MAC: 2, PHY: 2, PBA No:
> > 005302-003
> > [    0.706510] usbcore: registered new interface driver cdc_ether
> > [    6.557022] e1000e 0000:02:00.0 eth1: renamed from eth0
> > [    6.577554] systemd-udevd[2363]: renamed network interface eth0 to
> > eth1
> >
> > Any ideas ?
> 
> Yes , 19110cfbb34d4af0cdfe14cd243f3b09dc95b013 broke it.
> 
> See:
> https://bugzilla.kernel.org/show_bug.cgi?id=198047
> 
> Fix there :
> https://marc.info/?l=linux-kernel&m=151272209903675&w=2
> 
> Regards,
> 
> Gabriel C

Hi,

Digging into this, the problem is complicated. The original bug assumed behavior of the .check_for_link call, which is universally not implemented.

I think the correct fix is to revert 19110cfbb34d ("e1000e: Separate signaling for link check/link up", 2017-10-10) and find a more proper solution.

I don't think any other code which uses check_for_link expects the interface to return in the way this patch attempted.

Thanks,
Jake
