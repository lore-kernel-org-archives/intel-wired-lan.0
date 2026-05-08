Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F1FCD37AD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 03:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E27BE4145A;
	Fri,  8 May 2026 03:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpLtBE51b_or; Fri,  8 May 2026 03:12:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18CDF41455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778209957;
	bh=bh/oORBLNQ2x5kaaL0oP0C72RNUJz4SGrmtRKwH9lvs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m8sv6WChwveKUxmurqQdmUFcvuvg/Rly50v4LO8EpJpXOjf+uLe0ojR6b6tqccGE6
	 lTAPoKfNCxe7R3ZbjWnjkBOSzfkD9ZB5mOyixVDg1Y6QYRaRmvwU5e628EHzSQ+eYl
	 rCuplk1o+zzlalNdTzWeWKAX5eEipndjux/5Rofia4/fJIu7dDJdubyREZqVsyPjzY
	 T6Gra0bprBWy96ruKjDx1Vav9fTExKJ3YjYoPNjwqaXm+9GJ7g2iEMn8sgnyLZHHYm
	 sS9Y4/omgpwhV0Lz8lfmBfYrAbtidYpZ9IQr405sfCtIOKg9RZcUt7ctK85pCYh5Nr
	 ZStzsd/hC8uiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18CDF41455;
	Fri,  8 May 2026 03:12:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AA38317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00B3E409B3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHDDLJN0cN1A for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 03:12:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F0E634030E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0E634030E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F0E634030E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:33 +0000 (UTC)
X-CSE-ConnectionGUID: FNIWQ54zRo2cNoUvCp0RUw==
X-CSE-MsgGUID: gFkayHSPTRu5x90ZQilYLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027501"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="79027501"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 20:12:34 -0700
X-CSE-ConnectionGUID: 64ZNGCcPTIG3odcucKXIjw==
X-CSE-MsgGUID: LUJ9MZl+RIWFn0YYHfHPhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="241623191"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:32 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Piotr Skajewski <piotrx.skajewski@intel.com>
Date: Fri,  8 May 2026 05:12:21 +0200
Message-ID: <20260508031226.3601800-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778209954; x=1809745954;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eNkuLWRPSYTLbgVnN8ZTLbezDayq2V1B+TaYvmbS3UQ=;
 b=NGZS+pM6gDcFbB2LOj1Z15MV3dnjMoPNqHjcksds+Wp+tZoMf4UgPKX5
 Oczpxf89dN3Rus6Ks9U0o8zXnqieMkRKIFnpxiSkjZzbf/rmcmajQvr2w
 JJt0KDegKrySY8faDLTjC+iI5CWElrF0Dh+Ymz+ROvnMdB8yVCs7QngTy
 wdyW0PEZ7GP3GM08LxkTbTljY65OV7ibVtgmU1dCHODWoPxHuJTzkesxT
 +FZHXx5BvjPxYy7VO4vU+H40Pqiu2YTZuGEruSJCk0OG95gGcXLvvKynD
 tLCPpPbX7Y8kJu6nP39DV/VwxNOgvBEyahQs0U2o0od/wn9kZ7E4R+l8l
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NGZS+pM6
Subject: [Intel-wired-lan] [PATCH iwl-next 3/8] ixgbe: prevent adding
 duplicate FDIR perfect filter rules
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

From: Piotr Skajewski <piotrx.skajewski@intel.com>

When the same flow specification is added twice (same 5-tuple with
different sw_idx values), ixgbe_add_ethtool_fdir_entry() silently
programs the duplicate into hardware using a second FDIR table slot.
This wastes a scarce FDIR entry and can cause confusing behaviour
when deleting rules.

Add a helper ixgbe_match_ethtool_fdir_entry() that walks the in-kernel
filter list before programming hardware.  If an entry with an
identical filter (excluding the sw_idx) already exists, the new add
request is rejected with -EEXIST.

Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index ba049b3..a2009df 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2938,6 +2938,23 @@ static int ixgbe_flowspec_to_flow_type(struct ethtool_rx_flow_spec *fsp,
 	return 1;
 }
 
+static bool ixgbe_match_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
+					   struct ixgbe_fdir_filter *input)
+{
+	struct ixgbe_fdir_filter *rule = NULL;
+
+	hlist_for_each_entry(rule, &adapter->fdir_filter_list, fdir_node) {
+		if (rule->sw_idx == input->sw_idx)
+			continue;
+		if (!memcmp(&rule->filter, &input->filter,
+			    sizeof(rule->filter))) {
+			e_warn(drv, "FDIR filter already exists\n");
+			return true;
+		}
+	}
+	return false;
+}
+
 static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 					struct ethtool_rxnfc *cmd)
 {
@@ -2947,7 +2964,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	struct ixgbe_fdir_filter *input;
 	union ixgbe_atr_input mask;
 	u8 queue;
-	int err;
+	int err = -EINVAL;
 
 	if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
 		return -EOPNOTSUPP;
@@ -3050,6 +3067,12 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	/* apply mask and compute/store hash */
 	ixgbe_atr_compute_perfect_hash_82599(&input->filter, &mask);
 
+	/* check for a duplicate filter */
+	if (ixgbe_match_ethtool_fdir_entry(adapter, input)) {
+		err = -EEXIST;
+		goto err_out_w_lock;
+	}
+
 	/* program filters to filter memory */
 	err = ixgbe_fdir_write_perfect_filter_82599(hw,
 				&input->filter, input->sw_idx, queue);
@@ -3065,7 +3088,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	spin_unlock(&adapter->fdir_perfect_lock);
 err_out:
 	kfree(input);
-	return -EINVAL;
+	return err;
 }
 
 static int ixgbe_del_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
-- 
2.52.0

