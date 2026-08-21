Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B5C5DF7D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 18:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8781660A6A;
	Fri, 21 Aug 2026 18:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xWfuhbTsozn7; Fri, 21 Aug 2026 18:13:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787335988;
	bh=/EePeMp6ZlrkyiSb6ai/0z2NQP4aj8g4OyGfsw3ixPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SqxwF4PDYECCrt4n/YcqRS5N1xu88WmJTQgstZbWGrGqv0ZsmmhgqqOnVFkKO392S
	 mGHl6VHMCi1HAuEszN2hs5c6rG2Y7vhDAJgQ62b4lF36lFPR8b5B3IvHqAbQ2aSF/P
	 FNr1okhockCIWox3WqOeYNSPp59bZMpGTblyugGiUohRTiT9cnVUBbkw+E/vEZQjkF
	 L8AZUr6mqwGihIqKmyny/gTqpKntB7ehZFN7xlpk+oIljGS7u5GTUNdom2PqpL/fLe
	 +LENtRjKbud/byiiYMbOWO01AT9JLztpmVw2qGEpxMQbdJNVpso38wxJjYtvsaAciI
	 kglanZoK0Tvfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5D2160698;
	Fri, 21 Aug 2026 18:13:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C18D8EA3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 18:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B33EB60698
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 18:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8u5WttJKdg9a for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 18:13:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qrIfTezI
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D76DB60639
 for <intel-wired-lan@osuosl.org>; Fri, 21 Aug 2026 18:13:06 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso1010921b3a.2
 for <intel-wired-lan@osuosl.org>; Fri, 21 Aug 2026 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787335985; x=1787940785; darn=osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/EePeMp6ZlrkyiSb6ai/0z2NQP4aj8g4OyGfsw3ixPM=;
 b=qrIfTezIynwVbs8DhoKiTVg/SntuV+ZjRKQZAbEXPnDrMNbVWTw8XZIlNPYhxQhZp4
 yne+M/rIhxg/ztEe/cPSWhENHv6hUbVRCuJaUZJ5FzZ3jnmvfcZnsVbtEVDJH8BhCfOy
 oxjgP3RkiQDpbzajHBzAx3kEpVKRaxF/N54aTNnmQxkZgolm66gytCVDbD3m7PxiZL4b
 PVz405FvykQu1zlR4yPGil20vRRgVEaeNB9joO2PHBkLb7W5mWKJtWvKum+P0RjMmpTU
 UsLKe1D18MKiBVVgxBBkip3Iyd/TTkntL7RNWmwPHJ5tgKNk5F4l4KtQpRrIJHw29Vk+
 lVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787335985; x=1787940785;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/EePeMp6ZlrkyiSb6ai/0z2NQP4aj8g4OyGfsw3ixPM=;
 b=Z0Z0HAENCRGqCSBg9fKotDRmgzn2joUiujXMbnXbUf5BfwOVZbbzOB5H/w75q0K/tG
 YCcZUPixmiLm0yXXp6Fit+kv7HIzUCZq8oEg6+qteACFoRoYu+PIrJcOLR0aLEB78iDy
 T3XMEUvOszJKGbkX5a/U7Tev22TZ6cXxuBs82pcrS/x+27LbxcGLvyjiCxB+3HKbeb0+
 p/dpJXIUthElv1jLayWXiF6m1U7O2uEfYqq+6EoFKXXg/H9UcdLvsnEDj9vlVxU7VD4w
 m2FVgtTBZ3G2g62kOhA3vC1yqtjCDQg3JLcAucaaA2cgNwh0gYGgQsMaF+VT6E0Vqyzj
 yK6w==
X-Gm-Message-State: AFuF++nXFHSCpjNnNOBP77t63Mudt1xr/T0YjU4tuEv5b7obzK4jGeVG
 McCly59lXVHobxsdzzZoyUbDRfFIzYe12/hKHGerPrPMj4xMWnrNISbBlQAXtQ==
