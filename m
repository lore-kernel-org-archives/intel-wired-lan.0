Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19846C624A4
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 16:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B680060B75;
	Thu,  3 Sep 2026 16:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E_wtP38ke0HQ; Thu,  3 Sep 2026 16:01:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 12E6960B6E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788451260;
	b=UctQyMgTE78tgheHaR6IJDWerHmadSNDyVSoTc1vXrUph6P5Ul2WENQUm7s17wLB/MgI
	 jIaoScxHjKTrtVvk5ms1KAHgpSllgWVhsBanp4pdqb4Mz1hrEdyt85mUs74bYL3A1WW9y
	 7pA1JE4Cc+2KhIC/tGKNNMLpEONj6TJ4zDy6WeJ0lyAF/Mt5Dhg0FoorCVH86J871q4d8
	 SZTOb9qCHmIGSp0TbBD6kmqGTuxTYwSt+7ifAFfjoq+uiE3XzKTxp/kIRqM/kLWpGQOOL
	 wGaZMaj3XRx57pU9l8uJ0JqjqmqsPKYrjN5HUeTAEz554kwCVkDs4CX0efBsjEm3Ykw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788451260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=d0iIQfc/Xn8g8sZnyqtSBPoDrNyGH3/tP4TlfCZpLUs=;
	b=UbD+sGmHi9zG9i5jEjbN5lepL7EkJEM10u0rzxTBnD12xy1VwSOryZ5xYNF1V36+tuLK
	 7bGW9fmwJxsncKGBdKNkDFLym94B0Ap+QirHOtImjHvDUDjaPSY8dB5LGKb8uY97xDEmF
	 lJEAvbtvE09nIY4zAmZoZntv4lJomW8SiTEFB3xT3RhYXm6mCId1+UR2iqgW+EmTect33
	 j4YFZFut8+5I/UP/BKsERNlliJDiPILuO739gi96IofJC5b/R2eEgnZ7rzt7pC7qsY2IA
	 vMOmgu9NTTr/SCWUP0U1pAR1+2VaN0VIQGucxz7o0zXE3Mdb9OW4TaU0C/HGrktNe5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A7MDXFt3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788451260;
	bh=d0iIQfc/Xn8g8sZnyqtSBPoDrNyGH3/tP4TlfCZpLUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1QC3xUlwpan3DcsHDXb8CVLGeGuvRx3ei4xkF8UTiq+rr3yBVtY7lGXw1KrlJhDMn
	 4ip/W7+C2c8Slbq4uFRWy3vAm+T5eRgRRTjbzGANXVTC0iRsovg+L8YIZ0tfhjN0FN
	 mWC0kbR/K2nsYCX/MHP1/cs8JZ1A7+kOQS2grh4oZO8Xmxfo4pyp1aBxaIUmJOAwU5
	 5XPMCRcbidRo3pOO4mEp8JVectgMTdnv6+hQr0OhZ4qdVmXyZZa7QPEAu+m6UpNYkf
	 cN8aucQHwTm69RPOF1ncH9I9C3pUXL2YiTBhzK5e9vIqVWeRyXSFm6q5MhHCVnpKo9
	 BgW77vRBAZrUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12E6960B6E;
	Thu,  3 Sep 2026 16:01:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4587F2FD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BB9460B73
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hBbKZj6CX0Ju for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 16:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6BA106070F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788451257;
 b=M2OrUSPe7tBNGrP0Sm27VkAxsO/u5IpB/fosNV7b0G4ltB3dpvGv3fVr0iOsi9gXAEux
 VlwDJwKhfNHY5M4cz41zBCVVKE86KhzxP+omZrCANDno94DpaSzakWDNvL9bEmeulgMuD
 rt4iL0vWRL+/8e7M5TI/b81zLGHxcKJdzSDJAFgfCsvMikAwbiLInxoKsG5RjA0FhY0g8
 xnZP2605zk/fVUiU1Rh+mkTcxP72AmHHjYlnTcmvYLXYiZp+USt/DPUgvD4huD8Xm6d2C
 VQVPibdF9asKW/kraPw2Yq7Gh0nUMJpnhKfJaOgwNKQvP7+UAQFIZQkno7AdzofCebQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788451257;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=d0iIQfc/Xn8g8sZnyqtSBPoDrNyGH3/tP4TlfCZpLUs=;
 b=LsmBMHgJEFIQtnhGa5mWiysA9+sN0USNDn+xtV+yi+6sEivhcZP6oSUNn8rQ8SUa/oGP
 Sx+fscHMbya3Pv7WDOPEw4xrZfsbdqCpANS+7Gy+gS0476hE5Igia/Q7O7XznUon8Lo4o
 ZOzQIDKEKe871dtrWKLFTka8z5RW11XpECzbpUnzpWJLFozf5afg+YOXs/DFwObHjjqHc
 OhV8fwdZ0REeHI3idAlGlGabqbEj0EbrCXIiEzlwtkzO0+MmmmdVOF9KZmiyG4Z6rsOnC
 rrE1HVVVQ277s49v8HNWc2JwESeyZYy+zfsPby82yLL5bgWP3/Q+NV4xWkgoKJeh3lA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=A7MDXFt3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=A7MDXFt3
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BA106070F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:00:57 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-861a2ae9c51so644057b3.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 03 Sep 2026 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788451256; x=1789056056; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d0iIQfc/Xn8g8sZnyqtSBPoDrNyGH3/tP4TlfCZpLUs=;
 b=A7MDXFt3VvXpa6Gub57BHjGxtXoo0mvofHusFcE8JvNrHvkWKrZ5yxqlv8GW/4i7Sn
 4/vQ2I27P3dVRZkNvCyioBFiJlmhNHGrLg6YxmxhWC+yDjdwwrgYMbCoCAMrA2zdVOEF
 z1w+YlWHHIVMqlYAd/ZIhzyOhpmJxRUKix/nHiJ//nnCE+/cOQlLVdCtL6m8r8sOngCL
 FoIKZafpXU4Nx7WOEOSKeu8oYBP0dDMwKKiTgAANJQeZiSmokKI0Aq+PI/Xb+ebs3sEI
 hByC1N+BQYa5MxmYnoxdgSaRAWK7vif1XCF0XINrLm4j04UeubhqXsJADGtYx52qMowV
 2kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788451256; x=1789056056;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d0iIQfc/Xn8g8sZnyqtSBPoDrNyGH3/tP4TlfCZpLUs=;
 b=WnvQhfeO6Wl5qvXtTGhOo44zdraG+al0+r7hNoPPllhRTchwfPaxNtoZLEoGz5g+7x
 Q8pU3Aqb6efkE1enomnE+SAE0qhIT4Yafr1u2Mzxs7SYFa8BVHuRiUnPTQVWyzWz7wuh
 rGK/Ey/jbfz9D4DTzGpEmniS61HdTYM7ADRl9xrmmSHNVTAw73bfiS3FhX8qo6Er5HUT
 h0rOYqZWsP98rHgV+fxUi5fTFyIXr0tUiqofa/bX0ifWoarUia2U4BQcR+AvuB7/1YJR
 s66pGNMmJEwejJ1onFHWPqu0gEOGV3buaQhpVwJYBKj8WzmweTnukUEe/AaAQ+F+H7Fn
 /5PQ==
