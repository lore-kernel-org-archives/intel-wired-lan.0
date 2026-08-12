Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17751C5CFEB
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 21:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD064408A5;
	Wed, 12 Aug 2026 21:07:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id acMB4WiZ4ULu; Wed, 12 Aug 2026 21:07:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06AA740898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786568870;
	bh=JuOf7IuNKd7wjSTvvt25ebJBaxMf4VOX5lsUT+nXJ7E=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9vGmmcBd+B8ZqR+2F4eeYcbl2EDsPA93OTS7wna7FwpyBp3GFByvu3G5qhXZylUEV
	 kIhNN5Ihmd9Lmi1x2mMnjDBUpJAONm7LfvDVwdFNsA4BM6F1mMsuw/q75qkaNItQTz
	 ZyiQaU8fhTnoBKt4mnMZT2YyFTSKZ29fNzTmdbtrOiNZs1H+1wO9yA/9niAVuiZaJr
	 pS2zyhvjL3POGFrYPkqMAdI26Ft1lbyBV30JWhsz6MgK4SCbODz2imix+B+Hy9/Qpi
	 RQ97YyDywvsTz6zwg2DdUxQjq50mWGEZ1B1WKFvvhzG0+1FiPY51BItrmKtDX2IsO8
	 WeiijbSCnPRkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06AA740898;
	Wed, 12 Aug 2026 21:07:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D60C01AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 21:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC3EE40219
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 21:07:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-OLXmuAiQxI for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 21:07:47 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 85D54401F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85D54401F6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85D54401F6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 21:07:47 +0000 (UTC)
X-CSE-ConnectionGUID: aozy1uxYQ1OzkdGevHv/tg==
X-CSE-MsgGUID: Z2OEOdJzQxaK+VAF8YjpYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98652120"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="98652120"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 14:07:47 -0700
X-CSE-ConnectionGUID: bE1zNE4zTd2wK7GOP+MmFA==
X-CSE-MsgGUID: 2f3WwXyxQhulyXjRltS8yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="261985768"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa006.jf.intel.com with ESMTP; 12 Aug 2026 14:07:43 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 1B098332AB;
 Wed, 12 Aug 2026 22:07:42 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Date: Wed, 12 Aug 2026 22:18:06 +0200
Message-ID: <20260812204619.32253-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
References: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786568867; x=1818104867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TlU+92zmt63PGW7E7n89WAMKNhmHnj6HIDhWPk+cF44=;
 b=E1Sr35WOaAfLTi6DwaY87y+QjpFCAuTzjPCB66HbEUp9JXHf6A/Lk6Uv
 85pICCbi+Rp9kvnCo94PaE5RhBHblS13NOQWCsaD5GgoadE6H2DaYHK/R
 nKrdPQEYingHQLi41HChqg7TZXaISd8TzayktrLVcc8HHBWuR7K23jpFy
 GK7TvCZA0ObVXbNM5pwyGuw19d4/TPKQWfUYCWvRG1nzGqQZqX81y2Scf
 S5DvPlKX0Is3fI16Zd5EOTSupAqj1zHMecncrZymJbieGGziQqCw6ZgwS
 816AVxpRRiYz7IDm1S73Owuy8o3jSY4vTceVR7w3Hd/LGPML0nU16gx71
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E1Sr35WO
Subject: [Intel-wired-lan] [PATCH net v2 2/2] ice: fix stats array overflow
 via proper realloc
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Integrate ice_vsi_alloc_stat_arrays() with realloc variant.

Instead of keeping two functions for stat arrays allocation, change the
ice_vsi_realloc_stat_arrays() to handle initial condition (no vsi_stat
entry) and replace ice_vsi_alloc_stat_arrays() by the more generic
ice_vsi_realloc_stat_arrays().

Note that VSIs of ICE_VSI_CHNL type are ignored in realloc variant as they
were in the replaced ice_vsi_alloc_stat_arrays().

This is a fix for stats array overflow that occurs when VF is given more
queues (an operation that will be more frequent, and by bigger increase,
when we will merge my "XLVF" series).

Apply minor refactoring inside ice_vsi_realloc_stat_arrays() to avoid
mixing req/alloc variables used in different user paths. Also drop one
callsite to avoid some duplication.

