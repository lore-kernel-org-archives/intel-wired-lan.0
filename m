Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AB1EEC2AB
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Feb 2026 23:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64288823DD;
	Mon, 23 Feb 2026 23:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GDQOQc61sMLD; Mon, 23 Feb 2026 23:18:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C09682369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771888730;
	bh=tvsx03czcawTRB5M2mxe0UTx9RSL+lNFq+Jv45+/rXQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fn8C2U8TKOAMIdKZiX7r9aAE6XPINC1PXvZie59AKRiONNugcUvhSWTQbPhkBvKnS
	 f0CDTA9VMsR0veQceXEZlVCTTgUZiMluugmusRJpUzQfoLwa+fdMe1UtXVL6vaaUJu
	 twZQQbXGWKdHueCj7giznQBWKzPF5iI3Npzugpn0eoLgstW0sumaAoWvOPfe1O6DwP
	 0jZ6u0W/lThCiiBzCjiMTjSKMvMbTHe+tmlnmts7pwEml4942M8+7K+nDZIKoxhsM6
	 xnHAUDp9o/VAbTStbTuw1DxSNgIRjxCsnJJWcusQuXFIjIMHi1AilcvZE7Yr/9Fkbl
	 3fCmQlLlri+jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C09682369;
	Mon, 23 Feb 2026 23:18:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85B37237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 23:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B7FC409C4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 23:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGI-cecRicFS for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Feb 2026 23:18:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B851D409C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B851D409C0
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B851D409C0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 23:18:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 03E1D417E6;
 Mon, 23 Feb 2026 23:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC4EC116C6;
 Mon, 23 Feb 2026 23:18:46 +0000 (UTC)
Date: Mon, 23 Feb 2026 15:18:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Message-ID: <20260223151845.06db43b0@kernel.org>
In-Reply-To: <aZyKWoxnywXKWth9@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <20260218174742.62a4074f@kernel.org> <aZbuWBnmh_SQJyVf@lore-desk>
 <20260219091344.1d8517f3@kernel.org> <aZyKWoxnywXKWth9@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771888727;
 bh=CYLrkQbplhVLWpLwYQI2kVgix50aUPHsmv7SwhslwTg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TlZbVIG0zfxSp01GgD2+JrWlDWhpRYIi9iTBhCrYsyrhBEvafKGrz2Sy10Zr/MQkO
 X1SL7F61crQZeQWRjiwxV8hbfegSYseFSQVFEm3T0eSv7L1gLYAWcFx88Chz+qnBzR
 qxzUVv9nXlsD5qoFeVw2MpDIz2ZJBws9y/8zBWThrTv1CUFXmms+yQKrqAfBJe58Rj
 wzoFidKhPfAGKJtuWuzd3CSqX6uLhqXhwQPvDkLXHlNpf/7Xie1DnA9YPLi/1rPJUG
 2Uvl9A1L5WmKRP7FY64FUyfKI4LTjN9DyLsOPBIVeTR5NmcYTzMkfxsK50Z4nHKidf
 m7ZoZ1PlpHIWg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=TlZbVIG0
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v3 1/5] netlink: specs: Add
 XDP RX checksum capability to XDP metadata specs
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

On Mon, 23 Feb 2026 18:11:54 +0100 Lorenzo Bianconi wrote:
> > Off the top of my head drivers prefer reporting UNNECESSARY when they
> > have both, and reserve COMPLETE for cases where L4 could not be found
> > or is incorrect. Why don't we report both? We're using 3 args, we still
> > have 3 to go. We could turn ip_summed into a bitmap and have explicit
> > output args for both level and csum complete value?  
> 
> Ack, thx for the explanation. Just for sake of understanding, is there
> any NIC capable of reporting both csum_value and csum for the same packet
> in the DMA descriptor? Or is this change needed to be future-proof?

Both nfp and fbnic definitely can. Off the top of my head - mlx5 also
can, but I haven't double checked.

> > One more thing I'd like us to at least have a plan for at this stage
> > is how to deal with COMPLETE + modified packet + XDP_PASS.
> > Right now some drivers discard COMPLETE when XDP is attached since
> > they can't be sure if XDP modifies the packet. Other drivers don't
> > and we end up with bad csum splat. Do we have a recommendation on
> > the correct behavior? If not - should we have a kfunc to adjust /
> > discard csum complete explicitly?  
> 
> At the moment there is no way to store the csum value we got running
> bpf_xdp_metadata_rx_checksum() in order to be consumed during
> xdp_buff/xdp_frame to skb conversion (this info can just be consumed in the
> ebpf program bound to the NIC) but

I think the scope here is much narrower than the xdp_buf to xdp_frame
to skb conversion. We are just pass information between the program and
driver which owns xdp_buff. Very similar to your new xmo.

We could either tell the driver to discard the csum complete or even
add a helper to "adjust" the the csum value. Similar to the helper
we have to adjust the csum in TC / skb context.

> I guess the issue you pointed out can be solved in the verifier
> during program load time. What do you think?

It could, but at the verifier level we'd probably have to be fairly
coarse-grained. Any write to the packet data would mean csum complete
cannot be trusted, that's not too hard. But also any tail call / fentry?
I'm not really up to date on the latest in program chaining in BPF but
I think a lot of real-life deployments would use either chaining or
fentry. So in practice it may be a lot of complexity for having csum
complete always disabled w/ XDP, in practice.

Up to you. I'm totally okay to just say** that drivers should never
report csum complete with XDP (until appropriate API is built).
Perhaps this will force those who care about XDP+csum_complete to
tell us what their requirements are?

[**] "just say" == document and add driver kselftest that validates it
