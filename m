Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877F2C43334
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 Jul 2022 16:11:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02D274162D;
	Thu,  7 Jul 2022 16:11:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02D274162D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657210301;
	bh=0PigCmtxUz8spDtSjUcTHH13d21x1rBJ9E01jkQTsp0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=HBj3DDcjI02SyKNsssP2xel5JcvjAYALRrnDlKvt3cApRW2qt7vLn/EMYlxwxfP8y
	 +fjiFSweD26lxrpCULzQC7nf1M+mWGRCwbNwFkCuZ9r4uTHmrUKQMWV0uMUb7i6WBQ
	 2u/ZIjAXkmy8HE0J4SCxa0Yfpd8uuXK8dDuO4Ecb8CFWm9TDVCYHMEkYnCmWe0UCVR
	 B+yOzpVxjkp7NXBQ25vep8dNpsXaX/GBMV8M5CRsBr+zK+tsqX9SjJq0egacGz+STK
	 +bzl8JC/lHggPZHJT9LL/zt2qP2tPa371OVUX0uiqJKejWu8+J3USG3wnqc97NJGyN
	 Y3sFevsRD6qBg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rHUJpcjtUSc8; Thu,  7 Jul 2022 16:11:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7D8341A24;
	Thu,  7 Jul 2022 16:11:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7D8341A24
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 1BA631BF2A3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Jul 2022 16:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2E8A61263
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Jul 2022 16:11:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2E8A61263
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1xuD1EEMr6U3 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 Jul 2022 16:11:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 306AB60B0B
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 306AB60B0B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Jul 2022 16:11:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="348045859"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; d="scan'208";a="348045859"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 09:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; d="scan'208";a="839971579"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2022 09:11:34 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  7 Jul 2022 18:11:28 +0200
Message-Id: <20220707161128.54215-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657210295; x=1688746295;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vesXtGlDmOsjMCJXAf5YAftKju8+FHR1Lh+U8lCzIoU=;
 b=HV7FWh4UMas0aqfCPYyKNaG4817o0QFvWQHOJUfBBBthaBJ8uJPpioUz
 18Fqnk+PCZrwRgz8tbryBiwomGbz866olBY9kTSIQt0YtoqMwbQRWgQMC
 uPlF1IYGJ3p7GP3Apm/4T5BwZpB+vHs+G47Z1H3ref3vEyANzndPfxKUu
 tjhdLU27gnDpMKGrJ0lKH+B5hfoGzC9st20cbNINM+yKOjmRrbIgoOUad
 nduDW/VzSkol58eTZGzvej887Skm/9LtV78Bhk9LGPzQ51MtKYmTli+Je
 Mfrzn34sDtUraGoM6/kNP8sQ5xRudGpov5oa5c+dgPHRzXAOlGo0hKtjt
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HV7FWh4U
Subject: [Intel-wired-lan] [PATCH intel-net] ice: xsk: use Rx ring when
 picking NAPI context
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
Cc: netdev@vger.kernel.org, kuba@kernel.org, bpf@vger.kernel.org,
 davem@davemloft.net, magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Ice driver allocates per cpu XDP queues so that redirect path can safely
use smp_processor_id() as an index to the array. At the same time
though, XDP rings are used to pick NAPI context to call napi_schedule()
or set NAPIF_STATE_MISSED. When user reduces queue count, say to 8, and
num_possible_cpus() of underlying platform is 44, then this means queue
vectors with correlated NAPI contexts will carry several XDP queues.

This in turn can result in a broken behavior where NAPI context of
interest will never be scheduled and AF_XDP socket will not process any
traffic.

To fix this issue, use Rx ring to pull out the NAPI context.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Fixes: 22bf877e528f ("ice: introduce XDP_TX fallback path")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 49ba8bfdbf04..34d851d3e767 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -353,7 +353,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 	if (if_running) {
 		ret = ice_qp_ena(vsi, qid);
 		if (!ret && pool_present)
-			napi_schedule(&vsi->xdp_rings[qid]->q_vector->napi);
+			napi_schedule(&vsi->rx_rings[qid]->q_vector->napi);
 		else if (ret)
 			netdev_err(vsi->netdev, "ice_qp_ena error = %d\n", ret);
 	}
@@ -936,7 +936,7 @@ ice_xsk_wakeup(struct net_device *netdev, u32 queue_id,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_q_vector *q_vector;
 	struct ice_vsi *vsi = np->vsi;
-	struct ice_tx_ring *ring;
+	struct ice_rx_ring *ring;
 
 	if (test_bit(ICE_VSI_DOWN, vsi->state))
 		return -ENETDOWN;
@@ -944,13 +944,13 @@ ice_xsk_wakeup(struct net_device *netdev, u32 queue_id,
 	if (!ice_is_xdp_ena_vsi(vsi))
 		return -EINVAL;
 
-	if (queue_id >= vsi->num_txq)
+	if (queue_id >= vsi->num_txq || queue_id >= vsi->num_rxq)
 		return -EINVAL;
 
 	if (!vsi->xdp_rings[queue_id]->xsk_pool)
 		return -EINVAL;
 
-	ring = vsi->xdp_rings[queue_id];
+	ring = vsi->rx_rings[queue_id];
 
 	/* The idea here is that if NAPI is running, mark a miss, so
 	 * it will run again. If not, trigger an interrupt and
-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
