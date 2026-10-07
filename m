Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFDACA6007
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E452160706;
	Wed,  7 Oct 2026 13:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fUxI9jDUhV0; Wed,  7 Oct 2026 13:17:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CCFDA6081B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379026;
	b=qMBi4Fl8nKKYc7ne+0zjIFCpqHH0iivtBAA6tLkso3yuZzusvJmeRH8ZvBcK9DQpJmwN
	 654qgck/0tfb0s46nmXM7vQDfqCbiXh7EwaqRW22Jzn/GrSkHOcTRMyOpemVvSonikFt3
	 DDetxQeD5hUXg0xbehXfg2gJXGF9p/x+5K+jN0/YIz9Q3gdUHDhbXF2C15WB5z77P1rb/
	 NULuCwEgcl2WuXPm1rwKCyVqt+KYAY3cuMHiKUFZ+6c/A3S3Exg8jtREnw8Z0VWEBmeIK
	 f8BUA6OXbZYSw9IGk2EpPICRWu2s35Z4u4sjvP/hmV6KnD5r8BMDTZbNEZ/kOx2UmeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Yd1uEK0kxEtM+RtdnFL0tl6ahFrCu2TteaNd4hOr2ic=;
	b=d10YBPc7bfS6CVYjg9iDI57oBD/MIWvv7NiVKUHv6iJXhAwO81SwpKajOMJ95AVjVjzp
	 NHYkmiWSSwI8oIdAHA1IB1pGZwZxyxDj9sSzjlz/2MuvW52v3pnoKMGmlKTehwP/wzx6r
	 DcgbqTmK3eiJjbpvDFGuRBxo3YilbDqsOh1NKsoWTPPgZ3KlV8UDXussIx8/zpK05ORSw
	 qo7We7AvuLsvyrcbBb2F7pUmtqpbh2l5g1bX/cADwTYhxVId6FxVVRn7uCevCJh3Sv7DE
	 KBiUyK+lwgeXX9onElg24XcMsR+VRbT8jsfOWG5oI5+cqpKug9uSgYLRkYt1DEvRV4w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791379026;
	bh=Yd1uEK0kxEtM+RtdnFL0tl6ahFrCu2TteaNd4hOr2ic=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K6jSUFSpEmmdIkX1nfNtmVQ+FsmqAJYoCd3ySc9LeC99u46bBxTkA8V9hMrbu8s9o
	 xeIToq7iyX/o8l9XJSKzy2tTu6FItR8HW/K9CXYv5JcupAL6UCOtpTpZX9QSFESH6D
	 T4xPJpKP/ZdY0ewPtBbXjnXU5ZtXONDY4AvCv/ZhmwrlnxLO/FjZ+P8RPCyNotmr02
	 vv23EOI81Oe8LBLutUL5g6eWzqP6qSm8KKyxRd6gPEWqD9cKaJq39s2HrA7cJ94xnN
	 PsLM6KO072s9rbgsY0MmFqkJ7iy3OMr/rKWDdz5pIapeG2R3uvTZVkYWUh/Fne23E5
	 8ZRhcp38BJ4tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCFDA6081B;
	Wed,  7 Oct 2026 13:17:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 33F4E338
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2557B80D91
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A2tFnfo70M6i for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 12:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EAB8580EDA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791377304;
 b=DutmJMov1X3KGXxrvNm3B/pGRW6V0renHEgHTp+IKzNw8XqWVDyWvEPUmsRSeYykcUnS
 M60u4b0oufWOSXhGoBjpearDhls/YI2mGXAWBbz00gZ/PqpgoP+LN1lznWd6iOBTH9CKM
 zmC4a2T2/KbtstUx9YM+B6kPU97iaGDVKMRKw7kiiClh07FsnLSlAesA8mNzyUABawp+Z
 63suneYhs1PVVUfGLm4SEkUbvgppHNit2CeuBI0IhSShcbsEqOa+IgvA7D/v1VuXF+1g1
 1JexGkGngM3iwcJzVT/y+4uNS6GvkSkDwcZErfnqlTkaSas1pMKqMSuBSRp7tp1gNng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791377304;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Yd1uEK0kxEtM+RtdnFL0tl6ahFrCu2TteaNd4hOr2ic=;
 b=ZmPCwSCCm1TBbdPswf583Q9ZDkp5L3qRBn/nd0UV2x30DsUl/bRrUVWmcPpGwjaoQ9s5
 NqWwa2gvaeMbC2IUt17UQ0WG/5qRQZU4BNrNWncTMUH8NqCXxDXnQa1BEa6YQRE2hO3Lo
 RAqkz6UJXc2ocZyQ+e362T19TNgFLnlROI5burYHw+cXS9oIlDoyJEpUgQ6rdzmpbIFm/
 mZl3hVLLVTGYqLUs2+yLvMxtyqk3J0wcCUDZfgY5597R8/n9HH3AvdVmfKnlat32TttY3
 HpYzgbPHb/jVdCbYEmxTXSpc/5QXAlzkBnAHmBJAmpVVIZ7CvNslfjcTWmL7emSMebw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Eu1r27sz; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Eu1r27sz
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAB8580EDA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791377304; x=1822913304;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4Yqeo7BA4GZywXHOzk0R7sLwStbUotc9oOEiow8sOTQ=;
 b=Eu1r27sz2O88odBqaTwO478lhe7F9QMWZsTgZbzw0hZrop8BF3H4R1si
 PCapmdc6cGpmsvR4wIvi+LFD2WDk8pa4ZofHa/dj2Hx2heP3Ad+6DE6IW
 zCJ6zkOl+0RaFQ6YO/SyICTXclwl6se5oYyKVpfBW3AfjlB2oqWBRfYUd
 eGDVRhTcnJzeCickIVTNhghVPIKPTfIskXdrXhA31DQJIL4j6fJGof02U
 qBPwdE+bif7t49zGZmpWic/J4V04EeW29gFon1/s+2GCUUDUmKEhLi60v
 zPG5gkKYBchEaxIXaqem8mrfdNDKGl2Jaz2B7hxgJU5aMyqcckZR6FeVL A==;
