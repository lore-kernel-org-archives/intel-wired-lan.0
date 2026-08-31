Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B7EC624A4
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13FF640545;
	Mon, 31 Aug 2026 16:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oAjileh6gvua; Mon, 31 Aug 2026 16:11:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788192665;
	bh=lqXUxboPtpnTz8zM4jR3VQW7Oc1JjrspPLSNhTN/Bj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C0rC311IrQMlPDajLPyh7zCtrcV0Y2B1t+8kk0gRMiybEkJjfzlOH+efUdEnCSaXy
	 6NU629pa+gqfP/8RJiMbLd8dPThjJDCrbc60ukVRDAA6L685ryBzpL2RQjjTIrIKK7
	 k1sus6gb7ije4n5Vf+yg8PgaNv5d0czvswIE+88pgihzkHpPeihWlAcZ5nesiJBixD
	 u0AQbdQ/JpbeqWKg/ktmV1hXyEZ97uULHshCRGAkUl0IcwR065V1kC1Eso+3hnr+Ll
	 0Rjgk45SXiKTVyCYGs+YwZkCSvKBllZ+zQzdELgk2dC2QWuSPvJzrUyKBEbzUe3GT7
	 5CTcjuUU+CiCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CE8B40549;
	Mon, 31 Aug 2026 16:11:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3650423E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 16:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2858140549
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 16:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTJyiX2se7HJ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Aug 2026 16:11:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=C+sfRnMt
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2270B4054A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788192663; x=1819728663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AWD8JphA/F9C4WUtKk5k7CmRrzFpkslTAK2T77iQlhs=;
 b=C+sfRnMt3OyLjQppUUPGZWF/7oSNwN1ic38ur4SfcZ7tl2gYSaHYOdZs
 PE5E5RrhXW4u4bs5apJgvqtScHJM1KSunDjeVdf1jxYT32VGiEawHSyQU
 iYt2prBq4EFzzLN6DjpqQOtUXAV0tt5w1dvImDxfx6PPcabuFncyP5Use
 kY1NrRfApltohocGFsCKfqI7YsaJHNAN58RwpO0fk/ciK8QQhhQ4psBBM
 2epT/mF9Ws4vrWHiqkG+Qkm88GBMTElQyGahRVVLGD5g4RA72/cDvRqRJ
 qKifWS58PGx2A+FP84m84hXRd4pKzKWHPIH4WV4PYA+i9uZ4O34GIeMX0 w==;
X-CSE-ConnectionGUID: e7uhxy89SqqK+A0KgG+tRg==
X-CSE-MsgGUID: sbWFb3KMRa2WvmbPERYSlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88729030"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88729030"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 09:11:03 -0700
X-CSE-ConnectionGUID: pUNQh4kyQ8mR25hVmYMpdA==
X-CSE-MsgGUID: xX53UfviQdawcKRiM1xEGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="262706413"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2026 09:11:02 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 1/3] ice: Convert ctrl_pf pointer in struct
 ice_adapter to RCU
Date: Mon, 31 Aug 2026 16:10:58 +0000
Message-ID: <20260831161100.216773-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
References: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use RCU to ensure the consistent state of the control PF global
pointer contained in struct ice_adapter. Enforce RCU usage on
the callers.

Fix a potential invalid pointer return due a TOCTOU issue

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 25 +++++-
 drivers/net/ethernet/intel/ice/ice_adapter.c |  1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 80 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 20 +++++
 drivers/net/ethernet/intel/ice/ice_txclk.c   | 19 +++--
 6 files changed, 113 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c..c14bb1eb271e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -40,6 +40,7 @@
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
 #include <linux/gnss.h>
+#include <linux/rcupdate.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/tc_act/tc_mirred.h>
@@ -1148,26 +1149,44 @@ static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
  * ice_get_primary_hw - Get pointer to primary ice_hw structure
  * @pf: pointer to PF structure
  *
+ * The function must be called from an RCU read-side critical section or
+ * while holding adapter->ctrl_pf_lock.
+ * hw is embedded in struct ice_pf, so either mechanism protects its lifetime.
+ *
  * Return: A pointer to ice_hw structure with access to timesync
  * register space.
  */
 static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 {
-	if (!pf->adapter->ctrl_pf)
+	struct ice_pf *ctrl_pf;
+
+	ctrl_pf = rcu_dereference_check(pf->adapter->ctrl_pf,
+					lockdep_is_held(&pf->adapter->ctrl_pf_lock));
+
+	if (!ctrl_pf)
 		return &pf->hw;
 	else
-		return &pf->adapter->ctrl_pf->hw;
+		return &ctrl_pf->hw;
 }
 
 /**
  * ice_get_ctrl_pf - Get pointer to Control PF of the adapter
  * @pf: pointer to the current PF structure
  *
+ * The control PF is the PF which owns the PTP clock for the adapter.
+ * Only the control PF is allowed to perform certain operations on the
+ * PTP clock such as adjusting the time or configuring the pins.
+ *
+ * This function must be called from an RCU read-side critical section or
+ * while holding adapter->ctrl_pf_lock.
+ *
  * Return: A pointer to ice_pf structure which is Control PF,
  * NULL if it's not initialized yet.
  */
 static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
 {
-	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
+	return !pf->adapter ? NULL :
+		rcu_dereference_check(pf->adapter->ctrl_pf,
+				      lockdep_is_held(&pf->adapter->ctrl_pf_lock));
 }
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 2dc3629d6d0f..80cb8dc6b81a 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -66,6 +66,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 		mutex_init(&adapter->cpi_phy_lock[i]);
 	refcount_set(&adapter->refcount, 1);
 
