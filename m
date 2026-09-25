Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D08C9832E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 22:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B1FF812E8;
	Fri, 25 Sep 2026 22:34:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_sMS2yMs02U; Fri, 25 Sep 2026 22:34:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6A15181312
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790375644;
	b=k5beHE9g2KavKyh/55QHTBlK6GxL+DbAP/x4FmUKbML1lxcoduMpSXNLh8fvuMz3gdaq
	 SMPpyX6+1DR9EgMIbSPQQBljDcpszmMEmRp6SA0H7hfLbom0eH6F5oxICqyWuR8HdckLg
	 H2GVQMyWkXGVadtVR+E4lfPCyPfxbncuTvRBbFP0o2m5TOeQZ0Hh8oviGAfsZE+y/0uJ2
	 SLYs3k1YpWCQjOBxiDK2eIbhU/ub+nQ2AGu7k8IrB0ljAHK4S2PYj5FL1mTpzZh2yzOOV
	 ix79PxIHPWSpB9Uztlh1UaPDAi/St/Af+npYJodUFkBeF80wxQ7Hrn3KimvO59cBdXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790375644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Wp4Vte9npQqsNohjYazWIlZdhLmEPeW3eVNFTj6EneY=;
	b=DOYBYTCVlBLsv+KP1fIC62KiG5ZYXZCwDO9J0zN9cYXd76clNeOl6e+j5PAznGS2Y4bY
	 HzkWAcJ04g+WFkHqdbFg87effuItwlEnhGghB+FiQTuKJi14BE1XLEW3jzrc6pmbQiHK+
	 p+pJMbpqqOAwPlRFf145YBwgwbJ7VTMnI7mWkXopTGTwKMgsUKQQtMixPUqG0qd16dZLw
	 iRgNa/KR7wN2xsBKhOJq7Vv6G6+eAEjN7U9+KEF5LiRk5FHfdy9Ai+LqcnPZ3jKuMi3PU
	 i0OqmtzJyLxjK4OuJrdekwA0FW8bPFR4VxhfpRm7XXpKWSHUDuqI1fob8sZUpCPQuTg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790375644;
	bh=Wp4Vte9npQqsNohjYazWIlZdhLmEPeW3eVNFTj6EneY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I4g5DvbzioiWAR7o+GYlo3d2mYBUjPnfmAHK86aXMiNLdd3t3s/1pcahsdKu69LRN
	 T+AXM9K9rypwT0TcWQjF/w/Nspbd/eGsKf0Pm7geuvI+VQ5D8aoUfmEE23J487eqyV
	 rv7dApl7Jyj0Yjg6FN0N9zmN9b0N7vbGBf05W46d9eETqY5ehKiIZJCkqL46cYSCpL
	 gp6zQ/HakQjfMWMLhYQQEYPb4deAOGxlkxoqz5Msmy8lffoUPuzle5oc3TGbBB7LbJ
	 LE+T4rlhYOMbUahGvRQ2QJ+EC+D5Fk1ry4bwbHlSFs2sRKWHE1TemFAl5jlKXgzz4f
	 lZV0OxzUktM8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A15181312;
	Fri, 25 Sep 2026 22:34:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D0A4355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F46A40AA7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5VUJJMl-y1zK for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 22:34:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D25D40A82
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790375642;
 b=cNja/+ys/WjGQt2/MwBMIUhvjKfh60Oshucb4lnCZcAnh3rQYybGif/QlqDWSw/bypat
 H2LQBYWPUDi0IFL3gt+DhvxA3uasrYeVVL37tFLvGVWmTRDvxmHeu8jHYbHZgaYTPPHB+
 tUFsxP/HcoACgbLh0wmslkYK7vcGYn54ddUuj/rPcw1/JBmtazyDpLQLqjowkyuT2uCoV
 20hT2qb7YY6zgcgwQg121uoWQmLR80JcGcoQy55rnMilVn2oRT7aAc5a23eWlpYnCsD6G
 B9IJ/5a1SzKyPbS3SY020gu0xPWdjEH2CtRgXVCKUvclHUZSbOlTpFxholG5k3aDEFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790375642;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Wp4Vte9npQqsNohjYazWIlZdhLmEPeW3eVNFTj6EneY=;
 b=U4aoY7f6PCqqm7O8SjDgwdNJD/Cupl1omxMpXRvmxnbRpsWFbjpWmhmKNP8iIvQ7gnuV
 uT4b32WYnQ+laTOagif6pL36GKPcNutxfFfp37+TfLWViqn0DGUk7LQVloGNNpSL9BJ++
 8VlDxmheak8ovQpde9r4GKj0kIdy/Evc574to6rSsKSO9Mo1g167O4//wIa5w9OflHNms
 h0zOXpxLOBZ780bO6YoNwPiCcU/gpAh3xkO1iBLbmHqvB8l70aFXknacyR4pBZ4uYY7EG
 /bzqd1oJ2SlrYbJtz7kYUBMY89tM59MjkVrwywCi40P0n0JQ5vXjG4nA89GNkchRr1Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="OSP/dFpv"; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OSP/dFpv
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D25D40A82
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790375642; x=1821911642;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/fRiT2uIHxSoKh+ze8gNFT3ceQoN28uehW9Lr55Jmxc=;
 b=OSP/dFpv3AvlIyJsc5veXchNHUrin6z9x3HCddBK1BxLIZPqR8MFcC6c
 h8yEVP5ZzCRetRY2KCq43mwteuS5JkI8wR3ddgpGl2Mlf2XjOhMU+Uapk
 E+RaR6EWip+lYwPQUoZCAdf/sgvSC0T36gx4yjO/jpjSnAvO1s9YNLCcD
 SVFs3kCW5cQJ5t/yYt8UkiMf/w7594ZF9xthpGvClNQ6c2WfjF4Y585Ox
 RRLIVVrZMPg54Bvq80vU8bR7LodzvNcDe3pvk/tnOkdJAlLyoJUfWwdz3
 qgAcoOLG8x4yYF6os86+oqvq1taHRrGTUJue/W86CmeMF/V1/k5/rbPjV A==;
