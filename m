From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 31 May 2016 15:02:02 -0700
Subject: [Intel-wired-lan] fm10k driver questions
In-Reply-To: <CABnJGMiPnNDNyNX-=6J1QjxR=wjC09rN3qdJDzW2_Nq0fH4wCw@mail.gmail.com>
References: <CABnJGMiPnNDNyNX-=6J1QjxR=wjC09rN3qdJDzW2_Nq0fH4wCw@mail.gmail.com>
Message-ID: <1464732122.2599.50.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-05-31 at 10:35 -0700, Ryan Goodfellow wrote:
> I have a few Intel FM10420 based devices (Supermicro AOC-S100G-i2C) that
> I am trying to get working in our lab using dpdk and some of the network
> virtualization functions of the card. However, I am a bit confused on the
> two different sources of kernel drivers. In the documentation here?the
> instructions include passing parameters to the fm10k kernel module. In
> looking at source?for fm10k I see no such parameters and modinfo supports
> that. Then I found a?different set of Intel drivers that do seem to
> support these options. Could someone please tell me the relationship
> between these two source trees?

In kernel drivers do not have the module parameters option because the
Linux community is not able to come to a standard, so have opted to use
existing tools (i.e. ethtool, sysfs, etc.) for enabling/disabling/modifying
features. ?Our out-of-tree drivers, found on http://e1000.sf.net?have the
ability to load module parameters on load.

In most cases, the in-kernel and out-of-tree versions are very close in
functionality. ?In the case of FM10K, the in-kernel version is the most up-
to-date (unless you are using an older kernel, anything older than 4.6).

We distribute the out-of-tree version for two reasons, one to give users
the ability to do module parameters on module load and second is to provide
our latest driver with the ability to load on older kernels (due to kcompat
bundled with the out-of-tree driver).

DPDK adds another wrench in the mix, since DPDK bundles a version of our
driver with DPDK as well. ?Usually DPDK keeps up with what we have released
on sourceforge.net, but this is not guaranteed.
> 
> As I understand it this is the mailing list for the source tree within
> the kernel, and I would prefer to work with these sources. However when I
> load the kernel module I am having issues using the card, both as a
> kernel controlled Ethernet card and as a dpdk device. On the dpdk side of
> things I get an error saying the switch is not ready (PMD:
> eth_fm10k_dev_init(): switch is not ready), I have been looking for a way
> to make the switch ready through the kernel driver but have not found
> anything, any thoughts?

I will make sure that the FM10K developers review your issue and respond
accordingly. ?To help them, please provide what the kernel versions you are
using as well as what driver versions you may have installed. ?Since
ethtool is not help report any info, you can use modinfo and lspci to
report the driver and hardware information.

> In using the card as a kernel controlled Ethernet card, I have simply
> loaded the kernel module, it gets assigned to 'ens1' I bring the link up
> and assign and assign an IP address and try to ping another machine on
> the same subnet to no avail. I have also noticed that ethtool does not
> really seem to understand this card.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160531/ff212ee0/attachment.asc>
