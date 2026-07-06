Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17175C44500
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Jul 2026 23:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACD83407A2;
	Mon,  6 Jul 2026 23:03:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qgaA1O0pj353; Mon,  6 Jul 2026 23:03:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 744CC406E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783378980;
	bh=G5f+25hGd/5G5ZvbW2e/y0Wa2zZvaYWOwSJ03QnAHmc=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R8/n7DVYcYxXxgq2JMi+rIm0yzBylaqSte5hkw7BBos79JPmVMsJMsdf+kHOvwFbW
	 R/ZuqK7iKfl6l8t6qJX3xUwGJGJzLiI+RpdGezlG8rId3orkKkKbuolpLafLcgS9+J
	 mhGhY772G0nY/uN11bC/5YNNLhxo7sLCAGYr8sjoQ60GfA8wONRHd4rgnY7IenI1Sz
	 jCgmegkiCfgs6FIQsT89FiPO5G/H3tkgnECPzFjyEUf7dgHY5t3qUL9I3pQ7sJcznF
	 r1S8Zf5+uLoIvGtyfycDD4cTNfGZl04EMAXIOrixSsfJS8ndcuHAEtny8e8RgPXgF+
	 EQQHb939kzOSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 744CC406E0;
	Mon,  6 Jul 2026 23:03:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 070A533A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 23:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E115340072
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 23:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gRisV3CqwgrX for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Jul 2026 23:02:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EE36C40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE36C40025
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE36C40025
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 23:02:57 +0000 (UTC)
X-CSE-ConnectionGUID: 5eC90u3RRISW4+IkHf4BMQ==
X-CSE-MsgGUID: Nyjmh26rReuoB1pxueBhDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84071803"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; d="scan'208";a="84071803"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 16:02:57 -0700
X-CSE-ConnectionGUID: 8t+YtnOVQ6GmpL2Nyy4cng==
X-CSE-MsgGUID: mpX+D+ugSiug+NSEK3v3uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; d="scan'208";a="254482156"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa009.jf.intel.com with ESMTP; 06 Jul 2026 16:02:54 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 57DCE33BC0;
 Tue,  7 Jul 2026 00:02:52 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org, Michal Schmidt <mschmidt@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Tue,  7 Jul 2026 00:43:30 +0200
Message-ID: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783378978; x=1814914978;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oC8jt29NXkSPFD96mbTv5nD63+RCBk7CuQSSpqn2mJI=;
 b=kLY2pM6W+QVek1thV6mGNrl+WF/Qdf856ZxAgwODQQlk/a3KU84Ibhjg
 Vlf2efQEg2BfbKYxJoW/L0Rgz5r/znEr8LU8gPFUuuN8Zfk26ru2mNWWU
 qTgDLZ39NUY55W1zzxzJD49BLhUemmHPgnoysP7DE5MpDJS0xZLUbZdui
 sKeTv+DtH66g/XpjjIWR5N6ceq9S1UGLEFqU9lNuS1cvj0HPw5OUCOA23
 UxQNSclYk41RdJu/68vhx6iGDanoD4i1+X//79TNJUT8HAC4w3fMek68u
 Pa67Sc4GrPI8uoQ+B+IpQp9QnVuqPtB2LYcycYxhEzlDn9kfV6I+jL/jL
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kLY2pM6W
Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/2] ice: move
 ice_vsi_realloc_stat_arrays() up
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

Move ice_vsi_realloc_stat_arrays() up, to allow calling it from
ice_vsi_cfg_def() by the next commit.

Fix kdoc for touched code. One line break removed, "int i" scope
minimized to the loop, no changes otherwise.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2: no changes
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 119 +++++++++++------------
 1 file changed, 59 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdc4fda89e9..e48ee5940f17 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2303,6 +2303,65 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
 	return 0;
 }
 
