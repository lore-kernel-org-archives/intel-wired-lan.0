Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A010DD0EE0D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Nov 2025 17:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78C5740C6A;
	Tue, 25 Nov 2025 17:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yywnFlywQFkI; Tue, 25 Nov 2025 17:36:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEA9640B88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1764092213;
	bh=10UO4+r1CvAzrxw4K9slIjgheIjQpKvegMiNbeaMGKk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j9asJHm9tZhcKb3emBVkWjfFuH0MCO/JQAs7JUSGlxclWfe3Roy0y04ZeomKbXsFD
	 ykuKbHd5EEa4IZlNImhSUE0vMEXut3HPRfbK/93aOV8mr7ebmnwib6bNuSPLSD/Lhg
	 tdQNyMxFAti8OwV55VOH41YTKs2IGfyFbMZlvmrffqaxGugmM+1MK+R7keKaP9MsF1
	 HZ6erpltj2f+nrP0LpVowEMobH8/edKRPtiu7boCZJmrzOidiEzktZ64+jZWyTEPUa
	 xvHd1fj8/YEzn/Dm66lR6S54Co92kIvdT8WhH9k+8fCRvHXRLRaqvzDnWVcoeNcno3
	 BaU1C70chveHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEA9640B88;
	Tue, 25 Nov 2025 17:36:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F33EF359
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Nov 2025 17:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA66C607CB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Nov 2025 17:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mk2_XkZHX-e for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Nov 2025 17:36:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E5B7A60A7C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5B7A60A7C
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5B7A60A7C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Nov 2025 17:36:51 +0000 (UTC)
X-CSE-ConnectionGUID: nDEqZAV+QfesDoR+sLt7pQ==
X-CSE-MsgGUID: 4g3EqcDJS1S0c9lMfjqP0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69979930"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; d="scan'208";a="69979930"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 09:36:52 -0800
X-CSE-ConnectionGUID: DoZsEv1SRKOmu96wqKZmSQ==
X-CSE-MsgGUID: 9b02swwvT4uoQHfnAYAfBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; d="scan'208";a="216040434"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by fmviesa002.fm.intel.com with ESMTP; 25 Nov 2025 09:36:48 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 25 Nov 2025 18:36:03 +0100
Message-ID: <20251125173603.3834486-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125173603.3834486-1-aleksander.lobakin@intel.com>
References: <20251125173603.3834486-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764092212; x=1795628212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DckpuTLHr+h44ictMmml2fKM41YlxFMkmDarCT3LOPM=;
 b=UYFRyfiSrG3sL8SaTOLP2Pvyxu45HJ4jsQDdLzwQjYVaDnWUfPFRC+iF
 yZ5Mi0is86ubFgLXrd2AdPl9hxRmOEZZOIZISIaasV6NkytKKOq5emNu3
 dboDNRVa44xo5byfICKp5WcLsQGU7CQwCz+CGzBr9HweMsAIPCH2a6T6T
 EJ88rUVC+68ACps/WSvyPANkYhV61SD+FaD0PZ86/D7Pqo1zs4ZT9OxNT
 pLuLaON/fwZZvJ5FzDIikOg6p9uxCo4FMp0UCYsi/Ca1B/t3hLU7R+G++
 GSqlVeD2KeQ2i/AKb/7dYKLdSX2TrerC+R6oFP0gh/dkKXrS3IAwKp0yu
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UYFRyfiS
Subject: [Intel-wired-lan] [PATCH iwl-next 5/5] ice: add support for
 transmitting unreadable frags
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

Advertise netmem Tx support in ice. The only change needed is to set
ICE_TX_BUF_FRAG conditionally, only when skb_frag_is_net_iov() is
false. Otherwise, the Tx buffer type will be ICE_TX_BUF_EMPTY and
the driver will skip the DMA unmapping operation.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  1 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c   | 17 +++++++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9eb27a0d984b..0ac28b45e0fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3524,6 +3524,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 
 	netdev->netdev_ops = &ice_netdev_ops;
 	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
+	netdev->netmem_tx = true;
 	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
 	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
 	ice_set_ethtool_ops(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 41e1606a8222..51ad13c9d7f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -59,6 +59,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
 	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
+	netdev->netmem_tx = true;
 	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
 
 	err = register_netdev(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index b00fa436472d..494bcfed75af 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -113,11 +113,17 @@ ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
 static void
 ice_unmap_and_free_tx_buf(struct ice_tx_ring *ring, struct ice_tx_buf *tx_buf)
 {
-	if (tx_buf->type != ICE_TX_BUF_XDP_TX && dma_unmap_len(tx_buf, len))
+	switch (tx_buf->type) {
+	case ICE_TX_BUF_DUMMY:
+	case ICE_TX_BUF_FRAG:
+	case ICE_TX_BUF_SKB:
+	case ICE_TX_BUF_XDP_XMIT:
 		dma_unmap_page(ring->dev,
 			       dma_unmap_addr(tx_buf, dma),
 			       dma_unmap_len(tx_buf, len),
 			       DMA_TO_DEVICE);
+		break;
+	}
 
 	switch (tx_buf->type) {
 	case ICE_TX_BUF_DUMMY:
@@ -337,12 +343,14 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 			}
 
 			/* unmap any remaining paged data */
-			if (dma_unmap_len(tx_buf, len)) {
+			if (tx_buf->type != ICE_TX_BUF_EMPTY) {
 				dma_unmap_page(tx_ring->dev,
 					       dma_unmap_addr(tx_buf, dma),
 					       dma_unmap_len(tx_buf, len),
 					       DMA_TO_DEVICE);
+
 				dma_unmap_len_set(tx_buf, len, 0);
+				tx_buf->type = ICE_TX_BUF_EMPTY;
 			}
 		}
 		ice_trace(clean_tx_irq_unmap_eop, tx_ring, tx_desc, tx_buf);
@@ -1492,7 +1500,8 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 				       DMA_TO_DEVICE);
 
 		tx_buf = &tx_ring->tx_buf[i];
-		tx_buf->type = ICE_TX_BUF_FRAG;
+		if (!skb_frag_is_net_iov(frag))
+			tx_buf->type = ICE_TX_BUF_FRAG;
 	}
 
 	/* record SW timestamp if HW timestamp is not available */
@@ -2367,7 +2376,7 @@ void ice_clean_ctrl_tx_irq(struct ice_tx_ring *tx_ring)
 		}
 
 		/* unmap the data header */
-		if (dma_unmap_len(tx_buf, len))
+		if (tx_buf->type != ICE_TX_BUF_EMPTY)
 			dma_unmap_single(tx_ring->dev,
 					 dma_unmap_addr(tx_buf, dma),
 					 dma_unmap_len(tx_buf, len),
-- 
2.51.1

