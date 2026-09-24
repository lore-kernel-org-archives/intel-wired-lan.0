Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12847C9830E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C10F681CE7;
	Thu, 24 Sep 2026 12:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nC6NX6pdpTML; Thu, 24 Sep 2026 12:59:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A70D481BBD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254777;
	b=bK3ftIT0f7Mn2ZdByi81dmk99/AoScAmaHFOoBr3xQdaEmrcv8810v44OMCW5/WuiVh3
	 bhUkGrmFnJGB+Vh/WtmWKFL1SieP1K1zHSAiTec8UMZAzO/a8WwbwLCTVb04/NQtyHMwC
	 7wSCnql3HdlHUrpCzvf6tW3zi3DKovg0N9fwWFrr9EkZqQSgcbqh8q61OavwIyuLqhPvN
	 Uqv76rDWB1Bkh2rKEC2Vvoki9RTMgGi7uutCmGaPsF8RpPZZPV8DOeqc5A4I78gSnsJs8
	 lUCXG3MXa1jBikEnCL9c/GhIk2WdLdMq7O3lQv3g6E5J+ZAAaPiW2OpfzZe63n94+Pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pQMFFCya3wmc2ap38hLSqFx15I+RY820Z4UXZaDfLT4=;
	b=ecrTiLhbeOW2dG7RkPrt0pmqTH3PglH4TPdZiSPeYFUnO07IE5h9XQwzSGCwOGuUN70u
	 jZpJcSa6KmilmEbsWdh6+7g259o9b7WW8LppqeqOvmYbCJrpqZVlQq4i5XfpceTGr4cCn
	 EzNbDWWtu8FiEjfEzgvRObOG38yTwPn73crbF+XXAEL7wAPEIqnEldW1Uo0x65S5MZ7tV
	 XuluGE/acTxIxZZ38BO7R5OX58BsLCGFWu+nzFFyUTXW+Ra7ESP/Z7ZSC2fFOl+KtfzXM
	 493Sdg7OrqfC8nurUJWRuGFB7Fr41dQUlDPQ2fAWZsj9S80Xh2XFgCS6/5zjHSvISQA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790254777;
	bh=pQMFFCya3wmc2ap38hLSqFx15I+RY820Z4UXZaDfLT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RpBU1aJ3CahXXzCzCCppG/OihyNNNT6Cn75MIvYxihjoonUdQ4Q8rY2esamTy+yGM
	 SJKJVkCXBgOFf+164jviQNB4FTNfr5/cGAZesc4NH4gO6AycTIb/5AizPFPPEnkmUh
	 2r/5/g5qjVbyMBrL+FwluWyEkFPNwCAhOspeS914JGUauOxfevrHeZitdRM+m+KrjU
	 RCeu/4Ge8T6ayEtU8B39tMpRgIPlgbFB8Ka/MkGdQWHuo57ha/ZWDijCnDSMZfLS/e
	 70uv6dEZ7H9ou4peqfpVo5m3RtYQFwI7KjEj7N6pSFJ4VcM58X7aF6fR48gt/Rr8/C
	 vZZE3jOwKCPdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A70D481BBD;
	Thu, 24 Sep 2026 12:59:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0F581344
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE99D60838
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-8_BRUIKI56 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CC2D160807
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254772;
 b=ijxVQy/5uZMnnSLV1gUQUiHlgSRK9nNavx8PSog0V+sMPU/x2wZV4c8Uiz5j6WLxnsWi
 M+iwd2NYx0V8hPoXvfhqF0mAgUnC9WqEn0s9CgBNQTeSxe5vT6YIDnPMaYj5SUwpekJoO
 qVMpYhS4DrnassOqMSovltQIhsOyAe0fO2XOBVqkJfQHB7UOKrZokSeTzi4r/BfxzMHYk
 LkZPiCCdZAyqgzVfQNR4sAYr7PNjM1yiZ28qrvEH0cWAr2T3StJR4aG2pKQWcfL22SUL7
 RH1r9BLsEyDV92zRkbzGF4WkrZKBihSXbiKrbH/mBimI8Dd7Jo3MdLhfo9q+AWtpAjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254772;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=pQMFFCya3wmc2ap38hLSqFx15I+RY820Z4UXZaDfLT4=;
 b=GFBj2rBv0TjPGZQbbJI5oPVP36XhVleYhryMzH58oAfGeuK6XC9odMrIIrH1z8YPvTba
 QkgTt4o1P2eFnvmeUByWhbli/L8/5mU9WDey3/dakEKrTM7JfByc6d3qaT80x4MregGaY
 O6atBTokz+A2e9fI8AuBPmu02jPiXDCPIU6IewaocjAShMSJBv88WHt2yVhgMYx7qtAuS
 LxZM1bzChO4Zwh+xyJiu+iEGKHgSeC86QPD03psEX0M1lPZcEU3KQWspuTUbpqGrq/ckn
 2x23SdHsp4eNzKA9sO6VhoW9Kw6EK1ytOfVZdxp8RNEXCpKgJAAR+Nng9Mnh98ZFuOA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jyXTeKNr; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jyXTeKNr
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC2D160807
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790254772; x=1821790772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TFXPy66pLteuugCAv0UVm4p+uz1rFLrm6jJ5MqbLUyM=;
 b=jyXTeKNrG/ilSr5ZMeECEB52lNiop8pXL4Zl5gMrc29K9tw9CsvIL4Pm
 sL0++ibAHfXqV9dXDAASameMwpSyLBDmmHpXypj4Z3kyVgnp0fn8Q9vo2
 eisAeBaeQ4pPjAfOU6ndmnfxI/xjzkNWcpi/CdT0oeMxvVi+ccib93fp+
 kp0il3Ehv7BIvqf5Yys/oXmO/HJvvw+GjyO7KEpF7rxnpSsoit/unyQ97
 nMkoS9jrHf+k8rsPSvvMC1CiSyPX2KxRoWV3WjxBPUr+vJ6LWWTAM6Bus
 UYetiCHU/tASVkhX4tx2VvDfaUcHCTgg94YP/Gm9dQ1DYwcrg2o4J6eY0 g==;
