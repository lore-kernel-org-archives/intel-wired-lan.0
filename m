Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEDDC531D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 22:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05568607A0;
	Mon, 27 Jul 2026 22:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZEuGlFhjjBZV; Mon, 27 Jul 2026 22:57:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D43C605DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785193079;
	bh=6oUxK478sjBYqL8c8TkrkURsFQVIz72WZ22ccJ9dswc=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=7EKoabyjBMBHOXpPyPtTqxZ1VDHA471k9IEDnNjykQARnVYao6QoZcbUvDF6ZBn3l
	 ViiMebqUj5zuokMzEP2NwjCT1QYOtKZHOZuQcD79XqtdpPzls8mm/PdiJsOKMUnWMa
	 6zB06NqHn1V8fGfKYiwSKG2KUkcY36tQpiHofYHzZUQbkRFV7AqssCDC6hYH2WDVto
	 eqJoDcRTrUcoe+IXjqOUvAMFp9lqmJyFXYGlAc1n3iW0dN1X4KqwYj9S0LJDVeNHH+
	 UZR/l3V2wUqF29LWLQqd6dJsHr46mry7ioSKwQ/A95FwjiLQMnPkdb5lq7ZuhX9Tw/
	 9jrCBLhsDNqww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D43C605DB;
	Mon, 27 Jul 2026 22:57:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1032350
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 22:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA66F40098
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 22:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZIK-L0MLiawU for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 22:57:57 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=joshua.a.hay@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1BF674005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BF674005F
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BF674005F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 22:57:56 +0000 (UTC)
X-CSE-ConnectionGUID: HcMixHDVTwqNB/9dMO15tg==
X-CSE-MsgGUID: +RCZdB9KTVOSqdWzLDPEBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="84748871"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="84748871"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 15:57:55 -0700
X-CSE-ConnectionGUID: uMBtnQtwTD+sp4H48NcDDg==
X-CSE-MsgGUID: pVfpCCTWQFCcUIhAVVwrJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="263027552"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
 by orviesa003.jf.intel.com with ESMTP; 27 Jul 2026 15:57:55 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Mon, 27 Jul 2026 16:08:48 -0700
Message-Id: <20260727230848.1557452-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785193077; x=1816729077;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kzyWPv/hp3S8PU5Rn9lNwBnknhfersTVkI2IzpEKj1E=;
 b=nEU3mMkHeARpSV+STjrPeagMyICpZB3wnXoiLSaVKVoTQIdbI+a5+7bu
 mUB48DIBZgASzf/S6jVhlraxYWEhkLoI22AlkxLEywbshg78sjn1h+2v5
 ppInJAZe17tb4U6mLGvt3BH3lkAAxUF50XcjpeYVihxpLW1ZvjK4nTrw1
 Lyrvm6w9msKIjQdibzJ0YovAzc5ajM4aDKNqk+JoWK+7eCJNoivqLeIav
 n2GIXKvqvW6ofVHAyiERMCT5CuDy7xim8qxxqBs9F6s5WYM7aI5q7vES7
 1r8IYcWhx3U42ImR6k5cr2Oq03f3LUoWHfbpYktKBguFJXn6cAfvECCEI
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nEU3mMkH
Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: account for VLAN header
 when parsing RSC packet header
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

While parsing the header of a Receive Side Coalesced (RSC) packet, check
if a VLAN tag is present and adjust the header parsing accordingly.
Otherwise, Rx TCP traffic is completely broken for any VLAN interface
whose underlying interface has RSC (rx-gro-hw) enabled.

We only need to worry about one VLAN header since Rx packets with
multiple VLAN headers are not candidates for RSC.

Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c724d429a7aa..70553f64f770 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3299,6 +3299,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		       struct libeth_rx_pt decoded)
 {
 	u16 rsc_segments, rsc_seg_len;
+	u16 l3_start = 0;
 	bool ipv4, ipv6;
 	int len;
 
@@ -3321,7 +3322,10 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	NAPI_GRO_CB(skb)->count = rsc_segments;
 	skb_shinfo(skb)->gso_size = rsc_seg_len;
 
-	skb_reset_network_header(skb);
+	if (unlikely(eth_type_vlan(skb->protocol)))
+		l3_start = VLAN_HLEN;
+
+	skb_set_network_header(skb, l3_start);
 
 	if (ipv4) {
 		struct iphdr *ipv4h = ip_hdr(skb);
@@ -3329,7 +3333,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
 
 		/* Reset and set transport header offset in skb */
-		skb_set_transport_header(skb, sizeof(struct iphdr));
+		skb_set_transport_header(skb, l3_start + sizeof(struct iphdr));
 		len = skb->len - skb_transport_offset(skb);
 
 		/* Compute the TCP pseudo header checksum*/
@@ -3339,7 +3343,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
-		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+		skb_set_transport_header(skb, l3_start + sizeof(struct ipv6hdr));
 		len = skb->len - skb_transport_offset(skb);
 		tcp_hdr(skb)->check =
 			~tcp_v6_check(len, &ipv6h->saddr, &ipv6h->daddr, 0);
-- 
2.39.2