+	init_rwsem(&adapter->ctrl_pf_lock);
 	mutex_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.ports);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 4f695f32da3d..b1af59718482 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/spinlock_types.h>
 #include <linux/refcount_types.h>
 
@@ -36,6 +37,7 @@ struct ice_port_list {
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
+ * @ctrl_pf_lock: Protect control PF lifetime for sleepable users
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
@@ -49,7 +51,8 @@ struct ice_adapter {
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 
-	struct ice_pf *ctrl_pf;
+	struct rw_semaphore ctrl_pf_lock;
+	struct ice_pf __rcu *ctrl_pf;
 	struct ice_port_list ports;
 	u64 index;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index eaec36ab6ae3..ec2fd89c18a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/rcupdate.h>
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
@@ -55,6 +56,19 @@ static const struct ice_ptp_pin_desc ice_pin_desc_dpll[] = {
 	{  SDP3, {  3, -1 }, { 0, 0 }},
 };
 
+/**
+ * ice_get_ctrl_ptp - Get the PTP structure for the control PF
+ * @pf: The PF pointer to look up at
+ *
+ * The control PF is the PF which owns the PTP clock for the adapter.
+ * Only the control PF is allowed to perform certain operations on the
+ * PTP clock such as adjusting the time or configuring the pins.
+ *
+ * This function must be called from an RCU read-side critical section or
+ * while holding adapter->ctrl_pf_lock.
+ *
+ * Return: Pointer to the PTP structure of the control PF, or NULL if not found
+ */
 static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
 {
 	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
@@ -203,39 +217,42 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 	u32 hi, lo, lo2;
 	u8 tmr_idx;
 
-	if (!ice_is_primary(hw))
-		hw = ice_get_primary_hw(pf);
-
-	tmr_idx = ice_get_ptp_src_clock_index(hw);
-	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
-	/* Read the system timestamp pre PHC read */
-	ptp_read_system_prets(sts);
-
-	if (hw->mac_type == ICE_MAC_E830) {
-		u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
+	scoped_guard(rcu) {
+		if (!ice_is_primary(hw))
+			hw = ice_get_primary_hw(pf);
 
-		/* Read the system timestamp post PHC read */
-		ptp_read_system_postts(sts);
-
-		return clk_time;
-	}
+		tmr_idx = ice_get_ptp_src_clock_index(hw);
+		guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
+		/* Read the system timestamp pre PHC read */
+		ptp_read_system_prets(sts);
 
-	lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+		if (hw->mac_type == ICE_MAC_E830) {
+			u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
 
-	/* Read the system timestamp post PHC read */
-	ptp_read_system_postts(sts);
+			/* Read the system timestamp post PHC read */
+			ptp_read_system_postts(sts);
 
-	hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
-	lo2 = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+			return clk_time;
+		}
 
-	if (lo2 < lo) {
-		/* if TIME_L rolled over read TIME_L again and update
-		 * system timestamps
-		 */
-		ptp_read_system_prets(sts);
 		lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+
+		/* Read the system timestamp post PHC read */
 		ptp_read_system_postts(sts);
+
 		hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
+		lo2 = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+
+		if (lo2 < lo) {
+			/* if TIME_L rolled over read TIME_L again and update
+			 * system timestamps
+			 */
+			ptp_read_system_prets(sts);
+			lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+			ptp_read_system_postts(sts);
+			hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
+		}
+
 	}
 
 	return ((u64)hi << 32) | lo;
@@ -3068,14 +3085,17 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 static void ice_ptp_setup_adapter(struct ice_pf *pf)
 {
-	pf->adapter->ctrl_pf = pf;
+	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
-	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ice_ptp *ptp = &pf->ptp;
+	struct ice_ptp *ctrl_ptp;
 
+	guard(rwsem_read)(&pf->adapter->ctrl_pf_lock);
+
+	ctrl_ptp = ice_get_ctrl_ptp(pf);
 	if (!ctrl_ptp) {
 		dev_info(ice_pf_to_dev(pf),
 			 "PTP unavailable: no controlling PF\n");
@@ -3130,11 +3150,15 @@ static void ice_ptp_cleanup_pf(struct ice_pf *pf)
  */
 int ice_ptp_clock_index(struct ice_pf *pf)
 {
-	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
+	struct ice_ptp *ctrl_ptp;
 	struct ptp_clock *clock;
 
+	guard(rcu)();
+
+	ctrl_ptp = ice_get_ctrl_ptp(pf);
 	if (!ctrl_ptp)
 		return -1;
+
 	clock = ctrl_ptp->clock;
 
 	return clock ? ptp_clock_index(clock) : -1;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..8e9eb7dcd8d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include "ice_common.h"
@@ -335,6 +336,8 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -353,6 +356,8 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -2004,6 +2009,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
 	} else {
+		guard(rcu)();
+
 		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
 	}
@@ -2173,6 +2180,8 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
 	} else {
+		guard(rcu)();
+
 		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
 	}
@@ -5300,6 +5309,9 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
  *
  * Software must clear the busy bit with a write to release the lock for other
  * functions when done.
+ *
+ * A successful call holds adapter->ctrl_pf_lock for read until
+ * ice_ptp_unlock() is called.
  */
 bool ice_ptp_lock(struct ice_hw *hw)
 {
@@ -5307,6 +5319,8 @@ bool ice_ptp_lock(struct ice_hw *hw)
 	u32 hw_lock;
 	int i;
 
+	down_read(&pf->adapter->ctrl_pf_lock);
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -5324,6 +5338,9 @@ bool ice_ptp_lock(struct ice_hw *hw)
 		break;
 	}
 
+	if (hw_lock)
+		up_read(&pf->adapter->ctrl_pf_lock);
+
 	return !hw_lock;
 }
 
@@ -5338,10 +5355,13 @@ void ice_ptp_unlock(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 
+	lockdep_assert_held(&pf->adapter->ctrl_pf_lock);
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
 	wr32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), 0);
+	up_read(&pf->adapter->ctrl_pf_lock);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_txclk.c b/drivers/net/ethernet/intel/ice/ice_txclk.c
index 48459f971cbf..6d30d2f3f2a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_txclk.c
+++ b/drivers/net/ethernet/intel/ice/ice_txclk.c
@@ -41,6 +41,7 @@ ice_txclk_get_pin(struct ice_pf *pf, enum ice_e825c_ref_clk ref_clk)
 /**
  * ice_txclk_enable_peer - Enable required TX reference clock on peer PHY
  * @pf: pointer to the PF structure
+ * @ctrl_pf: control PF protected by adapter->ctrl_pf_lock
  * @clk: TX reference clock that must be enabled
  *
  * Some TX reference clocks on E825-class devices (SyncE and EREF0) must
@@ -54,13 +55,15 @@ ice_txclk_get_pin(struct ice_pf *pf, enum ice_e825c_ref_clk ref_clk)
  *
  * Return: 0 on success or negative error code on failure.
  */
-static int ice_txclk_enable_peer(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
+static int ice_txclk_enable_peer(struct ice_pf *pf, struct ice_pf *ctrl_pf,
+				 enum ice_e825c_ref_clk clk)
 {
-	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 	bool peer_clk_in_use;
 	u8 port_num, phy;
 	int err;
 
+	lockdep_assert_held(&pf->adapter->ctrl_pf_lock);
+
 	if (clk == ICE_REF_CLK_ENET)
 		return 0;
 
@@ -118,12 +121,15 @@ static int ice_txclk_enable_peer(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
  */
 int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
 {
-	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 	struct ice_port_info *port_info;
+	struct ice_pf *ctrl_pf;
 	bool clk_in_use;
 	u8 port_num, phy;
 	int err;
 
+	guard(rwsem_read)(&pf->adapter->ctrl_pf_lock);
+	ctrl_pf = ice_get_ctrl_pf(pf);
+
 	if (pf->ptp.port.tx_clk == clk)
 		return 0;
 
@@ -164,7 +170,7 @@ int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
 	mutex_unlock(&ctrl_pf->dplls.lock);
 
 	if (!clk_in_use) {
-		err = ice_txclk_enable_peer(pf, clk);
+		err = ice_txclk_enable_peer(pf, ctrl_pf, clk);
 		if (err)
 			return err;
 	}
@@ -215,15 +221,18 @@ int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
 void ice_txclk_update_and_notify(struct ice_pf *pf)
 {
 	struct ice_ptp_port *ptp_port = &pf->ptp.port;
-	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 	struct dpll_pin *old_pin = NULL;
 	struct dpll_pin *new_pin = NULL;
+	struct ice_pf *ctrl_pf;
 	struct ice_hw *hw = &pf->hw;
 	enum ice_e825c_ref_clk clk;
 	bool notify_dpll = false;
 	int err;
 	u8 phy;
 
+	guard(rwsem_read)(&pf->adapter->ctrl_pf_lock);
+	ctrl_pf = ice_get_ctrl_pf(pf);
+
 	phy = ptp_port->port_num / hw->ptp.ports_per_phy;
 
 	/* Hold txclk_notify_rwsem for read across the entire critical
-- 
2.53.0

