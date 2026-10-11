Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6029CA9ECA
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 19:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3643C80C84;
	Sun, 11 Oct 2026 19:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_kkiCT2zWww; Sun, 11 Oct 2026 19:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DD4680C88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791745446;
	b=ONk0fIluy+7IzQs2yaqJty5UOn5O15745mN+Zrh4vUY5uqUcfBW9xqrjUgYJdFWuJTDI
	 XWsF6cSz1RFfgZbtRQvoqyZRVcSZU2xiFqzNjVkNljJSRXVR+uXe0R1A/f+5vt840Md+2
	 K57TbrOdlotOLdNewII6jSZMBFEHDXyOjoG8xRyONFPEK6GCPcfeeGuVZdMI9+hqenayU
	 yDjtvhKmPZI1L7VEFSGVeWSjhvgXAWOw2PdLgSnwxvP0c62200tPR9KEbEoScgvb7kQRY
	 WO5gGQc5GfSaDJ21rc9rg6wQGxFQCdU5sRAGqSxwyaaJnf0aJ91ogky8E5hu9MS5mcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791745446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LdxMvCC8JxkBtq+BNVpskgNv+Iemqb0CitObZkcZf3A=;
	b=Quw9b2MZn2Ev5Rte5V7/T0estte29DNYNeXkRxgxHAl3O2aRnfldtjc4HSrCt0wl0s7o
	 7DmgI4VEbrOn4VJzcbl1DuQAeov2VwOhMxlJkFzoigEh3NUSLCVz3lkBpp6YjzSi2PrTW
	 4kIKhxZaOPVEleaCkDln/xIzbdwL/9wgWW8p86NLpNU8+OaO53bT1GASq4ZuV2s07wgGY
	 CBG9a1RqFUzA7nQ//Yv0z5TSqdlzW5IUUps32fCe5KnakVbzX0/fTNE2Hz8o9trTPpjV6
	 N+/SE9pK0Hp0BOXwcpdVTdvmVGtdemo2g0uubdcsFPCgM9ODmTJdhQ5kLv01tps2cOw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791745446;
	bh=LdxMvCC8JxkBtq+BNVpskgNv+Iemqb0CitObZkcZf3A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8eO2OJF8yAlpC6AM7qwSU132Qn4VT3GY0AT/aBzjavrh7eBzRTWc6yaqTq7yUa0l
	 aX+dM1cs4KEzOyHm7oGNsuwOIJIDq+a80KY4F/hBeQYN0rQUjdyk1Z/fvp+9RqGN3b
	 MrOUDJslQfBnbWCyWDRUhbY1SCTSwaPSrER62pwmNKmRQQHDZP8at3dkA1EFjMYrCD
	 Qt76NZphS+u+xGrMd43lr8nLAvV8hL+SRJ3FZHLeqo0wQfhMmvOqdegW7byFx9/Coa
	 wZeaFnF/7aKZcJgg3kvDzDtyKxhYrYD+nkdWRnLrFmuSkcq6SqmZaB0Vv2KvXtMxUD
	 nquCfa+iGgrSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DD4680C88;
	Sun, 11 Oct 2026 19:04:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C740F2E0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8C824008B
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hHR5v9h_3K3N for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 19:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B061940075
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791745445;
 b=sSFfIVZT76EDra88eAdEpOlxdWLVREe/8vRxHDl4JIFEh+ZMUq52vjszRJ/tWZRuyfth
 zzX5H/ChYA70lvHmtVQ70WXWq++LHuRFhIHpEyxqD2VKTMWwszbjlO/020WOo0PHQE397
 XKE+xBV+rlDVcy5QQdi+Mwj6vTN6PlDJYQTa9OBFDZ9PYCEuZGSVUULV28WPypVEB7uvt
 Yu9KIS1kN46loGw4VmuqZD/elvMpYETn64rYQXlgNz2NqC2hu3gJE78yle7R5RQJfySnA
 X6Em7D3owlR53KSQfDybxesVoSM+Oo7/CVnasS8veCbYUTXFDPri/1+GGBJtXKEUD6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791745445;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=LdxMvCC8JxkBtq+BNVpskgNv+Iemqb0CitObZkcZf3A=;
 b=DSli8zCqhQvcEem2YEqSkzYlHNt++4nv9emuJVXjyZpjK8bs0V6u4TPM4kHIr57dwdNw
 zsENLJObbshmqwc7BE6NPtdYOpnNxXvYZz8fE8eEeMkbxVPE5Di28frsxMv+iqxiH7g2Q
 U1jiMGz3lpn1XUIhoTceZZGBSLhx/js9+RxRL/T+fQC/1TD77KRgVhkMU+8lznOAGxl27
 JwpOlV4JnEvogvbrMAYvwDpBrSRdDwUqZQ8pbPVC1xwNTOy1QfU4KpFYljwJTGsRouyAV
 M3Myeb17TYOz42xbWcllm1WQYJPaYCDX4iZx/uhkEwUutaXA7TVYK+sprk1NC8wY88A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UzzUYkcx; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UzzUYkcx
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B061940075
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9B66600E2;
 Sun, 11 Oct 2026 19:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A731F0089B;
 Sun, 11 Oct 2026 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791745441;
 bh=LdxMvCC8JxkBtq+BNVpskgNv+Iemqb0CitObZkcZf3A=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=UzzUYkcxQOL0XlmelgcWjoUE8uZ5mu43l+m4m3WaR9oNIw62zCnUniB7tzEWo2BrB
 m/LtSCL5ygDk1oFfZBldkSOb9zcjhLNCiL0ryQ8J7LHAIrimuDA02HRyFG7gcNaeDp
 hJlAHlApw9NQgtB6uGiS1SdyWdNJPYYCIcokj6uBek3AWSfrNQrfwQN9yFCi/AjY1r
 L/H7nT8TTDqifm4cjorAwd2/DDPlx6Ti2F5nrdw4ff/R7AD535cW+u7s/elWHg0P39
 JDkxuf933VY9tJJkaAlHfRXEPptQgd6XeC196sPAtXgJjdRykcwDhXBIS4gDvJqmwz
 RH2OwqBWE9Ddw==
