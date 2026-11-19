Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C153606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=cCMY4qo1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c2zmapfs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07D03404C8;
	Thu, 19 Nov 2026 16:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yTscKA_OuXV; Thu, 19 Nov 2026 16:39:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 09C06404EF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795106371;
	b=np+Zi1PPWdpusP94UAuFbgGWEB6fLHAl+FKtOfKADM9jsvwbmtkZ/Go4TND94IFVppv9
	 hIha/3RChlc/Ylf+xZ5rd+/2/qY45n+gEL1zOM6nGECFN7u+p16MD1H6wwGgJJuyKC8Yd
	 3tBDXZ2hK4iyyXERxiAAiph1YzhRO6vhfTmgJWWaJ77XHbCru0Wzmrekur5SUzxuqpKPX
	 tbcmZponOT4PKBaKN/teyFMCUFvN4D/i67XSazzTMxjTBVwbkBvbE0lJOdgZ4FQyTrkH0
	 8i2DWvI/KfJk9AZfJQb4p1LwQ47EcSGX4goDs9IjDVDn5YmdTf2ZqC7w7DgWat9wMJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795106371;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wKqozka7wf3nJcI2D1vmPrgm5MT+jmTg1xPxdoRcAig=;
	b=EdgrplSfW5oTaizUQZcW9F65tU5Ug7TJntuC7YY7mX42Lr2by4PYd/IglTR0cOj4SW7/
	 JdREGXp8yiL4alBuUo5W+E20xoLg7fZrVYR+9AfGNm4V+IK44gRy9sTkdUuOS36R0cGmQ
	 wSkTmyqJEqZj2oNqs6pMYnsr+ybqMgyrRQKWS5o1uPxwFR5A4ZApPjd1m2Abq3PngYi+K
	 1JP0gJAxNV1e2Xu9Jr/CgJJgo+Hc7Qwft/zhIDCg1DteQWGDKWJwv/Md0Vw8UYMsWrFoU
	 ClR0bCELU57+jfvrBGLUG5wBqjSOYRyxLJC2q3FOwSaTpULriCs4a+E+gojK+M/BDfQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c2zmapfs;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795106371;
	bh=wKqozka7wf3nJcI2D1vmPrgm5MT+jmTg1xPxdoRcAig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cCMY4qo1R6RdaGKLc4kD+BCBiBqLEhc/lbdSstSR60ImatnzE13mTvTiuju3j/ZSB
	 ssLgWtqVR+ztnyuv/PRMYtEH/DwnQkdJM38EDkGS8hhYRQB/kql6LIa6LBJMFgcQxs
	 dPE0CsWqKP+Tkvd0X9lVz2/rL5+UwI42d0R+5FFXaWsN5MM3s4uVoeoZq7iyR39pLQ
	 dYC4gPgRDYVnPQ4T36dJHZh+2lj+LxmuizyxrZUL+7Se7J4jkBkzBZO3SnJQi8c+v7
	 MYqvnkV6/h7jkRZBeAGOorFWBkGGxin6AYA1ghFQwh3hmGdacvEpb8HUKL0PmGQcDI
	 yY7CGRpoFGPMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09C06404EF;
	Thu, 19 Nov 2026 16:39:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD3953A8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2EE3404EF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BjsSnEAfIWXS for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 16:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F65E404C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c2zmapfs
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F65E404C8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795106367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKqozka7wf3nJcI2D1vmPrgm5MT+jmTg1xPxdoRcAig=;
 b=c2zmapfslk6SbDHM/tbGsl0riZqTpPCU4PbGCVa7JXWbpULuN74O101cnrdKCq6tlqOwTN
 bZOqYpwI3AsYEXH3Myjx+KaQ7ekRaf67DBnrSRJ/3R3BO2KmvHc2tyUw35w2gMBvsN5o/O
 KLy+J6bMEnD4sBMvFWL2Vv5Ct9ikVgM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Xf2oO5cLOr2rSmuO7YYtoQ-1; Thu, 19 Nov 2026 16:39:25 +0000
