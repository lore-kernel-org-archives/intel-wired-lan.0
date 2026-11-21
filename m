Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFD606A6A3
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Nov 2026 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=v2QlWKhQ;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UGUkoaXK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51EA140E30;
	Sat, 21 Nov 2026 01:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lf-_WPtPvKqU; Sat, 21 Nov 2026 01:24:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C27F40E32
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795224252;
	b=soC+0zs+vfd1XPzqXfh/09QML4YKa64EnQZ8Jyvu8bWO13seZZQlHTgm4YIK68DGc5qa
	 gM4fi1IAjTiByxHbGPjYk7XuFmwwbP/r9UdOfPZ94f5iu5W9DW0jYOUecwK84apduYy51
	 RkeX3NkOuWEHIdw7uwpsFlxTUS0IRBXltNOPp6kRREXXAbbpCb5+fPbbE+QesZi/RzoCE
	 22V1jvcvrnS0s+IXt84/24r5zJg7m9Yd4S9YUie6htiNPA7tj0vhRNeynEb7tuoKw1DTS
	 WyEa7JKnUQf9br/pPHxHfuXdeYBgrVgo6DUasD8cR9xN2hr/6MOjGk6N0UGkJDwYEbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795224252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CgSRkrT3C0ViBLHE9DlJxbToE1aRxdogX3+8Kv7zlYY=;
	b=FUP2TAgxViQDsTbiMiWAQm+ioOYMh8iytBUnENL9yo+2AJNJHZA4zEFM3rEN3klUyNiz
	 RE+Ac+g2MOXlXqsl9dujef8LmOBMuKocwOa7MkgrwDFk8RIIFZBzTELBsc2ZSOZ3NMhGL
	 PWGiMmV8P0dS+XNNaYNCvKDlt8YjxqGdRhuIrJOmf8aFNr3kJq6o0Tdalkj8GLwYeL2rT
	 27FCnb8LyuttiRKfIJGJSiflJzEF5Zr4fRhDSg5QxrD4xG0+urJP5Jhy5r177p3oVn+s6
	 5b6PzE3qfFuChp2oTeywICW5kpq+FuvrUn3zqVX4AHjXyr74yzkvH7Te/3nyj79zNiA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UGUkoaXK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795224252;
	bh=CgSRkrT3C0ViBLHE9DlJxbToE1aRxdogX3+8Kv7zlYY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v2QlWKhQY784QpzNTIMe/EFQojos8mdJzhu9bCTn+W51UBN0uhVPfHiHOIK0IL4WJ
	 aWtR2TZtZe6gm1oGXA9LTd67scfc6AyRfv0Wzo8SQ2yyRH8s5JVz+RtUuFIQEIiF2g
	 5aE7sIhFEmQD//2XU2dmD4+Mj33a7aB49cxRs7xeY/vcqnZYhEMPOMmXVfdotleDdl
	 23iFnIf5Tb9A9uYZGixJlH92P3xyaixWy4eTVXjzpi6Shr3GO3u8WU8y1GTrsfQvIa
	 azNBC2+x60P6fSNgdfxZl/R44w6HDs44zAMZsK6zdxpbAtXzYJ2irVdzvNF6HVAXSa
	 6IAizAkpn0k2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C27F40E32;
	Sat, 21 Nov 2026 01:24:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0132A971
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 01:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB21740E32
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 01:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zIYTaCnGa9TQ for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 01:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E75F40E30
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=UGUkoaXK
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E75F40E30
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 01:24:08 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c5133831027so226506766b.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 17:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795224247; x=1795829047;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CgSRkrT3C0ViBLHE9DlJxbToE1aRxdogX3+8Kv7zlYY=;
 b=UGUkoaXKFWHnF3ATFDwvEGexa9K3BUUfRL9wJX6MAbwpaecRTnUKEGX5Aedf8wgd7u
 EY/emiGzIpPDGPowWN3p+fkDkC+2Lp1BeFiDRey85akQULVyo7deL4u/V8cxJM3WhLGa
 Usrb6NwJdbARRY6umt+KmCcYaFaAqHH3rX/pzIwjx/2OxrWd8hMGiSjIgz4yVDD6Z0t0
 Da09CLBdYt6IanJcX4Zz3nxAZzi4xicgeWUuiepywzifci6x2wwCfyknR8GDot9se4hk
 ROZi7xtM6+Ml914rn6fzckFZhSuBiSnsJty2Hd7oOXFi//vio367ixMXEO0riSDInKJh
 DDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795224247; x=1795829047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CgSRkrT3C0ViBLHE9DlJxbToE1aRxdogX3+8Kv7zlYY=;
 b=JlI4Gvr1I2SyTTtI3bY32HxQ32uIobHci/QaupQAms7d53Kx9nLiXD/D0Vsyq8qmcB
 0w+Ddmt8b6q3Ch13tF2cXg7TFxC678E+rwJHJbyT793olMoDnoLJI8sUQVEuBU5BSU+D
 tAsULmsKnY/KeCbpKlIWLTvbn4q42qhZTnIOru5SFmjMUL2Y05wFQ5sXWjOcFBGpBS/Z
 bytvjhOMeP4yKEZ6UmLe3MI6KZEuA02hcOAR5EUd7PZQKBmwDvN06H9zD6theui5KBHS
 xIISPz1v/ka6xAbyUHFgmLMC50OsDM36rdT+Cyiax1cL/D2HpqTJrnNCMQgxu3pRGhFD
 Cr1g==
