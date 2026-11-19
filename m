Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADBA60A2615
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mDuDuZMr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rNcr8Qcq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 378CA80CB2;
	Thu, 19 Nov 2026 15:51:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K6CuosdKYv7m; Thu, 19 Nov 2026 15:51:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4129D81154
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103508;
	b=FDm6EFgLBOsr6KVJ7uvl19GFP5xPOtgbg+Bt6lyxbDgUUPQXv9ZWHT3I5gXufxOMBAe0
	 3yHA4uRpP2QgrrN3zCOCE0BbSN0hUeCLrn12/eEjQQcLtXKe4gXp2N4SGqqQVyrt+6eZi
	 ton8TM875O0X3trDhe9kvw6KRH9gQD46Xd9TT5Q5407tJkksfuN8RIG1sAHMZABCFbyT+
	 W45elT/wmNhYGPKqsAnYNpMSurVgxnwXaAiugur9tD+JpT+jhjJmW8dZsfWQ28Xc5OfRq
	 HBool05X2uqfzunWh8zEIcPHuihMnKFSQ8379PtxZoyu7CiheXpcel017UfKjG6ydUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103508;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wQPC7WOppe0m6w+rkclbYm/OPw/drUqUiyXbGYqRwuU=;
	b=pIqkFEhah/HqM1YUwUbHQTPVIZtKQjx+s33IZ1XqHEFSpwM/QGsuOB0As+7QjKHvhy5c
	 FCtC9/NZyZlLnU8RoSVhpeGEJDFOkXT+i+e7jk1tLAgZADxvftR2kPw+mtFip0KVEl1JE
	 IzamzSqyAJGocni7qCB08LkemJkG8LvJe+eOy7nDLntWjwdDx/WPbT7d0JOo1RwS+KVhn
	 4jFDk33c4xPDe3QMjA3cPX69lKsNOjktmQfLjJx8ouZSH1D9Ix7cq4SynxCD+Q0tDUI67
	 l6h5Z2ZkEdQt4L3fz4n3a3iLVFRssHFgis96dI9VDSzECrGvOoyJTGdnjUN8u/4T04Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795103508;
	bh=wQPC7WOppe0m6w+rkclbYm/OPw/drUqUiyXbGYqRwuU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mDuDuZMr7SnRO5symjFruWGB8tBCEhA2SB0KA6HRaNZ7oKzrPhjuyxrqBlQXJDF4o
	 A+lv94IlbLHDVRQn4BYTHd/R0lLs90jo6w0C6xxvIok8BtUKpi5hQwzqZ3oFpCUeLR
	 XuBjTuh9nYOq0T5HsS7ekAH99nCpKE6vZT/xUj6e7YTiW9KHxoVj1dVfH5q7ifb1Vr
	 N21Ccp88O+qS9m9AWubn7LVo1VXYLO5dnfttpyFkMg0znkdoaqAa60e0wWYUexNqa/
	 bamH+Iqvlt9Xa54gaC5kfj9gBA4NeSloQBt4xnoVIReFJHgw3vvBflaihiJhqhy/SH
	 BaQYgL6caYkSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4129D81154;
	Thu, 19 Nov 2026 15:51:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E474822B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5E5760686
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:51:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UKMiTJHq9mvE for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 15:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C569660670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rNcr8Qcq
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C569660670
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:51:45 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8a06cc097c7so1830566b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 07:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795103505; x=1795708305; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wQPC7WOppe0m6w+rkclbYm/OPw/drUqUiyXbGYqRwuU=;
 b=rNcr8Qcqm8D6VlOeUPF5fpbLALWEjjf7TQbitPLbKO8nirokOVKXRkbvseVPvfrY/Y
 IrM1rKYKo0SeqQDq9ykC7XZucy4jkIiRB5izhXToopQyVjMfOQhW4DOHHJtYuovKMc5m
 DXv98Rr2zalipOX7WW8daWHsi4uMjpZyc3/Gxvi9np8LtuuZUbg7JFbznxgUi6puNq2L
 AqF5O1gx+juOvBZYpVXj22bHgnCelEx1e7+MKopswSk5mhzkHvJY17eaQk/pIp71ukkP
 zHJgpl8mXZFnRhPESWVSmUoIxfLHYBwPFhRrSOd9fmwYJj/pbHMKgSeErwDw5mmSSzyw
 HcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795103505; x=1795708305;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wQPC7WOppe0m6w+rkclbYm/OPw/drUqUiyXbGYqRwuU=;
 b=ZUxchcfEp3Rb3IPHoYL3pXnRMVrL18oyejOqaxhkh6bQr16mppH2qLWvIXFOQnaYOE
 dQjhqRgE59jfrxH9/APs7p/1tGTW6mnHsDFVdPwQia1CO/3bcehnyxy6qf70MvMDbXMw
 NkekPzNkqbaEZiCUiuXNoD6yyEGsUwJ5KLAh+h/ghCCDWUbeyiXMe8PsWgD1bMOfDJy0
 zAbpgSKZLYbUVTkk0unnSPc2IvlZLy2BkMmQDnjmnGZTXMq3Lczgf9/pVj6ff6hs+jG4
 XE17qnXFgfqmk+WPdrAhHEDi6ZnUUiicrJV4GH6ek3tuqlFaJcdVDXzNMbo80FVJus1u
 Y4Bw==
