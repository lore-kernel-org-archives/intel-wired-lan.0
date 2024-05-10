Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCABC25B10
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 May 2024 15:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BB0884511;
	Fri, 10 May 2024 15:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5D7esQUClvY; Fri, 10 May 2024 15:27:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6ADC845EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715354871;
	bh=ZfRf3hyouOBVyndn2QXWasQoXBqPkAIeAHBE4iu+/m8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8mFTzMwRiwsLV7r6tkAEJDHa5/oZgW7JOAuaxdeTMdhLo78SmzwYekWPEGp/nd73t
	 DXtOkGak5mFeM/h3YN93/8cLpgLB11WA6vXihpr5bCkIAfQP/Mv5FWmPjI9nuNl0gv
	 Fs8ARN+XOvDXDB+s3VBnlQEuhx+g8zop5kdTFbYcmtUNs0aHH9khdlW0ILpXzWX1Mt
	 ME8RKmMCcdU0yeAxum4ajOWNVdfk7Y9dnex54PvBPuDyIXL0psAjk1h0x7FW5Br78M
	 dcSN3VNG8bRItDZ+KRPZC/9qPjUY0KV3GVZPc9f8YaYVCK1q58NeHyrgmr+34B9gM0
	 qVkkhteKrOxUA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6ADC845EC;
	Fri, 10 May 2024 15:27:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C5D621BF997
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 May 2024 15:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF2D542243
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 May 2024 15:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qG4goUSmQpIM for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 May 2024 15:27:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CD49942048
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD49942048
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD49942048
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 May 2024 15:27:46 +0000 (UTC)
X-CSE-ConnectionGUID: Jr1SJCM4R7mwBpbcFaPNQg==
X-CSE-MsgGUID: AiYxy0bXQbicqCe1t2RTvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15152647"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="15152647"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 08:27:47 -0700
X-CSE-ConnectionGUID: f+FMRAZcRAeZJkN3glaBLw==
X-CSE-MsgGUID: nlXqQaOCRFuwfTAtv+pa2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="30208300"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by orviesa008.jf.intel.com with ESMTP; 10 May 2024 08:27:44 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 10 May 2024 17:26:17 +0200
Message-ID: <20240510152620.2227312-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
References: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715354867; x=1746890867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pJ2zNa4jO3CdB90KBwujeCTuJvbcVryhT3VX6SDhewU=;
 b=EawLQp2tEqscIbKjC2b9kNS1fVjALdBYVITQpRr4Q2LA5g73/fyHhpLM
 mfcxBv8+S+hlsFbbmDKO733YrIXZRSpEpnCuzml2HhfP5k2XgTwNZ41E1
 vrY07N/VagK60RijhEU00yf3HMAeBIbNhrKMw46BZU0DTarWi5uIryFVw
 OGp0/aofm1BKQfrG4X+lb0koJCEBeZs7ATTz2w4q/cwvZEuG6Ee7ALdb6
 IjVCuaJ8hvb/Fh5Zfn7ZkAyRy1y1VZ73CNiXggorHZPc2/eedxJVzJJnr
 8B9Yw+NZsthRwBsB2O6SdbDGE5110J0naaW2cVOu0J7fWJ/p2/UOYvqtt
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EawLQp2t
Subject: [Intel-wired-lan] [PATCH RFC iwl-next 09/12] idpf: remove legacy
 Page Pool Ethtool stats
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Page Pool Ethtool stats are deprecated since the Netlink Page Pool
interface introduction.
idpf receives big changes in Rx buffer management, including &page_pool
layout, so keeping these deprecated stats does only harm, not speaking
of that CONFIG_IDPF selects CONFIG_PAGE_POOL_STATS unconditionally,
while the latter is often turned off for better performance.
Remove all the references to PP stats from the Ethtool code. The stats
are still available in their full via the generic Netlink interface.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/Kconfig       |  1 -
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 29 +------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index bd96ab923b07..af6126eeb61e 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -7,7 +7,6 @@ config IDPF
 	select DIMLIB
 	select LIBETH
 	select PAGE_POOL
-	select PAGE_POOL_STATS
 	help
 	  This driver supports Intel(R) Infrastructure Data Path Function
 	  devices.
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 83447c3d026c..f66f866ec4fb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -573,8 +573,6 @@ static void idpf_get_stat_strings(struct net_device *netdev, u8 *data)
 	for (i = 0; i < vport_config->max_q.max_rxq; i++)
 		idpf_add_qstat_strings(&data, idpf_gstrings_rx_queue_stats,
 				       "rx", i);
-
-	page_pool_ethtool_stats_get_strings(data);
 }
 
 /**
@@ -608,7 +606,6 @@ static int idpf_get_sset_count(struct net_device *netdev, int sset)
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
 	u16 max_txq, max_rxq;
-	unsigned int size;
 
 	if (sset != ETH_SS_STATS)
 		return -EINVAL;
@@ -627,11 +624,8 @@ static int idpf_get_sset_count(struct net_device *netdev, int sset)
 	max_txq = vport_config->max_q.max_txq;
 	max_rxq = vport_config->max_q.max_rxq;
 
-	size = IDPF_PORT_STATS_LEN + (IDPF_TX_QUEUE_STATS_LEN * max_txq) +
+	return IDPF_PORT_STATS_LEN + (IDPF_TX_QUEUE_STATS_LEN * max_txq) +
 	       (IDPF_RX_QUEUE_STATS_LEN * max_rxq);
-	size += page_pool_ethtool_stats_get_count();
-
-	return size;
 }
 
 /**
@@ -884,7 +878,6 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
-	struct page_pool_stats pp_stats = { };
 	struct idpf_vport *vport;
 	unsigned int total = 0;
 	unsigned int i, j;
@@ -954,32 +947,12 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 				idpf_add_empty_queue_stats(&data, qtype);
 			else
 				idpf_add_queue_stats(&data, rxq, qtype);
-
-			/* In splitq mode, don't get page pool stats here since
-			 * the pools are attached to the buffer queues
-			 */
-			if (is_splitq)
-				continue;
-
-			if (rxq)
-				page_pool_get_stats(rxq->pp, &pp_stats);
-		}
-	}
-
-	for (i = 0; i < vport->num_rxq_grp; i++) {
-		for (j = 0; j < vport->num_bufqs_per_qgrp; j++) {
-			struct idpf_buf_queue *rxbufq =
-				&vport->rxq_grps[i].splitq.bufq_sets[j].bufq;
-
-			page_pool_get_stats(rxbufq->pp, &pp_stats);
 		}
 	}
 
 	for (; total < vport_config->max_q.max_rxq; total++)
 		idpf_add_empty_queue_stats(&data, VIRTCHNL2_QUEUE_TYPE_RX);
 
-	page_pool_ethtool_stats_get(data, &pp_stats);
-
 	rcu_read_unlock();
 
 	idpf_vport_ctrl_unlock(netdev);
-- 
2.45.0

