Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7C606A32A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vkU4WxqS;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SsUPvzKe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C08340B12;
	Thu, 19 Nov 2026 14:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vGK6ZUiZAn73; Thu, 19 Nov 2026 14:11:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 908DC40AF9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097465;
	b=fRYuWdOAxdN3lUDcPkd1Q5QPIypMdtJYBehUyMjeGIBpRs/3qfLOq9wqdOeNexxXh5cy
	 Kc+dT+uWDG35Ak25thKK0dDIAEIYkEivjul1JjHuHKrA1IBjLOuNzQ3FhJ0VI0BIaB3DE
	 Eev/J7CLyO9GvuG/NLSbQ/E0cOJyzgHuaX5hOwyVROZ8mQ1xp+3gDCvDHq/Ht/aKGVpP9
	 IZv58a0/pW1FCRmwzL61xHVhsL3sJtNGE9S16qeS7Mb7PGpTJjySylPggC7mkkN6YQqEi
	 XKmF6NJYF8j/tvoPy8HXGF9V+0DTOkEGNEUhNM1otI8BUXqNPYuJmIQmXvlxRhnt/zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UiueGydypUCFcibsno5g6MZ/gLLuDorxgcw0hPfbZ+o=;
	b=RJgkPnrBiTstr+p2VP+LcUMc4+qErI5uwAcp+U66E+dl834x8aKfwKVYCIx/2Mzsbdxd
	 +G1WRykqiZcCZGjZ0QUWzlREC3XnNi2Wnoe63TloNKwsU/3ZSL7Ay6fgMzpZalaxnKJ8f
	 MXMRP2UWc9rIbOk2tsvXN36Leds5+iFekU+RejhDyMbe446Epu6Po0Zx5mIxQWMn3DIqG
	 ttHevSHvghp/qwWxzb49uaIG4TwnhD4E4nhz3r8qqbl/CAHH1KZmp+xn5YCkyIHQqpBap
	 kBdSXZ9FwWU9mPClykyHwCEyJvBd8KlgK4utHJvJ2tPanQHa/LY/N0Op7pGgIhcI1Yg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097465;
	bh=UiueGydypUCFcibsno5g6MZ/gLLuDorxgcw0hPfbZ+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkU4WxqSjy16plv6RA51hyLIpVV0/LH41RLdhn5Yrd/go56negXKXTUEXsas3VW1H
	 G56EVLMDEoCIHmRl96SQYAzwfgHuL9Gns0VOZGXsJITiPwA0wWcuCsuAxO0rFVss54
	 kVYKiCbns1Fg/9ScDe+/k/QTu/mROgYtUjtPuoBADyXnkEUXVoY5ZxO0xUW+j0l90q
	 uToUWPN4tHCOx3xb2TWxnakqkJdxlUxmRgOTYY4FnTyitIVTPOWTzD3K9BkWBcRaLU
	 mRsyRyYJblsF3sWDNxMi6yPL3w8MAXu0kXz9ufr8YN1/++BGFiCTHcfPP/D5UYrkbl
	 qho8RxYRMkvOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 908DC40AF9;
	Thu, 19 Nov 2026 14:11:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E0AED1C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEAA340545
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zQjqafBozOdo for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F10D140544
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SsUPvzKe
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F10D140544
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795097463; x=1826633463;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xc/QIalpfKwrzppc5y9if1OnQN742H/iHd7mNLlTKSc=;
 b=SsUPvzKe4JLY2ZiVzSUuZ2fp8LYLIPW/3aoblDdC3t4YQT5IuaRVKJMS
 9IgbqVkQQCZfVYD2Bpg3JJaAVWU0i5+1+79eQ1aQ3mU3KPT1rBQK0I9rp
 hb2Uf0r72OAySQkC9dDhLjMshavkNNKXuVvmNmv83BIU0VYh4VpsZM0r6
 Prt73lNd4jsuGWdRNcxvqKz8B1G03HGtRIfPjg0Cg8GQpVft/1T9coDeC
 oHC49b1p1t8XbM85959B+1VfAbFD/VOIkQwGka9pS2/h4eQAk50ykZ5Dc
 P+GNHOSB93LGosuezrKKE3PLHjExmzzmmAztZpiMdyAD5dSm9/oBbst3M w==;
