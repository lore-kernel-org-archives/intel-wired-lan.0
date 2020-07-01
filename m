From: Paul Stewart <pstew@google.com>
Date: Wed, 1 Jul 2020 14:09:05 -0700
Subject: [Intel-wired-lan] ixgbe-x550 link detection after boot
Message-ID: <CAMcMvsjtsz3A+f-wA4yS7w+3dTaKO9tgCjeWPz_eAC5rMRHTNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi there.  I have a system with a Denverton based chipset which has a
built-in 4 ports of 10GBE.  It's properly configured to enumerate
as 8086:15c6 (IXGBE_DEV_ID_X550EM_A_SGMII).  It also successfully detects
link to its backplane partner with the stock ixgbe driver, but only if that
partner is up and running before the driver starts up.  If the Denverton
chipset comes up first, nothing I've tried so far as succeeded in having
the chipset detect link.  I've tried the normal "ifconfig down/up",
"ethtool -A eth1 autoneg off" etc, but nothing so far seems to do as much
as just rebooting the system.  Are there any hints as to how I can get this
going?  I've also tried "hw->mac.ops.reset_hw(hw)" and calling
"hw->mac.ops.setup_link()" again from the kernel and that surprisingly
didn't work either, so I'm getting curious as to what can get the system to
re-evaluate link state.  It's really true that the Links status register
does not mark the link as up (as shown by ethtool -d).

If it's of any consequence the SGMII link partner is a Marvell 88E1512.
MDIO is not connected.  For its part, the Marvell part detects link from
the Denverton whether or not that understanding is reciprocal.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200701/279fca6d/attachment.html>
