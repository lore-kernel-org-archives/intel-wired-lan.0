Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA4606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=lADP8kbG;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LEgYocX4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9676D81092;
	Thu, 19 Nov 2026 15:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f151rksoOZ2l; Thu, 19 Nov 2026 15:33:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A8F16810A1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795102424;
	b=ElQK11r4WKeYTz7vPZl9zgquEQpD0E1Z3UXA4JMSM42m0o4AVDsDmZa8tpPdp/4GVvCy
	 fEQ4soWlZiErSusdDSGaKrsIHigDnZjcyL7+kucWIhsRAIQE5AC2BFMKquw9AQJmY/ZpQ
	 M1QlXI963b55dImqfdZJTEZFFkSaGkfrysySwWiY6D4ut9v3c4p7WreyC1fboYdSzt5s5
	 EejnGmsSi2/sVALeqi3DrGdMW7OgYWxYzhORu+0utpIKEaqTr/oqJkfOSlQTEKdDCCYY/
	 ntD4hWCOScUGZLTcEGCIb55BIFwD2IoulcDaF5f/ZiEFq05fOyfiK6kFgIT/jktaXvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795102424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i/4VGZklI1mht3vU+GfYHjWfZdT4QdFVah9IYtlFYqU=;
	b=BI7Wy20NxOvDD3ODnYAagdj4Bii6DS6VhauvrLqctgnwStivz+bEC0eIS3T2sbSGPKX4
	 X4v2wrw5wyYFrwdk+m6ci3H/TyZ9kltL6LIOOMDdGUpwP4RXUa6IBix7laT5McrLZWJZ6
	 JjVOBU/dctRjTwooS7roMJXAj7mcH3isAKVwH+KFn88YsduFIWreFbxJsYfW+183FqF62
	 AGjUgZdAtJyM1LEg8/KBiAWPFRAAwlz6YOlRADNHsSmn1sJ0a1tsMmLCx2EjsisidT43+
	 Ij88Z0grdNwanWZ8Eft1p140ImMitKho3sgpxEWsxplDrk4h/hXYGZxOgD07HTr7Q1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LEgYocX4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795102424;
	bh=i/4VGZklI1mht3vU+GfYHjWfZdT4QdFVah9IYtlFYqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lADP8kbGtx2Hk0P1y1qyus4fhgr/+t7vLZPuIXAx8e5kQJpPzq9WvgM/FhK4p9jyh
	 I3wrPSs9sHMow69Y1mdGHoc71xAcQp3iyrYzJrkMgEgfN5HzIdtRuZnGG+O6XHDZb/
	 I8Ab9cA0h9GG1F5j5DKqWBGZ8WsJukk4iBt6PpxL4gHgfsx/Hnrxp0HxsanDPyRDLH
	 lQrPyypEtekp7kn5CxvMO9aIrNeLxpR3wPGrWbTCQ8C8uTYwr5HjYB76drrAiawbYh
	 A6MKuNIvdgBaz7tEDWK8WC0R+fb75yp8EP8LcD1bTjcCtIUSge0f1rJ5E+WrslMMdz
	 o3tkkVqp40AxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8F16810A1;
	Thu, 19 Nov 2026 15:33:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DAFFA1E7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB612810A1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gF8mE_lWf26V for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 15:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B7B181092
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LEgYocX4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B7B181092
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795102419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/4VGZklI1mht3vU+GfYHjWfZdT4QdFVah9IYtlFYqU=;
 b=LEgYocX4fBzi9V00E+JKJGjBW+8zfw6s98UoxXiPrnn8gI5nxV4TU4ohGc0GnN7fJv6lXS
 fi7DsfZ3cgbKw9NfEXIsHDaJi93SApmiuuKZGbst+FUKztcvKABrIfaZt7TnTxzg/2i3v+
 MS5Pdl7dRxkV6gZdSuPJqc7QPW6++Z4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-9u9nqmUFMreFKL8wrAKLXA-1; Thu, 19 Nov 2026 10:33:36 -0500
