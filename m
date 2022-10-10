Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03726C433FE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Oct 2022 19:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9046C60EFE;
	Mon, 10 Oct 2022 19:29:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9046C60EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1665430173;
	bh=rMSOgVTqs3cRgg/Cqvi3tR0x2AklLmJlx35orcF8VSU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=svhCS3Kg8eLvT4MK9H7znxjHs6xQ6qLl8PAD/iOc/+QgYDRxx2fJglWT1MYXUuV6M
	 KhPx/pj+TMKLphDd9u7Xe1ggG3WIZuVLQAkoz8a/Jx6R6+XjaBf251mgvIPTZAQA1I
	 UTHXO2QPsxapGFUF0d4oSyxB875G4MGp916j012ONcuQzI9g8iTq0QQ8kBYpkrTIVT
	 T3sTYBOoB7ciNyl9b8M0dJmcRwrNZKK/Wcgp+QbVzDG5iw9eSa8/e76ilElv8nQd1R
	 jRhz4GZKX3s4WEmCojhAzJgQALPUcp/Zj7UoyQ5pITPMLzllFkvULVk4D7OOr3bEC9
	 tGIhI0BH+dCXg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7XUTxHHciz59; Mon, 10 Oct 2022 19:29:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BAAC60F36;
	Mon, 10 Oct 2022 19:29:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BAAC60F36
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 9AAD11BF28F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Oct 2022 19:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 732348175B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Oct 2022 19:29:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 732348175B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i5MzLxBlPT24 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Oct 2022 19:29:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0C7781764
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0C7781764
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Oct 2022 19:29:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="303057149"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="303057149"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2022 12:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="659265729"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="659265729"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.232.13])
 by orsmga001.jf.intel.com with ESMTP; 10 Oct 2022 12:29:25 -0700
From: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 10 Oct 2022 15:22:22 -0400
Message-Id: <20221010192223.916578-2-benjamin.mikailenko@intel.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221010192223.916578-1-benjamin.mikailenko@intel.com>
References: <20221010192223.916578-1-benjamin.mikailenko@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665430165; x=1696966165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=npA0HfkpgvAuIJSYjaFaQJ4DauFyJXjXtREYC0Fa2ok=;
 b=fo5oIWzV89QR86/cusFael8OTPyYY0grzhextxd6o3zS7dJSIBUsHlj7
 I/CRVgP4b6qeFWVsNVDN+LB63QsyJfU5FrrXjaE5FdBTGZ4G9OVySNwu1
 TuORnY9FSReOdfyFxeCQH8KAbv4Rbm9mSn5HcrLIiFxTEhJOzwpb8efKP
 BKCtZDKvgNhL3HPAoyqJQ0RWmhiIYm4rwTnCjo3y+R6WiB0/sZ0kKHVxf
 Qvq134wS1sit1ElJJDGZnMSO4MpbwZVE2/C0l/5+5TmlfKx4fmgxThBys
 x2h0QLR+aats/3L7TY10lMotp1ahdtj3cG/3l9tZmuaP9Qd651EvNMv+A
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fo5oIWzV
Subject: [Intel-wired-lan] [net-next,
 v2 1/2] ice: Accumulate HW and Netdev statistics over reset
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
Cc: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Resets happen with or without user interaction. For example, incidents
such as TX hang or a reconfiguration of parameters will result in a reset.
During reset, hardware and software statistics were set to zero. This
created an issue for the user where a reset happens in the background,
statistics set to zero, and the user checks statistics expecting them to
be populated.

To ensure this doesn't happen, keep accumulating stats over reset.

1. Remove function calls which reset hardware and netdev statistics.
2. Do not rollover statistics in ice_stat_update40 during reset.