X-Gm-Gg: AR+sD13WkSSHQBlgR/xT/4f3LL31Dndhbd37pk8xXNcAKiFWeS2GhcoChOv3xVrlOvw
 L3l3oypHH2Zl73CBEcvOH1zb23P9tIqz/RFYWEULD1lhIytw9l9VDLHSOx4vMDCEGMbjt0Sc1q1
 6TxCM1wycK1MWauVUJADziSsKivqpc0Mc8upwiM7/7DsnCgHziSkX7SQ4gS8MKvhjDu8tH2NeVG
 qBT+iA8pvuODfxBmi6LRtut2Aemt11c8xEomcVHyVngt35aclRzcmt40wf7aQa/HaCDOyZd95wq
 3ZfX/pbpbxapwdr3wTOCy1F+x1FBcvsYGQxWVACb61VqEAKCbTMgx2sUU9q0ZHGalpkajjW5B/m
 FBtuRd7bC5AdXZfYTqnBl/aEI0IMinDr24taz3bZl1TjjHC22OfBkxbSGXWGLJjD3eyRmDArV/S
 9pDFLWAeMX5bZEpqzIXg58YKbsicFHuhyo344xHk5ueqAJNGtjTILlDL3xriG4WQ==
X-Received: by 2002:a05:6a00:80f:b0:847:8b0f:2508 with SMTP id
 d2e1a72fcca58-851f9fbafe6mr12320677b3a.13.1787335985302; 
 Fri, 21 Aug 2026 11:13:05 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d33b4ff5sm3326294b3a.25.2026.08.21.11.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 11:13:04 -0700 (PDT)
Message-ID: <18f20a04-5b8e-4012-a923-95332221611f@gmail.com>
Date: Fri, 21 Aug 2026 14:13:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] e1000e: Avoid DMA re-mapping on RX copybreak
To: intel-wired-lan@osuosl.org
Cc: Aleksander Loktionov <aleksandr.loktionov@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20260429014325.19136-1-tactii@gmail.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <20260429014325.19136-1-tactii@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/28/26 21:43, Matt Vollrath wrote:
> This patch factors out DMA re-mapping for skbs which were recycled in
> the RX path due to copybreak or errors. There is only one path out of
> the e1000_clean_rx_irq() loop where the skb is consumed and DMA needs
> to be re-mapped, so don't unmap it before checking the conditions.

I'm working on a series which consolidates e1000e's Rx paths and uses
a page pool, which supersedes this patch.

