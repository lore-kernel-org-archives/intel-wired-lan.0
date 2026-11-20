Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8665606A333
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9C8dGjtk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m9zaobVQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A44C680F4D;
	Fri, 20 Nov 2026 17:23:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWM9BOkfYTDt; Fri, 20 Nov 2026 17:23:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 32DAD80F4E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795195395;
	b=Qq/m8MHNHXlF5pPe4Ijk23pb/P530AWDRm+CVKnYgwrOS9RfXz13BiI2fT2bTliiUiex
	 eqH1dBd0mUYlxubjIQr/raTZtfw0V4GaxEF6bFPyB5ymIZsqsr/cEQkAFf2rmtfhcR/kF
	 /C+7XtxRnj8S9jAOFEKdKkdUXyxRxasbX96qlUYjliJCucCnrYQwy+BcCV8XHQxNkYY59
	 /M/07Npu9yEyPSi+xeOHP7dsE0e+TLe5o2VX3RCJErMMsQ4WoL3unag0dyAiBxSmSyA39
	 onkso0oO3LfJpRm+7IGxbE9E8jrFcQoAZwbHuwjk+E+lCHEl5nnc5C+60+PxdkU7rEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795195395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=REo0movs5zwF5c63UBfjGgfkR9sqFGdc7+LFOWOZksQ=;
	b=cYQPp+0XHipl6ULUzYbOlayKKpFILqKElMoHIfWKI4HTWcUZwu4PdFH9kZqZZgDCGbSk
	 uXBHu4oeHf+jraXIbsLRnYHibJh2gLvXG33Er16Dlgb8kB8ZeJGwVZCHZ+1Swjjpoxh2f
	 uHD5L0R1tQOmWAySZ5dZBFAzmoITRc6qUzRpViaJ6wpqyuz+RWvTDc5Z/88Xi4F9ARHW+
	 urHnPI94aJeHGlFTkHWNdXdScJvXnKbcmr1tEtiNaRaB/joqaA5/3/Z0PKE7vXQjD2TFS
	 AG+Rlx/2GKdPMQV98oFpu4WLBokfunJtBrj7cAZev/NSKyBVtAQri96yUrEW9evSkxw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795195395;
	bh=REo0movs5zwF5c63UBfjGgfkR9sqFGdc7+LFOWOZksQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9C8dGjtkF65FM4bcqf9pIOIdRorB9x/t210xIufNMHoB531vKNIU7mtqQBAsYpt3A
	 Nm7qvPZRmBNA/f/qnxegSCsIclm4OWBrj/M6Gsmz8ATOCFCAKw9nNdS1R+nlOuf5zl
	 3H7pUVtTkbBtEaEjDCaI81VnF5nkRiTQ/LAPFqJJSXfXW0maiNS75PlatbNdtICTrh
	 yUIEzXhgOwnHgsxLkLjJkIdglGCU4Snp2n7dwhN8Nor4ExBwT4qy33pU+3yWY8oUpP
	 wHdotM8dZBavPZ3iWLz2VPAJkc96fdP42A3CLx8jcseq0KpQqJvyF7XOYlhHnNXZwt
	 Ig/jwoR4wIlCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32DAD80F4E;
	Fri, 20 Nov 2026 17:23:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FBCDE22
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 17:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54FBF6069A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 17:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FlqBtmATRPS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 17:23:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C24406063A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:3a::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:3a::9;
 helo=mail-vs2-x09.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=m9zaobVQ
