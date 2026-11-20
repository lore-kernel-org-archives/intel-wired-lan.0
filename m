Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB8606A325
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=JyynQNhX;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLC4k6ir
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BD1D40A9F;
	Fri, 20 Nov 2026 08:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GU1DT2LUdT_y; Fri, 20 Nov 2026 08:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 10FE840B1F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795164972;
	b=r4Pdx43h4dK9tuhP2055955tR+vq9oPpYGLoPlUoriNu0A1cm9PrmYRAQQMazSau/SeE
	 2Y67xuBWAvK5VJkCB0bkZYOWAUY+JvexfYxeOkPp1Er2sFqSMfdxMGAW4b9JvHN1YFUcW
	 s6rHFi2wt+/Qhw3fVXG84UCO1FEVMukiiMMNjgatFa/9VK8IdjYu+/fN8Xo/4YDnVqYRK
	 0QCXZrd4dg5b9AmEVceqvYNU+DlcYi6MLqjjIfqmdGxuO2C7g8jjrahEJ97q8mlxIUwkQ
	 fqMYY1B/X0KRa9jZQ0XDtKOvBJu0bQE9Kz8gg07TIb2g3HlYGZ0QyCyCWRg8Y5MZj1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795164972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ea8na+F/KW7YSZM5z0Cu6cydEGAVmFMiRyDQf9OHsVI=;
	b=Q7PPsnntAYGi8QDWFNcEcm/PJ279HJiWbSlkhWYKg7/Q1MHfX98hVRsbFpL+Ye2R6gO0
	 bgc0LuMbLCm23tT8TBy3Q35vDqqODcENpf94JcZhXjh2NzsS17NkrM10AyEdk65SWSrvV
	 iVTPR8Q2YrOmF0um3JFoGuwMK43XC4YSmpeGKcw1k5QiSOMcx0iiGVkVDpglUGiYXqohg
	 xtQSYmVUgpRXoqbjdH/OkkWriGoO0t5aOc3ECmyQTYIq03Ymxftt8OZfgF2kRz49bDU5V
	 AAVQClIscHTwSxWpmg9i+6J30TTB5ZUj2EnbOtFkCr1RmD4iFvcKi0EPeSBdeyb589Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795164972;
	bh=ea8na+F/KW7YSZM5z0Cu6cydEGAVmFMiRyDQf9OHsVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JyynQNhXgfoTMlxVUr+RhfBuasnx/Z4ZlKK+3x4Snb5QzDVoJkV7pn6P2gpqEPQJ0
	 HO+V54sm8yOLk43N8YHOFl+lQJ912WdYmMy3peME+f6CyCjX7qv+0K68/8ruvFg26W
	 4jpY0PfluCsqqdzVnyRukRlAI86fIH2FSNJr7vBFkFyMYqp8G3Ahu982IjX/nSHy4N
	 J8hawI4KucLE7YhEnOgE2Bq25eKsEia4I7rIeAyKRszsiv3yxfBbgAAiy2JK6ZLRSN
	 9B/dsIhVaXZeL7jnApoC+znhjDaGmmaxQqfgS3/GycklUN4dEqOU58GZFdvJmYAad8
	 Vxvr1DUGkbp8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10FE840B1F;
	Fri, 20 Nov 2026 08:56:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EAE3169
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 08:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48FF3815DD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 08:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKwU9x5lVYFv for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 08:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5024881542
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=JLC4k6ir
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5024881542
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 08:56:07 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8b271e573adso321790b3a.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 00:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795164967; x=1795769767; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ea8na+F/KW7YSZM5z0Cu6cydEGAVmFMiRyDQf9OHsVI=;
 b=JLC4k6ir2y8McVrc6ItXFec3wAj8g9z+zloFPvhg9Btiy8KHhswwoJoPzP1mBgygJk
 xkru7ZuDAYKQr7EBm9gYUlo2gT9exfRBvD576SxeV3KHQ7CO7NfGjztSfEmmRShjnwbM
 qcZsPMsmnkbeeC5yaZcwe3noCXv89lyYjwbraWueidsmMHpj4SyUnBXC4SbThboL9Svp
 udWlseJh9YZigSTsdg/b70AY4KBUG2ck1/SfaPUPWm8m9z6J1UevdW0xH1dI+N2I8S+0
 x2G8qsmrWsu8o3aRI4OSf+QfGAa6Oxf1I9saV7u6JpDH26DHn0YHfIkRL0dyUf3UWpGU
 yYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795164967; x=1795769767;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ea8na+F/KW7YSZM5z0Cu6cydEGAVmFMiRyDQf9OHsVI=;
 b=gEx1q7hZp4G9VJaDn6ah/++X/fYkr9mKAXItaAgkuACMyc34C5VL0uXCvNcEZIqSK4
 BaAGOShws8pBGk5uShQRFA5Ag4hGh+uBIKMyBNrP1OYzCUfPH1PKzsHGZ6/nDezgyPkc
 tA2IqOuHo9d7dQ9pkkBUtrHbqPvnTcTPZBkLaeD5RdtJT8kCh2TBAmVCHzTZ+WWKU9Zt
 9KXTA1uNVyTdwxivDszkVFzDy3Yz4MZm4P/OCpcKF9Kl14IROJeFSxj6qFBTjeXhR0ug
 +s2r+EZa8cVRd31qziZ7TTC6LF+EdUrP8WgmbTjdmhFgV4MyoktuFeGOKVyKJJXS6Lmy
 bhhg==