Subject: Re: [PATCH net-next 2/9] net/mlx5e: check for failure when pulling
 the Ethernet header after XDP
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, jgross@suse.com,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, manishc@marvell.com, 
 rahulv@marvell.com, GR-Linux-NIC-Dev@marvell.com, shshaikh@marvell.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, xen-devel@lists.xenproject.org,
 intel-wired-lan@lists.osuosl.org
Date: Sun, 11 Oct 2026 19:03:59 +0000
Message-ID: <179174543945.434549.12308757559903944189@kernel.org>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-2-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-2-9512b0fb977b@toxicpanda.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In mlx5e_skb_from_cqe_mpwrq_nonlinear()
  (drivers/net/ethernet/mellanox/mlx5/core/en_rx.c), the new drop path…

--

net/mlx5e: check for failure when pulling the Ethernet header after XDP

This patch replaces the unchecked __pskb_pull_tail() call in
mlx5e_skb_from_cqe_mpwrq_nonlinear() with pskb_may_pull(). If the pull
fails, the packet is dropped. The goal is to stop eth_type_trans() from
hitting BUG() in __skb_pull() when the linear part holds less than
ETH_HLEN.

> When an XDP program leaves less than ETH_HLEN in the linear part of a
> multi-buffer packet, mlx5e_skb_from_cqe_mpwrq_nonlinear() pulls the rest
> of the Ethernet header in from the frags with __pskb_pull_tail() and
> ignores the return value.  If that pull fails, eth_type_trans() later
> finds less than ETH_HLEN in the head and BUG()s in __skb_pull().

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index e3f915beebe1b..b1e1e30a77e22 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -2060,9 +2060,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  				pagep->frags++;
>  			while (++pagep < frag_page);
>  
> -			if (len < ETH_HLEN)
> -				__pskb_pull_tail(skb, min(ETH_HLEN - len,
> -							  skb->data_len));
> +			if (len < ETH_HLEN &&
> +			    !pskb_may_pull(skb, min(ETH_HLEN, skb->len))) {
> +				rq->stats->buff_alloc_err++;
> +				dev_kfree_skb_any(skb);
> +				return NULL;
> +			}

[Severity: Low]
Can this new drop path actually be reached? Given how the skb is built
on the XDP path, it doesn't look like the pull can fail.

For an skb with frags and no frag_list, these are the only failure
returns in __pskb_pull_tail():

net/core/skbuff.c:__pskb_pull_tail() {
    ...
	if (!skb_frags_readable(skb))
		return NULL;

	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))
			return NULL;
	}
    ...
}

The frags are always readable here because XDP and memory providers
can't be used together:

- dev_xdp_attach() returns -EBUSY when dev_get_min_mp_channel_count()
  is non-zero.
- The memory provider binding code in netdev_rx_queue.c refuses when
  dev_xdp_prog_count() is non-zero.

The skb isn't cloned either, since mlx5e_build_linear_skb() has just
built it with napi_build_skb().

There is also always enough tailroom, so eat stays negative. The XDP
setup earlier in this function is:

	linear_hr = XDP_PACKET_HEADROOM;
	linear_data_len = 0;
	linear_frame_sz = MLX5_SKB_FRAG_SZ(linear_hr + MLX5E_RX_MAX_HEAD);

That leaves about 256 bytes past the linear tail, and the pull is never
more than ETH_HLEN bytes.

On the commit message's claim that this happens "When an XDP program
leaves less than ETH_HLEN in the linear part of a multi-buffer packet",
is that accurate?

The driver always gives XDP an empty linear area. So the pull runs for
every multi-buffer XDP_PASS packet whose program doesn't adjust the
head.

An XDP program also can't leave 1 to 13 bytes in the linear part,
because bpf_xdp_adjust_head() rejects it:

	if (unlikely(data < data_start ||
		     data > xdp->data_end - ETH_HLEN))
		return -EINVAL;

When frags are present, bpf_xdp_adjust_tail() only changes the frags,
so the linear data_end stays where it is. That means len is either 0 or
at least ETH_HLEN at this point.

If this change is meant as hardening, for example against later changes
to linear_frame_sz, could the commit message say so?

If there is a real way to make the pull fail, could the message describe
it and add a Fixes: tag for the commit that added the unchecked
__pskb_pull_tail()?

>  		}
>  	} else {
>  		if (xdp_buff_has_frags(&mxbuf->xdp)) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b%40toxicpanda.com
