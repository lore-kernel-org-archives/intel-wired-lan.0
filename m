From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 03 Jun 2015 20:13:53 -0400
Subject: [Intel-wired-lan] [net-next PATCH 07/11] ixgbe: Add const string
	for overheat message
In-Reply-To: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
References: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150604001353.18893.83669.stgit@dcs-desk.jf.intel.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5aea3ef..8f8c5d3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -81,6 +81,11 @@ const char ixgbe_driver_version[] = DRV_VERSION;
 static const char ixgbe_copyright[] =
 				"Copyright (c) 1999-2014 Intel Corporation.";
 
+static const char ixgbe_overheat_msg[] =
+		"Network adapter has been stopped because it has over heated. "
+		"Restart the computer. If the problem persists, "
+		"power off the system and replace the adapter";
+
 static const struct ixgbe_info *ixgbe_info_tbl[] = {
 	[board_82598]		= &ixgbe_82598_info,
 	[board_82599]		= &ixgbe_82599_info,
@@ -2407,10 +2412,7 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
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
@@ -2457,10 +2459,7 @@ static void ixgbe_check_overtemp_event(struct ixgbe_adapter *adapter, u32 eicr)
 		return;
 	}
 
-	e_crit(drv,
-	       "Network adapter has been stopped because it has over heated. "
-	       "Restart the computer. If the problem persists, "
-	       "power off the system and replace the adapter\n");
+	e_crit(drv, "%s\n", ixgbe_overheat_msg);
 }
 
 static void ixgbe_check_sfp_event(struct ixgbe_adapter *adapter, u32 eicr)

