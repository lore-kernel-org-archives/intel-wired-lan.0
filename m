Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A09C5516D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 12:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F223410E7;
	Fri, 31 Jul 2026 12:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KGuMFecFYt2P; Fri, 31 Jul 2026 12:49:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 246F0410FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785502186;
	bh=jG6/m0wFIS3acCnXY9BG108ect7Vn9Ccjk8vk1+isvU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C1af14IRPMivQ0dsbCXXfO0xfNBTwMU0aQI9px1x9p4jrQ6cfF02lpuivmc7U4roj
	 kcbiz6tTrD7FRFC/W1FmSQmTw8DMJEwlFquyOZFyNfIKBaiqPZbsw9lghUHW5p1hrl
	 ao1QgLawW5ZH4TWk8FDE8KP5NqIOm75N9LyTUJpE1yQxRrGCKhrN1UeZRJF8mg8oEi
	 PErDlEXFveB/0Pz7MgVFZnxCZ8ZkV6knnimbQVvgmx2ErWpfb6rHorOtAE9hmFQfgc
	 vCmFiAkDdNJvTGFdr0cIWPW751Tpzw1XzRFN9sNVfYHOdZ0VPEzeVhq/FIaLKSddVw
	 xSqGXXIbeXIdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 246F0410FB;
	Fri, 31 Jul 2026 12:49:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 764CF2E9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 685E440471
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Scq3Xu1mDr3T for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 12:49:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A391240234
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A391240234
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A391240234
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:43 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8143daf89c7so9064847b3.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 05:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502182; x=1786106982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jG6/m0wFIS3acCnXY9BG108ect7Vn9Ccjk8vk1+isvU=;
 b=Z0p+X4J61/YGwqfrv4O9jiw8cy3vq7FBwGOG37jxsSzVkkYVLpWunbFMjFdtpauHq3
 IzWxJSdohiwYOPIWGL10ptDYsbMdPSKLzgNIzaGDe974U58DH/kWTaMQl7zQG4BUMKWt
 i5eU1uQwDWfe+lVuCvn6RKHVkbuufaePyeJsM6zfMCmDD7wjevKF8Bn4LMExmltJQjWj
 PGcO0OJmugrQTaFVnJtd/zujQOMESN4AAskJb5l4QHMXBYsnGjssEw37ZDFS1qQou6ER
 YzzeGPuq/cGh/jpQHprhnLblAIeURLz+XZ407MvUTRlwvtwDHdIGR7iQaOTrsHzGT5HF
 vFRw==
X-Gm-Message-State: AOJu0YzB0zM2hYp1fZlBEvAc1DBLDeV3kx8trRHU8Bk8WAayl5C+fIQp
 k7BuMunCal9ctN2eQAI7WDDlQ1t1G8ckCj62v0S3rn37cdm5YqQ+AayTxy5uCg02
X-Gm-Gg: AR+sD11b54CGK1jKB1dAeYEW4D3G9hVx/ggUWKC+Iu/WBZ8Pd3tQ/1LcVwVcbP2bHVd
 OOe1v6gvMymfNrkgDjXm3NTL4x7coeWa/bBElK0EioB078M59rDMUwIQJ/AiBkhG0zT+Iu0q+TW
 +xXZn4iugfnwIg8cSwsC6HEhkYuceiOBRW6+QYjC/4QSDUWNzfI084NfyfrNSQXVpVGu1tUhYvl
 u2As00HR3tUZvc2EVPOptQPp2IaEW8aRK+HVGzMaprx8B7QhsWY0TWaXv9AX1pMbPx3Jm2Zwnct
 aWTAm+63tS9HUTLGcpyhBlc7TOuUeLns6LVmqaatKQYNouoA43wSmdAQKQO6AftcnUbzzwy8hG2
 CCX4dWHJdruX6Ainjt4Inv5fv9+D6B5oJBDZTNPzld+PFym4PK+2b4MjEPtG1CkHl/vXE24yLEc
 wLb4yV6Wfi3JGkKztqK0A3DDqquMf2QwKoy6O6iPAy
X-Received: by 2002:a05:690c:61c2:b0:814:4755:2b2b with SMTP id
 00721157ae682-81fcba55a69mr16655277b3.3.1785502182259; 
 Fri, 31 Jul 2026 05:49:42 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fcd108f0bsm5695367b3.35.2026.07.31.05.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:49:41 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Matt Vollrath <tactii@gmail.com>
Date: Fri, 31 Jul 2026 08:41:08 -0400
Message-ID: <20260731124109.99065-3-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731124109.99065-1-tactii@gmail.com>
References: <20260731124109.99065-1-tactii@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785502182; x=1786106982; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jG6/m0wFIS3acCnXY9BG108ect7Vn9Ccjk8vk1+isvU=;
 b=jPrAz32xSLoW7/9Lg/R3Myhz1/0T1iK4uUJTdgEgQE2WwS4Rj8Xx/BsuixYHS6E8U8
 mvRQE3V/6UdrMti1MFGDIwYtbiv8WHC7o4uCn0jRdjts+dyDEvfCS6ft+tUdcwt8vWc4
 hagL4CNjB1ZYuZ0RzABvDsw8TuK+j1pOFUvTzlApTFTmXWrtAa1JM9YJWeLMaz2BJSZC
 f4BQKLypuxRMmyIZwzBnxKfpCn3rZSURv6VmBgb5++QFLTpt0AK05furOYCIcCqOqOY9
 TXFOGFyKDWkmtAeFGTBtt0HoXYpDxf1De5hK8qtJlvE5kE0/u04hzg4TxHiF+KpZCzbX
 FWrw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jPrAz32x
Subject: [Intel-wired-lan] [PATCH iwl-next 2/3] iavf: use
 __libeth_rx_sync_for_cpu
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

The Rx ring already has a reference to its page pool adjacent to fields
touched every iteration. Avoid loading the netmem_desc for sync by
taking the shortcut.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index c30abf17cf5d..3ae2f0a0ee4d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1387,6 +1387,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 {
 	bool flex = rx_ring->rxdid == VIRTCHNL_RXDID_2_FLEX_SQ_NIC;
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	const struct page_pool *pp = rx_ring->pp;
 	struct sk_buff *skb = rx_ring->skb;
 	u16 cleaned_count = IAVF_DESC_UNUSED(rx_ring);
 	bool failure = false;
@@ -1424,7 +1425,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
 
 		rx_buffer = &rx_ring->rx_fqes[rx_ring->next_to_clean];
-		if (!libeth_rx_sync_for_cpu(rx_buffer, fields.len))
+		if (!__libeth_rx_sync_for_cpu(pp, rx_buffer, fields.len))
 			goto skip_data;
 
 		/* retrieve a buffer from the ring */
-- 
2.43.0

