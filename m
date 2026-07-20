Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EA2C44529
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 19:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FE2C60711;
	Mon, 20 Jul 2026 19:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rci-oGZXTiB8; Mon, 20 Jul 2026 19:33:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B9D3606EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784575983;
	bh=mipM1cLecOb4t56l8llNyfwcJ8p4RmBXYxGw64Z8Tfc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UwY2kT0RtEMQgZGYGfyI7KumN+mAwaK3IKJZNQmEI9pcP1y/rKvzVsWJcUQbtKodZ
	 6c5k4rFwOPlIDl10vP5IidvAxZkyphxTJyCwjO7T6PfkMGC293LT7FacYZOBCuazBE
	 A9HKkULlsiYhs8C5nH04PyFtXidn0LR9xftpUP3Vu3aLdDEyS2ae30a8EPC9bHsboY
	 W5rT1mPA6s1ALiQvbU7smLw4V2To8+i/tYa0uEt/8mnVta0Wt6JXgAKWAcMezoKk6W
	 /RtaDqXlBnOmOSpHLEAD7uIBAC6yMLKO5iyOy5oRWFxR9nP6RVatb6C4uekma152vL
	 zvlgKKFobjAyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B9D3606EF;
	Mon, 20 Jul 2026 19:33:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 67B71DB4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 19:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 595914017B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 19:33:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XSx3WrZ6HRX9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 19:33:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::1;
 helo=mail-pz2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 596D44016F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 596D44016F
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 596D44016F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 19:33:01 +0000 (UTC)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca00ea47337so2890546a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 12:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575980; x=1785180780;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mipM1cLecOb4t56l8llNyfwcJ8p4RmBXYxGw64Z8Tfc=;
 b=G7eM/n+IwuXmiK9ki9DcxZ9QKhwgv3QYrTRCtJtdWUS0JDPZGM+TmM4p9CanIsHtu1
 EXNRbleNsOpqSgYzeUSMAMA+wc1q1ry6oevV+2uF7rVt6nsMeH2pn+XpvdIX3K10KeQD
 VWHnSNWmQzfI+LDGNcJlyxbsg/xG+anHctCzFWTyyV71Wi+27JUSUsT53Ub82PlWWU6g
 gYVC/SRRVqPmvRm2jawiHtZotjC/H7qcO10zjxgtvg9UyK74e4HApXpCESrwdsn/5f1N
 9pPkyIjhCwrZre6qBHR6zCZ8FYelmt7NHY9oANjxLRlFsGwbWms3+ziviaKO02Ee8Hfn
 dOGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpdpZ99GwoWDiMOIJKK2UrKvPirEXGZscpVHHeCdICURzZkgl4ikx1mHy/sTDu3pdNkpinxedfAoaaDCLNLNk=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxmCjJCYm9PIr1vG5x+8tgqqqcwJEzAzS1su6XdfLbFaXfElrCA
 xmcB4tFQrNV1O66du+7gQ/TPopvDQM3ZTcWZqOFyXG89/7paB3irTUPo
X-Gm-Gg: AfdE7cmqT2vy8unq3Q0mLVP5Z8+0wTY+J3eYKUo0Fv6R+ITdv0NmAljs+SsNnx27byn
 yDyWIRDUxXrEBmKqpNEx6hz5LBpAYOqnEAbqO+5zIaKC4PDtCe4Rt9Pf6FlVi5K2+WFrhMM1n9Z
 EcCeaQkyFuye345nJhJ6anH/16xZv8vdLGRIQuly0hCI9DC0ZJDjau2JPug9CmDXPQyFFjRMFJ4
 xCdvxaEb7NlWZpFVnS/KaSayfa8rtDi1mbIM6Zj9tdrQ71xwyBNPP5woY3j4ixEq6LZbh0XKdNQ
 nPPJAYcAN9zRrViWjIbdDpUPEHGckuuR3vXxlG/wml02pN//0wiCZ2dH0hx68gGqRhXQk9YoDGL
 P/XOxO+ih8ylNq/W4A8VtwCkXhf5gNXAaKr1gwElRQJcBtYj2YU9/cfTeNVdZAXKLoBC9JQ==