X-CSE-ConnectionGUID: 7qaOh2/PTs6L9wFqhvyXhA==
X-CSE-MsgGUID: NW4HfTPFSY2OjzRsR4+Y0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90071990"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90071990"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 15:34:02 -0700
X-CSE-ConnectionGUID: 0LShXwHdTsGiNCK/k3RJ4g==
X-CSE-MsgGUID: mhIRvkYIS0OMWSBUT3Iatg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="273053398"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2026 15:33:59 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 arkadiusz.kubalewski@intel.com, davem@davemloft.net, edumazet@google.com,
 Maciek Machnikowski <maciej.machnikowski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Marc Neustadter <marc.neustadter@intel.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start with PTP
 lock and incval
Date: Sat, 26 Sep 2026 00:28:23 +0200
Message-Id: <20260925222824.270640-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260925222824.270640-1-grzegorz.nitka@intel.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
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

From: Maciek Machnikowski <maciej.machnikowski@intel.com>

ice_start_phy_timer_eth56g() programmed the PHY increment value and
performed the PHY-to-PHC phase synchronization in two separate PTP
semaphore critical sections, and touched the shared source command
register (GLTSYN_CMD via ice_ptp_src_cmd()) and read the source incval
before acquiring the semaphore at all.

Because GLTSYN_CMD is a single global register latched for the source
timer and all PHY ports by GLTSYN_CMD_SYNC, a concurrent adjtime (small
offset, <= S32_MAX) or adjfine could clobber the source command between
the incval-init and the phase-sync steps. In the worst case the source
timer command written by ice_ptp_adj_clock() (ICE_PTP_ADJ_TIME) was
overwritten by the unlocked ICE_PTP_NOP from ice_start_phy_timer_eth56g(),
so the adjustment was applied to the PHY ports but not to the PHC. This
left the E825 PHY clock permanently offset from the PHC, showing up as an
intermittent clock drift.

