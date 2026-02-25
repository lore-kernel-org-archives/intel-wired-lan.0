Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483E0FD377E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Feb 2026 18:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A9FC61576;
	Wed, 25 Feb 2026 18:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fU4UUP3lUY5j; Wed, 25 Feb 2026 18:17:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42AED615A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772043466;
	bh=VGgH+E2rYS9YUPEnggRIlaf6ZdXh+lYdW2JNES7RrrY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qXPKnKzZ1v5unrCIVsiMV3HDIIAHbFjwCG5qTaZOVEaxO71yguzE0tCj+DLWLRxBq
	 hHUoR5dTZxUSYiM28HvgXfqmaUNcaps21MMYu4e6aMNWDqZJ/HHtyWupyxuQGlafRP
	 xSmM0vD0tnIx4zrOzatMsDjxJHFqr5jaiN2Cr29zAsUhG+RBEkOuQ15xQMxPZj6lN0
	 VQcEYuGkAIrQHSx2VFOX5A8vZzHiHadn4TeiJHGrh0JYO94p5J9bi2O9Rjc7vh3+KJ
	 hqK+OLdivVqPCEsuPrsy5NDK1z0T3AQOkP48AWg0zvcahvpioqc8VGQpZj8X+iSdtk
	 0HDTFIcXOewWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42AED615A1;
	Wed, 25 Feb 2026 18:17:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14BBB23D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 18:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEFDA41F52
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 18:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AgdtNvO2uKfv for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Feb 2026 18:17:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F3FFA41F4C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3FFA41F4C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3FFA41F4C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 18:17:43 +0000 (UTC)
X-CSE-ConnectionGUID: ZqVYa3e6TQe0Bg+4da6fFw==
X-CSE-MsgGUID: eVliVUNSQcm8Gd4HEW2bzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="76928017"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="76928017"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 10:17:42 -0800
X-CSE-ConnectionGUID: pCow/N1CRd+XulMm3wlecg==
X-CSE-MsgGUID: UJLpy17/T0Culv0nZQa+Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="216337830"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa008.jf.intel.com with ESMTP; 25 Feb 2026 10:17:39 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 7DD5D32C86;
 Wed, 25 Feb 2026 18:17:37 +0000 (GMT)
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
Date: Wed, 25 Feb 2026 18:46:43 +0100
Message-ID: <20260225174646.3514556-10-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225174646.3514556-1-larysa.zaremba@intel.com>
References: <20260225174646.3514556-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772043463; x=1803579463;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2wzvXiUB6GHdMgSixEuavuGnCIhfYzTsdE5DIR4YvLk=;
 b=NnBwcjAK1wVawvnSI6B01YCBzhSkhVsMb84UgJHcxrILSQJaI1JNEatx
 OX+jTHM1pgBIxZ1V6C9T3MXxqCxkwdVAKuUbso9qBHESCc2WWjLGYWKdZ
 WHs4Sy3Zno+IHJCidkAn9iLYJ+vqWbO8e/xm3YfXcvWkylXSQcGCPgs1E
 sKVx19K+4P9b9jW2DR9Ntqk9liO7CiVql0Y/S7Ihk0KAGK/JsplZWIi5z
 Qp0ae6uIS/v8qjPcLvmYWL7lSdD4N25YsHyPwjLjPdlHPHBH5YEpC4ldx
 b5XrG3JEpoBFQR6kV+ZFB3HuPBqLoR/Cu32Ni5C4wQwGlWEiggI+MqtiM
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NnBwcjAK
Subject: [Intel-wired-lan] [PATCH iwl-next v2 09/10] ixgbevf: reconfigure
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
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 67 +++++++++----------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index b9a9607d1314..606c6123d7eb 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1660,6 +1660,12 @@ static void ixgbevf_rx_destroy_pp(struct ixgbevf_ring *rx_ring)
 		.fqes	= rx_ring->rx_fqes,
 	};
 
+	if (!fq.pp)
+		return;
+
+	xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
+	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
+
 	libeth_rx_fq_destroy(&fq);
 	rx_ring->rx_fqes = NULL;
 	rx_ring->pp = NULL;
@@ -1710,6 +1716,14 @@ static int ixgbevf_rx_create_pp(struct ixgbevf_ring *rx_ring)
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
 
@@ -1779,6 +1793,8 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
 
+	ixgbevf_rx_create_pp(ring);
+
 	/* RXDCTL.RLPML does not work on 82599 */
 	if (adapter->hw.mac.type != ixgbe_mac_82599_vf) {
 		u32 pkt_len =
@@ -2271,8 +2287,10 @@ static void ixgbevf_clean_all_rx_rings(struct ixgbevf_adapter *adapter)
 {
 	int i;
 
-	for (i = 0; i < adapter->num_rx_queues; i++)
+	for (i = 0; i < adapter->num_rx_queues; i++) {
 		ixgbevf_clean_rx_ring(adapter->rx_ring[i]);
+		ixgbevf_rx_destroy_pp(adapter->rx_ring[i]);
+	}
 }
 
 /**
@@ -3293,6 +3311,11 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
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
@@ -3303,43 +3326,25 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
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
@@ -3380,24 +3385,14 @@ static int ixgbevf_setup_all_rx_resources(struct ixgbevf_adapter *adapter)
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

