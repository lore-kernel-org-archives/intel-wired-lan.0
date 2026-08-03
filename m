Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7207BC55179
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 11:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CBC16075D;
	Mon,  3 Aug 2026 11:41:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjZAgNeU5RLZ; Mon,  3 Aug 2026 11:41:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81A606075F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785757282;
	bh=tl+AASrMwubr4UNbM+MucKB+BQM0+ij+RrtjqnZgOMs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GII7jh1tTfrDnbqUR+MHgalTyRkJVzdMmfNDGD52Pp9JCcBTHSyDPR4DIH1tsv0dU
	 7OsOujjwktBmnm85wZfCcBOfv//5V6WFPcp0KxJnnBEwOfarFXsjFwrc2fSd4ZvCt1
	 NoJ55DD+okMP5RtrfxFnsqeqryahORmmbEQqoiUFfvl/WswfglZhPeXKGGUplXveb9
	 RV3TbME4SjJDC8Jcm5THNLi4KOMVdEVOunbPljSgRvZQKvidxjqv/1l1rwHVZtAOJa
	 PfuwdfNRzY1kzQXT1dU7+73m00wg97gRBIc+LBavWhGOQlf9h4UmhrlyLxXR0YEL/V
	 lfKAfDKEZGzlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81A606075F;
	Mon,  3 Aug 2026 11:41:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EA87350
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 11:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 703E180D9D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 11:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3YuAPwVNkOt for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 11:41:18 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A1FE580DA4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1FE580DA4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1FE580DA4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 11:41:18 +0000 (UTC)
X-CSE-ConnectionGUID: em2/cynWTP6ip0lUeQlx0w==
X-CSE-MsgGUID: shzETI+HQbCJ2440wT6n+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="96878844"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="96878844"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 04:41:17 -0700
X-CSE-ConnectionGUID: FU8qsVn4QBqhsZemPIFx/w==
X-CSE-MsgGUID: XZc6ZUUKQFehuALUptFPFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="257299046"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa010.fm.intel.com with ESMTP; 03 Aug 2026 04:40:14 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  3 Aug 2026 13:35:06 +0200
Message-Id: <20260803113507.1858083-3-grzegorz.nitka@intel.com>
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
 bh=MSgV+SxPrEaSIXXDzO+Boj8AaTIZ82O/nWkt5aNElg0=;
 b=P223oioKwR1PtCzrd3QujaqmFTPihb1YIKthkUxVBstfJLS9QNCp2zF8
 mI6jIjl30ejizQwjdGf98KG6RLu6voGT9tJgdkOtSArUa0DO2LzqtR5Qa
 STQU7IvaMiNDK/g1Nzlgwu1OsHgGkEgAQuDfrQ3SN0PM9qwPF2k6tr6IH
 2Tk7qHN0xoP8Rr7AlUH0fluKVl12YJ9goyG8opBSETaTLK/aP58Vuh6bo
 qxeTjHSDvydcStpJCw9Mu17VVh20gSQ513D+mFq4nJyYdDvMVlXjgkIlW
 Yir0vPoLnTWIds1vsawnWAxrq+qK7AK++ZUqXQ+u6B0X+YjBJQ80wkVfP
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=P223oioK
Subject: [Intel-wired-lan] [PATCH v3 iwl-next 2/3] ice: add TSPLL DPLL
 device and TIME_REF pin for E825
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

This extends the E825 advanced sync-timing support introduced by the
tx-clk series, which added the TXC DPLL device for TX reference clock
control. The TSPLL, the source timer PLL, is now also exposed through
the dpll subsystem so that its lock status and clock source selection
are visible and controllable from userspace.

On E825 devices the TSPLL is the source timer PLL, distinct from the
EEC and PPS DPLLs used on E810. Register it as a DPLL_TYPE_GENERIC
device for owner PFs.

Add struct ice_dplls::tspll_in, a fwnode-backed input pin named
"time_ref". The state_on_dpll_get callback queries ICE_CGU_R23 via
ice_tspll_get_clk_src() and returns CONNECTED when TIME_REF is
selected as clock source, DISCONNECTED otherwise. The state_on_dpll_set
callback switches the source between TIME_REF and TCXO via the new
ice_tspll_set_cfg() helper. Registration is deferred via the dpll
notifier path if the pin is not yet visible in the subsystem at probe
time.

Initialize TSPLL DPLL state from direct clock-source/lock reads so the
first published state reflects hardware and prev_dpll_state matches.
During periodic polling, the DPLL worker consumes
READ_ONCE(pf->ptp.tspll_locked), maintained and recovered by the PTP
periodic worker. When the TSPLL clock source is TCXO (TIME_REF pin not
selected), UNLOCKED is reported unconditionally to reflect the
free-running state of the oscillator regardless of the raw lock bit.
To avoid stale lock-status reads after synchronous source changes, the
set callback now refreshes tspll.dpll_state immediately and emits a DPLL
change notification when the cached state changed.

