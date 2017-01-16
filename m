From: Daniel Genis <daniel.genis@gmx.de>
Date: Mon, 16 Jan 2017 15:05:40 +0100
Subject: [Intel-wired-lan] intel 82599ES freebsd 10.3-stable, no carrier
Message-ID: <d7d72e90-bbf3-f040-3f5a-ef4933faf6b1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Intel,

we're facing a very hard to debug problem with the our intel 82599ES 10gige cards on FreeBSD and would really appreciate your input.

The problem is that the cards enter a "no carrier" state, without network connectivity.
When in this state, the LEDs of the network cards are solid on (like in normal operation).

Network connectivity can be restored by either unplugging and replugging the network cable,
or by fully shutting down and opening the port on the network switch.


root at storage ~ # pciconf -lv | grep -B3 network
ix0 at pci0:1:0:0:	class=0x020000 card=0xffffffff chip=0x10fb8086 rev=0x01 hdr=0x00
    vendor     = 'Intel Corporation'
    device     = '82599ES 10-Gigabit SFI/SFP+ Network Connection'
    class      = network
--
ix1 at pci0:1:0:1:	class=0x020000 card=0xffffffff chip=0x10fb8086 rev=0x01 hdr=0x00
    vendor     = 'Intel Corporation'
    device     = '82599ES 10-Gigabit SFI/SFP+ Network Connection'
    class      = network

Our network is configured as follows (inside /etc/rc.conf):

cloned_interfaces="lagg0"
ifconfig_lagg0="laggproto failover laggport ix0 laggport ix1 10.1.2.254/16"
ifconfig_ix0="up"
ifconfig_ix1="up"



We're using Freebsd, and i've rebuilt the 10.3-stable kernel with the following debug
settings set to 1 (all 3 of them).  https://github.com/freebsd/freebsd/blob/3673260fc9cd940469688433ec5f09ca53d19107/sys/dev/ixgbe/ixgbe.h#L192
This is also the FreeBSD kernel which we're testing on. As far as the intel nic driver
is concerned it's the same as 10.3-RELEASE.

We haven't seen this issue on 10.1
10.2 likely is not affected either, but we are not 100% certain of that.
10.3 definitely is showing this issue

10.1 uses intel nic driver 2.5.15 10.2 uses intel nic driver 2.8.3 10.3 uses intel nic driver
3.1.13-k A full boot debug output of the 3.1.13-k driver booting into no
carrier state + subsequent switch port shut/open of ix0/ix1 can be seen
here: https://nopaste.me/view/cca08cee I've mailed this to the
FreeBSD-stable mailing list also, however it does not appear that many
others are facing this issue since we didn't get a response, it contains
a little more information as well:
https://lists.freebsd.org/pipermail/freebsd-stable/2017-January/086578.html
Most interestingly, when we pxe boot through the network the carrier
signal is available. When we boot from disk the nic's are in no carrier
state. This can be repeated. Do you guys have any suggestions as to how
we can debug this? Any help would be appreciated! With kind regards, Daniel