X-MC-Unique: Xf2oO5cLOr2rSmuO7YYtoQ-1
X-Mimecast-MFC-AGG-ID: Xf2oO5cLOr2rSmuO7YYtoQ_1795106364
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a0284121c6so16135135e9.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 08:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106364; x=1795711164;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wKqozka7wf3nJcI2D1vmPrgm5MT+jmTg1xPxdoRcAig=;
 b=OowlKQ/uph/wTeufX2njvXVszebPu/vFFwC2+V577S+VpCAJTyJatTgXPCyPPni2M9
 MCTW7z17t4VTlrW5MlrOTBY+kOmp6qUhtiVf9ioNnur831tqej85Y8YLuefC9wlh7R5N
 DLyF+eP9zoC/iWCtI3oXcKnS/EolaXkquBvfNIDPli+1MUWv1NWwfP1oodVirRe1ZnTI
 TrVI9QWTAijjpn2X5aPvhKCLYwhqe0Xduqh/fxdtWeLN+7imEDXl3ziZsixcELvdv9zi
 7GUeWxJkqnbukBa3F7iciSSHPezVgl47+YH8vmQTmVFDZ+QyvwOH2/Pv01hm0eFjh4Ck
 GPIA==
X-Forwarded-Encrypted: i=1;
 AL+hErEgxfvEYbMtDi9vqD4FFqx+2JAj7K6R+j7nJ0zLuYANUkpbnxZtkLU5sDfeOprjzGI1HdUmdofkfbJ0SFLgcNw=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8eg1AJp6a08dNu4bfD4in5N73xgjZpqmytRLgQMpwdhb5cyuVK
 4HXwymnMRVL4h32ehRIMAESSCBs56QIt+dd4KNbA4Hu/ADLJe5tp900lmiSaM2gAYY2GYChuQCD
 W/uN5iExmS9oKkI2R0j5NGK26fV2kYfJjD3d9r0f3bajPEyCdO2HLrHfBoJG3ufRmG+c4agc=
X-Gm-Gg: AYBFou3QtzPzFvEot1QI3RBYgO6I8Y26B9qBw4au+Iy+V+EdTaNbaGCAPEHKPS36TsN
 6M9WMKLeoNGCvWB2t+o3awe2unW6Kgoc7gpbjZyDjbg2BEj9VyQvbcV+MWQPGM/3CRI98jJBVen
 Lx6WiAU+lqaApq5ooBnb6MtUd3n4xolNe57vW+Yt+UViy7dRyFNhHp7REZaqfK9mZoUWyg9cbWw
 Inj2Z8+RAracDc/cbdxL0eCvYXogoAGxgpNJgE+vAMDC2/XdiVFX3uckuYUpL5J2s+bCQhz2Yrd
 hOhOo1ERjnQM5eFx9361gNYtlsQ1Lzh2v1irg5rPmdGi+IH/7O6lxbT/1JZ7xydPRZHCyzG2eIF
 vG7y+324UlMI3ca1ExLgZ2gSpeLB8q+PbEZcQk/rxwjDA7sY2sEvUOsj4nHN2dgn/Th4SuC+Cf5
 MH11bMt2dPV8rlxD3aEb8En3vHBOvBHQjvTxM1rkAgK388
X-Received: by 2002:a05:600c:3555:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4bb8882907fmr813895e9.34.1795106364359; 
 Thu, 19 Nov 2026 08:39:24 -0800 (PST)
X-Received: by 2002:a05:600c:3555:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4bb8882907fmr813415e9.34.1795106363865; 
 Thu, 19 Nov 2026 08:39:23 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it.
 [82.192.128.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3c4dsm449664f8f.46.2026.11.19.08.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 08:39:23 -0800 (PST)
Message-ID: <d2356153-be70-42ff-bfae-e766290e02a3@redhat.com>
Date: Thu, 19 Nov 2026 17:39:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] xsk: ice: USO support for AF_XDP
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, horms@kernel.org, bjorn@kernel.org,
 kerneljasonxing@gmail.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com