Splat for increasing number of queues thanks to Michal Schmidt:
KASAN detects the bug:
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
 Read of size 8 at addr ffff88810affea60 by task kworker/u131:7/221

 CPU: 24 UID: 0 PID: 221 Comm: kworker/u131:7 Not tainted 7.1.0-rc1+ #1 PREEMPT(lazy)
 ...
 Workqueue: ice ice_service_task [ice]
 Call Trace:
  <TASK>
  ...
  kasan_report+0xd7/0x120
  ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
  ice_vsi_cfg_def+0x12e2/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_reset_vf+0x858/0xf80 [ice]
  ice_vc_request_qs_msg+0x1da/0x290 [ice]
  ice_vc_process_vf_msg+0xb15/0x1430 [ice]
  __ice_clean_ctrlq+0x70d/0x9d0 [ice]
  ice_service_task+0x840/0xf20 [ice]
  process_one_work+0x690/0xff0
  worker_thread+0x4d9/0xd20
  kthread+0x322/0x410
  ret_from_fork+0x332/0x660
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 Allocated by task 2439:
  kasan_save_stack+0x1c/0x40
  kasan_save_track+0x10/0x30
  __kasan_kmalloc+0x96/0xb0
  __kmalloc_noprof+0x1d8/0x580
  ice_vsi_cfg_def+0x115c/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_vsi_setup+0x180/0x320 [ice]
  ice_start_vfs+0x1f3/0x590 [ice]
  ice_ena_vfs+0x66d/0x798 [ice]
  ice_sriov_configure.cold+0xe4/0x121 [ice]
  sriov_numvfs_store+0x279/0x480
  kernfs_fop_write_iter+0x331/0x4f0
  vfs_write+0x4c4/0xe40
  ksys_write+0x10c/0x240
  do_syscall_64+0xd9/0x650
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 The buggy address belongs to the object at ffff88810affea40
                which belongs to the cache kmalloc-32 of size 32
 The buggy address is located 0 bytes to the right of
                allocated 32-byte region [ffff88810affea40, ffff88810affea60)

Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Closes: https://redhat.atlassian.net/browse/RHEL-164321
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
This is an alternative to the fix [1] by Michal Schmidt, which were
blocked due to AI feedback. My fix was already developed before Michal's,
just not public back then. We have agreed to go on with my version.

[1] https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com

v0 - previous "Intel Wired LAN pull request":
https://lore.kernel.org/netdev/20260804222205.1580328-7-anthony.l.nguyen@intel.com

v1 changes:
 (Sashiko):
  * refactor the function and usage in terms of req_tx/alloc_tx, to avoid
    bounding by different variable for different user-paths (ditto for
    *rx) - also consolidate to only one callsite
  * collect missing tags from IWL v3
