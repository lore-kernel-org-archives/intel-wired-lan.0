Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857F0E68143
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Feb 2026 08:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1041140925;
	Tue, 17 Feb 2026 08:34:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7E25WX9tPqTA; Tue, 17 Feb 2026 08:34:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C60C40CC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771317277;
	bh=H3jL9wd7+AqHPCUpoJVlwDhfqcwAnMrrILuu2oEI2u4=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OKnHTGc5LlND/J9JB+VstQwt0q/e1WzmyinSz/QjEtkEQ4Egh4P0CFE/vhspjObEI
	 NjZ0meWylfCqRifiiTehe3JdIMFJ/L0CZglyqNGDenzPtmSc8hQsmPkoNsbasMtF5c
	 n9svnaTuiREUkOhZ9D5/Wf1OyMSpRIV1LpyenVEMGuzrpPQQPX+g5TPBrq8m6xHyUr
	 s3edEi7rjyrGoFv8O2jKPntPzY8/8Gmz/21v+oiDKfE8wksxoexH9B3KkEIctbgjeE
	 8GvEyDHOiMJGjjHxFj19LoVHdUvHuVV6z20tBIh5Wdl7IuZ/ClUPM48fCmfykdnJvn
	 3pAeERbJJy0ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C60C40CC3;
	Tue, 17 Feb 2026 08:34:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3519B1EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 08:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19AA840CC3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 08:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WiBeHwaGbxeG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Feb 2026 08:34:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=lorenzo@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4A71F40925
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A71F40925
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A71F40925
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 08:34:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6348340554;
 Tue, 17 Feb 2026 08:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5960C4CEF7;
 Tue, 17 Feb 2026 08:34:33 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 17 Feb 2026 09:33:55 +0100
Message-Id: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw6CMBREf4V0bc3lQpG68j8Mi1Iu0CCPtEgwh
 H+3kJjoQl3OJOfMLMyRNeTYOViYpck403c+RIeA6Vp1FXFT+MwQUIBEwfOh5HMx8JZGxe2sG3d
 vuQRIUkEoQRbMo4Ol0sy79pr5XBs39vaxr0y4tX+EE3LgSR6VJNOTJhleGrId3Y69rbYBTyeAY
 fSDVinqOAVUZU7v9PZnCl8fNgt8sYTeQqIQQisFIv74kK3r+gRUGBv5PQEAAA==
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
 d=kernel.org; s=k20201202; t=1771317274;
 bh=uL4DxKFzQP1l9k3Kk1Acq3jftmgv8xT3AxsRIN0UWhQ=;
 h=From:Subject:Date:To:Cc:From;
 b=J1G+E8GemW3j3SNkjeWUN98fLzNofnJDINU6InSnvliGxzY2vnwomAKb/qQVHgYvN
 bzHF0jxCfdhntCI1I6H6zVwhzmT5LWbYXx/ZCL+QlOTELVbhNiz+wrfjHSQoY90Ykh
 VwaVy26CmMK3kune0GOQ64+uYrfqOrmsSwKum7jTWZj9Znxm5e4SS6ZRNBC+CDpESj
 C7lELU7R6rLVRf/A+L/ocgrKROy03GXkaGzlxbJj77nN1LQ/iTpK1wjPo5cLaaR92L
 0xHAStfTeWy2FnJizFlKA5SjGojKYM6/fj8SlJ2KYCe1Z1HGjk/nQeoRR8VbWFSvOV
 oTYX7ZDLwIHcQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=J1G+E8Ge
Subject: [Intel-wired-lan] [PATCH bpf-next v3 0/5] Add the the capability to
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
Lorenzo Bianconi (5):
      netlink: specs: Add XDP RX checksum capability to XDP metadata specs
      net: veth: Add xmo_rx_checksum callback to veth driver
      net: ice: Add xmo_rx_checksum callback
      selftests/bpf: Add selftest support for bpf_xdp_metadata_rx_checksum
      selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog

 Documentation/netlink/specs/netdev.yaml            |   5 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      | 118 +++++++++++++--------
 drivers/net/veth.c                                 |  29 +++++
 include/net/xdp.h                                  |  13 +++
 include/uapi/linux/netdev.h                        |   3 +
 net/core/xdp.c                                     |  28 +++++
 tools/include/uapi/linux/netdev.h                  |   3 +
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   6 ++
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   8 ++
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |   3 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  25 +++++
 tools/testing/selftests/bpf/xdp_metadata.h         |  12 +++
 12 files changed, 211 insertions(+), 42 deletions(-)
---
base-commit: 192c0159402e6bfbe13de6f8379546943297783d
change-id: 20250925-bpf-xdp-meta-rxcksum-900685e2909d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

