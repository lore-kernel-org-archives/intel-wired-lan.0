Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C665C61D90
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Nov 2023 21:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BA8980D51;
	Tue, 21 Nov 2023 21:20:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BA8980D51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700601624;
	bh=osWLhnIBZ56iSNLo+TAwGbJEtjHuqd6QZ0lSrM4x6bM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Qhr1S8Y7rbCBa/qyKE2xFeQFDyh3UiGYGCjGkUiUnAOX/X+LZ5FeG8LyZf7afJ6jN
	 AegSjkcK6os5t07ldJl20VkdzQX3Ew451UMs7HFThnxjp/md9zbODK8Xqs0+fg13Yd
	 dXZ2IuX4SBp7eXohaOsdBTHMt5REQRbfNaIIUPkh++6FunA5emLF5JFW7LukRLrXhF
	 xG/gT4ea0UeRbUXgYP+mU/ag8zOuVHFE1Mc53Rg8M4w0xpDo+CVl1JugFf16tvIQJn
	 UONDcBghHlmm0DeKVSuSS/WBFjFKodW6Tty2cQY5U48ZKgN8i/pLNpLpVCoAlT4sGg
	 YXsN0VFrlZd5g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ulJmmMnuUniO; Tue, 21 Nov 2023 21:20:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F10C81ECE;
	Tue, 21 Nov 2023 21:20:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F10C81ECE
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C470B1BF3F6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Nov 2023 21:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09B2F409F1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Nov 2023 21:19:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09B2F409F1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W_68UQ63dpvj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Nov 2023 21:19:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BABB40978
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Nov 2023 21:19:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BABB40978
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="423022103"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; d="scan'208";a="423022103"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 13:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716630566"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; d="scan'208";a="716630566"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 13:19:38 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 21 Nov 2023 13:19:20 -0800
Message-Id: <20231121211921.19834-13-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231121211921.19834-1-jesse.brandeburg@intel.com>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700601582; x=1732137582;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ps0GNGg5kDvae5OYa4LXFr0lMUHpXWfhHf2T5oSdGts=;
 b=Nu8IxFKfpImjqUsf8rr+TSmq/li6IEwAmuMroy2kpx/PdAC1DvJWFWH7
 Cox1+HdYtWUuo+bnyIXS0sx84V6BKFN3q3FkRtr4U7K4D+oG/fM1WCPtU
 /gs7M6Hyw352PDSUqjtabFD4JeTKEo7KGJzmRqGCgZkxcFiQ7tUG+CKdk
 JrgwwQhuFSpajCyTRJSUq3IGxXi0waigBnHNVXNcMRMxDINuuPklWF0G5
 Q1zfH6ehZ9HrEiZmKOEtLiJHktppdTyWY5Cpbop20eyGOAdHQ6iXupa9o
 57mHxAHEm8Do74HmiMCRZGVA/cDa6vjoIy+Qf3x6Q0K2XDywjqiK1w3b0
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Nu8IxFKf
Subject: [Intel-wired-lan] [PATCH iwl-next v1 12/13] iavf: field get
 conversion
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
Cc: Julia Lawall <Julia.Lawall@inria.fr>, netdev@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Refactor the iavf driver to use FIELD_GET() for mask and shift reads,
which reduces lines of code and adds clarity of intent.

This code was generated by the following coccinelle/spatch script and
then manually repaired in a later patch.

@get@
constant shift,mask;
expression a;
@@
-((a & mask) >> shift)
+FIELD_GET(mask, a)

and applied via:
spatch --sp-file field_prep.cocci --in-place --dir \
 drivers/net/ethernet/intel/

