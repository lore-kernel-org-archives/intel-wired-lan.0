Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8E606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KVkFty2X;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FO9nP2WY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 664F460729;
	Tue, 17 Nov 2026 16:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mgA7GTZO1Z6I; Tue, 17 Nov 2026 16:29:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B24B360797
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932943;
	b=K9gPvVXFyV+1Cbe5osdJPlkDwUemKOEXoR2kQYKBDLo0pvpYOWTvKPrnFEUQscft+ve5
	 /0DZbaZj9MnoDPRRbo2TB/p9ky/E6b91X84D54Si9G/Bh/8icvlaYU2e5AjSaGLC5ja5M
	 RG1mc9uUzBE5otxhBtHtxVYurMfYn9s1cigfi4lXRyuXribUxEdXO2LTIN1qoaA+9EOoN
	 A6oQGkAXNmNLeMt9oVUkCpyS6778WR4TCvv0tXv3W7EiUa5djtKg8RPWjykxAi28/tcQ2
	 67NCmVkCHkb90EfH4QQydyiu0CxPElTO/2/iNqLamO8uLvouEMDoV38xypJxMCqsrtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X3DwMEGrZ57pkqE3y7BJjL3MnOYoEVHYkRTWJRAevnQ=;
	b=JAhTuZgNxdT1NK9ZKLIYnT0iCBTn7aLECqn/5NgfFLn7Bo9z2DlNOBk2MTGzIaaadYKW
	 ZYD7ogN1klTRbhz88k7qQHvFljktoWb44OE1d9tCDq6O05qh+sgfzPrx7GSCYU8zG2Swl
	 12imp0QrAQPmz1yJH8Ur8QcY6p2X1/vbWtCHUW2PIJY/wzyS0xYIpSZKV/YDNgO4hUM/u
	 JTSp8yqVX52o6+DpZfsKKVLuVrr7RgoIwEJ2IdxxMnu/ToR2GAZ1F9hM79DVI9KvitWJW
	 qkyb3HCYoCA3OiV/93Xt+pA1i1IpDM1VK+BSawJ52FgLNuNWhrVSMycyfjRT8dPNQ1Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932943;
	bh=X3DwMEGrZ57pkqE3y7BJjL3MnOYoEVHYkRTWJRAevnQ=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KVkFty2XWNrDaysAOCxcZJud2aAL2nglhceuVRkApVQu6ajnTxM+CUD8ZBPxtLXrt
	 /ukYg7nFQLHKjZwEhgsXfsuqb6eyR5yvNXL8qcm8wGOl9VRFIhVC/UMEjWZ2s3fm6o
	 vxVPWLoaXWLD4E9v/Q3HBoJ7bazBwHKv3TQ+W0YFZITTQMSV2TTgOvwRHSoQ7i/jlc
	 7Ze8h35UgL9QOmHjmHJYfmq2lgcCCX4t/qnwntXCX8Cdtjr+EJ4SXCZscHV626fKON
	 BhF5a5qP9Q9XeBvNBSLEFOdhRfxUg2csIKP0JXRIEyPop2Xcelu+WI8yW0KyxY31jy
	 o6MX/YgTs6Ebg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B24B360797;
	Tue, 17 Nov 2026 16:29:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62FF570B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60E578111E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QFu1f7RyfcAS for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E83480CFA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f48"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f48; helo=mail-qv1-xf48.google.com;
 envelope-from=362r8agukdxiabs50y66y3w.u6405bw3-e09wv-3s530aba.6ac6a3.69y@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=FO9nP2WY
Received: from mail-qv1-xf48.google.com (mail-qv1-xf48.google.com
 [IPv6:2607:f8b0:4864:20::f48])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E83480CFA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:41 +0000 (UTC)
Received: by mail-qv1-xf48.google.com with SMTP id
 6a1803df08f44-920ff6971a1so13530266d6.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927340; x=1795532140; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X3DwMEGrZ57pkqE3y7BJjL3MnOYoEVHYkRTWJRAevnQ=;
 b=FO9nP2WYuYdM04rleYnWjDO7HolfJTu3TpybEIEu0aJiDHtL+phdgKpK6SXQIIuDwA
 FyHOGGkSwGyzUYh7lsSIUiBncyTLxgVmIOosv42c5rdRvcviAKBLMjL/CTyrA1wr/M4N
 Yck8CHnox8qEkHcrZ56zVId7ISNmJ2hrQtX3hUpI6qmFyXG2T0Yrv0NOD0ap9vfPtwQP
 Rs0mVZyVeq53d6ZkkDK4Z5/mKncoBz0PmnGvSzMJmm+xc5GbklI3/8wNVKXVs0KjBkGb
 yWUWCm8J8t3Idg0bBEQWjora7+bj/15xCxfEDLp3CfSWRADzJmn+1oCsFfOEg8KKUABl
 o3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927340; x=1795532140;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X3DwMEGrZ57pkqE3y7BJjL3MnOYoEVHYkRTWJRAevnQ=;
 b=vNdRe5rTHhRqLSv1JqsEm6sE0SxocK2F/cENid7SVhXYWzwHu6PLP8/320DdbV7y3B
 AVcUSBt/YlqVGaH1AK7+jfPQYK9D/UdH/BjJlLhv4hhpp6R0osW7S+n9JzmkWZ2DQUes
 RpKaQIhlId3H+MD7bibyiIjkIguvYLUQHnAgm7wNyhGn03TdFXia3zjWxlH/3Gnd7J8H
 g5qLdsssEuHyLRwAKeOiU7Z9TswmEloZ6kVKgE4poDvHxUYRTJzqFY8xRPME2kekVxul
 NNVIxTKiF0JsGByXMUOlKa9wwgUAqGZIeVAFNp/t/jAK/D8jm7sSpD4yG8R8N6PmK0r4
 BwaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFgFRc8V96ffgXlj4tVtvX5ceviDDrOfVXVOtfKtanhM+AzKoU+iAiMnmBOgdDd11VRNAmK/naGUcbA9K/cw4M=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8nGd1vRVVjZ3dpeq+mvtLIEZ4TA3AIv3ZzJ5MiKHMJFRWKkVWS
 QZ5ZGIliV5MJ5PII7ELGQ39QOAsMPOwpRkGGs3CqZC3M7F0JjSkRS87CrRcp0UG9VsBe00x+i05
 xTA==