X-Gm-Message-State: AFuF++kD6c2Va3bB7s1ssbKqUpFdy93AsUcy/J7NuXpj+FaPoa6ekKps
 qcay1Es2gguYs7Zyns7vpmV8tmvdzhFNuYHIKt0751rM2TOeYpN1/LIyGDMKr4WrFJk=
X-Gm-Gg: AYBFou0ZnvvvUevb4ViLGRTKcByO/n/mQn9UEI6ai6qZnxy+vGHwLdLUl+2Rz+NhEDI
 1ft1yTqAAdah2UYLMkcBz1h4G/ohbxrgOGXQXYVi4EA6d5ybPmRoFsd0vPdlawTxoInPffYC5hM
 Mz6cIFrLzqxWlrqUPUuf1+ikdljZCDqKhg2tNuR6I6Z56uWMT+D6i3awJyRroabLOUxWquIWVfM
 6gk1IzzsyStI+VEiTrmx2OiF+YFcFryNZ5/Fsl6tRi27n82oKCueJvjWQAdoXcqqn3TBfyqh6Ne
 0+8IaxVMy1W66vYHY4u9JkI6GT46VsiNnnbPk7aFR9z2QhGrjKD7eQ32TJgEvDQ5te0wdXIbWlN
 HcyJ1zM7NfVAYyUFL50a8JknW6+vztGBSxb7kR2S9PERdJQRib/MZwH/2dZc7fWnyjwK5MCpadH
 gNXFghFJggjDOYWJZ+abFJ5/7fWiRTNTwXvqbgEufqvI414+IuzrNudRAoGIM8lA==
X-Received: by 2002:a05:690c:e694:10b0:820:15ad:522c with SMTP id
 00721157ae682-870ed3429c9mr3743287b3.11.1788451255669; 
 Thu, 03 Sep 2026 09:00:55 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-86c186d60f8sm43058097b3.36.2026.09.03.09.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 09:00:54 -0700 (PDT)
