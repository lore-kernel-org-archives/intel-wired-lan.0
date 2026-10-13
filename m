Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29EFCC6B03
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 09:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C6AA40653;
	Tue, 13 Oct 2026 09:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVLc8iczVsib; Tue, 13 Oct 2026 09:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E83BA4052A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791882765;
	b=K07PnkpzcVHzfLKeNeyz6GCAfUHBoiqi6rk33dmto3bj8gV3W0mhZteb6NHXeaXNCCC9
	 clujBJIZrUC2qfdViENJ6NC9TQ5Hi83YWMtUbEQYhsBvKI70R0W+eHW9LcgHDwyL0IPBT
	 lZ/I5GDfJMpPdDd1NnpNO5lk6/cglVv6QygBgpYUHqwBKi0ntlxsYkOrBMlBMZUb95zWk
	 aznNz8LgloHRmwgxUa16QYd+2ZFNrC6P4eZbTlctow20vdX/GMmuHDraj/C3tQ/fVlZBV
	 OJgdoDENs3ygvzdtKUcrYiWMQrX+8ZOwLE5LorqE++Kty5zi8jzrzPBtzEHK0/2Griw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791882765;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tzN4mGl4ffM1Lqq7M3vQnVQE69hn/hZXRzKFudT2weQ=;
	b=d+Q1jFToEGOdIyoINvg7U/sy5nPH+FHInkqKP/M49LunHHm3sBGGRzae6l3pS/ALJwoz
	 ueIb6u9H1+55oM9wuHvcvh3VZ6dJeKV0YmqSWNlBG5GdxTNFNJAFMkNVEn+rPwVaZ5OFW
	 zZZzUsjmemTiBdCOe4s8cwzZMOUkH8TBnvfc1E7IeO0PJaqvZBulUecWmktcshTgKhNYk
	 1jgCIF+X4o9358/KlQSYYsQQ7N16brh+q+nGTlCp/ugXyxZ0x2kBkF3bkMxJGCjK72RZ5
	 w1tcYPpCFrWv+KPWn3/SbHAJHeAnu3zxJnQU8603jthHvKWw5YQ0SodJtu4v/9akp2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791882765;
	bh=tzN4mGl4ffM1Lqq7M3vQnVQE69hn/hZXRzKFudT2weQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KNk1e55o/LHCEJM6z+9df5rpIoTOEtFyf7pRG12uOcLkn10P2VluBvlmH1HJms9Tf
	 HPNS4RO8nIPKqiie67xQIWJWGUwpQieAX5XcHT76F+eJQ/mT9jbZNY1TMSLAoXNx+R
	 Z3qeETkE1bVFvHreJvLmXrULCenc1Q822sV4PMnyUrjg1vSkgE4USiE4HW7scOWMPN
	 dpou8UVzqO3hsfwuYuxWxNGhuGHvctZckp4JPobsgZ7kkDZurwI9tRxYxKb1GDBb90
	 1dV3YzMJNQHnOQ3f9fd6GbdtXCh/xFkzS486zLolDA+Gri8bUOaSjklnerecurjm8j
	 dyz/WXh82ktvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E83BA4052A;
	Tue, 13 Oct 2026 09:12:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70DBB4DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 574CE606D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XGpUnQG4U9no for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 09:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7A0B60693
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791882762;
 b=MFtjA+dEmMlWLC7fE6aD9p/u8NyUhSqIdseS2O+AHp+xUcjwx8Hkhm+7qFgSGUMJkPmi
 VNrCufc8TkoqrsvFhgS6DQ+g1T++0A0xOnwcV6nAgCtKrUoC5R2v1exKe8ZO6rX9ONNHM
 nsm+wuBweLNpDiYEcKhVXcAm8jCmGxbjwMgPvLUZ00mNDtbHVTfQhg16miV38TF4LcTgj
 VQdKINpamrzQxhCLxEwmR0J/h0hqfeZ0mcv0WTmx3QD48gQxlo5Xm5oExcCp3sjEfW6fo
 sFtBzSzB3dq41OsvGzrd19I1zi/BwYnGswR3sVbxEok5Sz2A4ASwVc4hagyQnb38gnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791882762;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=tzN4mGl4ffM1Lqq7M3vQnVQE69hn/hZXRzKFudT2weQ=;
 b=Zd2St6Fsyn8xaJqouifoOUurhyNV2+rOHvekYoZm9FwS+d0ftv0Qr+VQEcoFOqriVhps
 2aQERmp3F4Y5jMvsVuXC65CjJO9yFi9awn6dtNx8jEGgYFGclKQ3RFu47rfZtE8aZi+0E
 LNXHdwIDX2uUtYiSbAzxzPfcXNstLoBidPLyjuBFZG0da9vvSWCD/YyGarDvesf3I5ezU
 USFzMgW7tr2dd/jY21FcpQ6MFiP9tN5qaqpN5iDN2PCVWzDAYaekxCfL8YbVdtlaeCfvU
 9XEAPFCXsfuRBftk6duOJACfGDYFC8gjRjLHaKzLC2UtnvSkBrmIMps/xlv3PSs7/kA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IglYFSyF; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IglYFSyF
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7A0B60693
 for <intel-wired-lan@osuosl.org>; Tue, 13 Oct 2026 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791882762; x=1823418762;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2Gh1OaqiWJQiT0qxcH5WT+8wm1FaoQEiw04hvH2dEMU=;
 b=IglYFSyFrfrbEdzNOKjBMZvRyrbhtidPqebvrArKIM63CjOhU1NJFhvD
 J8M2psrd7a82XMYkQOlmLFYvld+RpTmlXJHMMCtDhTNPCSEbcowvz72Z+
 Er67oLDcOtJewAW1oQqIdJfZt2n76Gd+dKohOUblJK2ENPjAnMLGpbHxd
 ED/YhObVLEC6Yc4s1ZNObYrEZ2Wvh1+8w0MAQbfeL6Voq6IvfOoFddtcS
 PY8hQ7W3h9UqJIO0jh3gp/u2lmxN/4ytoH8ftRKzkClcJIcHoXKThubjn
 zqmArVT0NMOIO6oL277+nmt+d4SEiidjiLiePkQJTZOaQv3TT4eSmy7Rq g==;