If a TSPLL reconfiguration is applied but the PLL has not yet
re-acquired lock, treat the internal -EAGAIN result as success so the
PTP periodic worker can complete recovery, while real -EBUSY failures
from reset/SBQ paths still propagate to userspace.

The TSPLL userspace reconfiguration path (state_on_dpll_set) and the
PTP periodic worker (ice_ptp_tspll_monitor) both read TSPLL HW state
and write the pf->ptp.tspll_locked cache consumed by the DPLL worker.
Serialize both with pf->dplls.lock across their HW-read -> cache-write
sequence; otherwise a preempted monitor could overwrite an accurate
cache update from the DPLL callback with stale HW state. The mutex
lifetime is lifted to PF-features scope (initialized in
ice_init_features() before ice_ptp_init(), destroyed in
ice_deinit_features() after ice_ptp_release()) so the PTP monitor
can take it unconditionally regardless of DPLL init state.

Extend ice_dpll_deinit_txclk_pins() with a "flush" parameter so the
E825 init error path for the TSPLL fwnode pin can tear down TXCLK
pins without flushing pf->dplls.wq. If the flush ran here, notifier
work items queued during earlier init steps would be blocked on
pf->dplls.dpll_init, which is only completed at the unregister_pins
label reached after this teardown. destroy_workqueue() at that label
drains the queued items safely. Existing full-teardown callers pass
flush=true and keep current behavior.

Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c  | 420 ++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c  |   9 +
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  12 +
 drivers/net/ethernet/intel/ice/ice_tspll.c |  34 +-
 drivers/net/ethernet/intel/ice/ice_tspll.h |   2 +
 6 files changed, 426 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 1ca137f67dd4..60d24b796c10 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -24,6 +24,8 @@
 
 #define E825_RCLK_PARENT_0_PIN_IDX		0
 #define E825_RCLK_PARENT_1_PIN_IDX		1
+#define E825_DPLL_TSPLL_BASE_IDX		0
+#define E825_DPLL_TXCLK_BASE_IDX		1
 
 #define ICE_DPLL_PIN_SW_INPUT_ABS(in_idx) \
 	(ICE_DPLL_SW_PIN_INPUT_BASE_SFP + (in_idx))
@@ -86,6 +88,7 @@ static const char * const ice_dpll_sw_pin_sma[] = { "SMA1", "SMA2" };
 static const char * const ice_dpll_sw_pin_ufl[] = { "U.FL1", "U.FL2" };
 static const char * const ice_dpll_ext_eref_pin = "EXT_EREF0";
 static const char * const ice_dpll_fwnode_ext_synce = "clk_ref_synce";
+static const char * const ice_dpll_fwnode_time_ref = "time_ref";
 
 static const struct dpll_pin_frequency ice_esync_range[] = {
 	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
@@ -2827,6 +2830,130 @@ static const struct dpll_pin_ops ice_dpll_txclk_ops = {
 	.direction_get = ice_dpll_input_direction,
 };
 
+static enum dpll_lock_status ice_dpll_tspll_lock_status_get(struct ice_pf *pf,
+							    bool use_cached);
+
+/**
+ * ice_dpll_tspll_state_on_dpll_get - get TIME_REF pin state on TSPLL DPLL
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @state: on success holds pin state on parent dpll
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Returns CONNECTED if the TSPLL is using
+ * TIME_REF as its clock source, DISCONNECTED otherwise.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - failed to read clock source
+ */
+static int
+ice_dpll_tspll_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
+				 const struct dpll_device *dpll,
+				 void *dpll_priv,
+				 enum dpll_pin_state *state,
+				 struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	enum ice_clk_src clk_src;
+	int err;
+
+	if (ice_dpll_is_reset(p->pf, extack))
+		return -EBUSY;
+
+	err = ice_tspll_get_clk_src(&p->pf->hw, &clk_src);
+	if (err)
+		return err;
+
+	*state = clk_src == ICE_CLK_SRC_TIME_REF ? DPLL_PIN_STATE_CONNECTED :
+						    DPLL_PIN_STATE_DISCONNECTED;
+	return 0;
+}
+
+/**
+ * ice_dpll_tspll_state_on_dpll_set - set TIME_REF pin state on TSPLL DPLL
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @state: requested state of the pin
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Enables (CONNECTED) or disables (DISCONNECTED)
+ * the TIME_REF signal as the TSPLL clock source. Selects TCXO when disabled.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
+				 const struct dpll_device *dpll,
+				 void *dpll_priv, enum dpll_pin_state state,
+				 struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_pf *pf = p->pf;
+	enum ice_clk_src clk_src;
+	bool changed = false;
+	struct ice_dpll *tp;
+	int ret;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
+	if (state != DPLL_PIN_STATE_CONNECTED &&
+	    state != DPLL_PIN_STATE_DISCONNECTED) {
+		NL_SET_ERR_MSG(extack,
+			       "unsupported pin state for TSPLL reference clock");
+		return -EINVAL;
+	}
+
+	clk_src = (state == DPLL_PIN_STATE_CONNECTED) ? ICE_CLK_SRC_TIME_REF :
+							ICE_CLK_SRC_TCXO;
+	tp = &pf->dplls.tspll;
+	/* Serialize multi-register TSPLL reconfiguration with restart path. */
+	mutex_lock(&pf->dplls.lock);
+	ret = ice_tspll_set_cfg(&pf->hw, ICE_TSPLL_FREQ_156_250, clk_src);
+	if (!ret || ret == -EAGAIN) {
+		enum dpll_lock_status new_state;
+
+		new_state = ice_dpll_tspll_lock_status_get(pf, false);
+
+		/* Sync the cached lock state to what we just observed from HW
+		 * so ice_dpll_periodic_work_e825() (cached path) does not emit
+		 * a spurious UNLOCKED notification between now and the next
+		 * PTP monitor tick.
+		 */
+		WRITE_ONCE(pf->ptp.tspll_locked,
+			   new_state == DPLL_LOCK_STATUS_LOCKED);
+
+		if (tp->prev_dpll_state != new_state) {
+			tp->dpll_state = new_state;
+			tp->prev_dpll_state = new_state;
+			changed = true;
+		}
+	}
+	mutex_unlock(&pf->dplls.lock);
+	if (changed)
+		__dpll_device_change_ntf(tp->dpll);
+	/* TSPLL reconfiguration may complete before lock is reacquired.
+	 * PTP periodic monitoring tracks and restores the final lock state.
+	 */
+	if (ret == -EAGAIN)
+		ret = 0;
+
+	return ret;
+}
+
+static const struct dpll_pin_ops ice_dpll_tspll_in_ops = {
+	.state_on_dpll_set = ice_dpll_tspll_state_on_dpll_set,
+	.state_on_dpll_get = ice_dpll_tspll_state_on_dpll_get,
+	.direction_get = ice_dpll_input_direction,
+};
+
 static const struct dpll_pin_ops ice_dpll_pin_sma_ops = {
 	.state_on_dpll_set = ice_dpll_sma_pin_state_set,
 	.state_on_dpll_get = ice_dpll_sw_pin_state_get,
@@ -2928,6 +3055,37 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
 	return pci_get_dsn(pf->pdev);
 }
 
