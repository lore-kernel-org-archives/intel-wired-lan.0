Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93EFC5DF89
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 13:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 893C7408D0;
	Fri, 21 Aug 2026 13:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3qQ0BJ_Hjat; Fri, 21 Aug 2026 13:02:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787317324;
	bh=skTjB8mEPsFu/eWt4SZjuMtXPfGi7lnzVZijU3AJpn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iyY+uc9atKSNR1FvaWZ2dOBOZAPfL8kBsHRJwfwBUJ96mOIqaYd+19r2nLlp+d7XG
	 7OUgnINrhETWaFdnD/MXDPwLlRQ4cF1g1UC7whRn0spKloKCSI7GXnMWAwjbWH67bi
	 UJUswynVLJEOdf5GUe1Y05DIIIjtZ1IV4cxtZqfbdzpDjeW2gpnEnfr4j4pHkzVl0J
	 KhQTyxN4FVW/ngFtJB/eKKCQIeutHYyuOvQUMPUVfm5gisQobOG5fonK/a0iW9ETbX
	 3goSppk9JNDQ5iV9bIv4D9PJTv+4SzxHOwKudtnS5dfhccq2jkrGAMemH8d2GKb4jZ
	 phrq9eyEsAA+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2F0240962;
	Fri, 21 Aug 2026 13:02:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A41C476
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 13:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C74D405EB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 13:02:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L4aOZcNVdTKL for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 13:02:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IBQQC/+0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80049408D0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787317323; x=1818853323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JKIcziNhAUpSVSzm0+hRdhTzDAr9AXuGrCwRbtKX0qo=;
 b=IBQQC/+0Hrs3EpqhY+/YzlnwALbOEyhlH08HH6J8PfhaX8AxlUwRaK3t
 KZG6QzyEm+WYfxYiJng2KxHeJEouIABYc22RNf/5zUMwQg4ujHBr5xs9u
 GSKTxfpJnN7HTzsuEZ0hfK5LFL8BDaIwFEiwuuVG0Pa3Y7A3xzPx92bkf
 srkXs3iwymTumO6067BGVkNFBpQQ17ZfLlxLbvG1Z9ZTIgMD8ZdAuK1Iq
 mQeyQB8V2iN7SZrWwRVyWQWeGtL6cff3/+OpJfe37l0lZQ71FJqweAeas
 TotPiqOmhIVAUG1mbWsfXmnFe+gZC3vL8nLIhK6KKvbfTCcM8wPHd/kaz Q==;
X-CSE-ConnectionGUID: +Pu4KAuyQA2khyRdVoNvLw==
X-CSE-MsgGUID: BVrIN175QkSNKmcxhuoVAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="75400967"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="75400967"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 06:02:02 -0700
X-CSE-ConnectionGUID: vAvfO6yqToSF0Yjs1CIUiw==
X-CSE-MsgGUID: A+qg4UzYTOCt/UC7J9vj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="271568496"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2026 06:02:00 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2 1/2] i40e: fix set_ringparam error path freeing
 live Tx rings
Date: Fri, 21 Aug 2026 15:01:56 +0200
Message-ID: <20260821130157.1451118-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
References: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
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

The free_tx: error label in i40e_set_ringparam() is supposed to release
the temporary tx_rings[] array built before i40e_down() is called.
Instead it passes vsi->tx_rings[i] to i40e_free_tx_resources() - a
pointer to the live, NAPI-active ring - rather than &tx_rings[i].

i40e_free_tx_resources() unconditionally NULLs out ring->desc and
ring->tx_bi.  Because i40e_down() has not run at this point, NAPI is
still scheduled and the next i40e_clean_tx_irq() call hits a NULL
descriptor pointer:

    BUG: unable to handle page fault for address: 0000000000002000
    RIP: i40e_napi_poll (i40e_txrx.c:942 i40e_txrx.c:2769)
    RAX: 0000000000000000  RBX: ffff8d0a53ea9800

The trigger is ethtool -G with a TX descriptor count change (so
tx_rings[] is allocated) followed by i40e_alloc_rx_buffers() returning
failure, e.g. under memory pressure.

Pass &tx_rings[i] instead so the temporary rings' DMA descriptors and
software buffer arrays are freed, leaving the live VSI rings intact.

Reproduced on real hardware (XL710/XXV710) by forcing the Rx alloc
failure deterministically instead of relying on real memory pressure;
confirmed the box hangs without this fix and runs clean with it,
including repeated ring resizes and normal (non-error) resize paths.

Verified via git blame that commit 74608d17fe29 ("i40e: add support
for XDP_TX action") introduced the incorrect vsi->tx_rings[i] pointer
at this call site.

Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
Cc: stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2: No functional change to the fix itself. During review, a related
    but distinct pre-existing hazard was pointed out: freeing a
    temporary tx_rings[] clone with i40e_free_tx_resources() also
    resets BQL/dql state for the live queue it was cloned from
    (i40e_clean_tx_ring() -> netdev_tx_reset_queue()), since the
    clone keeps the same ring->netdev/queue_index. That hazard
    predates this bug (Fixes: 9f65e15b4f98, 2013) and is also
    reachable from the i40e_setup_tx_descriptors() failure path
    that this patch does not touch, so it is fixed separately in
    patch 2/2 of this series rather than folded in here.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3da9ec4..6d2b076 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if (tx_rings) {
 		for (i = 0; i < tx_alloc_queue_pairs; i++) {
 			if (i40e_active_tx_ring_index(vsi, i))
-				i40e_free_tx_resources(vsi->tx_rings[i]);
+				i40e_free_tx_resources(&tx_rings[i]);
 		}
 		kfree(tx_rings);
 		tx_rings = NULL;
-- 
2.52.0