X-CSE-ConnectionGUID: 0ZkwflVOQM2ClO4G7fgzuQ==
X-CSE-MsgGUID: m6dlf6NvSR2YPcb5LEg8PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249228"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90249228"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:59:22 -0700
X-CSE-ConnectionGUID: oxql0OkUTdKTW7bEU7miAw==
X-CSE-MsgGUID: cla2MIzJT8GAta8CtV+IvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311934427"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:21 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 4/8] ice: Reject PTP access without a control PF
Date: Thu, 24 Sep 2026 12:59:12 +0000
Message-ID: <20260924125916.2796499-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
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

The timesync register space is not accessible through a secondary NAC.
ice_get_primary_hw() currently falls back to the caller's hardware when
the control PF is absent, causing secondary PFs to access the wrong
register space after the control PF is removed.

Return NULL instead and propagate the missing control PF through PHC
reads and timer setup paths. This leaves secondary PFs operational while
PTP requests fail safely until a control PF is available again.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  9 +--
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 71 ++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h      | 11 +--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 23 +++++-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  5 +-
 5 files changed, 85 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 08b40626b876..c454f19a2cb2 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1146,8 +1146,8 @@ static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
  * while holding adapter->ctrl_pf_lock.
  * hw is embedded in struct ice_pf, so either mechanism protects its lifetime.
  *