+/**
+ * ice_dpll_tspll_lock_status_get - derive TSPLL state for dpll subsystem
+ * @pf: board private structure
+ * @use_cached: if true, read lock state from pf->ptp.tspll_locked (maintained
+ *              by the PTP periodic worker); if false, query hardware directly
+ *
+ * If TIME_REF is not selected, TSPLL is treated as unlocked from the dpll
+ * subsystem perspective, regardless of raw lock bit.
+ */
+static enum dpll_lock_status
+ice_dpll_tspll_lock_status_get(struct ice_pf *pf, bool use_cached)
+{
+	enum ice_clk_src clk_src;
+	bool locked;
+
+	if (ice_tspll_get_clk_src(&pf->hw, &clk_src) ||
+	    clk_src != ICE_CLK_SRC_TIME_REF)
+		return DPLL_LOCK_STATUS_UNLOCKED;
+
+	if (use_cached) {
+		locked = READ_ONCE(pf->ptp.tspll_locked);
+	} else {
+		bool lock_lost;
+
+		if (ice_tspll_lost_lock_e825c(&pf->hw, &lock_lost))
+			return DPLL_LOCK_STATUS_UNLOCKED;
+		locked = !lock_lost;
+	}
+	return locked ? DPLL_LOCK_STATUS_LOCKED : DPLL_LOCK_STATUS_UNLOCKED;
+}
+
 /**
  * ice_dpll_pin_ntf - notify pin change including any SW pin wrappers
  * @dplls: pointer to dplls struct
@@ -3160,12 +3318,44 @@ ice_dpll_update_state(struct ice_pf *pf, struct ice_dpll *d, bool init)
 	return ret;
 }
 
+/**
+ * ice_dpll_periodic_work_e825 - TSPLL DPLL periodic update for E825
+ * @pf: board private structure
+ *
+ * Publish TSPLL lock status to the dpll subsystem. The PTP periodic worker
+ * owns TSPLL lock polling and recovery; this function consumes the cached
+ * result for dpll notifications.
+ *
+ * Context: Must be called without pf->dplls.lock held.
+ */
+static void ice_dpll_periodic_work_e825(struct ice_pf *pf)
+{
+	struct ice_dpll *tp = &pf->dplls.tspll;
+	enum dpll_lock_status new_state;
+	bool changed = false;
+
+	mutex_lock(&pf->dplls.lock);
+	new_state = ice_dpll_tspll_lock_status_get(pf, true);
+
+	if (tp->prev_dpll_state != new_state) {
+		tp->dpll_state = new_state;
+		tp->prev_dpll_state = new_state;
+		changed = true;
+	}
+	mutex_unlock(&pf->dplls.lock);
+	if (changed)
+		dpll_device_change_ntf(tp->dpll);
+}
+
 /**
  * ice_dpll_periodic_work - DPLLs periodic worker
  * @work: pointer to kthread_work structure
  *
- * DPLLs periodic worker is responsible for polling state of dpll.
- * Context: Holds pf->dplls.lock
+ * Periodic worker responsible for polling DPLL state. On E810 devices it
+ * polls the EEC and PPS DPLLs. On E825 devices, when this PF owns the
+ * source timer, it publishes TSPLL lock status to the dpll subsystem.
+ *
+ * Context: Acquires and releases pf->dplls.lock
  */
 static void ice_dpll_periodic_work(struct kthread_work *work)
 {
@@ -3173,38 +3363,43 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	struct ice_pf *pf = container_of(d, struct ice_pf, dplls);
 	struct ice_dpll *de = &pf->dplls.eec;
 	struct ice_dpll *dp = &pf->dplls.pps;
-	u32 phase_offset_ntf = 0;
+	u32 ntf_mask = 0;
 	int ret = 0;
 
 	if (ice_is_reset_in_progress(pf->state))
 		goto resched;
-	mutex_lock(&pf->dplls.lock);
-	d->periodic_counter++;
-	ret = ice_dpll_update_state(pf, de, false);
-	if (!ret)
-		ret = ice_dpll_update_state(pf, dp, false);
-	if (!ret && dp->phase_offset_monitor_period &&
-	    d->periodic_counter % dp->phase_offset_monitor_period == 0)
-		ret = ice_dpll_pps_update_phase_offsets(pf, &phase_offset_ntf);
-	if (ret) {
-		/* EBUSY is expected during reset recovery */
-		if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
-			d->cgu_state_acq_err_num++;
-		/* stop rescheduling this worker */
-		if (d->cgu_state_acq_err_num >
-		    ICE_CGU_STATE_ACQ_ERR_THRESHOLD) {
-			dev_err(ice_pf_to_dev(pf),
-				"EEC/PPS DPLLs periodic work disabled\n");
-			mutex_unlock(&pf->dplls.lock);
-			return;
+
+	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
+		ice_dpll_periodic_work_e825(pf);
+	} else {
+		mutex_lock(&pf->dplls.lock);
+		d->periodic_counter++;
+		ret = ice_dpll_update_state(pf, de, false);
+		if (!ret)
+			ret = ice_dpll_update_state(pf, dp, false);
+		if (!ret && dp->phase_offset_monitor_period &&
+		    d->periodic_counter % dp->phase_offset_monitor_period == 0)
+			ret = ice_dpll_pps_update_phase_offsets(pf, &ntf_mask);
+		if (ret) {
+			/* EBUSY is expected during reset recovery */
+			if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
+				d->cgu_state_acq_err_num++;
+			/* stop rescheduling this worker */
+			if (d->cgu_state_acq_err_num >
+			    ICE_CGU_STATE_ACQ_ERR_THRESHOLD) {
+				dev_err(ice_pf_to_dev(pf),
+					"EEC/PPS DPLLs periodic work disabled\n");
+				mutex_unlock(&pf->dplls.lock);
+				return;
+			}
 		}
+		mutex_unlock(&pf->dplls.lock);
+		ice_dpll_notify_changes(de);
+		ice_dpll_notify_changes(dp);
+		if (ntf_mask)
+			ice_dpll_pins_notify_mask(d, d->inputs, d->num_inputs,
+						  ntf_mask);
 	}
-	mutex_unlock(&pf->dplls.lock);
-	ice_dpll_notify_changes(de);
-	ice_dpll_notify_changes(dp);
-	if (phase_offset_ntf)
-		ice_dpll_pins_notify_mask(d, d->inputs, d->num_inputs,
-					  phase_offset_ntf);
 
 resched:
 	/* Run twice a second or reschedule if update failed */
@@ -3568,6 +3763,7 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 						   work);
 	struct ice_dpll_pin *pin, *parent = w->pin;
 	bool is_tx_synce_parent = false;
+	bool is_tspll_time_ref = false;
 	struct ice_pf *pf = parent->pf;
 	bool is_rclk_parent = false;
 	int ret;
@@ -3588,7 +3784,11 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 	is_tx_synce_parent =
 		ice_dpll_fwnode_eq(parent->fwnode,
 				   pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX].fwnode);
