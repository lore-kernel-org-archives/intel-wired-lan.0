Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF80CC43458
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Jul 2026 23:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A60E260722;
	Wed,  8 Jul 2026 23:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dOUGQuXZO9f; Wed,  8 Jul 2026 23:05:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D400B6072D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783551929;
	bh=0R7rSSkqTacn4eRr91WictHmBFApYWPcIKUA6H01yVc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j1BHmTPtH9CQ40c9h6JqsLryC8YrW1Qeq5rpoJ1uE+cNmdWkOJjOQ3mbGbVh7c/dC
	 SAd7bgPoeAsfOTLs6mzT7RCGdR9BmjWV7wDZvB3bCiyrURMJcRGFLCbOKIX75tZEBf
	 13iHzXZNQRlYJmQhQd+vgB0OpiRFSWRIAakFFNbMUuGsqFNGEGrmBOIFNvE8JLCyUt
	 0TgCHVsgdYdXBPOcpmN27SqZohVYgsFB++9aTm0YtOi8K1wMYYC2i0Y4C0VUZxO8qs
	 HY7HYMqPCXwQjtitByFOusaoJrUNC8ZVSqPo5llPhkL4KQa22UhHDEVcwhVbtzO2V2
	 2ULtf50M0wOxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D400B6072D;
	Wed,  8 Jul 2026 23:05:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DCF90422
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 22:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3402606F6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 22:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lnxBWRLqM7h1 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Jul 2026 22:57:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3006:205::8; helo=outbound.qs.icloud.com;
 envelope-from=deliran@verdict.gg; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0F4586067F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F4586067F
Received: from outbound.qs.icloud.com (qs-2005a-snip6-5.eps.apple.com
 [IPv6:2a01:b747:3006:205::8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F4586067F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 22:57:03 +0000 (UTC)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 08BA130000C3; Wed, 08 Jul 2026 20:34:59 +0000 (UTC)
X-ICL-RepId: 019f4370-e4bf-78e7-b622-e53a71ef1a4d
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgFDGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJIC0gAWQZbHEQMSQFcGl8fFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 305FF300111D; Wed, 08 Jul 2026 20:34:54 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Vladimir Vdovin <deliran@verdict.gg>
Date: Wed,  8 Jul 2026 23:34:07 +0300
Message-ID: <20260708203410.45121-4-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260708203410.45121-1-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Xc3ckwcLp0BEyAc5tgHAQkM2JZVoURXZ
X-Proofpoint-GUID: Xc3ckwcLp0BEyAc5tgHAQkM2JZVoURXZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMiBTYWx0ZWRfX+OzZU1/BCEx3
 ZtDTz+/OjgDLr7jGXvgEcQmnk71DE2qspxAHQkFh83nL/OeOYzmi0fd7Y2rUNWioBpem1lKQYrp
 kGZkhLYUF8K3AsSIDC7Uyrx6prUpVKk+VA9NX29qh7P50Vhbplm4yepa+pbEM6j3vVtmsGn+Q8k
 OVsiTDOe4RfkjkSncYGnCewvCG3u2UcUQfUdBFn1EGnK2Ptvg53fiiu41Nu8D0N8kl1Uc0eUOaA
 NbiqSFP75OxWeKj+qYpohiK7dyXmVVsPAQVGCWveWQbiVqwdtwjlFc8FPaX2SkJ7uBqH+9vA/eM
 UuU4pqVRNE/l68eWdeO
X-Mailman-Approved-At: Wed, 08 Jul 2026 23:05:25 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=verdict.gg; s=sig1; t=1783542906; x=1786134906;
 bh=0R7rSSkqTacn4eRr91WictHmBFApYWPcIKUA6H01yVc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=QBmNOqK74cCqJJ+DneB+4N35Z6fFqHMCJJEZFvNDdtTbwB3m6pNz9O/f9dRYnMI6D1NIPO97N5L9XT736RZ9U6+IaetbCsP2frluMAEIIw7FN2H+kNb49XA2scdP/e7iTUBEifj9oqe+63yk2pv9GgY3BffbTOZ25oZQhITONgoBdRzRc/0fDpJRc0g4iTYqCdDFrgvgVM5633uA2Y4//dZhp7jLTg2k10BHTlD1BlxxcbcSLDnoH8vAqwCeSewUTFChlllrKTEfyJvoLRc/u5+ZQIwr4lLPWuiCBZIITU1a0hxPsbNkTgCavxe/fgP7wIQ44pcFHRd3h2+kT1w86A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=verdict.gg
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=verdict.gg header.i=@verdict.gg header.a=rsa-sha256
 header.s=sig1 header.b=QBmNOqK7
Subject: [Intel-wired-lan] [PATCH bpf-next v4 3/6] net: ice: Add
 xmo_rx_checksum callback
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

From: Lorenzo Bianconi <lorenzo@kernel.org>

Implement xmo_rx_checksum callback in ice driver to report RX checksum
result to the eBPF program bounded to the NIC.
Introduce ice_get_rx_csum utility routine in order to make the rx checksum
code reusable from ice_rx_csum()

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 123 ++++++++++++------
 1 file changed, 81 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..3aa82ff03d9e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -78,69 +78,48 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
 		libeth_rx_pt_set_hash(skb, hash, decoded);
 }
 
-/**
- * ice_rx_gcs - Set generic checksum in skb
- * @skb: skb currently being received and modified
- * @rx_desc: receive descriptor
- */
-static void ice_rx_gcs(struct sk_buff *skb,
-		       const union ice_32b_rx_flex_desc *rx_desc)
-{
-	const struct ice_32b_rx_flex_desc_nic *desc;
-	u16 csum;
-
-	desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
-	skb->ip_summed = CHECKSUM_COMPLETE;
-	csum = (__force u16)desc->raw_csum;
-	skb->csum = csum_unfold((__force __sum16)swab16(csum));
-}
-
-/**
- * ice_rx_csum - Indicate in skb if checksum is good
- * @ring: the ring we care about
- * @skb: skb currently being received and modified
- * @rx_desc: the receive descriptor
- * @ptype: the packet type decoded by hardware
- *
- * skb->protocol must be set before this function is called
- */
 static void
-ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
-	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
+ice_get_rx_csum(const union ice_32b_rx_flex_desc *rx_desc, u16 ptype,
+		struct ice_rx_ring *ring, enum xdp_checksum *ip_summed,
+		u32 *cksum, u8 *cksum_level)
 {
-	struct libeth_rx_pt decoded;
+	struct libeth_rx_pt decoded = libie_rx_pt_parse(ptype);
 	u16 rx_status0, rx_status1;
 	bool ipv4, ipv6;
 
-	/* Start with CHECKSUM_NONE and by default csum_level = 0 */
-	skb->ip_summed = CHECKSUM_NONE;
-
-	decoded = libie_rx_pt_parse(ptype);
 	if (!libeth_rx_pt_has_checksum(ring->netdev, decoded))
-		return;
+		goto checksum_none;
 
 	rx_status0 = le16_to_cpu(rx_desc->wb.status_error0);
 	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
-
 	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
 	    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
 	    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
 	     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||
 	     decoded.inner_prot == LIBETH_RX_PT_INNER_ICMP)) {
-		ice_rx_gcs(skb, rx_desc);
+		const struct ice_32b_rx_flex_desc_nic *desc;
+		__wsum wcsum;
+		u16 csum;
+
+		desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
+		*ip_summed = XDP_CHECKSUM_COMPLETE;
+		csum = (__force u16)desc->raw_csum;
+		wcsum = csum_unfold((__force __sum16)swab16(csum));
+		*cksum = (__force u32)wcsum;
+		*cksum_level = 0;
 		return;
 	}
 
 	/* check if HW has decoded the packet and checksum */
 	if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