Received: from mail-vs2-x09.google.com (mail-vs2-x09.google.com
 [IPv6:2a00:1450:4864:3a::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C24406063A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 17:23:11 +0000 (UTC)
Received: by mail-vs2-x09.google.com with SMTP id
 ada2fe7eead31-7d2ca8708acso191566137.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 09:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795195391; x=1795800191; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=REo0movs5zwF5c63UBfjGgfkR9sqFGdc7+LFOWOZksQ=;
 b=m9zaobVQgWdap1nnJ3YiF6p+eal1jITdz/ebks3R0xIU+aZLYz2ZDq4MvWPtUx6e0I
 hUwq0dS8zj0zm0cBBNIXYwSKUr/Y7lyAOpFtleV2NuGx8Lzx+wLKO/MmoeIYvuM0Y9/H
 57Hw5Fj7++sFZD2DsSOzkGkjDRGfrd8pDufHEKiBDihDTb6NPOS40OVEPfqpChGj6DJ6
 3InQe7t4EwrIgCkuaWzLzh7PzlEV9tdmTr5Qfb5yD2M4MN7DUYbG6U5W38W7tcm1ScJK
 G3kymX6XE3jUEN/UbJnkP8uAdDHMMkZ8YxYpeAyLY3rNirrbGsBhQlvuutrnehkEaCdr
 Lb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195391; x=1795800191;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=REo0movs5zwF5c63UBfjGgfkR9sqFGdc7+LFOWOZksQ=;
 b=OiLv0/DTPZr9vyL/ir0YERlCbEGkj/RRFwAB/ivT3z7dO43CoW0BDOl0V0LDn75cLu
 /cZfFDJjrppbgPH6gpy7sqEkHP3aV5LMbGA/+F1ZFF0Zag+zpDvFg0QNYtVhQ7pKxhhL
 /mi8yne1T7G9dJTPEM+e+v/8UIvihq4hblH4rkxspBAkgE/6l/TP8qQRHeWwCSnXgb4H
 j2YnI3cm1d2RSq2bWuitesHKQN1F7J+f8yRqZ14iWHbZcw8raz/02NrtJBq4cfpLIDEf
 mdaHQg55nVuvxNT3ge/25p9cgQ8UEzbLHXH4ME3wkNYAgNhpATF3ghJMFj9BuB+eXYpr
 K13g==
X-Forwarded-Encrypted: i=1;
 AL+hErELO8lznkegT52DQMJOlAvVX9+hNQ/TWYCA5FhjzP0PE0ZY7IpVksbiIjI+x9l0Y8KwNvtClK0VxCVvwsWUfhk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9AdEiO4YFPv+5fNHzyHo55AT4v4iJ1U3zVWGAGocWJV1kxfxI5
 r6Nek4MsQfnL/85NG1YR9FohgQOayNeDRh/NriUBacqomuXWC1ljdvYC
X-Gm-Gg: AZFdTZfEO0KrOxxWXKz7X72Jk15BfY2/Qfabl9U8Jay2PIVF5V2yK0vaFx3lJ5886GJ
 EKYBrpLWYIyTKrGX3Pu5g2fpm8sJ8kkptg0RPSGxF4Kxy3cuLfAiNQYI/9wF/BnNEPjkT/j1Gcf
 0cgTO7YWPrTaOpiqDeIy7+41rvV/VkIQRydnbBGan8YOEhevFHscddBJF096AiUb9fIGPEy0m+S
 PdndYdxE/bHSbyIUOrUUbdGu8aHiYHnUSO9BRwWbg517FImIPqRiRzYnhbSsirvy+VQpll6jQKX
 4imG/NGkWcwtqU4ejSzUZ+MEoKPr8uLmDKSEBsCApMQTvYASjJQ5KHPSkon4cIhYd4rrs7YNW+X
 mNL2cKLqH5+lCp/LxMJXQXEVkH3P5aGL6ztUgrceSq7wl2mTbkFGoRBoTGhsnQQSFG1us8PlOrX
 yUJHefQ8BELd5lgGdRBbP9bkAz1I5GcYN/Icq1DjcqpWKsPQoi3Fl2ZYAOLYwJ606ppkoSxBpgB
 UpHihgS+0e3Cd0qqB1vguaadaAHz4RYwQ9qosTdlaIVehrDkxzj1zCuqI6IorbAvRD23jnVlRYP
 gWUokUaUtZXiwHHQRMgo19EfMQK+2SPJcr75UnSkMEfF
X-Received: by 2002:a05:6102:3592:b0:7d6:5e38:3434 with SMTP id
 ada2fe7eead31-7d7396683a5mr1432626137.30.1795195390503; 
 Fri, 20 Nov 2026 09:23:10 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:67::])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d6e822a085sm3462926137.10.2026.11.20.09.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 09:23:10 -0800 (PST)
Date: Fri, 20 Nov 2026 09:22:07 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@gmail.com, 
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, 
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org, 
 kerneljasonxing@gmail.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 1/5] xsk: add USO support for skb path