+/**
+ * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
+ * @vsi: VSI pointer
+ * Return: 0 on success or -ENOMEM on allocation failure.
+ */
+static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
+{
+	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
+	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
+	struct ice_ring_stats **tx_ring_stats;
+	struct ice_ring_stats **rx_ring_stats;
+	struct ice_vsi_stats *vsi_stat;
+	struct ice_pf *pf = vsi->back;
+	u16 prev_txq = vsi->alloc_txq;
+	u16 prev_rxq = vsi->alloc_rxq;
+
+	vsi_stat = pf->vsi_stats[vsi->idx];
+
+	if (req_txq < prev_txq) {
+		for (int i = req_txq; i < prev_txq; i++) {
+			if (vsi_stat->tx_ring_stats[i]) {
+				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
+				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
+			}
+		}
+	}
+
+	tx_ring_stats = vsi_stat->tx_ring_stats;
+	vsi_stat->tx_ring_stats =
+		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
+			       sizeof(*vsi_stat->tx_ring_stats),
+			       GFP_KERNEL | __GFP_ZERO);
+	if (!vsi_stat->tx_ring_stats) {
+		vsi_stat->tx_ring_stats = tx_ring_stats;
+		return -ENOMEM;
+	}
+
+	if (req_rxq < prev_rxq) {
+		for (int i = req_rxq; i < prev_rxq; i++) {
+			if (vsi_stat->rx_ring_stats[i]) {
+				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
+				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
+			}
+		}
+	}
+
+	rx_ring_stats = vsi_stat->rx_ring_stats;
+	vsi_stat->rx_ring_stats =
+		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
+			       sizeof(*vsi_stat->rx_ring_stats),
+			       GFP_KERNEL | __GFP_ZERO);
+	if (!vsi_stat->rx_ring_stats) {
+		vsi_stat->rx_ring_stats = rx_ring_stats;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /**
  * ice_vsi_cfg_def - configure default VSI based on the type
  * @vsi: pointer to VSI
@@ -3011,66 +3070,6 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 	}
 }
 
-/**
- * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
- * @vsi: VSI pointer
- */
-static int
-ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
-{
-	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
-	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
-	struct ice_ring_stats **tx_ring_stats;
-	struct ice_ring_stats **rx_ring_stats;
-	struct ice_vsi_stats *vsi_stat;
-	struct ice_pf *pf = vsi->back;
-	u16 prev_txq = vsi->alloc_txq;
-	u16 prev_rxq = vsi->alloc_rxq;
-	int i;
-
-	vsi_stat = pf->vsi_stats[vsi->idx];
-
-	if (req_txq < prev_txq) {
-		for (i = req_txq; i < prev_txq; i++) {
-			if (vsi_stat->tx_ring_stats[i]) {
-				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
-				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
-			}
-		}
-	}
-
-	tx_ring_stats = vsi_stat->tx_ring_stats;
-	vsi_stat->tx_ring_stats =
-		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
-			       sizeof(*vsi_stat->tx_ring_stats),
-			       GFP_KERNEL | __GFP_ZERO);
-	if (!vsi_stat->tx_ring_stats) {
-		vsi_stat->tx_ring_stats = tx_ring_stats;
-		return -ENOMEM;
-	}
-
-	if (req_rxq < prev_rxq) {
-		for (i = req_rxq; i < prev_rxq; i++) {
-			if (vsi_stat->rx_ring_stats[i]) {
-				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
-				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
-			}
-		}
-	}
-
-	rx_ring_stats = vsi_stat->rx_ring_stats;
-	vsi_stat->rx_ring_stats =
-		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
-			       sizeof(*vsi_stat->rx_ring_stats),
-			       GFP_KERNEL | __GFP_ZERO);
-	if (!vsi_stat->rx_ring_stats) {
-		vsi_stat->rx_ring_stats = rx_ring_stats;
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
 /**
  * ice_vsi_rebuild - Rebuild VSI after reset
  * @vsi: VSI to be rebuild
-- 
2.54.0

