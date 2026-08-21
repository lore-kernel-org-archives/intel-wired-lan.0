Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700F6C5DF93
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 13:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20F3F60A60;
	Fri, 21 Aug 2026 13:02:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Pp0K5xJ3JMS; Fri, 21 Aug 2026 13:02:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787317326;
	bh=Jyz++XTiuYL5gPFusIQzrAu0kxHzxuD5pt3F26V1wm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4xraEYjz7pXWS3VmnHeffHLtppK4qh/+psS6eZl8wPFP+RT9IdSRgFjiN/y7Q1a1M
	 S7EXpuYVDseh1CsAEnlJePbEhn9guaBJ1sdTzG1Ba+IhoWTouiafZfBwpoowgV7ebI
	 lSWESVyFc7igQBXbViAsd8MpIcY1avSY/QYiRXx2x0guQsVDpjrgaKzNnWFXzAb1jv
	 IYSqVfv4Wd3InaLvOpmbW+kGgl3zZXljK14PBvnem+jWkyzKYD08XlJGe9eY4awh9S
	 91wi6kBakHW4GnmPVha9K6hVuKIPUNz+mlO9/RCj13Wbe30JWP8FmkcrFa16jBm2F9
	 VRtyC7fqhS/5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB30160A51;
	Fri, 21 Aug 2026 13:02:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DC05EA3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 13:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F0B340984
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 13:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pm-ftRIpzrqj for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 13:02:04 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=egMfwezL
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F07D405EB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 13:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787317325; x=1818853325;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/Kg4fShpoVUcUgg5AO18lGQL4ky1Jj9dnSBMcNpbOMg=;
 b=egMfwezL8GeD/LRA0ll/P0kf0pPBwVK+gy1DxntR8/Ek5fhBSrcVBgoc
 uXSza2qRsb0Et6sVoS0APgW9O1FIhLfcU+EBCp0+3ChscvW2lKni812c2
 OK/bMoLFVdcaPj2vadDUsnzagxgM90pkV/0WJEp7lWED01vNKHmnher0/
 bjrOGlQkkESAXAMyE6zZjDKPFCLGEaemkjsm6qYZTF6LFKqTc+F04gSnP
 lkZ1M1u1RX3siiQNDMvvIpHdOGXhY3IFIcjv/fmsjY6uBXDL50n+cB77h
 4VVyvziDKL3fN0jdmnoLro4jKFvyQKIWT9yrvU8XPDoAVKfmIYMxBZaZw A==;
X-CSE-ConnectionGUID: nRFSyZCtQbqZw9w73M8Z9w==
X-CSE-MsgGUID: YBMFYcOwSqWoQtpEVd6CrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="75400971"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="75400971"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 06:02:04 -0700
X-CSE-ConnectionGUID: IcVdrkDdQsWJh7adZEEzag==
X-CSE-MsgGUID: dF42Ex6CRC6dDruG9TFAwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="271568507"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2026 06:02:02 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2 2/2] i40e: avoid resetting BQL state when freeing
 temporary Tx rings in set_ringparam
Date: Fri, 21 Aug 2026 15:01:57 +0200
Message-ID: <20260821130157.1451118-3-aleksandr.loktionov@intel.com>
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

Temporary Tx rings built by i40e_set_ringparam() while resizing
descriptor counts are shallow struct copies of the live vsi->tx_rings[]
entries, so they retain the same ring->netdev and ring->queue_index as
the live ring they are staged to replace.

If an error path frees one of these clones with
i40e_free_tx_resources() before i40e_down() has run - either the
i40e_setup_tx_descriptors() failure unwind loop, or the free_tx: error
label - i40e_clean_tx_ring() will call netdev_tx_reset_queue() on
txring_txq(tx_ring), which resolves to the *same* netdev_queue as the
live ring because netdev/queue_index alias. That call resets the
queue's BQL/dql state (dql_reset(): num_queued = num_completed = 0)
while the live ring is still actively transmitting and completing
Tx on that same queue.

The next time the live ring reports completions for bytes that were
queued before the reset, dql_completed() can underflow its own
sanity check and hit:

	BUG_ON(count > num_queued - dql->num_completed);

i.e. a guaranteed kernel panic, not just a warning, given a queue with
outstanding (queued but not yet completed) Tx traffic at the moment
the clone is freed.

Reproduced on real hardware by forcing i40e_setup_tx_descriptors() to
fail partway through building tx_rings[] while flooding real Tx
traffic on the affected queues:

    kernel BUG at lib/dynamic_queue_limits.c:99!
    RIP: 0010:dql_completed+0x285/0x2a0
    Call Trace:
     <IRQ>
     i40e_napi_poll+0x74b/0x1700 [i40e]
     __napi_poll+0x10a/0x200
     net_rx_action+0x2f7/0x380
     handle_softirqs+0xcc/0x270

Confirmed the same trigger no longer panics with this fix applied,
including repeated resize/traffic cycles.

Clear the clone ring netdev before freeing it in both error paths, so
i40e_clean_tx_ring()'s existing `if (!tx_ring->netdev) return;` guard
skips the netdev_tx_reset_queue() call for the clone. This mirrors the
same idiom i40e already uses for XDP Tx rings, which also have no
netdev_queue of their own (ring->netdev = NULL in i40e_vsi_setup_tx()).
Only the temporary, about-to-be-freed clone is touched; the live ring
in vsi->tx_rings[] keeps its netdev.

Fixes: 9f65e15b4f98 ("i40e: Move rings from pointer to array to array of pointers")
Cc: stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2: New patch, split out of the set_ringparam NULL-deref fix (1/2)
    after review pointed out this related but distinct, older,
    pre-existing hazard on the same error path. Trimmed the inline
    comments to one line each.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 6d2b076..0e5b456 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2143,6 +2143,8 @@ static int i40e_set_ringparam(struct net_device *netdev,
 					i--;
 					if (!i40e_active_tx_ring_index(vsi, i))
 						continue;
+					/* not live yet, skip its BQL reset on free */
+					tx_rings[i].netdev = NULL;
 					i40e_free_tx_resources(&tx_rings[i]);
 				}
 				kfree(tx_rings);
@@ -2248,8 +2250,11 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	/* error cleanup if the Rx allocations failed after getting Tx */
 	if (tx_rings) {
 		for (i = 0; i < tx_alloc_queue_pairs; i++) {
-			if (i40e_active_tx_ring_index(vsi, i))
-				i40e_free_tx_resources(&tx_rings[i]);
+			if (i40e_active_tx_ring_index(vsi, i)) {
+				/* not live yet, skip its BQL reset on free */
+				tx_rings[i].netdev = NULL;
+				i40e_free_tx_resources(&tx_rings[i]);
+			}
 		}
 		kfree(tx_rings);
 		tx_rings = NULL;
-- 
2.52.0
