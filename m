Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCF2C55196
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 11:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6FC980D9D;
	Mon,  3 Aug 2026 11:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBheXewx5n8Q; Mon,  3 Aug 2026 11:41:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC37280DA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785757282;
	bh=olZ/9aK4J48rrRGq3Rh4GqiXWbqC7G/K+6X+LpeLwWw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fqIqV3ignT8HrZR5h5XRJu6+uXEhJjznq/Ekow2PWsM1G1wrONjGFH/PNW2CuvQZt
	 l6uJ+rIWj0lph6XBEGUVOfTIBED45m/qNVgpAGntr6BWXd45fOlmHbeMIUt7T+G3ve
	 K5mNaXOLViRwEZ5akqN+jFuveA2RMn/V9RFB1wNcLyLLY+mg4KnjV3IPA9XmgT1/o/
	 K47dI0BGzlbT1rhj/5pxkWSDGlJdsZzNfOeYtRuqOOJNXmKdATAj43UF6qgubiw2QM
	 ZdfRK/TYpvU/JOU7ZNyp067u1ol1ytME08VSk7XliHQOSI6YUmi/AdgtqqNaxHIeu2
	 uM8lz1dMucneQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC37280DA2;
	Mon,  3 Aug 2026 11:41:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 38ED92AA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 11:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A76E80D9D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 11:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 73891m6gzGGg for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 11:41:19 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3703C80DA2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3703C80DA2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3703C80DA2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 11:41:19 +0000 (UTC)
X-CSE-ConnectionGUID: bWALws1dSfyZp47Nr7xRrA==
X-CSE-MsgGUID: pJha6YCsRmaYf2NpLfYt2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="96878865"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="96878865"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 04:41:17 -0700
X-CSE-ConnectionGUID: PrALrjZ4QoaPpGJwgiarJg==
X-CSE-MsgGUID: kWWsoezJQT2oEA1SXM8Vjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="257299045"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa010.fm.intel.com with ESMTP; 03 Aug 2026 04:40:10 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  3 Aug 2026 13:35:05 +0200
Message-Id: <20260803113507.1858083-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260803113507.1858083-1-grzegorz.nitka@intel.com>
References: <20260803113507.1858083-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785757279; x=1817293279;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3VHs14ctbdCHZHJmw79Nv6gyfdb/VhIja/1/P1uZIWk=;
 b=DJRg4sBIbH6z8S7OCdfLxG/kivEQ34I/a95s7dc7moZ+LcMcndPRr0RT
 aC8xaVdb4hNjzQu5aasCBk5xMiiXCxXXcp4PVLLfKccQBWSbd+UYbcZE3
 s0iZF6+x9I+c7YQbVSzJDugY+JQHhxBCBX10x3IFC3g1epkr2lW9Ta/Ya
 zlm6xTamm2gliTg7dZ2kuG3HiwXxRSIcl4yaGxenUDWKXo3cH5GK2W6nm
 kGmu/U99oWV62WQQFW0yqawhIo/IttfN986YwCX+vXNW6r/stvOn1d7CK
 UkhK4dAMZSLtGkTOL2nE4b6YLDgApc+NNAt9CTL2OXSq/BM19HZAIFNLb
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DJRg4sBI
Subject: [Intel-wired-lan] [PATCH v3 iwl-next 1/3] ice: monitor TSPLL lock
 from PTP periodic worker
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
Cc: przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 Przemyslaw Korba <przemyslaw.korba@intel.com>, andrew+netdev@lunn.ch,
 edumazet@google.com, anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On E825 devices that own the source timer, the TSPLL can lose lock when
the TCXO or TIME_REF signal is disrupted. Recovery requires re-enabling
the TSPLL via CGU register writes; without it, the PHC keeps running on
a degraded reference indefinitely.

The DPLL periodic worker (ice_dpll_periodic_work()) would be a natural
home for this monitoring, but placing it there has two problems:

  1. ice_dpll_init_e825() sets ICE_FLAG_DPLL only after all initialization
     steps succeed. If any earlier step fails, the driver would run
     without any TSPLL recovery mechanism.

  2. When CONFIG_DPLL=n, the DPLL worker is compiled out and TSPLL
     recovery would be silently absent.

Add the monitor to ice_ptp_periodic_work() instead, which always runs on
E825 owner PFs regardless of DPLL init state or config. Introduce two
small helpers, ice_tspll_lost_lock_e825c() and ice_tspll_restart_e825c(),
which encapsulate the CGU register reads/writes required to observe and
recover the TSPLL.

Cache the observed lock state in pf->ptp.tspll_locked using
WRITE_ONCE()/READ_ONCE() so a follow-up change can consume it from the
DPLL periodic worker (for user-space notification via
dpll_device_change_ntf()) and drop the redundant poll+recovery from
that path. Precise synchronization is not required: both workers converge
on the same value within one poll period.

Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c   | 70 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   | 11 +++
 drivers/net/ethernet/intel/ice/ice_tspll.c | 88 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |  4 +
 4 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4df3d83b5066..a997be5f7d8f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -5,8 +5,11 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