X-Forwarded-Encrypted: i=1;
 AL+hErGoO6bHXDxbxSiYpHJgne9+OMu67AHichjg9UAevJLwUkveTS/ChZ0Vo1RTvjbt4H+yZlWIGqRIsqP9yLZDPlw=@lists.osuosl.org
X-Gm-Message-State: APuU4Z85FiXHZMzkQ2wW8Vt557Sfg5i8RoKc6CzEhpY5bEUix4uI6Di9
 o7KWlpJtrwp/C/eYeNkCaEdmWt5qXflspimiFcn8lyMF2qlNhPduOGWOAl2Kco5voLFDKVfPBhm
 bE3+qqtwIJmv0JW9oSnESxJnsmqfWA0Y=
X-Gm-Gg: AYBFou3tx1EcTdUeMkAX6vvTzkmO22o9glqkPosfiYyRbjtWk/POL8SsU4TFI75TRop
 /QqxT3ase7zwZE74HCy/kA/tSfu/2d9IiYH0+0weI3KjzSff4ShX1+0bVMEJs7/uOXg9EuBZ/Iz
 kmEydfMoZwVaYkdyvPltgJAj86pGHOhzS6aGya3AR/7iIdhUlJZOOZ+iFIbMJtpAuYmkkYGXK4E
 ABlE2O3/ZLJS2TqRCmGNYWD23ed7o4eDheXGvz5Mw7nufrY9fpUHm6GavP7DX+YGYTJCATz9FID
 82RjY893esqM4A7GUBR7tHOGW7zJ73jhlrT95O+0XKAdt2P5dn3MDPfSxKsLCSSd3PsPJ2u38Sy
 AtwjQ4cmy0NRDL6O9RyIRPbx0X9hZcDtpL2gzwdcRWiWJoTLrGQrFMaY06rzf
X-Received: by 2002:a05:6a20:2448:b0:3e1:1eca:2214 with SMTP id
 adf61e73a8af0-4014c257b24mr2798218637.49.1795164966907; Fri, 20 Nov 2026
 00:56:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-2-magnus.karlsson@intel.com> <av9EMbwng6Oc7chm@boxer>
In-Reply-To: <av9EMbwng6Oc7chm@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 20 Nov 2026 09:55:54 +0100
X-Gm-Features: AclHuK8AjGDpNKkntCMBs73h6g6_k2U-zfX-fbz4ziA1mlzcg0oHPhh9jOv7wvo
Message-ID: <CAJ8uoz1yeh1JGHBiE-jfKzzO3e4uKZu=y2qy79KVsSKga0KkgQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] xsk: add USO support for skb path
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org,
 sdf@fomichev.me, 
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
 horms@kernel.org, bjorn@kernel.org, kerneljasonxing@gmail.com, 
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 19:47, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Nov 19, 2026 at 05:53:36PM +0100, Magnus Karlsson wrote:
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
>
> Hmm - this looks good to me!
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
> I only had minor comments/questions.