References: <20261119141032.1070446-1-magnus.karlsson@intel.com>
 <91e6c89d-d963-4282-822f-b9daa5bf32a8@redhat.com>
 <CAJ8uoz25cA_oEidTzwC_sjCH_0YMT2njXbCXwWfeAkMpEUDV8g@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAJ8uoz25cA_oEidTzwC_sjCH_0YMT2njXbCXwWfeAkMpEUDV8g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CUzomD6RrAnMK9Qja1mK7LZxkQVemYQQ7uBaTgYH0Ww_1795106364
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

On 11/19/26 16:51, Magnus Karlsson wrote:
> On Thu, 19 Nov 2026 at 16:33, Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 11/19/26 15:10, Magnus Karlsson wrote:
>>> This series adds UDP Segmentation Offload (USO) to AF_XDP. An
>>> application submits one Ethernet frame holding a single IP and UDP
>>> header followed by the aggregate UDP payload, and the device emits a
>>> train of MTU-sized UDP datagrams. Patch 1 implements it for copy mode
>>> (the skb path). Patch 2 is an ice preparation that adds Tx descriptor
>>> builders, and patch 3 implements USO for zero-copy mode in the ice
>>> driver.
>>>
>>> AF_XDP never segments these packets itself: a request is rejected
>>> unless the device offers USO. For the ice zero-copy path, the
>>> segmentation is done in HW. In copy mode, the packet is passed
>>> unsegmented to the bound device's driver, and as with UDP_SEGMENT
>>> sockets, how the driver carries out the segmentation is up to it.
>>> Stacked devices (VLAN, bonding, macvlan) forward the packet to a lower
>>> device that may segment it in SW.
>>>
>>> The design extends the existing Tx metadata support in AF_XDP. One new
>>> flag, XDP_TXMD_FLAGS_USO, is added, and the reserved u32 in the request
>>> part of struct xsk_tx_metadata is split into two u16 fields called
>>> gso_size and network_offset. Zero-copy support is advertised through
>>> the new tx-uso-zc netdev XSK feature.
>>>
>>> network_offset is part of the uAPI because csum_start only locates L4,
>>> while segmentation also needs the start of L3: the device rewrites the
>>> IP header of every datagram and needs the L2 and L3 lengths, and on
>>> the skb path it becomes the network header. With it, the kernel does
>>> not need to understand the link layer, and the fields can be reused
>>> later. Any future extension for tunnel segmentation would treat
>>> network_offset as the outer L3 offset and csum_start as the inner L4
>>> offset, adding only the outer L4 and inner L3 offsets.
>>>
>>> To request USO, bind the socket in XDP_COPY mode, or in XDP_ZEROCOPY
>>> mode on a driver advertising tx-uso-zc, and set XDP_TXMD_FLAGS_USO |
>>> XDP_TXMD_FLAGS_CHECKSUM in the Tx metadata. Reserve at least 16 bytes
>>> of metadata and set XDP_TX_METADATA on the first descriptor of the
>>> packet.
>>>
>>> Submit an Ethernet frame containing one IP header, one UDP header, and
>>> the aggregate UDP payload. Set network_offset to the IP header offset,
>>> csum_start to the UDP header offset, and csum_offset to the UDP
>>> checksum field offset (6 bytes). Header offsets are measured from the
>>> first descriptor's packet-data address, excluding metadata. Set
>>> gso_size to the number of UDP payload bytes per output datagram,
>>> excluding headers; the last datagram may of course be shorter.
>>>
>>> USO is only available on Ethernet devices. IPv4 headers may carry
>>> options but must not be fragmented. In IPv6, the UDP header must
>>> directly follow the fixed header; extension headers are not supported.
>>>
>>> The IP and UDP lengths must describe the aggregate packet. Initialize
>>> the UDP checksum field with the partial pseudoheader checksum seed for
>>> that packet. The device generates the per-datagram lengths and UDP
>>> checksums and, for IPv4 segmentation, the IP header checksums. You must
>>> supply a valid IPv4 header checksum as well, since a request that fits
>>> in one datagram uses ordinary checksum offload without segmentation.
>>>
>>> All headers through UDP must be in the first buffer. Multi-buffer
>>> packets use XDP_USE_SG and XDP_PKT_CONTD, with metadata only on the
>>> first descriptor. Each output IP packet must fit the device MTU, and
>>> requests remain subject to the device's segmentation limits. Query
>>> tx-udp-segmentation through ethtool to check whether skb UDP
>>> segmentation offload is enabled.
>>>
>>> USO cannot be combined with XDP_UMEM_TX_SW_CSUM or
>>> XDP_TXMD_FLAGS_TIMESTAMP. Launch time can be combined with USO in copy
>>> mode, but not in zero-copy mode as that has not been implemented on
>>> ice or tested on any other device for that matter.
>>>
>>> A USO request that is rejected is dropped: its buffers are completed
>>> and counted in tx_invalid_descs. This is the only indication of the
>>> failure, whatever its cause: invalid metadata or headers, the MTU,
>>> segmentation limits, or a device without the offload. Errors in other
>>> Tx metadata keep failing sendmsg() in copy mode, so the behaviour for
>>> existing non-USO users is unchanged. Zero-copy drivers without
>>> tx-uso-zc do not drop USO requests; they ignore the Tx metadata and
>>> send the frame unsegmented and without offloads. ice behaves the same
>>> way when it has fewer XDP Tx rings than CPUs, as queues then share XDP
>>> Tx rings. This can be supported in a follow up patch series as it
>>> would require quite some changes to the driver. Note that tx-uso-zc is
>>> still reported in this case, since it is a static driver capability.
>>>
>>> In both modes, requests that produce more than one datagram need
>>> tx-udp-segmentation to be enabled; tx-uso-zc only reports driver
>>> capability. In zero-copy mode, a packet may use at most
>>> xdp-zc-max-segs descriptors, and ice specifically allows at most eight
>>> buffers per output datagram, counting the copied header.
>>>
>>> The header validator works on a raw header copy instead of an skb, so
>>> that it can be shared by the skb and zero-copy paths. It lives in
>>> net/xdp/xsk_tx_uso.c and include/net/xsk_tx_uso.h. In zero-copy mode,
>>> ice copies the headers into kernel-owned memory before validating them
>>> and handing them to the NIC, while the payload stays in the UMEM. I
>>> tried finding an existing packet header validator that works on raw
>>> buffers that could be reused, but I could not find one. Therefore this
>>> small validator was added.
>>>
>>> Testing was done on an ice NIC in loopback mode with a USO selftest,
>>> in both copy and zero-copy mode. Patch 5 adds it as
>>> selftests/net/xsk_uso. It checks the segment count, lengths, checksums
>>> and payload of the received datagrams for IPv4 and IPv6, single and
>>> multi-buffer requests, and that invalid requests are rejected. Patch 4
>>> adds KUnit tests for the header validation helpers. Note that patch 5
>>> should really be integrated into either xskxceiver or Stan's
>>> xdp_hw_metadata tests. But as these are currently being modified to
>>> fit into selftests/net and maybe even merged, I kept the USO tests
>>> separate for now.
>>>
>>> The tables below show the UDP packet rate achieved by a single socket
>>> on my rather old 2.1 GHz Cascade Lake server with PCIe3, relative to
>>> no offloads at 1472 bytes. Each request carries a UDP payload that is
>>> segmented into 1472-byte datagrams, either in user space (no offloads,
>>> so UDP checksum is also performed in SW using the kernel's
>>> csum_partial() algorithm) or by the NIC (USO). The application and the
>>> queue's interrupt are pinned to the same core, and the socket is
>>> driven by preferred busy polling with napi_defer_hard_irqs=100 and
>>> gro_flush_timeout=2000000, so there are virtually no device
>>> interrupts. Each table's performance numbers are normalized to the
>>> performance for 1472 byte packets with no offloads in that table.
>>>
>>> SKB mode - write all packet data for each packet
>>>
>>> +---------------+-------------+---------------+
>>> | Payload bytes | No offloads | USO + HW csum |
>>> +---------------+-------------+---------------+
>>> |          1472 |       +0.0% |        +86.2% |
>>> |          4416 |       +2.2% |       +192.1% |
>>> |          7360 |       +2.6% |       +290.0% |
>>> |         10304 |       +2.4% |       +301.5% |
>>> |         13248 |       +2.4% |       +322.2% |
>>> |         16192 |       +2.1% |       +355.6% |
>>> +---------------+-------------+---------------+
>>>
>>> SKB mode - write only headers for each packet
>>>
>>> +---------------+-------------+---------------+
>>> | Payload bytes | No offloads | USO + HW csum |
>>> +---------------+-------------+---------------+
>>> |          1472 |       +0.0% |        +88.7% |
>>> |          4416 |       +2.3% |       +211.3% |
>>> |          7360 |       +2.5% |       +342.0% |
>>> |         10304 |       +2.6% |       +367.7% |
>>> |         13248 |       +2.8% |       +394.1% |
>>> |         16192 |       +2.8% |       +444.8% |
>>> +---------------+-------------+---------------+
>>>
>>> ZC mode - write all packet data for each packet
>>>
>>> +---------------+-------------+---------------+
>>> | Payload bytes | No offloads | USO + HW csum |
>>> +---------------+-------------+---------------+
>>> |          1472 |       +0.0% |       +185.6% |
>>> |          4416 |       +4.1% |       +279.6% |
>>> |          7360 |       +4.8% |       +332.1% |
>>> |         10304 |       +4.4% |       +325.5% |
>>> |         13248 |       +3.6% |       +333.4% |
>>> |         16192 |       +3.5% |       +339.1% |
>>> +---------------+-------------+---------------+
>>>
>>> ZC mode - write only headers for each packet
>>>
>>> +---------------+-------------+---------------+
>>> | Payload bytes | No offloads | USO + HW csum |
>>> +---------------+-------------+---------------+
>>> |          1472 |       +0.0% |       +163.9% |
>>> |          4416 |       +2.9% |       +260.0% |
>>> |          7360 |       +3.1% |       +291.9% |
>>> |         10304 |       +3.6% |       +303.9% |
>>> |         13248 |       +4.2% |       +307.6% |
>>> |         16192 |       +4.1% |       +315.8% |
>>> +---------------+-------------+---------------+
>>>
>>> At 1472 bytes the request fits in one datagram, so USO is not
>>> segmenting anything and the gain comes from the checksum offload
>>> alone. As soon as multiple UDP packets have to be produced on the
>>> wire, USO becomes really beneficial.
>>>
>>> For the zero-copy tests, my system seems to bottleneck at around 50
>>> Gbps (about 4 Mpps) with 7K payloads or above. The board only has x8
>>> lanes of PCIe3, though the slot is x16. In any case, there is a
>>> benefit to USO even on this system.
>>>
>>> Patch series:
>>> 1: Implements USO for skb path
>>> 2: Adds Tx descriptor builders and a header length check to ice
>>> 3: Implements USO for ice zero-copy driver
>>> 4: KUnit tests for the USO header helpers
>>> 5: selftests/net: AF_XDP USO functional test
>> You forgot to CC: netdev
> 
> Ha, that is what I get for being out of the game for a while! Should I
> send a v2 or just resend? Please advice.
It's not a big deal either way, but the ML has never seen the v1, so a
resend would be better, I think.

/P

