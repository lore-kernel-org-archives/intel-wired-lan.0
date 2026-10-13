Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5F8CA9ED0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 01:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E16C14055C;
	Tue, 13 Oct 2026 01:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ut0v93oUOE9i; Tue, 13 Oct 2026 01:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4AECA40536
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791853813;
	b=RRHvaqVjdt61oB4X19EkYaG+xyak4o7uk9+ItZR+rXF/Hfjunlf+g/95hEDcvnBAzqbg
	 fN39FscUBnJ8BYx/vNnXrfVOVDiKjZ78+YozO2Q0v2St2RiWp/1W0gUBUhfkZIewxM8uA
	 XXO9C5GNPtyJOwSQMw1IbDYDRAeYtCG/kA045E2B8r7pJ7ipxOUjlRsYdC3A2WuVKC1jd
	 pcJWt7h2Tvq/djB+d1VTU6Xlg1+C5f+yWyc3ZGVVLkT9jGEbjZh0lkrGLeVpD1it0DYn3
	 3Bxr7XcYiLz5j0IYTBUB1rKyCOzFjmbn/QPPjrueJfE+SXHqTlY7k/Qy+fQNACSqSNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791853813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jCsFKpLJmYvgm1OlKEvx32KM7x7W0yeCdPkSIbJ20jc=;
	b=g0uUocOrDrc3emwnanHL7omNDIJVTevdB7x5rEznOeJS+ADNMwBX+ytxdA9TKLfu10Zi
	 Vb8L3gIoS6CjK5iCobAgP3CYNVMM7YrpmLR6kFlSsfe6IsUMnmmQtTjV0RbnZ7sR7dX0T
	 b+BrA82lxyCyIT4L8ujmPy1zvziMEZnwMxLFfWvDDKtf1KWBNP8z2hw+JKtgxlCaqMRV9
	 rqdC8pnebbeUzYrybmZYN9RK5QWWCD8awuvVB7M4ABa6pdf0mbva5wh2/Oba/3TpsX/N+
	 CG5H7NJGOxMoYAoRD4BoIS5mxYvLmMMMAsfgoBtbgUmqjTG50Q8lNqC/YQTXobDpp1A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791853813;
	bh=jCsFKpLJmYvgm1OlKEvx32KM7x7W0yeCdPkSIbJ20jc=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OHmsK0shIA7V2TiGBQNfqo7oHUuzU9DACMoW/jVUHej3qlcIGUuH7wbbXTAJyM2OS
	 lCIrha77ikrACN+MRdPx97iYbhcagSQGL2MT5TrfRyJd6qRhIUGgTnuwh6tejvPkfo
	 cfrKZIBonHoBFJXP4veWJCurI6UiA6DS2DbWpUT28Gu3AgGKfb5Tzx3TO8NDooGpbJ
	 aEeHaTULD4eVIrAZAfYdXY1YvD5QTQTUhROQD7CvjB6PnbxUCSPnHcH8H+M0NGH4+9
	 mVpLC1G63t8XymmQfYxwJigaeaaSGU7TuAXHirrum3v2m/pfoY+jM+Iz1EIymPqb8c
	 q6IsthH0gffLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AECA40536;
	Tue, 13 Oct 2026 01:10:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F359A2A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 01:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E498D60705
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 01:10:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jCDM0h1041ZV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 01:10:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 529AF6071E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.105
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791853810;
 b=VeJBljdg97YDL5Bzf9rb2QAC1+CY5bM9i/i7z392Ve7m2wqB7Bj5FXklRAWFqc+ujbLU
 ZkVRu2FJQAMJqBVFOScpJWcs7n+CnY2nFAWqt8FH7AkHtlqZD1baz//WXIT8ZV2VlecFc
 xEDxF0rGKtwFBu2u+JtJqWU/jGXWZqivEMmf0ZeC8RyKKi1OmLcUu+EgWnxwrBqMbnBu2
 cwz8kZgtJZ89hPYvUqyrNiY7gTFGQW7CymH/n8TjYzycvYqUobuk+O2sQSV9M6OgV8AgI
 kiTLYG2XzzDPnEWpv4l+FzY76nPqDg+Bf7GJu8/Kl2EKTZG1eajv3Hsl/lROjqti5wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791853810;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=jCsFKpLJmYvgm1OlKEvx32KM7x7W0yeCdPkSIbJ20jc=;
 b=OKETbLWR6z6EQ2g0SMcILMz6UCahMKS80i8Z/pYmpIIpiRg0m6F0lv2Lb7m9Up4JU2ci
 nLro27Hzp2o1lVAAUK90hUM3LFvyuOngZxikdk04DKNyiki5tdueuZSVNv377MW2KVYgG
 y3VNJb3hjxRUHMusjBNsnVanWN3E7Hr6B3gDg7OsDh6WbRt4VIVuYFhMvoow0CQF2rX6/
 ZbJYY4eiBky2j0RCkjhYxtHiF5+6qH5gvYngJsx5RzoSP3CXT4268H05CbNwnpyyESZ+M
 J2oNicmwt3MiHczYDINW+AunxOFbHX1xATzCtaUn9d6ESXHVqD3TjLpG73b6gTYWjxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=ihkm2S3c; 
 arc=none smtp.remote-ip=109.224.244.105
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.105;
 helo=mail-244105.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=ihkm2S3c
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 529AF6071E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1791853787; x=1792112987;
 bh=jCsFKpLJmYvgm1OlKEvx32KM7x7W0yeCdPkSIbJ20jc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ihkm2S3cNXK6MBFgENx6x9lI8ENmuQ83ikVkPU2W+wZz3s3KgpZwZ9yOIA1EGFZYV
 +Voj5RyxUloDM6XzlPICV8zozczQwpoQxx3zgyc8RZ1Q9c5UqCrhXxhUnndVBlJ34K
 lL9NRmgHE4PAxN7UL4LBN09tFoTgtmqwTjSWoePnpij+VoLUtHCETrW7icoyjYPJqB
 MhwCcXkWQq+BOeuETH9JoYwVJF0iUjtDk+mB3JOxRjebpWerOJ220UHxWoheRrRT2M
 icSkearQlf6q5EFdZODFSl173pa1/nXJgdsvFEAYcNJhNT7MLa2O1yNne9Fg1ahEkB
 dRuGwC+d0kE3g==
