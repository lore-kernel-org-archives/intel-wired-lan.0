Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6330EC88E63
	for <intel-wired-lan@archiver.kernel.org>; Sun, 13 Sep 2026 17:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 158FB4059A;
	Sun, 13 Sep 2026 17:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9CAN93iHD1S; Sun, 13 Sep 2026 17:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5B02A40505
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789319788;
	b=Z43NJDhYwkJcGWh4UAP4cPkXBlfSNQuLfb59ZjcjswdE3Cj5Vy2cezjx0nVGAWigeazS
	 oax3Z6lgEDntMf+AbyqZ3rCsYIeIAUajVpGsFI4rqzStbX7t666wpI8KJN0nGQFd3ubd9
	 Aw93yA7hRsdkt0AHavB7qLXMy7bqTi2sueGZ0b/uRjO0iVfetnir3fxW97bQwXmDEQzJM
	 hNA2nV0KKvRTLu7NKRFdcOFVWjPuMr1yB4lxNn4mgcCtnMmmhB+ABuwKLn68hmDnnjmfQ
	 XDoLTldh9WtzhDbhAZ/70gLiPm6IyYFQyOctTnx+y3b3kL/HpP6SGn7RavozVEUAlWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789319788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GateTyBBPIQQ3kCKpBN9Gh9lEseqwXsnXnPZooaJ/B4=;
	b=oqcue0/XEFN8Pt5dLYagjfJjDH6yFRjQiI51D/d5QjV1Cj4lDH8hguR0WfLO8qlpnBsS
	 WdFEXmM21UEAnTHxZTIafVxbAf+QeiMUzMMCCkMppRrJMfc5WUlZJFefG40m+wJLTIW82
	 RrLrKqkXunK1M0bpPouw9sO4JCAgKgT+jWBZFb8pmraKIAANfKQQCuqA9zRrsuVvPt0ID
	 Vbd+lYjI00KEwi8PsIAOr2vq7tuKJKWbTXD2CIV9wrtwg4twypCayHQiofN6tcqD8X/dP
	 RgjJQmaovvnq4LLjsUtN7AQuT87Y0lf6qxkrm7fgvQ40H/IDpJx5uszaAOlFNhlICaA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789319788;
	bh=GateTyBBPIQQ3kCKpBN9Gh9lEseqwXsnXnPZooaJ/B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ToRkqcJybKwDqmtsp83Vt3rubAr5eQSFtAHi2v7zpqjRvAB1pKoI32MjIX9vuYzGX
	 hfr+rrcqXd966Cj388D7xzGThPQit4beVzmf2U3CGBPLIyxkCs5C2v4X4lSlKso1Tc
	 KbBogrphj286UeA27K3Q86jX2TQlZd+y8eXB4u3VkH0ID6AMl9zmEZIMxIuwVqSFTR
	 INs3FWbXiUGDKsqtI8J4dgaUXGciXZIgufkqJLkmgqRO7gAej381dA17o6EEYrcVF0
	 5tJ5Dzq+juuJW/JDIUnziD8V4lKOoFA7NAB4N5lT8Ga7plYeCsEHOAQpHYCUkzYXHx
	 iSTUTHgH6CFLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B02A40505;
	Sun, 13 Sep 2026 17:16:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52D2424D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 17:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44EB04006F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 17:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e3gr1mXDwIm3 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 13 Sep 2026 17:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 77A6840022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789319785;
 b=AfoANaCAWqTbktAHzY6KBvLZMNYBHGVGtMpIs2vGTSjeVMxT+qxOnmIcN2gvTyAqYrfz
 Igqh9F6C7sticXB5YuIv1VXP9W+q3dHTddF6Lhq/SclAQ1Gj9NuOd7icROK7+Inpb222d
 ch7afNVeMQj8cry7G5CO0SEpAaWoUET/xJl8euv/Q6mu0ir2IuwgOg6O47Dfpc3c7Wo4J
 Nge4FV6XLx9UwBuMFnbtViPEJkPkeF+SThx26G/LDZiGptEp7ktZp5ndrTsIMm3aa4BvP
 4c+W2afgskrwSdhxdKhmNVn9XU+7S42WnNXhCFoOXa36AZN+k5uMOQkR7+Mo4IIMpHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789319785;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=GateTyBBPIQQ3kCKpBN9Gh9lEseqwXsnXnPZooaJ/B4=;
 b=b+CoYQbGRAAETudW6UBZdxOeDXhc+8MlB8oWNOh9d5giCWw+qgrRovQeXJrzES3O364v
 LoCClMzG2c4USl72W4Ghr7SjuqFMSEuIcRL6VRYpuCEq7jZXC/PYIEKEYi5s/4oJ/OadZ
 wq/30l88pU13L4qL3XvGY5P1f+/hLhND/NWfn+M5RO9PY8zU7OwQtRkuBeFZc9UeirEFa
 ABccO/k6/Srk1hwlT54lnhJiO4lG+oc95MVEjmLPfV0u9/r9f54c1tjP0Isf++Huo2xB9
 LpnHeg7BDmCRlEs5oIJe06s2cgk7eolcE/lHIkgRntDFqimjobgdiENzFlEV0Bs3S7Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QqnJ7DUX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QqnJ7DUX
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77A6840022
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 17:16:25 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d46e4cdcaso9559097b3.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789319784; x=1789924584; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GateTyBBPIQQ3kCKpBN9Gh9lEseqwXsnXnPZooaJ/B4=;
 b=QqnJ7DUX3rN1SN0xLj1e8VTeOmsWT8SOotVz5FxVRUlTVVqRZItf4C7RsPl30nueRT
 3MvxjFz8Rq+ax7SoJel9Wc0iqdgUjGNynU9s6UwB/m6nOcVRRPWzLfHtwzWrXnEJE9f7
 sTgHRJ++LPGVVH9y73vuNGaKwz4VkQD4GVepGMsyawPtBR0/MYaJsoQBlhSyZQTdqK13
 0Y6+M4+zQaIwk/Q5DwAKk57KVa2cxVdYue5yco5UdNkORiPQAv50g1q5432H9RNe+OMZ
 JbIA0S9oxpCKFOe/Wp+yHHvr0e6ofdugPSQuJyMMPYjmSIwZHVJzlWOm3/J4nE2rnS5r
 mMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789319784; x=1789924584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GateTyBBPIQQ3kCKpBN9Gh9lEseqwXsnXnPZooaJ/B4=;
 b=ZOwFzsRjaNcZUgC+ej3xMvKfwVECM4555RUAFDAfALZo8iaDmyu8HP4QOJoFb0U+R1
 i6itcBI7zmmdKW6IxRBKbW1b+nS79NXw2rm/tsE0U7h8bVOaKSuPSSUDaKCKIy1HUvu4
 GOdknht8KlPuO7FofL1QRG8M9byra/mVqeab9AWhp55PsuQqtoVbwGemU6bekXk0rKAL
 Ml3xIE/MKEmrnbIm2NU/PSmvce/S07iHVLFnLYYnKSuwxFnfxfRaA2IVjlWSt1oc3cvS
 4gY0EysOCzFWTW35KXs8teFqFjd7C12TlO8UN5QlA6ZQw88Z/wGhYvokT82daEXkyW5Y
 KtWg==
