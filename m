From: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 8 Feb 2017 14:31:58 -0200
Subject: [Intel-wired-lan] i40e: driver can't probe device (capabilities
	discovery error)
Message-ID: <64ac2d0b-7685-4adb-a0e4-2ab7bfd6975e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Recently we had a sudden fail on Intel XL710 adapter, in which the i40e
driver is not able to probe the device anymore - it fails right on the
beginning of the probe process, on discovery capabilities procedure. We
observed the following messages on kernel (v4.10-rc7) log:


i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 1.6.25-k
i40e: Copyright (c) 2013 - 2014 Intel Corporation.
i40e 0002:01:00.0: Using 64-bit DMA iommu bypass
i40e 0002:01:00.0: fw 5.1.40981 api 1.5 nvm 5.03 0x80002469 1.1313.0
i40e 0002:01:00.0: capability discovery failed, err OK aq_err
I40E_AQ_RC_EMODE
i40e 0002:01:00.1: Using 64-bit DMA iommu bypass
i40e 0002:01:00.1: fw 5.1.40981 api 1.5 nvm 5.03 0x80002469 1.1313.0
i40e 0002:01:00.1: capability discovery failed, err OK aq_err
I40E_AQ_RC_EMODE

<and the same messages on functions .2 and .3 too>


We were able to "revive" the adapter using one of the following 2
procedures:

i) PowerPC systems have a feature called EEH, that is a PCI slot reset
in essence. It's something in HW/PHB level, so the mechanism does a slot
reset, that can be a PCI Hot Reset or Fundamental Reset (PERST).

The 1st way to recover the adapter was to inject an error on this slot
and forcing a called "hotplug recovery". Basically, we removed the
adapter from the PCI core (echo 1 >
/sys/bus/pci/devices/0002:01:00.*/remove), then we froze the PHB
transactions (using a debug facility on powerpc kernel) and then we do a
rescan on PCI bus (echo 1 > /sys/bus/pci/rescan).

This led to Hot Reset on slot, and adapter recovered fine, i40e driver
was able to complete the probe procedure. I can provide full logs if
desired.
Although I think this is too hacky way...

ii) With the attached patch, we were able to "partially" circumvent the
issue. Basically, the probe procedure worked fine to all device
functions, but on function 3 we failed in eeprom check - the following
messages were observed in the kernel log:

[29.1126] i40e 0002:01:00.3: Using 64-bit DMA iommu bypass
[32.3530] i40e 0002:01:00.3: fw 5.1.40981 api 1.5 nvm 5.03 0x24695003
192.0.63
[32.8441] i40e 0002:01:00.3: eeprom check failed (-2), Tx/Rx traffic
disabled
[32.8583] i40e 0002:01:00.3: MAC address: 0c:c4:7a:89:f1:c3
[32.8712] i40e 0002:01:00.3: MSI-X vector limit reached, attempting to
redistribute vectors
[32.9765] i40e 0002:01:00.3: Added LAN device PF3 bus=0x00 func=0x03
[32.9766] i40e 0002:01:00.3: PCI-Express: Speed 8.0GT/s Width x8
[32.9867] i40e 0002:01:00.3: Features: PF-id[3] VFs: 32 VSIs: 34 QP: 119
RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA


All the other 3 functions presented the same messages except the eeprom
check failed.
I'm aware the patch needs some rework (in my understanding, the logic
works only to a single adapter, because we need a global reset only in
one function of the adapter. But the patch logic fails if we have more
than 1 physical adapter on machine. It's just a draft/RFC version for now).
--

So, I'd like to request help/feedback from you regarding what's going
on. I'm not sure the root cause of the sudden adapter failure. In one
day it was fine, and in the other, after a machine reboot, it entered in
this odd state. We have 2 machines presenting this behavior and 5 others
that are fine.

Is there a way to clear this bad state on the adapter, like a special
reset (or even a jumper that we should play physically)? I tried EMP
reset too, but seems it's not allowed for some reason (perhaps only in
NVM update mode? Not sure). Also, any pointers on how to understand the
root cause are welcome.
Thanks in advance,


Guilherme
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-i40-force-global-reset-on-adapter-probe.patch
Type: text/x-patch
Size: 1695 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170208/24946270/attachment.bin>
