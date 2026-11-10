Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E8606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=WPuoWIQI;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=W4Ecy/As
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8926E811C8;
	Tue, 10 Nov 2026 16:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kEIeNJY2u_r; Tue, 10 Nov 2026 16:51:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7643581192
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329469;
	b=ZtOArC+zN/85aamI+wLUbc3Dy22itGv9d6OpvZQMnquA0BFgsEdOuaKjExm4HRwbeK8P
	 VRBfmH4nuWeWiOxxkeY8O5u4E0F3ZK6fJ9dOXGj/s4Ow9pfQU17ma4xE5A2fXov8e9xba
	 yTlDG+eGA/AxqtLKPpq8EogCIQCrfnzPwC2DIB6mJIcBtXrvVAtQy2jelTlfhQwGIPjp4
	 oDEEeOLNhBlFODbItt++gCmDNueB+bT43H6nIxByGb/BHEHUowbVTwmL1OTFRw41JsqjO
	 eOiScAgExdatbMLYES/qwKh85CqOzaDb9Rmf2rv8M70xaUIABiiUkY2il4aU4E7BQAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eceI8dL07kv9yfwsc+DTSqIVxIuF3lFqQT3hh7B4xzA=;
	b=AnpUUzdnInszSy4eSb4xSsfVsRV1ZcpNQir90r9R/MGJYXvMANNCKAGXrIa1w5kakEPE
	 MqzedvUVNMq9xVnWL8/OqnDai35no3khbero3ygXAKcHZsZVM7A7oaCCwePBRcjo+doTL
	 LyYbO0UxjHHmwMnC5WmUocp906MTY/rdxlNxLP80X2riowjJ6lUlqi7XD/YRRill+WGCQ
	 M8CfvEe4Mx7aZYZSecFOQb3U6TavM/szl/yuygV95Nak103qYf7Xc4Utrr3YsPcNe0CRZ
	 9Hdetr4jJ0jIPecchX/04D7rv4dy/Kk1Y5ByE56kLDZH4REAZl/8Ofl1NqCQP3qrXTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329469;
	bh=eceI8dL07kv9yfwsc+DTSqIVxIuF3lFqQT3hh7B4xzA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WPuoWIQIQQRdY7O8sxahqJFl4fVwgK3fjS7UY8ih9aw+Z+p8NMuud95Np26SyxXor
	 zsUu91mJ9bihoRiQwf++UkcofQONIn7odND9e4/yUvSHwwqw1ZqLxVkSxHSSNEncqo
	 6fGCEswyQaMehz3KIhphsAP97BonNAwk3F9wa6bGQjDmX1x+//vVzh8SueZ1EpabEq
	 2I6M7UxtmwYs61yo0wIWkOp8P7eP63W4Sf0ja9UpCi0W0LlvXTbnz+CEtJPsf+xbMk
	 Xf+CcqGZljOAnvGRuGWIZ6QiAh/fsES54Xnb+jAEJAbmQfwbp7s7Zl0hbh5s8i3SQX
	 nTUEzfmstCcZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7643581192;
	Tue, 10 Nov 2026 16:51:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7971335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD19E4031B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZsWh2BSn_-l for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:57:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 20B1940061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=W4Ecy/As
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20B1940061
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:21 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b5669a5100so2126880a12.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283040; x=1794887840;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eceI8dL07kv9yfwsc+DTSqIVxIuF3lFqQT3hh7B4xzA=;
 b=W4Ecy/AsHOGkFrte8QoS5ELqBlTVjjN9QbXNvg/k6wfYKei3MA+iqhT6E2s5ZEFrND
 0vL5ZzfeMVmlXPySssreAbLVd1r7PbpWyWAZq1eHYLqKg2JogMszaUTs/G/+ggZ6s9Y5
 AY8MoVZcZoxqcsKldYzZaZPOgn6YKH/ioP5FqtGnNV8bqbVJvQv//9Lsl5Y/HK5SqAJP
 HousI1/RabYS0RsBbHFGMGc4cewYBcQO8fN0uLgqraLHi46k3d3BOGt8d6msucDnse0y
 BKjqSNPxfPJ/pWTpCst9fthqvMwGlF/Irv/xAFh+/mIa7nxvm40QFhQBkOvEZjUIw4X3
 b7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283040; x=1794887840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eceI8dL07kv9yfwsc+DTSqIVxIuF3lFqQT3hh7B4xzA=;
 b=LZ6rOal0LcwRzskujRUwVG4RFi8re6fOkTjsNWhR9tu3ecCleuDOSk2g/hSPUH8Rvc
 RIGNC0zMkMxXjqE865SlrdU/qgvwvZlMvhMbSBJFSzcENLdBNn8TPVozE/u47G4q03ok
 SKrXlxztVpRM+C6wJlxA3QF4XIq4L229NsLNIfnnjz/0IwpacbGPndj7Er3ToaWpAS2H
 OBvT2AkSm1CasX1cUIOpoSJLjWlvwAMgyx2ZoEtAmSHCDaWfYxhyLfwjkqhCVZYcs1a+
 lrg4mp4R9PiRR2Qshmx/1DsfwBGhwjW4n8vQM9chX/rz1/t9WyZ1hDj1a0DZnIo+i4uq
 b53w==
