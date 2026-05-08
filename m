Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4096CD37A7
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 12:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C23040F54;
	Fri,  8 May 2026 12:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pS0Pp2kt3M09; Fri,  8 May 2026 12:59:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A335740F84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778245189;
	bh=KhR0clBjP/i1cxVxR2nrNsdPKIvqAtVc0P8uLc84SCs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b6eJ96+z7ms+2pxMXoO47AHrpX5JM/yYWvdFX4HAMw+0THu5uECmEUWa+00ZNL1SC
	 ZKMn+jbOxIr2hLooU6KcuhPVAMtuyawAy9k6JUkM2EyK4mubHRYWXk51PIy3VCf5ou
	 AH7ELPYxS4DSiSOja5biPOp0nMbV/9Z44crG1LPg/DOzAiWZsePsgf7dynYJBcKSM9
	 9q+tl5jAeepA3TD8HwRNt41892w8FXOH23epGT7ftxmYaWCwSvjkeSLEk7gOPIs5Ns
	 n9aCIcGzj1xKvavliG7rkDB29ouJyeI6+18N1L5ShOCSzmBu7iYHPI0IOa3NhsqVpq
	 NEduaz/yzbVJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A335740F84;
	Fri,  8 May 2026 12:59:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B7C9317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 12:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DAA940E67
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 12:59:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TO-_ZolcsqOp for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 12:59:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4472F40F2F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4472F40F2F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4472F40F2F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 12:59:45 +0000 (UTC)
X-CSE-ConnectionGUID: U9F9IDYxQjuxG5RBKeBFLw==
X-CSE-MsgGUID: 8rz4pM6oTAKrRGsiRo73PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79199870"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79199870"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 05:59:45 -0700
X-CSE-ConnectionGUID: wdc3UB6nSnidgWE+t0qDOA==
X-CSE-MsgGUID: 0V1VuZUnRiC9MCyfZ2Ctwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241730097"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 05:59:39 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id A0EA028799;
 Fri,  8 May 2026 13:59:37 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org, Michal Schmidt <mschmidt@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 bruce.richardson@intel.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 padraig.j.connolly@intel.com, ananth.s@intel.com,
 timothy.miskell@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Date: Fri,  8 May 2026 14:41:55 +0200
Message-Id: <20260508124208.11622-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778245186; x=1809781186;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QsJaN+gGgc7NJavl6FKWkJ2C+kjJw0qTT0RUyfrJlN0=;
 b=QSnAQlIrJCpxItFplryKyMmxtgEKpHFxQ+LlKpe40OPrmCXqwNERw4q2
 VNUtsIPKBL4NSywHIaL0iNtd2K7WBfO0xTYs7VW1u2Qj7SZMv5cDcVR4G
 HsDbSviQZ+qeaCK6owzzaphAoen7erU91pp7O1fBTp0cAA9cBM82BOviO
 jmS/JGpIITb6oLeGr7r9hRHQmhETbXVXq+2K/JH02wkvF0a7FUtPIocJM
 ncJ3vzoJvV7vdkuO7BnkEpiYvcl7FaM0F4oaC1C4us80k6ZIazr/aZPVc
 7/iXA5a1HBKRHImYanZVqhRGR7n/VV/YAfOTrFLg4HaWMqCZeMt1ojgA8
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QSnAQlIr
Subject: [Intel-wired-lan] [PATCH iwl-next v1 02/15] ice: use shared devlink
 to store ice_adapters instead of custom xarray
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Refactor our storage and deduplication logic of ice_adapters by moving
it to be handled by shared devlink instance, recently added by
Jiri Pirko [1].

We wanted the devlink instance for whole device anyway - later in the
series I will add devlink resources under it.

Make the shared devlink a parent (wrt. nesting) of the actual PF devices.

[1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'")
[1]  https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h  | 12 +--
 .../net/ethernet/intel/ice/devlink/devlink.c  |  3 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 97 ++++++-------------
 drivers/net/ethernet/intel/ice/ice_main.c     |  4 +-
 4 files changed, 42 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index e95266c7f20b..5539ec5f8515 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -6,7 +6,8 @@
 
 #include <linux/types.h>
 #include <linux/spinlock_types.h>
-#include <linux/refcount_types.h>
+
+#include <net/devlink.h>
 
 struct pci_dev;
 struct ice_pf;
@@ -27,27 +28,26 @@ struct ice_port_list {
 
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
- * @refcount: Reference count. struct ice_pf objects hold the references.
+ * @devlink: ice adapter's devlink (whole dev devlink)
  * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
  *                        register of the PTP clock.
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
- * @index: 64-bit index cached for collision detection on 32bit systems
  */
 struct ice_adapter {
-	refcount_t refcount;
+	struct devlink *devlink;
+
 	/* For access to the GLTSYN_TIME register */
 	spinlock_t ptp_gltsyn_time_lock;
 	/* For access to GLCOMM_QTX_CNTX_CTL register */
 	spinlock_t txq_ctx_lock;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
-	u64 index;
 };
 
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
-void ice_adapter_put(struct pci_dev *pdev);
+void ice_adapter_put(struct ice_adapter *adapter);
 
 #endif /* _ICE_ADAPTER_H */
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 641d6e289d5c..f6382d038048 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1750,7 +1750,10 @@ struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf)
 void ice_devlink_register(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
+	struct ice_adapter *adapter = pf->adapter;
 
+	if (adapter)
+		devl_nested_devlink_set(adapter->devlink, devlink);
 	devl_register(devlink);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index cbb57060bd56..d07d349a1692 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -1,18 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // SPDX-FileCopyrightText: Copyright Red Hat
 
-#include <linux/cleanup.h>
-#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/xarray.h>
+
 #include "ice_adapter.h"
 #include "ice.h"
 
-static DEFINE_XARRAY(ice_adapters);
-static DEFINE_MUTEX(ice_adapters_mutex);
-
 #define ICE_ADAPTER_FIXED_INDEX	BIT_ULL(63)
 
 #define ICE_ADAPTER_INDEX_E825C	\
@@ -40,44 +35,36 @@ static u64 ice_adapter_index(struct pci_dev *pdev)
 	}
 }
 
