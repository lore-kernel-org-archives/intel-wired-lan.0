Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAEA606A321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Ooc1I3+R;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSZfoBMC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1E274095C;
	Fri, 27 Nov 2026 14:21:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HO9cMUBT5xnA; Fri, 27 Nov 2026 14:21:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22D9240A69
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795789306;
	b=cO7ob1CsGZIooHOb5utQPamMOWMx6Swbx27wGVulP1/Fr23v3c7AXkibGof0uUvvPff2
	 PSen6mAEqqpTHTUVGSzRcfn1UmwD9fabokUKxWjhnwuTXAYHGv3SaFNpUwHd2TXHx18G4
	 v/uUhxbQAsb4riloOiX5xSwx7gg1J+RTcFH9IviDAVU4ZqagaRFFTwfz3U4gfwoTqipyF
	 dxlPM75X5ii5sYzn8PoG/j97TIOCLMx98HV67oijO+/Dp15LiPIIilc/Rxm+SnBjITUtP
	 ByhxyvjOGp/SSaP5Jy5g9hDj5GPWqPkRs4H7Qr19F5+zKZvzfYqn8/zAwW+2UlHSCCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795789306;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HE7gEqGCw4EyFiuV8uGktoGe7HLL7Xdr4RQo2bxKmaU=;
	b=RiQ4NCJ4cyCyURphP9y78xOBbXtaUk2inbtqgTijWlu6aO0LO62Q1uBD7+x5sqLgbO4m
	 3NSWpW/xozvbAylrbPMF8m+FB6cX9GrcP7ALebLnWGmC8b9aQuJfzBpJcAwqArFoJCFJc
	 ZZDPilUVrE+ONpT8/Nk+eRh7hkM2NmDsAGZEDm2P25xTD3ggs+WxsFMlzZ3PPTrrixtPj
	 0VcTTpfy5ffw6eYJKcrHYuy3yTN4FOAuQHub2511L8Hub8JUjLQ6s20aGrEuPH+EOFlQm
	 pFUClllJA7GqOSLdtTzojy+r/hasgf8JYqPymwzdjXNxo4lyz4ok7Y3vQiaP/SwXmEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795789306;
	bh=HE7gEqGCw4EyFiuV8uGktoGe7HLL7Xdr4RQo2bxKmaU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ooc1I3+RNa+hXMKxw9yGmTtJXOEWQNIdy2ScyhOaurJs4T1Vw3Wal/JfVwXmRcpy2
	 zRbgjfIZzs9geG6kakvXFzawl6U7OCS3Y9vc0Za2QqJXcdTwOATAk7ud3oGAAgMk61
	 EUQ/DEKB+JGyrfZhKS0T0Iwh5ARzS8KdhG7k1XDh5PAEY+zws7R2mSBpei2lMmjvxs
	 V/vnAMypjjjI0WzvrCWNdOoHge6Cif/BRAynNN6IqXwHm3uqTMANgGMkJ27I4Hllrm
	 SC0cu9iKUi4B/TkmnBqj9jvxLoPsxUdAiMX8nt9oViDB9Bj15WInV9WMkKC/IcEYUl
	 66HAI/FyQM7MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22D9240A69;
	Fri, 27 Nov 2026 14:21:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AAF80D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9136C8121F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dm4_1_5a1YTn for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 14:21:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B73D0811F4
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=DSZfoBMC
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B73D0811F4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:21:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0CA14581C;
 Fri, 27 Nov 2026 14:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC91F000C1;
 Fri, 27 Nov 2026 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795789302;
 bh=HE7gEqGCw4EyFiuV8uGktoGe7HLL7Xdr4RQo2bxKmaU=;
 h=From:To:Cc:Subject:Date;
 b=DSZfoBMCSmtY1GfTC/aIsp071xWx6Mp0hDMLkQraEQDi8XJb1Dd9rqkypOU8L1psY
 eB/vAXVvxYh1jKxDT/9Viqq1QtP9B3iC1uSoeVW8JbqQrgdN88s6KprKBUH4Ghe6gx
 wqw9+rMaO8T2/38DOzym6kcukJMMMiz0vkyocUzAKxI4iCXlQgl/2oVSstArCKrqJu
 qayNzLkTUVxoSA7IdZXIinv836XVHWNwDFBu7pMC+749RSbQ3+KqIlMVcHAExQWYxa
 3YWSAnVYjz8+U+KvJz1JwGKBzqyEsNoWS3dUTHyHkepJH25gf9HhnzboSb0zrqsUAd
 IeL4x1WxCS2kQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Colin Ian King <colin.i.king@gmail.com>, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/3] xsk: Keep the shared info of zero-copy buffers in
 kernel memory
Date: Fri, 27 Nov 2026 15:21:26 +0100
Message-ID: <20261127142131.3527737-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A packet that AF_XDP receives in zero-copy mode over several buffers
keeps its shared info, the fragment list and its count, in the UMEM,
which userspace can write while the kernel uses it. A rewritten list
or count makes the kernel read and write out of bounds.

Patch 2 moves the shared info into the buffer pool and lets the device
write up to the end of each chunk. Patch 1 makes libeth count XSk
XDP_TX buffers one by one, as it read the shared info at a later bulk
flush. Patch 3 updates the xsk selftests.

Sashiko found this in its review of the AF_XDP device buffer layout
series [1].

I tested this on mlx5 hardware, and on igb and veth in QEMU. None of
them receives multi-buffer packets in zero copy, so i40e, ice and
idpf, which do, are only build-tested. Intel folks, could you run your
multi-buffer zero-copy tests on them?

Also for Intel, found while auditing the drivers and not touched here:
ice no longer sizes its zero-copy RX buffers from the XSK pool. Commit
3a4f419f7509 ("ice: drop page splitting and recycling") programmed a
fixed 3072 bytes, and 93f53db9f9dc ("ice: switch to Page Pool")
changed ice_setup_rx_ctx() to use ring->rx_buf_len, which only the
page pool path sets. An XSK ring gets the length of its last page pool
setup, 3456 bytes on 4K pages, or 0 if it never had one. With 2K
chunks the device can write past the chunk into the next one. I found
this by reading the code and did not test it.

[1] https://lore.kernel.org/netdev/179561567996.3135.9952128421877275714@kernel.org/

Björn Töpel (3):
  libeth: xsk: Count each XDP_TX buffer on its own
  xsk: Keep the shared info of zero-copy buffers in kernel memory
  selftests/bpf: Drop the zero-copy tailroom from the xsk tests

 include/net/libeth/tx.h                       |  3 +-
 include/net/libeth/xdp.h                      |  9 +++++-
 include/net/libeth/xsk.h                      |  6 ++--
 include/net/xdp.h                             | 32 +++++++++++++++----
 include/net/xdp_sock_drv.h                    | 29 ++++++-----------
 include/net/xsk_buff_pool.h                   |  2 ++
 net/xdp/xdp_umem.c                            |  3 +-
 net/xdp/xsk_buff_pool.c                       | 17 +++++-----
 .../selftests/bpf/prog_tests/test_xsk.c       | 10 +++---
 .../selftests/bpf/prog_tests/test_xsk.h       |  2 --
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 13 +-------
 tools/testing/selftests/bpf/xskxceiver.c      | 15 +--------
 12 files changed, 67 insertions(+), 74 deletions(-)


base-commit: 28a371228d4eb4857cc31eeb1a0d7d01e9c3ea2f
-- 
2.56.1