X-CSE-ConnectionGUID: Nmo521AXSTSXE/dwcSN3+g==
X-CSE-MsgGUID: R9ZohU1oSp65LHEZr0Phuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3835341"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3835341"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:11:03 -0800
X-CSE-ConnectionGUID: iMNkeVWgR/2Wj/XKSPZzDQ==
X-CSE-MsgGUID: CEuvBfjDSE6QyKy4HoQbcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10775515"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmviesa006.fm.intel.com with ESMTP; 19 Nov 2026 06:10:59 -0800
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bjorn@kernel.org, kerneljasonxing@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: [PATCH net-next 2/5] ice: add Tx descriptor builders and header
 length check
Date: Thu, 19 Nov 2026 15:10:29 +0100
Message-Id: <20261119141032.1070446-3-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261119141032.1070446-1-magnus.karlsson@intel.com>
References: <20261119141032.1070446-1-magnus.karlsson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add ice_build_tx_desc_offset() and ice_build_tso_ctx_qw1() to
ice_txrx_lib.h for the length fields of the Tx data descriptor and the
TSO context descriptor, and use them in ice_tso() and ice_tx_csum().
Add ice_tx_hdr_lens_ok() for the header length limits of the data
descriptor, and use it in ice_features_check().

This prepares for AF_XDP USO in zero-copy mode, which builds the same
descriptors from a copied packet header instead of an skb. The new
check also requires IPLEN to be a multiple of 4 bytes, as the field is
encoded in dwords, and so does the inner IPLEN check for encapsulated
packets. The IPv4 and IPv6 header lengths that reach them always are.
No functional change intended.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c     | 12 ++---
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 20 +++-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 48 +++++++++++++++++++
 3 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47c6798c97e8..41bcac642291 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -10,6 +10,7 @@
 #include "ice.h"
 #include "ice_base.h"
 #include "ice_lib.h"
+#include "ice_txrx_lib.h"
 #include "ice_fltr.h"
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
@@ -9748,12 +9749,8 @@ ice_features_check(struct sk_buff *skb,
 	if (gso && (skb_shinfo(skb)->gso_size < ICE_TXD_CTX_MIN_MSS))
 		features &= ~NETIF_F_GSO_MASK;
 
-	len = skb_network_offset(skb);
-	if (len > ICE_TXD_MACLEN_MAX || len & 0x1)
-		goto out_rm_features;
-
-	len = skb_network_header_len(skb);
-	if (len > ICE_TXD_IPLEN_MAX || len & 0x1)
+	if (!ice_tx_hdr_lens_ok(skb_network_offset(skb),
+				skb_network_header_len(skb)))
 		goto out_rm_features;
 
 	if (skb->encapsulation) {
@@ -9770,8 +9767,9 @@ ice_features_check(struct sk_buff *skb,
 				goto out_rm_features;
 		}
 
+		/* IPLEN is encoded in dwords, see ice_tx_hdr_lens_ok() */
 		len = skb_inner_network_header_len(skb);
-		if (len > ICE_TXD_IPLEN_MAX || len & 0x1)
+		if (len > ICE_TXD_IPLEN_MAX || len & 3)
 			goto out_rm_features;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 35a480a1e172..7877c27293a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1624,7 +1624,6 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 
 	/* compute outer L2 header size */
 	l2_len = ip.hdr - skb->data;
-	offset = (l2_len / 2) << ICE_TX_DESC_LEN_MACLEN_S;
 
 	/* set the tx_flags to indicate the IP protocol type. this is
 	 * required so that checksum header computation below is accurate.
@@ -1736,7 +1735,6 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 
 	/* compute inner L3 header size */
 	l3_len = l4.hdr - ip.hdr;
-	offset |= (l3_len / 4) << ICE_TX_DESC_LEN_IPLEN_S;
 
 	if ((tx_ring->netdev->features & NETIF_F_HW_CSUM) &&
 	    !(first->tx_flags & ICE_TX_FLAGS_TSO) &&
@@ -1757,7 +1755,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 		off->cd_qw1 |= ICE_TX_DESC_DTYPE_CTX;
 		off->cd_gcs_params = gcs_params;
 		/* Fill out CSO info in data descriptors */
-		off->td_offset |= offset;
+		off->td_offset |= ice_build_tx_desc_offset(l2_len, l3_len, 0);
 		off->td_cmd |= cmd;
 		return 1;
 	}
@@ -1767,26 +1765,24 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	case IPPROTO_TCP:
 		/* enable checksum offloads */
 		cmd |= ICE_TX_DESC_CMD_L4T_EOFT_TCP;
-		l4_len = l4.tcp->doff;
-		offset |= l4_len << ICE_TX_DESC_LEN_L4_LEN_S;
+		l4_len = l4.tcp->doff * sizeof(u32);
 		break;
 	case IPPROTO_UDP:
 		/* enable UDP checksum offload */
 		cmd |= ICE_TX_DESC_CMD_L4T_EOFT_UDP;
-		l4_len = (sizeof(struct udphdr) >> 2);
-		offset |= l4_len << ICE_TX_DESC_LEN_L4_LEN_S;
+		l4_len = sizeof(struct udphdr);
 		break;
 	case IPPROTO_SCTP:
 		/* enable SCTP checksum offload */
 		cmd |= ICE_TX_DESC_CMD_L4T_EOFT_SCTP;
-		l4_len = sizeof(struct sctphdr) >> 2;
-		offset |= l4_len << ICE_TX_DESC_LEN_L4_LEN_S;
+		l4_len = sizeof(struct sctphdr);
 		break;
 
 	default:
 		goto checksum_sw_fb;
 	}
 
+	offset = ice_build_tx_desc_offset(l2_len, l3_len, l4_len);
 	off->td_cmd |= cmd;
 	off->td_offset |= offset;
 	return 1;
@@ -1940,10 +1936,8 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	cd_mss = skb_shinfo(skb)->gso_size;
 
 	/* record cdesc_qw1 with TSO parameters */
-	off->cd_qw1 |= (u64)(ICE_TX_DESC_DTYPE_CTX |
-			     (ICE_TX_CTX_DESC_TSO << ICE_TXD_CTX_QW1_CMD_S) |
-			     (cd_tso_len << ICE_TXD_CTX_QW1_TSO_LEN_S) |
-			     (cd_mss << ICE_TXD_CTX_QW1_MSS_S));
+	off->cd_qw1 |= ICE_TX_DESC_DTYPE_CTX |
+		       ice_build_tso_ctx_qw1(cd_tso_len, cd_mss);
 	first->tx_flags |= ICE_TX_FLAGS_TSO;
 	return 1;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index f17990b68b62..e9dc17dab2a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -53,6 +53,54 @@ ice_build_ctob(u64 td_cmd, u64 td_offset, unsigned int size, u64 td_tag)
 			   (td_tag    << ICE_TXD_QW1_L2TAG1_S));
 }
 