-	if (!is_rclk_parent && !is_tx_synce_parent)
+
+	is_tspll_time_ref =
+		ice_dpll_fwnode_eq(parent->fwnode, pf->dplls.tspll_in.fwnode);
+
+	if (!is_rclk_parent && !is_tx_synce_parent && !is_tspll_time_ref)
 		goto out;
 
 	switch (w->action) {
@@ -3629,6 +3829,18 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 					ERR_PTR(ret));
 				goto drop_parent_ref;
 			}
+		} else if (is_tspll_time_ref) {
+			/* Register TIME_REF pin directly to TSPLL DPLL */
+			ret = dpll_pin_register(pf->dplls.tspll.dpll,
+						parent->pin,
+						&ice_dpll_tspll_in_ops,
+						parent);
+			if (ret) {
+				dev_err(ice_pf_to_dev(pf),
+					"TSPLL TIME_REF pin register failed: %pe\n",
+					ERR_PTR(ret));
+				goto drop_parent_ref;
+			}
 		}
 		break;
 	case DPLL_PIN_DELETED:
@@ -3647,6 +3859,11 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 			pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
 			dpll_pin_unregister(pf->dplls.txc.dpll, pin->pin,
 					    &ice_dpll_txclk_ops, pin);
+		} else if (is_tspll_time_ref) {
+			/* Unregister TIME_REF pin from TSPLL DPLL */
+			dpll_pin_unregister(pf->dplls.tspll.dpll,
+					    parent->pin,
+					    &ice_dpll_tspll_in_ops, parent);
 		}
 drop_parent_ref:
 		/* Drop fwnode pin reference */
