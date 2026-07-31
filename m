Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65747C5516D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 12:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2925260B52;
	Fri, 31 Jul 2026 12:49:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mqHXZ5q5_yHh; Fri, 31 Jul 2026 12:49:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9FE3560B24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785502183;
	bh=6+bsZsvLjgWGQPi3EMCs77AGqgUuxi4LRoiemM6mPsU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wjR52+kQ14Q058Kg5qz7v7wLLgFgLOylGhkAc6s5S76VKuTD7hj24fFbJVvgddpof
	 Zq5B7HInwN7mWlXrDTX5lSiP7dZAmWss22XAm4CJNtnLvyz2wnd0Bpc+B2t/6LMxHz
	 yUL7GyJjpZpLOadFZs+Bswyd6YlGF43bUTdOZKjmLD9zyeqAUK2XgfpoZMG2bmO07m
	 JF6LrJmCTBCUhoGfS0KPRmwpa1oxRw7DPt9yuF1J8tzkRPUXzv9S3hTNa3KTIUg+lw
	 KRwQb1cj3a/HUGG0Jj9Zsf99S1n6qHi4GgjYqPAHiRNQdF9UNwYMtn4rIwIJbSgP0x
	 m/RAqO+ae5d6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FE3560B24;
	Fri, 31 Jul 2026 12:49:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EF1C37F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05C0D410FB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gVdKDK3miAAY for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 12:49:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4C203410E7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C203410E7
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C203410E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:41 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7ff05e5d009so12029157b3.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 05:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502180; x=1786106980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6+bsZsvLjgWGQPi3EMCs77AGqgUuxi4LRoiemM6mPsU=;
 b=cb38GLaQtMhi5LS0NmZeBa6svxhPtjZSdrjywpJxYxiRCbYOlvSqh9AgwndBTDZsh4
 QH3XB1GBQNBlA6PXbhAOQIg1kPl4h8aWicuz2J1ZH20ERezrNRoHu6ow6+CFs6sNt8e6
 wXIk5L7x5zdNOxwRBvu5LWnqIf34rNx0IstaR1I6yoVk6Rm76cEwUO2h3tjxUGyjdxOi
 XMymgLS8W8JN30ReK+KkJZe2cRMBK9gVoHASZmm38XGmfhf9qngdxB/TkBh+Tm5//I9T
 pLJzBeDJEn4AoFPF/aMdbpLtIUHD4atw0QU4/eAkCXOq3yh2M0oOgv2IFhBwvO98xRfI
 awwQ==
X-Gm-Message-State: AOJu0YxP0HZR2OEIAAbym/qxKTvA+j2smAfQ8Cg1BSNfAxRCVdNZ5Qag
 jTfoTMDUqjJRcNyE7Qs4qfT+vwZXPIUkJk1qc75nUz3hdr1gTnuqyWJkt03/27+S
X-Gm-Gg: AR+sD11WnjC48FhnLdd/yTKRxJuFQKoNTMA4YCeLs/bzjN+I/FWGDRsijFj+APsiMXy
 d7xUnK5D9+FAm3D4QlbIxt1A9j0Kw4gktG6ZYE4BjSOQFkatRD+oTl+l6zz1AQmxgDrlieKZNc3
 e3zfTTGwP885Dn7gwe8vF8APFRgDGTgaAE7oyiwu7Knyr/9jz3PKkxobUBM58HngvSZF1H3n+b3
 nMk4kC3CKuBaFTOxTu5c0VBOkvdOC99b70uHY9h5xsGFk4/9m1ShL8mpB9l626BL76YwD+Y8xzo
 k9/m1a4N0jxdgWlmoe6lX+gAYrkb6NaUr4Ow6YRdblX8pt2vPFC1mCD7ufnpQNW6x/R16/vvtIh
 uIOL0Fo5aqAv8wYQDBR8Y0C9mW9QV45i6y6fptC9TwFaBHZ5UDXDY2+BaOqCIJ0ltcMjrOEhqe8
 EZHpX+u2BkcNgYl7S8mQM0hW/4Aai22wGiXGeXnNfw
