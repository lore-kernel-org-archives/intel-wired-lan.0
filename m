From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed, 13 Jan 2016 16:51:42 -0800
Subject: [Intel-wired-lan] [v2 next PATCH S27 05/15] i40e: use new add_veb
	calling with veb stats control
In-Reply-To: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452732712-12248-6-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

The new parameters for add_veb allow us to enable and disable VEB stats,
so let's use them.

Update copyright year.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Ie6e68c68e2d1d459e42168eda661051b56bf0a65
---
Testing Hints: These commands should now do something useful:
	ethtool --set-priv-flags eth0 veb-stats on
	ethtool --set-priv-flags eth0 veb-stats off

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 11 ++++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f49f224..40a52b8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
- * Copyright(c) 2013 - 2015 Intel Corporation.
+ * Copyright(c) 2013 - 2016 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -2785,10 +2785,15 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		pf->auto_disable_flags |= I40E_FLAG_FD_ATR_ENABLED;
 	}
 
-	if (flags & I40E_PRIV_FLAGS_VEB_STATS)
+	if ((flags & I40E_PRIV_FLAGS_VEB_STATS) &&
+	    !(pf->flags & I40E_FLAG_VEB_STATS_ENABLED)) {
 		pf->flags |= I40E_FLAG_VEB_STATS_ENABLED;
-	else
+		reset_required = true;
+	} else if (!(flags & I40E_PRIV_FLAGS_VEB_STATS) &&
+		   (pf->flags & I40E_FLAG_VEB_STATS_ENABLED)) {
 		pf->flags &= ~I40E_FLAG_VEB_STATS_ENABLED;
+		reset_required = true;
+	}
 
 	if ((flags & I40E_PRIV_FLAGS_HW_ATR_EVICT) &&
 				   (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE))
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ce8651a..1c03ff6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10067,13 +10067,13 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = veb->pf;
 	bool is_default = veb->pf->cur_promisc;
-	bool is_cloud = false;
+	bool enable_stats = !!(pf->flags & I40E_FLAG_VEB_STATS_ENABLED);
 	int ret;
 
 	/* get a VEB from the hardware */
 	ret = i40e_aq_add_veb(&pf->hw, veb->uplink_seid, vsi->seid,
 			      veb->enabled_tc, is_default,
-			      &veb->seid, is_cloud, NULL);
+			      &veb->seid, enable_stats, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't add VEB, err %s aq_err %s\n",
-- 
2.1.0