Message-ID: <awCA3XH25M-fZCeK@devvm16445.scu0.facebook.com>
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-2-magnus.karlsson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119165340.1071525-2-magnus.karlsson@intel.com>
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

On 11/19, Magnus Karlsson wrote:
> Add UDP Segmentation Offload (USO) to the AF_XDP Tx metadata interface
> and implement it for copy mode. An application submits one Ethernet
> frame holding a single IP and UDP header followed by the aggregate UDP
> payload, and the device emits a train of MTU-sized UDP datagrams.
> 
> The uAPI adds the XDP_TXMD_FLAGS_USO flag and splits the reserved u32
> in the request part of struct xsk_tx_metadata into two u16 fields:
> gso_size, the UDP payload bytes per output datagram, and
> network_offset, the IP header offset. USO requires
> XDP_TXMD_FLAGS_CHECKSUM, with csum_start pointing at the UDP header,
> csum_offset at its checksum field and the checksum field seeded with
> the partial pseudoheader checksum of the aggregate packet. It cannot
> be combined with XDP_TXMD_FLAGS_TIMESTAMP or
> XDP_UMEM_TX_SW_CSUM. Launch time is supported and applies to the start
> of the segmented packet.
> 
> The request is turned into a GSO skb of type SKB_GSO_UDP_L4. Before
> transmission, the headers are validated. The link layer is not parsed:
> the IP header starts at network_offset and its version selects
> unfragmented IPv4 or IPv6 without extension headers, followed by UDP.
> The IP and UDP lengths must describe the aggregate packet, every output
> datagram must fit the MTU, and the number of segments is limited to
> UDP_MAX_SEGMENTS. As skb drivers find L3 through the EtherType, the skb
> path also requires the EtherType, after any VLAN tags, to lead to the
> same IP header. A request that fits in one datagram is sent as an
> ordinary checksum offload request.
> 
> network_offset is part of the uAPI because csum_start only locates L4,
> while segmentation also needs the start of L3: the device rewrites the
> IP header of every datagram and needs the L2 and L3 lengths, and on
> the skb path it becomes the network header. With it, the kernel does
> not need to understand the link layer, and the fields can be reused
> later. Any future tunnel segmentation extension to the uAPI could then
> treat network_offset as the outer L3 offset and csum_start as the
> inner L4 offset, adding only the outer L4 and inner L3 offsets.
> 
> AF_XDP never segments these packets itself. A request that produces more
> than one datagram is rejected unless the bound device advertises
> NETIF_F_GSO_UDP_L4, and the GSO skb is passed to its driver unsegmented.
> As with UDP_SEGMENT sockets, how the segmentation is carried out is up
> to the driver. Stacked devices such as VLAN or bonding forward the
> packet to a lower device that may segment it in software.
> 
> A new pool field, tx_uso_supported, records whether USO requests are
> accepted on a pool. It is set only for Ethernet devices (ARPHRD_ETHER)
> and is cleared when XDP_UMEM_TX_SW_CSUM is used.
> 
> A USO request that fails validation is dropped: its buffers are
> completed and counted in tx_invalid_descs. Errors in other Tx metadata
> keep failing sendmsg() and leave the descriptor on the Tx ring, so the
> existing behaviour for non-USO requests is unchanged. A USO request
> that cannot be processed for lack of memory is also left on the Tx
> ring, and sendmsg() fails with -EAGAIN, unless part of it was already
> released to user space, either by an earlier call or while peeking
> further descriptors. That part may already have been reused, so the
> request is then dropped.
> 
> The header validator works on a raw header copy instead of an skb, so
> that the zero-copy path in a later patch can reuse it. It lives in
> the new files net/xdp/xsk_tx_uso.c and include/net/xsk_tx_uso.h.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  Documentation/networking/xsk-tx-metadata.rst |  91 +++++++++++++
>  MAINTAINERS                                  |   1 +
>  include/net/xdp_sock_drv.h                   |  12 ++
>  include/net/xsk_buff_pool.h                  |   4 +
>  include/net/xsk_tx_uso.h                     |  30 +++++
>  include/uapi/linux/if_xdp.h                  |  13 +-
>  net/xdp/Makefile                             |   1 +
>  net/xdp/xsk.c                                | 130 +++++++++++++++++--
>  net/xdp/xsk_buff_pool.c                      |   4 +
>  net/xdp/xsk_queue.h                          |   6 +
>  net/xdp/xsk_tx_uso.c                         |  77 +++++++++++
>  tools/include/uapi/linux/if_xdp.h            |  13 +-
>  12 files changed, 371 insertions(+), 11 deletions(-)
>  create mode 100644 include/net/xsk_tx_uso.h
>  create mode 100644 net/xdp/xsk_tx_uso.c
> 
> diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
> index ac15e5fddc6b..41cfc5482b15 100644
> --- a/Documentation/networking/xsk-tx-metadata.rst
> +++ b/Documentation/networking/xsk-tx-metadata.rst
> @@ -55,6 +55,9 @@ The flags field enables the particular offload:
>    packet for transmission at a pre-determined time called launch time. The
>    value of launch time is indicated by ``request.launch_time`` field of
>    ``struct xsk_tx_metadata``.
> +- ``XDP_TXMD_FLAGS_USO``: requests UDP segmentation offload.
> +  ``request.gso_size`` specifies UDP payload bytes per output datagram;
> +  ``request.network_offset`` identifies the IP header.
>  
>  Besides the flags above, in order to trigger the offloads, the first
>  packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
> @@ -70,6 +73,69 @@ In this case, when running in ``XDP_COPY`` mode, the TX checksum
>  is calculated on the CPU. Do not enable this option in production because
>  it will negatively affect performance.
>  
> +UDP Segmentation
> +================
> +
> +To request UDP segmentation offload (USO), bind the socket in
> +``XDP_COPY`` mode and set ``XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM``
> +in the Tx metadata. Reserve at least 16 bytes of metadata and set
> +``XDP_TX_METADATA`` on the first descriptor of the packet.
> +
> +Submit an Ethernet frame containing one IP header, one UDP header, and the
> +aggregate UDP payload. Set ``request.network_offset`` to the IP header
> +offset, ``request.csum_start`` to the UDP header offset, and
> +``request.csum_offset`` to the UDP checksum field offset (6 bytes).
> +Header offsets are measured from the first descriptor's packet-data address,
> +excluding metadata. Set ``request.gso_size`` to the number of UDP payload
> +bytes per output datagram, excluding headers; the last datagram may be
> +shorter.
> +
> +USO is only available on Ethernet devices. ``request.network_offset``
> +locates the IP header, and its version selects IPv4 or IPv6. In copy mode,
> +the EtherType, after up to six VLAN tags, must lead to the same IP header,
> +since drivers rely on it. IPv4 headers may carry options but must not be
> +fragmented. In IPv6, the UDP header must directly follow the fixed header;
> +extension headers are not supported.
> +
> +The IP and UDP lengths must describe the aggregate packet. Initialize the
> +UDP checksum field with the partial pseudoheader checksum seed for that
> +packet. The device generates the per-datagram lengths and UDP checksums and,
> +for IPv4 segmentation, the IP header checksums. Supply a valid IPv4 header
> +checksum as well, since a request that fits in one datagram uses ordinary
> +checksum offload without segmentation.
> +
> +All headers through UDP must be in the first buffer. Multi-buffer packets
> +use ``XDP_USE_SG`` and ``XDP_PKT_CONTD``, with metadata only on the first
> +descriptor. Each output IP packet must fit the device MTU, and requests
> +remain subject to the device's segmentation limits. Query
> +``tx-udp-segmentation`` through ethtool to check whether skb UDP segmentation
> +offload is enabled.
> +
> +AF_XDP never segments the packet itself. In copy mode, a request that
> +produces more than one datagram is rejected unless the bound device
> +advertises UDP segmentation offload, and the packet is passed to its driver
> +unsegmented. A request that fits in one datagram does not need the offload,
> +so its success does not show that the device supports USO. As with
> +``UDP_SEGMENT`` sockets, how the segmentation is carried out is up to the
> +driver, which may build the per-datagram headers in software. Stacked
> +devices such as VLAN, bonding, or macvlan advertise UDP segmentation
> +regardless of the lower device and forward the packet through the lower
> +device's qdisc, where it is segmented in software if the lower device lacks
> +the offload.
> +
> +A USO request that is rejected is dropped: its buffers are returned
> +through the completion ring and counted in the socket's ``tx_invalid_descs``
> +statistic. This is the only indication of the failure, whatever its cause:
> +invalid metadata or headers, the MTU, segmentation limits, or a device
> +without the offload. A request that cannot be processed for lack of memory
> +is instead left on the Tx ring, and ``sendmsg()`` fails with ``EAGAIN``,
> +unless part of a multi-buffer request was already released to user space;
> +it is then dropped. Errors in other Tx metadata also fail ``sendmsg()`` and
> +leave the descriptor on the Tx ring.
> +
> +USO cannot be combined with ``XDP_UMEM_TX_SW_CSUM`` or
> +``XDP_TXMD_FLAGS_TIMESTAMP``.
> +
>  Launch Time
>  ===========
>  
> @@ -127,6 +193,31 @@ cycle time is set to 1 second, the horizon of the launch time ranges
>  from 1 second to 2 seconds, depending on where the Qbv cycle is currently
>  running.
>  
> +USO with launch time
> +====================
> +
> +Add ``XDP_TXMD_FLAGS_LAUNCH_TIME`` to the USO and checksum flags and set
> +``request.launch_time`` to schedule the segmented packet. This combination
> +requires at least 24 bytes of Tx metadata.
> +
> +The launch time applies to the start of the segmented packet: the first
> +output UDP datagram is scheduled, and subsequent datagrams follow according
> +to the device's scheduling rules. This does not request per-datagram pacing
> +or separate launch times.
> +
> +The skb path passes one unsegmented GSO skb and its launch time directly to
> +the bound device's driver, bypassing that device's qdisc, including ETF.
> +On stacked devices, the lower device's qdisc and software segmentation
> +may still apply, as described above. The driver and selected queue
> +must support UDP segmentation and launch time together. Separate support
> +for either offload does not establish support for their combination.
> +As with ordinary launch-time requests, drivers may ignore the time when
> +scheduling is disabled or unsupported. Acceptance or Tx completion alone
> +does not prove that a packet was transmitted at the requested time.
> +
> +The clock, queue configuration, and scheduling horizon requirements above
> +also apply to USO launch-time requests.
> +
>  Querying Device Capabilities
>  ============================
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40bb77cbc6b0..9b5f6f307d53 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -30588,6 +30588,7 @@ F:	Documentation/networking/af_xdp.rst
>  F:	include/net/netns/xdp.h
>  F:	include/net/xdp_sock*
>  F:	include/net/xsk_buff_pool.h
> +F:	include/net/xsk_tx_uso.h
>  F:	include/uapi/linux/if_xdp.h
>  F:	include/uapi/linux/xdp_diag.h
>  F:	net/xdp/
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index a40ad3f90f13..6b5bb7b29f87 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -263,6 +263,7 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr, u32 options)
>  		XDP_TXMD_FLAGS_TIMESTAMP | \
>  		XDP_TXMD_FLAGS_CHECKSUM | \
>  		XDP_TXMD_FLAGS_LAUNCH_TIME | \
> +		XDP_TXMD_FLAGS_USO | \
>  	0)
>  
>  static inline bool
> @@ -270,6 +271,10 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
>  			   const struct xsk_tx_metadata *meta, u64 *flags)
>  {
>  	*flags = READ_ONCE(meta->flags);
> +	if (*flags & XDP_TXMD_FLAGS_USO)
> +		if (!pool->tx_uso_supported || pool->tx_metadata_len <
> +		    offsetofend(struct xsk_tx_metadata, request.network_offset))
> +			return false;
>  	if (*flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
>  		if (pool->tx_metadata_len <
>  		    offsetofend(struct xsk_tx_metadata, request.launch_time))
> @@ -277,6 +282,13 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
>  	return !(*flags & ~XDP_TXMD_FLAGS_VALID);
>  }
>  
> +/* USO requires checksum offload and cannot report a Tx timestamp. */
> +static inline bool xsk_tx_uso_flags_valid(u64 flags)
> +{
> +	return (flags & XDP_TXMD_FLAGS_CHECKSUM) &&
> +	       !(flags & XDP_TXMD_FLAGS_TIMESTAMP);
> +}
> +
>  /**
>   *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
>   *  and call appropriate xsk_tx_metadata_ops operation.
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 02e89350faf9..ea2ff3680efa 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -89,6 +89,10 @@ struct xsk_buff_pool {
>  	bool uses_need_wakeup;
>  	bool unaligned;
>  	bool tx_sw_csum;
> +	/* USO requests accepted: Ethernet device without SW checksum, and
> +	 * driver support in zero-copy mode. Set when the pool is bound.
> +	 */
> +	bool tx_uso_supported;
>  	void *addrs;
>  	/* Mutual exclusion of the completion ring in the SKB mode.
>  	 * Protect: NAPI TX thread and sendmsg error paths in the SKB
> diff --git a/include/net/xsk_tx_uso.h b/include/net/xsk_tx_uso.h
> new file mode 100644
> index 000000000000..f23384077712
> --- /dev/null
> +++ b/include/net/xsk_tx_uso.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _NET_XSK_TX_USO_H
> +#define _NET_XSK_TX_USO_H
> +
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +#include <net/xsk_buff_pool.h>
> +
> +/* Header offsets are relative to the start of the supplied Ethernet frame. */
> +struct xsk_tx_uso_info {
> +	struct xsk_tx_metadata metadata;
> +	u32 len;
> +	u16 header_len;
> +	u16 gso_segs;
> +	__be16 protocol;
> +	u8 l4_protocol;
> +};
> +
> +#ifdef CONFIG_XDP_SOCKETS
> +int xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso,
> +			u32 mtu);
> +#else
> +static inline int
> +xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso, u32 mtu)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
> +#endif
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 50d67df78911..0f7ba4859218 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -134,6 +134,12 @@ struct xdp_options {
>   */
>  #define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
>  
> +/* Request UDP segmentation offload in XDP_COPY mode. Requires CHECKSUM.
> + * Segment size and IP header offset are in request.
> + * With LAUNCH_TIME, scheduling applies to the start of the segmented packet.
> + */
> +#define XDP_TXMD_FLAGS_USO			(1 << 3)
> +
>  /* AF_XDP offloads request. 'request' union member is consumed by the driver
>   * when the packet is being transmitted. 'completion' union member is
>   * filled by the driver when the transmit completion arrives.
> @@ -149,7 +155,12 @@ struct xsk_tx_metadata {
>  			__u16 csum_start;
>  			/* Offset from csum_start where checksum should be stored. */
>  			__u16 csum_offset;
> -			__u32 reserved;
> +
> +			/* XDP_TXMD_FLAGS_USO */
> +			/* UDP payload bytes per output datagram. */
> +			__u16 gso_size;
> +			/* IP header offset from desc->addr. */
> +			__u16 network_offset;

It is only a matter of time now until someone asks for TSO. I remember
there was strong opposition awhile ago, not sure the winds have changed..
So maybe we should at least make it more generic on the UAPI side
to keep the conversion open? Make it xSO, support passing protocol,
support only UDP for now.. And maybe gso_size is something we can
also rename? segment_size?

>  
>  			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
>  			/* Launch time in nanosecond against the PTP HW Clock */
> diff --git a/net/xdp/Makefile b/net/xdp/Makefile
> index 30cdc4315f42..b6109e0e5547 100644
> --- a/net/xdp/Makefile
> +++ b/net/xdp/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_XDP_SOCKETS) += xsk.o xdp_umem.o xsk_queue.o xskmap.o
>  obj-$(CONFIG_XDP_SOCKETS) += xsk_buff_pool.o
> +obj-$(CONFIG_XDP_SOCKETS) += xsk_tx_uso.o
>  obj-$(CONFIG_XDP_SOCKETS_DIAG) += xsk_diag.o
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f22f9a2cdbbe..14be62b8de5f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -11,6 +11,8 @@
>  
>  #define pr_fmt(fmt) "AF_XDP: %s: " fmt, __func__
>  
> +#include <linux/if_arp.h>
> +#include <linux/if_vlan.h>
>  #include <linux/if_xdp.h>
>  #include <linux/init.h>
>  #include <linux/sched/mm.h>
> @@ -22,6 +24,7 @@
>  #include <linux/net.h>
>  #include <linux/netdevice.h>
>  #include <linux/rculist.h>
> +#include <linux/udp.h>
>  #include <linux/uio.h>
>  #include <linux/vmalloc.h>
>  
> @@ -31,6 +34,7 @@
>  #include <net/netdev_lock.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/xdp.h>
> +#include <net/xsk_tx_uso.h>
>  
>  #include "../core/dev.h"
>  
> @@ -986,12 +990,62 @@ static void xsk_drop_skb(struct sk_buff *skb)
>  	xs->skb = NULL;
>  }
>  
> +static int xsk_skb_uso(struct sk_buff *skb)
> +{
> +	struct xsk_tx_uso_info uso = {
> +		.metadata.request = {
> +			.gso_size = skb_shinfo(skb)->gso_size,
> +			.csum_start = skb_transport_offset(skb),
> +			.network_offset = skb_network_offset(skb),
> +		},
> +		.header_len = skb_transport_offset(skb) + sizeof(struct udphdr),
> +		.len = skb->len,
> +	};
> +	int depth, err;
> +
> +	/* Best effort: a bond or team device can change type while the pool
> +	 * is bound, also after this check.
> +	 */
> +	if (READ_ONCE(skb->dev->type) != ARPHRD_ETHER)
> +		return -EINVAL;
> +	if (!pskb_may_pull(skb, uso.header_len))
> +		return -ENOMEM;
> +
> +	err = xsk_tx_uso_validate(skb->data, &uso, READ_ONCE(skb->dev->mtu));
> +	if (err)
> +		return err;
> +
> +	skb_reset_mac_header(skb);
> +	skb->protocol = eth_hdr(skb)->h_proto;
> +	/* skb drivers find L3 through the EtherType and VLAN tags. Parse them
> +	 * from the end of the Ethernet header, not from network_offset.
> +	 */
> +	skb->mac_len = ETH_HLEN;
> +	if (__vlan_get_protocol(skb, skb->protocol, &depth) != uso.protocol ||
> +	    depth != skb_network_offset(skb))
> +		return -EINVAL;
> +	skb_reset_mac_len(skb);
> +	if (uso.gso_segs == 1) {
> +		skb_gso_reset(skb);
> +		return 0;
> +	}
> +
> +	skb_shinfo(skb)->gso_segs = uso.gso_segs;
> +	if (netif_needs_gso(skb, netif_skb_features(skb)))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +/* A failed USO request returns -EOVERFLOW, so that the packet is dropped. Other
> + * metadata errors are returned to user space.
> + */
>  static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  			    struct xdp_desc *desc, struct xsk_buff_pool *pool,
>  			    u32 hr)
>  {
>  	struct xsk_tx_metadata *meta = NULL;
> -	u16 csum_start, csum_offset;
> +	int err = -EINVAL;
>  	u64 flags;
>  
>  	if (unlikely(pool->tx_metadata_len == 0))
> @@ -999,18 +1053,43 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  
>  	meta = buffer - pool->tx_metadata_len;
>  	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
> -		return -EINVAL;
> +		goto err;
> +
> +	if (flags & XDP_TXMD_FLAGS_USO) {
> +		u16 nhoff = READ_ONCE(meta->request.network_offset);
> +		u16 offset = READ_ONCE(meta->request.csum_offset);
> +		u16 thoff = READ_ONCE(meta->request.csum_start);
> +		u16 size = READ_ONCE(meta->request.gso_size);
> +
> +		if (!xsk_tx_uso_flags_valid(flags))
> +			goto err;
> +		if (!size || size == GSO_BY_FRAGS ||
> +		    nhoff < ETH_HLEN || thoff < nhoff ||
> +		    thoff + sizeof(struct udphdr) > desc->len ||
> +		    offset != offsetof(struct udphdr, check) ||
> +		    hr + thoff >= U16_MAX)
> +			goto err;
> +
> +		skb_set_network_header(skb, nhoff);
> +		skb_set_transport_header(skb, thoff);
> +		skb_shinfo(skb)->gso_size = size;
> +		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> +	}
>  
>  	if (flags & XDP_TXMD_FLAGS_CHECKSUM) {
> -		csum_start = READ_ONCE(meta->request.csum_start);
> -		csum_offset = READ_ONCE(meta->request.csum_offset);
> +		if (flags & XDP_TXMD_FLAGS_USO) {

[..]

> +			skb->csum_start = skb_transport_offset(skb);
> +			skb->csum_offset = offsetof(struct udphdr, check);

Why do we want this? Can we assume the user will do the right thing
if they set XDP_TXMD_FLAGS_CHECKSUM?
