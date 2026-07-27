Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D22C53209
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE40780E75;
	Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id syAklbhlWm9e; Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24FF380C10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785169204;
	bh=EBHchiXE2dARhW+lF5cUbUC3sGgHoglb/2VvCgkoEgQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ik4DV6AlkJ/22H8Jk3dRCcNgSxtSdmyr+IkpzdQF7m/MGqS0NMCGEyB6EGQXyoG8g
	 w3Gu33vvvG5uRArXVkiDJeZzYs+YtSWAm9xW0KNA22jd5AoEM5OZbYiSRxQgjE/+GT
	 9wjp1PnEH0HS2i7ah5Ve9IPd/2uaRHl3wTl1ag34zQeNlv3sFwRxlTMx3ogJeH8Qod
	 s30Q1w+2WgE6EUil8K+hPXXrJw2s1uksnP8p4Tm8WQY64s2uNu3lIcNI1tCmRhoUdk
	 tZwweGFCWgNAvW8+CChuCxIAljFXMkr0UBvX7kg76a2SbeNQkuMEU3/v86N/wEuZL4
	 My92LjIyt+NIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24FF380C10;
	Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2522C357
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AD5A40172
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sfrwkEeIKyHG for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 16:20:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::;
 helo=mail-pj2-x00.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 38FFE4016A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38FFE4016A
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38FFE4016A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:00 +0000 (UTC)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc73acd2d0so1709285ad.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169200; x=1785774000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EBHchiXE2dARhW+lF5cUbUC3sGgHoglb/2VvCgkoEgQ=;
 b=p4B9mqtf9V8xOk7Gm/4Q/5svQIwjfPiQSIM9rgy/dsBnMSW5+en5/4u4XT8gW9FsrA
 vpV4upY9nVgOgFVBnIPZeXYQvxf/2VpZZT6KAqknAjmuh5oaMd1VByc2+ULg8gVeB0kd
 m9p7qhDfnSUly8KKOzNthyoeFagEGbhcw6diwVd2wxxsw7X49qc8j8d67D6TrsS0utr6
 w0p1UPKM0xthf09cJZx84T1nq17ED+Z1CckHuQrQmTKf0kATqEnZbnfggV8r5uOF4rl9
 LszGUQOPu9Yotd2v0Sr1N2PS8Pk404dm9Lc/zOB4icmL0BDyT9bKtWlDeUNN7Zp50ZUg
 BBqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPCKtaLQUpx6juF3K73+L5Buc3JqcBo05//Zd1kk8NGgcvbDrhC81D8dfjBFGvtlIAW1vTIPHSXXrr/mX85dM=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzBnLdxoMaawMajsBdHyJWWH+MZ31TYobz+shKDQSNB0mFmuuCg
 5v9o0b3ytEQKutp3XguLq6ExamsP64h/mkttpDMBb992aWkiqTsMqFeD
X-Gm-Gg: AR+sD10Og+dBdb/fY4uXh4MYbPPqzEaPfPtpIcdAppqHw3hLzCO1nnCHugvlIzhSPMs
 qIV7StBb79WuJkBvyGFBN2QxXGa7RDMfppfJSp/MpvPsdPjIZjFndSBkpeGzKZDYWkviyLZurfE
 a2YhYUF/KBljvc2kujo7V5Z99sZ3ta4R4W75Y1GttZ2wECMCD0QcL/F53aXWHyS3XGgPISxkaDA
 r5QQPUqskSLdNrwndwuAjGPllRWFznv+mgwxhsSvcmE095xl63TQKZY64j9WCM7XRxvI5sQ02Ht
 9b3uAsIQJ2Q9k/sQCYXGvmVpdkMK375W1Gl5erkV0ZrCkemrvdYuR/+CLy+yvLTtu9fNHBPzHOY
 ZoefOlRQmg5whBACUrsm8fOh6DjN0T5g0cse1xUf7IyxArNBBuXdhe758R54yRziWWjrA0g==
X-Received: by 2002:a17:903:9ce:b0:2ca:c847:8e41 with SMTP id
 d9443c01a7336-2d00e7f7ca8mr978145ad.11.1785169200191; 
 Mon, 27 Jul 2026 09:20:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde5c7678sm38144985ad.18.2026.07.27.09.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:19:59 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com,
 horms@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 witu@nvidia.com, alice.kernel@fastmail.im, dtatulea@nvidia.com,
 yoong.siang.song@intel.com, martin.lau@kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, leon@kernel.org,
 AutonomousCodeSecurity@microsoft.com,
 "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Date: Mon, 27 Jul 2026 09:19:53 -0700
Message-ID: <20260727161959.885642-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169200; x=1785774000; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EBHchiXE2dARhW+lF5cUbUC3sGgHoglb/2VvCgkoEgQ=;
 b=kD6IhkNPPG92FYiOdJTviodgh5Ai0QidnD1oCQ+PxT/WOyo27tSy2+MqF6dpxp3RWB
 vzElHnEjZGzTYYZsY+0e5pTsWg9eNDIYSmEGS/xn5lia6Sj4qa4XdyfL67xRjkcaXsGQ
 j7amcuipNk+/QdEJW2NMtKJ6la6Mfa2TxTcgBBOq6MfUSCkqKL87ylGwo9Fm/M58iQ4A
 +K0/CcAbtBSbwW8pB88k/4pBtbQsoL8gwZU4liH+iGrJ3XtoTvBD2sRjhWQyySTUPKrA
 pzCEZvRoXRY28QDC1lAb0+IgCd0H4h++TkImJPk33GoUz6fPhay7G6r0eOtYV5ecr1Eh
 qJRw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kD6IhkNP
Subject: [Intel-wired-lan] [PATCH net 0/6] xsk: harden TX metadata
 validation against races
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

Cen Zhang reported a KASAN out-of-bounds read when AF_XDP is configured
with a TX metadata area smaller than struct xsk_tx_metadata. The metadata
is also shared with user space, so reading its flags more than once can
produce inconsistent validation and processing decisions.

Require enough space for the flags and one request field, validate the
launch-time field against the configured metadata length, and use one
snapshot of the flags while processing each request. Carry the validated
decision through completion handling so later user-space changes cannot
enable an unrequested completion timestamp.

Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Link: https://lore.kernel.org/netdev/20260720155210.34229-1-blbllhy@gmail.com/

Stanislav Fomichev (6):
  xsk: require at least 16 bytes of TX metadata
  xsk: pass TX metadata pointer by reference
  xsk: clear metadata pointer when no timestamp is requested
  xsk: validate launch-time metadata size
  xsk: move xsk_tx_metadata_request() to xdp_sock_drv.h
  xsk: validate metadata when processing requests

 drivers/net/ethernet/intel/igc/igc_main.c     |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 15 ++--
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  4 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 +-
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock.h                        | 45 ++---------
 include/net/xdp_sock_drv.h                    | 77 ++++++++++++++++---
 net/xdp/xdp_umem.c                            |  2 +
 net/xdp/xsk.c                                 | 11 ++-
 net/xdp/xsk_buff_pool.c                       |  6 +-
 12 files changed, 101 insertions(+), 71 deletions(-)

-- 
2.53.0-Meta