---
 drivers/net/ethernet/intel/ice/ice.h     |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.c | 100 ++++++++---------------
 2 files changed, 37 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fc91b6665f90..83da5ba6eeb1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -328,6 +328,8 @@ enum ice_vsi_state {
 struct ice_vsi_stats {
 	struct ice_ring_stats **tx_ring_stats;  /* Tx ring stats array */
 	struct ice_ring_stats **rx_ring_stats;  /* Rx ring stats array */
+	u16 tx_ring_stats_len;
+	u16 rx_ring_stats_len;
 };
 
 /* struct that defines a VSI, associated with a dev */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e48ee5940f17..420e72df7f5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -338,7 +338,6 @@ static void ice_vsi_free_stats(struct ice_vsi *vsi)
 {
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
-	int i;
 
 	if (vsi->type == ICE_VSI_CHNL)
 		return;
@@ -349,14 +348,14 @@ static void ice_vsi_free_stats(struct ice_vsi *vsi)
 	if (!vsi_stat)
 		return;
 
-	ice_for_each_alloc_txq(vsi, i) {
+	for (int i = 0; i < vsi_stat->tx_ring_stats_len; i++) {
 		if (vsi_stat->tx_ring_stats[i]) {
 			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
 			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
 		}
 	}
 
-	ice_for_each_alloc_rxq(vsi, i) {
+	for (int i = 0; i < vsi_stat->rx_ring_stats_len; i++) {
 		if (vsi_stat->rx_ring_stats[i]) {
 			kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
 			WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
@@ -513,51 +512,6 @@ static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/**
- * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
- * @vsi: VSI pointer
- */
-static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
-{
-	struct ice_vsi_stats *vsi_stat;
-	struct ice_pf *pf = vsi->back;
-
-	if (vsi->type == ICE_VSI_CHNL)
-		return 0;
-	if (!pf->vsi_stats)
-		return -ENOENT;
-
-	if (pf->vsi_stats[vsi->idx])
-	/* realloc will happen in rebuild path */
-		return 0;
-
-	vsi_stat = kzalloc_obj(*vsi_stat);
-	if (!vsi_stat)
-		return -ENOMEM;
-
-	vsi_stat->tx_ring_stats =
-		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
-	if (!vsi_stat->tx_ring_stats)
-		goto err_alloc_tx;
-
-	vsi_stat->rx_ring_stats =
-		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
-	if (!vsi_stat->rx_ring_stats)
-		goto err_alloc_rx;
-
-	pf->vsi_stats[vsi->idx] = vsi_stat;
-
-	return 0;
-
-err_alloc_rx:
-	kfree(vsi_stat->rx_ring_stats);
-err_alloc_tx:
-	kfree(vsi_stat->tx_ring_stats);
-	kfree(vsi_stat);
-	pf->vsi_stats[vsi->idx] = NULL;
-	return -ENOMEM;
-}
-
 /**
  * ice_vsi_alloc_def - set default values for already allocated VSI
  * @vsi: ptr to VSI
@@ -2310,56 +2264,76 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
  */
 static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 {
-	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
-	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
 	struct ice_ring_stats **tx_ring_stats;
 	struct ice_ring_stats **rx_ring_stats;
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
-	u16 prev_txq = vsi->alloc_txq;
-	u16 prev_rxq = vsi->alloc_rxq;
+	u16 new_txq = vsi->alloc_txq;
+	u16 new_rxq = vsi->alloc_rxq;
+	u16 prev_txq, prev_rxq;
+
+	if (vsi->type == ICE_VSI_CHNL)
+		return 0;
 
 	vsi_stat = pf->vsi_stats[vsi->idx];
+	if (!vsi_stat) {
+		vsi_stat = kzalloc_obj(*vsi_stat);
+		if (!vsi_stat)
+			return -ENOMEM;
+	}
 
-	if (req_txq < prev_txq) {
-		for (int i = req_txq; i < prev_txq; i++) {
+	prev_txq = vsi_stat->tx_ring_stats_len;
+	if (new_txq < prev_txq) {
+		for (int i = new_txq; i < prev_txq; i++) {
 			if (vsi_stat->tx_ring_stats[i]) {
 				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
 				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
 			}
 		}
 	}
 
 	tx_ring_stats = vsi_stat->tx_ring_stats;
 	vsi_stat->tx_ring_stats =
-		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
+		krealloc_array(vsi_stat->tx_ring_stats, new_txq,
 			       sizeof(*vsi_stat->tx_ring_stats),
 			       GFP_KERNEL | __GFP_ZERO);
 	if (!vsi_stat->tx_ring_stats) {
 		vsi_stat->tx_ring_stats = tx_ring_stats;
-		return -ENOMEM;
+		goto err_free_partial_vsi_stat;
 	}
+	vsi_stat->tx_ring_stats_len = new_txq;
 
-	if (req_rxq < prev_rxq) {
-		for (int i = req_rxq; i < prev_rxq; i++) {
+	prev_rxq = vsi_stat->rx_ring_stats_len;
+	if (new_rxq < prev_rxq) {
+		for (int i = new_rxq; i < prev_rxq; i++) {
 			if (vsi_stat->rx_ring_stats[i]) {
 				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
 				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
 			}
 		}
 	}
 
 	rx_ring_stats = vsi_stat->rx_ring_stats;
 	vsi_stat->rx_ring_stats =
-		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
+		krealloc_array(vsi_stat->rx_ring_stats, new_rxq,
 			       sizeof(*vsi_stat->rx_ring_stats),
 			       GFP_KERNEL | __GFP_ZERO);
 	if (!vsi_stat->rx_ring_stats) {
 		vsi_stat->rx_ring_stats = rx_ring_stats;
-		return -ENOMEM;
+		goto err_free_partial_vsi_stat;
 	}
+	vsi_stat->rx_ring_stats_len = new_rxq;
 
+	pf->vsi_stats[vsi->idx] = vsi_stat;
 	return 0;
+
+err_free_partial_vsi_stat:
+	if (!pf->vsi_stats[vsi->idx]) {
+		/* vsi_stat was not visible before current alloc attempt */
+		kfree(vsi_stat->tx_ring_stats);
+		kfree(vsi_stat);
+	}
+	return -ENOMEM;
 }
 
 /**
@@ -2379,7 +2353,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		return ret;
 
 	/* allocate memory for Tx/Rx ring stat pointers */
-	ret = ice_vsi_alloc_stat_arrays(vsi);
+	ret = ice_vsi_realloc_stat_arrays(vsi);
 	if (ret)
 		goto unroll_vsi_alloc;
 
@@ -3097,10 +3071,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 
 	mutex_lock(&vsi->xdp_state_lock);
 
-	ret = ice_vsi_realloc_stat_arrays(vsi);
-	if (ret)
-		goto unlock;
-
 	ice_vsi_decfg(vsi);
 	ret = ice_vsi_cfg_def(vsi);
 	if (ret)
-- 
2.54.0