X-MC-Unique: 9u9nqmUFMreFKL8wrAKLXA-1
X-Mimecast-MFC-AGG-ID: 9u9nqmUFMreFKL8wrAKLXA_1795102415
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4bb68a5e792so7415985e9.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 07:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795102415; x=1795707215;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/4VGZklI1mht3vU+GfYHjWfZdT4QdFVah9IYtlFYqU=;
 b=NTFzBI1jDf4a8Z1suov48lmviMfK8z6nnHFtDkjqJZiFBq9mGQLMnJebKF8msZ6tbj
 CifYtjhTQCUvnXcpFo5N9JS0d/RpFRcpNfnLPuG7rNsyc7vRnjm8NzvUfJ0Lc5VNmm3S
 Ys26p00naHUXxzOYXCMAbr1brGCY/4mEy8sMEC2RA1PUfrEJtxBMxfOEQDvpz5Perch8
 9ehNaM0BWhXHWCHaB0nEiTRT7Mko8beY1BRhSSSVQtt9QfRbhYvywNnKkyC9q0+hhGjI
 JtNE2A6AL58O7Tov3t+8KWewzdw//9/h0bnctJDcbrRrGeNAf4CI0TIa9cExqdQf/DuB
 1/xQ==
X-Gm-Message-State: APuU4Z8Yfh1m4210fs0rlOrU7S6vShygTWCclCVb6ElqRGwYLyJP0Mte
 W5TQIhLXLeT55xFWMrBnMf8FRunkXZ9ZcMKNFUzYPKaPf40SvMMWMa5aR1IymnSVHZnp9iwIykP
 ANDpx3+mGvgBE5HFdsxzGYNjkjXVON9Avz997hxPUpIkH3MaFfrcuAobPQn00CURL1VHxJus=
X-Gm-Gg: AYBFou2KCeZRiG+C4QJFIlJTs3/eER/QZQC6TcS1E25cdQcsE/O3RFxnJOW6CYAk5Ji
 EFUyLhH5Btu0sRxt8P6KvY/cEvgx6WYJ/lD5wWzn9YROVLNdLC53FJvddORZV+0Vo6EwxZUGRdd
 UJBtn1K4frxqUuYkvJaIhVa0M87QEJQVZ4uTP/MWRGfMGVe6gomB6bydKGEiOO/Xy9JdvRO0mzB
 pO1RtNCVywPuIaZtSLMwMwk9wtIi8OXGuJIBpNqA/JZGVUUYy2hbcuapmsas8vDOMM8k7ZAQk/j
 IgWRpb8n0wfvdbrXrHHJBTMsrjKLkNXCYoU+ErrUe1JvZYlPydlGbOxZvVEOaZQ3Tdm8jPlXLwU
 JbzprtOkg8+NGbPC/8XIZWHN0eczCSbSLfx6oSgMjhs1LxpbPHK4VthbG/GfAZEpYSsGn6GEQX8
 0+ZXFrrX0cws1g1r/tDdqHTJaRl6xHISbqwzRIVpLTU2gq
X-Received: by 2002:a05:600c:b90:b0:4bb:6a78:7c42 with SMTP id
 5b1f17b1804b1-4bb860f622cmr33533285e9.1.1795102414616; 
 Thu, 19 Nov 2026 07:33:34 -0800 (PST)
X-Received: by 2002:a05:600c:b90:b0:4bb:6a78:7c42 with SMTP id
 5b1f17b1804b1-4bb860f622cmr33532145e9.1.1795102413397; 
 Thu, 19 Nov 2026 07:33:33 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it.
 [82.192.128.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm4736515e9.7.2026.11.19.07.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 07:33:32 -0800 (PST)
Message-ID: <91e6c89d-d963-4282-822f-b9daa5bf32a8@redhat.com>
Date: Thu, 19 Nov 2026 16:33:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] xsk: ice: USO support for AF_XDP
To: Magnus Karlsson <magnus.karlsson@intel.com>, magnus.karlsson@gmail.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, horms@kernel.org, bjorn@kernel.org,
 kerneljasonxing@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