-static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
-{
-	u64 index = ice_adapter_index(pdev);
-
-#if BITS_PER_LONG == 64
-	return index;
-#else
-	return (u32)index ^ (u32)(index >> 32);
-#endif
-}
-
-static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
+static int ice_adapter_init(void *priv, void *init_param)
 {
-	struct ice_adapter *adapter;
+	struct ice_adapter *adapter = priv;
+	struct devlink *devlink;
 
-	adapter = kzalloc_obj(*adapter);
-	if (!adapter)
-		return NULL;
+	devlink = shd_priv_to_devlink(adapter);
+	adapter->devlink = devlink;
 
-	adapter->index = ice_adapter_index(pdev);
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	spin_lock_init(&adapter->txq_ctx_lock);
-	refcount_set(&adapter->refcount, 1);
 
 	mutex_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.ports);
 
-	return adapter;
+	return 0;
 }
 
-static void ice_adapter_free(struct ice_adapter *adapter)
+static void ice_adapter_fini(void *priv)
 {
+	struct ice_adapter *adapter = priv;
+
 	WARN_ON(!list_empty(&adapter->ports.ports));
 	mutex_destroy(&adapter->ports.lock);
-
-	kfree(adapter);
 }
 
+static const struct devlink_ops ice_adapter_devlink_ops = {
+	.shd_init = ice_adapter_init,
+	.shd_fini = ice_adapter_fini,
+};
+
 /**
  * ice_adapter_get - Get a shared ice_adapter structure.
  * @pdev: Pointer to the pci_dev whose driver is getting the ice_adapter.
@@ -94,54 +81,32 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
 	struct ice_adapter *adapter;
-	unsigned long index;
-	int err;
-
-	index = ice_adapter_xa_index(pdev);
-	scoped_guard(mutex, &ice_adapters_mutex) {
-		adapter = xa_load(&ice_adapters, index);
-		if (adapter) {
-			refcount_inc(&adapter->refcount);
-			WARN_ON_ONCE(adapter->index != ice_adapter_index(pdev));
-			return adapter;
-		}
-		err = xa_reserve(&ice_adapters, index, GFP_KERNEL);
-		if (err)
-			return ERR_PTR(err);
-
-		adapter = ice_adapter_new(pdev);
-		if (!adapter) {
-			xa_release(&ice_adapters, index);
-			return ERR_PTR(-ENOMEM);
-		}
-		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
-	}
+	struct devlink *devlink;
+	char devlink_id[32];
+	u64 index;
+
+	index = ice_adapter_index(pdev);
+	snprintf(devlink_id, sizeof(devlink_id), "%llx", index);
+	devlink = devlink_shd_get(devlink_id, &ice_adapter_devlink_ops,
+				  sizeof(*adapter), NULL, pdev->dev.driver);
+	if (!devlink)
+		return ERR_PTR(-ENOMEM);
+
+	adapter = devlink_shd_get_priv(devlink);
+
 	return adapter;
 }
 
 /**
  * ice_adapter_put - Release a reference to the shared ice_adapter structure.
- * @pdev: Pointer to the pci_dev whose driver is releasing the ice_adapter.
+ * @adapter: the ice_adapter to release reference to
  *
  * Releases the reference to ice_adapter previously obtained with
  * ice_adapter_get.
  *
  * Context: Process, may sleep.
  */
-void ice_adapter_put(struct pci_dev *pdev)
+void ice_adapter_put(struct ice_adapter *adapter)
 {
-	struct ice_adapter *adapter;
-	unsigned long index;
-
-	index = ice_adapter_xa_index(pdev);
-	scoped_guard(mutex, &ice_adapters_mutex) {
-		adapter = xa_load(&ice_adapters, index);
-		if (WARN_ON(!adapter))
-			return;
-		if (!refcount_dec_and_test(&adapter->refcount))
-			return;
-
-		WARN_ON(xa_erase(&ice_adapters, index) != adapter);
-	}
-	ice_adapter_free(adapter);
+	devlink_shd_put(adapter->devlink);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 716ac8800559..42d9c4220f43 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5380,7 +5380,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 unroll_dev_init:
 	need_dev_deinit = true;
 unroll_adapter:
-	ice_adapter_put(pdev);
+	ice_adapter_put(adapter);
 unroll_hw_init:
 	ice_deinit_hw(hw);
 	if (need_dev_deinit)
@@ -5493,7 +5493,7 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
-	ice_adapter_put(pdev);
+	ice_adapter_put(pf->adapter);
 	ice_deinit_hw(&pf->hw);
 
 	ice_deinit_dev(pf);
-- 
2.39.3