X-Received: by 2002:a05:6a00:80a:b0:847:97a4:d6b3 with SMTP id
 d2e1a72fcca58-84c2922630cmr15623327b3a.16.1784575980551; 
 Mon, 20 Jul 2026 12:33:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2f1601d6sm5999817b3a.50.2026.07.20.12.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:33:00 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:32:55 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alkBnI3XcH0XGjEo@lore-desk>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784575980; x=1785180780; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mipM1cLecOb4t56l8llNyfwcJ8p4RmBXYxGw64Z8Tfc=;
 b=WAvPno7oo9E/5i0hieqUbEv9OH8o38N2o6/ewcEtRCCPl0biBPBRuqlYYsUV1a3t9+
 vwPXuKoF2vhAWItJH44A19bSvR9Pl4qTvD4SOafo712RSH4vO1EpRsxxElCAVn//L4a1
 PrUyXMQG55wSDLHijLjkwHo2aeCg/NRcKulURd+2tyxUgf2Aopr7UbvnswWZlLvxkSCK
 VbRjYUiE2ciOH4rB9xSHXLm6uNeabOQnQVZlBvOXWyy+52lJfpyTDfmv+Y8SKN6WdNC9
 q976ACuHWUvM8aAnvyalR9LP3SEG0uz7x95cg4Lnsa4HFQR+yGP4NVTZonRbfKcqoqsU
 nyjg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WAvPno7o
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v5 8/8] selftests: net: add
 test for XDP_PASS skb checksum invalidation
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

On 07/16, Lorenzo Bianconi wrote:
> On Jul 16, Stanislav Fomichev wrote:
> > On 07/15, Lorenzo Bianconi wrote:
> > > Add a test that verifies skb->ip_summed is set to CHECKSUM_NONE
> > > when a device running in XDP mode creates an skb from a xdp_buff
> > > if the attached ebpf program returns an XDP_PASS.
> > > The test attaches an XDP program returning XDP_PASS, and a TC
> > > ingress program that runs the bpf_skb_rx_checksum() kfunc to
> > > inspect the resulting skb. After XDP_PASS the driver must invalidate
> > > any previously computed hardware RX checksum since XDP may have
> > > modified the packet data.
> > > The BPF program counts packets per checksum type in a map, and the
> > > test runner verifies that after sending traffic the CHECKSUM_NONE
> > > counter is non-zero while CHECKSUM_UNNECESSARY and CHECKSUM_COMPLETE
> > > counters are zero.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  Documentation/networking/xdp-rx-metadata.rst       |  5 ++
> > >  .../selftests/drivers/net/hw/xdp_metadata.py       | 55 +++++++++++++++-
> > >  .../selftests/net/lib/skb_metadata_csum.bpf.c      | 73 ++++++++++++++++++++++
> > >  3 files changed, 132 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > index 93918b3769a3..7434ac98242a 100644
> > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > @@ -90,6 +90,11 @@ conversion, and the XDP metadata is not used by the kernel when building
> > >  ``skbs``. However, TC-BPF programs can access the XDP metadata area using
> > >  the ``data_meta`` pointer.
> > 
> > [..]
> > 
> > > +If a driver is running in XDP mode, any existing hardware RX checksum
> > > +(``CHECKSUM_UNNECESSARY`` or ``CHECKSUM_COMPLETE``) must be invalidated
> > > +by setting ``skb->ip_summed`` to ``CHECKSUM_NONE`` before passing the
> > > +skb to the kernel, since XDP may have modified the packet data.
> > > +
> > >  In the future, we'd like to support a case where an XDP program
> > >  can override some of the metadata used for building ``skbs``.
> > 
> > Sorry for keeping nitpicking on this, but I'm still not convinced that
> > it is what we currently do. From my previous reply:
> 
> no worries :)
> My current take-away from the previous discussion is we just need to document
> what would be the driver expected behaviour adding a kselftest for it (without
> modifying any driver).
> 
> > 
> > > > Looking at a few drivers:
> > > > - bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
> > > > - mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if there is
> > > >   bpf prog attached
> > > > - fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
> > > > - gve (gve_rx) - can do COMPLETE even with xdp attached?
> > 
> > (although for gve I might be wrong, there is also gve_rx_skb_csum that only
> > does UNNECESSARY).
> > 
> > I'd wait for Jakub to chime in, but it feels like we should just document
> > what we currently do as a recommended approach: for the drivers
> > that support COMPLETE, do not report it when the bpf program is attached.
> > Both NONE and UNNECESSARY are ok.
> 
> I am not completely sure the UNNECESSARY case is different from the COMPLETE
> one. What are we supposed to do if the driver reports UNNECESSARY and the ebpf
> program modifies some fields covered by the rx-checksum?

For unnecessary, I think the safe expectation is that the bpf program
will update the value of the checksum in the packet if it touches the data?

> > Also, did you run this test on real HW? NIPA now has HW tests, maybe it
> > makes sense to route this series via net-next to get the real coverage?
> 
> What about splitting this series and have two different series:
> - bpf-next: add xdp rx kfunc and related selftest
> - net-next: add kselftest for the driver expected behaviour.
> 
> What do you think?

I'd post everything to net-next to get the HW coverage. Once you get all
the acks we can ask the maintainers' guidance.
