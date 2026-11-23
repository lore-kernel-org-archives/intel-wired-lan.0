Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37816606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=s4roH9JT;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQXr803l
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12D6980DAC;
	Mon, 23 Nov 2026 08:52:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQZ5yGz6vE11; Mon, 23 Nov 2026 08:52:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9E40E80DA9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795423973;
	b=S3trWahwnZQ2LgMA+mO6hcEIUOLgpr2UvjPHcgubg1S81dnLDHhRbhPc/stKgC4mhj/X
	 HkpvOjxFkJgr4wQ/Em2RQPK/QmQmULLZ9w8xzjBCqkoEoYGlfi7S38T4TkaPqBHmqAh4g
	 mj8JY5XSboBzJH8URYCy+o/F+ewOaAPvqIA+ljK+6pgSs24TPldz4LCnDEl4Sw25BN2Qb
	 D+p7uLr6nmJLMc4oi9P5mZUFXMBXK5Wv4ZL+iPAyMqls/VVY9MmUl+gADNqARQhpO5d7T
	 3pDGD4n4P4pBa9kAuDu3Sc7VkTtD7fxaTWnX5DBwRdfj5vgiwjJ1ls5hm+9gC5Lmn0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795423973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cBy8a6PARV8Ud2jYBKY1ifWsHzxGDdjHTpckRaboeTA=;
	b=hJhoN2l7o6UhijVj0H5+6TLejTbzfsYa/j7jBIZVJD+tMkPjkY2zv9Mwu1LQsr3IqS1R
	 nOjUzaZv8L4tECnj7cm4D5gIk9lt6PsYPXCqWwDUJmrMmgmyosS/HOjspg4aumv8uc2rX
	 jk7w/O48PpcK0n0xIC97HRkbxkq0QpKyFA4XeZtCpk5WGX/MMorEg4dchEmWYFu537aMk
	 nnyXFcivQ+cFplOU0x5fvPP2Yu703EGQcspgI08h5lZbUCWCcnjC+NOVKmGdqU/IMkhGh
	 VHfLG4jrhxRNq+aVSfnj0zF4zDbGbtduEcEYoflqp2gr/TxkxGWs5/4GQ9Nc//lL3Ow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795423973;
	bh=cBy8a6PARV8Ud2jYBKY1ifWsHzxGDdjHTpckRaboeTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s4roH9JTeXJ44Dx6wxFcwzPSlKOizmPavQJmQl2J6Z8w5he+iz3ReAPK4OdIaKb3L
	 JPCmK4X/ltzAEj0UKzQPdwW3KeE7qyRSq8y8EULhowR93e4BNhX2p/R13vXl9veOJ0
	 qKpbQP2sNEd1+b3RfPcEWfaHmR6mi9A00QcAh/b9CX57svoDlnPWKm3+sChhmI4w05
	 kdToKJl2LyzyfwyEH2g0NeYOIkegX/ObVLL1+NwSHiHW+78nUNfIQ36swopNE6RVme
	 bT/dc+YFjpp72zOmZKOZSj9gkx6ZOqyc2RpEFFAsZTwr6Plj0+NGGda1xs+7sZDWZI
	 mQEqMDaQRiE/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E40E80DA9;
	Mon, 23 Nov 2026 08:52:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 340D71AB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 08:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19FE840063
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 08:52:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZCfmDPoH4IA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 08:52:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 882274005D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BQXr803l
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 882274005D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 08:52:49 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3b487f44ee0so441778a91.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795423969; x=1796028769; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cBy8a6PARV8Ud2jYBKY1ifWsHzxGDdjHTpckRaboeTA=;
 b=BQXr803ljzhA72I+6ZbwyTxTRRxI/RjqdBV5ANyoy3vQrBgxcTTF1+WpICjvxt+Fbw
 g1PqqzYJLZXb3g0cmbTUAATE4QU4Y56LEG+ufx8OlTrn4DNQBu2mtlJDgwM6dmJivkkz
 Aj68fCnTWBnRpLuG+Wvsa1UUHiQD3HzD0fA0fZ0y/S1Yc1J1Er02ivVtv8OHAn82H749
 hfDkeQ/YJRKDUT9/Y7pudrBSqDyWcW3wscmqTv/HWbRq1vvwcZSPfCbeDCUgFHmIcNl2
 u/Sj1L8G4FciP2TWv06zpaqKKCyKu+sJtlmc0idDD1PhBcQ+tBX1VD7utErUJ4XXcv5d
 7UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795423969; x=1796028769;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cBy8a6PARV8Ud2jYBKY1ifWsHzxGDdjHTpckRaboeTA=;
 b=yOWSBn29/LxCO9n9rEjpfe0qqN2sQnppp+x1t1SdwkDwa7awhDQ9IjR1Vo5yP6ILai
 2NfqQ4+w0ot2OyudiIVGJBqf6dKz4piAtV6p15r7gChOpm63JeHg3bkUEmLbDgLkPpCJ
 RAF7q5u+Yp4I+5+IP8jgUsMW+TKynP5WiScVh8QiCXcMz/GBBAvSn3uVB+kttwlh3v57
 k3giyVF5efd4AD61kdMDvmutHHTH8TZLSY+AUSRFh750Lvl3xxWWVKH2Izt4IRC8y5eq
 xYDuqLeUlNPveMF7/91QC6nEz+DSrV31r1SmCyjuUPUk75oc1tMzOdil5wJOxfSMvIbg
 lRGg==
