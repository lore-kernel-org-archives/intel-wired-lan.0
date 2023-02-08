Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927DFC6379F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Feb 2023 00:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC95F40192;
	Wed,  8 Feb 2023 00:37:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC95F40192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675816648;
	bh=p4HDN7DRfihV4sA5mFZEhpOraC2I+JR8bq7KcIl5c4I=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=B2HfbD481MIRB7jm2d4XFLZSAShILEAkwsv0u8qg6LKdijwvNCftEY5xOhzDlq/hP
	 000trapDYoqrxoj3b8csjmojEaUfi3I0FPrL0Tq5At5+jgN3P6Lb9Oa8epHs+vSYQE
	 tlPBPEL/3PfqochRxT9cgeX8L/rRxhTD4LFJsUuF3sMPqWL2OpZ04JdKWTImtDDk2G
	 IXOy0YHNpCfbGRt3YIr2wYGGwf+oQPB1QE3NZ+gM5Dag/CN39QROSrWa/GcezKWzgb
	 ej0FmRaqF+NJ5AlJ9xQm/Ax7LrRy/3TdRIXKAC8zVTg1GcoKCy987fHe/ijEOOkQjp
	 D0+MZkTrs3RDA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNy7ZE3FNVrb; Wed,  8 Feb 2023 00:37:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B806E40B5C;
	Wed,  8 Feb 2023 00:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B806E40B5C
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 471481BF95C
 for <intel-wired-lan@osuosl.org>; Wed,  8 Feb 2023 00:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BCE661066
 for <intel-wired-lan@osuosl.org>; Wed,  8 Feb 2023 00:37:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BCE661066
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WCBB1xxiSzHY for <intel-wired-lan@osuosl.org>;
 Wed,  8 Feb 2023 00:37:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BD7761056
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BD7761056
 for <intel-wired-lan@osuosl.org>; Wed,  8 Feb 2023 00:37:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="330959567"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; d="scan'208";a="330959567"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2023 16:37:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="912531757"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; d="scan'208";a="912531757"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by fmsmga006.fm.intel.com with ESMTP; 07 Feb 2023 16:37:12 -0800
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Date: Wed,  8 Feb 2023 08:33:27 +0800
Message-Id: <20230208003327.29538-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675816645; x=1707352645;
 h=from:to:cc:subject:date:message-id;
 bh=UiGGeG09/xWgsrDmkR1WSlAI1WubWg9eUFL6lyR5URQ=;
 b=UcdW+9YQ/CE4+G0qJprYIwLGPV4tJ2xZiJS2hAFsRTazfXcJAU0nwEVK
 avWtGthU5DxrJ40t/HBRxPJziRSMSVKjkd6+XbFq8lnkQuIhWseoBjRxK
 Vu+YvhFHcvRdtyHNkhDyxvmK3wgy5dxqg1dZSjanqAqc52ai5KUBsVyyV
 hxJqDElJiyTY9W5XKrDAJF0IHaPjHJOY2SV27eVG98rFCzGtIVKi6rFK6
 VwlDdgCST9K05rr5g5rYewl2br1h9DdDFdQkk9z0yp29/4cMvPE+Fe2cB
 mPhOLMEnlMLgaCxYSH6gYxUtfNKPEENR8yyluCWV1E6/1L585KCEoO7br
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UcdW+9YQ
Subject: [Intel-wired-lan] [PATCH net-next v3] igc: offload queue max SDU
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
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 26 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

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
index 0cc327294dfb5..38ad437957ada 100644
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
 
@@ -6221,6 +6246,7 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
 		if (hw->mac.type != igc_i225)
 			return -EOPNOTSUPP;
 
+		caps->supports_queue_max_sdu = true;
 		caps->gate_mask_per_txq = true;
 
 		return 0;
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