X-CSE-ConnectionGUID: hXf7RyZTRL6zfnUlhWJ4GA==
X-CSE-MsgGUID: uKcIiUpASyqTc2S0qu/9sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="31579"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="31579"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 05:48:24 -0700
X-CSE-ConnectionGUID: pKGQDQ+bRTu1C5UKiS0XTw==
X-CSE-MsgGUID: 4UzcgjS+SXKIIlXG2/GZmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="281191704"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 07 Oct 2026 05:48:23 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v6 3/7] ice: Reject PTP access without a control PF
Date: Wed,  7 Oct 2026 12:48:15 +0000
Message-ID: <20261007124819.1074675-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
References: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
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

A failed PHC read invalidates the cached PHC time by publishing zero.
ice_ptp_get_rx_hwts() already treats a zero cache as "no timestamp";
teach ice_ptp_extend_40b_ts() to do the same so that Tx timestamps are
discarded rather than extended against a value that no longer tracks
the clock.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  9 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 85 ++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h      | 11 +--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 24 +++++-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  5 +-
 5 files changed, 98 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b88c89db9387..aa81b6db7502 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1147,8 +1147,8 @@ static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
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
@@ -1157,10 +1157,7 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
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
index ece2e2ba2602..471fc39f379b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -215,17 +215,23 @@ void ice_ptp_restore_timestamp_mode(struct ice_pf *pf)
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
@@ -233,12 +239,12 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
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
@@ -261,7 +267,9 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 
 	}
 
-	return ((u64)hi << 32) | lo;
+	*time = ((u64)hi << 32) | lo;
+
+	return 0;
 }
 
 /**
@@ -361,6 +369,7 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 {
 	const u64 mask = GENMASK_ULL(31, 0);
 	unsigned long discard_time;
+	u64 cached_time;
 
 	/* Discard the hardware timestamp if the cached PHC time is too old */
 	discard_time = pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
