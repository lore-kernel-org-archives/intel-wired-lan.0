Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A1FEF9001
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Mar 2026 16:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 964E98137E;
	Wed,  4 Mar 2026 16:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c2koLSIKZOh2; Wed,  4 Mar 2026 16:36:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6D3F81364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772642176;
	bh=xH3Zmcd576nlLcKjE9auZk0MqMBeH8c5vtdU1xpyRXM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9kSoXI3xtmfMTD2v4k3O1viIjfxWbIAOWjtFBoqJ1zNjs5ryX7mjXKA6zVbSpYlM
	 aNXOxOBc0FYyz+DlsElY3q8hAERU/QJb8n7Kl1rOdLkdOBIVVJg8P8ZO5kwTXlaAvR
	 5NFcJi0km7744NaRF1BKxA88YNSWCnVXewPW894guMOeSz1Z9QTRMceiugWTkllmci
	 yARr8HjEVqKzeBH0decUxpfpbw8uSxCCwjFdH+VL69dKvXcxqupAm6Z55V9VJlp5l2
	 nwG+WhzGtA7GresAslhsiPZPYlZTwqCxG3BBV43B4f0Gr8tGTAwMiMapC8ix5IF5Sk
	 gVZQCp6/PFQwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6D3F81364;
	Wed,  4 Mar 2026 16:36:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C58E1EB
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 16:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 630E86086F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 16:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rR7IG4x08BL2 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Mar 2026 16:36:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 66F866086D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66F866086D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66F866086D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 16:36:14 +0000 (UTC)
X-CSE-ConnectionGUID: K3+g2riCRsOR3Q+gQmjF5w==
X-CSE-MsgGUID: 0nDMAuBTTmSFBUj1xyaA2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72906446"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="72906446"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 08:36:14 -0800
X-CSE-ConnectionGUID: bmMhBjZnRnaC4vLQ7HpYNw==
X-CSE-MsgGUID: xBt0cTI1Sr6BaAXFry3wFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="241405028"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 04 Mar 2026 08:36:10 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 2E7DE312CA;
 Wed,  4 Mar 2026 16:36:08 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Natalia Wochtman <natalia.wochtman@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed,  4 Mar 2026 17:03:41 +0100
Message-ID: <20260304160345.1340940-10-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304160345.1340940-1-larysa.zaremba@intel.com>
References: <20260304160345.1340940-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772642174; x=1804178174;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dFgFR9mD8Y+SNY8Jnfeggcz+/V/svBglT97OuTyNgW4=;
 b=V5jWMGhCTqDnkZ2PxQEQCbuJIpZ/FvWIg40KuU98QX3/K4re74nwj9gi
 WwPA/Ch+mdaq4SCGCuGOEObqxWDwGzTz0WTfOMhULJPXJwA4EzLjoqruS
 CT2nDBQa79rAmmtprXrc8clgSFA9JxH2cNUFZbjiRax4V72uJPuxjMnlj
 7i6OiU1MO0lR7OTzHySspKeLrP7E1QynDaFBeISywL3XnaCeruZ6xWx6B
 r3VI/pXRJxlc3LX7Vc1jEPUbxqmpraJ6Zm8h/snYg3MNl4Va48YYBYtnH
 00IucbzSVZigj0vBcvKH2jJ74mDFoxg0x2dX4D+H15mxwZFjWO1P2Hvo3
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=V5jWMGhC
Subject: [Intel-wired-lan] [PATCH iwl-next v3 09/10] ixgbevf: reconfigure
 page pool when reallocating buffers
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

Currently, when MTU is changed, page pool is not reconfigured, which leads
to usage of suboptimal buffer sizes.

Always destroy page pool when cleaning the ring up and create it anew when
we first allocate Rx buffers.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 69 +++++++++----------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d00d3b307a8f..196e51eb516a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1662,6 +1662,14 @@ static void ixgbevf_rx_destroy_pp(struct ixgbevf_ring *rx_ring)
 		.fqes	= rx_ring->rx_fqes,
 	};
 
+	if (!fq.pp)
+		return;
+
+	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq)) {
+		xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
+		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
+	}
+
 	libeth_rx_fq_destroy(&fq);
 	rx_ring->rx_fqes = NULL;
 	rx_ring->pp = NULL;
@@ -1712,6 +1720,14 @@ static int ixgbevf_rx_create_pp(struct ixgbevf_ring *rx_ring)
 	rx_ring->truesize = fq.truesize;
 	rx_ring->rx_buf_len = fq.buf_len;
 