Thanks for taking a look at this Maciej. Things that I have not
commented on, I will fix. But please read below for some answers to
your questions.

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
> you're doing it like this as you still want to execute
> XDP_TXMD_FLAGS_CHECKSUM which is present for USO, ok.
>
> > +                     skb->csum_start = skb_transport_offset(skb);
> > +                     skb->csum_offset = offsetof(struct udphdr, check);
> > +             } else {
> > +                     skb->csum_start = READ_ONCE(meta->request.csum_start);
> > +                     skb->csum_offset = READ_ONCE(meta->request.csum_offset);
> > +             }
> >
> > -             if (unlikely(csum_start + csum_offset +
> > +             if (unlikely(skb->csum_start + skb->csum_offset +
> >                            sizeof(__sum16) > desc->len))
> > -                     return -EINVAL;
> > +                     goto err;
> >
> > -             skb->csum_start = hr + csum_start;
> > -             skb->csum_offset = csum_offset;
> > +             skb->csum_start += hr;
> >               skb->ip_summed = CHECKSUM_PARTIAL;
> >       }
> >
> > @@ -1021,6 +1100,9 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >       xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> >
> >       return 0;
> > +
> > +err:
> > +     return flags & XDP_TXMD_FLAGS_USO ? -EOVERFLOW : err;
>
> could you stick to explicit returns maybe and be consistent with rest of
> flags?
>
> >  }
> >
> >  static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
> > @@ -1108,6 +1190,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >       return skb;
> >  }
> >
> > +/* On -EOVERFLOW, the packet was dropped and its descriptors were consumed and
> > + * completed as invalid. Other errors leave the descriptor on the Tx ring for
> > + * the application to retry.
> > + */
> >  static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >                                    struct xdp_desc *desc)
> >  {
> > @@ -1196,13 +1282,17 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >       if (skb && !xs->skb)
> >               kfree_skb(skb);
> >
> > +     /* Too many descriptors and invalid USO requests drop the packet. Only
> > +      * the latter can fail on the first descriptor, which is completed
> > +      * here. Other errors are returned so that the application can retry.
> > +      */
> >       if (err == -EOVERFLOW) {
> >               if (xs->skb) {
> >                       /* Drop the packet */
> >                       xsk_inc_num_desc(xs->skb);
> >                       xsk_drop_skb(xs->skb);
> >               } else {
> > -                     xsk_cq_cancel_locked(xs->pool, 1);
> > +                     xsk_cq_submit_addr_single_locked(xs->pool, desc);
> >                       xs->tx->invalid_descs++;
> >               }
> >               xskq_cons_release(xs->tx);
> > @@ -1279,6 +1369,28 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                       continue;
> >               }
> >
> > +             if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > +                     err = xsk_skb_uso(skb);
> > +                     /* Descriptors already released to user space may be
> > +                      * reused, so the packet can only be put back if none
> > +                      * of them has been released. Otherwise it is dropped.
>
> This is the only part i don't follow.

Before we tell user-space to retry a multi-buffer packet by rewinding
the ring, we need to make sure that none of those slots making up the
packet have already been released to user-space. That would break the
ring as one of those released slots might already have been filled in
with new data by user-space.

> > +                      */
> > +                     if (err == -ENOMEM &&
> > +                         xskq_cons_nb_unreleased(xs->tx) >=
> > +                         xsk_get_num_desc(skb)) {
> > +                             /* Tell user-space to retry the send */
> > +                             xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
> > +                             xsk_consume_skb(skb);
> > +                             err = -EAGAIN;
> > +                             goto out;
> > +                     }
> > +                     if (err) {
> > +                             xsk_drop_skb(skb);
> > +                             err = 0;
> > +                             continue;
> > +                     }
> > +             }
> > +
> >               err = xsk_skb_sw_csum(skb, xs->pool);
> >               if (unlikely(err)) {
> >                       xsk_drop_skb(skb);
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 5ec092f7cb6f..e62f3c2b3362 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > +#include <linux/if_arp.h>
> >  #include <linux/netdevice.h>
> >  #include <net/netdev_lock.h>
> >  #include <net/xsk_buff_pool.h>
> > @@ -192,6 +193,8 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >       err = xsk_reg_pool_at_qid(netdev, pool, queue_id);
> >       if (err)
> >               return err;
> > +     pool->tx_uso_supported = !pool->tx_sw_csum &&
> > +                              netdev->type == ARPHRD_ETHER;
> >
> >       if (mbuf)
> >               pool->umem->flags |= XDP_UMEM_SG_FLAG;
> > @@ -260,6 +263,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >               goto err_unreg_xsk;
> >       }
> >       pool->umem->zc = true;
> > +     pool->tx_uso_supported = false;
>
> I assume this will be lifted on later patch

Correct.