+#include "ice_tspll.h"
 #include "ice_txclk.h"
 
+#define ICE_TSPLL_LOG_INTERVAL		120
+
 static const char ice_pin_names[][64] = {
 	"SDP0",
 	"SDP1",
@@ -2875,6 +2878,67 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_ptp_tspll_monitor - poll and recover TSPLL lock on E825 owner PFs
+ * @pf: Board private structure
+ *
+ * Called from the PTP periodic worker. On E825 devices that own the source
+ * timer, poll the TSPLL lock status via CGU registers and trigger a restart
+ * if the lock has been lost. The result is cached in @pf->ptp.tspll_locked
+ * so it can be consumed by the DPLL periodic worker via READ_ONCE().
+ *
+ * TSPLL lock is critical for PHC operation and must be monitored regardless
+ * of whether DPLL init succeeded or CONFIG_DPLL is enabled. Placing the
+ * monitor here makes recovery independent of the dpll subsystem.
+ *
+ * AQ read errors are rate-limited and do not stop monitoring. Lock-lost
+ * events are logged every 120 retries (~60 s at normal poll rate) to
+ * surface persistent failures without flooding the log.
+ */
+static void ice_ptp_tspll_monitor(struct ice_pf *pf)
+{
+	bool lock_lost;
+	int err;
+
+	if (pf->hw.mac_type != ICE_MAC_GENERIC_3K_E825 ||
+	    !ice_pf_src_tmr_owned(pf))
+		return;
+
+	err = ice_tspll_lost_lock_e825c(&pf->hw, &lock_lost);
+	if (err) {
+		dev_err_ratelimited(ice_pf_to_dev(pf),
+				    "Failed reading TimeSync PLL lock status (err: %d). Retrying.\n",
+				    err);
+		return;
+	}
+
+	if (lock_lost) {
+		WRITE_ONCE(pf->ptp.tspll_locked, false);
+		if (!(pf->ptp.tspll_lock_retries % ICE_TSPLL_LOG_INTERVAL))
+			dev_warn(ice_pf_to_dev(pf),
+				 "TimeSync PLL lock lost. Retrying to acquire lock.\n");
+		err = ice_tspll_restart_e825c(&pf->hw);
+		if (err)
+			dev_err_ratelimited(ice_pf_to_dev(pf),
+					    "Failed to restart TimeSync PLL (err: %d).\n",
+					    err);
+		pf->ptp.tspll_lock_retries++;
+	} else {
+		if (pf->ptp.tspll_lock_retries) {
+			enum ice_clk_src clk_src;
+			const char *src_str = "unknown";
+
+			if (!ice_tspll_get_clk_src(&pf->hw, &clk_src))
+				src_str = ice_tspll_clk_src_str(clk_src);
+			dev_info(ice_pf_to_dev(pf),
+				 "TimeSync PLL lock acquired with %s clock source after %u retries.\n",
+				 src_str, pf->ptp.tspll_lock_retries);
+		}
+		WRITE_ONCE(pf->ptp.tspll_locked, true);
+		pf->ptp.tspll_lock_retries = 0;
+	}
+}
+
 static void ice_ptp_periodic_work(struct kthread_work *work)
 {
 	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
@@ -2884,6 +2948,8 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
+	ice_ptp_tspll_monitor(pf);
+
 	err = ice_ptp_update_cached_phctime(pf);
 
 	ice_ptp_maybe_trigger_tx_interrupt(pf);
@@ -3001,6 +3067,9 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	err = ice_tspll_init(hw);
 	if (err)
 		return err;
+	/* Rebuild reinitialized TSPLL, so reset monitor retry state. */
+	WRITE_ONCE(ptp->tspll_locked, true);
+	ptp->tspll_lock_retries = 0;
 
 	/* Acquire the global hardware lock */
 	if (!ice_ptp_lock(hw)) {
@@ -3364,6 +3433,7 @@ void ice_ptp_init(struct ice_pf *pf)
 	}
 	ptp->port.port_num = hw->lane_num;
 
+	ptp->tspll_locked = true;
 	ice_ptp_init_hw(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index c4b0da7ce20e..0e40fef3b4e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -249,6 +249,15 @@ struct ice_ptp_pin_desc {
  * @tx_hwtstamp_discarded: number of Tx skbs discarded due to cached PHC time
  *                         being too old to correctly extend timestamp
  * @late_cached_phc_updates: number of times cached PHC update is late
+ * @tspll_locked: last observed TSPLL lock state on E825 owner PFs.
+ *	Written by the PTP periodic worker after polling the TSPLL and
+ *	intended to be read (without pf->dplls.lock) by the DPLL periodic
+ *	worker in a follow-up change. Access via READ_ONCE()/WRITE_ONCE();
+ *	precise synchronization is not required because both workers
+ *	converge on the same value within one poll period.
+ * @tspll_lock_retries: counts consecutive poll cycles in which the TSPLL
+ *	was found unlocked. Reset to zero when lock is re-acquired. Used to
+ *	rate-limit the lock-lost log message (~every 120 retries / ~60 s).
  */
 struct ice_ptp {
 	enum ice_ptp_state state;
@@ -274,6 +283,8 @@ struct ice_ptp {
 	u32 tx_hwtstamp_flushed;
 	u32 tx_hwtstamp_discarded;
 	u32 late_cached_phc_updates;
+	bool tspll_locked;
+	u32 tspll_lock_retries;
 };
 
 #define __ptp_port_to_ptp(p) \
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index fd4b58eb9bc0..be8e2da21dd6 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -129,7 +129,7 @@ static bool ice_tspll_check_params(struct ice_hw *hw,
  *
  * Return: specified clock source converted to its string name
  */
-static const char *ice_tspll_clk_src_str(enum ice_clk_src clk_src)
+const char *ice_tspll_clk_src_str(enum ice_clk_src clk_src)
 {
 	switch (clk_src) {
 	case ICE_CLK_SRC_TCXO:
@@ -531,6 +531,64 @@ int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
 	return ice_write_cgu_reg(hw, ICE_CGU_R9, val);
 }
 
+/**
+ * ice_tspll_lost_lock_e825c - check if TSPLL lost lock
+ * @hw: Pointer to the HW struct
+ * @lost_lock: Output flag for reporting lost lock
+ *
+ * Get E825 device TSPLL DPLL lock status.
+ *
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+int ice_tspll_lost_lock_e825c(struct ice_hw *hw, bool *lost_lock)
+{
+	u32 val;
+	int err;
+
+	err = ice_read_cgu_reg(hw, ICE_CGU_RO_LOCK, &val);
+	if (err)
+		return err;
+
+	*lost_lock = !FIELD_GET(ICE_CGU_RO_LOCK_TRUE_LOCK, val);
+
+	return 0;
+}
+
+/**
+ * ice_tspll_restart_e825c - trigger TSPLL restart
+ * @hw: Pointer to the HW struct
+ *
+ * Re-enable TSPLL for E825 device.
+ *
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+int ice_tspll_restart_e825c(struct ice_hw *hw)
+{
+	u32 val;
+	int err;
+
+	/* Read the initial values of r23 and disable the PLL */
+	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &val);
+	if (err)
+		return err;
+
+	val &= ~ICE_CGU_R23_R24_TSPLL_ENABLE;
+	err = ice_write_cgu_reg(hw, ICE_CGU_R23, val);
+	if (err)
+		return err;
+
+	/* Wait at least 1 ms before reenabling PLL */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+	val |= ICE_CGU_R23_R24_TSPLL_ENABLE;
+	err = ice_write_cgu_reg(hw, ICE_CGU_R23, val);
+
+	return err;
+}
+
 /**
  * ice_tspll_cfg - Configure the Clock Generation Unit TSPLL
  * @hw: Pointer to the HW struct
@@ -577,6 +635,34 @@ static int ice_tspll_dis_sticky_bits(struct ice_hw *hw)
 	}
 }
 
+/**
+ * ice_tspll_get_clk_src - get current TSPLL clock source
+ * @hw: board private hw structure
+ * @clk_src: pointer to store clk_src value
+ *
+ * Get current TSPLL clock source settings.
+ *
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+int ice_tspll_get_clk_src(struct ice_hw *hw, enum ice_clk_src *clk_src)
+{
+	u32 val;
+	int err;
+
+	err = (hw->mac_type == ICE_MAC_GENERIC_3K_E825) ?
+		ice_read_cgu_reg(hw, ICE_CGU_R23, &val) :
+		ice_read_cgu_reg(hw, ICE_CGU_R24, &val);
+	if (err)
+		return err;
+
+	*clk_src = (enum ice_clk_src)FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL,
+					       val);
+
+	return 0;
+}
+
 /**
  * ice_tspll_init - Initialize TSPLL with settings from firmware
  * @hw: Pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index d650867004d1..05917ae51ded 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.h
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
@@ -32,6 +32,9 @@ struct ice_tspll_params_e82x {
 #define ICE_TSPLL_FBDIV_INTGR_E825		256
 
 int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable);
+int ice_tspll_lost_lock_e825c(struct ice_hw *hw, bool *lost_lock);
+int ice_tspll_restart_e825c(struct ice_hw *hw);
+int ice_tspll_get_clk_src(struct ice_hw *hw, enum ice_clk_src *clk_src);
 int ice_tspll_init(struct ice_hw *hw);
 int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
 				      enum ice_synce_clk output);
@@ -39,4 +42,5 @@ int ice_tspll_cfg_bypass_mux_e825c(struct ice_hw *hw, bool ena, u32 port_num,
 				   enum ice_synce_clk output);
 int ice_tspll_cfg_synce_ethdiv_e825c(struct ice_hw *hw,
 				     enum ice_synce_clk output);
+const char *ice_tspll_clk_src_str(enum ice_clk_src clk_src);
 #endif /* _ICE_TSPLL_H_ */
-- 
2.39.3