Date: Tue, 13 Oct 2026 01:09:37 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 maciej.fijalkowski@intel.com, avigailx.dahan@intel.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v2] igc: only strip RX timestamp header from first buffer
Message-ID: <20261013010854.4068874-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: b4fcef83b2762455dccb4db51660a44ac447b7fb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

igc_clean_rx_irq() subtracts 16 bytes for TSIP without checking whether
the descriptor contains that much data. On continuation buffers shorter
than 16 bytes, the unsigned length underflows and is stored in the skb
fragment.

From the wire, a 2040-byte timestamped frame with an 8-byte final buffer
produces a fragment length of 0xfffffff8. Bridge forwarding allows that
skb to reach igc TX without passing through IPv4 length validation.

igc_xmit_frame_ring() uses the corrupted length to calculate the
descriptor requirement, overflowing its 16-bit counter. igc_tx_map()
then passes the same length to skb_frag_dma_map(), requesting a nearly
4 GiB DMA mapping.

In both reproductions, the DMA mapping succeeded and the descriptor
loop completed. The corrupted fragment generated 131,072 descriptor
writes. With the tested 256-entry TX ring, this traversed the ring
512 times, repeatedly overwriting descriptors.

The TX queue then stalled. NETDEV WATCHDOG reported "transmit queue 0
timed out" after about 5.5 seconds, followed by an adapter reset.
The first occurrence also triggered a warning in the NAPI poll path.

Only subtract the inline timestamp header from the first buffer of
an skb-assembled packet. Continuation buffers are appended as fragments
and do not contain an inline timestamp.

Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Paul Moses <p@1g4.org>
---
v1...v2
    - improve commit message
    - no code changes
---
Logs:

[  540.236838] WARNING: at igc_poll+0x4f42/0x7660 [igc], CPU#3: swapper/3/0
[  540.372991] Modules linked in: igc
[  540.413904] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.3.0-rc6+ =
#4 PREEMPT=20
[  540.505951] RIP: 0010:igc_poll+0x4f42/0x7660 [igc]
[  540.563556] Code: 00 e8 b2 c6 eb f0 85 c0 74 27 48 c7 44 24 30 00 00 00 =
00 45 89 e7 8b ac 24 e0 00 00 00 4c 8b b4 24 d8 00 00 00 e9 b2 e6 ff ff <0f=
> 0b e9 10 ec ff ff 49 83 c6 74 4c 89 f0 48 c1 e8 03 42 0f b6 04
[  540.789183] RSP: 0018:ffffc900003e0b68 EFLAGS: 00010282
[  540.852006] RAX: ffffc90000469100 RBX: ffff88824b711380 RCX: 00000000000=
00800
[  540.937776] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888205d=
33468
[  541.023541] RBP: 1ffff110496e226f R08: ffff888205d3346f R09: 1ffff11040b=
a668d
[  541.109317] R10: dffffc0000000000 R11: ffffed1040ba668e R12: 00000000000=
00000
[  541.195086] R13: 1ffff110496e2270 R14: ffffc900004690f0 R15: ffffea00044=
85d40
[  541.280849] FS:  0000000000000000(0000) GS:ffff8887ac2a5000(0000) knlGS:=
0000000000000000
[  541.378102] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  541.447186] CR2: 000079fdfe44f188 CR3: 0000000109c68003 CR4: 0000000000f=
70ef0
[  541.532974] PKRU: 55555554
[  541.565530] Call Trace:
[  541.594960]  <IRQ>
[  541.619184]  __napi_poll+0x91/0x380
[  541.661120]  net_rx_action+0x4e0/0xbc0
[  541.706209]  handle_softirqs+0x173/0x4d0
[  541.753373]  ? handle_edge_irq+0x1af/0x710
[  541.802631]  __irq_exit_rcu+0x63/0xd0
[  541.846664]  common_interrupt+0x81/0x90
[  541.892793]  </IRQ>
[  541.918044]  <TASK>
[  541.943297]  asm_common_interrupt+0x26/0x40
[  541.993593] RIP: 0010:mwait_idle+0x49/0x60
[  542.042838] Code: 80 0e 40 48 f7 06 10 00 00 00 75 1f 48 89 f0 0f 1f 00 =
31 c9 31 d2 0f 01 c8 48 f7 06 10 00 00 00 75 09 31 c0 31 c9 fb 0f 01 c9 <fa=
> f0 80 26 bf c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[  542.268428] RSP: 0018:ffffc9000025fed8 EFLAGS: 00000246
[  542.331248] RAX: 0000000000000000 RBX: ffff88810091c400 RCX: 00000000000=
00000
[  542.417000] RDX: 0000000000000000 RSI: ffff88810091c400 RDI: 00000000002=
2e00c
[  542.502770] RBP: 1ffff11020123880 R08: ffff8887608f06d3 R09: 1ffff110ec1=
1e0da
[  542.588551] R10: dffffc0000000000 R11: ffffed10ec11e0db R12: 00000000000=
00000
[  542.674330] R13: 0000000000000000 R14: dffffc0000000000 R15: 00000000000=
00000
[  542.760111]  default_idle_call+0x39/0x60
[  542.807277]  do_idle+0xff/0x340
[  542.845051]  cpu_startup_entry+0x48/0x70
[  542.892212]  start_secondary+0xfc/0x100
[  542.938337]  common_startup_64+0x12c/0x147
[  542.987604]  </TASK>
[  543.013881] ---[ end trace 0000000000000000 ]---
[  543.069828] igc 0000:02:00.0: Using 39-bit DMA addresses
[  548.627473] igc 0000:02:00.0 enp2s0: NETDEV WATCHDOG: CPU: 2: transmit q=
ueue 0 timed out 5480 ms
[  548.627546] igc 0000:02:00.0 enp2s0: Register Dump
[  548.627556] igc 0000:02:00.0 enp2s0: Register Name   Value
[  548.627566] igc 0000:02:00.0 enp2s0: CTRL            581c0040
[  548.627581] igc 0000:02:00.0 enp2s0: STATUS          40680683
[  548.627590] igc 0000:02:00.0 enp2s0: CTRL_EXT        100000c0
[  548.627599] igc 0000:02:00.0 enp2s0: MDIC            1805dde1
[  548.627607] igc 0000:02:00.0 enp2s0: ICR             00000081
[  548.627616] igc 0000:02:00.0 enp2s0: RCTL            04408022
[  548.627630] igc 0000:02:00.0 enp2s0: RDLEN[0-3]      00001000 00001000 0=
0001000 00001000
[  548.627649] igc 0000:02:00.0 enp2s0: RDH[0-3]        00000013 0000000c 0=
0000000 00000000
[  548.627668] igc 0000:02:00.0 enp2s0: RDT[0-3]        00000012 0000000b 0=
00000ff 000000ff
[  548.627687] igc 0000:02:00.0 enp2s0: RXDCTL[0-3]     02040808 02040808 0=
2040808 02040808
[  548.627706] igc 0000:02:00.0 enp2s0: RDBAL[0-3]      ffffb000 ffffa000 f=
fff9000 ffff8000
[  548.627725] igc 0000:02:00.0 enp2s0: RDBAH[0-3]      00000000 00000000 0=
0000000 00000000
[  548.627734] igc 0000:02:00.0 enp2s0: TCTL            a503f0fa
[  548.627748] igc 0000:02:00.0 enp2s0: TDBAL[0-3]      fffff000 ffffe000 f=
fffd000 ffffc000
[  548.627766] igc 0000:02:00.0 enp2s0: TDBAH[0-3]      00000000 00000000 0=
0000000 00000000
[  548.627780] igc 0000:02:00.0 enp2s0: TDLEN[0-3]      00001000 00001000 0=
0001000 00001000
[  548.627799] igc 0000:02:00.0 enp2s0: TDH[0-3]        00000013 0000000c 0=
0000000 00000018
[  548.627814] igc 0000:02:00.0 enp2s0: TDT[0-3]        00000013 0000000c 0=
0000000 00000018
[  548.627828] igc 0000:02:00.0 enp2s0: TXDCTL[0-3]     02100108 02100108 0=
2100108 02100108
[  548.627837] igc 0000:02:00.0 enp2s0: Reset adapter
[  552.415852] igc 0000:02:00.0 enp2s0: NIC Link is Up 2500 Mbps Full Duple=
x, Flow Control: RX/TX
[  607.597798] igc 0000:02:00.0 enp2s0: NETDEV WATCHDOG: CPU: 0: transmit q=
ueue 0 timed out 5680 ms
[  607.597890] igc 0000:02:00.0 enp2s0: Register Dump
[  607.597901] igc 0000:02:00.0 enp2s0: Register Name   Value
[  607.597911] igc 0000:02:00.0 enp2s0: CTRL            581c0040
[  607.597926] igc 0000:02:00.0 enp2s0: STATUS          40680683
[  607.597935] igc 0000:02:00.0 enp2s0: CTRL_EXT        100000c0
[  607.597944] igc 0000:02:00.0 enp2s0: MDIC            1805dde1
[  607.597952] igc 0000:02:00.0 enp2s0: ICR             00000081
[  607.597962] igc 0000:02:00.0 enp2s0: RCTL            04408022
[  607.597976] igc 0000:02:00.0 enp2s0: RDLEN[0-3]      00001000 00001000 0=
0001000 00001000
[  607.597996] igc 0000:02:00.0 enp2s0: RDH[0-3]        0000000a 00000006 0=
0000000 00000000
[  607.598015] igc 0000:02:00.0 enp2s0: RDT[0-3]        00000009 00000005 0=
00000ff 000000ff
[  607.598034] igc 0000:02:00.0 enp2s0: RXDCTL[0-3]     02040808 02040808 0=
2040808 02040808
[  607.598053] igc 0000:02:00.0 enp2s0: RDBAL[0-3]      ffffb000 ffffa000 f=
fff9000 ffff8000
[  607.598072] igc 0000:02:00.0 enp2s0: RDBAH[0-3]      00000000 00000000 0=
0000000 00000000
[  607.598081] igc 0000:02:00.0 enp2s0: TCTL            a503f0fa
[  607.598094] igc 0000:02:00.0 enp2s0: TDBAL[0-3]      fffff000 ffffe000 f=
fffd000 ffffc000
[  607.598109] igc 0000:02:00.0 enp2s0: TDBAH[0-3]      00000000 00000000 0=
0000000 00000000
[  607.598124] igc 0000:02:00.0 enp2s0: TDLEN[0-3]      00001000 00001000 0=
0001000 00001000
[  607.598139] igc 0000:02:00.0 enp2s0: TDH[0-3]        00000008 00000006 0=
0000000 0000000c
[  607.598153] igc 0000:02:00.0 enp2s0: TDT[0-3]        00000008 00000006 0=
0000000 0000000c
[  607.598168] igc 0000:02:00.0 enp2s0: TXDCTL[0-3]     02100108 02100108 0=
2100108 02100108
[  607.598176] igc 0000:02:00.0 enp2s0: Reset adapter
[  611.790143] igc 0000:02:00.0 enp2s0: NIC Link is Up 2500 Mbps Full Duple=
x, Flow Control: RX/TX

---

 drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe93c..41b293dc10c3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_ve=
ctor, const int budget)
=20
 =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
=20
-=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
+=09=09if (!skb &&
+=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
 =09=09=09ctx.rx_ts =3D pktbuf;
 =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
 =09=09=09size -=3D IGC_TS_HDR_LEN;
--=20
2.56.GIT


