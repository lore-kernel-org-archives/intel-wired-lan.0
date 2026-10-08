Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF78ACA600D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75F96408CB;
	Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k5jmpBmrCgpd; Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A8799408DB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791483419;
	b=TijlMhMGmNTxcRgpE4c3x+wrU7XPQClNwJpue2A3QzNYUP5YcUvYEomi1bMw+EXp7Lyp
	 UDkAe8ojCnFydhAgugn618xFceDCsjlDDJspjrUlsD7uoY6Kv/dhnmB8eWUjFrarLXjiq
	 veZQJRSZ7WUV1NRoV5bf8sDq8YK9l7/LbTWrMUxqob4Uf0x8yxndueM+xW/8djMtyw/Mk
	 FWJDNhKzIJQEkjpGhhxY9mvq0QUH/lOEk6NnJ34CK/rFhP25UIaJiuK3i47KUJ1m7l9iz
	 xOVOG6AiqfRfGD+7wUBJJhJkOp5o8FbqBBnEvrOvTheGhuuyLWbdP1bsuANeAcYXVLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791483419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=VzoVMQbcXgYaOLQ53frGvWFhNKe6dxLXGK1tt8CobLw=;
	b=ptLshs9tJHkz8Ep8IvLdZWKwlFatD0JLICfgZ570Z8zOm+FHSvuGL/9DbtoUePZwMBAL
	 FqVp4YLobi9qXIgrGguX5JgsA7fYQrcqYfdKJ/EpEU68ToyfxPJIw52IZ6rEPCshh59+k
	 YvRsDAFnUW3kwXfHrqq/XkegQhz6gR0L+T+b8gsbELysYnqz0esQzoOoKOBvlDtv16IxB
	 EF2jc3/CAWnTQWIn/1raRYM9YoAznTJ44Q5ZEgjjqc4cIfCl18RgCm2Y4HL1P3dka0Y+F
	 TqJHR6tmRis6wntp4avEmySAlqsV4g8R5dG71p8aFL243yiRABFesUT5Q0ULrJ41gYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791483419;
	bh=VzoVMQbcXgYaOLQ53frGvWFhNKe6dxLXGK1tt8CobLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=gRNGv93283CaL+WrpGbaLZardzn1K3G0kEGHiWqYty0LNnIK3F4dnOhQ6vKPXugIw
	 ud8L+nm2z0qfMRzkFNM4414iLahZ79pAbAJiUlItudBemOPBHKiBm64W1gOrKp7he9
	 n8mC8vkL24htteAF5jJbSrPC7on27Ph7BG2W9cbZlqjRYkLc1y1kvfPiGhMaDgZf4s
	 M/tAqPL4aGkbbyeP5grdNkkcNIVPqkOaPFP7z+mF8/C5S7zwnp+FODhYpXb/FzatQ5
	 FIeUfijH+J7wgdxbaMJw1H3w2rUTzoIDJlK5hP0rY7Svhqd/435OHIldrix3gMF626
	 HCvyrFeVf9HWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8799408DB;
	Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E3246338
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4EB0403A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id At6CRxepEvhh for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 10A59401A0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791483417;
 b=cgQQ5+Jc+pcGCeS3xPcFdY5r3fwX1F2nd/FlRuDXwe3EbSvvPcivl45MWTpfW17fplfd
 mX/JIidGVfSAFajFkOGuoKXbFTfkrFxRh2Im5mvpS7eStD6mBszbCESUcpZ2VHh5p/IPL
 ueK+mIA0thZqcdvpK31uNnJ6Qy3ePmVZiqfl9ryLf62217g/YgTIphGg/ZyzRwI1wzREt
 U/OvVz+ChTLCSYdPMWzYdo3mPNK7lLESkBZ3fYiFETI8l88kMPi8s87jvLt0tUC6Gbhpc
 X89LAFL6/Q4/Fi6jHVqzKs6GB2AZI+2jaFfClZPfmdw3Z28/vuYMe0facMky2uqF+oA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791483417;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=VzoVMQbcXgYaOLQ53frGvWFhNKe6dxLXGK1tt8CobLw=;
 b=aiZCOr+jmqKOyGFcLExlgbyf+WCUKO94yJj2m/i4WJQFc1TtAo6bRWAhugZ8Mtvfi0Ib
 imxhREcMRCRbbeWUiPwiGzT67CNt2KlVKl371pytq2a/UhpVEu+0P+M1GzWNfkgN6zb73
 EobNZX6Ssl4sMPk5TkbgUx49Dy38ld0shiaKsmJJXpUhjVeahWF8ZPusJzwwshyfhEBwi
 Nid1sKTPf4cMuNk58M4rZ5BXvvA2zQ6TagPGEx6REpPeK9OzWzQ3maKTx0tg1nX4Bumwq
 JK8WW8oNXWqr511OGboqVXDQTcMPmmFfFhgPQnEk4mD5++QnNPxue8e+E8axbIxM/7g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="StkK/jkM"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=StkK/jkM
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10A59401A0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8D6C42B90;
 Thu,  8 Oct 2026 18:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703321F000FF;
 Thu,  8 Oct 2026 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791483415;
 bh=VzoVMQbcXgYaOLQ53frGvWFhNKe6dxLXGK1tt8CobLw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=StkK/jkMTpyb+AzE/tDrSX2x1t6KudlDL2MRlLUbqwB2EHikAw8/0ZsBOmqKIe4Xx
 yHkctIIZGrQPznJ9maDo1sfsaSIIPws1qzcdnFTRl5H2rTAgUa+ZbOTr4KwmSyx3P3
 5SI6C0vgRnL8HTvjNLNuGGp8IWxNeV9b3/48YNghWKIlf4NVQ5Ko9AuCBdOD0r3e7D
 tFeBCt6YdWBRh1zRx2iOabAZ9UTx0lXiz/OiNqGTZblQP34h98f3bXOjAkWk9Hl45u
 JXtvyACi+Jv6QdQ0R5WeBStpYJ0Lv+0EdJsfMxLAFaoA3o7kQh+dcDihdfHySg4b/e
 xyugb6I6716zg==
