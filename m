From: Ryan Goodfellow <rgoodfel@isi.edu>
Date: Tue, 31 May 2016 10:35:40 -0700
Subject: [Intel-wired-lan] fm10k driver questions
Message-ID: <CABnJGMiPnNDNyNX-=6J1QjxR=wjC09rN3qdJDzW2_Nq0fH4wCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I have a few Intel FM10420 based devices (Supermicro AOC-S100G-i2C) that I
am trying to get working in our lab using dpdk and some of the network
virtualization functions of the card. However, I am a bit confused on the
two different sources of kernel drivers. In the documentation here
<http://www.intel.com/content/www/us/en/embedded/technology/packet-processing/dpdk/dpdk-network-interface-controller-drivers-guide.html>
the
instructions include passing parameters to the fm10k kernel module. In
looking at source
<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/fm10k?id=refs/tags/v4.6>
for
fm10k I see no such parameters and modinfo supports that. Then I found a
different <https://sourceforge.net/projects/e1000/files/fm10k%20stable/>
set of Intel drivers that do seem to support these options. Could someone
please tell me the relationship between these two source trees?

As I understand it this is the mailing list for the source tree within the
kernel, and I would prefer to work with these sources. However when I load
the kernel module I am having issues using the card, both as a kernel
controlled Ethernet card and as a dpdk device. On the dpdk side of things I
get an error saying the switch is not ready (PMD: eth_fm10k_dev_init():
switch is not ready), I have been looking for a way to make the switch
ready through the kernel driver but have not found anything, any thoughts?

In using the card as a kernel controlled Ethernet card, I have simply
loaded the kernel module, it gets assigned to 'ens1' I bring the link up
and assign and assign an IP address and try to ping another machine on the
same subnet to no avail. I have also noticed that ethtool does not really
seem to understand this card.

Below is some relevant information from my system. Thank you for your time!

# ethtool ens1
Settings for ens1:
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: no

# uname -a
Linux mrtb0 4.4.0-22-generic #40-Ubuntu SMP Thu May 12 22:03:46 UTC 2016
x86_64 x86_64 x86_64 GNU/Linux

# modinfo fm10k
filename:
/lib/modules/4.4.0-22-generic/kernel/drivers/net/ethernet/intel/fm10k/fm10k.ko
version:        0.19.3-k
license:        GPL
description:    Intel(R) Ethernet Switch Host Interface Driver
author:         Intel Corporation, <linux.nics@intel.com>
srcversion:     2FC847E4AA68E2C08B4B274
alias:          pci:v00008086d000015A5sv*sd*bc*sc*i*
alias:          pci:v00008086d000015A4sv*sd*bc*sc*i*
depends:        ptp,vxlan
intree:         Y
vermagic:       4.4.0-22-generic SMP mod_unload modversions


-- 
*Ryan Goodfellow*
*Computer Scientist*
USC Information Sciences Institute
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160531/f4de712c/attachment.html>
