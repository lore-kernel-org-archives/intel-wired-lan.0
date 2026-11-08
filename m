Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97561606A31C
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TeARSFGz;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJCgIcuz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 700BF405ED;
	Sun,  8 Nov 2026 14:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVNJWH7MpJVf; Sun,  8 Nov 2026 14:45:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D56D4405F4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794149113;
	b=e8oC33ptXDUZqS0mEWfxLX5/DsKXpFbt7dcC4AJr4WrcrEKIN805PJR2Vph+7L3UWXQ/
	 vZ3h9lNpwVWeiDDWjUZheiKJ6Py7+X4NHPJIyVpiNT/LV8zBrbZC6PmblmDjuZFvhNQzY
	 wJsLOBctmVJyGWmSxmWLaWYbeVK+Gm3Q+P/spEibU3IYz4g8GIZepVQHs+QOJXV5K1Y9+
	 8uQ6Skm4FanWALaNvpVMxn671hpcNnq3R3to5yNb0SGC8MCdtCQ5gYe1ZYOGUYrpQZXlP
	 2K6MMZ+2ni0lqM4t0Hdz9EXKi6kh+zyg/zCaE8tRxGd3SSP6x01K2oRg4fsd/qJ6cew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794149113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BWLXPrDBb6fwVdC9SdLihK45EJBOKhQGZpqv0eMsNFY=;
	b=DdR5oEuWwQJ7tpG0RzB+7hk0Y24/8DTVJbtqubB20w8XrQMprNHhQEM1uqXljDHpB/YT
	 5hrY+m5WiV5KLhtcbK/CQErNWjjIdUcaSeaA5RGa8nqJ09b9Mf/RB/BpYb8XOHcvcksNi
	 ZzPqrCHPlX2T9Skaz9pskM8zNzd0fm3eLrM7/hpH7UIL9u4z/T0TZAif42NWJr4wbYMjq
	 IgBSRJABQ04iHzJMmosyv4j7LTmUtj0SKFs6YM37o5gEVeREc3gUclizatH5iZ4IUPn1U
	 H9o9XqZOrtzpJBvDt5eA/6Qdin1cMPXf3RhPUGCrvNLtC4NupmZ2b65jBHqTz3b59ZA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794149113;
	bh=BWLXPrDBb6fwVdC9SdLihK45EJBOKhQGZpqv0eMsNFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TeARSFGzazFR5drhzQ5X8wCgpqpN3NatdW6WAAKFHi0NoY+oiEwDoe7IuNfbFkX0W
	 PF+JtrKqverAMk9w4VK185DHn57+h6TxvKXmncsuEe/s7fot+EwDH6X+sCA2VBUq6S
	 rN0M7zpaaFpxQCTtV4VK3CpPJA6VENBO9fX8teOxzNMj9fNrVtlMrieA8cK0PZbExL
	 K0soaEb80voehZomI+9QpT5qKXUWrwnSsZ7kPZ/1LUNPAdc/SLvr9MpILJmlUsb2xb
	 jNxpMTBIBsRRP15oB1jVIGa3kGKELJkP6eBRpwotEAZw5bWj5ewx9pRkQm4EhvSt/r
	 9PkWihPUBhb5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D56D4405F4;
	Sun,  8 Nov 2026 14:45:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 97B5E9D1
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D12080E1B
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwhaT82SFlEs for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 14:45:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7FD5180D5A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=MJCgIcuz
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FD5180D5A
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:45:09 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so863555e9.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 08 Nov 2026 06:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794149108; x=1794753908; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BWLXPrDBb6fwVdC9SdLihK45EJBOKhQGZpqv0eMsNFY=;
 b=MJCgIcuzokYrzZWNW5InHRd0uPhDfF8aLbiCDPFRRpCE6pmwJMNw0UsBMitLWeS2o+
 XmxrXQ0Dr2jOf6m0TnDu0KamUnPSua7db1Yx4fDfabwr0X3mKcx4Ty64C81z7bGt0xP0
 kZQTteSZIm/2pn0hKn/511saxtYqrPvSYD7DUuXCkAa8Ehpg9svqmgHY5og2Vc/2pnTs
 ucm0IytF3jol+taS9yhLmylStztkzwngq960mwWu/dhOydqTBqzB14fAoGA2qeoS4en4
 QNwadY3VrNQ5MGAZQJ4O7CpfcYUBZ3B8btSPYGJx6NfETie6bn1Xi7tSsi3ARRqKCAxP
 RA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794149108; x=1794753908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BWLXPrDBb6fwVdC9SdLihK45EJBOKhQGZpqv0eMsNFY=;
 b=X1f1MGYUbztMN5Mb5YA6MYhMghduxybn8zMrf0WS15/HmwzmUTl5hrTqAi/xk38/Ra
 TnhyJZfuZn4tB0ps0FeWMm2fZTKxGoqjz6303qhWJbzZzW1HJ5nIC8EMbe/0A7iF5iOq
 Y+X/0QXTsd7JcppGz/odMjSxiJGHaZR/NgAGwk9syM9fU1ff36+zm8t50ORLYdXKPtwJ
 2bLiiSv2HR87ax+TtrOr5wLpenRQuL0jadArWwhMuXWleDy9xoKut6pvHL+76vK2nYL9
 ug5mJ5qbJ2OxwapAh7kKKYzuy+S+SS8szNoQWFQNsfrA/D9F/Pc5Jzr6/5lY5CCFp272
 RDFg==
