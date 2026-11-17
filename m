Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D51606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uKcz2dNG;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HbAZ1e5o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE5C8408D1;
	Tue, 17 Nov 2026 16:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xlGM7AaZ0xXr; Tue, 17 Nov 2026 16:29:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DCB1240908
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932943;
	b=B8AzfuGUt+8a4/frtlRw+qq04Xjk/EjCW2Xy+kcOFeHaG0p96FP1SIzA/bkFbUkW1NI9
	 eLLJnyM/ptONhYfjRgeu32FYbveDclWJbrtDqlTKGLQ3SJ2yAx+/QQxgAfVdYgBwDgbdH
	 roF9eLTpn+LyUDSagvD5a8/6CEvDvQEftd0T2ENCGjXc78o4AQtcHI0qdc0DgiFgmwgxx
	 JnZWzalG3azuALe9yrgpMpq14EPlnV3baGVVRaTIRoeq/dCPECYZO65xraD4K6VAsiFRs
	 Rt7V73xU1/bC9n9bjfjFCZ7l0pQBV3pBlZduTpwWpbwWBBLQe5qVY5pOcZQ2N/bx81w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tncad3xb72MRHXQPalnrg31jkG++uAFsv3nTcMKPqIc=;
	b=GtFEkbpYRMxFBXR//zC3Fr6HbXiYAev+gmsl25LTa0IeM563zNADABhxhM7Kq25TrTs1
	 Vjoe/Aw6ItQ7eMgf/ue8V0hpjtZe/sGU3et1uTegYPavc2mgVSXVidDBix1UgX9tgm8U+
	 UcWIqJ7Mf/Ohud5PEz8PZbnpoRJtz/5ybOs+MERUjaW7iwNJai3Y2Bj4S/8q2+3Pt9sJ9
	 o13grE5LaBeP1BOKwNLqhAQNulIK0umaDMhoZSrbqMpqno5wsJft+25wldMm5btPjooN3
	 it6Ld1uw1kru71ipFEpC2jp7rIpoQ8+/qm6Y7scQ7rf7wPjRn724F2Vjsino8+jFZAQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932942;
	bh=tncad3xb72MRHXQPalnrg31jkG++uAFsv3nTcMKPqIc=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uKcz2dNGwg+3FVa5ETxTkMRDGz18INmzyXuI0Sq/cBsUOfshTQ1uif6D5RS0fLWgj
	 OzU2O1b1Nf6jj6DI3q9mbFLnfXg7otmU1iCo6tLFS0glXhv+GAK3tdsbzyBrOgFLau
	 G3rgUwvmR9iegfmxtUexjfNWgh2ygZY7BazzUiDJDHo/3Snh1a91YOO4raZr3Uj7o1
	 pwtFA4eUfQfEYMRU8tDX9ojQCZcpPIvupNrU2PR6YAwRRcwyAFPCIzHIb+p0KAHDD4
	 urngMWu6TRyE3c7qXRdPcQpDiz18mf3Y6EKgnexP1BIUgj/gRZww9Dd0Q2GVHql0Bj
	 aaaLa0RU0RKJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCB1240908;
	Tue, 17 Nov 2026 16:29:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AAA549B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C7C08111E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GiAgTN2symKG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0073080CFA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b146"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b146; helo=mail-yx1-xb146.google.com;
 envelope-from=36gr8agukdw878p2xv33v0t.r31x28t0-bx6ts-0p20x787.379370.36v@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=HbAZ1e5o
Received: from mail-yx1-xb146.google.com (mail-yx1-xb146.google.com
 [IPv6:2607:f8b0:4864:20::b146])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0073080CFA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:38 +0000 (UTC)