X-Gm-Message-State: AFuF++nx21jm08bsl9hHMpvQ53DBvtCY1q1xdBQ4q1SQJzNrv1VjkL8N
 TI8af122yi0tC4Jt2IDHpGNBInwwzlAq0y/d6nxubbmyuvkZTHK+SHCkxLlDWLr5laY=
X-Gm-Gg: AYBFou14F7ahBrdpYfytPmVGheLumZ6o0HGqPC2Nnk6m3MLGVti1qc3sWmVrEA4THWL
 6Bboz4QvZYbrkQNY5nUc0OXhYcSTF5XK4A3Z8JAU1QRaAwcNGOoG3FglUeIRXFLpKw4Uu0nnygd
 4wiCxk1PSZtXvplPG/9bExMFpVtfXpbtLY4AkH9cY8FyYNmqJocZvLTWP5xLV4hs8PPJI8Srat2
 5f+JsgDHsbeBZ13twVr7cUTlpn2jlfxN4nsKdzm+bdBin/DsWCZ82VZ9c6qgO4eOAkIXoszARrZ
 akj6enwcbtuoUe7q5LndOFRWkLYP5nOQegiWHT19U7i9Q2JjBT6DOowTfI9A/B8hn5Xix5KzSNf
 SPPSTlvFLGVaQJPY8e+wVAFrkKZxsGZlg0QGNujPcYgvvZsNUcsQJ0w0BSGMVIhtAeN96wVti4O
 ADPGXr1R738cFCdDi1LHtSbCj19mCvAllLwIG+aPfTBqRTGDMfiMBEdDxhV2QTEQ==
X-Received: by 2002:a05:690c:a759:b0:882:1d1f:23e2 with SMTP id
 00721157ae682-884b387e35cmr40144407b3.28.1789319783900; 
 Sun, 13 Sep 2026 10:16:23 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8847db4476bsm29210607b3.5.2026.09.13.10.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 10:16:22 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Matt Vollrath <tactii@gmail.com>, stable@vger.kernel.org
Subject: [PATCH iwl-net v2 1/2] e1000e: fix Rx skb DMA map error sentinel
Date: Sun, 13 Sep 2026 13:15:54 -0400
Message-ID: <20260913171555.89537-2-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913171555.89537-1-tactii@gmail.com>
References: <20260913171555.89537-1-tactii@gmail.com>
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

The map error value was 0 on some platforms (including most common x86)
until error values were unified to DMA_MAPPING_ERROR in v4.20/v5.0.
Since then the error handling in this driver has been incorrect on all
platforms.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
---
v2:
* Add history blurb to description.
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

base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
-- 
2.43.0

