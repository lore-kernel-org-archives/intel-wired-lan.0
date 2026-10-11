Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C510ACA9EC7
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 19:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F09D60607;
	Sun, 11 Oct 2026 19:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rKl63L8eXgaR; Sun, 11 Oct 2026 19:04:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B0936060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791745447;
	b=Bo9s9XiragGzbB4cfL7SFD2z/CttJ8IVI9FaE5YfRpGw5/DEtjLBvGz+yp+wqBg4YnI9
	 0RComU/bZCVXbjlLI4fUB0WbHUI2OKyH7QmkoVputHKjTU/Vzc993mIOKSbOFDV3OoMCM
	 Wc/re0vxNZZwmZLVsJokR6U9wpxv9iGteBcsShO+z+f4/Vw1UVeZ9EW9XqHgu85YLEq2J
	 GnIgW2A4tiOhk3QkJ0INohNIA+GkjwnSnYsTxqvA+I4jIIh8ba5KOfAnFrYOxP0ccbUH4
	 conkT8A875v2Cgy15YHQs8eDxxr9iMdpZRtpn9VJvgM7BIPqa7z7mnAjI66zKSoNH+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791745447;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xwkEhVzbUvjpITITmAO4h3R+R7/UDQRQJB9aMn4M6nw=;
	b=mAN5lDEaSXCieen8bO5oRzR/lUoE/iiecyAttMrOeWcrqoKZLUTdykNBAavGNaORo6mc
	 uQ+UpkL/rBegFKzqglkSyq/dwAQ4cwarRLe8PZJM9bww9nIF/qZIVjizylxMoJOU/0GmZ
	 2w3njT2HXG8wZJAaPPMl2ux9UgzNxyngBwIQSZnbFlVf2RqreVW7T3lbI0kBXzQsjjNdf
	 cA9I7Jq7VGHq9uKowc4ZXytjMfx3FxSkmm3b5iUVrzS716CReomeA0R06xHQM7wYjQiXt
	 Fmre5GXAAjrC7xT5izmaFrq+t0Fkk5CcLRr+e7n/2pleBGrSb4CEyLD5uoa/Bm8dNOw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791745447;
	bh=xwkEhVzbUvjpITITmAO4h3R+R7/UDQRQJB9aMn4M6nw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V+KC+Ak3m+b/iK/3HgNfndi6gXVSUZQbsfudjUSdUfo6bn1TWGQm18cwYs13IDbwR
	 RS3iPVIG32Vz4fLUMnXHmky+1OpMYZKWb8W7MqZlKxr31XiCKZgNYr+NcOqUzdWU8N
	 zNe4OEWfvnCmfKVYY7VRbnt39oeBXhZs9F8bkf5Y4uD1uLXtDCBstArh6AfY1oNeL9
	 2u/6XJnDbWxUiGHnHDhTBdQbhtZIg21KBLo1iNPLjfluMhKmpsJHRcsS+Nottq0p85
	 HBpnOTEiuXVJKUPwkgTKRz8CKNEFKgeEpgWLBGFY2/PHmlvFs/iijjqXS0e8ONQX3F
	 ceTD9NvQOqBfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B0936060E;
	Sun, 11 Oct 2026 19:04:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B272675
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9763180C8F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id To7h6JbsMqGZ for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 19:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 63D3D80C7E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791745445;
 b=ifWS6fqr/REnyIaEM8C2cKBflDhT5NnNhsaD195KFCBNSeKPyMDZiA1tARlNYv6CNWkV
 67jw+C9S7klZYBPO0P8KMcZPIPNuCBoaJkC88UaQggzdeFd8S9dLxS1ZxVOqRebr8HHXG
 LFKlZsQj8p9LKbFVd/NcRqr3TxXE35qs1Uz0uormCtLemX2JCnX59UkJAXHbnLqQRPzel
 j5habRECKOCX8xF6cGr+Yh+nb8U98Uhl7rhdnqMIyYM+9IZ2fpEAt5XPNhieWJg/7nj/7
 YgQwZequ9HcBp0N34Kfh9CE6dDPqXxIuS51LKYNxrSkTPEFdVCgravrE5gCFzJlrNhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791745445;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=xwkEhVzbUvjpITITmAO4h3R+R7/UDQRQJB9aMn4M6nw=;
 b=FUo7IRxYyvjc1lAL/vZjX4XrRgH1jFYF37t/J0jXRAKxTRLjRSbRBq6Ws/XUQamwtoTM
 B7Qv7jJFQCKFEsdsHXFR6lN0rA/1MB2ZzU1GdPEdfhkI4SeWiuLlip8uz1jLmRGi82hLR
 97KgIyqQJuPkcuZ+hxlEwcTSnbw216wiu2xJQaa3q6xEFenpqxoG0GvxENnRh78g+s8M2
 AclO31D1PlR6R0p5s8aiI1Nnkd8M5P//UPmnhyU8CyavD86IfuaLSYX9Y1knOI7mxVkjp
 7cy5ex73xo0BCHkgJsS6x1omQEy0tVijwVmnZqSUFCbvGyVLgm3U7QrFRp0rZNJfMZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=T6j22e7N; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=T6j22e7N
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63D3D80C7E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F03DE60232;
 Sun, 11 Oct 2026 19:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435F91F0089C;
 Sun, 11 Oct 2026 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791745443;
 bh=xwkEhVzbUvjpITITmAO4h3R+R7/UDQRQJB9aMn4M6nw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=T6j22e7NaJcS2fr8bxi+2fkNg3yrrBUkW62t0KEMPQPEPq6c0g63GVfOejKgcDELZ
 nmYI+TGJ0tsychweaRGXM07GIaFEB966dLGXJyiPj6MPWOn/DFHhGqWRvNFsXTA1ra
 87Xeej/L81UcUVZorzjZeW51kYQGMzJcfsJTcZoB4zTKj0JyWidBNaJOJ6Ktoxn5FJ
 GSPMJY8QX27VBcLnNvtiLgJLQ18xB1oxYB/arUS4CmN/96Q3lt5LR2+ABSHrV4KunZ
 WzUvdS5XWPMRzPg/0rwoxHPa8HFmiuoRrT0YDo5ToOt5LgXojsjM/Jcx4KN/A2GZD8
 uXYz9dXc4NUqA==