X-Forwarded-Encrypted: i=1;
 AL+hErG1tyu4yy7Z4Fwp7FFD3iVhpEvyg2xafJUaImtb0NNL2+DtRsobufv15ui+VEEuYxnsJgB/jGukI2uAvFuBoz0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z81mmx93E2uNJ4y5GcKTd2s1NbcQnIII95wHICfpWPU2gWmbZut
 zu+0Pn7pBn5CtmSVjxwqXUzr5LxjQ+SyIamXGeY8t+SpdsLwQ+a7aeMhfYrbR9spwkWLcq9Tnhs
 wOmODh8uMhrCrXaSXtOK0zwx+S530DIo=
X-Gm-Gg: AYBFou2/Juc920jhzl++8DSGMGvJXl4Y22n0j1tGp1MtBRTW91aHUB+lh82MRw91EZ9
 R2ZL1qSoWCq5XbWTI6muDf0gkM3G5TDyNdF8Dzr37abG0jHhdUkfIeHSqs7p8HHTj9WIBGaYpIg
 BtL0Opj9kj9euhmJ+NvR1g8kn9sTwOx7uJrg07PSTVDX/6kzGeFqqLHmc98QU6t+SYIz7ZHIEJ2
 b7fLVVD1b0fTkr1cA8HqB05nVJmrZQ0rDC+0knzwDL508ZZ7TlfVnSygwxh9xMXZtrcmz7JZzWW
 fheAOpe15su0aM0uJ0JJxVnXqz0sMFgq2WfwNIRddVr683b3Y0jAvPH3zNILvPDCrdP4PamS7oV
 XFnRI66W8CsRys1zIWXoQYipNTTTB7LgSGFhTN/3nxWqTnl89gHA7XxDJbYqf
X-Received: by 2002:a05:6a21:880a:b0:3f9:e8f1:697e with SMTP id
 adf61e73a8af0-4014bc58241mr38751637.34.1795103504502; Thu, 19 Nov 2026
 07:51:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119141032.1070446-1-magnus.karlsson@intel.com>
 <91e6c89d-d963-4282-822f-b9daa5bf32a8@redhat.com>
In-Reply-To: <91e6c89d-d963-4282-822f-b9daa5bf32a8@redhat.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 19 Nov 2026 16:51:31 +0100
X-Gm-Features: AclHuK998jI5jJtqbxgN7cl9HOWptEXEZ8Fp-fB1oy6oPL0QzyvA32qeU7B7YNA
Message-ID: <CAJ8uoz25cA_oEidTzwC_sjCH_0YMT2njXbCXwWfeAkMpEUDV8g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] xsk: ice: USO support for AF_XDP
To: Paolo Abeni <pabeni@redhat.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, maciej.fijalkowski@intel.com, 
 sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 16:33, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 11/19/26 15:10, Magnus Karlsson wrote:
> > This series adds UDP Segmentation Offload (USO) to AF_XDP. An
> > application submits one Ethernet frame holding a single IP and UDP
> > header followed by the aggregate UDP payload, and the device emits a
> > train of MTU-sized UDP datagrams. Patch 1 implements it for copy mode
> > (the skb path). Patch 2 is an ice preparation that adds Tx descriptor
> > builders, and patch 3 implements USO for zero-copy mode in the ice
> > driver.
> >
> > AF_XDP never segments these packets itself: a request is rejected
> > unless the device offers USO. For the ice zero-copy path, the
> > segmentation is done in HW. In copy mode, the packet is passed
> > unsegmented to the bound device's driver, and as with UDP_SEGMENT
> > sockets, how the driver carries out the segmentation is up to it.
> > Stacked devices (VLAN, bonding, macvlan) forward the packet to a lower
> > device that may segment it in SW.
> >
> > The design extends the existing Tx metadata support in AF_XDP. One new
> > flag, XDP_TXMD_FLAGS_USO, is added, and the reserved u32 in the request
> > part of struct xsk_tx_metadata is split into two u16 fields called
> > gso_size and network_offset. Zero-copy support is advertised through
> > the new tx-uso-zc netdev XSK feature.
> >
> > network_offset is part of the uAPI because csum_start only locates L4,
> > while segmentation also needs the start of L3: the device rewrites the
> > IP header of every datagram and needs the L2 and L3 lengths, and on
> > the skb path it becomes the network header. With it, the kernel does
> > not need to understand the link layer, and the fields can be reused
> > later. Any future extension for tunnel segmentation would treat
> > network_offset as the outer L3 offset and csum_start as the inner L4
> > offset, adding only the outer L4 and inner L3 offsets.
> >
> > To request USO, bind the socket in XDP_COPY mode, or in XDP_ZEROCOPY
> > mode on a driver advertising tx-uso-zc, and set XDP_TXMD_FLAGS_USO |
> > XDP_TXMD_FLAGS_CHECKSUM in the Tx metadata. Reserve at least 16 bytes
> > of metadata and set XDP_TX_METADATA on the first descriptor of the
> > packet.
> >
> > Submit an Ethernet frame containing one IP header, one UDP header, and
> > the aggregate UDP payload. Set network_offset to the IP header offset,
> > csum_start to the UDP header offset, and csum_offset to the UDP
> > checksum field offset (6 bytes). Header offsets are measured from the
> > first descriptor's packet-data address, excluding metadata. Set
> > gso_size to the number of UDP payload bytes per output datagram,
> > excluding headers; the last datagram may of course be shorter.
> >
> > USO is only available on Ethernet devices. IPv4 headers may carry
> > options but must not be fragmented. In IPv6, the UDP header must
> > directly follow the fixed header; extension headers are not supported.
> >
> > The IP and UDP lengths must describe the aggregate packet. Initialize
> > the UDP checksum field with the partial pseudoheader checksum seed for
> > that packet. The device generates the per-datagram lengths and UDP
> > checksums and, for IPv4 segmentation, the IP header checksums. You must
> > supply a valid IPv4 header checksum as well, since a request that fits
> > in one datagram uses ordinary checksum offload without segmentation.
> >
> > All headers through UDP must be in the first buffer. Multi-buffer
> > packets use XDP_USE_SG and XDP_PKT_CONTD, with metadata only on the
> > first descriptor. Each output IP packet must fit the device MTU, and
> > requests remain subject to the device's segmentation limits. Query
> > tx-udp-segmentation through ethtool to check whether skb UDP
> > segmentation offload is enabled.
> >
> > USO cannot be combined with XDP_UMEM_TX_SW_CSUM or
> > XDP_TXMD_FLAGS_TIMESTAMP. Launch time can be combined with USO in copy
> > mode, but not in zero-copy mode as that has not been implemented on
> > ice or tested on any other device for that matter.
> >
> > A USO request that is rejected is dropped: its buffers are completed
> > and counted in tx_invalid_descs. This is the only indication of the
> > failure, whatever its cause: invalid metadata or headers, the MTU,
> > segmentation limits, or a device without the offload. Errors in other
> > Tx metadata keep failing sendmsg() in copy mode, so the behaviour for
> > existing non-USO users is unchanged. Zero-copy drivers without
> > tx-uso-zc do not drop USO requests; they ignore the Tx metadata and
> > send the frame unsegmented and without offloads. ice behaves the same
> > way when it has fewer XDP Tx rings than CPUs, as queues then share XDP
> > Tx rings. This can be supported in a follow up patch series as it
> > would require quite some changes to the driver. Note that tx-uso-zc is
> > still reported in this case, since it is a static driver capability.
> >
> > In both modes, requests that produce more than one datagram need
> > tx-udp-segmentation to be enabled; tx-uso-zc only reports driver
> > capability. In zero-copy mode, a packet may use at most
> > xdp-zc-max-segs descriptors, and ice specifically allows at most eight
> > buffers per output datagram, counting the copied header.
> >
> > The header validator works on a raw header copy instead of an skb, so
> > that it can be shared by the skb and zero-copy paths. It lives in
> > net/xdp/xsk_tx_uso.c and include/net/xsk_tx_uso.h. In zero-copy mode,
> > ice copies the headers into kernel-owned memory before validating them
> > and handing them to the NIC, while the payload stays in the UMEM. I
> > tried finding an existing packet header validator that works on raw
> > buffers that could be reused, but I could not find one. Therefore this
> > small validator was added.
> >
> > Testing was done on an ice NIC in loopback mode with a USO selftest,
> > in both copy and zero-copy mode. Patch 5 adds it as
> > selftests/net/xsk_uso. It checks the segment count, lengths, checksums
> > and payload of the received datagrams for IPv4 and IPv6, single and
> > multi-buffer requests, and that invalid requests are rejected. Patch 4
> > adds KUnit tests for the header validation helpers. Note that patch 5
> > should really be integrated into either xskxceiver or Stan's
> > xdp_hw_metadata tests. But as these are currently being modified to
> > fit into selftests/net and maybe even merged, I kept the USO tests
> > separate for now.
> >
> > The tables below show the UDP packet rate achieved by a single socket
> > on my rather old 2.1 GHz Cascade Lake server with PCIe3, relative to
> > no offloads at 1472 bytes. Each request carries a UDP payload that is
> > segmented into 1472-byte datagrams, either in user space (no offloads,
> > so UDP checksum is also performed in SW using the kernel's
> > csum_partial() algorithm) or by the NIC (USO). The application and the
> > queue's interrupt are pinned to the same core, and the socket is
> > driven by preferred busy polling with napi_defer_hard_irqs=100 and
> > gro_flush_timeout=2000000, so there are virtually no device
> > interrupts. Each table's performance numbers are normalized to the
> > performance for 1472 byte packets with no offloads in that table.
> >
> > SKB mode - write all packet data for each packet
> >
> > +---------------+-------------+---------------+
> > | Payload bytes | No offloads | USO + HW csum |
> > +---------------+-------------+---------------+
> > |          1472 |       +0.0% |        +86.2% |
> > |          4416 |       +2.2% |       +192.1% |
> > |          7360 |       +2.6% |       +290.0% |
> > |         10304 |       +2.4% |       +301.5% |
> > |         13248 |       +2.4% |       +322.2% |
> > |         16192 |       +2.1% |       +355.6% |
> > +---------------+-------------+---------------+
> >
> > SKB mode - write only headers for each packet
> >
> > +---------------+-------------+---------------+
> > | Payload bytes | No offloads | USO + HW csum |
> > +---------------+-------------+---------------+
> > |          1472 |       +0.0% |        +88.7% |
> > |          4416 |       +2.3% |       +211.3% |
> > |          7360 |       +2.5% |       +342.0% |
> > |         10304 |       +2.6% |       +367.7% |
> > |         13248 |       +2.8% |       +394.1% |
> > |         16192 |       +2.8% |       +444.8% |
> > +---------------+-------------+---------------+
> >
> > ZC mode - write all packet data for each packet
> >
> > +---------------+-------------+---------------+
> > | Payload bytes | No offloads | USO + HW csum |
> > +---------------+-------------+---------------+
> > |          1472 |       +0.0% |       +185.6% |
> > |          4416 |       +4.1% |       +279.6% |
> > |          7360 |       +4.8% |       +332.1% |
> > |         10304 |       +4.4% |       +325.5% |
> > |         13248 |       +3.6% |       +333.4% |
> > |         16192 |       +3.5% |       +339.1% |
> > +---------------+-------------+---------------+
> >
> > ZC mode - write only headers for each packet
> >
> > +---------------+-------------+---------------+
> > | Payload bytes | No offloads | USO + HW csum |
> > +---------------+-------------+---------------+
> > |          1472 |       +0.0% |       +163.9% |
> > |          4416 |       +2.9% |       +260.0% |
> > |          7360 |       +3.1% |       +291.9% |
> > |         10304 |       +3.6% |       +303.9% |
> > |         13248 |       +4.2% |       +307.6% |
> > |         16192 |       +4.1% |       +315.8% |
> > +---------------+-------------+---------------+
> >
> > At 1472 bytes the request fits in one datagram, so USO is not
> > segmenting anything and the gain comes from the checksum offload
> > alone. As soon as multiple UDP packets have to be produced on the
> > wire, USO becomes really beneficial.
> >
> > For the zero-copy tests, my system seems to bottleneck at around 50
> > Gbps (about 4 Mpps) with 7K payloads or above. The board only has x8
> > lanes of PCIe3, though the slot is x16. In any case, there is a
> > benefit to USO even on this system.
> >
> > Patch series:
> > 1: Implements USO for skb path
> > 2: Adds Tx descriptor builders and a header length check to ice
> > 3: Implements USO for ice zero-copy driver
> > 4: KUnit tests for the USO header helpers
> > 5: selftests/net: AF_XDP USO functional test
> You forgot to CC: netdev

Ha, that is what I get for being out of the game for a while! Should I
send a v2 or just resend? Please advice.

> /P
>
