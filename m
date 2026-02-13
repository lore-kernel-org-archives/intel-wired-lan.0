Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9EEEDF174
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Feb 2026 15:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B742D41CDC;
	Fri, 13 Feb 2026 15:27:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZWZcNxXu2RF; Fri, 13 Feb 2026 15:27:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 752FE41CD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770996426;
	bh=sFkdSYU5SU7oDumKXqm7DY8TaWeqWXh8QYMNmFSOsOY=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VsAo8G24ekBnqiJQ2dKVlUew9tIma9LZqHHmBE86zY2sgL3fZNu/nDuqRZBwpTSrw
	 W/f98FubhiEE39JcgrN/aWt7xBwFKo7on/CdpZVcrMkx8VXr53sqaYn641nvOTpdjU
	 TWulvkkW7Xh3nA1F4zmX457NjuTqdinub0VAmWHAbR3HN7g4C6Qc0tb2ak7AHwsmP2
	 fDrwrw6ZcCsMsRAva0qXual6Di8rDubyxskRi3r1iQayYpqRCcIeFQxkqMK+MiYe+N
	 BB20XIndit02XkhTo/RfG+RaJeWCu0Y7Vxpt77pJrnGwBkUefKuXtEWzI3XgTGZX7o
	 V9yyGYkUIgpyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 752FE41CD7;
	Fri, 13 Feb 2026 15:27:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F850255
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60BD9611FB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxX9sskhz3Dk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Feb 2026 15:27:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=lorenzo@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 29C58607E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29C58607E0
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29C58607E0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:27:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E183B61334;
 Fri, 13 Feb 2026 15:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DA6C19425;
 Fri, 13 Feb 2026 15:26:59 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 13 Feb 2026 16:26:19 +0100
Message-Id: <20260213-bpf-xdp-meta-rxcksum-v2-0-a82c4802afbe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNTQ6CMBCG4auYrh0zrRapK+9hXJR2gAb5SYsNh
 nB3C4kLF8bl+yXzzMwCeUeBXXYz8xRdcH2XQux3zNS6qwicTc0EColKSCiGEiY7QEujBj+ZJjx
 bUIhZLkkoVJal08FT6aaNvd1T1y6MvX9tX6JY1z9gFICQFceSVH42pPi1Id/R49D7iq1i5B8lQ
 8Hxh8KTQtJKabRGefpWlmV5A5ggbkT/AAAA
X-Change-ID: 20250925-bpf-xdp-meta-rxcksum-900685e2909d
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.14.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770996420;
 bh=/B6JgBhqjAE9R1cCIB7J9fbNRvjvEZDD6CRvNZPox4s=;
 h=From:Subject:Date:To:Cc:From;
 b=UB3g8NdqdNaideuG+s8IqIlRFiOwNydc4FJi/QXG6Ltc56VT8nNDZpK9WP8HKoXFN
 UQfH7aDRVeJ8bac4XAd+hLrcLGXyOq0b6S3xtgJSveEKOE6Pl5oN/iAklcSUyCzOJ3
 WbI4BfMGA8MrgxRIghXSYkhX6CUZzmO62jTwSvTfKL7YtQ+q0JnuVhey/HuYP5Das/
 I+JTNW9cuOj0qbwGPBefrvCePe6GxUtZl2tJieQaLhK/FU9H5wiTOM4j5EGoL6gVRL
 /LWpgb+Qwvuw7gsoK0r5PWM0N3KgFTnttRi2Q+mKdfPuV/DayBb1cFPNkkCliEz3lO
 661LgQ4GITf3g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=UB3g8Ndq
Subject: [Intel-wired-lan] [PATCH bpf-next v2 0/5] Add the the capability to
 load HW RX checsum in eBPF programs
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

Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
RX cheksum results in the eBPF program binded to the NIC.
Implement xmo_rx_checksum callback for veth and ice drivers.

If the hardware detects a wrong/failed checksum, it will report
CHECKSUM_NONE in the packet metadata. Moreover, CHECKSUM_NONE will be
returned even if the NIC can't parse the packet (e.g. if it does not
support a specific protocol). A possible use case for
bpf_xdp_metadata_rx_checksum() would be to implement a XDP DDoS
application [1] combining the info from bpf_xdp_metadata_rx_checksum()
and bpf_xdp_metadata_rx_hash() kfuncs in order to filter packets with a
wrong/failed checksum.

[1] https://blog.cloudflare.com/unimog-cloudflares-edge-load-balancer/

---
Changes in v2:
- Remove XDP_CHECKSUM_PARTIAL definition
- Improve veth_xdp_rx_checksum() callback
- Fix uninitialized case for cksum_meta in ice_get_rx_csum()
- Fix sparse warnings in ice driver
- Fix typos
- Link to v1: https://lore.kernel.org/r/20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org

Changes in v1:
- Rebase on top of bpf-next
- Test ice driver using xdp_hw_metadata tool available in the bpf
  kernel selftest
- Improve cover letter with an use-case for
  bpf_xdp_metadata_rx_checksum()
- Link to RFC v2: https://lore.kernel.org/r/20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org

Changes in RFC v2:
- Squash patch 1/6 and 2/6
- Introduce enum xdp_checksum definitions
- Rework ice support to reuse ice_rx_csum codebase

---
Lorenzo Bianconi (5):
      netlink: specs: Add XDP RX checksum capability to XDP metadata specs
      net: veth: Add xmo_rx_checksum callback to veth driver
      net: ice: Add xmo_rx_checksum callback
      selftests/bpf: Add selftest support for bpf_xdp_metadata_rx_checksum
      selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog

 Documentation/netlink/specs/netdev.yaml            |   5 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      | 118 +++++++++++++--------
 drivers/net/veth.c                                 |  30 ++++++
 include/net/xdp.h                                  |  13 +++
 include/uapi/linux/netdev.h                        |   3 +
 net/core/xdp.c                                     |  28 +++++
 tools/include/uapi/linux/netdev.h                  |   3 +
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   6 ++
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   8 ++
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |   3 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  25 +++++
 tools/testing/selftests/bpf/xdp_metadata.h         |  12 +++
 12 files changed, 212 insertions(+), 42 deletions(-)
---
base-commit: 192c0159402e6bfbe13de6f8379546943297783d
change-id: 20250925-bpf-xdp-meta-rxcksum-900685e2909d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