X-Forwarded-Encrypted: i=1;
 AL+hErEb7eloMeTOa83AfcaF8sO82JNJdmfmRMlYoTqxX8/uOWoKdxYneG68qhSff5JrXHC2qKlzFIi3FPg4IypU4WY=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/oadL2Q+R/j9GM+s5i+qPXJLhlLKFc3v2k+um1NFlYIsZuVjAq
 InuUXzVhrbQo0GXAlt55dbIDDkbQycf/NFxUwugCQ+f62HzMLWD+aBtEElpVTwWnLDTS6Hfj9t5
 OdwU8DjgmEdqCrgRzdXYKllgGx9WeCko=
X-Gm-Gg: AZFdTZdAEMkUP+/BYXtSzumgYY3qeqduxYjDkYdwMXVJH+o6h/1pA8n56rtZSmH0MAa
 kezGA8MF82XORHD+7lAjdioThM5gktimEkACz0fdw9B6LO3q+vK7hf8N8ofcSmg+mvwqhP0pQ88
 VUnRPuRbZu1qSSUyshFm20gAOJgK0arbGuWu/l3zVzgQVRWs9h7TCYYGlNhC8BUC61vFfWDwuwg
 49ZPwJAWl2Z4s7+ARyTCRZLwn2UGd4LuotGP2LLAPev3s3vQWiimlhsexupTMu27u9NKQ50yjAR
 W+S3GHQKo/cPQ4Dtz9Oi7aWBhjmGEuNh7qIJ/uogpXWJs8MwaerDn+QGabIlmH7kwUphmsirL8m
 ubZN2pOzSqQNdPUi5eAVvQTGgpxWJVQnpnpheBGM=
X-Received: by 2002:a17:90b:3d90:b0:3ab:b39f:41b9 with SMTP id
 98e67ed59e1d1-3b41cb42c13mr8755285a91.61.1795423968911; Mon, 23 Nov 2026
 00:52:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-2-magnus.karlsson@intel.com>
 <awCA3XH25M-fZCeK@devvm16445.scu0.facebook.com>