@@ -3818,12 +4035,12 @@ ice_dpll_deinit_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 	destroy_workqueue(pf->dplls.wq);
 }
 
-static int ice_dpll_deinit_txclk_pins(struct ice_pf *pf)
+static int ice_dpll_deinit_txclk_pins(struct ice_pf *pf, bool flush)
 {
 	struct ice_dpll_pin *synce_pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
 	struct ice_dpll *dt = &pf->dplls.txc;
 
-	ice_dpll_stop_fwnode_pin_activity(synce_pin, true);
+	ice_dpll_stop_fwnode_pin_activity(synce_pin, flush);
 	ice_dpll_unregister_pins(dt->dpll, pf->dplls.txclks,
 				 &ice_dpll_txclk_ops,
 				 ARRAY_SIZE(pf->dplls.txclks));
@@ -3838,6 +4055,25 @@ static int ice_dpll_deinit_txclk_pins(struct ice_pf *pf)
 	return 0;
 }
 
+/**
+ * ice_dpll_deinit_tspll_pins - deinitialize TSPLL fwnode pin
+ * @pf: board private structure
+ *
+ * Stop notifier activity and release the TIME_REF fwnode pin, unregistering
+ * it from the TSPLL DPLL if it was registered.
+ */
+static void ice_dpll_deinit_tspll_pins(struct ice_pf *pf)
+{
+	struct ice_dpll_pin *time_ref = &pf->dplls.tspll_in;
+	struct ice_dpll *tp = &pf->dplls.tspll;
+
+	ice_dpll_stop_fwnode_pin_activity(time_ref, true);
+	if (!IS_ERR_OR_NULL(time_ref->pin))
+		dpll_pin_unregister(tp->dpll, time_ref->pin,
+				    &ice_dpll_tspll_in_ops, time_ref);
+	ice_dpll_release_fwnode_pin(time_ref);
+}
+
 /**
  * ice_dpll_deinit_pins - deinitialize direct pins
  * @pf: board private structure
@@ -3870,7 +4106,10 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 
 	ice_dpll_deinit_rclk_pin(pf);
 	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
-		ice_dpll_deinit_txclk_pins(pf);
+		if (ice_pf_src_tmr_owned(pf) &&
+		    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
+			ice_dpll_deinit_tspll_pins(pf);
+		ice_dpll_deinit_txclk_pins(pf, true);
 		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
 	}
 	if (cgu) {
@@ -4066,6 +4305,45 @@ static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
 	return ret;
 }
 
+/**
+ * ice_dpll_init_tspll_pins - init and register TSPLL TIME_REF fwnode pin
+ * @pf: board private structure
+ *
+ * Initialize the fwnode-based TIME_REF input pin for the TSPLL DPLL on E825.
+ * If the pin is not yet available in the dpll subsystem, registration will
+ * be deferred via the notifier path.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - initialization failure reason
+ */
+static int ice_dpll_init_tspll_pins(struct ice_pf *pf)
+{
+	struct ice_dpll_pin *time_ref = &pf->dplls.tspll_in;
+	struct ice_dpll *tp = &pf->dplls.tspll;
+	int ret;
+
+	time_ref->pf = pf;
+	ret = ice_dpll_init_fwnode_pin(time_ref, ice_dpll_fwnode_time_ref);
+	if (ret)
+		return ret;
+
+	if (IS_ERR_OR_NULL(time_ref->pin)) {
+		dev_dbg(ice_pf_to_dev(pf),
+			"TSPLL TIME_REF pin not registered yet\n");
+		return 0;
+	}
+
+	ret = dpll_pin_register(tp->dpll, time_ref->pin,
+				&ice_dpll_tspll_in_ops, time_ref);
+	if (ret) {
+		ice_dpll_stop_fwnode_pin_activity(time_ref, false);
+		ice_dpll_release_fwnode_pin(time_ref);
+	}
+
+	return ret;
+}
+
 /**
  * ice_dpll_init_pins_e825 - init pins and register pins with a dplls
  * @pf: board private structure
@@ -4093,8 +4371,25 @@ static int ice_dpll_init_pins_e825(struct ice_pf *pf)
 		goto unregister_pins;
 
 	ret = ice_dpll_init_txclk_pins(pf, 0);
-	if (ret)
+	if (ret) {
 		ice_dpll_deinit_rclk_pin(pf);
+		goto unregister_pins;
+	}
+
+	if (ice_pf_src_tmr_owned(pf) &&
+	    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
+		ret = ice_dpll_init_tspll_pins(pf);
+		if (ret) {
+			/*
+			 * Avoid flushing pf->dplls.wq here: notifier work
+			 * items block on pf->dplls.dpll_init which is
+			 * completed by the unregister_pins path below.
+			 * destroy_workqueue() there drains queued items.
+			 */
+			ice_dpll_deinit_txclk_pins(pf, false);
+			ice_dpll_deinit_rclk_pin(pf);
+		}
+	}
 
 unregister_pins:
 	if (ret) {
@@ -4288,6 +4583,7 @@ static void ice_dpll_deinit_worker(struct ice_pf *pf)
 
 	kthread_cancel_delayed_work_sync(&d->work);
 	kthread_destroy_worker(d->kworker);
+	d->kworker = NULL;
 }
 
 /**
@@ -4777,6 +5073,7 @@ static void ice_dpll_deinit_info(struct ice_pf *pf)
 static int ice_dpll_init_info_e825c(struct ice_pf *pf)
 {
 	struct ice_dplls *d = &pf->dplls;
+	struct ice_dpll *tp = &d->tspll;
 	struct ice_dpll *dt = &d->txc;
 	int ret = 0;
 	int i;
@@ -4785,7 +5082,11 @@ static int ice_dpll_init_info_e825c(struct ice_pf *pf)
 	d->num_inputs = ICE_SYNCE_CLK_NUM;
 	dt->dpll_state = ice_txclk_lock_status(pf->ptp.port.tx_clk);
 	dt->mode = DPLL_MODE_MANUAL;
-	dt->dpll_idx = pf->ptp.port.port_num;
+	dt->dpll_idx = E825_DPLL_TXCLK_BASE_IDX + pf->ptp.port.port_num;
+	tp->dpll_state = ice_dpll_tspll_lock_status_get(pf, false);
+	tp->prev_dpll_state = tp->dpll_state;
+	tp->mode = DPLL_MODE_MANUAL;
+	tp->dpll_idx = E825_DPLL_TSPLL_BASE_IDX;
 
 	d->inputs = kzalloc_objs(*d->inputs, d->num_inputs);
 	if (!d->inputs)
@@ -5040,7 +5341,8 @@ void ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
  * resources and unregistering the dpll, pin and all resources used for
  * handling them.
  *
- * Context: Destroys pf->dplls.lock mutex. Call only if ICE_FLAG_DPLL was set.
+ * Context: Call only if ICE_FLAG_DPLL was set. pf->dplls.lock lifetime is
+ * managed by ice_init_features()/ice_deinit_features().
  */
 void ice_dpll_deinit(struct ice_pf *pf)
 {
@@ -5064,7 +5366,7 @@ void ice_dpll_deinit(struct ice_pf *pf)
 		up_write(&pf->dplls.txclk_notify_rwsem);
 	}
 