+	/* XDP RX-queue info */
+	ret = __xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
+				 rx_ring->queue_index, 0, rx_ring->truesize);
+	if (ret)
+		goto err;
+
+	xdp_rxq_info_attach_page_pool(&rx_ring->xdp_rxq, rx_ring->pp);
+
 	if (!fq.hsplit)
 		return 0;
 
@@ -1781,6 +1797,8 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
 
+	ixgbevf_rx_create_pp(ring);
+
 	/* RXDCTL.RLPML does not work on 82599 */
 	if (adapter->hw.mac.type != ixgbe_mac_82599_vf) {
 		u32 pkt_len =
@@ -2273,8 +2291,10 @@ static void ixgbevf_clean_all_rx_rings(struct ixgbevf_adapter *adapter)
 {
 	int i;
 
-	for (i = 0; i < adapter->num_rx_queues; i++)
+	for (i = 0; i < adapter->num_rx_queues; i++) {
 		ixgbevf_clean_rx_ring(adapter->rx_ring[i]);
+		ixgbevf_rx_destroy_pp(adapter->rx_ring[i]);
+	}
 }
 
 /**
@@ -3295,6 +3315,11 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 	return err;
 }
 
+static struct device *ixgbevf_dma_dev_from_ring(struct ixgbevf_ring *ring)
+{
+	return &ring->q_vector->adapter->pdev->dev;
+}
+
 /**
  * ixgbevf_setup_rx_resources - allocate Rx resources
  * @adapter: board private structure
@@ -3305,43 +3330,25 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
 			       struct ixgbevf_ring *rx_ring)
 {
-	int ret;
-
-	ret = ixgbevf_rx_create_pp(rx_ring);
-	if (ret)
-		return ret;
-
 	u64_stats_init(&rx_ring->syncp);
 
 	/* Round up to nearest 4K */
 	rx_ring->dma_size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
 	rx_ring->dma_size = ALIGN(rx_ring->dma_size, 4096);
 
-	rx_ring->desc = dma_alloc_coherent(rx_ring->pp->p.dev,
+	rx_ring->desc = dma_alloc_coherent(ixgbevf_dma_dev_from_ring(rx_ring),
 					   rx_ring->dma_size,
 					   &rx_ring->dma, GFP_KERNEL);
 
 	if (!rx_ring->desc) {
-		ret = -ENOMEM;
-		goto err;
+		dev_err(rx_ring->dev,
+			"Unable to allocate memory for the Rx descriptor ring\n");
+		return -ENOMEM;
 	}
 
-	/* XDP RX-queue info */
-	ret = __xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
-				 rx_ring->queue_index, 0, rx_ring->truesize);
-	if (ret)
-		goto err;
-
-	xdp_rxq_info_attach_page_pool(&rx_ring->xdp_rxq, rx_ring->pp);
-
 	rx_ring->xdp_prog = adapter->xdp_prog;
 
 	return 0;
-err:
-	ixgbevf_rx_destroy_pp(rx_ring);
-	dev_err(rx_ring->dev, "Unable to allocate memory for the Rx descriptor ring\n");
-
-	return ret;
 }
 
 /**
@@ -3382,24 +3389,14 @@ static int ixgbevf_setup_all_rx_resources(struct ixgbevf_adapter *adapter)
  **/
 void ixgbevf_free_rx_resources(struct ixgbevf_ring *rx_ring)
 {
-	struct libeth_fq fq = {
-		.fqes	= rx_ring->rx_fqes,
-		.pp	= rx_ring->pp,
-	};
-
 	ixgbevf_clean_rx_ring(rx_ring);
-
+	ixgbevf_rx_destroy_pp(rx_ring);
 	rx_ring->xdp_prog = NULL;
-	xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
-	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 
-	dma_free_coherent(fq.pp->p.dev, rx_ring->dma_size, rx_ring->desc,
+	dma_free_coherent(ixgbevf_dma_dev_from_ring(rx_ring),
+			  rx_ring->dma_size, rx_ring->desc,
 			  rx_ring->dma);
 	rx_ring->desc = NULL;
-
-	libeth_rx_fq_destroy(&fq);
-	rx_ring->rx_fqes = NULL;
-	rx_ring->pp = NULL;
 }
 
 /**
-- 
2.52.0