Message-ID: <sashiko-outbox-164442@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 4/9] xen/netfront: check for failure when
 pulling in xennet_fill_frags()
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-4-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-4-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 18:16:54 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: xen-netfront: memory leak of head SKB on xennet_fill_frags() =
error path
--

commit 35a098cdf4bebe9adc4115a04a7fd029b02400ea
Author: Josef Bacik <josef@toxicpanda.com>

xen/netfront: check for failure when pulling in xennet_fill_frags()

When the skb already has MAX_SKB_FRAGS frags, xennet_fill_frags() pulls
the start of the packet into the head to try to free up a frag slot. This
commit explicitly uses pskb_may_pull() and takes the error path if it
fails.

> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index 2ed673649c488..6e01a883cc64a 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
[ ... ]
> @@ -1198,6 +1191,11 @@ static int xennet_fill_frags(struct netfront_queue=
 *queue,
>  	xennet_set_rx_rsp_cons(queue, cons);
> =20
>  	return 0;
> +
> +err:
> +	xennet_set_rx_rsp_cons(queue, ++cons + skb_queue_len(list));
> +	kfree_skb(nskb);
> +	return -ENOENT;
>  }

[Severity: High]
Does this code leak the head skb on the error path?

When xennet_fill_frags() returns -ENOENT on failure, the error path handles
cleanup for the individual fragment (nskb) but does not free or requeue the
main head skb.

Back in xennet_poll(), upon failure, it jumps to the err label without
placing the head skb back into tmpq, unlike the xennet_set_skb_gso() failure
path just above it:

drivers/net/xen-netfront.c:xennet_poll() {
    ...
		skb =3D __skb_dequeue(&tmpq);
    ...
		if (unlikely(xennet_fill_frags(queue, skb, &tmpq)))
			goto err;
    ...
err:
			while ((skb =3D __skb_dequeue(&tmpq)))
				__skb_queue_tail(&errq, skb);
    ...
}

This loop overwrites the skb pointer, causing the head skb to be permanently
lost.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-pskb-pu=
ll-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com?part=3D4
