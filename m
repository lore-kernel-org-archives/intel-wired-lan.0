Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6133CC4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Nov 2022 20:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F08C660592;
	Thu, 10 Nov 2022 20:35:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F08C660592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668112512;
	bh=skIBTpGwHml4t+z1cyAUd3fZCnwR7W8PBsVdevWznw0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=X9PdqD8wxLu4xelUS3YgwkXuKqbL70/l7hE3gc04bBPiLDoujPOJJl0RO6WXv1UQG
	 ndcBylPCPUEVGOXlJ57gE1I+XelFMj/klQRtV/a0KTtOFtdrzJGm+uUqSKOgCUodet
	 gwc4x/htQj5WsafUZUCbWT7z4aTAHiUb69fVoLyxp7LdjmpRx3egg+HTXGMqcX3iS2
	 TefCnZG6WMGysz97FwgSq7C9rnCo23blQfD5U1gZ0gg4abt+SkSoaxlnrz4WEliaj6
	 KCOr2jt5WuOMV5J/e0yNuFAU5HJz1jHj8eoyiwf3sGR0hx5AhC2VtcQfKOHuVcGEQx
	 5rvJ/yZ/ASmuw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HG2mCsXYTTjL; Thu, 10 Nov 2022 20:35:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id F231D60594;
	Thu, 10 Nov 2022 20:35:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F231D60594
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 5DD5C1BF3EE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Nov 2022 20:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43DBC4049C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Nov 2022 20:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43DBC4049C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0pWN25Jk5b9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Nov 2022 20:35:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2509F4049A
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2509F4049A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Nov 2022 20:35:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310153203"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; d="scan'208";a="310153203"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 12:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="966564410"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; d="scan'208";a="966564410"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.232.13])
 by fmsmga005.fm.intel.com with ESMTP; 10 Nov 2022 12:35:03 -0800
From: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 10 Nov 2022 15:26:48 -0500
Message-Id: <20221110202649.738026-2-benjamin.mikailenko@intel.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221110202649.738026-1-benjamin.mikailenko@intel.com>
References: <20221110202649.738026-1-benjamin.mikailenko@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668112504; x=1699648504;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P82SnH8JxbPsJ20kwrMIj9QpRlGMunnVmoBF1bXrTLo=;
 b=aERQX+iC4LHVXMFvs/CVTkB0smWdRmwfOliNaWZPXaoFDVUaJWPRDWJl
 XCCgHH4ImNLmry0rDe6B/Djq4IvR/vUUgrNQXQHoq/wK6mruS+qAYUKGj
 l5iT3GMNAsw9Hhx/q94wTFWcd/vKUJHoZAXhKD0mBim+K5/3ytsCXa6Zc
 unOhfCVW+piYz0/cGYEl4AhYZc8iuc75jdkiV3kh9W6ewQMCgVjoVjsOv
 jDyXjeG/j/5BAH25Rtkj3yoAJSLEksXg7WNx0XuRRiLHqpVijuB8IKggL
 lFScGB230u/g4Wy7ah9nGbT7FxvtQ2MQtk8VaWTFRyv2DVeLMRehPEsUB
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aERQX+iC
Subject: [Intel-wired-lan] [net-next,
 v4 1/2] ice: Accumulate HW and Netdev statistics over reset
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
index f88ee051e71c..74d40a766664 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -373,6 +373,7 @@ struct ice_vsi {
 
 	/* VSI stats */
 	struct rtnl_link_stats64 net_stats;
+	struct rtnl_link_stats64 net_stats_prev;
 	struct ice_eth_stats eth_stats;
 	struct ice_eth_stats eth_stats_prev;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index add90e75f05c..01da9389de84 100644
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
index 1f27dc20b4f1..de3b94e89066 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6412,6 +6412,7 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
  */
 static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 {
+	struct rtnl_link_stats64 *net_stats, *stats_prev;
 	struct rtnl_link_stats64 *vsi_stats;
 	u64 pkts, bytes;
 	int i;
@@ -6451,10 +6452,28 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 
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
@@ -6516,6 +6535,9 @@ void ice_update_pf_stats(struct ice_pf *pf)
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