X-Received: from qknrh21.prod.google.com
 ([2002:a05:620a:8f15:b0:945:e9b7:7c18])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:870e:20b0:949:8a03:c35e
 with SMTP id af79cd13be357-9498a03c384mr411244985a.54.1794927339421; Tue, 17
 Nov 2026 06:55:39 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:07 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-2-stani@google.com>
Subject: [PATCH iwl-next 01/15] libie: wipe copied small send buffers on
 release
From: Stan Iliev <stani@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Madhu Chittim <madhu.chittim@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Nov 2026 16:29:00 +0000
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

libie_ctlq_xn_send() copies the messages that fit in LIBIE_CP_TX_COPYBREAK
bytes into a DMA buffer of their transaction, which is reused for later
messages but never cleared. The messages can hold secrets, e.g. the PSP
TX keys that idpf inserts into the SADB of the device.

Wipe the copy once the message was sent, when its send queue entry is
cleaned, and when it couldn't be sent. The transaction can be reused as
soon as that entry is cleared, see libie_ctlq_xn_pop_free(): order the
wipe before it with smp_wmb(), paired with smp_acquire__after_ctrl_dep()
after the check of the entry, so that the wipe can't overwrite the next
message on weakly ordered architectures.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/libie/controlq.c | 28 ++++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index 6214fc036ce5..c31d3c9e792a 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -694,9 +694,16 @@ libie_ctlq_xn_pop_free(struct libie_ctlq_xn_manager *xnm)
 		 * address is dirty in any way, reuse is already safe.
 		 */
 		if (xn->tx_msg &&
-		    data_race(xn->tx_msg->send_mem.pa) == xn->small_dma_mem.pa)
+		    /* READ_ONCE() for the control dependency below */
+		    data_race(READ_ONCE(xn->tx_msg->send_mem.pa)) ==
+		    xn->small_dma_mem.pa)
 			continue;
 
+		/* The small buffer is wiped before the message is cleared,
+		 * pairs with the smp_wmb() of libie_ctlq_xn_rel_tx_buf()
+		 */
+		smp_acquire__after_ctrl_dep();
+
 		clear_bit(free_idx, xnm->free_xns_bm);
 
 		return xn;
@@ -998,6 +1005,8 @@ int libie_ctlq_xn_process_send(struct libie_ctlq_xn_send_params *params,
 		if (!libie_ctlq_send_desc_avail(ctlq)) {
 			if (!libie_cp_can_send_onstack(buf_len))
 				libie_cp_unmap_dma_mem(dev, dma_mem);
+			else
+				memzero_explicit(dma_mem->va, buf_len);
 
 			return -EBUSY;
 		}
@@ -1132,10 +1141,21 @@ static void libie_ctlq_xn_rel_tx_buf(const void *ctx,
 {
 	const struct libie_ctlq_xn_rel_tx_ctx *rel_ctx = ctx;
 
-	if (!libie_cp_can_send_onstack(dma_mem->size)) {
-		libie_cp_unmap_dma_mem(rel_ctx->dev, dma_mem);
-		rel_ctx->rel_tx_buf(dma_mem->va);
+	/* Small messages are copied into the buffer of their transaction,
+	 * which is reused: wipe the copy, the message may hold secrets, e.g.
+	 * crypto keys
+	 */
+	if (libie_cp_can_send_onstack(dma_mem->size)) {
+		memzero_explicit(dma_mem->va, dma_mem->size);
+		/* libie_ctlq_send_clean() clears the message next, which lets
+		 * libie_ctlq_xn_pop_free() reuse the buffer
+		 */
+		smp_wmb();
+		return;
 	}
+
+	libie_cp_unmap_dma_mem(rel_ctx->dev, dma_mem);
+	rel_ctx->rel_tx_buf(dma_mem->va);
 }
 
 /**
-- 
2.56.0.679.gc527c65306-goog

