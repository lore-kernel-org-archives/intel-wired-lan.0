Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD1BC624D0
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 03:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7D3040754;
	Wed,  2 Sep 2026 03:29:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_m0DTL3-IEZ; Wed,  2 Sep 2026 03:29:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788319790;
	bh=U1ZdTa+YPG5R8JD3WrAQzRV0ImB3xHixQQQtd7zdN10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fV4vwOuyatHffvqIZidIXE02Qd0WqJ1ew14w/E6lydNx7M4qOQBJk5wkRBrmti+Mw
	 sdHQzpOYHX11o9PcZR838Xvgf3V6m/u3oVkkjXV7ZE84Dyz9i1FOksN0Rf8fn1apw6
	 /ig14kDCj1dfmGeDbuumvFSytmSGjLJr9hluENEEM3hr/XK/9DKeIC/xYLCAJdMMdw
	 f6tF5BEtoN/LU0N6jJpKQwStISthenhC2plAqsZ77M1xpLiIxlUQIlMX27TLm3aJEM
	 cGNYoIMqeHTwx3/7lIbY/ep7A5WqUxkvTXDhGd+DbBRgbfyXjEK2eDbI52k35pgR2G
	 TsKYU+8O7z+xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4B3240774;
	Wed,  2 Sep 2026 03:29:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CC302FC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2C7A40774
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujPi0s5sh2mk for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 03:29:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=faWjGfvU
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6ABF94073A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:48 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2d715f4a587so8224805ad.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 01 Sep 2026 20:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788319788; x=1788924588; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U1ZdTa+YPG5R8JD3WrAQzRV0ImB3xHixQQQtd7zdN10=;
 b=faWjGfvUD0b99EabCwsbgchOmW5vmKU9Kf+VBFNbcDVNhCKRkPKhnSiOjYWTV882zl
 5CeBpe2YExxwlx4btV3wYYGKmUtP2nvAOKR0dvdjoaaPXxlpjWEfqgN4sj+LO9Yp2p0g
 h9oLrFuhy7qlhIHl5uAntjz+jSbz3YegYkU7itAOCu6VIT7CScPCqKUOFMh0gH5WaD8X
 o5GGM0LbCZpS5VhEsdNK3Jeg3hCowiXr0MQpkgo2UZQQLnBcQ49BfvOWGVyNdW4ovxG4
 7iDfAasepxtEnI780rFuPQ8mHrCVHDLRlXwQBU8drvB2FHlBG9Rxz74w56NcZkJ1iCXw
 zDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788319788; x=1788924588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U1ZdTa+YPG5R8JD3WrAQzRV0ImB3xHixQQQtd7zdN10=;
 b=KCEsVuzBxw8En2CwGYR2O/d/efHaohJnLajFrwg3kBg32uE7jMlLBaZBIaMmlPXFC8
 ACVW+GKAcKKuz37ZXJTY6LPyjpz3WlGi1yirLPZluyNJQTgGWH/8n95h/0QD7PZL/70U
 x+dyGBHaOjJgJPb7IFLPYd2ZTpsLmwD6vjBmFwFcv+F99/lGUFQ6Qo4BaddF1LhOvSKi
 KkgkDYmEAQ2slQbtY9ijQLfR1dQtUVtjB5ZQrK5cXfY9qf+RSFNHfYQwU0XObdr32h95
 5BcninNPgpK/s+Q5XbPJM7WCSCZQZS4s7Ok7VoT0Qsq+5zEJJqEZE3kSWKXF9tLDC+Vl
 BZgA==
X-Gm-Message-State: AFuF++k4JJ2yqO6/yUGQLJ4v4Zl6ypcW7kY3fuvfSCiFQ/F5bAny6DcN
 u4chtaIZjDeE9w1a1HCeGAozEm/g3Ge2eN4Wzehh9NEqg8Sf4bQQuMxLG62wRlqNp6w=