- * Return: A pointer to ice_hw structure with access to timesync
- * register space.
+ * Return: A pointer to ice_hw structure with access to timesync register
+ * space, or NULL if the control PF is not available.
  */
 static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 {
@@ -1156,10 +1156,7 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 	ctrl_pf = rcu_dereference_check(pf->adapter->ctrl_pf,
 					lockdep_is_held(&pf->adapter->ctrl_pf_lock));
 
-	if (!ctrl_pf)
-		return &pf->hw;
-	else
-		return &ctrl_pf->hw;
+	return ctrl_pf ? &ctrl_pf->hw : NULL;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 455e3af30abe..3ee29c0cd726 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -214,17 +214,23 @@ void ice_ptp_restore_timestamp_mode(struct ice_pf *pf)
  * @pf: Board private structure
  * @sts: Optional parameter for holding a pair of system timestamps from
  *       the system clock. Will be ignored if NULL is given.
+ * @time: Storage for the source clock time
+ *
+ * Return: 0 on success, negative error code otherwise.
  */
-u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
-			     struct ptp_system_timestamp *sts)
+int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts, u64 *time)
 {
 	struct ice_hw *hw = &pf->hw;
 	u32 hi, lo, lo2;
 	u8 tmr_idx;
 
 	scoped_guard(rcu) {
-		if (!ice_is_primary(hw))
+		if (!ice_is_primary(hw)) {
 			hw = ice_get_primary_hw(pf);
+			if (!hw)
+				return -ENODEV;
+		}
 
 		tmr_idx = ice_get_ptp_src_clock_index(hw);
 		guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
@@ -232,12 +238,12 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 		ptp_read_system_prets(sts);
 
 		if (hw->mac_type == ICE_MAC_E830) {
-			u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
+			*time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
 
 			/* Read the system timestamp post PHC read */
 			ptp_read_system_postts(sts);
 
-			return clk_time;
+			return 0;
 		}
 
 		lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
@@ -260,7 +266,9 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 
 	}
 
-	return ((u64)hi << 32) | lo;
+	*time = ((u64)hi << 32) | lo;
+
+	return 0;
 }
 
 /**
@@ -997,13 +1005,15 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
  * Return:
  * * 0 - OK, successfully updated
  * * -EAGAIN - PF was busy, need to reschedule the update
+ * * -ENODEV - no control PF owns the source clock register space
+ * * -EOPNOTSUPP - PTP support is not compiled in
  */
 static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	unsigned long update_before;
 	u64 systime;
-	int i;
+	int err, i;
 
 	update_before = pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
 	if (pf->ptp.cached_phc_time &&
@@ -1016,11 +1026,22 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 	}
 
 	/* Read the current PHC time */
-	systime = ice_ptp_read_src_clk_reg(pf, NULL);
-
-	/* Update the cached PHC time stored in the PF structure */
-	WRITE_ONCE(pf->ptp.cached_phc_time, systime);
-	WRITE_ONCE(pf->ptp.cached_phc_jiffies, jiffies);
+	err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
+	if (err) {
+		/* The source clock is gone, so the cache can no longer be
+		 * refreshed. Publish zero instead of leaving the last good
+		 * value behind: ice_ptp_get_rx_hwts() has no staleness check
+		 * and would keep extending Rx timestamps against it.
+		 * cached_phc_jiffies is deliberately left alone so that
+		 * ice_ptp_extend_40b_ts() still discards Tx timestamps.
+		 */
+		systime = 0;
+		WRITE_ONCE(pf->ptp.cached_phc_time, 0);
+	} else {
+		/* Update the cached PHC time stored in the PF structure */
+		WRITE_ONCE(pf->ptp.cached_phc_time, systime);
+		WRITE_ONCE(pf->ptp.cached_phc_jiffies, jiffies);
+	}
 
 	if (test_and_set_bit(ICE_CFG_BUSY, pf->state))
 		return -EAGAIN;
@@ -1043,7 +1064,7 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 	}
 	clear_bit(ICE_CFG_BUSY, pf->state);
 
-	return 0;
+	return err;
 }
 
 /**
@@ -1073,8 +1094,8 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 		 * properly reset them here. This could lead to reporting of
 		 * invalid timestamps, but there isn't much we can do.
 		 */
-		dev_warn(dev, "%s: ICE_CFG_BUSY, unable to immediately update cached PHC time\n",
-			 __func__);
+		dev_warn(dev, "%s: unable to immediately update cached PHC time, err %d\n",
+			 __func__, err);
 
 		/* Queue the work item to update the Rx rings when possible */
 		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
@@ -1811,6 +1832,7 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	u64 clk, period, start, phase;
 	struct ice_hw *hw = &pf->hw;
 	int pin_desc_idx;
+	int err;
 
 	pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_PEROUT, rq->index);
 	if (pin_desc_idx < 0)
@@ -1849,7 +1871,10 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	 * at the next multiple of period, maintaining phase at least 0.5 second
 	 * from now, so we have time to write it to HW.
 	 */