Cc: Julia Lawall <Julia.Lawall@inria.fr>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  3 +--
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 20 +++++++------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 11150bdc63d0..90d8f1fcc3aa 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1020,8 +1020,7 @@ iavf_parse_rx_flow_user_data(struct ethtool_rx_flow_spec *fsp,
 #define IAVF_USERDEF_FLEX_MAX_OFFS_VAL 504
 		flex = &fltr->flex_words[cnt++];
 		flex->word = value & IAVF_USERDEF_FLEX_WORD_M;
-		flex->offset = (value & IAVF_USERDEF_FLEX_OFFS_M) >>
-			     IAVF_USERDEF_FLEX_OFFS_S;
+		flex->offset = FIELD_GET(IAVF_USERDEF_FLEX_OFFS_M, value);
 		if (flex->offset > IAVF_USERDEF_FLEX_MAX_OFFS_VAL)
 			return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index fb7edba9c2f8..b71484c87a84 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -989,11 +989,9 @@ static void iavf_rx_checksum(struct iavf_vsi *vsi,
 	u64 qword;
 
 	qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
-	ptype = (qword & IAVF_RXD_QW1_PTYPE_MASK) >> IAVF_RXD_QW1_PTYPE_SHIFT;
-	rx_error = (qword & IAVF_RXD_QW1_ERROR_MASK) >>
-		   IAVF_RXD_QW1_ERROR_SHIFT;
-	rx_status = (qword & IAVF_RXD_QW1_STATUS_MASK) >>
-		    IAVF_RXD_QW1_STATUS_SHIFT;
+	ptype = FIELD_GET(IAVF_RXD_QW1_PTYPE_MASK, qword);
+	rx_error = FIELD_GET(IAVF_RXD_QW1_ERROR_MASK, qword);
+	rx_status = FIELD_GET(IAVF_RXD_QW1_STATUS_MASK, qword);
 	decoded = decode_rx_desc_ptype(ptype);
 
 	skb->ip_summed = CHECKSUM_NONE;
@@ -1534,8 +1532,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		if (!iavf_test_staterr(rx_desc, IAVF_RXD_DD))
 			break;
 
-		size = (qword & IAVF_RXD_QW1_LENGTH_PBUF_MASK) >>
-		       IAVF_RXD_QW1_LENGTH_PBUF_SHIFT;
+		size = FIELD_GET(IAVF_RXD_QW1_LENGTH_PBUF_MASK, qword);
 
 		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
 		rx_buffer = iavf_get_rx_buffer(rx_ring, size);
@@ -1582,8 +1579,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		total_rx_bytes += skb->len;
 
 		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
-		rx_ptype = (qword & IAVF_RXD_QW1_PTYPE_MASK) >>
-			   IAVF_RXD_QW1_PTYPE_SHIFT;
+		rx_ptype = FIELD_GET(IAVF_RXD_QW1_PTYPE_MASK, qword);
 
 		/* populate checksum, VLAN, and protocol */
 		iavf_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
@@ -2291,8 +2287,7 @@ static void iavf_tx_map(struct iavf_ring *tx_ring, struct sk_buff *skb,
 
 	if (tx_flags & IAVF_TX_FLAGS_HW_VLAN) {
 		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
-		td_tag = (tx_flags & IAVF_TX_FLAGS_VLAN_MASK) >>
-			 IAVF_TX_FLAGS_VLAN_SHIFT;
+		td_tag = FIELD_GET(IAVF_TX_FLAGS_VLAN_MASK, tx_flags);
 	}
 
 	first->tx_flags = tx_flags;
@@ -2468,8 +2463,7 @@ static netdev_tx_t iavf_xmit_frame_ring(struct sk_buff *skb,
 	if (tx_flags & IAVF_TX_FLAGS_HW_OUTER_SINGLE_VLAN) {
 		cd_type_cmd_tso_mss |= IAVF_TX_CTX_DESC_IL2TAG2 <<
 			IAVF_TXD_CTX_QW1_CMD_SHIFT;
-		cd_l2tag2 = (tx_flags & IAVF_TX_FLAGS_VLAN_MASK) >>
-			IAVF_TX_FLAGS_VLAN_SHIFT;
+		cd_l2tag2 = FIELD_GET(IAVF_TX_FLAGS_VLAN_MASK, tx_flags);
 	}
 
 	/* obtain protocol of skb */
-- 
2.39.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