-	if (cgu)
+	if (pf->dplls.kworker)
 		ice_dpll_deinit_worker(pf);
 
 	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
@@ -5078,9 +5380,10 @@ void ice_dpll_deinit(struct ice_pf *pf)
 		ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
 	if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll))
 		ice_dpll_deinit_dpll(pf, &pf->dplls.txc, false);
+	if (!IS_ERR_OR_NULL(pf->dplls.tspll.dpll))
+		ice_dpll_deinit_dpll(pf, &pf->dplls.tspll, false);
 
 	ice_dpll_deinit_info(pf);
-	mutex_destroy(&pf->dplls.lock);
 }
 
 /**
@@ -5089,17 +5392,13 @@ void ice_dpll_deinit(struct ice_pf *pf)
  *
  * Set up the device dplls for unmanaged mode, register them and pins connected
  * within Linux dpll subsystem. Allow userspace to obtain state of DPLL.
- *
- * Context: Initializes pf->dplls.lock mutex.
  */
 static void ice_dpll_init_unmanaged(struct ice_pf *pf)
 {
-	struct ice_dplls *d = &pf->dplls;
 	int err;
 
 	if (!ice_pf_src_tmr_owned(pf))
 		return;
-	mutex_init(&d->lock);
 	err = ice_dpll_init_info_unmanaged(pf);
 	if (err)
 		goto err_exit;
@@ -5118,7 +5417,6 @@ static void ice_dpll_init_unmanaged(struct ice_pf *pf)
 deinit_info:
 	ice_dpll_deinit_info(pf);
 err_exit:
-	mutex_destroy(&d->lock);
 	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
 }
 
@@ -5129,8 +5427,6 @@ static void ice_dpll_init_unmanaged(struct ice_pf *pf)
  * Set up the device dplls, register them and pins connected within Linux dpll
  * subsystem. Allow userspace to obtain state of DPLL and handling of DPLL
  * configuration requests.
- *
- * Context: Initializes pf->dplls.lock mutex.
  */
 static void ice_dpll_init_e825(struct ice_pf *pf)
 {
@@ -5148,7 +5444,6 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
 			pf->ptp.port.port_num = pf->hw.lane_num;
 	}
 
