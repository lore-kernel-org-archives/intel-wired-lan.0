From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed, 13 Jan 2016 16:51:38 -0800
Subject: [Intel-wired-lan] [v2 next PATCH S27 01/15] i40e: move
	sync_vsi_filters up in service_task
In-Reply-To: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452732712-12248-2-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The sync_vsi_filters function is moved up in the service_task because
it may need to request a reset, and we don't want to wait another round
of service task time.

NOTE: Filters will be replayed by sync_vsi_filters including broadcast
and promiscuous settings.

Also, added some error handling in this space in case any of these
fail the driver will retry correctly.

Also update copyright year.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I23f3d552100baecea69466339f738f27614efd47
---
Testing Hints: This bug hits a sensitive area of the driver that is used in
many different paths such as reset (PFR/CORER/GLOBR) and multicast address
add/remove, vlan add/remove, MAC address add/remove.  As much testing as
possible should be done in the areas of filter add/remove, maximum filter
add, etc.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1f6ce52..2838ae0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
- * Copyright(c) 2013 - 2015 Intel Corporation.
+ * Copyright(c) 2013 - 2016 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -2168,6 +2168,10 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		}
 	}
 out:
+	/* if something went wrong then set the changed flag so we try again */
+	if (retval)
+		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
+
 	clear_bit(__I40E_CONFIG_BUSY, &vsi->state);
 	return retval;
 }
@@ -7104,6 +7108,7 @@ static void i40e_service_task(struct work_struct *work)
 	}
 
 	i40e_detect_recover_hung(pf);
+	i40e_sync_filters_subtask(pf);
 	i40e_reset_subtask(pf);
 	i40e_handle_mdd_event(pf);
 	i40e_vc_process_vflr_event(pf);
-- 
2.1.0

