From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Date: Tue, 18 Aug 2015 11:32:31 -0400
Subject: [Intel-wired-lan] e1000e driver - commit 37b12910 needs to be in
	Linus tree..
Message-ID: <2887.1439911951@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hate to bother everybody, but we're at -rc7..

Commit 83129b37ef is still in Linus's tree.  This one causes a crash
on my Dell Latitude after 4 hours uptime.

commit 83129b37ef35bb6a7f01c060129736a8db5d31c4
Author: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date:   Tue Jun 2 17:05:45 2015 +0300

    e1000e: fix systim issues

Commit 37b12910dd fixes it, but is *NOT* in Linus's tree yet.

commit 37b12910dd11d9ab969f2c310dc9160b7f3e3405
Author: Raanan Avargil <raanan.avargil@intel.com>
Date:   Sun Jul 19 16:33:20 2015 +0300

    e1000e: Fix tight loop implementation of systime read algorithm

Can we do something to get this fix in-tree, or revert the problem commit?



-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150818/af37e799/attachment.asc>