Received: by mail-yx1-xb146.google.com with SMTP id
 956f58d0204a3-677c4ca22c5so8192936d50.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927337; x=1795532137; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tncad3xb72MRHXQPalnrg31jkG++uAFsv3nTcMKPqIc=;
 b=HbAZ1e5o3zHKaBIp8G6FS71IusrwYBRYGahM7ZCdTvb7CRhWb/Lo3OoJEsnLRSw5nL
 7295ROuEaiFY16amT5enoaYbOTlqD9w8KPIdnh/2nvga321sRg3kfSFtgAeHXHunayUP
 Z8EfnjBSKZw7IKKmuE3yhZmnn8S9g4Fx4RuMbMJRUyrjspXK+LNK0OUqD3F8WGgT/dNN
 E0TRihSgk4Q9WRmmqb38xqk5JCDSgi44pMx3nAmutDAfw1ENhDww6KzZREEcLtuCpjXo
 ukZ5ltTRuTNDB+WEfW+IiUrGyj/Qpa8VHL9KH5oRg4lydTLQcX3bimZR14hKxijkemmE
 f/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927337; x=1795532137;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tncad3xb72MRHXQPalnrg31jkG++uAFsv3nTcMKPqIc=;
 b=E04VoEYe87QJNTjomW7AuT3Qw8d346d8BvUAgr1xsElWBgthuW8WYrNAUInZeV77+k
 rDMs4HoH1xE82rXiCW3kUyKSZETQXjtkK/tZKshfMAbTQDjFS8QAFvM69cCOxM6yvtxt
 VklAzfvCo/2vcHW8uUh7F23HcOEw/njVoi59FRKLeVN/Fwnq+kTU+Vop5OSHqxvPUNKy
 vsmkP3GiSjGJb+DhGKup4svUCLldaPhk65TfZ71+xvppzp+hyrqT9UtHXxluZS7in+88
 UWJYr4Q4aljOIQZnHwKSKCm+Q2OSs0gt5qz+HeGE/FIW6WKZVmG32cFX5QMRHxrsJq6C
 wPRw==
X-Forwarded-Encrypted: i=1;
 AL+hErFSXG22+1d/aCz2CrzgdighX3Yp4xpLVDzc63ubKaIrqOzW93FX01tLi4f3fleEa6AnWIuNYDcVCN7XYp9t9uk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/CE4uZiwvLIThI3SsJsRWw3MtvjP7TFzwxwd8R75o9awzi9s+U
 pTojtJmUneMZzJNbEhQW1Y8BRQsGOc9qklomPl68m16I8bT4oUllV9lFeNx29N8RBkD60rqOJmj
 x0g==
X-Received: from yxrk12.prod.google.com ([2002:a53:b60c:0:b0:67d:bd70:dbc8])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:408c:b0:677:cbfc:be34
 with SMTP id 956f58d0204a3-67d896e0019mr8711688d50.66.1794927336861; Tue, 17
 Nov 2026 06:55:36 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:06 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-1-stani@google.com>
Subject: [PATCH iwl-next 00/15] idpf: add PSP offload support, part 1
From: Stan Iliev <stani@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Madhu Chittim <madhu.chittim@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Nov 2026 16:29:00 +0000
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
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds PSP (PSP Security Protocol) [1] inline crypto offload
to idpf, through the PSP device API of the PSP core [2]. It comes in two
parts. This is part 1, which adds the control path.

The device encrypts and decrypts the PSP packets. Its control plane
(CP) holds the master keys and the security association database
(SADB) of the TX keys. idpf manages them with new virtchnl2 commands
over the mailbox:
- the CP derives an RX key from a master key and the SPI it allocates,
  one synchronous request per rx_spi_alloc;
- the TX keys are inserted into the SADB asynchronously, in batches of
  up to 101 keys. The SA index that the CP returns for a key goes into
  a TX context descriptor of each of its packets (part 2);
- the SA indexes of the released associations are deleted in batches.

Part 1:
- patches 1-2 wipe the mailbox send buffers on release, as some of the
  messages carry keys;
- patch 3 makes the mailbox workqueue visible in sysfs, like the PSP
  workqueue added later;
- patches 4-7 add the PSP initialization and negotiate the crypto
  offload capabilities, the PSP capabilities and the FIPS compliance
  status;
- patches 8-10 implement the rx_spi_alloc, key_rotate and get_stats
  PSP device ops;
- patches 11-15 add the TX key state, and the insertion of the TX keys
  into the SADB and their deletion.

