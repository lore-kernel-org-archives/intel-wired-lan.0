Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29BFC87FCF
	for <intel-wired-lan@archiver.kernel.org>; Sat,  9 Aug 2025 09:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B0DA80F5D;
	Sat,  9 Aug 2025 09:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id maD9J40Soxxb; Sat,  9 Aug 2025 09:35:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD99C80F6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1754732110;
	bh=rIbp5FIJo8akkKYQORntM4TUBPp7XenEp7s64M4IwuA=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7MKipE4IGm00e6K4LIF6yxqfPgwwG+pMLnDefa/9LWYwTUUQZCvH80gZjSZSGw6UA
	 SSjIV4n7VC8bQrZen3jEi+1ITQRxr7F6fUOJ3LaXSuUd2L6xJkp5AZiyi4sSHytnif
	 /eiz3yMOuZjvOCTK2UBVwccn51pCPA6hEF0TKpnl+gfe03Q5nzgX4iNOozu49Y3bCF
	 OfT267endqolugAW+uUUp1AMqbCUZsfcwESzSrvCI6p6Nc7MED8oKn5uGY+ko+CAo7
	 cQbYv5ye3BJJYgWEg5Qte2U9rvbDg4SZky9uzt/ppyzhg7Nsz3tJHxq4TQHh6hp1Fc
	 oXwKa0aiCN4Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD99C80F6B;
	Sat,  9 Aug 2025 09:35:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42CF01D3
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Aug 2025 09:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28DA7608DC
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Aug 2025 09:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hvCpGDYsB1eK for <intel-wired-lan@lists.osuosl.org>;
 Sat,  9 Aug 2025 09:35:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4E57D60896
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E57D60896
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E57D60896
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Aug 2025 09:35:07 +0000 (UTC)
Received: from [192.168.0.192] (ip5f5af7a9.dynamic.kabel-deutschland.de
 [95.90.247.169])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6D8BC61E647B7;
 Sat, 09 Aug 2025 11:34:52 +0200 (CEST)
Message-ID: <f0752ae6-25f8-4504-b23b-052f60007deb@molgen.mpg.de>
Date: Sat, 9 Aug 2025 11:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, aleksander.lobakin@intel.com,
 anthony.l.nguyen@intel.com
References: <20250808155310.1053477-1-michal.kubiak@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250808155310.1053477-1-michal.kubiak@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix incorrect counter
 for buffer allocation failures
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

Dear Michal,


Thank you for your patch.


Am 08.08.25 um 17:53 schrieb Michal Kubiak:
> Currently, the driver increments `alloc_page_failed` when buffer allocation fails
> in `ice_clean_rx_irq()`. However, this counter is intended for page allocation
> failures, not buffer allocation issues.
> 
> This patch corrects the counter by incrementing `alloc_buf_failed` instead,
> ensuring accurate statistics reporting for buffer allocation failures.
> 
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> Reported-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thank you, but I merely asked to send in the patch separately and didn’t 
spot the error. So, I’d remove the tag, but you add the one at the end.

> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 93907ab2eac7..1b1ebfd347ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1337,7 +1337,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   			skb = ice_construct_skb(rx_ring, xdp);
>   		/* exit if we failed to retrieve a buffer */
>   		if (!skb) {
> -			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> +			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
>   			xdp_verdict = ICE_XDP_CONSUMED;
>   		}
>   		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: A little off-topic: As this code is present since v6.3-rc1, I 
wonder, why this has not been causing any user visible issues in the 
last two years. Can somebody explain this?
