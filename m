Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE00C44500
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Jan 2026 11:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A19B48538F;
	Thu, 22 Jan 2026 11:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z86qvlKcjnLP; Thu, 22 Jan 2026 11:17:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE1A88538C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769080625;
	bh=wdtWcSsXmiiXzpXAwKXV1bSwpBcIScE43aU9yGZWDIo=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9kqVdPoR+IL76PC8YxtPKGbOvvY2FEE2ZQW929i1mtm3QDv0KFZfcIBOGMUkC7Yw8
	 2A6RUmj3/YP6xufFRyAVwsVncLWbPM4dLXvwL+XEP1M81r3Urb/ZLa01k3Nk1zkiy0
	 D8b3UVnnO18T8ykywU9Z9kkAPGsEHJxD/LYNuOEfZ3G7xyibaJ00wrFDK/+TWbtWWi
	 o0i29xMtOZr+w+oM+NzS9R2D0wjLHGUKU2KRRsp0u6GWv0PFph/BxQejpWj+ekrsLH
	 cb07wwxpMA5u2HqmsOfLke4MkzADrs+WdHssZjyBpSugGc78z9C5heW/J4ot+23CNB
	 KyKjDWR5DWTtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE1A88538C;
	Thu, 22 Jan 2026 11:17:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24201158
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 11:17:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 087B78538A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 11:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wd8AeQQxJh0s for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Jan 2026 11:17:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3C75185382
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C75185382
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C75185382
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 11:17:01 +0000 (UTC)
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de
 [141.14.13.172])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8DDA44C1A15B96;
 Thu, 22 Jan 2026 12:16:26 +0100 (CET)
Message-ID: <880ef2b4-14a5-49fe-81ad-4b6ea430e911@molgen.mpg.de>
Date: Thu, 22 Jan 2026 12:16:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zilin Guan <zilin@seu.edu.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260122032644.183754-1-zilin@seu.edu.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260122032644.183754-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix memory leak in
 ice_set_ringparam()
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

Dear Zilin,


Thank you for your patch.

Am 22.01.26 um 04:26 schrieb Zilin Guan:
> In ice_set_ringparam, tx_rings and xdp_rings are allocated before
> rx_rings. If the allocation of rx_rings fails, the code jumps to
> the done label leaking both tx_rings and xdp_rings. Furthermore, if
> the setup of an individual Rx ring fails during the loop, the code jumps

RX ring

> to the free_tx label which releases tx_rings but leaks xdp_rings.
> 
> Fix this by introducing a free_xdp label and updating the error paths to
> ensure both xdp_rings and tx_rings are properly freed if rx_rings
> allocation or setup fails.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 969d4f8f9c02..1643b118144a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3318,7 +3318,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>   	rx_rings = kcalloc(vsi->num_rxq, sizeof(*rx_rings), GFP_KERNEL);
>   	if (!rx_rings) {
>   		err = -ENOMEM;
> -		goto done;
> +		goto free_xdp;
>   	}
>   
>   	ice_for_each_rxq(vsi, i) {
> @@ -3345,7 +3345,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>   			}
>   			kfree(rx_rings);
>   			err = -ENOMEM;
> -			goto free_tx;
> +			goto free_xdp;
>   		}
>   	}
>   
> @@ -3398,6 +3398,13 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>   	}
>   	goto done;
>   
> +free_xdp:
> +	if (xdp_rings) {
> +		ice_for_each_xdp_txq(vsi, i)
> +			ice_free_tx_ring(&xdp_rings[i]);
> +		kfree(xdp_rings);
> +	}
> +
>   free_tx:
>   	/* error cleanup if the Rx allocations failed after getting Tx */
>   	if (tx_rings) {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