Part 2 makes idpf_tso() run after the splitq TX resource check,
implements the tx_key_add and tx_key_del PSP device ops and the TX and
RX datapath, and registers the PSP device. Until then, the only change
visible on a device with the crypto offload is the capability
negotiation, which also logs the FIPS compliance status.

PSP is only enabled if the CP grants the new VIRTCHNL2_CAP_CRYPTO
capability, idpf works as before otherwise. The crypto offload API of
the CP uses the virtchnl2 opcodes 560 to 567, the
VIRTCHNL2_EVENT_PSP_ROTATE_KEY event and the VIRTCHNL2_PROTO_HDR_PSP
protocol ID.

Limitations:
- PSP version 0 (AES-GCM-128) and the splitq queue model only;
- the RX datapath only recognizes the IPv6 PSP packet type;
- master key rotations started by the CP itself can't be reported to
  the PSP core, as in mlx5;
- the PSP state doesn't survive a hard reset: the PSP device is
  unregistered at the start of the reset and registered again once the
  reset is done, as in mlx5.

Testing, of both parts on next-queue/dev-queue:
- each patch built with W=1 (allmodconfig) with gcc 15 and clang 21, and
  with gcc without CONFIG_INET_PSP: no warnings in idpf, libie and ixd,
  and no new kernel-doc warnings. checkpatch --strict only asks for
  blank lines between the new virtchnl2.h structures and their
  VIRTCHNL2_CHECK_STRUCT_LEN(), which would break the style of the file;
- tools/testing/selftests/drivers/net/psp.py between two hosts with
  Intel IPU devices (idpf PF, PCI ID 8086:1452), in both directions,
  plus a local case that checks that a connection keeps receiving after
  one key rotation: pass:19 fail:1 xfail:2 skip:11. Same result with RX
  checksum offload off on both hosts, without TCP checksum errors. The
  skips are the IPv4 cases (no IPv4 on these hosts), PSP versions 1 to 3
  and kTLS, the xfails need netdevsim. data_mss_adjust fails since
  commit 3c6e29760c13 ("tcp: Subtract psp_sk_overhead() in
  __tcp_mtu_to_mss() and tcp_mss_to_mtu()."): the routes between these
  hosts have mtu 4220 and advmss 4108, so the PSP overhead no longer
  reduces the 4096 byte MSS, as that commit intends, while the test
  expects a 40 byte reduction. It passed on the same hosts without that
  commit;
- after the tests, the TX keys inserted into the SADB were all deleted
  once their sockets were gone;
- with part 1 only, the hosts boot, negotiate the crypto offload and
  log the FIPS compliance status, without a PSP device.

  An AI coding assistant was used to rework parts of the code and of the
  commit messages of this series after an internal review, and an AI
  code review tool (Sashiko) reviewed the series. I reviewed and tested
  all the changes.

[1] https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
[2] https://docs.kernel.org/networking/psp.html

Stan Iliev (15):
  libie: wipe copied small send buffers on release
  idpf: wipe mailbox send buffers on release
  idpf: make the mailbox workqueue visible in sysfs
  idpf: psp: add psp offload initialization
  idpf: psp: add support for crypto capabilities
  idpf: psp: add support for psp capabilities
  idpf: psp: add support for fips compliance status
  idpf: psp: add support for psp rx key allocation
  idpf: psp: add support for psp key rotation
  idpf: psp: add support for psp statistics
  idpf: psp: add psp tx key state
  idpf: psp: add support for psp tx key deletion
  idpf: psp: add psp work and tx key insertion completion
  idpf: psp: add support for psp tx key insertion
  idpf: psp: add psp tx key registration

 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  15 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  16 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   5 +-
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 738 +++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    |  86 ++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 190 ++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 841 ++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |  23 +
 .../intel/idpf/idpf_psp_virtchnl_def.h        |  24 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  24 +-
 drivers/net/ethernet/intel/libie/controlq.c   |  28 +-
 include/linux/net/intel/virtchnl2.h           | 393 ++++++++
 13 files changed, 2376 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_def.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h


base-commit: 4cd5d9c333fb45a4e70ad6a77c44f13bd7312afb
-- 
2.56.0.679.gc527c65306-goog

