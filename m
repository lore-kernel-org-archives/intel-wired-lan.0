Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2D8C61DD3
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 03:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CE6080DD1;
	Wed,  2 Sep 2026 03:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKxJpqjgpJ1Y; Wed,  2 Sep 2026 03:29:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788319785;
	bh=gZ0kKM6EGOh/iG6MobiDle5RWpCCg6ryEvbje4v46XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wRyiHlZhticVKkFpkCT3IgO3EdDIHtKZrfYr0SFYN4/iqF3mWwExzL4AOqiYLl10v
	 nn5PGz1PCPsMCvNF09N7VjQqDGoxmmPu1tkO7GShmCv+jBNISHOLAv95RU26MENtde
	 UpDca6oE/mWhuYmxUnuhrqdQwjaVVDmKqjxp0G/902bQfhN7UOfOEhuutGG0nUYZw5
	 6iU77Xa6Ke02luqozQ7LmXQLDNsB5s9MNUHuz19UfhZPF8BYZ/uDoMCrcmQnrLdOvl
	 kh+D/6nNpYpSA1At6gDxVDGjjQsNBsQIYAcz9RuT7eThMfKGp6rUnxEhY2zAEQ3Bm+
	 7R9QRZLLlZrNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2564880E27;
	Wed,  2 Sep 2026 03:29:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DF742FC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23CF56067F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZuOG1lkl43JC for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 03:29:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aHQMKUo3
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 795A560677
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:42 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so560182a91.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 01 Sep 2026 20:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788319781; x=1788924581; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gZ0kKM6EGOh/iG6MobiDle5RWpCCg6ryEvbje4v46XU=;
 b=aHQMKUo3XH3ZMBBwDBP/1SSjRddgciKBlyElfldHorjbNOTyX9ykAx8T0+CL5hXJi0
 iGHybrqKSAYliMYlB/+N7TZMheuFcR8yfRg4oyR9nxy+vNLBE9EY8+ABbNaR4nDNFGsk
 vq3K5G9GUnB437iEBVtUO4o3JQkJTvII5nIYDIyYao7Oc/2IHuxMSVr03HGi0hqKEK/e
 GR2AE8DLpACaZuSm+oiN+YAmdJTyhljmU5hZROd1PhMsI/HArMo/M9UT8LDT1UNq38aM
 Yu05YV0mLSuGyRtXD6PzePMzeVEaOLIje4aa2RpXVXNeFh+bfIho88Yc7XyZUhRuHg94
 YzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788319781; x=1788924581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gZ0kKM6EGOh/iG6MobiDle5RWpCCg6ryEvbje4v46XU=;
 b=HVuNSBbwDjl5YyaFs6MltXg2d7Ef7Wyu7ExSZ3XfkltdG5R2JoT73mNqr18pml/YNb
 ckbhCYp+i43IexavKtX4ugrclRQJAVZFzJf5crSKvEAhKKhhTx6/5e4YaWo7itq78+VM
 xNTGsCQbZ3BSw8oaPUVGMrmJrPUtftoACrEwtGPsR9cGSp4z7sXvstCxBW+ADLmoTD9E
 s7gy7prYdWNGGMN5k1G8Ou8D337gib6n8OnI3fIh8a3NbXCJLWe3BlGT1yeMH4qk1voN
 Q3tjFa2tH6I8aOHUAGC2XeFTwDdZeQSX18/3ynOu2g83bFU40/9i+nsQJtSAaO2lw6EG
 EEbg==
X-Gm-Message-State: AFuF++n/go7ss5DZntoEtH3aAfFUg5SZZ3SSZ38hnMtCwc4rLgRg3wO7
 cC8IhAJx4dVGU7nN/5dJC8r1r58qUnw2+P/TJLMSedT21b0ZOgbtj71d9MAY10/QcsA=
X-Gm-Gg: AYBFou3ArYSoKwty5DLy1W3wws/CZTVBBg1mV0WjNXEezjeatg8ycHuzHwo910oXvwh
 9XFBvaO/40JSewN/hCIRwOjlgAFz7RBbUxmAEjiS6buv2hxK1yGPg+YCgxiSEqs4dqmtOreCBoB
 9ZR5H7TTUfxnNnC42/S4ENy3Bme4GBZsYNcZfuUAKIRi383QO/B7a1FjfmvRPjcp70Tt1laROmj
 9kFZRRct2PDwJKAHkor8ZKNv/nGI1gc0LCVsfaRwU0tY7nCOtVIJ69YZqW5vVKAMggOQWVtHlBp
 TuDiL2ZLfWWGHbHJMQVU1MET7yDaetAmYH4xhj0esRxKZrBRf4g+b2jhsZHbA1pWWzCiK2BAkI5
 Gcd4ebcAiSU04OTnLYNAjIZ25IX7ySLszDe+bYSxmEwINt3TMDVjmFGsHTB9/xIeShhe24E3mLo
 hyGthTMuMjTeVq/5SBaEyAgrhthu0sF01F2bPoBL6xwUwnV5SIKro=
X-Received: by 2002:a17:90b:5606:b0:398:9be6:f996 with SMTP id
 98e67ed59e1d1-39aee1115e0mr2822094a91.21.1788319781337; 
 Tue, 01 Sep 2026 20:29:41 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07baa594sm3099307eec.22.2026.09.01.20.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 20:29:40 -0700 (PDT)
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
Subject: [PATCH iwl-net 1/3] e1000e: fix Rx skb DMA map error sentinel
Date: Tue,  1 Sep 2026 23:29:11 -0400
Message-ID: <20260902032913.661570-2-tactii@gmail.com>
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

Upon encountering a DMA_MAPPING_ERROR during skb allocation and mapping,
the driver would leave DMA_MAPPING_ERROR in the buffer_info->dma field.
This would lead several buffer_info->dma == 0 conditions down unwanted
paths:

* In e1000_alloc_jumbo_rx_buffers(), it would not re-attempt the failed
  mapping and instead write DMA_MAPPING_ERROR to the h/w descriptor on
  the next allocation call. On cleaning or teardown it would attempt to
  dma_unmap_page() DMA_MAPPING_ERROR. This case would only be
  reachable at MTU > 1518 and page size > 16K.
* In e1000_clean_rx_ring(), it would attempt to dma_unmap_page/single()
  DMA_MAPPING_ERROR (unless cleaned by the jumbo path first). This case
  would be reachable at any combination of MTU and page size.

Use buffer_info->dma = 0 as the sentinel for "DMA is not mapped." Set it
immediately upon detecting the failure.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..26f45ee8c7e7 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -691,6 +691,7 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 						  adapter->rx_buffer_len,
 						  DMA_FROM_DEVICE);
 		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			buffer_info->dma = 0;
 			dev_err(&pdev->dev, "Rx DMA map failed\n");
 			adapter->rx_dma_failed++;
 			break;
@@ -791,6 +792,7 @@ static void e1000_alloc_rx_buffers_ps(struct e1000_ring *rx_ring,
 						  adapter->rx_ps_bsize0,
 						  DMA_FROM_DEVICE);
 		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			buffer_info->dma = 0;
 			dev_err(&pdev->dev, "Rx DMA map failed\n");
 			adapter->rx_dma_failed++;
 			/* cleanup skb */
@@ -877,6 +879,7 @@ static void e1000_alloc_jumbo_rx_buffers(struct e1000_ring *rx_ring,
 							PAGE_SIZE,
 							DMA_FROM_DEVICE);
 			if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+				buffer_info->dma = 0;
 				adapter->alloc_rx_buff_failed++;
 				break;
 			}
-- 
2.43.0