@@ -369,8 +378,17 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 		return 0;
 	}
 
-	return ice_ptp_extend_32b_ts(READ_ONCE(pf->ptp.cached_phc_time),
-				     (in_tstamp >> 8) & mask);
+	/* Discard it as well if there is no cached PHC time at all, which is
+	 * how ice_ptp_update_cached_phctime() reports that the source clock
+	 * has become unreachable.
+	 */
+	cached_time = READ_ONCE(pf->ptp.cached_phc_time);
+	if (!cached_time) {
+		pf->ptp.tx_hwtstamp_discarded++;
+		return 0;
+	}
+
+	return ice_ptp_extend_32b_ts(cached_time, (in_tstamp >> 8) & mask);
 }
 
 /**
@@ -1035,13 +1053,15 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
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
@@ -1054,11 +1074,22 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
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
+		 * value behind: neither ice_ptp_get_rx_hwts() nor
+		 * ice_ptp_extend_40b_ts() may extend against a value that no
+		 * longer tracks the PHC, and both treat a zero cache as
+		 * "no timestamp".
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
@@ -1081,7 +1112,7 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 	}
 	clear_bit(ICE_CFG_BUSY, pf->state);
 
-	return 0;
+	return err;
 }
 
 /**
@@ -1111,8 +1142,8 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 		 * properly reset them here. This could lead to reporting of
 		 * invalid timestamps, but there isn't much we can do.
 		 */
-		dev_warn(dev, "%s: ICE_CFG_BUSY, unable to immediately update cached PHC time\n",
-			 __func__);
+		dev_warn(dev, "%s: unable to immediately update cached PHC time, err %d\n",
+			 __func__, err);
 
 		/* Queue the work item to update the Rx rings when possible */
 		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
@@ -1877,6 +1908,7 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	u64 clk, period, start, phase;
 	struct ice_hw *hw = &pf->hw;
 	int pin_desc_idx;
+	int err;
 
 	pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_PEROUT, rq->index);
 	if (pin_desc_idx < 0)
@@ -1915,7 +1947,10 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
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
 
@@ -2058,8 +2093,12 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
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
@@ -3112,9 +3151,13 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 
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
index faf7b6dc4847..21c5434f77f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -329,8 +329,8 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
-u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
-			     struct ptp_system_timestamp *sts);
+int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts, u64 *time);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
@@ -382,10 +382,11 @@ ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
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
index c84adc096027..dde6bddd4ecf 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -355,8 +355,11 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 
 	guard(rcu)();
 
-	if (!ice_is_primary(hw))
+	if (!ice_is_primary(hw)) {
 		hw = ice_get_primary_hw(pf);
+		if (!hw)
+			return;
+	}
 
 	wr32(hw, GLTSYN_CMD, cmd_val);
 }
@@ -375,8 +378,11 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 
 	guard(rcu)();
 
-	if (!ice_is_primary(hw))
+	if (!ice_is_primary(hw)) {
 		hw = ice_get_primary_hw(pf);
+		if (!hw)
+			return;
+	}
 
 	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
 	wr32(hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
@@ -2039,6 +2045,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		guard(rcu)();
 
 		pri_hw = ice_get_primary_hw(pf);
+		if (!pri_hw)
+			return -ENODEV;
 
 		zo = rd32(pri_hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(pri_hw, GLTSYN_SHTIME_L(tmr_idx));
@@ -2222,6 +2230,11 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		 */
 		rcu_read_lock();
 		pri_hw = ice_get_primary_hw(pf);
+		if (!pri_hw) {
+			rcu_read_unlock();
+			err = -ENODEV;
+			goto err_ptp_unlock;
+		}
 
 		lo = rd32(pri_hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(pri_hw, GLTSYN_INCVAL_H(tmr_idx));
@@ -5367,8 +5380,13 @@ bool ice_ptp_lock(struct ice_hw *hw)
 
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