Subject: Re: [PATCH net-next 4/9] xen/netfront: check for failure when pulling
 in xennet_fill_frags()
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
Date: Sun, 11 Oct 2026 19:04:01 +0000
Message-ID: <179174544182.434549.6411289628191595001@kernel.org>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-4-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-4-9512b0fb977b@toxicpanda.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch now sends pull failures explicitly to an error path
  that leaks the head skb.
- [High] net: xen-netfront: memory leak of head SKB on
  xennet_fill_frags() error path
- [Medium] In xennet_fill_frags() (drivers/net/xen-netfront.c), replacing
  __pskb_pull_tail(skb, pull_to - skb_headlen(skb)) with…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  xennet_fill_frags() (drivers/net/xen-netfront.c) reads each follow-on…
- [High] This problem wasn't introduced by this patch, but in
  xennet_poll() (drivers/net/xen-netfront.c)…

--

xen/netfront: check for failure when pulling in xennet_fill_frags()

When the skb already has MAX_SKB_FRAGS frags, this patch makes
xennet_fill_frags() call pskb_may_pull() instead of __pskb_pull_tail(), and
it now checks the return value. The BUG_ON() on pull_to is removed. Both
failure exits now share a common err label.

> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index 2ed673649c488..6e01a883cc64a 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -1174,18 +1174,11 @@ static int xennet_fill_frags(struct netfront_queue *queue,
>  
>  		RING_COPY_RESPONSE(&queue->rx, ++cons, &rx);
>  
> -		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS) {
> -			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
> -
> -			BUG_ON(pull_to < skb_headlen(skb));
> -			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
> -		}
> -		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
> -			xennet_set_rx_rsp_cons(queue,
> -					       ++cons + skb_queue_len(list));
> -			kfree_skb(nskb);
> -			return -ENOENT;
> -		}
> +		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS &&
> +		    unlikely(!pskb_may_pull(skb, NETFRONT_SKB_CB(skb)->pull_to)))
> +			goto err;
> +		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
> +			goto err;

[Severity: Medium]
Is pskb_may_pull() really equivalent to the old call when pull_to equals
skb_headlen(skb)?

pskb_may_pull_reason() returns before it reaches __pskb_pull_tail():

    if (likely(len <= skb_headlen(skb)))
        return SKB_NOT_DROPPED_YET;

The old code still called __pskb_pull_tail(skb, 0) in that case. Its
pull_pages loop removes every zero-length frag, even with eat == 0:

    if (size <= eat) {
        skb_frag_unref(skb, i);
        eat -= size;
    }

That lowered nr_frags and freed a slot.

xennet_get_responses() accepts zero-length responses, since it only rejects
status < 0 and offset + status > XEN_PAGE_SIZE. It also allows
XEN_NETIF_NR_SLOTS_MIN + 1 (19) slots when the first response is at most
RX_COPY_THRESHOLD bytes.

Take the default MAX_SKB_FRAGS of 17, no XDP, a 64-byte first slot,
non-empty slots 2-17, a zero-length slot 18 and a non-empty slot 19:

    slot 18: nr_frags == 17, pull 64 bytes, frags[0] consumed -> 16
             zero-length slot 18 added -> 17
    slot 19: nr_frags == 17, pull_to == headlen, pskb_may_pull() no-op
             nr_frags >= MAX_SKB_FRAGS -> goto err

The old code would have dropped the zero-length frag at slot 19 and
accepted the packet. A zero-length first slot gives the same result,
because frags[0] is then zero-length.

Are these packets now dropped and counted in rx_errors, when the old code
assembled them? The commit message says "pskb_may_pull() does nothing if the
head already holds pull_to bytes", but that does not match the old
behaviour in this case. These drops also go through the xennet_poll() err
path discussed below.

[Severity: High]
This is a pre-existing issue, but in xennet_poll() pull_to comes from the
first slot's status. It has an upper cap but no lower bound:

    NETFRONT_SKB_CB(skb)->pull_to = rx->status;
    if (NETFRONT_SKB_CB(skb)->pull_to > RX_COPY_THRESHOLD)
        NETFRONT_SKB_CB(skb)->pull_to = RX_COPY_THRESHOLD;

Suppose the backend sends a first slot with status below ETH_HLEN and
XEN_NETRXF_more_data set, followed by non-empty slots.
handle_incoming_queue() pulls only pull_to bytes and then calls
eth_type_trans():

    handle_incoming_queue()
      __pskb_pull_tail(skb, pull_to - skb_headlen(skb))
      eth_type_trans()
        eth_skb_pull_mac()
          skb_pull_inline(skb, ETH_HLEN)
            __skb_pull()
              skb->len < skb->data_len -> BUG()

For example, a 5-byte first slot followed by a 1000-byte slot gives len =
1005, data_len = 1000 and headlen = 5. Pulling ETH_HLEN leaves len = 991,
which is less than data_len.

Can a backend crash the guest this way? Should pull_to be clamped to at
least ETH_HLEN? With a single short slot, skb_pull_inline() returns NULL,
so this only applies when frags follow.

>  
>  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
>  				skb_frag_page(nfrag),

[Severity: High]
This isn't a bug introduced by this patch, but xennet_fill_frags() reads
each follow-on response from the shared ring a second time. It then uses
offset and status without checking them again:

    RING_COPY_RESPONSE(&queue->rx, ++cons, &rx);
    ...
    skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
                    skb_frag_page(nfrag),
                    rx.offset, rx.status, PAGE_SIZE);

The only bounds check runs in xennet_get_responses(), on a separate local
copy that is then thrown away:

    if (unlikely(rx->status < 0 ||
                 rx->offset + rx->status > XEN_PAGE_SIZE)) {

RING_COPY_() does a volatile load, so this is a fresh read of memory that
the backend can still write.

Could a backend rewrite the slot between the check and this read? A
negative status would lower skb->len and skb->data_len and store a huge
frag size. An offset plus status past the page would create a frag that
runs past the RX page.

Commit 8446066bf8c1 was meant to make netfront read each response only
once. Could the copy already validated in xennet_get_responses() be reused
here?

[ ... ]

> @@ -1198,6 +1191,11 @@ static int xennet_fill_frags(struct netfront_queue *queue,
>  	xennet_set_rx_rsp_cons(queue, cons);
>  
>  	return 0;
> +
> +err:
> +	xennet_set_rx_rsp_cons(queue, ++cons + skb_queue_len(list));
> +	kfree_skb(nskb);
> +	return -ENOENT;
>  }

[Severity: High]
net: xen-netfront: memory leak of head SKB on xennet_fill_frags() error path

1. Consequence: Memory leak of the main/head SKB and its data on the RX error path. Over time, an attacker triggering this error could exhaust system memory (DoS).
2. Triggering path: In xennet_poll(), a head SKB is dequeued from tmpq. It is passed to xennet_fill_frags(), which attempts to merge additional fragments. If pskb_may_pull() fails (e.g., due to memory allocation failure) or if nr_frags still exceeds MAX_SKB_FRAGS, xennet_fill_frags() returns -ENOENT without freeing the head SKB. Back in xennet_poll(), this triggers goto err, which loops over the remaining fragments in tmpq using while ((skb = __skb_dequeue(&tmpq))). This loop overwrites the skb local variable, causing the head SKB pointer to be permanently lost and leaked.
3. Reachability: High. A remote attacker could potentially send highly fragmented packets designed to exceed MAX_SKB_FRAGS to intentionally trigger this error path and exhaust memory.

[Severity: High]
Does this error path leak the head skb?

This exit frees only nskb and leaves the partly built head skb with the
caller. In xennet_poll(), the head skb has already been taken off tmpq:

    skb = __skb_dequeue(&tmpq);
    ...
    if (unlikely(xennet_fill_frags(queue, skb, &tmpq)))
        goto err;

The err label there only drains tmpq, and it overwrites the local skb
pointer:

err:
    while ((skb = __skb_dequeue(&tmpq)))
        __skb_queue_tail(&errq, skb);

The GSO failure path just above calls __skb_queue_head(&tmpq, skb) before
goto err, but this path does not. The head skb is never freed or requeued.

That would leak the linear buffer and the page_pool frag pages attached to
the skb. These include pages moved over from earlier nskbs whose nr_frags
was set to 0.

The leak has existed since commit ad4f15dc2c70 (2018). However, the commit
message assumes this path drops the packet ("take the error path
explicitly"), and the change above sends more packets into it.

Should the head skb be put back on tmpq, or freed, before goto err in
xennet_poll()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b%40toxicpanda.com