References: <20261119141032.1070446-1-magnus.karlsson@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261119141032.1070446-1-magnus.karlsson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6awTRn_c2Pum8PPtaxRvQ3Qu459roRoAoMddzeUgq5E_1795102415
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 15:10, Magnus Karlsson wrote:
> This series adds UDP Segmentation Offload (USO) to AF_XDP. An
> application submits one Ethernet frame holding a single IP and UDP
> header followed by the aggregate UDP payload, and the device emits a
> train of MTU-sized UDP datagrams. Patch 1 implements it for copy mode
> (the skb path). Patch 2 is an ice preparation that adds Tx descriptor
> builders, and patch 3 implements USO for zero-copy mode in the ice
> driver.
> 
> AF_XDP never segments these packets itself: a request is rejected
> unless the device offers USO. For the ice zero-copy path, the
> segmentation is done in HW. In copy mode, the packet is passed
> unsegmented to the bound device's driver, and as with UDP_SEGMENT
> sockets, how the driver carries out the segmentation is up to it.
> Stacked devices (VLAN, bonding, macvlan) forward the packet to a lower
> device that may segment it in SW.
> 
> The design extends the existing Tx metadata support in AF_XDP. One new
> flag, XDP_TXMD_FLAGS_USO, is added, and the reserved u32 in the request
> part of struct xsk_tx_metadata is split into two u16 fields called
> gso_size and network_offset. Zero-copy support is advertised through
> the new tx-uso-zc netdev XSK feature.
> 
> network_offset is part of the uAPI because csum_start only locates L4,
> while segmentation also needs the start of L3: the device rewrites the
> IP header of every datagram and needs the L2 and L3 lengths, and on
> the skb path it becomes the network header. With it, the kernel does
> not need to understand the link layer, and the fields can be reused
> later. Any future extension for tunnel segmentation would treat
> network_offset as the outer L3 offset and csum_start as the inner L4
> offset, adding only the outer L4 and inner L3 offsets.
> 
> To request USO, bind the socket in XDP_COPY mode, or in XDP_ZEROCOPY
> mode on a driver advertising tx-uso-zc, and set XDP_TXMD_FLAGS_USO |
> XDP_TXMD_FLAGS_CHECKSUM in the Tx metadata. Reserve at least 16 bytes
> of metadata and set XDP_TX_METADATA on the first descriptor of the
> packet.
> 
> Submit an Ethernet frame containing one IP header, one UDP header, and
> the aggregate UDP payload. Set network_offset to the IP header offset,
> csum_start to the UDP header offset, and csum_offset to the UDP
> checksum field offset (6 bytes). Header offsets are measured from the
> first descriptor's packet-data address, excluding metadata. Set
> gso_size to the number of UDP payload bytes per output datagram,
> excluding headers; the last datagram may of course be shorter.
> 
> USO is only available on Ethernet devices. IPv4 headers may carry
> options but must not be fragmented. In IPv6, the UDP header must
> directly follow the fixed header; extension headers are not supported.
> 
> The IP and UDP lengths must describe the aggregate packet. Initialize
> the UDP checksum field with the partial pseudoheader checksum seed for
> that packet. The device generates the per-datagram lengths and UDP
> checksums and, for IPv4 segmentation, the IP header checksums. You must
> supply a valid IPv4 header checksum as well, since a request that fits
> in one datagram uses ordinary checksum offload without segmentation.
> 
> All headers through UDP must be in the first buffer. Multi-buffer
> packets use XDP_USE_SG and XDP_PKT_CONTD, with metadata only on the
> first descriptor. Each output IP packet must fit the device MTU, and
> requests remain subject to the device's segmentation limits. Query
> tx-udp-segmentation through ethtool to check whether skb UDP
> segmentation offload is enabled.
> 
> USO cannot be combined with XDP_UMEM_TX_SW_CSUM or
> XDP_TXMD_FLAGS_TIMESTAMP. Launch time can be combined with USO in copy
> mode, but not in zero-copy mode as that has not been implemented on
> ice or tested on any other device for that matter.
> 
> A USO request that is rejected is dropped: its buffers are completed
> and counted in tx_invalid_descs. This is the only indication of the
> failure, whatever its cause: invalid metadata or headers, the MTU,
> segmentation limits, or a device without the offload. Errors in other
> Tx metadata keep failing sendmsg() in copy mode, so the behaviour for
> existing non-USO users is unchanged. Zero-copy drivers without
> tx-uso-zc do not drop USO requests; they ignore the Tx metadata and
> send the frame unsegmented and without offloads. ice behaves the same
> way when it has fewer XDP Tx rings than CPUs, as queues then share XDP
> Tx rings. This can be supported in a follow up patch series as it
> would require quite some changes to the driver. Note that tx-uso-zc is
> still reported in this case, since it is a static driver capability.
> 
> In both modes, requests that produce more than one datagram need
> tx-udp-segmentation to be enabled; tx-uso-zc only reports driver
> capability. In zero-copy mode, a packet may use at most
> xdp-zc-max-segs descriptors, and ice specifically allows at most eight
> buffers per output datagram, counting the copied header.
> 
> The header validator works on a raw header copy instead of an skb, so
> that it can be shared by the skb and zero-copy paths. It lives in
> net/xdp/xsk_tx_uso.c and include/net/xsk_tx_uso.h. In zero-copy mode,
> ice copies the headers into kernel-owned memory before validating them
> and handing them to the NIC, while the payload stays in the UMEM. I
> tried finding an existing packet header validator that works on raw
> buffers that could be reused, but I could not find one. Therefore this
> small validator was added.
> 
> Testing was done on an ice NIC in loopback mode with a USO selftest,
> in both copy and zero-copy mode. Patch 5 adds it as
> selftests/net/xsk_uso. It checks the segment count, lengths, checksums
> and payload of the received datagrams for IPv4 and IPv6, single and
> multi-buffer requests, and that invalid requests are rejected. Patch 4
> adds KUnit tests for the header validation helpers. Note that patch 5
> should really be integrated into either xskxceiver or Stan's
> xdp_hw_metadata tests. But as these are currently being modified to
> fit into selftests/net and maybe even merged, I kept the USO tests
> separate for now.
> 
> The tables below show the UDP packet rate achieved by a single socket
> on my rather old 2.1 GHz Cascade Lake server with PCIe3, relative to
> no offloads at 1472 bytes. Each request carries a UDP payload that is
> segmented into 1472-byte datagrams, either in user space (no offloads,
> so UDP checksum is also performed in SW using the kernel's
> csum_partial() algorithm) or by the NIC (USO). The application and the
> queue's interrupt are pinned to the same core, and the socket is
> driven by preferred busy polling with napi_defer_hard_irqs=100 and
> gro_flush_timeout=2000000, so there are virtually no device
> interrupts. Each table's performance numbers are normalized to the
> performance for 1472 byte packets with no offloads in that table.
> 
> SKB mode - write all packet data for each packet
> 
> +---------------+-------------+---------------+
> | Payload bytes | No offloads | USO + HW csum |
> +---------------+-------------+---------------+
> |          1472 |       +0.0% |        +86.2% |
> |          4416 |       +2.2% |       +192.1% |
> |          7360 |       +2.6% |       +290.0% |
> |         10304 |       +2.4% |       +301.5% |
> |         13248 |       +2.4% |       +322.2% |
> |         16192 |       +2.1% |       +355.6% |
> +---------------+-------------+---------------+
> 
> SKB mode - write only headers for each packet
> 
> +---------------+-------------+---------------+
> | Payload bytes | No offloads | USO + HW csum |
> +---------------+-------------+---------------+
> |          1472 |       +0.0% |        +88.7% |
> |          4416 |       +2.3% |       +211.3% |
> |          7360 |       +2.5% |       +342.0% |
> |         10304 |       +2.6% |       +367.7% |
> |         13248 |       +2.8% |       +394.1% |
> |         16192 |       +2.8% |       +444.8% |
> +---------------+-------------+---------------+
> 
> ZC mode - write all packet data for each packet
> 
> +---------------+-------------+---------------+
> | Payload bytes | No offloads | USO + HW csum |
> +---------------+-------------+---------------+
> |          1472 |       +0.0% |       +185.6% |
> |          4416 |       +4.1% |       +279.6% |
> |          7360 |       +4.8% |       +332.1% |
> |         10304 |       +4.4% |       +325.5% |
> |         13248 |       +3.6% |       +333.4% |
> |         16192 |       +3.5% |       +339.1% |
> +---------------+-------------+---------------+
> 
> ZC mode - write only headers for each packet
> 
> +---------------+-------------+---------------+
> | Payload bytes | No offloads | USO + HW csum |
> +---------------+-------------+---------------+
> |          1472 |       +0.0% |       +163.9% |
> |          4416 |       +2.9% |       +260.0% |
> |          7360 |       +3.1% |       +291.9% |
> |         10304 |       +3.6% |       +303.9% |
> |         13248 |       +4.2% |       +307.6% |
> |         16192 |       +4.1% |       +315.8% |
> +---------------+-------------+---------------+
> 
> At 1472 bytes the request fits in one datagram, so USO is not
> segmenting anything and the gain comes from the checksum offload
> alone. As soon as multiple UDP packets have to be produced on the
> wire, USO becomes really beneficial.
> 
> For the zero-copy tests, my system seems to bottleneck at around 50
> Gbps (about 4 Mpps) with 7K payloads or above. The board only has x8
> lanes of PCIe3, though the slot is x16. In any case, there is a
> benefit to USO even on this system.
> 
> Patch series:
> 1: Implements USO for skb path
> 2: Adds Tx descriptor builders and a header length check to ice
> 3: Implements USO for ice zero-copy driver
> 4: KUnit tests for the USO header helpers
> 5: selftests/net: AF_XDP USO functional test
You forgot to CC: netdev

/P

