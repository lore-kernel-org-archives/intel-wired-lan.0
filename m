From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 08 Apr 2019 07:58:49 -0700
Subject: [Intel-wired-lan] Kernel Linux and i*gb* drivers
In-Reply-To: <CAJdzkC0Ji0ZnCPhCDdhN_PUr5-qNs_OM5cvn=r+t8wYhJR3R0g@mail.gmail.com>
References: <CAJdzkC0Ji0ZnCPhCDdhN_PUr5-qNs_OM5cvn=r+t8wYhJR3R0g@mail.gmail.com>
Message-ID: <7fa75c5fd75b326e7825524481aca1365dfdaa9a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-04-08 at 13:15 +0200, L Ait wrote:
> Hi ,
> 
> I have a linux applidation that uses udp for data transferer between
> processes (on the same machine or same vlan). This application runs
> fine on linux 4.4.27. But when upgrading to linux 4.14.20 kernel I
> was facing out of order udp packets. This espcially happens when
> small datagramms occurs as they arrive before big ones.
> I know that udp packets aren't guaranteed to arrive in order but I
> would know what kernel changes affects this udp behavior.
> After troublshooting the application I didn't find waht could cause
> the problem. Here some parameters I changed either wtih ethtool or
> sysctl: -RX fifo length -irq interrupts vs cpus - RSS mode activation
> /deactivation
> for ibg and ixgbe drivers here are the versions I used in both cases
> :
> Kernel 4.4.27
> modinfo igb :
> filename:       /lib/modules/4.4.27-
> HRN06/kernel/drivers/net/ethernet/intel/igb/igb.ko
> version:        5.3.0-k
> license:        GPL
> description:    Intel(R) Gigabit Ethernet Network Driver
> modinfo ixgbe:
> filename:       /lib/modules/4.4.27-
> HRN06/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko
> version:        4.2.1-k
> license:        GPL
> description:    Intel(R) 10 Gigabit PCI Express Network Driver
> 
> Kernel 4.14.20
> modinfo igb:
> filename:       /lib/modules/4.14.20-
> HRN09/kernel/drivers/net/ethernet/intel/igb/igb.ko
> version:        5.4.0-k
> license:        GPL
> description:    Intel(R) Gigabit Ethernet Network Driver
> author:         Intel Corporation, <e1000-devel@lists.sourceforge.net
> >
> modinfo ixgbe
> filename:       /lib/modules/4.14.20-
> HRN09/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko
> version:        5.1.0-k
> license:        GPL
> description:    Intel(R) 10 Gigabit PCI Express Network Driver
> author:         Intel Corporation, <linux.nics@intel.com>
> 
> I also modified RX buffers but no good results
> 

First thing, please send requests like this to our public mailing list
so that all of the Intel Ethernet developers can review and help
respond to your questions.  I have gone ahead and added our public
mailing list.

The kernel versions you are using are older and do not contain all the
bug fixes and changes.  Is there any chance that you can use the latest
kernel from David Miller or Linus kernel git tree?

Also can you provide the hardware you are using for both the igb and
ixgbe drivers?  Specifically the NICs you are using.  This can be
obtained by running lspci -vvv.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190408/160a5c97/attachment.asc>
