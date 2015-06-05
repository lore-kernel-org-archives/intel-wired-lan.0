From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 05 Jun 2015 00:51:14 -0400
Subject: [Intel-wired-lan] [net-next PATCH 2 07/13] ixgbe: Add const string
 for overheat message
In-Reply-To: <20150605045038.26373.94842.stgit@dcs-desk.jf.intel.com>
References: <20150605045038.26373.94842.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150605045114.26373.80994.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The over heat message is displayed for mutliple reasons but the text is
cut-n-pasted for each of these cases.  This patch pulls the text from the
same location.  I noticed this as I am about to add anothere case.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5aea3ef..83fc1a3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -81,6 +81,8 @@ const char ixgbe_driver_version[] = DRV_VERSION;
 static const char ixgbe_copyright[] =
 				"Copyright (c) 1999-2014 Intel Corporation.";
 
+static const char ixgbe_overheat_msg[] = "Network adapter has been stopped because it has over heated. Restart the computer. If the problem persists, power off the system and replace the adapter";
+
 static const struct ixgbe_info *ixgbe_info_tbl[] = {
 	[board_82598]		= &ixgbe_82598_info,
 	[board_82599]		= &ixgbe_82599_info,
@@ -2407,10 +2409,7 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 			return;
 		break;
 	}
-	e_crit(drv,
-	       "Network adapter has been stopped because it has over heated. "
-	       "Restart the computer. If the problem persists, "
-	       "power off the system and replace the adapter\n");
+	e_crit(drv, "%s\n", ixgbe_overheat_msg);
 
 	adapter->interrupt_event = 0;
 }
@@ -2457,10 +2456,7 @@ static void ixgbe_check_overtemp_event(struct ixgbe_adapter *adapter, u32 eicr)
 		return;
 	}
 
-	e_crit(drv,
-	       "Network adapter has been stopped because it has over heated. "
-	       "Restart the computer. If the problem persists, "
-	       "power off the system and replace the adapter\n");
+	e_crit(drv, "%s\n", ixgbe_overheat_msg);
 }
 
 static void ixgbe_check_sfp_event(struct ixgbe_adapter *adapter, u32 eicr)

