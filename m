Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26E5CA9ECA
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 19:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86A846061E;
	Sun, 11 Oct 2026 19:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hirOaBSUtA5d; Sun, 11 Oct 2026 19:04:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87D6460622
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791745451;
	b=jIyTh6+a4prciBtoKY8LRojrkhObCG5P8i0v9QyKWGQi9q6UTWnrNBh2D7rONxfut81Z
	 gOCUPCsbf8Kl1dqJxusfdF3MMeJVct8OpkuCQXHx9g1WfrFeRjY1GSKfliM+Frke/+oA5
	 /R0fSl4yd/Ff1eCXdWSTol9uSCp+iqCogtVarNlvUs2TsqURFYVp7s8Ls/WCO3WDiCGxZ
	 rxyT6xttyWdaZvUCt1YbbWhxte/VbOcfqEJ17pNVll0rMrNUj0wHnSTSLn+h1ndr3r+fZ
	 8bgzDMujPEaiTQyBToo4jlqKVt7A0kHcMYEv7kJHspMKLLqGBhjhiWZh+TrH4Ls9SGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791745451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WuowvedJwpfz9l4BSl0jWJ9ure/QdY1u7QLk9R2KaLE=;
	b=q3pvELFu3GWbASgI5qMO+YWEH8MKeqpby/DfctSwkOmvFVww+n39cT3R2dAPfRSdcenU
	 RELLP+/CSrffMUvwwwTNfEnMfTAY0wVtPoG+2xqdcKOqYggySzcC+spxkmTnungckzgFl
	 mETd9T301uc99pP7Nd9wz50CF6dqFZeHeTozYl3ijChWmvMsnX6zE5+XfL7DZ+p4q89Jq
	 /wILlk3nJa2qAUqwioVMSa2Uo9y9FSPMIfWbfgihokeQHI0QIYRcAJQ16qZo5QDRKj4t7
	 QK+JyyE1wu2bvJrwgWYacPdZkEwhv3eXByoAUrx7uYZDZINKbqZ6x/TZhIhvBPslS7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjO6s4Kj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791745451;
	bh=WuowvedJwpfz9l4BSl0jWJ9ure/QdY1u7QLk9R2KaLE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WdEy3Og2yWkKYOY1QLtBBp56wWS8kb2h6VdrvyHcuWdWdr9/NcX5C5nm8DOMyGCwt
	 Nt/vPgSH3gPaOWonrfSuPELSJu1Jw5Wdl474LoxVKFiDYTNq3/H6+lUlE1v4MvK13m
	 xnw2/mf/vc6DPeFYyDtsA/YtjhouzSgqK3lwJ3s8kV+ZFnC5+YAj14AazJgOOxPGMy
	 JUL4zujnVtba6vHbiWWfx55+RMw8lt+5FAC4zlCE96ACVDxCBygywrx4XtxC12mH25
	 ooYlJLop4LV2tIJrcvNQ+haOtqoOqYJVZOuClCeYNPzdNCMXVObrnQbn1Y+nKuHIps
	 bSxYMO7n89Bhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87D6460622;
	Sun, 11 Oct 2026 19:04:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F08BE75
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6A9C60622
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KoiMTz5GMjrD for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 19:04:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3F286061E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791745449;
 b=sunQdMzt3FTCcZYAxm2TeBVRFO5aINaf72qsi59ShpSqzXT01qjmWN6pQGwhYgruu/cY
 Fw1izN/Df+ImKohVItrS4TuydLltBVDsgPpnpmVIZ/vyw5Qg7U+Y88/9DYYwWkoWz/K3c
 NGsois8OmWYn+vUD3mSzm3u2u2lOwaoCc4kbCziPYc8ow6i1CJ6fIRYVvJVtX5rPIzoHT
 9t5e76M8ThK/XZtCgVz+yVoN7CMEuL7KxK3RiqW7oFh4tVF0ya0dmTLeW1WmEOiH9rtJB
 tzRk9EkigBExzWOQWYTdKuIIjEhcQ7shYKrUCn9IYN12cDSIE9xNbIenGp5GRBIuRZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791745449;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=WuowvedJwpfz9l4BSl0jWJ9ure/QdY1u7QLk9R2KaLE=;
 b=P3AsWOPBpJN94Y7EbhBeJCt5kv5Odfhc1oW61VA5eWI8e8jxYt9CLQc/lS8JByqGNqQG
 RsUHO3fS/6EqS6EOqDjG+geVYd6XnxkyVw2Xa+t7VbUny6luXFNQd0Au9YqB1/5DB1qJn
 +cel39nA1jfPD+HvlI+LbCxAin35L7aeKMat3ivGias+0hshJemS2Uoje8TwjdWeOm5Rb
 wo/PoCNWZ+7TRmnE9IEHcxUN2hIah3urGLA8lY+zWYcZXqhtmJhu/51GqRhO860/1Xalx
 Yp4MrONex43pEAzXV9Rg5tVnYg6tAJlTV/R3pXQZzJ/kLRnvM7J2HfmOw0gV56rO2Eg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RjO6s4Kj; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RjO6s4Kj
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3F286061E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8847560234;
 Sun, 11 Oct 2026 19:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDB91F0089C;
 Sun, 11 Oct 2026 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791745447;
 bh=WuowvedJwpfz9l4BSl0jWJ9ure/QdY1u7QLk9R2KaLE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=RjO6s4KjJvi7xkGcHN5EHGT6aPnhgDHeKBQR4KlNGg7G3veS5ERT6aUTK0AaS+4Au
 QseF9/l1US2IoNpmNX9S4or7ctEpEDBqd4luzSXcwVwLvWC/ob4sSqW50KbQFv8VP+
 cSKMW70BgZb4peazc+WL0283hDfOSOndopEX2uDci/VjZ3T9uvQjL7oxNMNy4J6w4a
 ZwHUFm0MglbCCDknOMuQEuBbGKN1yCMBhv60uStpzDWgSMLVy2rZ/sdk7S2gq+AV/p
 +L+qnEjLswbYR/fpUhp92yCUmV+pDpVv08AfapC+huhSJ0OAdvt+J8K2Qskq7fTlCj
 rEvn6Jy/KogHg==
