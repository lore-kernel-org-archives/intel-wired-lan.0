Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2A5C05027
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Feb 2023 16:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DED8960B4D;
	Mon,  6 Feb 2023 16:53:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DED8960B4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675702388;
	bh=vnEFP9G0LMGpZA+oPRgPacKeW1/H6kfMlkvTWvbdcko=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3BpmdO1XPp8hVEAimlzTK0vDQrofxFxTizsb2D19x6Ivqw3MI0L7VW6KesQnhmVa5
	 ePCV1GDE+I62aSgjO8n3PaCCxgp14uV9ywy+eG3hrCeJSe7dsreAM8EKRUWn+A15Pi
	 WTbE7SbYhwkhkWBS2wO5PHbL7dYVcZ5pWpaW2LVIvwyBpaIxE2K4K9/oLevSk4t+pv
	 6OO7FXuzDlAuFzxirfgDBOSKQZkQcGgoavPfHsBR9NrDdveLxtPZ3UgMijX3qjavPe
	 82ITwwJgzfyP1TkjsFS/c9bFYGoxNslZxrVHm9CgmrOVBg1dnojvbOFV1sfMXGmp9D
	 z07GALg6pYgxA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2IAqv9hOsQ9k; Mon,  6 Feb 2023 16:53:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id D98F960B57;
	Mon,  6 Feb 2023 16:53:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D98F960B57
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 45E2F1BF33A
 for <intel-wired-lan@osuosl.org>; Mon,  6 Feb 2023 16:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17C9E60B6E
 for <intel-wired-lan@osuosl.org>; Mon,  6 Feb 2023 16:53:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17C9E60B6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i5pWJOUnTZiJ for <intel-wired-lan@osuosl.org>;
 Mon,  6 Feb 2023 16:53:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A64F60B4D
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A64F60B4D
 for <intel-wired-lan@osuosl.org>; Mon,  6 Feb 2023 16:53:04 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3CD2A61CC457B;
 Mon,  6 Feb 2023 17:53:01 +0100 (CET)
Message-ID: <6eed8aad-1520-5789-264e-b952b6ff4502@molgen.mpg.de>
Date: Mon, 6 Feb 2023 17:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
References: <20230206155912.2032457-1-pawel.chmielewski@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230206155912.2032457-1-pawel.chmielewski@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH 1/1] ice: add support BIG TCP on IPv6
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, intel-wired-lan@osuosl.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Pawel,


Thank you for your patch.

Am 06.02.23 um 16:59 schrieb Pawel Chmielewski:
> This change enables sending BIG TCP packets on IPv6 in the ice driver using
> generic ipv6_hopopt_jumbo_remove helper for stripping HBH header.
> 
> Tested:
> netperf -t TCP_RR -H 2001:db8:0:f101::1  -- -r80000,80000 -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT
> 
> Results varied from one setup to another, but in every case we got lower
> latencies and increased transactions rate.

Please give some concrete examples nevertheless.


Kind regards,

Paul


> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice.h      | 2 ++
>   drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
>   drivers/net/ethernet/intel/ice/ice_txrx.c | 3 +++
>   3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 3d26ff4122e0..c774fdd482cd 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -122,6 +122,8 @@
>   
>   #define ICE_MAX_MTU	(ICE_AQ_SET_MAC_FRAME_SIZE_MAX - ICE_ETH_PKT_HDR_PAD)
>   
> +#define ICE_MAX_TSO_SIZE 131072
> +
>   #define ICE_UP_TABLE_TRANSLATE(val, i) \
>   		(((val) << ICE_AQ_VSI_UP_TABLE_UP##i##_S) & \
>   		  ICE_AQ_VSI_UP_TABLE_UP##i##_M)
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 22b8ad058286..8c74a48ad0d3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3421,6 +3421,8 @@ static void ice_set_netdev_features(struct net_device *netdev)
>   	 * be changed at runtime
>   	 */
>   	netdev->hw_features |= NETIF_F_RXFCS;
> +
> +	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index ccf09c957a1c..bef927afb766 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -2297,6 +2297,9 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
>   
>   	ice_trace(xmit_frame_ring, tx_ring, skb);
>   
> +	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
> +		goto out_drop;
> +
>   	count = ice_xmit_desc_count(skb);
>   	if (ice_chk_linearize(skb, count)) {
>   		if (__skb_linearize(skb))
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