X-Gm-Gg: AYBFou0cPbrZGKFwZ5xG+IScWWIz5gCfP/+Y1bwSk5JqoULOVcFc/9AWbx8wvEQ2AtZ
 D8kwMgstRnsemg5twV2kgj2pWyWG+CK8CdutXfZepr+SSt43SquqTmjG3PAR5xpraJJJpD6UxMi
 pWDYqE7lz3CYcZiisk4d2tyZK776G7ptuE0NqbpFqLIQ5Ym/lkHr8bvlHy+GipTBvlsebpsnvWE
 HfI4DD/SO/TkhcQPQTGnzXUacbffYRoQQIiVQj2AAzKWGY2roa1rwi0gKoAHKiyimEqdSHy640h
 bQigfTt+STXrxfn+upyj3EqUKC1qX8eaTUPn7qJmJSNSbqxKVmSqzupTZ1J3+nxcyDOln6pCSUf
 NQS5oTovwCODkeRbBkaPwrjfciW7hwoRPXylNDmW9jh3bYTuiUooyroEsaLE8DZgq1RV35WQXSI
 NsauFmKHZXeA3JMLZKTuWq9iDRHfHYA6O2EAajie/z
X-Received: by 2002:a17:902:d482:b0:2d9:1dee:43db with SMTP id
 d9443c01a7336-2daec7368famr25186725ad.15.1788319788333; 
 Tue, 01 Sep 2026 20:29:48 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07baa594sm3099307eec.22.2026.09.01.20.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 20:29:47 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matt Vollrath <tactii@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH iwl-net 2/3] e1000e: fix ps_pages DMA map error sentinel
Date: Tue,  1 Sep 2026 23:29:12 -0400
Message-ID: <20260902032913.661570-3-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902032913.661570-1-tactii@gmail.com>
References: <20260902032913.661570-1-tactii@gmail.com>
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

While allocating packet-split buffer pages, a failed DMA mapping would
leave DMA_MAPPING_ERROR in the ps_page->dma field.

This would have two consequences:
* The next attempt to allocate that buffer would write DMA_MAPPING_ERROR
  to h/w if all pages are allocated. If the h/w uses that buffer and is
  handling a frame large enough to touch the affected page, it would
  cause a DMA fault and be dropped. The driver would then call
  dma_unmap_page() on DMA_MAPPING_ERROR and unknowingly send the
  uninitialized page up the stack as part of the frame payload.
* On ring teardown, dma_unmap_page() would be called on
  DMA_MAPPING_ERROR.

This condition is only reachable when MTU > 1500 and PAGE_SIZE <= 16K.

Fix this by setting ps_page->dma = 0 upon mapping failure and separately
testing ->page and ->dma during allocation and teardown.

The rewrite of the ps_pages section of e1000_clean_rx_ring was necessary
to recognize the case of a mapped page without a valid DMA mapping. It
also fixes a separate bug which would potentially leak pages on ring
teardown. The cleaner stops cleaning pages when h/w reported that it did
not write to a page in the sequence, leaving the following pages
allocated and mapped. The teardown would then break early and leak the
unused mapped pages. If the ring is re-allocated with similar
configuration, it would reclaim those lost pages. This would only affect
configurations with rx_ps_pages >= 2 (MTU > PAGE_SIZE) and the same
condition of MTU > 1500 and PAGE_SIZE <= 16K.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 26f45ee8c7e7..063fc8cd2673 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -759,12 +759,15 @@ static void e1000_alloc_rx_buffers_ps(struct e1000_ring *rx_ring,
 					adapter->alloc_rx_buff_failed++;
 					goto no_buffers;
 				}
+			}
+			if (!ps_page->dma) {
 				ps_page->dma = dma_map_page(&pdev->dev,
 							    ps_page->page,
 							    0, PAGE_SIZE,
 							    DMA_FROM_DEVICE);
 				if (dma_mapping_error(&pdev->dev,
 						      ps_page->dma)) {
+					ps_page->dma = 0;
 					dev_err(&adapter->pdev->dev,
 						"Rx DMA page map failed\n");
 					adapter->rx_dma_failed++;
@@ -1722,13 +1725,15 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 
 		for (j = 0; j < PS_PAGE_BUFFERS; j++) {
 			ps_page = &buffer_info->ps_pages[j];
-			if (!ps_page->page)
-				break;
-			dma_unmap_page(&pdev->dev, ps_page->dma, PAGE_SIZE,
-				       DMA_FROM_DEVICE);
-			ps_page->dma = 0;
-			put_page(ps_page->page);
-			ps_page->page = NULL;
+			if (ps_page->dma) {
+				dma_unmap_page(&pdev->dev, ps_page->dma,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
+				ps_page->dma = 0;
+			}
+			if (ps_page->page) {
+				put_page(ps_page->page);
+				ps_page->page = NULL;
+			}
 		}
 	}
 
-- 
2.43.0