X-Received: by 2002:a05:690c:6f08:b0:7db:ccda:a409 with SMTP id
 00721157ae682-81fcb971568mr16571697b3.9.1785502179974; 
 Fri, 31 Jul 2026 05:49:39 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fcd108f0bsm5695367b3.35.2026.07.31.05.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:49:39 -0700 (PDT)
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
Date: Fri, 31 Jul 2026 08:41:07 -0400
Message-ID: <20260731124109.99065-2-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731124109.99065-1-tactii@gmail.com>
References: <20260731124109.99065-1-tactii@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785502180; x=1786106980; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6+bsZsvLjgWGQPi3EMCs77AGqgUuxi4LRoiemM6mPsU=;
 b=DZ4Wgm6S2/PAT795RUe+7eJiQ8pvvgIjbCOAH3rqOmSEGwqvCvDi1Vfc3R30gEpOQT
 mjRmxNECgwU3ZxJj0AQcgHJc9tHKI1zPlvqhcne8EouukDjPnNlhUqwbS4OTxBei4nbd
 N4tpwh1XihnrTrJbR0zBmGAdA1fNZvOxIxaTPJt4aE7ZgcbYrhG9yn23etPJmge1Wc56
 Y9I50NmMf+qmuUqy0Dtbsb0F8tydpTBgCFYpkQ8/GXj59rLPKCD0/MSjeOtou0XKL79Q
 6Th++T4W51ylGgHpOyFHUcMEjxYHWE2PTynP+CHQHIdK5U1kHQWN8UDrh/X2GUQbHeS6
 FsbA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DZ4Wgm6S
Subject: [Intel-wired-lan] [PATCH iwl-next 1/3] libeth: add
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

Deriving a netmem's page pool from the ref requires loading a pointer
from the netmem_desc, which may not be cached. The driver may already
have a cached reference to the correct page pool, so add a bypass.

No functional change for existing callers.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 include/net/libeth/rx.h | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 5d991404845e..fddac084e001 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -118,36 +118,51 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 void libeth_rx_recycle_slow(netmem_ref netmem);
 
 /**
- * libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * __libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * @pool: &page_pool the buffer was allocated from
  * @fqe: buffer to process
  * @len: frame length from the descriptor
  *
- * Process the buffer after it's written by HW. The regular path is to
- * synchronize DMA for CPU, but in case of no data it will be immediately
- * recycled back to its PP.
+ * Variant for callers which already know the buffer's pool, typically
+ * their Rx queue's fill queue pool.
  *
  * Return: true when there's data to process, false otherwise.
  */
-static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
-					  u32 len)
+static inline bool __libeth_rx_sync_for_cpu(const struct page_pool *pool,
+					    const struct libeth_fqe *fqe,
+					    u32 len)
 {
-	netmem_ref netmem = fqe->netmem;
-
 	/* Very rare, but possible case. The most common reason:
 	 * the last fragment contained FCS only, which was then
 	 * stripped by the HW.
 	 */
 	if (unlikely(!len)) {
-		libeth_rx_recycle_slow(netmem);
+		libeth_rx_recycle_slow(fqe->netmem);
 		return false;
 	}
 
-	page_pool_dma_sync_netmem_for_cpu(netmem_get_pp(netmem), netmem,
-					  fqe->offset, len);
+	page_pool_dma_sync_netmem_for_cpu(pool, fqe->netmem, fqe->offset, len);
 
 	return true;
 }
 
+/**
+ * libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * @fqe: buffer to process
+ * @len: frame length from the descriptor
+ *
+ * Process the buffer after it's written by HW. The regular path is to
+ * synchronize DMA for CPU, but in case of no data it will be immediately
+ * recycled back to its PP.
+ *
+ * Return: true when there's data to process, false otherwise.
+ */
+static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
+					  u32 len)
+{
+	return __libeth_rx_sync_for_cpu(netmem_get_pp(fqe->netmem), fqe, len);
+}
+
 /* Converting abstract packet type numbers into a software structure with
  * the packet parameters to do O(1) lookup on Rx.
  */
-- 
2.43.0

