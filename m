Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8654C44507
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 21:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CF04404C0;
	Wed, 15 Jul 2026 21:41:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hljq5QHsP6Zs; Wed, 15 Jul 2026 21:41:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68B6C404E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784151663;
	bh=beMvsMOYV/35qvC4uNSHGPgxhMwJhGYCp9bcZZ4egZU=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ij/g3Ixutioyn3MS6/834A/mi/IVKa4fO8yFTKX6MtaClaum+FOAA2DKYdbkN6E87
	 V0x33l/p/Vj96+r7JRbSfCjKbQtO4yl9Dw2lhB8YgvEvIFun37/BrYJZff22EO5/y7
	 /HPVn2J+e3GoYUWDbbBJdyPWtiSjNyNHOQTndWdO2aC6B7wd5gTOyNXdG/v81kfFgo
	 /J2JrYv9ra9nIHZ9j1SdmtzZy0E8ta1V1kkfePhi+QEZEN7KdIX/YRYD2QoAW2g2UY
	 OJqOlkfvtG2OJuxM8CCxwdgHz1f/4pczuvNlD6RDML/ur/n32mje4XryY3YyItJTKq
	 OgKH0sghzloaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68B6C404E8;
	Wed, 15 Jul 2026 21:41:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F316E203
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8CF76069A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sl4swyn0tGkp for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 21:41:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=lorenzo@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E0615605EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0615605EF
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0615605EF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 442716001A;
 Wed, 15 Jul 2026 21:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4766E1F000E9;
 Wed, 15 Jul 2026 21:40:58 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:40 +0200
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OwW6DMAyA4Vepcm4mx8FAetp7TD2EYErUFlBCE
 VPFuy8gTeo00aNl/Z/9FJGD5yhOh6cIPPno+y4NdDwI19ruwtLXaRYISGCQZDU0cq4HeefRyjC
 7a3zcpQHIS2I0YGqR0iFw4+eN/RJr0fE8inPatD6Offje7k247d/TE0qQeaUbNmXh2KjPK4eOb
 x99uKynUp0DKv2mtiW6rAS0TcWv9frPpH5/WBXYUVRSmGoiZy1Qpv4p+lUpdhSdFA2AmSOobPF
 XWZblBz8K4ZaNAQAA
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
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784151659;
 bh=beMvsMOYV/35qvC4uNSHGPgxhMwJhGYCp9bcZZ4egZU=;
 h=From:Subject:Date:To:Cc;
 b=nM5Zby8IovOatbyak1vT2rmYnjz/8yyWs1oXOT7zbxv73sEFKBa+H1gPrkdx28+Sp
 YIkDERxUSsq/tnZdjX26mEfidhyzojKK+6E30lHjgbgGLqgOC4/kesGpjK0JvjGvUu
 fAbuzIjtoqila0/bQ0TSJDHKaZVZSGtWzKJGd9QHLLAFBvL3a9E67R46fM8IfnbflT
 lRtufK5+UzisSaPAOaCniTW3Srnfl1E0I5dJI3JuY7yLBupLyNxWEo6JbD0fGkqzDE
 4b33R+4uxrTZ2x9p3sT93WkehSHfqZn7dyShngFIDD1lk0XUgrWJe4hAjd0dt2aJZx
 4YTUlJfbieWCA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nM5Zby8I
Subject: [Intel-wired-lan] [PATCH bpf-next v5 0/8] Add the the capability to
 load HW RX checksum in eBPF programs
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
RX checksum results in the eBPF program binded to the NIC.
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
Changes in v5:
- Add new kfunc to Documentation/networking/xdp-rx-metadata.rst
  documentation
- Introduce bpf_skb_rx_checksum kfunc and related selftest.
- Introduce selftest to check the driver invalidates the rx checksum if
  running in XDP mode.

Changes in v4:
- Report cusm and csum_level separately and convert ip_summed to a
  bitmask in bpf_xdp_metadata_rx_hash()
- Fix endianness issue in bpf selftests
- Add a comment about the driver expected behaviour if the the NIC reports
  CHECKSUM_UNNECESSARY or CHECKSUM_COMPLETE and the eBPF program modifes
  the packet
- Introduce bpf_get_skb_cksum kfunc and related selftest to load the
  checksum result to the SCHED_CLS eBPF program attached to the qdisc.
- Link to v3: https://lore.kernel.org/r/20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org

Changes in v3:
- Remoe leftover assignment from v2 in veth_xdp_rx_checksum()
- Fix typos
- Fix commit logs
- Link to v2: https://lore.kernel.org/r/20260213-bpf-xdp-meta-rxcksum-v2-0-a82c4802afbe@kernel.org

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
Lorenzo Bianconi (8):
      netlink: specs: add XDP RX checksum capability to XDP metadata specs
      net: veth: add xmo_rx_checksum callback to veth driver
      net: ice: add xmo_rx_checksum callback
      selftests/bpf: add selftest support for bpf_xdp_metadata_rx_checksum
      selftests/bpf: add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
      net: add bpf_skb_rx_checksum kfunc to read skb checksum metadata
      selftests/bpf: Add test for bpf_skb_rx_checksum kfunc
      selftests: net: add test for XDP_PASS skb checksum invalidation

 Documentation/netlink/specs/netdev.yaml            |   5 +
 Documentation/networking/xdp-rx-metadata.rst       |   8 ++
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      | 123 ++++++++++++++-------
 drivers/net/veth.c                                 |  32 ++++++
 include/net/xdp.h                                  |  13 +++
 include/uapi/linux/netdev.h                        |   3 +
 net/core/filter.c                                  |  31 ++++++
 net/core/xdp.c                                     |  32 ++++++
 tools/include/uapi/linux/netdev.h                  |   3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   8 ++
 .../selftests/bpf/prog_tests/skb_rx_checksum.c     |  50 +++++++++
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   9 ++
 .../testing/selftests/bpf/progs/skb_rx_checksum.c  |  33 ++++++
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   7 ++
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |   2 +
 tools/testing/selftests/bpf/skb_rx_checksum.h      |   8 ++
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  31 ++++++
 tools/testing/selftests/bpf/xdp_metadata.h         |  13 +++
 .../selftests/drivers/net/hw/xdp_metadata.py       |  55 ++++++++-
 .../selftests/net/lib/skb_metadata_csum.bpf.c      |  73 ++++++++++++
 20 files changed, 496 insertions(+), 43 deletions(-)
---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20250925-bpf-xdp-meta-rxcksum-900685e2909d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

