Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479FF606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=lzoJDkP8;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bpwFqJJc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D2BB80F28;
	Mon, 19 Oct 2026 22:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BTuN1pidZJKY; Mon, 19 Oct 2026 22:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D03B080FEF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792450573;
	b=ibGR+pfdt8wEESkCzm/b+EvPwShxVAHVR93t/xnj7OL7V+fmZ/0PuWs3abeLzzfzmSI9
	 Ez7/nYJHyyhxEY4QKYTKCvLG96qYKUYFyNaBnc6ToP7Hg5c/4iWpW8f0oij79OrKbmfXe
	 FgVCCf+gPqyhFcxFxTYjvjbU5HymxaQeD89XEJj2e/F+MyJyee4bz5DyOfTWHnt+8ZbcU
	 hX2xkUideTHa9EtZZJubTu3J8tEflehhdPdpagOkVvbpnWuRszwivyJQ7KrWd9xnsqSQ7
	 NpiKZro9i6z3CiipgfVfp/Ai1mpFGUnOgTRr5Kz7k9LaGMvzLX64933B9KoC8wDV5hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792450573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/v4ixfdXOTxFhPS/xMPBmAHxe7W62ZgZQBHyPPIyfwI=;
	b=CvdXkAsZmtlPMn0irT5T1UiHHTa9t41h+yI3MX1aqart+0fY37ZLNUqG84WnfWQb6pVh
	 4gw40OfzXh8u3hK2Hp9ujq8Ba1aaIUPY4EGlHYfb/SUmCCBxSN7+Eyn59hMpA+yR2d8ti
	 hVg712eqWFXiipUpD24fxm1o+Xt89D6jIyAdpScqaJVcWR8jZjxd/1fau3I58fR2117tQ
	 qYm6GzRzHel39Zy5EnDkALyTvhhopyvVJoJZsyIcqwRjxwG+TZfomOGz6pnLcKngcQgsE
	 m9APvvvPiKhJhwSqdVYJFjYs0nfT/V41Odcl/Jz+6u8/FhdiVTeTpLlYH1CNCc3vXyQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792450573;
	bh=/v4ixfdXOTxFhPS/xMPBmAHxe7W62ZgZQBHyPPIyfwI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lzoJDkP8qTT3X0wsOqLUzX7FgptFs8Q836Ywh4tWSF14kVbyX5dUxu8+GLOVDCWBL
	 0Xf5UVy3Uo4Xj9XK09QnX1SC3GX8g4Qg+kFOGfM2Bo7n/bpcttht/KJw4aSEVqqHpx
	 N8R9n5Hfhq9QiRrAnKwzKvQ//rwKuKjR/YTBafQHMqFzyK00TlxaRASAxml2s3xrOg
	 GaCtBUJIDOcKgw1LnD+QBVfwZRqvtscBLx54WH86b2Bd2z6v5FpQXHzj6dHHiX/VKq
	 chTvgb1IWgkzy6KI7vRevTjwfbzbnKldHh7PrRv6isouqxgencFIwHxVIPl2pt50qS
	 rppHozzp1Z78g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D03B080FEF;
	Mon, 19 Oct 2026 22:56:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 882522A8
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 20:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E6616060D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 20:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n2RwGgBzf0Iv for <intel-wired-lan@lists.osuosl.org>;
 Sun, 18 Oct 2026 20:33:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4C75605FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792355617;
 b=Awn0o/vTU1belKViF7Xafofcf3PDGxl7YZhfWXZxMH87qKZboIKJlMy0xGNFrg6Y+VGd
 fpW+K868dk2STu5+y13sfzRA1KVBh8NFHkyABgc0AS0Tn0mfvqGk1EAjgj/cTZSNDtwwC
 dLiSnXYVeb/JsIw2Tsp5ng2q9WXUQWyCXH0kqEDpgoz8YPTljqwz+iwox+OQfKz3kynBV
 z0sFTB3ywAreATNg6ruNL0EqPbD9NOMCVBTR9RWryMnhvA28F5quJIA+jeH5pop/oWE7X
 RJdXa/V9TB+auu4KVJVgODkkNNfSQumSqFsvIuPK3C5/Z08aLjYMFDqv4kyivBi94nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792355617;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=/v4ixfdXOTxFhPS/xMPBmAHxe7W62ZgZQBHyPPIyfwI=;
 b=sludbwSJ4M1iLrzoMZnv/gqE8kaOjyPoUBu3TMQTbEXao6XdhOr8dbTswYkzMYZkmThB
 HrBGvh+bwibtoxZS1I4/2GGgtFZiCVS0glCBCWnmi8sSNrml+a+5o2YyXu97KRHspe78r
 o6UOcFeKhD3u3VFLZvHMCFRI4cqBtZhZHmbOoD1pQ10m3h1ewsQt8LO5ExnI+v918uhdf
 zFuSPHyrVGNmeVlgLmX4K1Buw7lJTZL7Vg1EZ4FndE6wAbWbI6IEq2nFiLLhcqi8Ku0iF
 jbAdopYwfSEUHi2L3wXDcmsU5mGUYZ/4pZY4RvYPKeNwMDdxbMpJznetaVoP/AAAj9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bpwFqJJc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=andrebrait@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bpwFqJJc
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4C75605FC
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 20:33:36 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1b13e09ffso1605591a12.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792355614; x=1792960414; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/v4ixfdXOTxFhPS/xMPBmAHxe7W62ZgZQBHyPPIyfwI=;
 b=bpwFqJJckdxNFZRyzdyXUolm+s6WwztTfAxU+svHzDwesl04oQrW453xns2RUaNH0i
 1Ym5rwg11D/G6WWTvMZ4NY8RI+byFvaEx7Sbtg+TkhDcVAfz0VpE770XwCCg8cSQiYJ6
 AwBYf8PCmCfKHX+WiGEhpxM9lrGbq677Sj6W4lFpMvKhf+hYUWIzW2LKT46XT/f5NeuV
 5kjhgV5CR+dGqWvny5fUOxorRcZ2569mbmY01GCu+UA6z246kPSS577CobQ/x57TKvIQ
 NLk2jKs3pZE6M71u5szOcYH2K8leZAZVE8AZYbjxPpf5YubiTE4wKso5pcCWKnOvHUVI
 7A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792355614; x=1792960414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/v4ixfdXOTxFhPS/xMPBmAHxe7W62ZgZQBHyPPIyfwI=;
 b=YvNQ3MSOU83esR9WpnzhOI3v08uqz6CAW0NLW0oqxfyAX/Vry1OgHI6Apyf9nH2HnB
 AEBrnaDLf4eDoZzCVnhNBfgT9Q6PJLNSDoXgQNkMdv8At4QZWHFG9hyHt2RNNdTUOqo7
 WgHVUEhSHCo54EY26wRJoZFpeJDSquFYNbDMNE604GMPrWmKI48gPF0j2SJWMjHyWNZI
 GavEdRXqR83QjcAnv6Pxqn84dKZ6Nf6AXn99sc5zaGBdughmn5zA7Jm50G68KKs3LIPI
 jMTzuk68FFwBwUyaRIRdoTK03gTeUbVqdq16JEQCOFZNa4oaMsSfqaM8jf7qFpTZtCkp
 xjGQ==
