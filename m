Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11343606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xzbO8mjq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2981407BC;
	Mon, 19 Oct 2026 22:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPE38Brmo4wC; Mon, 19 Oct 2026 22:56:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B1AAA407CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792450577;
	b=phsKBgTywWGrCQMKd1THjNHfAfGY2gtOx/tQa7P3uZqfcGP6gWy/FKJoQjA5bPwm/Zsj
	 fMocw5pBfsydKv7SqWKJuHpuyMw07ZnE6+JLB0nTvVvlB1CPUB42kOO8/j0Kv8C6DOWB3
	 y62DLp6/XtK+evNyCjO08SlCa3xmQdtGOXPsqRNFY2zaNw5KwE9p3fhsX/0oXbCbtLivK
	 qaCYzqvV/v4Z9ZU2dkzAxjMqZB9ZOyMKHygeA+XKHLC4z59S8i6mvRsY51GswJVzDG/+1
	 aw4xjeq4PHzRVkw7ALH2NlVbxJkzZhWm86/FbafVNwDUpou3tEPFPATKltltpK7YKvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792450577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TeyCY6N7EE9VBYsjwg1WsnXG/9D2AYAUunCAhHquj9U=;
	b=KoGJuR7wU4EWgR8gJgjlR2PAVrsAf5qJSE/9cohdf9Svk1GSM+uhAX+zIGT8zUN5KCv2
	 0I1QOTfffjhxy4feMO+YRBnxViPCpI2FYFELThTXaKlRaOsTPm2gGPSkZqltuNTZUogZA
	 jEScMs1RFlOaqvDHSUBgjCNoDLPUrIA0s2gNIQ31qGaoA1EeozxLgKNfa+lR0Pb8LC5dP
	 7RvjJUp6IJCO13iMkd+73lntU5KB47rIshqqdQepbKiOZFV1esZK005WBEN75+6/9d/ox
	 4Zexi8llIpoFHY2WHBEM92i5LZJsdK59OjLh0G5+Va9VXSDCuDCNPQXiIDadLzH537Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=proxmox.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792450577;
	bh=TeyCY6N7EE9VBYsjwg1WsnXG/9D2AYAUunCAhHquj9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xzbO8mjqsxDPu5CBZKhBwwSCzDWgxG7Clguy9XiN00ggdlbqNDfQg+Dwb2sRShDHO
	 Ciwuq2hkupantJxKgeHc3U2/zM+0ZBRhmAb3EZHvnnI8Jk1loSF3mJRJlcJYE9iiQU
	 Sm3+zh30BTPpuIhMb3E88W+E+cglpQM8DiD0cVn0T6Qr2eo197s3v9sCg31lv8zi0S
	 SZmAgBJcmZfFY6+Atz/ZjO+//y/pS8ySiZ48KP4X4EJ9h5aGa8faQc5Acnhb8T/OMv
	 OqvoQmqy1w+DnN/83r+TuDLiFCc+3uEYsNXXIh7H4SlvcGoFqog9hz7FLjDyumqzVE
	 2u8C5cISQ1JtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1AAA407CF;
	Mon, 19 Oct 2026 22:56:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 832B6263
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 13:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 692FC4066D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 13:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q5HMK_NBtX8h for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 13:46:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ADBA2405A3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792417574;
 b=ZjzFD50jx0na4PaNg5ZcZ0bnnDtO3pnrsulYzrnGnVSIO0kxxd/bdJwBXSFOYQEULbxP
 hQ5nPYrp4F9HoYFPlwsQYwk1fs3aMBqqxSoM8UJ0a6QkWl5rV4uDTVrLa5vJFijta8flk
 Qr4ukzvrqvwVPDgOxEP8c5A8t0CehfsmqHfm7YXPXU9ZJmGAipnRYYSTSB6GIPwwqEzY0
 w/o7+DLGh0Yu7JdL9t7IGGWy7hU3apA0euPGvxvc3iLjqZn9jre9LZsCZfUI8VVYKtbgZ
 1oDFR0/mn7+KyJWt+wGwUX9WrpFQd9vKicw+YyU09MpXXpFsK61RIw3AKbQQj25I4EA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792417574;
 h=X-Greylist:Received-SPF:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 User-Agent:X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
 bh=TeyCY6N7EE9VBYsjwg1WsnXG/9D2AYAUunCAhHquj9U=;
 b=UCv9kCetjpQYR78iVhw0nyvTtMHgVcU4JUUgQl/pixWSlTH2B5R0RyEuxzK41ySaU2zs
 CYxuBWuLIQgMIrmzrgKoV8zE17zSE2Kl4WbpsEsUVjAyagHrNsM/GPi6sQ5htthT43qNw
 9o8h96+fl87aWNIke9uu+Wmh05/6hsIsvYdctJBDcBYU+KlKznAHnNgtivDpgyRwoKK2g
 OV4+Eq5KLD0mh3M7AwvpqFW1V+dqskygHI+sM2Ca6E9CEujdamk250KPDjCr+CbrldcjE
 e8btajLCRlpdcV7VGV7M5S205D/UriLQHu/v8D+aDus/eqq5Y8GxexJM6aEsj+v2X8Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=proxmox.com;
 arc=none smtp.remote-ip=94.136.29.106
