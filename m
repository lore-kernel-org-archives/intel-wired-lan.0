From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 17 May 2017 15:17:51 -0700
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: always call setup_mac_link for
	multispeed fiber
In-Reply-To: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
References: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
Message-ID: <20170517221751.15538.97694.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove the logic which would previously skip the link configuration
in the case where we are already at the requested speed in
ixgbe_setup_mac_link_multispeed_fiber().

By exiting early we are skipping the link configuration and as such
the driver may not always configure the PHY correctly for SFP+.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 3af6127..8a2e8bf8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -4121,15 +4121,6 @@ s32 ixgbe_setup_mac_link_multispeed_fiber(struct ixgbe_hw *hw,
 		speedcnt++;
 		highest_link_speed = IXGBE_LINK_SPEED_10GB_FULL;
 
-		/* If we already have link at this speed, just jump out */
-		status = hw->mac.ops.check_link(hw, &link_speed, &link_up,
-						false);
-		if (status)
-			return status;
-
-		if (link_speed == IXGBE_LINK_SPEED_10GB_FULL && link_up)
-			goto out;
-
 		/* Set the module link speed */
 		switch (hw->phy.media_type) {
 		case ixgbe_media_type_fiber:
@@ -4181,15 +4172,6 @@ s32 ixgbe_setup_mac_link_multispeed_fiber(struct ixgbe_hw *hw,
 		if (highest_link_speed == IXGBE_LINK_SPEED_UNKNOWN)
 			highest_link_speed = IXGBE_LINK_SPEED_1GB_FULL;
 
-		/* If we already have link at this speed, just jump out */
-		status = hw->mac.ops.check_link(hw, &link_speed, &link_up,
-						false);
-		if (status)
-			return status;
-
-		if (link_speed == IXGBE_LINK_SPEED_1GB_FULL && link_up)
-			goto out;
-
 		/* Set the module link speed */
 		switch (hw->phy.media_type) {
 		case ixgbe_media_type_fiber:

