Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786B9CD98E2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 17 Jun 2026 08:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E79E85D40;
	Wed, 17 Jun 2026 08:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8uUF2s40rDQG; Wed, 17 Jun 2026 08:47:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEF1585D3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781686030;
	bh=htuQhUa1HfSLqmSf+a4aGM2L9LirqJSYUGKvORQmPkM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hz99ha2OLp/31/B4hUJqN6qzjpm1sQFHnJ2ECAYv8QdYXJFgJYc1y05jkpO3Rcwtc
	 zS6WMmmwh78w4A/U9ILHcaNjus/phQyq6Y5rzPuh0Ob4AgRMtCSwDHlBk7jUWodwS5
	 83QeO8duygwCwvAxUfV9t1InvW/AxGhxDzHNykb1WGkc4qDkPz4m5xk1NvRqsgPSc7
	 OS662t7kaD3i5MiUSO8RBoVZBUHnf3PJ49pTTMG0uXnO7G/KZijNVvetTfs33MffBh
	 5nelc78fHuWgZR4i4Ak+DYyV5kGnxt2MOJR1Lfe5F3xpb2a2HOQkBnI1OgYbMoQ6GW
	 Ddt1RLvjc3SsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEF1585D3B;
	Wed, 17 Jun 2026 08:47:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 74DFD33C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 08:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EE6640102
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 08:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOWf8g_lyIaM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 17 Jun 2026 08:47:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A55BB400B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A55BB400B0
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A55BB400B0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 08:47:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 147E0600AA;
 Wed, 17 Jun 2026 08:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB421F00A3F;
 Wed, 17 Jun 2026 08:47:03 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:47:01 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, piotr.raczynski@intel.com,
 michal.swiatkowski@linux.intel.com, wojciech.drewek@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <20260617084701.GB827683@horms.kernel.org>
References: <20260615140532.52676-1-doruk@0sec.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615140532.52676-1-doruk@0sec.ai>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1781686026;
 bh=htuQhUa1HfSLqmSf+a4aGM2L9LirqJSYUGKvORQmPkM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DuxFI3dCysid9xJBJTERwWsTGfgg74K3i4Y+T0uvGz+gjHYu4R5MZbHNjglDc4BNi
 nV/lwjA8n0qbbpt38AVe835BqANxZ6BsFQPgNIw2X4JN8CqnH8+++HJZ/4L7EThdZQ
 L2YR9q2MCF3Zm4l7TRPTNDZccOuCrYyNLZ77G7UK1KKXrqQdxmHxOVj69Y6HxhywCM
 oCtxeDe8EHLcCDdx3+yFsRKpLXRiuhfRm+MkQt1pekWrWzm8rPBh2AK1ZDR59aWwyI
 ERvV994c8jW2KZ2KSR9qo3Os7KFZEKl8kOsfzMg1q1cv3ZZmCTyXdN6QSvF+d5BqJQ
 R1M7SHYWx8pZw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DuxFI3dC
Subject: Re: [Intel-wired-lan] [PATCH net] ice: eswitch: fix use-after-free
 of metadata_dst in repr release
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

On Mon, Jun 15, 2026 at 04:05:32PM +0200, Doruk Tan Ozturk wrote:
> ice_eswitch_release_repr() frees the port representor metadata_dst via
> metadata_dst_free(), which directly kfree()s the object and ignores the
> dst_entry refcount. The eswitch slow-path TX routine
> ice_eswitch_port_start_xmit() takes a reference on this dst with
> dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
> is still in flight (e.g. queued in a qdisc) when the representor is torn
> down, the metadata_dst is freed while the skb still points at it. When
> the skb is later freed, dst_release() operates on already-freed memory.
> 
> Replace metadata_dst_free() with dst_release() so the metadata_dst is
> freed only after the last reference is dropped. The dst subsystem frees
> metadata_dst objects from dst_destroy() once the refcount reaches zero
> (DST_METADATA is set by metadata_dst_alloc()).
> 
> Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
> nft_tunnel: fix use-after-free on object destroy").

I think that the commit cited above moves the code in question around
but did not introduce the call to dst_release. And I think that this
bug goes back to when switchdev support was added.

I would suggest:

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")

> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Otherwise, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