In-Reply-To: <awCA3XH25M-fZCeK@devvm16445.scu0.facebook.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 23 Nov 2026 09:52:36 +0100
X-Gm-Features: Aa3M54oxgzrGjZaIQauDL0BEe3Y2-VsYMMfEBMJ5bsZqtoaJcjSDlqukraajdPI
Message-ID: <CAJ8uoz3xRjbPOHYYs=NZ5QucS6Di+USR_TxLES8qwMxfa4y=TQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] xsk: add USO support for skb path
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org, 
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
 bjorn@kernel.org, kerneljasonxing@gmail.com, intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 18:23, Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
>
> On 11/19, Magnus Karlsson wrote:
> > Add UDP Segmentation Offload (USO) to the AF_XDP Tx metadata interface
> > and implement it for copy mode. An application submits one Ethernet
> > frame holding a single IP and UDP header followed by the aggregate UDP
> > payload, and the device emits a train of MTU-sized UDP datagrams.
> >
> > The uAPI adds the XDP_TXMD_FLAGS_USO flag and splits the reserved u32
> > in the request part of struct xsk_tx_metadata into two u16 fields:
> > gso_size, the UDP payload bytes per output datagram, and
> > network_offset, the IP header offset. USO requires
> > XDP_TXMD_FLAGS_CHECKSUM, with csum_start pointing at the UDP header,
> > csum_offset at its checksum field and the checksum field seeded with
> > the partial pseudoheader checksum of the aggregate packet. It cannot
> > be combined with XDP_TXMD_FLAGS_TIMESTAMP or
> > XDP_UMEM_TX_SW_CSUM. Launch time is supported and applies to the start
> > of the segmented packet.
> >
> > The request is turned into a GSO skb of type SKB_GSO_UDP_L4. Before
> > transmission, the headers are validated. The link layer is not parsed:
> > the IP header starts at network_offset and its version selects
> > unfragmented IPv4 or IPv6 without extension headers, followed by UDP.
> > The IP and UDP lengths must describe the aggregate packet, every output
> > datagram must fit the MTU, and the number of segments is limited to
> > UDP_MAX_SEGMENTS. As skb drivers find L3 through the EtherType, the skb
> > path also requires the EtherType, after any VLAN tags, to lead to the
> > same IP header. A request that fits in one datagram is sent as an
> > ordinary checksum offload request.
> >
> > network_offset is part of the uAPI because csum_start only locates L4,
> > while segmentation also needs the start of L3: the device rewrites the
> > IP header of every datagram and needs the L2 and L3 lengths, and on
> > the skb path it becomes the network header. With it, the kernel does
> > not need to understand the link layer, and the fields can be reused
> > later. Any future tunnel segmentation extension to the uAPI could then
> > treat network_offset as the outer L3 offset and csum_start as the
> > inner L4 offset, adding only the outer L4 and inner L3 offsets.
> >
> > AF_XDP never segments these packets itself. A request that produces more
> > than one datagram is rejected unless the bound device advertises
> > NETIF_F_GSO_UDP_L4, and the GSO skb is passed to its driver unsegmented.
> > As with UDP_SEGMENT sockets, how the segmentation is carried out is up
> > to the driver. Stacked devices such as VLAN or bonding forward the
> > packet to a lower device that may segment it in software.
> >
> > A new pool field, tx_uso_supported, records whether USO requests are
> > accepted on a pool. It is set only for Ethernet devices (ARPHRD_ETHER)
> > and is cleared when XDP_UMEM_TX_SW_CSUM is used.
> >
> > A USO request that fails validation is dropped: its buffers are
> > completed and counted in tx_invalid_descs. Errors in other Tx metadata
> > keep failing sendmsg() and leave the descriptor on the Tx ring, so the
> > existing behaviour for non-USO requests is unchanged. A USO request
> > that cannot be processed for lack of memory is also left on the Tx
> > ring, and sendmsg() fails with -EAGAIN, unless part of it was already
> > released to user space, either by an earlier call or while peeking
> > further descriptors. That part may already have been reused, so the
> > request is then dropped.
> >
> > The header validator works on a raw header copy instead of an skb, so
> > that the zero-copy path in a later patch can reuse it. It lives in
> > the new files net/xdp/xsk_tx_uso.c and include/net/xsk_tx_uso.h.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  Documentation/networking/xsk-tx-metadata.rst |  91 +++++++++++++
> >  MAINTAINERS                                  |   1 +
> >  include/net/xdp_sock_drv.h                   |  12 ++
> >  include/net/xsk_buff_pool.h                  |   4 +
> >  include/net/xsk_tx_uso.h                     |  30 +++++
> >  include/uapi/linux/if_xdp.h                  |  13 +-
> >  net/xdp/Makefile                             |   1 +
> >  net/xdp/xsk.c                                | 130 +++++++++++++++++--
> >  net/xdp/xsk_buff_pool.c                      |   4 +
> >  net/xdp/xsk_queue.h                          |   6 +
> >  net/xdp/xsk_tx_uso.c                         |  77 +++++++++++
> >  tools/include/uapi/linux/if_xdp.h            |  13 +-
> >  12 files changed, 371 insertions(+), 11 deletions(-)
> >  create mode 100644 include/net/xsk_tx_uso.h
> >  create mode 100644 net/xdp/xsk_tx_uso.c
> >
> > diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
> > index ac15e5fddc6b..41cfc5482b15 100644
> > --- a/Documentation/networking/xsk-tx-metadata.rst
> > +++ b/Documentation/networking/xsk-tx-metadata.rst
> > @@ -55,6 +55,9 @@ The flags field enables the particular offload:
> >    packet for transmission at a pre-determined time called launch time. The
> >    value of launch time is indicated by ``request.launch_time`` field of
> >    ``struct xsk_tx_metadata``.
> > +- ``XDP_TXMD_FLAGS_USO``: requests UDP segmentation offload.
> > +  ``request.gso_size`` specifies UDP payload bytes per output datagram;
> > +  ``request.network_offset`` identifies the IP header.
> >
> >  Besides the flags above, in order to trigger the offloads, the first
> >  packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
> > @@ -70,6 +73,69 @@ In this case, when running in ``XDP_COPY`` mode, the TX checksum
> >  is calculated on the CPU. Do not enable this option in production because
> >  it will negatively affect performance.
> >
> > +UDP Segmentation
> > +================
> > +
> > +To request UDP segmentation offload (USO), bind the socket in
> > +``XDP_COPY`` mode and set ``XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM``
> > +in the Tx metadata. Reserve at least 16 bytes of metadata and set
> > +``XDP_TX_METADATA`` on the first descriptor of the packet.
> > +
> > +Submit an Ethernet frame containing one IP header, one UDP header, and the
> > +aggregate UDP payload. Set ``request.network_offset`` to the IP header
> > +offset, ``request.csum_start`` to the UDP header offset, and
> > +``request.csum_offset`` to the UDP checksum field offset (6 bytes).
> > +Header offsets are measured from the first descriptor's packet-data address,
> > +excluding metadata. Set ``request.gso_size`` to the number of UDP payload
> > +bytes per output datagram, excluding headers; the last datagram may be
> > +shorter.
> > +
> > +USO is only available on Ethernet devices. ``request.network_offset``
> > +locates the IP header, and its version selects IPv4 or IPv6. In copy mode,
> > +the EtherType, after up to six VLAN tags, must lead to the same IP header,
> > +since drivers rely on it. IPv4 headers may carry options but must not be
> > +fragmented. In IPv6, the UDP header must directly follow the fixed header;
> > +extension headers are not supported.
> > +
> > +The IP and UDP lengths must describe the aggregate packet. Initialize the
> > +UDP checksum field with the partial pseudoheader checksum seed for that
> > +packet. The device generates the per-datagram lengths and UDP checksums and,
> > +for IPv4 segmentation, the IP header checksums. Supply a valid IPv4 header
> > +checksum as well, since a request that fits in one datagram uses ordinary
> > +checksum offload without segmentation.
> > +
> > +All headers through UDP must be in the first buffer. Multi-buffer packets
> > +use ``XDP_USE_SG`` and ``XDP_PKT_CONTD``, with metadata only on the first
> > +descriptor. Each output IP packet must fit the device MTU, and requests
> > +remain subject to the device's segmentation limits. Query
> > +``tx-udp-segmentation`` through ethtool to check whether skb UDP segmentation
> > +offload is enabled.
> > +
> > +AF_XDP never segments the packet itself. In copy mode, a request that
> > +produces more than one datagram is rejected unless the bound device
> > +advertises UDP segmentation offload, and the packet is passed to its driver
> > +unsegmented. A request that fits in one datagram does not need the offload,
> > +so its success does not show that the device supports USO. As with
> > +``UDP_SEGMENT`` sockets, how the segmentation is carried out is up to the
> > +driver, which may build the per-datagram headers in software. Stacked
> > +devices such as VLAN, bonding, or macvlan advertise UDP segmentation
> > +regardless of the lower device and forward the packet through the lower
> > +device's qdisc, where it is segmented in software if the lower device lacks
> > +the offload.
> > +
> > +A USO request that is rejected is dropped: its buffers are returned
> > +through the completion ring and counted in the socket's ``tx_invalid_descs``
> > +statistic. This is the only indication of the failure, whatever its cause:
> > +invalid metadata or headers, the MTU, segmentation limits, or a device
> > +without the offload. A request that cannot be processed for lack of memory
> > +is instead left on the Tx ring, and ``sendmsg()`` fails with ``EAGAIN``,
> > +unless part of a multi-buffer request was already released to user space;
> > +it is then dropped. Errors in other Tx metadata also fail ``sendmsg()`` and
> > +leave the descriptor on the Tx ring.
> > +
> > +USO cannot be combined with ``XDP_UMEM_TX_SW_CSUM`` or
> > +``XDP_TXMD_FLAGS_TIMESTAMP``.
> > +
> >  Launch Time
> >  ===========
> >
> > @@ -127,6 +193,31 @@ cycle time is set to 1 second, the horizon of the launch time ranges
> >  from 1 second to 2 seconds, depending on where the Qbv cycle is currently
> >  running.
> >
> > +USO with launch time
> > +====================
> > +
> > +Add ``XDP_TXMD_FLAGS_LAUNCH_TIME`` to the USO and checksum flags and set
> > +``request.launch_time`` to schedule the segmented packet. This combination
> > +requires at least 24 bytes of Tx metadata.
> > +
> > +The launch time applies to the start of the segmented packet: the first
> > +output UDP datagram is scheduled, and subsequent datagrams follow according
> > +to the device's scheduling rules. This does not request per-datagram pacing
> > +or separate launch times.
> > +
> > +The skb path passes one unsegmented GSO skb and its launch time directly to
> > +the bound device's driver, bypassing that device's qdisc, including ETF.
> > +On stacked devices, the lower device's qdisc and software segmentation
> > +may still apply, as described above. The driver and selected queue
> > +must support UDP segmentation and launch time together. Separate support
> > +for either offload does not establish support for their combination.
> > +As with ordinary launch-time requests, drivers may ignore the time when
> > +scheduling is disabled or unsupported. Acceptance or Tx completion alone
> > +does not prove that a packet was transmitted at the requested time.
> > +
> > +The clock, queue configuration, and scheduling horizon requirements above
> > +also apply to USO launch-time requests.
> > +
> >  Querying Device Capabilities
> >  ============================
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 40bb77cbc6b0..9b5f6f307d53 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -30588,6 +30588,7 @@ F:    Documentation/networking/af_xdp.rst
> >  F:   include/net/netns/xdp.h
> >  F:   include/net/xdp_sock*
> >  F:   include/net/xsk_buff_pool.h
> > +F:   include/net/xsk_tx_uso.h
> >  F:   include/uapi/linux/if_xdp.h
> >  F:   include/uapi/linux/xdp_diag.h
> >  F:   net/xdp/
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index a40ad3f90f13..6b5bb7b29f87 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -263,6 +263,7 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr, u32 options)
> >               XDP_TXMD_FLAGS_TIMESTAMP | \
> >               XDP_TXMD_FLAGS_CHECKSUM | \
> >               XDP_TXMD_FLAGS_LAUNCH_TIME | \
> > +             XDP_TXMD_FLAGS_USO | \
> >       0)
> >
> >  static inline bool
> > @@ -270,6 +271,10 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
> >                          const struct xsk_tx_metadata *meta, u64 *flags)
> >  {
> >       *flags = READ_ONCE(meta->flags);
> > +     if (*flags & XDP_TXMD_FLAGS_USO)
> > +             if (!pool->tx_uso_supported || pool->tx_metadata_len <
> > +                 offsetofend(struct xsk_tx_metadata, request.network_offset))
> > +                     return false;
> >       if (*flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> >               if (pool->tx_metadata_len <
> >                   offsetofend(struct xsk_tx_metadata, request.launch_time))
> > @@ -277,6 +282,13 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
> >       return !(*flags & ~XDP_TXMD_FLAGS_VALID);
> >  }
> >
> > +/* USO requires checksum offload and cannot report a Tx timestamp. */
> > +static inline bool xsk_tx_uso_flags_valid(u64 flags)
> > +{
> > +     return (flags & XDP_TXMD_FLAGS_CHECKSUM) &&
> > +            !(flags & XDP_TXMD_FLAGS_TIMESTAMP);
> > +}
> > +
> >  /**
> >   *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
> >   *  and call appropriate xsk_tx_metadata_ops operation.
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index 02e89350faf9..ea2ff3680efa 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -89,6 +89,10 @@ struct xsk_buff_pool {
> >       bool uses_need_wakeup;
> >       bool unaligned;
> >       bool tx_sw_csum;
> > +     /* USO requests accepted: Ethernet device without SW checksum, and
> > +      * driver support in zero-copy mode. Set when the pool is bound.
> > +      */
> > +     bool tx_uso_supported;
> >       void *addrs;
> >       /* Mutual exclusion of the completion ring in the SKB mode.
> >        * Protect: NAPI TX thread and sendmsg error paths in the SKB
> > diff --git a/include/net/xsk_tx_uso.h b/include/net/xsk_tx_uso.h
> > new file mode 100644
> > index 000000000000..f23384077712
> > --- /dev/null
> > +++ b/include/net/xsk_tx_uso.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _NET_XSK_TX_USO_H
> > +#define _NET_XSK_TX_USO_H
> > +
> > +#include <linux/errno.h>
> > +#include <linux/types.h>
> > +#include <net/xsk_buff_pool.h>
> > +
> > +/* Header offsets are relative to the start of the supplied Ethernet frame. */
> > +struct xsk_tx_uso_info {
> > +     struct xsk_tx_metadata metadata;
> > +     u32 len;
> > +     u16 header_len;
> > +     u16 gso_segs;
> > +     __be16 protocol;
> > +     u8 l4_protocol;
> > +};
> > +
> > +#ifdef CONFIG_XDP_SOCKETS
> > +int xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso,
> > +                     u32 mtu);
> > +#else
> > +static inline int
> > +xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso, u32 mtu)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +#endif
> > +
> > +#endif
> > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> > index 50d67df78911..0f7ba4859218 100644
> > --- a/include/uapi/linux/if_xdp.h
> > +++ b/include/uapi/linux/if_xdp.h
> > @@ -134,6 +134,12 @@ struct xdp_options {
> >   */
> >  #define XDP_TXMD_FLAGS_LAUNCH_TIME           (1 << 2)
> >
> > +/* Request UDP segmentation offload in XDP_COPY mode. Requires CHECKSUM.
> > + * Segment size and IP header offset are in request.
> > + * With LAUNCH_TIME, scheduling applies to the start of the segmented packet.
> > + */
> > +#define XDP_TXMD_FLAGS_USO                   (1 << 3)
> > +
> >  /* AF_XDP offloads request. 'request' union member is consumed by the driver
> >   * when the packet is being transmitted. 'completion' union member is
> >   * filled by the driver when the transmit completion arrives.
> > @@ -149,7 +155,12 @@ struct xsk_tx_metadata {
> >                       __u16 csum_start;
> >                       /* Offset from csum_start where checksum should be stored. */
> >                       __u16 csum_offset;
> > -                     __u32 reserved;
> > +
> > +                     /* XDP_TXMD_FLAGS_USO */
> > +                     /* UDP payload bytes per output datagram. */
> > +                     __u16 gso_size;
> > +                     /* IP header offset from desc->addr. */
> > +                     __u16 network_offset;
>
> It is only a matter of time now until someone asks for TSO. I remember
> there was strong opposition awhile ago, not sure the winds have changed..
> So maybe we should at least make it more generic on the UAPI side
> to keep the conversion open? Make it xSO, support passing protocol,
> support only UDP for now.. And maybe gso_size is something we can
> also rename? segment_size?

Good idea. I do not think it will hurt to be future proof in this
case, even if TSO support never materializes.

> >
> >                       /* XDP_TXMD_FLAGS_LAUNCH_TIME */
> >                       /* Launch time in nanosecond against the PTP HW Clock */
> > diff --git a/net/xdp/Makefile b/net/xdp/Makefile
> > index 30cdc4315f42..b6109e0e5547 100644
> > --- a/net/xdp/Makefile
> > +++ b/net/xdp/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-$(CONFIG_XDP_SOCKETS) += xsk.o xdp_umem.o xsk_queue.o xskmap.o
> >  obj-$(CONFIG_XDP_SOCKETS) += xsk_buff_pool.o
> > +obj-$(CONFIG_XDP_SOCKETS) += xsk_tx_uso.o
> >  obj-$(CONFIG_XDP_SOCKETS_DIAG) += xsk_diag.o
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f22f9a2cdbbe..14be62b8de5f 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -11,6 +11,8 @@
> >
> >  #define pr_fmt(fmt) "AF_XDP: %s: " fmt, __func__
> >
> > +#include <linux/if_arp.h>
> > +#include <linux/if_vlan.h>
> >  #include <linux/if_xdp.h>
> >  #include <linux/init.h>
> >  #include <linux/sched/mm.h>
> > @@ -22,6 +24,7 @@
> >  #include <linux/net.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/rculist.h>
> > +#include <linux/udp.h>
> >  #include <linux/uio.h>
> >  #include <linux/vmalloc.h>
> >
> > @@ -31,6 +34,7 @@
> >  #include <net/netdev_lock.h>
> >  #include <net/netdev_rx_queue.h>
> >  #include <net/xdp.h>
> > +#include <net/xsk_tx_uso.h>
> >
> >  #include "../core/dev.h"
> >
> > @@ -986,12 +990,62 @@ static void xsk_drop_skb(struct sk_buff *skb)
> >       xs->skb = NULL;
> >  }
> >
> > +static int xsk_skb_uso(struct sk_buff *skb)
> > +{
> > +     struct xsk_tx_uso_info uso = {
> > +             .metadata.request = {
> > +                     .gso_size = skb_shinfo(skb)->gso_size,
> > +                     .csum_start = skb_transport_offset(skb),
> > +                     .network_offset = skb_network_offset(skb),
> > +             },
> > +             .header_len = skb_transport_offset(skb) + sizeof(struct udphdr),
> > +             .len = skb->len,
> > +     };
> > +     int depth, err;
> > +
> > +     /* Best effort: a bond or team device can change type while the pool
> > +      * is bound, also after this check.
> > +      */
> > +     if (READ_ONCE(skb->dev->type) != ARPHRD_ETHER)
> > +             return -EINVAL;
> > +     if (!pskb_may_pull(skb, uso.header_len))
> > +             return -ENOMEM;
> > +
> > +     err = xsk_tx_uso_validate(skb->data, &uso, READ_ONCE(skb->dev->mtu));
> > +     if (err)
> > +             return err;
> > +
> > +     skb_reset_mac_header(skb);
> > +     skb->protocol = eth_hdr(skb)->h_proto;
> > +     /* skb drivers find L3 through the EtherType and VLAN tags. Parse them
> > +      * from the end of the Ethernet header, not from network_offset.
> > +      */
> > +     skb->mac_len = ETH_HLEN;
> > +     if (__vlan_get_protocol(skb, skb->protocol, &depth) != uso.protocol ||
> > +         depth != skb_network_offset(skb))
> > +             return -EINVAL;
> > +     skb_reset_mac_len(skb);
> > +     if (uso.gso_segs == 1) {
> > +             skb_gso_reset(skb);
> > +             return 0;
> > +     }
> > +
> > +     skb_shinfo(skb)->gso_segs = uso.gso_segs;
> > +     if (netif_needs_gso(skb, netif_skb_features(skb)))
> > +             return -EOPNOTSUPP;
> > +
> > +     return 0;
> > +}
> > +
> > +/* A failed USO request returns -EOVERFLOW, so that the packet is dropped. Other
> > + * metadata errors are returned to user space.
> > + */
> >  static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >                           struct xdp_desc *desc, struct xsk_buff_pool *pool,
> >                           u32 hr)
> >  {
> >       struct xsk_tx_metadata *meta = NULL;
> > -     u16 csum_start, csum_offset;
> > +     int err = -EINVAL;
> >       u64 flags;
> >
> >       if (unlikely(pool->tx_metadata_len == 0))
> > @@ -999,18 +1053,43 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >
> >       meta = buffer - pool->tx_metadata_len;
> >       if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
> > -             return -EINVAL;
> > +             goto err;
> > +
> > +     if (flags & XDP_TXMD_FLAGS_USO) {
> > +             u16 nhoff = READ_ONCE(meta->request.network_offset);
> > +             u16 offset = READ_ONCE(meta->request.csum_offset);
> > +             u16 thoff = READ_ONCE(meta->request.csum_start);
> > +             u16 size = READ_ONCE(meta->request.gso_size);
> > +
> > +             if (!xsk_tx_uso_flags_valid(flags))
> > +                     goto err;
> > +             if (!size || size == GSO_BY_FRAGS ||
> > +                 nhoff < ETH_HLEN || thoff < nhoff ||
> > +                 thoff + sizeof(struct udphdr) > desc->len ||
> > +                 offset != offsetof(struct udphdr, check) ||
> > +                 hr + thoff >= U16_MAX)
> > +                     goto err;
> > +
> > +             skb_set_network_header(skb, nhoff);
> > +             skb_set_transport_header(skb, thoff);
> > +             skb_shinfo(skb)->gso_size = size;
> > +             skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> > +     }
> >
> >       if (flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > -             csum_start = READ_ONCE(meta->request.csum_start);
> > -             csum_offset = READ_ONCE(meta->request.csum_offset);
> > +             if (flags & XDP_TXMD_FLAGS_USO) {
>
> [..]
>
> > +                     skb->csum_start = skb_transport_offset(skb);
> > +                     skb->csum_offset = offsetof(struct udphdr, check);
>
> Why do we want this? Can we assume the user will do the right thing
> if they set XDP_TXMD_FLAGS_CHECKSUM?

This is to avoid reading these variables twice from user-space. They
might have changed in-between by some malicious user. The read from
user-space can be found in the if-statement above this that is only
executed for USO.