X-CSE-ConnectionGUID: cQ25krxlQtiN4QuY0+Y5dg==
X-CSE-MsgGUID: kKTTHsK6RIagBW0El4Stqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="481268"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="481268"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:12:41 -0700
X-CSE-ConnectionGUID: 8uusGDlzQHKUEG7aDn0YNQ==
X-CSE-MsgGUID: tHD9CRseSrO9g0w/FHSp5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1125346"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa004.jf.intel.com with ESMTP; 13 Oct 2026 02:12:40 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH RESEND iwl-net v6 3/7] ice: Reject PTP access without a
 control PF
Date: Tue, 13 Oct 2026 09:12:31 +0000
Message-ID: <20261013091235.1423979-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
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
index c7f3b444d16d..f104df72bedf 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1154,8 +1154,8 @@ static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
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
@@ -1164,10 +1164,7 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
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
index 58dc16b5762c..b901f2e0b1c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -212,17 +212,23 @@ void ice_ptp_restore_timestamp_mode(struct ice_pf *pf)
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
@@ -230,12 +236,12 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
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
@@ -258,7 +264,9 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 
 	}
 
-	return ((u64)hi << 32) | lo;
+	*time = ((u64)hi << 32) | lo;
+
+	return 0;
 }
 
 /**
@@ -358,6 +366,7 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 {
 	const u64 mask = GENMASK_ULL(31, 0);
 	unsigned long discard_time;
+	u64 cached_time;
 
 	/* Discard the hardware timestamp if the cached PHC time is too old */
 	discard_time = pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
@@ -366,8 +375,17 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
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
@@ -1032,13 +1050,15 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
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
@@ -1051,11 +1071,22 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
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
@@ -1078,7 +1109,7 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 	}
 	clear_bit(ICE_CFG_BUSY, pf->state);
 
-	return 0;
+	return err;
 }
 
 /**
@@ -1108,8 +1139,8 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 		 * properly reset them here. This could lead to reporting of
 		 * invalid timestamps, but there isn't much we can do.
 		 */
-		dev_warn(dev, "%s: ICE_CFG_BUSY, unable to immediately update cached PHC time\n",
-			 __func__);
+		dev_warn(dev, "%s: unable to immediately update cached PHC time, err %d\n",
+			 __func__, err);
 
 		/* Queue the work item to update the Rx rings when possible */
 		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
@@ -1874,6 +1905,7 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	u64 clk, period, start, phase;
 	struct ice_hw *hw = &pf->hw;
 	int pin_desc_idx;
+	int err;
 
 	pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_PEROUT, rq->index);
 	if (pin_desc_idx < 0)
@@ -1912,7 +1944,10 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
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
 
@@ -2055,8 +2090,12 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
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
@@ -3038,9 +3077,13 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 
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
index 7810fefc546e..cf7e51d87c0c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -318,8 +318,8 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
-u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
-			     struct ptp_system_timestamp *sts);
+int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts, u64 *time);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
@@ -371,10 +371,11 @@ ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
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
index cc28779fc0f6..0786d46160ec 100644
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
@@ -2023,6 +2029,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		guard(rcu)();
 
 		pri_hw = ice_get_primary_hw(pf);
+		if (!pri_hw)
+			return -ENODEV;
 
 		zo = rd32(pri_hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(pri_hw, GLTSYN_SHTIME_L(tmr_idx));
@@ -2206,6 +2214,11 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
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
@@ -5351,8 +5364,13 @@ bool ice_ptp_lock(struct ice_hw *hw)
 
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

