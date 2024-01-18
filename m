Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5D9C47DB3
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 Jan 2024 17:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9C2983EEF;
	Thu, 18 Jan 2024 17:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9C2983EEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705599992;
	bh=VsMaJtWf5FtrhX762lsWBH8lVMeJuT82Unm6NjmGa+Y=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ce2jaYLPXyffiFV/jMqiDI2rkNicB/yGxglrVhf4YlA8Kds6ZpnaenYuTO/Oj37A3
	 7avP3kNm3Ue//OKgumsWvbnvr6sApMrtHAi4BB0Hl8Bv9RG8AY1d/DBQ3diikQ6RE7
	 wQiqPsw720vy2P42ccGo6L731dt1KuPX3bu3HmVBjK2aOW6C22c5j85VoEGsobU3AG
	 N0c1TUwF3eUdUuIAIpX9BeCVWRkvSKSmcQPNR0qjjwjI5ktVc/24xWEkdFiYaIKXci
	 vB2u8bc0pbm3GXCu8lPRMlrzL35jpA/ZhhhITVjVStM7nGQtKpPRBorZzeBq4mLGkj
	 iKctDhhMOa7aA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJywLrUiISnP; Thu, 18 Jan 2024 17:46:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1F7F83FFB;
	Thu, 18 Jan 2024 17:46:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1F7F83FFB
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5E67D1BF376
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jan 2024 17:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43F796F5C3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jan 2024 17:46:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43F796F5C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zYJwuuEyHu-Z for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 Jan 2024 17:46:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A4126F646
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jan 2024 17:46:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A4126F646
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="22001408"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="22001408"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 09:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="26819770"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
 by fmviesa001.fm.intel.com with ESMTP; 18 Jan 2024 09:46:14 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 18 Jan 2024 18:45:49 +0100
Message-Id: <20240118174552.2565889-5-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240118174552.2565889-1-karol.kolacinski@intel.com>
References: <20240118174552.2565889-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705599977; x=1737135977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=68jVvMhU1kG514ua7vPoDZLFEpxD3nLkUs2Cyv+pqTs=;
 b=cea4DBzPMagapFrLuHeCo+V9TCFA4kPrtcQz+YBAWWZRj4plrRpNlM/7
 UXZarr80VcsSA+9J9l2c6q6f51RjMkEdIIbopu+chxuRjEX2Bplvbwcmx
 4P9lAMCfK31s18wz2/E9XBieUSHc84zN+FdpyB7SGAvSvywE5hZastQ/6
 aloWqJGQN5omyjlTA3PvE2kkLIv3T7LRf3gaNwU1yFd9C9zkl7pwJAlYI
 nfQ7dvOPgc0opWOv9s3F1S6KZYj4MzCbVuQ1LfGjsl3jlOE4sF6sbc1dP
 fFWU+J3O7z9BZTLTRsPJaOoR+NtPs4hiRVJoxWcLBMBcRcBOKIB9VewqK
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cea4DBzP
Subject: [Intel-wired-lan] [PATCH v6 iwl-next 4/7] ice: don't check
 has_ready_bitmap in E810 functions
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 Karol Kolacinski <karol.kolacinski@intel.com>, anthony.l.nguyen@intel.com,
 jesse.brandeburg@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

E810 hardware does not have a Tx timestamp ready bitmap. Don't check
has_ready_bitmap in E810-specific functions.
Add has_ready_bitmap check in ice_ptp_process_tx_tstamp() to stop
relying on the fact that ice_get_phy_tx_tstamp_ready() returns all 1s.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
V5 -> V6: introduced this patch which was a part of a previous one

 drivers/net/ethernet/intel/ice/ice_ptp.c | 25 ++++++++++++------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 558716aa6ef1..69d11dbda22c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -601,17 +601,13 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
 	/* Read the low 32 bit value */
 	raw_tstamp |= (u64)rd32(&pf->hw, PF_SB_ATQBAH);
 
-	/* For PHYs which don't implement a proper timestamp ready bitmap,
-	 * verify that the timestamp value is different from the last cached
-	 * timestamp. If it is not, skip this for now assuming it hasn't yet
-	 * been captured by hardware.
+	/* Devices using this interface always verify the timestamp differs
+	 * relative to the last cached timestamp value.
 	 */
-	if (!drop_ts && !tx->has_ready_bitmap &&
-	    raw_tstamp == tx->tstamps[idx].cached_tstamp)
+	if (raw_tstamp == tx->tstamps[idx].cached_tstamp)
 		return;
 
-	if (!tx->has_ready_bitmap && raw_tstamp)
-		tx->tstamps[idx].cached_tstamp = raw_tstamp;
+	tx->tstamps[idx].cached_tstamp = raw_tstamp;
 	clear_bit(idx, tx->in_use);
 	skb = tx->tstamps[idx].skb;
 	tx->tstamps[idx].skb = NULL;
@@ -701,9 +697,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	hw = &pf->hw;
 
 	/* Read the Tx ready status first */
-	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
-	if (err)
-		return;
+	if (tx->has_ready_bitmap) {
+		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
+		if (err)
+			return;
+	}
 
 	/* Drop packets if the link went down */
 	link_up = ptp_port->link_up;
@@ -731,7 +729,8 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		 * If we do not, the hardware logic for generating a new
 		 * interrupt can get stuck on some devices.
 		 */
-		if (!(tstamp_ready & BIT_ULL(phy_idx))) {
+		if (tx->has_ready_bitmap &&
+		    !(tstamp_ready & BIT_ULL(phy_idx))) {
 			if (drop_ts)
 				goto skip_ts_read;
 
@@ -751,7 +750,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		 * from the last cached timestamp. If it is not, skip this for
 		 * now assuming it hasn't yet been captured by hardware.
 		 */
-		if (!drop_ts && tx->verify_cached &&
+		if (!drop_ts && !tx->has_ready_bitmap &&
 		    raw_tstamp == tx->tstamps[idx].cached_tstamp)
 			continue;
 
-- 
2.40.1