X-Gm-Message-State: AFq9FYL+FrH3kpKXzE5eHP3pD8F711VLH8hXCqqGfMKYsMaZth+xiEr/
 EhPiCSmzIF/pI8cHnvvilBtxi7DbabTZxrnckuqq7L4ySuUT2Pnsc6V7h6HhCw==
X-Gm-Gg: AYBFou0Ju7PQuPY92N20/5TPZa1dyiu37TXesasaXTtSDFG/I4YAXh1zYllRd1FGbFl
 3QkKc+VU4LTDL2V/v6LwxzEhFaUxKQaR0zEvNucOA78P/EVG/A7kg5ofUPeIzc3YNYLWeJIafFh
 I7E3Ssq93xvNZGKEXqvKPDnnZaJRUf2GHVd7oocaZZu8UE8K9BTamiwD35V2iEeuE5j7AVA5ENN
 jcI2fTBOgmpaTAkkMnVPysST1Nlfm1sFtdaG7Xppd6zq+Ug0yi/OQ05OnFS0w7AUNiVqhVgAxG+
 nUbxpz6G4NZBoF62QRhd+XSybIqTdSIdnF9S+G966I14gfyshuRDDqCt/z36T+lMOcyEPDj7abw
 eVLDIkIo53tzGcdbkmr9XsIqwP0RN1HoYsL0tr8AfK1HDTQbPbiTYGulY68OsekujsYTyFNlpco
 KhyvaXGaR77iAk/HTT6DeLVJrjC/CZBN+LtQZsRsRhJ0aRw1TfjWJn9ioJuojwkEUVKjgUsmG7J
 PL43n6M+jLv3bRxhrc1nCwOQRfFrDfEnaERzcsBYH6rv9c9IMCVDd3+rqJUkkTanBggKVosokok
 LwneLxTia8oZTF7O7kX9Xpeh+w==
