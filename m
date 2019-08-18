From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Sun, 18 Aug 2019 20:36:33 +0000
Subject: [Intel-wired-lan] x
In-Reply-To: <CAP-MU4PKYRP0SpxDC7SgRGCjWAyyu0vHh5W5YAsjf=JseRkAqg@mail.gmail.com>
References: <CAP-MU4MAwQd5bOGpJ=tu4iVB4j4FO6UWbkXg6ox34i7pb5DjQA@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD69AFFB063@ORSMSX115.amr.corp.intel.com>
 <CAP-MU4PKYRP0SpxDC7SgRGCjWAyyu0vHh5W5YAsjf=JseRkAqg@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD69AFFBD76@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The problem should be fixed with an NVM update but I'm unsure if your NVM already has the fix. Let me make sure with the Product AE.

However, you're going to have to go directly to Cisco for the NVM updates since the cards look like they're from Cisco.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: Shannon Nelson [mailto:shannon.lee.nelson at gmail.com] 
Sent: Thursday, August 15, 2019 7:19 PM
To: Fujinaka, Todd <todd.fujinaka@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] x

On Thu, Aug 15, 2019 at 6:46 PM Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
>
> x722? x550? Or is it a different part?
>
> I've seen something like this lately, but I'll need to know which Ethernet controller it is before I can narrow it down.

Sorry about that short Subject text and lack of info... someone was passing this info to me in the midst of two or three other things going on and I hit <send> before I finished the text.

Since that's ixgbe printing the complaints, I'm pretty sure it isn't anything x722-ish.  I don't have access to the actual machine, but it is the same as this one:

65:00.0 Ethernet controller: Intel Corporation Ethernet Controller 10G X550T (rev 01)
Subsystem: Cisco Systems Inc Device 01a3
Capabilities: [e0] Vital Product Data
Product Name: Cisco  X550-TX 10 Gig
Read-only fields:
[PN] Part number: X550-TX
[V0] Vendor specific: MAP 1.86 V0.02 PHY 2.B.B MAC 3.15 [MN] Manufacture ID: 11 37 [RV] Reserved: checksum good, 0 byte(s) reserved

# ethtool -i eno1
driver: ixgbe
version: 5.1.0-k
firmware-version: 0x80000af9, 0.385.33

We have a bunch of these machines, and I'm told we're seeing this off and on in several of them.

sln


>
> Todd Fujinaka
> Software Application Engineer
> Datacenter Engineering Group
> Intel Corporation
> todd.fujinaka at intel.com
>
> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On 
> Behalf Of Shannon Nelson
> Sent: Thursday, August 15, 2019 2:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] x
>
> We've been occasionally seeing some of these messages recently on some of our machines after reboots.  Usually a powercycle clears it up.
> Any hints as to what might be going on?
>
> [    2.570012] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver -
> version 5.1.0-k-rh7.5
> [    2.570016] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [    4.883541] ixgbe 0000:65:00.0 (unregistered net_device): eeprom
> read at offset 40 failed
> [    7.112885] ixgbe 0000:65:00.0 (unregistered net_device): eeprom
> read at offset 39 failed
> [   11.571710] ixgbe 0000:65:00.0: The EEPROM Checksum Is Not Valid
> [   11.571916] ixgbe: probe of 0000:65:00.0 failed with error -5
> [   13.922688] ixgbe 0000:65:00.1 (unregistered net_device): eeprom
> read at offset 40 failed
> [   16.152080] ixgbe 0000:65:00.1 (unregistered net_device): eeprom
> read at offset 39 failed
> [   20.617460] ixgbe 0000:65:00.1: The EEPROM Checksum Is Not Valid
> [   20.617639] ixgbe: probe of 0000:65:00.1 failed with error -5
>
>
> Thanks,
> sln
>
>
> --
> ==============================================
> Mr. Shannon Nelson         Parents can't afford to be squeamish.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan



--
==============================================
Mr. Shannon Nelson         Parents can't afford to be squeamish.
