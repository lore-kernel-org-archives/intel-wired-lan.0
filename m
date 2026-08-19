Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD3AC5B572
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 16:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2643605C9;
	Wed, 19 Aug 2026 16:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PXhl60MDMZ_K; Wed, 19 Aug 2026 16:05:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787155541;
	bh=8jkkIHI4R35tfZea7PHfGNfeEKUbdMreB+UNwExCspY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WQfMGgRxo4cjcW2ZDXfqHxP07GJbRLivORTd8Q+CuGzfwlyek7pwHHTbgEz7OpUaM
	 H1w33pbF+7waH1JbcOKnSuWauZm82vwftrJzJCmtjKA2Ro7C0gzBrAOWpxcvkvQyLl
	 2o3EKRmz46U9g07GY0QE1rQMnWylDUo0NUf2StbouAeFFnUz52H8GqN56E95f/94ZR
	 VAwY/4PR4RC2qc3OHp9Y4WPK9K7HZukj+MTvAX9u488X39Ye0uwKXMf3cWkp9IShMs
	 HddKY2U9T3BZ2X1G9L31PUL51qoD0yTQsk2nxwt2A1d+/QuQVtuF50Co9RHFYMJPVo
	 GXf8FtY0osjEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36B59606F4;
	Wed, 19 Aug 2026 16:05:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 447711EA4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 16:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29EDE405CC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 16:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufxULEbdZdKs for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 16:05:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::9;
 helo=mail-pj2-x09.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AA0BqCHI
Received: from mail-pj2-x09.google.com (mail-pj2-x09.google.com
 [IPv6:2607:f8b0:4864:39::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43A40405C5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 16:05:38 +0000 (UTC)
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-38eaa0c5df6so135577a91.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787155537; x=1787760337; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8jkkIHI4R35tfZea7PHfGNfeEKUbdMreB+UNwExCspY=;
 b=AA0BqCHIG/oVxJQ+0nPbQcAicz9GCxI/eL7EvOUuYzh+Ei+MftLJObux9ijiEgLRAc
 qFE8M7h6MHJr9JN97OBTl+ptqPQtFAs9E3J2iS1m7zMn6iGBME1LJntqUmkIgu/4UWZO
 b1nCSGsiIeNcToZr+NbJlsPWIw3Ckoyvrj6Qf67+w1pri6XNNr6n0ZCULCcafhuPTK1Q
 s/6jh7IG1Gj4UA6F/KUI4E0+be0xi5ergBGKFItN8DNUqEoVnRLc/CA7zJIxnDhgrvHg
 eJy5v/e8JAHAuVAeSwYLI2BKoI8JSf7IECC5BWp1eprA/A7ST40yxtGkToA9ONeBScnp
 es5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787155537; x=1787760337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8jkkIHI4R35tfZea7PHfGNfeEKUbdMreB+UNwExCspY=;
 b=YTwazbGgaXkhZF3Nq1iTrLeFv/bA8jdgrJt/yTnGE5pJEg2bc0mjB5ql70ViayePoE
 xPxnhevvItNTnqoBFSjiLNyQU9X+drgpVuB5SyNML/E3te0t5yG+7NcS+nUo3oKce8rM
 bVsTzV82/jlDdZtitfBY7Dme3H7q7nZPe5qYrQ2+UgpW4G2VHXzeDPmiFHIh6pF4o9Fy
 9+987ZwZbNj+zpgc9a2BOzRgCk+qNlcXTJdLoO7Du4QYn6ZAjNEqM//51Lu9RVit7QQ/
 1wb7Q7R+soIbJtURAiPfvaA612vJ+NK9XMhw4Z+i48zFvyJoNKmHhwX4aCZ6+EjXWQnt
 NLHg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpw+9Zsr0RZVnK6g+cdfhXlhVI/DLzb6p6SA9tgjwFn6YSd9IelOslX6b0MByLZ64bw1cfd7mAUEwiaiC29Ai4=@lists.osuosl.org
X-Gm-Message-State: AFuF++n+2Yvc4kHQ1+72d4HdKIomGMF8rz0jsGGZWr7KuZhO37l1mu6N
 m8YOZJIXm9uHiCdsXEp9NjdsE+e7R54kX9VBjwQ2AZthft19m0DU8IPo
X-Gm-Gg: AR+sD10D+Ab6Vf3TVhOCUquWJxSbflt2iqrahswdiz9vUgAA60EoGZWDqp38eodBS3z
 C+7Qt7QzumB+43gMQEOzmbuta1ZCjSWDT/7hIdmlYlHKOi6rcVWl3hwkonI6zaBCTCDn2aw7kvn
 e3c1nr3ivmGEtTACvDQYPJWZm+rDF8LnlzK8WyALOyXEpGmgAzyCTw0HCrBTDVVj0qCeOrYVG1V
 nFDPWr/wsS4/uKiZm3SD42q5NO9TtOK3LmGGazWNjPqYcBmOAP7JSGHzRnONlZ90RdDq6vdvvnl
 IoTBd/yfAGAs3CcdIYgDBoR9yvV9fZB6KSKFAVDGiixzkzwAVg6prv6SfQB8M9VFP0scfIg41Ys
 EWaxNG3gHBa9GK1CYuexoObUeWyb9HFFd38EvX3cZKLR9IOLsNII8IfGx0K9y7HJk0azJV9gYcs
 DmmIojHV1FVWTRASbgTfMYjsgUts+SuUx3nBalBP0y3+lWLoqQL81w0Q==
X-Received: by 2002:a17:90b:2584:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-395a074aab8mr140125a91.10.1787155537339; 
 Wed, 19 Aug 2026 09:05:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fbbe817sm1267610a91.2.2026.08.19.09.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:05:36 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 guoren@kernel.org, dtatulea@nvidia.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-csky@vger.kernel.org, leon@kernel.org
Subject: [PATCH net v3 0/3] xsk: pre-existing AF_XDP TX metadata fixes from
 Sashiko
Date: Wed, 19 Aug 2026 09:05:32 -0700
Message-ID: <20260819160535.1472459-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A few fixes to address pre-existing issues from Sashiko review.

Notes on the feedback from net-next v1 posting [0]:
- It correctly complains about ABI breakage for 32 bit systems, added
  an explanation why I think we unlikely to have any 32 bit users with
  launch time
- mlx5 batching (pre existing) - I think my point in the comment still
  stays (that we do not make it worse)
- stmmac recycled descriptors (pre existing) - seems valid but I don't feel
  confident sending a vibe-coded fix
- stmmac queueMaxSDU vs taprio offload - don't think this is real but
  we can fix separately later if it is (the existing issue with breaking
  xsk seems more real)

v3:
- update first patch commit description (Arnd)
- replace last patch with a comment (Jakub)

v2:
- target net, address clashiko feedback (mostly here and other commit
  descriptions)

0: from https://netdev-ai.bots.linux.dev/sashiko/#/message/20260810184753.135756-1-sdf%40fomichev.me

Stanislav Fomichev (3):
  xsk: align TX metadata layout across ABIs
  xsk: honor XDP_TX_METADATA in zero-copy path
  net: stmmac: document oversized AF_XDP frame handling

 drivers/net/ethernet/intel/igc/igc_main.c     |  3 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  7 +++++-
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock_drv.h                    | 22 +++++++++++--------
 include/net/xsk_buff_pool.h                   |  3 ++-
 include/uapi/linux/if_xdp.h                   |  1 +
 net/xdp/xsk_buff_pool.c                       |  7 ++++--
 tools/include/uapi/linux/if_xdp.h             |  1 +
 9 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.53.0-Meta