Message-ID: <eb208b80-4cf2-4c3b-90c7-f68520382cf6@gmail.com>
Date: Thu, 3 Sep 2026 12:00:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 3/3] e1000e: fix NETIF_F_RXALL buffer overrun
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260902032913.661570-1-tactii@gmail.com>
 <20260902032913.661570-4-tactii@gmail.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <20260902032913.661570-4-tactii@gmail.com>
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

On 9/1/26 23:29, Matt Vollrath wrote:
> When SBP is set, the card may deliver frames which would otherwise be
> filtered out by LPE being unset. This would allow the device to write
> up to 526 bytes beyond the skb's data allocation: over its own shinfo,
> and beyond. This bug is reachable only when MTU <= 1500 and
> NETIF_F_RXALL is set ("ethtool -K <dev> rx-all on").
> 
> Ensure that buffers are large enough for an entire 2048 byte chunk when
> NETIF_F_RXALL is set. Do this by moving final rx_buffer_len
> determination to one place, right before RCTL.BSIZE is determined. This
> will correctly re-evaluate every time the adapter is configured, not
> just on MTU change.
> 
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Assisted-by: Claude:claude-5-fable
> Fixes: cf955e6c96cb ("e1000e: Support RXALL feature flag.")
> Cc: stable@vger.kernel.org
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 53 +++++++++++++---------
>   1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 063fc8cd2673..80d5a0010df8 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3036,6 +3036,33 @@ static void e1000_configure_tx(struct e1000_adapter *adapter)
>   #define PAGE_USE_COUNT(S) (((S) >> PAGE_SHIFT) + \
>   			   (((S) & (PAGE_SIZE - 1)) ? 1 : 0))
>   
> +/**
> + * e1000_set_rx_buffer_len - determine the Rx buffer size
> + * @adapter: Board private structure
> + **/
> +static void e1000_set_rx_buffer_len(struct e1000_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	u32 max_frame = adapter->max_frame_size;
> +
> +	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically NET_IP_ALIGN
> +	 * means we reserve 2 more, this pushes us to allocate from the next
> +	 * larger slab size.
> +	 * i.e. RXBUFFER_2048 --> size-4096 slab
> +	 * However with the new *_jumbo_rx* routines, jumbo receives will use
> +	 * fragmented skbs
> +	 */
> +	if (max_frame <= 2048)
> +		adapter->rx_buffer_len = 2048;
> +	else
> +		adapter->rx_buffer_len = 4096;
> +
> +	/* adjust allocation if LPE protects us, and we aren't using SBP */
> +	if (max_frame <= (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN) &&
> +	    !(netdev->features & NETIF_F_RXALL))
> +		adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
> +}
> +
>   /**
>    * e1000_setup_rctl - configure the receive control registers
>    * @adapter: Board private structure
> @@ -3102,6 +3129,8 @@ static void e1000_setup_rctl(struct e1000_adapter *adapter)
>   		e1e_wphy(hw, 22, phy_data);
>   	}
>   
> +	e1000_set_rx_buffer_len(adapter);
> +
>   	/* Setup buffer sizes */
>   	rctl &= ~E1000_RCTL_SZ_4096;
>   	rctl |= E1000_RCTL_BSEX;
> @@ -6087,30 +6116,12 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
>   
>   	pm_runtime_get_sync(netdev->dev.parent);
>   
> -	if (netif_running(netdev))
> +	if (netif_running(netdev)) {

I see now that I should not have collapsed this to one netif_running check.

>   		e1000e_down(adapter, true);
> -
> -	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically NET_IP_ALIGN
> -	 * means we reserve 2 more, this pushes us to allocate from the next
> -	 * larger slab size.
> -	 * i.e. RXBUFFER_2048 --> size-4096 slab
> -	 * However with the new *_jumbo_rx* routines, jumbo receives will use
> -	 * fragmented skbs
> -	 */
> -
> -	if (max_frame <= 2048)
> -		adapter->rx_buffer_len = 2048;
> -	else
> -		adapter->rx_buffer_len = 4096;
> -
> -	/* adjust allocation if LPE protects us, and we aren't using SBP */
> -	if (max_frame <= (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN))
> -		adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
> -
> -	if (netif_running(netdev))
>   		e1000e_up(adapter);
> -	else
> +	} else {
>   		e1000e_reset(adapter);
> +	}
>   
>   	pm_runtime_put_sync(netdev->dev.parent);
>   