X-Forwarded-Encrypted: i=1;
 AL+hErFto7dzeKlwrr5Q8UuMGX6MnPwF3ib35vOwgn4Ymu8jwMnEeM9UgBZlGzDo91cni3t30Mz+LCwur1/DOq9E0Jk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+qMQlz1X0kkopqPo8euGrF7L3/OIMC/tAdRmh/T5z7rMeqS59Z
 L4ImKOPkeys2yfz7l+WYoiJATgU2d0Ghr/Gp3IjhPU7v1u9d60H1Nsa4KI3jw3iFajs=
X-Gm-Gg: AYBFou0Cgc8gFO+bQ12Y6kH3uA546Q/MQLV3JAfH0Ex3Q32dswU7fNZQV5G2PBRBxg+
 67LFoWgXGLEq94ysXBpZqegK8a2crb/szv2lw8DGTW3vtK56d4nf8CfmkJxZevdOx/+JURWsHJH
 FDacA4Qm6AQGqN8x/kn3T8jYIrGGhEiQ8+Kup+NjGcFkoPA20E2E0Fwbd9s0bMDMJc7I3s/pBPN
 tKxypOFtnLZaMV1iO5qCP96Z9zfqj8T5BuVQVbHlCQsyjFSc1DZcQNlqNACnyNepKYArKxC499S
 u20ZSjZSV56XFuHKkp+5JL1qOJxOu0bufcy4dkHv7n11kCaUVF5Zmj3OrxjDT6LbJkljf8lTbIl
 cV/VKczHxsnO/b4BGEUa+4SFn6HJSc7t8c2xjhdvPpKx09of9Le8os3T8hUBnjHzLve4CM/ShKL
 lCVfvXMr6bdBMhKuze8bt3oe0yw5l5WV2XwIRYP8fTkm+nrvPB8tMJpQlxJ509+v9zXr3hzuLFZ
 cL+wVbW9wSsXa1RDThSq8a7x09bZQ2u2zcyJTvwt8faIbkHWmjJdWbHdy3DZr8W9ds9oSbxbwBh
 UlMGSGkB6Pb4P1Nhl/q+HSBkcYkfkaJAC6XUxEAlBZMqeRhf2ibm87pFWRZzw+RF
X-Received: by 2002:a05:6402:205b:b0:6b7:1d62:3916 with SMTP id
 4fb4d7f45d1cf-6b755626b9dmr778195a12.0.1794283039727; 
 Mon, 09 Nov 2026 19:57:19 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:57:18 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vladimir Vdovin <deliran@verdict.gg>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Donald Hunter <donald.hunter@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Chris J Arges <carges@cloudflare.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 llvm@lists.linux.dev, kernel-team@cloudflare.com,
 Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
Date: Tue, 10 Nov 2026 03:56:58 +0000
Message-ID: <cover.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 16:51:07 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An skb gets its RX hash, VLAN tag and checksum status from the RX
descriptor, which describes the packet before the XDP program ran.

Without this series:

- On XDP_PASS, the values are stale. After the program strips a UDP
  tunnel header, the stack applies the outer CHECKSUM_UNNECESSARY to the
  inner packet [1]. If the outer UDP checksum is 0, a packet with a bad
  inner checksum reaches the socket.
- On XDP_REDIRECT, the values are lost. The skb that cpumap or veth
  builds from the xdp_frame has no RX hash and no VLAN tag, and its
  checksum status is CHECKSUM_NONE.

In one use case, an XDP program redirects packets into a veth device.
The checksum status is lost, so GRO verifies every checksum in software.
With one TCP flow, this costs 34% of the receiving CPU.

Another use case [2] is load balancing IPsec tunnel traffic with cpumap.
Without the RX hash, GRO on cpumap puts all flows into the same bucket.
In a cpumap test with 16 TCP flows and no IPsec, the throughput is
17.6 Gbit/s instead of 23.4.

This series introduces SKB core extensions for XDP. It reserves an skb
core extension area in the headroom, right after the space for struct
xdp_frame. An XDP program stores RX metadata in the area with kfuncs,
and the kernel sets the skb fields from it. This design was initially
proposed in [3].

The layout of the area follows skb extensions (struct skb_ext). A small
header gives the offset of each entry. An entry takes headroom only when
the program stores it, so the area does not grow with each new type of
RX metadata, unlike [4]. Unlike skb_ext, the area needs no allocation.

This series supports three types of RX metadata. Each type has a store
kfunc, and bpf_xdp_skb_ext_del() deletes an entry:

- The RX hash and its type: bpf_xdp_skb_ext_store_rx_hash().
- The VLAN tag and its protocol: bpf_xdp_skb_ext_store_rx_vlan().
- The checksum status: bpf_xdp_skb_ext_store_rx_csum(). Only
  XDP_CHECKSUM_NONE, or XDP_CHECKSUM_UNNECESSARY with a csum_level up to
  SKB_MAX_CSUM_LEVEL, are allowed [5][6].

The kernel sets the skb fields from the area:

- After XDP_REDIRECT, in __xdp_build_skb_from_frame().
- On XDP_PASS, in the NIC driver. A driver that does this sets the new
  XDP feature skb-ext-pass. On other native XDP drivers, the kernel
  warns once when the program returns XDP_PASS with stored values, and
  ignores the area. This series adds the support to ice.

The existing XDP RX metadata kfuncs are bpf_xdp_metadata_rx_*(). Only
a device-bound program can call them. Programs on cpumap and devmap are
not device-bound, so they cannot call them. Relaxing this check would
change their semantics. So this series adds three load kfuncs,
bpf_xdp_skb_ext_load_rx_*(). They read the stored values.

bpf_xdp_adjust_head(), bpf_xdp_adjust_meta() and bpf_xdp_pull_data() do
not move the packet or the metadata into the area. In this series, the
area takes at most 20 bytes of headroom. With the hardware RX timestamp,
the RX queue index and CHECKSUM_COMPLETE, it would take up to 40 bytes.

Lorenzo's RX checksum kfunc series v5 [7] also defines enum
xdp_checksum. The series that is merged second drops its copy.

Performance:

We measured on ice (E810, 25 Gbit/s) with bpf-next 0fb18ce8a2e9, patches
1-3 of [7] and this series. In the RX metadata column, the XDP program
reads a value with bpf_xdp_metadata_rx_*() and stores it. The veth test
stores the checksum status, and the cpumap test stores the RX hash. The
kernel then sets the value on the skb. Baseline does not store it. Each
value is the median of 5 rounds:

test                  metric          baseline     RX metadata
veth, 1 TCP flow      RX CPU busy     100%         66% (-34%)
veth, 1 TCP flow      RX cycles/pkt   2027         1343 (-34%)
cpumap, 16 TCP flows  throughput      17.6 Gbit/s  23.4 (+33%)
cpumap, 16 TCP flows  pkts/GRO skb    3.4          7.5 (+122%)

Both veth columns reach line rate, so the gain is in CPU time. A store
kfunc takes 2.9 to 4.9 ns. Details are in [8].

Not in this series:

- XDP_PASS support in mlx5 and bnxt. To align with Lorenzo's series [7],
  we plan to add xmo_rx_checksum and XDP_PASS support to them together,
  one driver at a time.
- AF_XDP zero-copy. User space can write the headroom of zero-copy
  buffers, so the store kfuncs return -EOPNOTSUPP there.
- Packets that enter XDP as an skb and leave it as an skb. This happens
  in generic XDP, and on XDP_PASS in veth when its peer sends it an skb.
  The series only sets the stored values on an skb that the kernel
  builds from an xdp_buff or an xdp_frame.
- Stored entries on frames that dpaa and dpaa2 redirect. These drivers
  move data_hard_start before XDP_REDIRECT, so patch 2 clears the flag
  of the area.

[1] https://lore.kernel.org/all/20260227153231.78d16b69@kernel.org/
[2] https://lore.kernel.org/all/ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org/
[3] https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kernel.org/
[4] https://lore.kernel.org/all/175146824674.1421237.18351246421763677468.stgit@firesoul/
[5] https://lore.kernel.org/all/20260722113525.34092660@kernel.org/
[6] https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/
[7] https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/
[8] https://github.com/tgao-cf/skb-core-extensions-bench

Tianyi Gao (15):
  xdp: reserve an skb core extension area after the xdp_frame
  net: dpaa, dpaa2: clear the skb core extension flag
  xdp: add kfuncs to store RX hash and VLAN tag
  xdp: add a kfunc to delete skb core extension entries
  xdp: add a kfunc to store the RX checksum status
  selftests/bpf: Test the skb core extension kfuncs
  xdp: set skb RX metadata from the skb core extension area of xdp_frame
  selftests/bpf: Test RX metadata on skbs built from xdp_frames
  xdp: add the skb-ext-pass XDP feature and warn without it
  xdp: warn on XDP_PASS with stored values when XDP runs on an skb
  ice: set skb RX metadata from the skb core extension area of xdp_buff
  selftests: drv-net: xdp: test the stored RX metadata on XDP_PASS
  xdp: add kfuncs to load the stored RX metadata
  selftests/bpf: Test the load kfuncs on cpumap and veth
  docs: net: document the skb core extension area

 Documentation/netlink/specs/netdev.yaml       |   5 +
 Documentation/networking/xdp-rx-metadata.rst  | 127 +++++-
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |   2 +
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   3 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   3 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   7 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   3 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 drivers/net/veth.c                            |   5 +-
 include/net/xdp.h                             |  74 +++
 include/uapi/linux/netdev.h                   |   6 +-
 net/bpf/test_run.c                            |   4 +-
 net/core/dev.c                                |   2 +
 net/core/filter.c                             |   8 +-
 net/core/xdp.c                                | 428 +++++++++++++++++-
 tools/include/uapi/linux/netdev.h             |   6 +-
 .../selftests/bpf/prog_tests/test_xsk.c       |  25 +
 .../selftests/bpf/prog_tests/test_xsk.h       |   2 +
 .../selftests/bpf/prog_tests/xdp_bonding.c    |   8 +-
 .../bpf/prog_tests/xdp_do_redirect.c          |   8 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  |  12 +-
 .../selftests/bpf/prog_tests/xdp_skb_ext.c    | 375 +++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |   7 +
 .../selftests/bpf/progs/test_xdp_skb_ext.c    | 173 +++++++
 .../selftests/bpf/progs/xdp_skb_ext_failure.c |  16 +
 .../selftests/bpf/progs/xdp_skb_ext_success.c | 245 ++++++++++
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  13 +
 tools/testing/selftests/bpf/xdp_skb_ext.h     |  53 +++
 .../drivers/net/hw/lib/py/__init__.py         |   3 +-
 .../selftests/drivers/net/hw/xdp_metadata.py  | 118 ++++-
 .../drivers/net/hw/xdp_skb_ext.bpf.c          | 166 +++++++
 33 files changed, 1873 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_skb_ext_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_skb_ext_success.c
 create mode 100644 tools/testing/selftests/bpf/xdp_skb_ext.h
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_skb_ext.bpf.c


base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
-- 
2.56.0