X-Gm-Message-State: APuU4Z9lN07e83YcPZEfPccoRslG5pvYV0ZAGLaz1HEb5ktTaHdMUDgz
 D60+6pzr6sfO7mLxOVpXPSNtD6A9uCf+kwmquu/9UHJguyJBGFGXTSwYPwRMKrMh
X-Gm-Gg: AYBFou354xE8lgJIs/oKpObcjC1b/3C6PhNNNPcYHFqKb9Vxh8L9fmwWNHmseGoVgju
 xtcbpt63g/UWOv2UcoKqOksnLX+bqEvwUpncoWBu5Ldf+F4KIn20keWgczMf+lpDZUCAb6300jx
 UkChRo3zMs5N4caSfdseVyRBTxvFf57gs9pjwQ50ZbpSJe3/83Am8nwVPtSrl6LxG7Caj6R8EKX
 Gro9fli2LwaVjD6OJFdZWgO4T39slzdFam1iqjV501GtZR6Gxv/2znxyPL7Q87FL9NaaY+soF49
 xGlOmLpe63qfVSIo5wTqaxW8AO2IH/oI1ygiitY4QYxhGcab2OIyb63gsErmsbgTICCXGO0c10M
 NgkKDYv8tArZgSwZEotHxQvL/dqvE5oqv3Q6C5H0GJlkYQRWCaMeNH0QtM06P1B3H2PbtwTYtrD
 Ibc+3L1R4isQEUV+rFdnkw7NbnfSgvBiVdqBpTXupnyOFmMP0mZoDXpEwnKEt6xAyDSjRXnys1/
 HbQUG3yKd3sAIVashUiQ83SHAyd9rxjpeMTYBQNeO+28MdU5jr0o5kA1Iyjja1cviXdtV66javq
 c9R6WeZQfwYDpCDYAYJZE4LoSX1oibsmOkYSE+4ZXqEujynG9RYph1irTzVaQ9Mw4ipweLZ7+8I
 GZw==
X-Received: by 2002:a05:600c:6218:b0:4a2:1002:223e with SMTP id
 5b1f17b1804b1-4b8205955e1mr94099205e9.7.1794149107552; 
 Sun, 08 Nov 2026 06:45:07 -0800 (PST)
Received: from raspi5eynotyarden3.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-495bf0772c1sm3074754f8f.18.2026.11.08.06.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 06:45:07 -0800 (PST)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Sasha Neftin <sashaneftin@gmail.com>
Subject: [PATCH iwl-next v1 2/2] igc: clean up redundant braces and code
 formatting
Date: Sun,  8 Nov 2026 16:45:03 +0200
Message-ID: <20261108144503.97783-2-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108144503.97783-1-sashaneftin@gmail.com>
References: <20261108144503.97783-1-sashaneftin@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clean up minor coding style issues in the igc driver:
- Remove unnecessary curly braces around single-statement `if` blocks
  in `igc_tx_map()` and `igc_enable_nfc_rule()`.
- Fix line-wrapping and indentation for fragment size calculations.
- Remove trailing empty lines/whitespace.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++-------
 drivers/net/ethernet/intel/igc/igc_ptp.c  |  1 -
 drivers/net/ethernet/intel/igc/igc_tsn.c  |  1 -
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 019f0c2375d7..edfa042ed71a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1415,9 +1415,8 @@ static int igc_tx_map(struct igc_ring *tx_ring,
 	/* Make sure there is space in the ring for the next send. */
 	igc_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
-	if (netif_xmit_stopped(txring_txq(tx_ring)) || !netdev_xmit_more()) {
+	if (netif_xmit_stopped(txring_txq(tx_ring)) || !netdev_xmit_more())
 		writel(i, tx_ring->tail);
-	}
 
 	return 0;
 dma_error:
@@ -1617,8 +1616,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	 * otherwise try next time
 	 */
 	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
-		count += TXD_USE_COUNT(skb_frag_size(
-						&skb_shinfo(skb)->frags[f]));
+		count += TXD_USE_COUNT(skb_frag_size(&skb_shinfo(skb)->
+				       frags[f]));
 
 	if (igc_maybe_stop_tx(tx_ring, count + 5)) {
 		/* This is a hard error. Write the tail for packets deferred
@@ -2795,7 +2794,7 @@ static struct igc_xdp_buff *xsk_buff_to_igc_ctx(struct xdp_buff *xdp)
 	 * igc_xdp_buff shares its layout with xdp_buff_xsk and private
 	 * igc_xdp_buff fields fall into xdp_buff_xsk->cb
 	 */
-       return (struct igc_xdp_buff *)xdp;
+	return (struct igc_xdp_buff *)xdp;
 }
 
 static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
@@ -3900,9 +3899,8 @@ static int igc_enable_nfc_rule(struct igc_adapter *adapter,
 {
 	int err;
 
-	if (rule->flex) {
+	if (rule->flex)
 		return igc_add_flex_filter(adapter, rule);
-	}
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE) {
 		err = igc_add_etype_filter(adapter, rule->filter.etype,
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index b40aba9ab685..fe808ffeaff7 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -649,7 +649,6 @@ static void igc_ptp_enable_tx_timestamp(struct igc_adapter *adapter)
 
 		set_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags);
 	}
-
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index d23a45a34fa3..0ccba557918d 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -243,7 +243,6 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 {
 	unsigned int new_flags = adapter->flags & ~IGC_FLAG_TSN_ANY_ENABLED;
 
-
 	if (adapter->taprio_offload_enable || is_any_launchtime(adapter) ||
 	    adapter->strict_priority_enable)
 		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
-- 
2.47.3

