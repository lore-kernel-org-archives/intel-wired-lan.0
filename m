Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019BAC05027
	for <intel-wired-lan@archiver.kernel.org>; Thu,  9 Feb 2023 02:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F6D682088;
	Thu,  9 Feb 2023 02:33:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F6D682088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675909998;
	bh=aDacT6ADfPuqeZ5gG0STY2UO0esCOQitEAsCvLJvNrA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Omio6mb0BefJm5IrqbcAmHesTgLA94ZlM6v5zn3QJLr62vPmoz0rRo675p42RrXvl
	 Mmi+7m5CNQvEv5jHSXFyO1oKq7viWFTDVbad0IianRh0KhCprM/5+puJepZ51Q9K4Y
	 ATmA5K8k79Dam10b6ckLWtJ62YKn0T25g3EmfGBeI61TBorGQmRHygIorm1RDJXj74
	 WjosTQE0saR411uETjQC5f2LLJLBjufiIBiZ5ZmZL73rHlhY1TN51bcueQhO/n2Cuz
	 ihpXTGf/yATBWz4XF9Y1dg/Sk49BTK7Hlutell+0NLWBLt/TOjJYQrudP4afMiQdGj
	 qLwJiAxSSGOUQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HWsWmaNcb-Il; Thu,  9 Feb 2023 02:33:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 666B682095;
	Thu,  9 Feb 2023 02:33:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 666B682095
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 349171BF31B
 for <intel-wired-lan@osuosl.org>; Thu,  9 Feb 2023 02:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0984940543
 for <intel-wired-lan@osuosl.org>; Thu,  9 Feb 2023 02:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0984940543
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n5Z7BM0a1YCZ for <intel-wired-lan@osuosl.org>;
 Thu,  9 Feb 2023 02:33:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7CFE40393
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7CFE40393
 for <intel-wired-lan@osuosl.org>; Thu,  9 Feb 2023 02:33:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310350686"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; d="scan'208";a="310350686"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2023 18:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756258130"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; d="scan'208";a="756258130"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by FMSMGA003.fm.intel.com with ESMTP; 08 Feb 2023 18:33:10 -0800
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Date: Thu,  9 Feb 2023 10:29:24 +0800
Message-Id: <20230209022924.24154-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675909994; x=1707445994;
 h=from:to:cc:subject:date:message-id;
 bh=nV5ZNHnQ3H0ibDp7c6WKuTF8y1+MDVUfkWphEw5NK4s=;
 b=lb16juyWCK1AYopIxMhDE54Vacos5mU8tvyTzGxQ4mgI+wJuCnMmSQeN
 l4IDR3eUnVrU8Qafjxu5WCBPONXCr0lLUkBPGfCbNhqOfCQNZnpZmEMIL
 WCar7D23wn2l/xaTwvIDdJ6/HR9ujohqf7iYUbqmDQAcAEaum3dtfT+dp
 DgyYYhLCOpqfsioRITZsypZokzkq67GlAcIPu+TulSKADDOwfk9YWn/L7
 17jaMqtZoYTFGDO6VJF6pxVOPjvUb1p7bAfCvV76gay431D+fKBU4wJD2
 4OtjaottGfWVaWy6lQlZiRk8vuyyg61/7txjkoxp1aUcCiyvXFnnsXFeP
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lb16juyW
Subject: [Intel-wired-lan] [PATCH net-next v4] igc: offload queue max SDU
 from tc-taprio
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
Cc: pabeni@redhat.com, leon@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, kuba@kernel.org,
 muhammad.husaini.zulkifli@intel.com, davem@davemloft.net,
 tee.min.tan@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Tan Tee Min <tee.min.tan@linux.intel.com>

Add support for configuring the max SDU for each Tx queue.
If not specified, keep the default.

Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

---
V3 -> V4: Rebase to the latest tree as per requested by Anthony.
V2 -> V3: Rework based on Leon Romanovsky's comment.
V1 -> V2: Rework based on Vinicius's comment.
---
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 29 ++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 9db93c1f97679..34aebf00a5123 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -99,6 +99,7 @@ struct igc_ring {
 
 	u32 start_time;
 	u32 end_time;
+	u32 max_sdu;
 
 	/* CBS parameters */
 	bool cbs_enable;                /* indicates if CBS is enabled */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ddbabf4213499..bba3fe31157fb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1508,6 +1508,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	__le32 launch_time = 0;
 	u32 tx_flags = 0;
 	unsigned short f;
+	u32 max_sdu = 0;
 	ktime_t txtime;
 	u8 hdr_len = 0;
 	int tso = 0;
@@ -1527,6 +1528,14 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
+	if (tx_ring->max_sdu > 0) {
+		max_sdu = tx_ring->max_sdu +
+			  (skb_vlan_tagged(skb) ? VLAN_HLEN : 0);
+
+		if (skb->len > max_sdu)
+			goto skb_drop;
+	}
+
 	if (!tx_ring->launchtime_enable)
 		goto done;
 
@@ -1606,6 +1615,11 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	dev_kfree_skb_any(first->skb);
 	first->skb = NULL;
 
+	return NETDEV_TX_OK;
+
+skb_drop:
+	dev_kfree_skb_any(skb);
+
 	return NETDEV_TX_OK;
 }
 
@@ -6039,6 +6053,7 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 
 		ring->start_time = 0;
 		ring->end_time = NSEC_PER_SEC;
+		ring->max_sdu = 0;
 	}
 
 	return 0;
@@ -6122,6 +6137,16 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 		}
 	}
 
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+		struct net_device *dev = adapter->netdev;
+
+		if (qopt->max_sdu[i])
+			ring->max_sdu = qopt->max_sdu[i] + dev->hard_header_len;
+		else
+			ring->max_sdu = 0;
+	}
+
 	return 0;
 }
 
@@ -6220,8 +6245,10 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
 
 		caps->broken_mqprio = true;
 
-		if (hw->mac.type == igc_i225)
+		if (hw->mac.type == igc_i225) {
+			caps->supports_queue_max_sdu = true;
 			caps->gate_mask_per_txq = true;
+		}
 
 		return 0;
 	}
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
