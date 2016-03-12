From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 11 Mar 2016 17:07:23 -0800
Subject: [Intel-wired-lan] [PATCH 0/5] ixgbe: An assortment of fixes and
	cleanups
Message-ID: <20160312010538.130154.49237.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patches fix a length checking problem, correct the
failure to take a needed semaphore in all uses of firmware commands,
and do some other cleanups.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

---

Mark D Rustad (5):
      ixgbe: Delete some unused register definitions
      ixgbe: Change the lan_id and func fields to a u8 to avoid casts
      ixgbe: Correct length check for round up
      ixgbe: Clean up interface for firmware commands
      ixgbe: Take manageability semaphore for firmware commands


 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   73 +++++++++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |    4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |   12 +---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |   15 ++---
 4 files changed, 52 insertions(+), 52 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
