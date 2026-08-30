Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32292C61DE2
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 23:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEE2B4046C;
	Sun, 30 Aug 2026 23:22:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vp1tu-yLztim; Sun, 30 Aug 2026 23:22:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788132147;
	bh=oDyIKzL6PQfyOtcZdXIqJp7bl04CBybW0yg006Rr6/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yu0j8hcv11+jvciB0qOkOfv36aCfJbg4YRRAnb9spEjgAFDAAjVse21l4PA1DCfRe
	 AY3C7bvxmvNSWhyqNE5B/3XcRBQtQujmItd/Fnr7S7dOJhPFFcmsipXQfKiOi4gFXX
	 E2npPvfWWuqzsiu8Mkkv6/zdHpcYtoIbqKyiYAhaGpZf83UZG3t/S4fU7lKKnKNuVc
	 pvZ3+iMJF9zk6eCWd2VWA4O60gIhbFT5dIUUNuuXHfNflb/QwvveBZw3IAvAU89sLu
	 Zhw+BSK785lUf6Xt1EQGVkBAGd9LBgB/C8XLXqirmnSYnm0b0jnpRSes4v7Gg1eaUr
	 mT0APLg0hv2aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC26A40462;
	Sun, 30 Aug 2026 23:22:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81EA4334
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F59C605D9
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id myStZchdoDJE for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 23:22:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=naLFX6nQ
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6054605D3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:24 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-855a66e5b5dso26626757b3.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788132143; x=1788736943; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oDyIKzL6PQfyOtcZdXIqJp7bl04CBybW0yg006Rr6/Q=;
 b=naLFX6nQ/TtewRUjsR7zXh7Lq2z3vXAOQnurPfR797x9z4G99eBClbsV2PqdkrpEK4
 Qc6C9W01uoiybJaqWS846CXCMQMFW1qvsU4ohVf0uOOp0YwSWd7GBTJuYg8hxqNsdNa6
 gum+s7IOWXOb8XbWmPo6nq5NC6NzNVa3KJW2+NA7ux74uaY/DAP8TLmxquwEtXNTdwKg
 0hDHmdYdd+BIgkrJ3leAAOqbEEUqDHcu7EFgStvfLyH0e7xiHwXq7NQapE4Fr9RWSQJk
 VSSy2aricJMVKScfqXGRbwuRvBcJb2b6PAX6NEBr0ITilH5QPWbw+JRgsXhjjBNYa5+o
 FyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788132143; x=1788736943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oDyIKzL6PQfyOtcZdXIqJp7bl04CBybW0yg006Rr6/Q=;
 b=eU1J8x3TcuHYtDcsKXdnmj6ni13aiUIosEOxMuRrRs0r6nu3YXeIVTSM7S9t8IJo91
 SQWDOkLILnyAEX2SukGFRmiZwMgCvH7vMMggiiVXB/MFCQ6YC8eUdgnR6OHY1egmCGBs
 cBbElbFyZKY75jPRGuWQXiEfaZ+dSvTIQraVa/oN87gU8B2FqADttolvoLpaSfKpTrb8
 RakQREWw29pZj08k+7BLuhUucAfLXBaXIHly/k2ynIm/CIJeBEEuKGOwr+mmP8xMH6F5
 5E/qMJJpN1cJVl62j7FO/LUisdpph3vHlMvRnkbt4/4TDM0ZRbYxLRWN50aV8DqEwXjx
 0iDg==
X-Gm-Message-State: AFuF++kZwAzb6LahGuzfnesMCGYQIsaF3bHW9HDzAW8IV9j7lVRiVn18
 BnLtl1TLk0+RzSBiKyQ8wBBEpwQmBf8p3gvUFb0AHc+IHwhMhzXqKwa4b/foa8t81d4=
X-Gm-Gg: AYBFou3Qs7s6WEwxiqzaHop4PBSvX0RpA907QGp5Jm9dDAqdLl20Qey2P570Au6ZTIw
 n9FfdLD07C0+R8Wmt48waIkQYMktb4wfB/12OX+mu4mBiSIys5e/kmdB7s+fvI6ODv+hsyMO0gU
 dCzSjQmritMY8Kt0ZiRt15MooL/JdBfmVZHRoINpMuWq2fCIfGpS4FSpJx7EfTou/LNoXqfRULQ
 hWbIZzZNHbepsY8qi+FLxJjj5nakkAgwo+xJHQoEvtHnsT5XdEEsP/rKQsmSh4LZA70YO/16gN2
 iH4vQhY5GIlxDdW6gLqaHrWJYYxoGP7qOVYadpA6TJDwj8If4m1COz4fPW9Ed/iAde8u20H9syU
 CqZ+9zIsgYZRXzs1OSoJLoz71KQYSXxmgFWugqdvjy8BBqpNMmQTSHh6W60XcrHDzUJy053yKnu
 HoPSkRB/5ycYRl2q8vpRf3KGy2hqGN5bHYEAsQ0fK3zq47EWAk21g=
X-Received: by 2002:a05:690c:e294:b0:862:65f4:c8c2 with SMTP id
 00721157ae682-86726879df3mr283417b3.21.1788132143343; 
 Sun, 30 Aug 2026 16:22:23 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 16:22:22 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Vollrath <tactii@gmail.com>, stable@vger.kernel.org
Subject: [PATCH iwl-next 2/8] e1000e: dump pages for jumbo Rx buffers
Date: Sun, 30 Aug 2026 19:21:40 -0400
Message-ID: <20260830232146.36948-3-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830232146.36948-1-tactii@gmail.com>
References: <20260830232146.36948-1-tactii@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The jumbo Rx path keeps its data in buffer_info->page rather than the
skb, which is only a shell. Previously data beyond the end of the skb
allocation would be dumped. The jumbo path would at best dump useless
garbage. At worst it would dump arbitrary kernel memory. This OOB read
is only reachable when page size is >16K and MTU is >1518.

Dump the page instead when it exists. Skip dumping the shell skb left
behind when a jumbo slot is cleaned.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Fixes: f0c5dadff3fb ("e1000e: fix panic while dumping packets on Tx hang with IOMMU")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 599600ad695c..47ff3c6ab451 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -465,8 +465,23 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 					(unsigned long long)buffer_info->dma,
 					buffer_info->skb, next_desc);
 
+				/* Jumbo buffers land in the page; a cleaned
+				 * jumbo slot keeps only its small shell skb
+				 * until it is refilled, so only dump an skb
+				 * that can hold a whole buffer.
+				 */
 				if (netif_msg_pktdata(adapter) &&
-				    buffer_info->skb)
+				    buffer_info->page)
+					print_hex_dump(KERN_INFO, "",
+						       DUMP_PREFIX_ADDRESS, 16,
+						       1,
+						       page_address(buffer_info->page),
+						       adapter->rx_buffer_len,
+						       true);
+				else if (netif_msg_pktdata(adapter) &&
+					 buffer_info->skb &&
+					 skb_tailroom(buffer_info->skb) >=
+					 adapter->rx_buffer_len)
 					print_hex_dump(KERN_INFO, "",
 						       DUMP_PREFIX_ADDRESS, 16,
 						       1,
-- 
2.43.0