> 
> The buffer allocation loop is adjusted to not assume that DMA is
> unmapped, handling mapping errors gracefully.
> 
> On systems with IOMMU enabled, the cost of re-mapping DMA is greater
> than the cost of copying data out of the ring buffer. When I use this
> patch and configure e1000e with copybreak=2048, my system with IOMMU
> completes RX roughly twice as fast under load.
> 
> Informal performance comparisons were based on Asus Gryphon Z97 which
> includes an I218-V and with a Xeon E3-1240 v3 in the socket. ktime_get()
> measurement was injected into e1000e_poll() wrapping the
> adapter->clean_rx() call. The total time spent in clean_rx() was divided
> by work_done to print the average time spent per buffer. iperf3 -R was
> used to saturate the RX path and awk was used for statistics. Control
> revision was set to 7.1-rc1 because iwl-next hadn't been updated yet.
> 
>    rev     | iommu | copybreak | samples | mean (ns) |   stdev
>    7.1-rc1 |   off |         0 |    4748 |    453.72 |  155.82
>    7.1-rc1 |   off |      2048 |    4743 |    554.83 |  103.67
>    7.1-rc1 |    on |         0 |    4751 |   1139.22 |  150.56
> * 7.1-rc1 |    on |      2048 |    4737 |   1267.02 |  184.62
>     +patch |   off |         0 |    4739 |    456.30 |  146.33
>     +patch |   off |      2048 |    4739 |    538.56 |  132.97
>     +patch |    on |         0 |    4769 |   1165.97 |  140.19
> *  +patch |    on |      2048 |    4745 |    562.25 |  171.80
> 
> No surprises here, IOMMU DMA ops are known to be expensive. For most
> users the kernel default is iommu=on and driver default is
> copybreak=256, so unless the workload is small packets, some tuning of
> either knob would be needed to see the full benefit of this change.
> 
> The kludge of unconditional unmapping has existed since this driver was
> introduced in 2007[1], inherited from the e1000 driver which has since
> factored it out[2]. IOMMU tech was new at the time.
> 
> [1] Commit bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> [2] Commit 2b294b18689c ("e1000: perform copybreak ahead of DMA unmap")
> 
> Assisted-by: Claude:claude-4-7-opus
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---
> v3:
> * refactor unmapping bypass, use goto instead of redundant branch
> * remove Aleksandr's sign-off due to logic change
> * benchmark details
> * cite historic commits
> v2:
> * proofread description with Aleksandr
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 32 ++++++++++++++--------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 7ce0cc8ab8f4..62bf85c768d6 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -663,6 +663,8 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
>   		skb = buffer_info->skb;
>   		if (skb) {
>   			skb_trim(skb, 0);
> +			if (likely(buffer_info->dma))
> +				goto write_desc;
>   			goto map_skb;
>   		}
>   
> @@ -680,10 +682,12 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
>   						  DMA_FROM_DEVICE);
>   		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
>   			dev_err(&pdev->dev, "Rx DMA map failed\n");
> +			buffer_info->dma = 0;
>   			adapter->rx_dma_failed++;
>   			break;
>   		}
>   
> +write_desc:
>   		rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
>   		rx_desc->read.buffer_addr = cpu_to_le64(buffer_info->dma);
>   
> @@ -941,7 +945,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>   		dma_rmb();	/* read descriptor and rx_buffer_info after status DD */
>   
>   		skb = buffer_info->skb;
> -		buffer_info->skb = NULL;
>   
>   		prefetch(skb->data - NET_IP_ALIGN);
>   
> @@ -955,9 +958,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>   
>   		cleaned = true;
>   		cleaned_count++;
> -		dma_unmap_single(&pdev->dev, buffer_info->dma,
> -				 adapter->rx_buffer_len, DMA_FROM_DEVICE);
> -		buffer_info->dma = 0;
>   
>   		length = le16_to_cpu(rx_desc->wb.upper.length);
>   
> @@ -973,8 +973,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>   		if (adapter->flags2 & FLAG2_IS_DISCARDING) {
>   			/* All receives must fit into a single buffer */
>   			e_dbg("Receive packet consumed multiple buffers\n");
> -			/* recycle */
> -			buffer_info->skb = skb;
>   			if (staterr & E1000_RXD_STAT_EOP)
>   				adapter->flags2 &= ~FLAG2_IS_DISCARDING;
>   			goto next_desc;
> @@ -982,8 +980,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>   
>   		if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
>   			     !(netdev->features & NETIF_F_RXALL))) {
> -			/* recycle */
> -			buffer_info->skb = skb;
>   			goto next_desc;
>   		}
>   
> @@ -1010,19 +1006,33 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>   			struct sk_buff *new_skb =
>   				napi_alloc_skb(&adapter->napi, length);
>   			if (new_skb) {
> +				dma_sync_single_for_cpu(&pdev->dev,
> +							buffer_info->dma,
> +							adapter->rx_buffer_len,
> +							DMA_FROM_DEVICE);
>   				skb_copy_to_linear_data_offset(new_skb,
>   							       -NET_IP_ALIGN,
>   							       (skb->data -
>   								NET_IP_ALIGN),
>   							       (length +
>   								NET_IP_ALIGN));
> -				/* save the skb in buffer_info as good */
> -				buffer_info->skb = skb;
> +				dma_sync_single_for_device(&pdev->dev,
> +							   buffer_info->dma,
> +							   adapter->rx_buffer_len,
> +							   DMA_FROM_DEVICE);
>   				skb = new_skb;
> +				goto copybreak_done;
>   			}
>   			/* else just continue with the old one */
>   		}
> -		/* end copybreak code */
> +
> +		buffer_info->skb = NULL;
> +		dma_unmap_single(&pdev->dev, buffer_info->dma,
> +				 adapter->rx_buffer_len,
> +				 DMA_FROM_DEVICE);
> +		buffer_info->dma = 0;
> +
> +copybreak_done:
>   		skb_put(skb, length);
>   
>   		/* Receive Checksum Offload */