-		return;
+		goto checksum_none;
 
 	ipv4 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV4;
 	ipv6 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV6;
 
 	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S)))) {
 		ring->vsi->back->hw_rx_eipe_error++;
-		return;
+		goto checksum_none;
 	}
 
 	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S))))
@@ -164,14 +143,51 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 	 * we need to bump the checksum level by 1 to reflect the fact that
 	 * we are indicating we validated the inner checksum.
 	 */
-	if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
-		skb->csum_level = 1;
-
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	*cksum_level = decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT;
+	*ip_summed = XDP_CHECKSUM_UNNECESSARY;
+	*cksum = 0;
 	return;
 
 checksum_fail:
 	ring->vsi->back->hw_csum_rx_error++;
+checksum_none:
+	*ip_summed = XDP_CHECKSUM_NONE;
+	*cksum_level = 0;
+	*cksum = 0;
+}
+
+/**
+ * ice_rx_csum - Indicate in skb if checksum is good
+ * @ring: the ring we care about
+ * @skb: skb currently being received and modified
+ * @rx_desc: the receive descriptor
+ * @ptype: the packet type decoded by hardware
+ *
+ * skb->protocol must be set before this function is called
+ */
+static void
+ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
+	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
+{
+	enum xdp_checksum ip_summed;
+	u8 cksum_level;
+	u32 cksum;
+
+	ice_get_rx_csum(rx_desc, ptype, ring, &ip_summed, &cksum,
+			&cksum_level);
+	switch (ip_summed) {
+	case XDP_CHECKSUM_UNNECESSARY:
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = cksum_level;
+		break;
+	case XDP_CHECKSUM_COMPLETE:
+		skb->ip_summed = CHECKSUM_COMPLETE;
+		skb->csum = (__force __wsum)cksum;
+		break;
+	default:
+		skb->ip_summed = CHECKSUM_NONE;
+		break;
+	}
 }
 
 /**
@@ -566,6 +582,28 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_checksum - RX checksum XDP hint handler
+ * @ctx: XDP buff pointer
+ * @ip_summed: RX checksum result destination address
+ * @cksum: RX checksum value destination address
+ * @cksum_level: RX checksum level value destination address
+ */
+static int ice_xdp_rx_checksum(const struct xdp_md *ctx,
+			       enum xdp_checksum *ip_summed,
+			       u32 *cksum, u8 *cksum_level)
+{
+	const struct libeth_xdp_buff *xdp_ext = (void *)ctx;
+	const union ice_32b_rx_flex_desc *rx_desc = xdp_ext->desc;
+	struct ice_rx_ring *ring;
+
+	ring = libeth_xdp_buff_to_rq(xdp_ext, typeof(*ring), xdp_rxq);
+	ice_get_rx_csum(rx_desc, ice_get_ptype(rx_desc), ring, ip_summed,
+			cksum, cksum_level);
+
+	return 0;
+}
+
 /**
  * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
  * @ctx: XDP buff pointer
@@ -598,4 +636,5 @@ const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
 	.xmo_rx_hash			= ice_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= ice_xdp_rx_checksum,
 };
-- 
2.47.0