Hold the PTP semaphore across the entire start sequence: acquire it
before the first shared-register access (ice_ptp_src_cmd()), keep it held
through the incval read, PHY incval init, and the phase synchronization,
then release it once. Since the hardware semaphore is not recursive, split
the phase-sync helper into ice_sync_phy_timer_eth56g_unlocked(), which
assumes the caller already holds the lock, and call it directly from
ice_start_phy_timer_eth56g(). The locking wrapper is removed as it no
longer has any callers.

Fixes: 781ff8f2d575 ("ice: ptp: serialize E825 PHY timer start with PTP lock")
Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Suggested-by: Marc Neustadter <marc.neustadter@intel.com>
Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 20bd1813650f..d3e4aeb7e496 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2045,7 +2045,7 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 }
 
 /**
- * ice_sync_phy_timer_eth56g - Synchronize the PHY timer with PHC timer
+ * ice_sync_phy_timer_eth56g_unlocked - Synchronize the PHY timer with PHC timer
  * @hw: pointer to the HW struct
  * @port: the PHY port to synchronize
  *
@@ -2058,22 +2058,18 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
  *
  * Return:
  * * %0     - success
- * * %-EBUSY- failed to acquire PTP semaphore
  * * %other - PHY read/write failed
+ *
+ * The caller must acquire PTP semaphore lock
  */
-static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
+static int ice_sync_phy_timer_eth56g_unlocked(struct ice_hw *hw, u8 port)
 {
 	u64 phc_time, phy_time, difference;
 	int err;
 
-	if (!ice_ptp_lock(hw)) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to acquire PTP semaphore\n");
-		return -EBUSY;
-	}
-
 	err = ice_read_phy_and_phc_time_eth56g(hw, port, &phy_time, &phc_time);
 	if (err)
-		goto err_unlock;
+		return err;
 
 	/* Calculate the amount required to add to the port time in order for
 	 * it to match the PHC time.
@@ -2089,11 +2085,11 @@ static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	err = ice_ptp_prep_port_adj_eth56g(hw, port, (s64)difference);
 	if (err)
-		goto err_unlock;
+		return err;
 
 	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_ADJ_TIME);
 	if (err)
-		goto err_unlock;
+		return err;
 
 	/* Issue the sync to activate the time adjustment */
 	ice_ptp_exec_tmr_cmd(hw);
@@ -2103,15 +2099,13 @@ static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	 */
 	err = ice_read_phy_and_phc_time_eth56g(hw, port, &phy_time, &phc_time);
 	if (err)
-		goto err_unlock;
+		return err;
 
 	dev_info(ice_hw_to_dev(hw),
 		 "Port %u PHY time synced to PHC: 0x%016llX, 0x%016llX\n",
 		 port, phy_time, phc_time);
 
-err_unlock:
-	ice_ptp_unlock(hw);
-	return err;
+	return 0;
 }
 
 /**
@@ -2174,19 +2168,24 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	if (!ice_ptp_lock(hw)) {
+		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP semaphore\n");
+		return -EBUSY;
+	}
+
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	err = ice_phy_cfg_parpcs_eth56g(hw, port);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	err = ice_phy_cfg_ptp_1step_eth56g(hw, port);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	err = ice_phy_cfg_mac_eth56g(hw, port);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	if (ice_is_primary(hw)) {
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
@@ -2203,11 +2202,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	}
 	incval = (u64)hi << 32 | lo;
 
-	if (!ice_ptp_lock(hw)) {
-		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP semaphore\n");
-		return -EBUSY;
-	}
-
 	err = ice_write_40b_ptp_reg_eth56g(hw, port, PHY_REG_TIMETUS_L, incval);
 	if (err)
 		goto err_ptp_unlock;
@@ -2218,11 +2212,11 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	ice_ptp_exec_tmr_cmd(hw);
 
-	ice_ptp_unlock(hw);
-
-	err = ice_sync_phy_timer_eth56g(hw, port);
+	err = ice_sync_phy_timer_eth56g_unlocked(hw, port);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
+
+	ice_ptp_unlock(hw);
 
 	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 1);
 	if (err)
-- 
2.39.3

