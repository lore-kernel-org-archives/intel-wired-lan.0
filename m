From: William Dauchy <william@gandi.net>
Date: Fri, 27 Nov 2015 11:05:57 +0100
Subject: [Intel-wired-lan] dynamically set number of queues for 82598
	devices in -stable
Message-ID: <20151127100557.GB21147@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Jeff,

I faced the problem described in commit 7e3f5c8:
ixgbe: fix bounds checking in ixgbe_setup_tc for 82598

This patch resolves an issue where users were not able to dynamically
set number of queues for 82598 via ethtool -L


I backported it for my v4.1.x build but I was wondering if this could be
a candidate for a backport in stable tree at least for v4.1.x.

Thanks,
-- 
William
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151127/af3a33c9/attachment.asc>
