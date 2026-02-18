Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F99AE9A03B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 08:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9B8E4077C;
	Wed, 18 Feb 2026 08:09:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E2mgz5ZkG40a; Wed, 18 Feb 2026 08:09:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBB4640777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771402159;
	bh=ci0sMh8NfQB6W72WGOm9nN9RbM5xUL1rvhhVZ2Qrl7s=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wR/eTsO4kgR90cX/F9jJGEU6DHkQVDhGmmDn28W8uDEuSLmKXG14X3uKe8s6DWjiE
	 7NA4LmkzXSTObrhAAQ4YNMTsrTJGofQP3AUq3jk34eUpa/Jw8VX0K4tYp0Q1T32ZWn
	 rbbU8HX0V4AvVL/oDCzwYbcL1zuSC8gfus+az74rZV41QoMnQWovRTmTc+irmrcvvm
	 B5Srw6vWRprtvyFo6Ih96bxDPFV9ltfG5Dky68dNhxbdcn2gpGN8eusfIPVFDrBGPc
	 ZIygn74qrbNcNVf4oclEdZYFMQCGVSHKCQBGlOnEziIbYcQ/Z02Y+l9AVlvAgPtp1i
	 jwmHoGSRH7v9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBB4640777;
	Wed, 18 Feb 2026 08:09:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB33D206
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 08:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCA3780F14
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 08:09:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bUv7kUROmK_3 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 08:09:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5487980F10
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5487980F10
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5487980F10
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 08:09:15 +0000 (UTC)
Received: from [192.168.2.221] (p5b13aefb.dip0.t-ipconnect.de [91.19.174.251])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0E36E4C2C37D4C;
 Wed, 18 Feb 2026 09:08:44 +0100 (CET)
Message-ID: <d5debf35-e07b-45ff-a1cb-076b77a91694@molgen.mpg.de>
Date: Wed, 18 Feb 2026 09:08:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sasha Neftin <sasha.neftin@intel.com>, kohei.enju@gmail.com
References: <20260214194636.295647-1-kohei@enjuk.jp>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260214194636.295647-1-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igc: fix missing update of
 skb->tail in igc_xmit_frame()
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

Dear Kohei,


Thank you for your patch.

Am 14.02.26 um 20:46 schrieb Kohei Enju:
> igc_xmit_frame() misses updating skb->tail when the packet size is
> shorter than the minimum one.
> Use skb_put_padto() in alignment with other Intel Ethernet drivers.
> 
> Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1abbdbebf8a4..7ebeca5333b6 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1727,11 +1727,8 @@ static netdev_tx_t igc_xmit_frame(struct sk_buff *skb,
>   	/* The minimum packet size with TCTL.PSP set is 17 so pad the skb
>   	 * in order to meet this minimum size requirement.
>   	 */
> -	if (skb->len < 17) {
> -		if (skb_padto(skb, 17))
> -			return NETDEV_TX_OK;
> -		skb->len = 17;
> -	}
> +	if (skb_put_padto(skb, 17))
> +		return NETDEV_TX_OK;
>   
>   	return igc_xmit_frame_ring(skb, igc_tx_queue_mapping(adapter, skb));
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