X-Forwarded-Encrypted: i=1;
 AL+hErG+vfU0DZhgp4B2EgivSWXq8sB5a8eT43QR24PCmh2DfEqq8hoMZB+e8xbrOHAZI5H3/b/d7JiuRejd0oeWfds=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+FZYUSr91a3Q/UNL0/OeBAP6g5QfpO4fznfXZB1GdEkYoV3p2L
 n9+jF/lse8WMaE0MmMo+xnnsjmrWjdff3gqhSz5GS2tapGinTt7wwJi9CAxmYfvWxAg=
X-Gm-Gg: AYBFou1k1qfBmPfwZBec+NZqxejwyScK7zUh7DbupeFYp9nzscqzky+9vLLIv5+i/3L
 j73jQvdUFL30w45aYbCB5BwtrDRwUXoZq1WfLdUD6BXwmyPhGWmIeoPclgkvb6kor1HmdJsZq9X
 Qb6mNZsBNNBqXRXmDWJ4q5114TbP257PkNwGRbvBa4+C+JCezoH6sZxh7claY8jel6ldJP85lJL
 F1VkryTxBKT4ccLfqDzw3DdWVlH/YQgeU9oOJ5mlB/7D/vfzx3GVj6bKg56fm2k6bt9+CQFpcCF
 JufsSwarq0OaXJCe8bLfCKXbXD854NT8zi2O+iaDZXcI1x5Nl4ayggHal4P4BJouhlYOQahLKLY
 FDKzR7Rn3YBiEb+O+OFm4CwkaI4WzPVSIvHklEqIhz22zVET/XXuzAqeuQS6mDM6a6hhawqhLqf
 lDejp6s/T6DMa1JpCh7tqBR9+Qc1GolX61exDaPP1+vU0Z7UR4OqFd3PsZJYG4mJmgOKGiF86pK
 TfxlgMqJYGzBybWaexOep5sY8VqihKi+EaHX4sxriQ3/N3vCQ0oTCt1ldcUPa7g9s8gLMYGw++N
 dWsHDJVt5BPpK6QAwUNSp4JnqOw98Mol1YnicJ/vWFo9PUhwPxhauYnU/w==
X-Received: by 2002:a17:906:7944:b0:c50:564b:c63 with SMTP id
 a640c23a62f3a-c513a43559cmr500636266b.6.1795224246891; 
 Fri, 20 Nov 2026 17:24:06 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6872asm143855266b.13.2026.11.20.17.24.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 17:24:05 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>,
 Eric Joyner <eric.joyner@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev,
 Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP program
 is attached
Date: Sat, 21 Nov 2026 01:24:02 +0000
Message-ID: <20261121012402.84848-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
that the hardware computes over the received frame. If an XDP program
changes the packet and returns XDP_PASS, that checksum no longer
matches. The stack then checks the packet again in software and calls
netdev_rx_csum_fault().

On Cloudflare servers, an XDP load balancer removes the encapsulation
of the packets that it accepts locally. Our production traffic hits
netdev_rx_csum_fault() all the time.

Do not use GCS when the ring has an XDP program, as mlx5 has done since
commit 5d0bb3bac4b9 ("net/mlx5e: XDP, Avoid checksum complete when XDP
prog is loaded").

E830 also sets the L3L4P and checksum error bits, so the packet gets
CHECKSUM_UNNECESSARY or CHECKSUM_NONE, as on E810. For example, a zero
UDP checksum over IPv6 is marked as bad and gets CHECKSUM_NONE. A zero
UDP checksum over IPv4 gets CHECKSUM_UNNECESSARY.

Two pending series [1][2] give XDP access to the checksum status.
Neither of them supports CHECKSUM_COMPLETE.

ice_rx_csum() reads rx_ring->xdp_prog again after the poll loop ran XDP.
While ICE_VSI_REBUILD_PENDING is set, ice_xdp_setup_prog() can replace
the program without stopping NAPI, so the two reads can differ. At
worst, a packet in that poll gets CHECKSUM_COMPLETE as before this
patch. The pointer is only compared with NULL, so this cannot crash.

Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/ [1]
Link: https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/ [2]
Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
Suggested-by: Jesse Brandeburg <jbrandeb@kernel.org>
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
Tested on an E830 (8086:12d2, board N31483-007, fw.mgmt 7.9.5, DDP ICE
COMMS 1.3.63.0) with an XDP program that removes a UDP encapsulation
header with bpf_xdp_adjust_head() and returns XDP_PASS. The kernel was
based on 6.18.64, where ice_rx_csum() is the same as in net:

- Before: 63322069 netdev_rx_csum_fault() calls in 30 s.
- After: 0.
- Without an XDP program, the port still reports CHECKSUM_COMPLETE.

On an E810, which has no GCS, drivers/net/xdp.py, ping.py and
hw/csum.py give the same results with and without this patch.

Request for comment: I also prepared a drv-net selftest for net-next.
It removes 16 bytes from the UDP payload with bpf_xdp_adjust_head()
and fails if the packet reaches the stack with CHECKSUM_COMPLETE. I am
not sure we want to enforce this for all NICs, so asking here.

 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..ad22d855436e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -123,6 +123,7 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
 
 	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
+	    !READ_ONCE(ring->xdp_prog) &&
 	    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
 	    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
 	     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||

base-commit: 92e97d7cffc7ec6adfa4699203c18b1ab0c8b314
-- 
2.56.0