-	clk = ice_ptp_read_src_clk_reg(pf, NULL) + NSEC_PER_MSEC * 500;
+	err = ice_ptp_read_src_clk_reg(pf, NULL, &clk);
+	if (err)
+		return err;
+	clk += NSEC_PER_MSEC * 500;
 	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay_ns)
 		start = div64_u64(clk + period - 1, period) * period + phase;
 
@@ -1992,8 +2017,12 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
 	u64 time_ns;
+	int err;
+
+	err = ice_ptp_read_src_clk_reg(pf, sts, &time_ns);
+	if (err)
+		return err;
 
-	time_ns = ice_ptp_read_src_clk_reg(pf, sts);
 	*ts = ns_to_timespec64(time_ns);
 	return 0;
 }
@@ -3041,9 +3070,13 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 
 	ice_ptp_maybe_trigger_tx_interrupt(pf);
 
-	/* Run twice a second or reschedule if phc update failed */
+	/* Run twice a second, or retry soon if another thread was busy
+	 * updating the Rx rings. Other errors, such as a missing control PF,
+	 * do not clear up on their own and must not turn the periodic worker
+	 * into a busy loop.
+	 */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
-				   msecs_to_jiffies(err ? 10 : 500));
+				   msecs_to_jiffies(err == -EAGAIN ? 10 : 500));
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 8a341e3cba17..562822b106d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -331,8 +331,8 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
-u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
-			     struct ptp_system_timestamp *sts);
+int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts, u64 *time);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
@@ -384,10 +384,11 @@ ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 	return false;
 }
 
-static inline u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
-					   struct ptp_system_timestamp *sts)
+static inline int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+					   struct ptp_system_timestamp *sts,
+					   u64 *time)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline u64
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 38e90a68ba78..a85aa8f99057 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -339,8 +339,11 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 
 	guard(rcu)();
 
-	if (!ice_is_primary(hw))
+	if (!ice_is_primary(hw)) {
 		hw = ice_get_primary_hw(pf);
+		if (!hw)
+			return;
+	}
 
 	wr32(hw, GLTSYN_CMD, cmd_val);
 }
@@ -359,8 +362,11 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 
 	guard(rcu)();
 
-	if (!ice_is_primary(hw))
+	if (!ice_is_primary(hw)) {
 		hw = ice_get_primary_hw(pf);
+		if (!hw)
+			return;
+	}
 
 	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
 	wr32(hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
@@ -2020,6 +2026,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		guard(rcu)();
 
 		pri_hw = ice_get_primary_hw(pf);
+		if (!pri_hw)
+			return -ENODEV;
 
 		zo = rd32(pri_hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(pri_hw, GLTSYN_SHTIME_L(tmr_idx));
@@ -2199,6 +2207,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		 */
 		rcu_read_lock();
 		pri_hw = ice_get_primary_hw(pf);
+		if (!pri_hw) {
+			rcu_read_unlock();
+			return -ENODEV;
+		}
 
 		lo = rd32(pri_hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(pri_hw, GLTSYN_INCVAL_H(tmr_idx));
@@ -5354,8 +5366,13 @@ bool ice_ptp_lock(struct ice_hw *hw)
 
 	down_read(&pf->adapter->ctrl_pf_lock);
 
-	if (!ice_is_primary(hw))
+	if (!ice_is_primary(hw)) {
 		hw = ice_get_primary_hw(pf);
+		if (!hw) {
+			up_read(&pf->adapter->ctrl_pf_lock);
+			return false;
+		}
+	}
 
 #define MAX_TRIES 15
 
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
index ca8018e3dd42..66332d02c5ba 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
@@ -2485,7 +2485,10 @@ static int ice_vc_get_phc_time(struct ice_vf *vf)
 
 	len = sizeof(*phc_time);
 
-	phc_time->time = ice_ptp_read_src_clk_reg(pf, NULL);
+	if (ice_ptp_read_src_clk_reg(pf, NULL, &phc_time->time)) {
+		v_ret = VIRTCHNL_STATUS_ERR_NOT_SUPPORTED;
+		len = 0;
+	}
 
 err:
 	/* send the response back to the VF */
-- 
2.53.0