> >       pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
> >       return 0;
> >
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index 1bc42c8902f4..182cd1cccb74 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> > @@ -390,6 +390,12 @@ static inline void xskq_cons_release(struct xsk_queue *q)
> >       q->cached_cons++;
> >  }
> >
> > +/* Entries consumed locally but not yet released to the producer. */
> > +static inline u32 xskq_cons_nb_unreleased(struct xsk_queue *q)
> > +{
> > +     return q->cached_cons - q->ring->consumer;
>
> READ_ONCE(q->ring->consumer) ?
>
> > +}
> > +
> >  static inline void xskq_cons_cancel_n(struct xsk_queue *q, u32 cnt)
> >  {
> >       q->cached_cons -= cnt;
> > diff --git a/net/xdp/xsk_tx_uso.c b/net/xdp/xsk_tx_uso.c
> > new file mode 100644
> > index 000000000000..a7313ade1092
> > --- /dev/null
> > +++ b/net/xdp/xsk_tx_uso.c
> > @@ -0,0 +1,77 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <net/ip.h>
> > +#include <net/ipv6.h>
> > +#include <net/udp.h>
> > +#include <net/xsk_tx_uso.h>
> > +
> > +/**
> > + * xsk_tx_uso_validate - validate a kernel-owned plain UDP header
> > + * @header: kernel-owned buffer containing at least uso->header_len bytes
> > + * @uso: packet length and metadata offsets; receives protocol and segment count
> > + * @mtu: maximum output IP packet length
> > + *
> > + * The link-layer header is not parsed. The IP header starts at network_offset
> > + * and its version selects IPv4 or IPv6. The caller must provide a nonzero
> > + * gso_size other than GSO_BY_FRAGS and header_len equal to transport_offset
> > + * plus the UDP header size.
> > + *
> > + * Return: zero on success or a negative error code.
> > + */
> > +int xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso,
> > +                     u32 mtu)
> > +{
> > +     const struct xsk_tx_metadata *meta = &uso->metadata;
> > +     u32 nhoff = meta->request.network_offset;
> > +     u32 thoff = meta->request.csum_start;
> > +     u32 udp_len, payload_len, network_len;
> > +     const struct udphdr *uh;
> > +     __be16 protocol;
> > +
> > +     if (nhoff < ETH_HLEN || thoff <= nhoff || uso->header_len < thoff ||
> > +         uso->len < uso->header_len)
> > +             return -EINVAL;
> > +
> > +     network_len = uso->len - nhoff;
> > +     switch (((const struct iphdr *)(header + nhoff))->version) {
> > +     case 4: {
> > +             const struct iphdr *iph = header + nhoff;
> > +
> > +             if (thoff - nhoff < sizeof(*iph) ||
> > +                 iph->ihl < 5 || iph->ihl * 4 != thoff - nhoff ||
> > +                 ip_is_fragment(iph) ||
> > +                 ntohs(iph->tot_len) != network_len)
>
> question: i keep on seeing this validation of iphdr - don't we have
> somewhere a generic routine for that?

I tried finding one but failed. The receive path validators are all
based on skbs and I do not want to create a fake skb in this path for
the sake of zero-copy mode. I did look at
skb_flow_dissect_flow_keys_basic() that can take a raw buffer as
input. The problem with that one is that it does not validate the
packet header thoroughly so it would not remove much code as I would
have to do that anyway. It would only remove two lines and add ten
more to be exact, so +8 lines and a significant increase in run-time
as I parse it twice. Another problem is that it can run a BPF program,
and this program could state that everything is fine with the header,
even though it is not. I need something predictable that cannot be
modified by user-space.

But if we could find something reusable, that would be preferred of
course. I just could not.

> > +                     return -EINVAL;
> > +             protocol = htons(ETH_P_IP);
> > +             uso->l4_protocol = iph->protocol;
> > +             break;
> > +     }
> > +     case 6: {
> > +             const struct ipv6hdr *ip6h = header + nhoff;
> > +
> > +             if (thoff - nhoff != sizeof(*ip6h) ||
> > +                 ntohs(ip6h->payload_len) != network_len - sizeof(*ip6h))
> > +                     return -EINVAL;
> > +             protocol = htons(ETH_P_IPV6);
> > +             uso->l4_protocol = ip6h->nexthdr;
> > +             break;
> > +     }
> > +     default:
> > +             return -EPROTONOSUPPORT;
> > +     }
> > +     uso->protocol = protocol;
> > +     udp_len = uso->len - thoff;
> > +     uh = header + thoff;
> > +     if (uso->l4_protocol != IPPROTO_UDP || udp_len > U16_MAX ||
> > +         ntohs(uh->len) != udp_len)
> > +             return -EINVAL;
>
> nit: i think you should start with this validation?
>
> > +     payload_len = udp_len - sizeof(*uh);
> > +     if (payload_len > meta->request.gso_size * UDP_MAX_SEGMENTS ||
> > +         uso->header_len - nhoff +
> > +         min_t(u32, payload_len, meta->request.gso_size) > mtu)
> > +             return -EINVAL;
> > +
> > +     uso->gso_segs = max_t(u32, 1, DIV_ROUND_UP(payload_len,
> > +                                                meta->request.gso_size));
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(xsk_tx_uso_validate);
> > diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> > index 50d67df78911..0f7ba4859218 100644
> > --- a/tools/include/uapi/linux/if_xdp.h
> > +++ b/tools/include/uapi/linux/if_xdp.h
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
> >
> >                       /* XDP_TXMD_FLAGS_LAUNCH_TIME */
> >                       /* Launch time in nanosecond against the PTP HW Clock */
> > --
> > 2.38.1
> >