Subject: Re: [PATCH net-next 7/9] netxen: use pskb_may_pull() to pull excess
 TX frags into the head
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
Date: Sun, 11 Oct 2026 19:04:05 +0000
Message-ID: <179174544563.434549.2218178416870785309@kernel.org>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-7-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-7-9512b0fb977b@toxicpanda.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In netxen_nic_xmit_frame()
  (drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c), the new…

--

netxen: use pskb_may_pull() to pull excess TX frags into the head

This patch changes how netxen_nic_xmit_frame() pulls the TX frags that
don't fit in a descriptor into the head. It used to call
__pskb_pull_tail(skb, delta) directly. It now calls
pskb_may_pull(skb, skb_headlen(skb) + delta).

> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> index 67d9bf69f8f29..202deb64ddefb 100644
> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> @@ -2045,7 +2045,7 @@ netxen_nic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
>  			delta += skb_frag_size(frag);
>  		}
>  
> -		if (!__pskb_pull_tail(skb, delta))
> +		if (!pskb_may_pull(skb, skb_headlen(skb) + delta))
>  			goto drop_packet;
>  
>  		frag_count = 1 + skb_shinfo(skb)->nr_frags;

[Severity: Medium]
Does this behave the same as the old call when delta is 0?

delta is the sum of the sizes of the leading excess frags. It is 0 when
every frag in frags[0 .. frag_count - NETXEN_MAX_FRAGS_PER_TX - 1] has
size 0.

The old __pskb_pull_tail(skb, 0) still ran the pull_pages loop. With
eat == 0, every zero-size frag matched the size <= eat test:

net/core/skbuff.c:__pskb_pull_tail() {
    ...
	eat = delta;
	k = 0;
	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
		int size = skb_frag_size(&skb_shinfo(skb)->frags[i]);

		if (size <= eat) {
			skb_frag_unref(skb, i);
			eat -= size;
		} else {
		...
	}
	skb_shinfo(skb)->nr_frags = k;
    ...
}

So those frags were dropped, and the recomputed frag_count was back
within the limit.

With this patch the length passed is exactly skb_headlen(skb). That makes
pskb_may_pull_reason() return early without calling __pskb_pull_tail():

include/linux/skbuff.h:pskb_may_pull_reason() {
    ...
	if (likely(len <= skb_headlen(skb)))
		return SKB_NOT_DROPPED_YET;
    ...
}

The skb is left unchanged, so frag_count stays above
NETXEN_MAX_FRAGS_PER_TX (14), and nothing checks it again. After that:

netxen_nic_xmit_frame()
    netxen_map_tx_skb()        maps every frag, zero-length ones included
    netxen_set_tx_frags_len()  writes the oversized frag count
    descriptor loop            posts buffer_length[k] = 0 entries across
                               extra cmd_desc_type0 descriptors

The comment above this block says only 14 frags are supported for normal
(non-TSO) packets. Could this post a descriptor chain the hardware
doesn't support?

When delta > 0 the two calls are equivalent, so only the delta == 0 case
changes. It isn't clear whether zero-length leading frags can reach a TX
driver today. Nothing on the TX path appears to rule them out, though.

The commit message describes this as a direct swap:

  "It already checks the result.  Switch to pskb_may_pull(), which takes
  the length the head should end up with and checks it against the skb"

Would it make sense to re-check frag_count against
NETXEN_MAX_FRAGS_PER_TX after the pull, and drop or linearize the skb if
it is still too large?

The later patch "qlcnic: use pskb_may_pull() to pull excess TX frags into
the head" makes the same change in qlcnic_xmit_frame(). It looks like it
has the same delta == 0 gap.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b%40toxicpanda.com