-	mutex_init(&d->lock);
 	/* Initialize the txclk worker and its notification rwsem before any
 	 * code path can fail: ice_dpll_deinit() runs unconditionally on
 	 * failure and calls cancel_work_sync() / down_write() on these.
@@ -5160,9 +5455,30 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
 	err = ice_dpll_init_info_e825c(pf);
 	if (err)
 		goto err_exit;
+	if (ice_pf_src_tmr_owned(pf) &&
+	    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
+		err = ice_dpll_init_dpll(pf, &pf->dplls.tspll, false,
+					 DPLL_TYPE_GENERIC);
+		if (err)
+			goto deinit_info;
+		/* Start the periodic worker before registering fwnode pins. The
+		 * fwnode notifier path (ice_dpll_pin_notify_work()) blocks on
+		 * pf->dplls.dpll_init, which is only signalled on the success
+		 * return below. Starting the worker before any fwnode notifier
+		 * is registered means a subsequent init failure cannot leave
+		 * notifier work items queued on pf->dplls.wq, so the deinit
+		 * flush_workqueue() paths in ice_dpll_deinit_pins() cannot
+		 * deadlock. The E825 periodic worker only touches
+		 * pf->dplls.tspll (already registered above) and pf->ptp state,
+		 * so it is safe to run before pins.
+		 */
+		err = ice_dpll_init_worker(pf);
+		if (err)
+			goto deinit_tspll;
+	}
 	err = ice_dpll_init_dpll(pf, &pf->dplls.txc, false, DPLL_TYPE_GENERIC);
 	if (err)
-		goto deinit_info;
+		goto deinit_worker;
 	err = ice_dpll_init_pins_e825(pf);
 	if (err)
 		goto deinit_txclk;
@@ -5173,10 +5489,15 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
 
 deinit_txclk:
 	ice_dpll_deinit_dpll(pf, &pf->dplls.txc, false);
+deinit_worker:
+	if (pf->dplls.kworker)
+		ice_dpll_deinit_worker(pf);
+deinit_tspll:
+	if (!IS_ERR_OR_NULL(pf->dplls.tspll.dpll))
+		ice_dpll_deinit_dpll(pf, &pf->dplls.tspll, false);
 deinit_info:
 	ice_dpll_deinit_info(pf);
 err_exit:
-	mutex_destroy(&d->lock);
 	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
 }
 
@@ -5187,16 +5508,12 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
  * Set up the device dplls, register them and pins connected within Linux dpll
  * subsystem. Allow userspace to obtain state of DPLL and handling of DPLL
  * configuration requests.