+/**
+ * ice_tx_hdr_lens_ok - check header lengths against the Tx descriptor fields
+ * @mac_len: L2 header length in bytes
+ * @ip_len: L3 header length in bytes
+ *
+ * MACLEN is encoded in 2-byte words and IPLEN in 4-byte dwords, in fields of
+ * limited width.
+ *
+ * Return: true if the MACLEN and IPLEN fields of a Tx data descriptor can
+ * hold these lengths.
+ */
+static inline bool ice_tx_hdr_lens_ok(u32 mac_len, u32 ip_len)
+{
+	return mac_len <= ICE_TXD_MACLEN_MAX && !(mac_len & 1) &&
+	       ip_len <= ICE_TXD_IPLEN_MAX && !(ip_len & 3);
+}
+
+/**
+ * ice_build_tx_desc_offset - build the offset field of a Tx data descriptor
+ * @mac_len: L2 header length in bytes
+ * @ip_len: L3 header length in bytes
+ * @l4_len: L4 header length in bytes
+ *
+ * Return: the MACLEN field in 2-byte words, and the IPLEN and L4LEN fields in
+ * 4-byte dwords.
+ */
+static inline u32 ice_build_tx_desc_offset(u32 mac_len, u32 ip_len, u32 l4_len)
+{
+	return (mac_len / 2) << ICE_TX_DESC_LEN_MACLEN_S |
+	       (ip_len / 4) << ICE_TX_DESC_LEN_IPLEN_S |
+	       (l4_len / 4) << ICE_TX_DESC_LEN_L4_LEN_S;
+}
+
+/**
+ * ice_build_tso_ctx_qw1 - build quad word 1 of a TSO context descriptor
+ * @tso_len: payload bytes to segment, excluding the headers
+ * @mss: payload bytes per output segment
+ *
+ * Return: the TSO command with the TSO_LEN and MSS fields. The caller adds the
+ * descriptor type.
+ */
+static inline u64 ice_build_tso_ctx_qw1(u32 tso_len, u16 mss)
+{
+	return (u64)ICE_TX_CTX_DESC_TSO << ICE_TXD_CTX_QW1_CMD_S |
+	       (u64)tso_len << ICE_TXD_CTX_QW1_TSO_LEN_S |
+	       (u64)mss << ICE_TXD_CTX_QW1_MSS_S;
+}
+
 /**
  * ice_build_tstamp_desc - build Tx time stamp descriptor
  * @tx_desc: Tx LAN descriptor index
-- 
2.38.1