X-Received: by 2002:a17:907:96ab:b0:c40:38b5:d784 with SMTP id
 a640c23a62f3a-c419e23dccdmr382502866b.22.1792355613973; 
 Sun, 18 Oct 2026 13:33:33 -0700 (PDT)
Received: from localhost.localdomain
 (2a02-a466-79a7-beef-acc9-464e-9c0c-41d2.fixed6.kpn.net.
 [2a02:a466:79a7:beef:acc9:464e:9c0c:41d2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4091fade41sm288148366b.82.2026.10.18.13.33.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 13:33:33 -0700 (PDT)
From: Andre Brait <andrebrait@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, Andre Brait <andrebrait@gmail.com>
Subject: [PATCH iwl-net] e1000e: segment TSO packets whose headers cross a 4
 KB boundary
Date: Sun, 18 Oct 2026 22:32:15 +0200
Message-ID: <20261018203215.77371-1-andrebrait@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 22:56:11 +0000
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On I219-LM (8086:15bb) and I219-V (8086:15bc), the transmit DMA can stop
for good on a TSO packet whose protocol headers cross a 4 KB boundary in
the buffer that holds them. The packet's data descriptor is never
written back, e1000e logs "Detected Hardware Unit Hang" every two
seconds, and the link stays down until the adapter is reset. Just before
the queue stops, the NIC also sends corrupted payload with a valid TCP
checksum, so the receiver accepts it.

The host's own TCP stack does not produce such packets: its TSO skbs
keep the headers in a small linear head and the payload in page
fragments. Forwarded guest traffic does: tun/vhost-net copies a VM's
small GSO packet into a single linear buffer from a page fragment, which
can start anywhere in a page. Hypervisor hosts bridging virtio-net
guests onto the I219 are therefore affected.

At each hang, the ring dump (NETIF_MSG_HW | NETIF_MSG_TX_DONE) shows, at
TDH, a TSO context descriptor followed by a single data descriptor
holding header and payload (TSE | EOP, status 0), with the buffer at
page offset 0xfc0 and 66 bytes of headers. The TX FIFO is empty (TDFH ==
TDFT), link, PHY and PCI status are normal, and there is no IOMMU fault.
Logging every TSO packet's layout in e1000_xmit_frame() over three
hangs:

  capture  TSO packets  headers cross 4 KB  only the rest crosses  hung
  1        118,784      37                  7,068                  37th
  2        118,699      19                  6,765                  19th
  3         31,520       3                  1,726                   3rd

Every stuck packet was "len=2962 headlen=2962 frags=0 hdr=66 mss=1448
pgoff=4032". About 0.03% of TSO packets have headers crossing 4 KB, and
not every one of them hangs, which suggests a race inside the NIC.
TSO packets whose linear part crosses 4 KB only after the headers never
hung.

The corruption was found with a traffic generator whose receiver checks
every byte. At each of 10 hangs, whole TCP segments from the guest
carried the stream data from exactly 128 bytes earlier.

Implement ndo_features_check to clear the GSO features for TCP GSO
packets whose headers cross a 4 KB boundary, so the stack segments those
in software. All other packets keep TSO and checksum offload.

Tested on I219-LM with upstream v7.0.14 e1000e built from one source
tree with and without this patch, under the same verified guest and
host traffic and an otherwise identical setup:

                 duration  hangs  corrupted  TCP verified  throughput
  without patch  64 min    5      6 chunks   0.24 TB       794-813 Mb/s
  with patch     252 min   0      0          1.51 TB       795-813 Mb/s

UDP loss was 0.021% without and 0.022% with the patch (queue drops on
the saturated link). Over 2 minutes, 64 of 8,612,900 packets were
diverted to software segmentation.

The problem was diagnosed and this fix was written with the help of an
AI coding assistant (Claude, by Anthropic), which designed the
instrumentation, analysed the captures and drafted the patch and this
message. The tests ran on my hardware. The notes below the cut give the
details; the reproducer, the captures and the raw data are at
https://github.com/andrebrait/e1000e-i219-tso-hang/tree/b5ef46099b28

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Assisted-by: LLM
Signed-off-by: Andre Brait <andrebrait@gmail.com>
---

Notes:
    How AI was used. The investigation ran as one long session with Claude
    (Anthropic) acting as a coding agent with root SSH access to two test
    hosts. It wrote the debug tooling (a hang watcher that captures the
    ring dump via msglvl, an ftrace of every transmit, and an e1000e build
    that logs each TSO skb's layout), the traffic generators, analysed the
    captures, proposed the header-crossing hypothesis, and drafted the fix
    and the changelog. I provided the hardware, directed the work, insisted
    on a reproducer whose receiver verifies every byte and on an A/B test
    where the patch is the only difference, and reviewed the results and
    the patch.
    
    Everything below, plus the full captures, the reproducer and the exact
    systemd units, is at https://github.com/andrebrait/e1000e-i219-tso-hang/tree/b5ef46099b28
    
    Setup:
    - I219-LM 8086:15bb rev 10 (HP ProDesk 600 G5 Mini), NVM 0.5-4,
      1000 Mb/s full duplex, EEE and flow control on, VT-d on, MTU 1500.
    - Kernel 7.0.14 (Proxmox VE 9.2). Both A/B modules were built from the
      same v7.0.14 e1000e tree, with and without this patch; a fingerprint of
      the rest of the setup (scripts, units, VM configuration, kernels,
      offloads, MTU, EEE, flow control, command line) was identical.
    - Traffic: a virtio-net/vhost-net guest bridged onto the I219 sending TCP
      bulk data, small TCP writes and small UDP datagrams to a second host,
      plus 8 TCP streams with MSS 536 from the host in both directions. The
      receiver checks every byte of every TCP stream and UDP datagram.
    
    Hang message and registers (capture 2, 20261018T104202Z):
    
      e1000e 0000:00:1f.6 eno1: Detected Hardware Unit Hang:
        TDH                  <6d>
        TDT                  <a3>
        next_to_use          <a3>
        next_to_clean        <6c>
        buffer_info[next_to_clean]:
        time_stamp           <fffef4c8>
        next_to_watch        <6d>
        jiffies              <fffefd00>
        next_to_watch.status <0>
        MAC Status             <80083>
        PHY Status             <796d>
        PHY 1000BASE-T Status  <3800>
        PHY Extended Status    <3000>
        PCI Status             <10>
      e1000e: STATUS          00080083
      e1000e: TDH             0000006d
      e1000e: TDT             000000a3
      e1000e: TDFH            00000d04
      e1000e: TDFT            00000d04
      e1000e: TDFHS           00000d04
      e1000e: TDFTS           00000d04
    
    TX ring around next_to_clean (same capture). Tc[0x06C] is the TSO
    context (MSS 0x5A8, HDRLEN 0x42, PAYLEN 0xB50); Td[0x06D] is the single
    data descriptor holding header and payload, buffer at page offset 0xFC0,
    length 0xB92, DCMD 0xAF (TSE|EOP|RS|IFCS|IDE), never written back:
    
      e1000e: Td[0x06A]    00000000FFD7EBC0 0000000026100046 0000000000000000 0046   6A 0000000000000000 0000000000000000
      e1000e: Td[0x06B]    00000000FEC50004 00000000AF101050 0000000000000000 10F4   6B 0000000000000000 0000000000000000
      e1000e: Tc[0x06C]    000032220021180E 05A8420027000B50 0000000000000000 17A0   6D 00000000FFFEF4C8 0000000000000000 NTC
      e1000e: Td[0x06D]    00000000FF664FC0 00000300AF100B92 00000000FF664FC0 0B92   6D 00000000FFFEF4C8 000000000325885a
      e1000e: Tc[0x06E]    0000322200000000 0000000021000000 0000000000000000 17A0   6F 00000000FFFEF4C8 0000000000000000
      e1000e: Td[0x06F]    00000000FF7C3D7E 00000200AB100042 00000000FF7C3D7E 0042   6F 00000000FFFEF4C8 0000000010c11e46
      e1000e: Tc[0x070]    0000322200000000 0000000021000000 0000000000000000 0518   71 00000000FFFEF4C8 0000000000000000
      e1000e: Td[0x071]    00000000FFE3E1FE 00000200AB100042 00000000FFE3E1FE 0042   71 00000000FFFEF4C8 000000006d7e7051
      e1000e: Tc[0x072]    000032220021180E 020C420027006E88 0000000000000000 17A0   79 00000000FFFEF4C8 0000000000000000
      e1000e: Td[0x073]    00000000FF2EEC7E 0000030026100046 00000000FF2EEC7E 0046   73 00000000FFFEF4C8 0000000000000000
      e1000e: Td[0x074]    00000000FF6308F4 00000300261017A0 00000000FF6308F4 17A0   74 00000000FFFEF4C8 0000000000000000
      e1000e: Td[0x075]    00000000FF30A094 0000030026100F6C 00000000FF30A094 0F6C   75 00000000FFFEF4C8 0000000000000000
      e1000e: Td[0x076]    00000000FF8CE000 00000300261017A0 00000000FF8CE000 17A0   76 00000000FFFEF4C8 0000000000000000
      e1000e: Td[0x077]    00000000FF67E7A0 00000300261017A0 00000000FF67E7A0 17A0   77 00000000FFFEF4C8 0000000000000000
      e1000e: Td[0x078]    00000000FEDFCF40 00000300261017A0 00000000FEDFCF40 17A0   78 00000000FFFEF4C8 0000000000000000
    
    TSO layout log from the instrumented driver, per capture (the stuck
    packet is the one at next_to_clean):
    
      20261018T103307: TSO packets logged: 118784; linear (frags=0): 8552; headers crossing 4 KB: 37; linear part crossing 4 KB but not the headers: 7068
        stuck: 1805.336507: e1000e-tso idx=116 len=2962 headlen=2962 frags=0 hdr=66 mss=1448 segs=2 pgoff=4032 hdr_cross=1 head_cross=1
      20261018T104202: TSO packets logged: 118699; linear (frags=0): 7747; headers crossing 4 KB: 19; linear part crossing 4 KB but not the headers: 6765
        stuck: 232.374032: e1000e-tso idx=108 len=2962 headlen=2962 frags=0 hdr=66 mss=1448 segs=2 pgoff=4032 hdr_cross=1 head_cross=1
      20261018T104845: TSO packets logged: 31520; linear (frags=0): 770; headers crossing 4 KB: 3; linear part crossing 4 KB but not the headers: 1726
        stuck: 104.942690: e1000e-tso idx=126 len=2962 headlen=2962 frags=0 hdr=66 mss=1448 segs=2 pgoff=4032 hdr_cross=1 head_cross=1
    
    Payload mismatches logged by the receiver (all hangs with the verifying
    reproducer: Proxmox's e1000e build 12:30-13:04, upstream v7.0.14
    unpatched 13:13-14:17; none with the patch, 14:26-18:38 UTC). In every
    case the received bytes equal the stream data 128 bytes before the
    offset:
    
      2026-10-18T12:30:32Z MISMATCH tcp from 10.0.255.90 at stream offset 156885518: got b4552cee6086c51f73e278c0638b663a expected c4fceede1125b36848bc4cd4a9e1bdc3 (chunk 2896 bytes)
      2026-10-18T12:40:16Z MISMATCH tcp from 10.0.255.90 at stream offset 2154601342: got b537fe2d12d226e90f9ed5681801b845 expected a8a25ec284acc5b04e347043ddb900c5 (chunk 5792 bytes)
      2026-10-18T12:47:36Z MISMATCH tcp from 10.0.255.90 at stream offset 489107398: got 8b141d678d46c443f73b04b83ecab696 expected d41ba3ff49478e0f3d91ffabf1deffc1 (chunk 2896 bytes)
      2026-10-18T12:55:21Z MISMATCH tcp from 10.0.255.90 at stream offset 841581822: got 0881a33e1918e81fa4a446d99017b200 expected d69c66fa5e01fa17340ce7f9c7c94308 (chunk 2896 bytes)
      2026-10-18T13:02:07Z MISMATCH tcp from 10.0.255.90 at stream offset 40350478: got 4cddf132550c31492e279451675867ea expected f0022aabe41439bfd23c02219ee16c68 (chunk 2896 bytes)
      2026-10-18T13:40:16Z MISMATCH tcp from 10.0.255.90 at stream offset 1134953671: got 5b9d0621664fb8a960911cb4efe028e1 expected 5f99cc2ab5ea857119acdce4a5b3ea19 (chunk 1452 bytes)
      2026-10-18T13:48:47Z MISMATCH tcp from 10.0.255.90 at stream offset 1345086806: got 939f9a54ec81648fbcadb6506c5b297e expected 531bc7fc65da6b23eaafbe081ba95ebc (chunk 2896 bytes)
      2026-10-18T13:55:52Z MISMATCH tcp from 10.0.255.90 at stream offset 229134926: got 6e8252624a43baaf23f28b636cf5fa83 expected 0aac653e1175623ccf2a19f3f93ddb04 (chunk 2896 bytes)
      2026-10-18T14:04:52Z MISMATCH tcp from 10.0.255.90 at stream offset 1645261550: got dd44d386aefd565c7b7af11809cabf75 expected d77584104f8c094ba75858204db81803 (chunk 1448 bytes)
      2026-10-18T14:04:52Z MISMATCH tcp from 10.0.255.90 at stream offset 1645262488: got 0afa21dd34f3be0308b2576d4c64ee95 expected 3e2f976035c0421d538814f2c8beaca1 (chunk 1448 bytes)
      2026-10-18T14:15:27Z MISMATCH tcp from 10.0.255.90 at stream offset 2818840934: got 737cc43f17815f47cc805435de979c51 expected 64fc2cd280cf2af40a89c222cc41bbd0 (chunk 2896 bytes)
    
    A kretprobe on e1000_features_check() with the patch, 2 minutes:
    8,612,900 calls, 64 returning the features without NETIF_F_TSO |
    NETIF_F_TSO6 (the only GSO features enabled on the interface).
    
    This patch applies to net-queue dev-queue (0344a46e40a4) and all e1000e
    objects compile there with W=1 without warnings. It was not
    runtime-tested on a dev-queue kernel, only on 7.0.14.
    
    Not done or not known:
    - The fix was only tested on I219-LM. An I219-V (8086:15bc rev 10,
      Lenovo M720q) hung the same way in production but was not on the test
      bench. No other e1000e MAC (82574, 82579, I217/I218) was tested; the
      check applies to all e1000e devices because it only affects packets
      whose headers cross a 4 KB boundary.
    - Traffic from an unprivileged guest is enough to trigger the hang, so
      on affected hosts a guest can take the host's network down.
    - What goes wrong inside the NIC is unknown. Is this a known I219
      erratum, and which MACs does it affect? If Intel documents a
      narrower condition, the check can be tightened.

 drivers/net/ethernet/intel/e1000e/netdev.c | 31 +++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 834a5b888..6f95ed19a 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
+#include <linux/sizes.h>
 #include <linux/interrupt.h>
 #include <linux/tcp.h>
 #include <linux/ipv6.h>
@@ -7359,6 +7360,34 @@ static int e1000_set_features(struct net_device *netdev,
 	return 1;
 }
 
+/**
+ * e1000_features_check - validate offloads for a packet about to be sent
+ * @skb: packet to check
+ * @netdev: network interface device structure
+ * @features: offload features usable for this packet
+ *
+ * The transmit DMA can stop for good when a TSO packet's protocol headers
+ * cross a 4 KB boundary in the buffer holding them: the descriptor is never
+ * written back, the driver reports "Detected Hardware Unit Hang", and only a
+ * reset brings the queue back. Seen on I219-LM/-V (PCH) with forwarded
+ * guest traffic, which arrives as linear GSO skbs that can start anywhere in a
+ * page. Let the stack segment those few packets in software instead.
+ *
+ * Returns: the features to use for @skb.
+ */
+static netdev_features_t e1000_features_check(struct sk_buff *skb,
+					      struct net_device *netdev,
+					      netdev_features_t features)
+{
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) &&
+	    (offset_in_page(skb->data) & (SZ_4K - 1)) +
+	    skb_tcp_all_headers(skb) > SZ_4K)
+		features &= ~NETIF_F_GSO_MASK;
+
+	return features;
+}
+
 static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_open		= e1000e_open,
 	.ndo_stop		= e1000e_close,
@@ -7378,7 +7407,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 #endif
 	.ndo_set_features	= e1000_set_features,
 	.ndo_fix_features	= e1000_fix_features,
-	.ndo_features_check	= passthru_features_check,
+	.ndo_features_check	= e1000_features_check,
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 };
-- 
2.56.0