- *
- * Context: Initializes pf->dplls.lock mutex.
  */
 static void ice_dpll_init_e810(struct ice_pf *pf)
 {
 	bool cgu = ice_is_feature_supported(pf, ICE_F_CGU);
-	struct ice_dplls *d = &pf->dplls;
 	int err = 0;
 
-	mutex_init(&d->lock);
 	err = ice_dpll_init_info(pf, cgu);
 	if (err)
 		goto err_exit;
@@ -5227,7 +5544,6 @@ static void ice_dpll_init_e810(struct ice_pf *pf)
 deinit_info:
 	ice_dpll_deinit_info(pf);
 err_exit:
-	mutex_destroy(&d->lock);
 	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index c59d746a8567..6bdb821bfb3a 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -135,10 +135,12 @@ struct ice_dpll {
  * @eec: pointer to EEC dpll dev
  * @pps: pointer to PPS dpll dev
  * @txc: pointer to TXC dpll dev
+ * @tspll: pointer to TSPLL dpll dev (E825 only)
  * @inputs: input pins pointer
  * @outputs: output pins pointer
  * @rclk: recovered pins pointer
  * @txclks: TX clock reference pins pointer
+ * @tspll_in: TSPLL TIME_REF fwnode input pin (E825 only)
  * @num_inputs: number of input pins available on dpll
  * @num_outputs: number of output pins available on dpll
  * @cgu_state_acq_err_num: number of errors returned during periodic work
@@ -179,12 +181,14 @@ struct ice_dplls {
 	struct ice_dpll eec;
 	struct ice_dpll pps;
 	struct ice_dpll txc;
+	struct ice_dpll tspll;
 	struct ice_dpll_pin *inputs;
 	struct ice_dpll_pin *outputs;
 	struct ice_dpll_pin sma[ICE_DPLL_PIN_SW_NUM];
 	struct ice_dpll_pin ufl[ICE_DPLL_PIN_SW_NUM];
 	struct ice_dpll_pin rclk;
 	struct ice_dpll_pin txclks[ICE_DPLL_TXCLK_NUM_MAX];
+	struct ice_dpll_pin tspll_in;
 	u8 num_inputs;
 	u8 num_outputs;
 	u8 sma_data;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 968a8e18d197..ab83b64b2270 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4920,6 +4920,14 @@ static void ice_init_features(struct ice_pf *pf)
 	if (ice_is_safe_mode(pf))
 		return;
 
+	/* pf->dplls.lock guards TSPLL/CGU access shared between the DPLL
+	 * subsystem callbacks and the PTP periodic worker's TSPLL monitor.
+	 * Initialize it before ice_ptp_init() so the PTP kworker never sees
+	 * an uninitialized mutex, and destroy it in ice_deinit_features()
+	 * only after ice_ptp_release() has drained the kworker.
+	 */
+	mutex_init(&pf->dplls.lock);
+
 	/* initialize DDP driven features */
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
 		ice_ptp_init(pf);
@@ -4976,6 +4984,7 @@ static void ice_deinit_features(struct ice_pf *pf)
 		ice_ptp_release(pf);
 	if (test_bit(ICE_FLAG_DPLL, pf->flags))
 		ice_dpll_deinit(pf);
+	mutex_destroy(&pf->dplls.lock);
 	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV)
 		xa_destroy(&pf->eswitch.reprs);
 	ice_hwmon_exit(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a997be5f7d8f..39538068a11e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2904,8 +2904,19 @@ static void ice_ptp_tspll_monitor(struct ice_pf *pf)
 	    !ice_pf_src_tmr_owned(pf))
 		return;
 
+	/* Serialize the entire monitor tick against TSPLL userspace reconfig
+	 * (ice_dpll_tspll_state_on_dpll_set()). Both paths read HW state and
+	 * write pf->ptp.tspll_locked; without holding pf->dplls.lock across
+	 * the HW read here, a preempted monitor could observe stale HW state
+	 * and then overwrite an accurate cache update from the DPLL callback.
+	 * pf->dplls.lock is initialized in ice_init_features() before the PTP
+	 * kworker starts and destroyed in ice_deinit_features() only after
+	 * ice_ptp_release() has drained the kworker, so it is always valid.
+	 */
+	mutex_lock(&pf->dplls.lock);
 	err = ice_tspll_lost_lock_e825c(&pf->hw, &lock_lost);
 	if (err) {
+		mutex_unlock(&pf->dplls.lock);
 		dev_err_ratelimited(ice_pf_to_dev(pf),
 				    "Failed reading TimeSync PLL lock status (err: %d). Retrying.\n",
 				    err);
@@ -2937,6 +2948,7 @@ static void ice_ptp_tspll_monitor(struct ice_pf *pf)
 		WRITE_ONCE(pf->ptp.tspll_locked, true);
 		pf->ptp.tspll_lock_retries = 0;
 	}
+	mutex_unlock(&pf->dplls.lock);
 }
 
 static void ice_ptp_periodic_work(struct kthread_work *work)
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index be8e2da21dd6..378eefe0f9af 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -334,8 +334,9 @@ static int ice_tspll_dis_sticky_bits_e82x(struct ice_hw *hw)
  * Return:
  * * %0       - success
  * * %-EINVAL - input parameters are incorrect
- * * %-EBUSY  - failed to lock TSPLL
- * * %other   - CGU read/write failure
+ * * %-EAGAIN - TSPLL configuration succeeded but lock is not acquired yet
+ * * %-EBUSY  - CGU access is busy (for example during reset)
+ * * %other   - other CGU read/write failures
  */
 static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			       enum ice_clk_src clk_src)
@@ -467,7 +468,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 
 	if (!(val & ICE_CGU_RO_LOCK_TRUE_LOCK)) {
 		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
-		return -EBUSY;
+		return -EAGAIN;
 	}
 
 	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &r9);
@@ -663,6 +664,33 @@ int ice_tspll_get_clk_src(struct ice_hw *hw, enum ice_clk_src *clk_src)
 	return 0;
 }
 
+/**
+ * ice_tspll_set_cfg - configure TS PLL with new settings
+ * @hw: board private hw structure
+ * @clk_freq: clock frequency to program
+ * @clk_src: clock source to select (TIME_REF, or TCXO)
+ *
+ * Configure CGU with new clock source and clock frequency settings.
+ *
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+int ice_tspll_set_cfg(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
+		      enum ice_clk_src clk_src)
+{
+	int ret;
+
+	if (!ice_tspll_check_params(hw, clk_freq, clk_src))
+		return -EINVAL;
+
+	ret = ice_tspll_dis_sticky_bits(hw);
+	if (ret)
+		return ret;
+
+	return ice_tspll_cfg(hw, clk_freq, clk_src);
+}
+
 /**
  * ice_tspll_init - Initialize TSPLL with settings from firmware
  * @hw: Pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index 05917ae51ded..832c049e686c 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.h
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
@@ -35,6 +35,8 @@ int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable);
 int ice_tspll_lost_lock_e825c(struct ice_hw *hw, bool *lost_lock);
 int ice_tspll_restart_e825c(struct ice_hw *hw);
 int ice_tspll_get_clk_src(struct ice_hw *hw, enum ice_clk_src *clk_src);
+int ice_tspll_set_cfg(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
+		      enum ice_clk_src clk_src);
 int ice_tspll_init(struct ice_hw *hw);
 int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
 				      enum ice_synce_clk output);
-- 
2.39.3

