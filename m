From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 13 Sep 2021 22:44:25 +0200
Subject: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
In-Reply-To: <20210913203234.GA6762@codemonkey.org.uk>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk>
Message-ID: <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 13.09.2021 22:32, Dave Jones wrote:

+ Jesse and Tony as Intel NIC maintainers

> On Mon, Sep 13, 2021 at 10:22:57PM +0200, Heiner Kallweit wrote:
> 
>  > > This didn't help I'm afraid :(
>  > > It changed the VPD warning, but that's about it...
>  > > 
>  > > [  184.235496] pci 0000:02:00.0: calling  quirk_blacklist_vpd+0x0/0x22 @ 1
>  > > [  184.235499] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)                                                                                           
>  > > [  184.235501] pci 0000:02:00.0: quirk_blacklist_vpd+0x0/0x22 took 0 usecs
>  > > 
>  > With this patch there's no VPD access to this device any longer. So this can't be
>  > the root cause. Do you have any other PCI device that has VPD capability?
>  > -> Capabilities: [...] Vital Product Data
> 
> 
> 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
>         Subsystem: Device 1dcf:030a
> 	...
> 	        Capabilities: [e0] Vital Product Data
>                 Unknown small resource type 06, will not decode more.
> 

When searching I found the same symptom of invalid VPD data for 82599EB.
Do these adapters have non-VPD data in VPD address space? Or is the actual
VPD data at another offset than 0? I know that few Chelsio devices have
such a non-standard VPD structure.

> 
> I'll add that to the quirk list and see if that helps.
> 
> 	Dave
> 
Heiner
