From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 22 Oct 2015 16:26:23 -0700
Subject: [Intel-wired-lan] [net-next PATCH 0/3] ixgbe: Fix FDB handling
Message-ID: <20151022232228.24612.81341.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series addresses a number of issues in the FDB handling code of
the ixgbe driver.  Specifically there were 3 issues.

1.  The addresses were being allocated but not freed from the MAC address
tables.  As a result cycling in and out various addresses would end up
exhausing the table.

2.  The entries weren't being counted correclty and as a result only half
of the MAC address entries could be used at any given point in time.

3.  The FDB entries were being limited to only 15 while there were 126
RAL/H entries available.

With this patch series in place it is possible ot maintain a decent sized
set of FDB entries and they can cycle in and out without incurring any
heavy cost as previously seen.

---

Alexander Duyck (3):
      ixgbe: Refactor MAC address configuration code
      ixgbe: Use __dev_uc_sync and __dev_uc_unsync for unicast addresses
      ixgbe: Allow FDB entries access to more RAR filters


 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    7 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  196 ++++++++++++++++---------
 2 files changed, 129 insertions(+), 74 deletions(-)

--