Signed-off-by: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  3 ++
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 +++++
 drivers/net/ethernet/intel/ice/ice_main.c    | 30 +++++++++++++++++---
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 001500afc4a6..e0ed2f1cc434 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -358,6 +358,7 @@ struct ice_vsi {
 
 	/* VSI stats */
 	struct rtnl_link_stats64 net_stats;
+	struct rtnl_link_stats64 net_stats_prev;
 	struct ice_eth_stats eth_stats;
 	struct ice_eth_stats eth_stats_prev;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 5e6d168bac48..4f3a848f4e99 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -874,6 +874,9 @@ void ice_update_dcb_stats(struct ice_pf *pf)
 	prev_ps = &pf->stats_prev;
 	cur_ps = &pf->stats;
 
+	if (ice_is_reset_in_progress(pf->state))
+		pf->stat_prev_loaded = false;
+
 	for (i = 0; i < 8; i++) {
 		ice_stat_update32(hw, GLPRT_PXOFFRXC(port, i),
 				  pf->stat_prev_loaded,
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 938ba8c215cb..a5945319b62e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1795,11 +1795,15 @@ void ice_update_eth_stats(struct ice_vsi *vsi)
 {
 	struct ice_eth_stats *prev_es, *cur_es;
 	struct ice_hw *hw = &vsi->back->hw;
+	struct ice_pf *pf = vsi->back;
 	u16 vsi_num = vsi->vsi_num;    /* HW absolute index of a VSI */
 
 	prev_es = &vsi->eth_stats_prev;
 	cur_es = &vsi->eth_stats;
 
+	if (ice_is_reset_in_progress(pf->state))
+		vsi->stat_offsets_loaded = false;
+
 	ice_stat_update40(hw, GLV_GORCL(vsi_num), vsi->stat_offsets_loaded,
 			  &prev_es->rx_bytes, &cur_es->rx_bytes);
 
@@ -3279,6 +3283,8 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 			goto err_vectors;
 
 		ice_vsi_map_rings_to_vectors(vsi);
+
+		vsi->stat_offsets_loaded = false;
 		if (ice_is_xdp_ena_vsi(vsi)) {
 			ret = ice_vsi_determine_xdp_res(vsi);
 			if (ret)
@@ -3315,6 +3321,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 		if (ret)
 			goto err_vectors;
 
+		vsi->stat_offsets_loaded = false;
 		break;
 	case ICE_VSI_CHNL:
 		if (test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 189160dacad9..ac893ce39e5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6487,6 +6487,7 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
  */
 static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 {
+	struct rtnl_link_stats64 *net_stats, *stats_prev;
 	struct rtnl_link_stats64 *vsi_stats;
 	u64 pkts, bytes;
 	int i;
@@ -6526,10 +6527,28 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 
 	rcu_read_unlock();
 
-	vsi->net_stats.tx_packets = vsi_stats->tx_packets;
-	vsi->net_stats.tx_bytes = vsi_stats->tx_bytes;
-	vsi->net_stats.rx_packets = vsi_stats->rx_packets;
-	vsi->net_stats.rx_bytes = vsi_stats->rx_bytes;
+	net_stats = &vsi->net_stats;
+	stats_prev = &vsi->net_stats_prev;
+
+	/* clear prev counters after reset */
+	if (vsi_stats->tx_packets < stats_prev->tx_packets ||
+	    vsi_stats->rx_packets < stats_prev->rx_packets) {
+		stats_prev->tx_packets = 0;
+		stats_prev->tx_bytes = 0;
+		stats_prev->rx_packets = 0;
+		stats_prev->rx_bytes = 0;
+	}
+
+	/* update netdev counters */
+	net_stats->tx_packets += vsi_stats->tx_packets - stats_prev->tx_packets;
+	net_stats->tx_bytes += vsi_stats->tx_bytes - stats_prev->tx_bytes;
+	net_stats->rx_packets += vsi_stats->rx_packets - stats_prev->rx_packets;
+	net_stats->rx_bytes += vsi_stats->rx_bytes - stats_prev->rx_bytes;
+
+	stats_prev->tx_packets = vsi_stats->tx_packets;
+	stats_prev->tx_bytes = vsi_stats->tx_bytes;
+	stats_prev->rx_packets = vsi_stats->rx_packets;
+	stats_prev->rx_bytes = vsi_stats->rx_bytes;
 
 	kfree(vsi_stats);
 }
@@ -6591,6 +6610,9 @@ void ice_update_pf_stats(struct ice_pf *pf)
 	prev_ps = &pf->stats_prev;
 	cur_ps = &pf->stats;
 
+	if (ice_is_reset_in_progress(pf->state))
+		pf->stat_prev_loaded = false;
+
 	ice_stat_update40(hw, GLPRT_GORCL(port), pf->stat_prev_loaded,
 			  &prev_ps->eth.rx_bytes,
 			  &cur_ps->eth.rx_bytes);
-- 
2.34.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