X-Greylist: delayed 601 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 19 Oct 2026 13:46:13 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=proxmox.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=94.136.29.106;
 helo=proxmox-new.maurer-it.com; envelope-from=g.goller@proxmox.com;
 receiver=<UNKNOWN> 
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com
 [94.136.29.106])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADBA2405A3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 13:46:13 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 70763447B0;
 Mon, 19 Oct 2026 15:36:08 +0200 (CEST)
Date: Mon, 19 Oct 2026 15:36:06 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Andre Brait <andrebrait@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-net] e1000e: segment TSO packets whose headers cross
 a 4 KB boundary
Message-ID: <atYbzARmBOVuRTdW@luna.proxmox.com>
References: <20261018203215.77371-1-andrebrait@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018203215.77371-1-andrebrait@gmail.com>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1792416967724
X-Mailman-Approved-At: Mon, 19 Oct 2026 22:56:11 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andre,

On 18.10.2026 22:32, Andre Brait wrote:
> [snip]
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 834a5b888..6f95ed19a 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -11,6 +11,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/delay.h>
>  #include <linux/netdevice.h>
> +#include <linux/sizes.h>
>  #include <linux/interrupt.h>
>  #include <linux/tcp.h>
>  #include <linux/ipv6.h>
> @@ -7359,6 +7360,34 @@ static int e1000_set_features(struct net_device *netdev,
>  	return 1;
>  }
>  
> +/**
> + * e1000_features_check - validate offloads for a packet about to be sent
> + * @skb: packet to check
> + * @netdev: network interface device structure
> + * @features: offload features usable for this packet
> + *
> + * The transmit DMA can stop for good when a TSO packet's protocol headers
> + * cross a 4 KB boundary in the buffer holding them: the descriptor is never
> + * written back, the driver reports "Detected Hardware Unit Hang", and only a
> + * reset brings the queue back. Seen on I219-LM/-V (PCH) with forwarded
> + * guest traffic, which arrives as linear GSO skbs that can start anywhere in a
> + * page. Let the stack segment those few packets in software instead.
> + *
> + * Returns: the features to use for @skb.
> + */
> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> +					      struct net_device *netdev,
> +					      netdev_features_t features)
> +{
> +	if (skb_is_gso(skb) &&
> +	    (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) &&
> +	    (offset_in_page(skb->data) & (SZ_4K - 1)) +
> +	    skb_tcp_all_headers(skb) > SZ_4K)

Hmm, doesn't validate_xmit_skb call validate_xmit_vlan after the
ndo_features_check, which means that the vlan header can be pushed into the
packet? Meaning the packet can grow after this check.

> +		features &= ~NETIF_F_GSO_MASK;
> +
> +	return features;
> +}
> +
>  static const struct net_device_ops e1000e_netdev_ops = {
>  	.ndo_open		= e1000e_open,
>  	.ndo_stop		= e1000e_close,
> @@ -7378,7 +7407,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
>  #endif
>  	.ndo_set_features	= e1000_set_features,
>  	.ndo_fix_features	= e1000_fix_features,
> -	.ndo_features_check	= passthru_features_check,
> +	.ndo_features_check	= e1000_features_check,
>  	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
>  	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
>  };
> -- 
> 2.56.0

Gabriel

