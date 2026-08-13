Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4210BC5DF6A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 19:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E866540C85;
	Thu, 13 Aug 2026 19:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5EvtuTjQA90; Thu, 13 Aug 2026 19:08:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6127040C8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786648087;
	bh=VCh4FhUfWPAIY5oCHgOyENQTN+HS1fAJsuh3sXLGPjQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kFJvHrt2ePc0452lTBSijQkItOn0P1WJ/wfC6+hACxcOjoi1D7veJvTMQcIgtK8u4
	 /xTIRm3R4j0oiIVi/lyZY7Qu5Xfpl7AakKkw4hcb9RR+GxPfYScTn/oR6iYYAxOo2H
	 9jHDnJ0agWlE5TYlPEsAAKVDGkVh/rD6RQPkp6sJcDtIJ768dpPKyvy+6QTyNosTN9
	 vX/TKUvddzopIERAhmr6f+urqdR6XxuOAOu00H6Wy0aDq6J6QcwEBR/N+NELp7KVxR
	 5txG1zRuJrq7rIcH6DY9o2nyjyFMnUElXZ0BOTbeOOUw6O4+KwZH2B6g54CPKZbuZp
	 tbl6w6QUdrhcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6127040C8A;
	Thu, 13 Aug 2026 19:08:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0106194
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92597409EC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kSDwwVibaF-J for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 19:08:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::b;
 helo=mail-pj2-x0b.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6C4A640A1B
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C4A640A1B
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=d4KADUpr
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C4A640A1B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:02 +0000 (UTC)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2ceb5a39c48so1001125ad.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786648081; x=1787252881; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VCh4FhUfWPAIY5oCHgOyENQTN+HS1fAJsuh3sXLGPjQ=;
 b=d4KADUpr1HcnvNtIuML8ycXTBEgg5FSmoqQ8LVAt4iUfNtfDXhfoqOrweKZGF3mXmu
 oqTvoCmz7eB7C8fgEnIal0lK3P11WDw4QtIHtJ9O/OCrArF7CoW3JPacVYIfgj67Gm3T
 9rEmRD1IC09xsxm7JS29tS5FkE45dPMj9HVk4CJzBl6X2F2fKIhWsID7IqDg+6z4w1Bw
 HZ4WLZMx/DgYe+h6fH400JUgmtRkjIMs6gY9rUhP/xf86+iqshMFPrK5vdF3tXrF8mHM
 5vSq/mLMsh4mtv00v7AEuQDiB/HZyC7e5uiX82w/u0FLiWk/Tyjjel9L4IR7ewIsZo/4
 lQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648081; x=1787252881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VCh4FhUfWPAIY5oCHgOyENQTN+HS1fAJsuh3sXLGPjQ=;
 b=Vz/Ls8V8c1sKM+6kHmjD035Ar4++EIh5X4SelBBld0koZrayueMI/oYEWdXw34iW+H
 191G3wnZVf8ab32HgMeXeq5Mydmda0+ceR3aJvPXxzIJ0D03xFqfcCFFJkteC9+v79Aw
 EOp7w9kK12zVi4QigNgRLAOAoJCCfr84NgStzVgwekIh8LiMciLD/zVO4KFTnElS9EM+
 r0W12R4xprJ7fqnGIs9X4i8Aqq0TLapwAIJSYNmuc2KsrnGr7oc1wxujk86SHsHKotvQ
 e4d3HXp7uoVKC37/rwrFDDnFk5qK4AkWuGVt3dBRYwgIGrny+i9u9xdpaHz17UDSfkGh
 5Adw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpnk5HyXaq9akhL4ruo+WSyLnU4gFLjFR4GL2F2hhsOLMMAH6E9tDjZNI9OdMAWZIXgvnA2GkdFdl8A4oCTiG4=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yzj1ELDNbmZbGvLQqdDE8JIq/05bpdge/eqHxfnHxxA1Gg0+30y
 0hF/lOlYbzSKa1tenAUBSnxS/CkfzJAbte82cA4HQ+aR5doVG9RIgp6D
X-Gm-Gg: AR+sD12WIa7ALpVUOPyHPi30Njax2iaZH5phXO9N+C1abuFJWA/hkja5NtgOaqumw9J
 RGpQqHVILjGaQj10DWW3bZGhMpRbHGawB9M+sdon5IONn64OHpCvOc5FwNmDEHv2X2hbtBJoZrC
 ehQHqauPQhycNu9X28ASvzHnueebY6na+F8MWTD8mEsChpNSItyDten+C4qNojI1Su/0cj5DEGr
 YyILFKa1jYe5jLTQq5hf8CWbSURRMX45iWxsixR9qPAqr+g4UCMLLI+fI3HcmYb43te+TcQ+qG1
 ENS2wCZSilEvBwFeYkpKG6MrVGImz49XFEbL/dw3CIOUPVM+KTu743M1O1a7z3I4QwBcgfjPCNN
 7NrPy7amoifbtf5DItffK469Yk6DbGetxJ2VEJLd/nKgNMqO8oKrdRpRlSbDRTh+vYsUsinSTDh
 DrDKj2N8hf6GN70HypIcufSZBkZkRtKpLdZa3AXfCH7bxNRFab7YHN4Q==
X-Received: by 2002:a17:903:1b66:b0:2cf:b68a:340 with SMTP id
 d9443c01a7336-2d3b0c43462mr1698315ad.10.1786648081499; 
 Thu, 13 Aug 2026 12:08:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3aeb78d20sm1310695ad.57.2026.08.13.12.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:08:00 -0700 (PDT)
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
 witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Date: Thu, 13 Aug 2026 12:07:57 -0700
Message-ID: <20260813190800.222527-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH net v2 0/3] xsk: pre-existing AF_XDP TX
 metadata fixes from Sashiko
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

v2:
- target net, address clashiko feedback (mostly here and other commit
  descriptions)

0: from https://netdev-ai.bots.linux.dev/sashiko/#/message/20260810184753.135756-1-sdf%40fomichev.me

Stanislav Fomichev (3):
  xsk: align TX metadata layout across ABIs
  xsk: honor XDP_TX_METADATA in zero-copy path
  net: stmmac: skip queueMaxSDU check for AF_XDP

 drivers/net/ethernet/intel/igc/igc_main.c     |  3 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++-------
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock_drv.h                    | 22 +++++++++++--------
 include/net/xsk_buff_pool.h                   |  3 ++-
 include/uapi/linux/if_xdp.h                   |  1 +
 net/xdp/xsk_buff_pool.c                       |  7 ++++--
 tools/include/uapi/linux/if_xdp.h             |  1 +
 9 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.53.0-Meta

