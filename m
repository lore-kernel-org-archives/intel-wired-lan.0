From: Daniel Axtens <dja@axtens.net>
Date: Tue, 25 Jul 2017 15:23:02 +1000
Subject: [Intel-wired-lan] ixgbe: X540T + BMC - speed stuck at 100Mbit
Message-ID: <87o9s9um2x.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm looking at a Dell system that has an ixgbe X540T card that is shared
with a BMC.

When the system boots, the card negotiates a speed of 100Mbit, even
though the other end is capable of 10Gbit and autonegotiation is on.

Unplugging the network cable from the card and plugging it back in again
causes the speed to go to 10Gbit, but if the system is shut down and
then booted again, the speed drops back to 100Mbit.

Asking for a renegotiation with 'ethtool -r' doesn't cause the speed to
change, nor does bringing it down and up with 'ip link'.

Our theory is that this is related to the sharing with the BMC. It was
first observed when the userspace on the system changed from Ubuntu
14.04 to Ubuntu 16.04, but it doesn't seem to depend on the kernel
version - it seems to be some sort of weird race condition.

Is there any way to force a harder reset of the card to make it
renegotiate? I thought that probe() would call reset_hw() and that
ixgbe_reset_hw_X540() would be sufficient to reset the link but it
doesn't seem to be taking.

(This has been observed on a stock Xenial kernel, which is based on v4.4
but with some of the more recent fixes to the driver backported. I
haven't seen anything in the git history that looks like it would fix
the issue, but I can try a more recent kernel version if that would be
helpful.)

Thanks in advance!

Regards,
Daniel
