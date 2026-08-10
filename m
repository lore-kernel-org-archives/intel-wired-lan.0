Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698A9C5B567
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 18:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EEDF4069D;
	Mon, 10 Aug 2026 18:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJENe8m_zBU3; Mon, 10 Aug 2026 18:47:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0FB840684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786387676;
	bh=/bAxJNp2NmtcJDSfK/A8JjF0qJRtyo/oUMnpIAtF1l8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a2v2trEYDI9uf23x47uJKYeaChX0lz8PSYUDdjod6JFYFEFm+1DtAIc9nExQ1HjUe
	 8z8JcPdqDANZBIyc1Z3+q+ENdODbSIjrTX2OaHWzZRb+LFiXXevQ6oPBcSQj31L8CS
	 cGmoZ7khsX9paMWcvfiaPirPGmMNYg0I1/I1wTIkAamrU1yGOBBJaX6uYt/2zPhILt
	 36+K3M+qM/XVQv3NSuAS6h5ibCLhUxsTVoFChxAd9jN2GBvttT4xZXOB0PDMiSNPsp
	 OL9u6khR0qIChDL2Ovbi9aklB1KG23kBCsJcilRhVNh/dRXiu5IhDYA6e6NEaryR1/
	 1KO4eRKq7FNaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0FB840684;
	Mon, 10 Aug 2026 18:47:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE0A924E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFCE840684
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yuVzFw36wgMa for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 18:47:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::1;
 helo=mail-pz2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4B22440526
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B22440526
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B22440526
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:55 +0000 (UTC)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca034c989e2so1225630a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 11:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786387674; x=1786992474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/bAxJNp2NmtcJDSfK/A8JjF0qJRtyo/oUMnpIAtF1l8=;
 b=QD46QBsFtAkZ7a9Ps/k/Wo44PvPJ2OFJQvJbR/JygUeNM1UuzdKnU74etMeSPOETJS
 lMtw5HIBplC2zTILdHZltjdczty4PKpEZm3O6xspRGRLynMD906in62J8DpsOvIXhfja
 /tjxrY8ZplFx5z+9sqPguMIRGmgyAnNKBAIm6zarouoQINEgbEDfLVhz+63Wmph3rsyf
 RhBC7kjv0EXZtmd62QFh6YScUZfBt/EOeRedKjMLyWglfXIzQIF4s4DhBNYKfFWUCxME
 VHs6+R5PxwE91LSvK6f6L5+zOv5p0K1jJRtKetcEXJd380i2y3No/uhwssSMZjo5CNiZ
 b7IQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro//20OK1jYLao94zKNI/wFJqHBqs+TcqMmLeLldPd2fJ7FM1uXpKgiSBB6/W3OiTxTxqE4NfxbiWhPi6ytIr4=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yyf9TU2vaBW6BlQsSZ1zum2IAg4n9H5Lje2fDsqdZdteenD/OKC
 v4N8/gpl0Z/s8EubxWy1NY6+2J8DPqpkthNj4wrMq3t6YJ4I+QV5Bb8G
X-Gm-Gg: AR+sD107oPUDoEQLxfZjMtnV4fuzrsReD3kPm7VkJFU7bkrDFUpfgm9TWeJxzOxNfR2
 5dvi6FlG/6x0fCFFTsBWBwo1U7l8VQ7pupZ3gLH86yBfiCUApZdBycYOG5KSBfEBkkRfrFkw6VB
 z2SNInWKVrzKJ6QMwizX/6dtY20TXQPFEHuzpn5vEIJxw0iqCUjy6Il8jdzJ9Ugt7K/wGHx6QXf
 BMQPnUataoHKEIGjZXcSEc+1TBBgZ9FVyWwcR49P5N3J/OE1I1jKs5ORESfNYDfio7IbYdJItlv
 VTikVFVARAFZHgJp2U8al1lMyReNxFiutO9nzRkQWRR4LnQK5lOIbR1oqlM9XYxSNTt1UO1iC14
 c6kyHrb1cCxYeegP3acWR5V4IzaNQ36qFtu2/sGengt9R+z2vESubNhpQcdpKKHpHujs0xqQZgn
 YV91/6WJRz7/DOS6aYBDUvhyucq5wHTNBC7fU97iBcrucSdH1x1YIrAw==
X-Received: by 2002:a05:6a00:3987:b0:837:e9cc:d46e with SMTP id
 d2e1a72fcca58-84f9c965aacmr3341745b3a.21.1786387674437; 
 Mon, 10 Aug 2026 11:47:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a51d88dsm4244979b3a.29.2026.08.10.11.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:47:54 -0700 (PDT)
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
 alice.kernel@fastmail.im, dtatulea@nvidia.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Date: Mon, 10 Aug 2026 11:47:50 -0700
Message-ID: <20260810184753.135756-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786387674; x=1786992474; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/bAxJNp2NmtcJDSfK/A8JjF0qJRtyo/oUMnpIAtF1l8=;
 b=D3t70nG+OvqhpZhD0P33dcwd+DhNSGTWMWarxSKOpA21tswrcYPFzaHlVpUbvSwPwY
 IbU9eZXzSPnIQSwJrprgpYa+I1dhTUorVkxjakon0F+rYEDJXYvKVEtRPT9FrUCq0DjQ
 h8iQyMLjoTDd8DLPzgeG0rK8F2cBVHWvPnVDZYA/XCndnJuYnZIBkcbHZ2DLCCuc4XqQ
 cr2Ol5iLby5GjGcS0b14ubOF2M5SLZj1VGD2wSR/ntDhnZGMxfvG/0U1IsHjzr1MgaeS
 S0reqPIFn91MnyoSGZ2vogNCGX6vmE4rM8P3DONWGPLnraJ5qy46Kj6Ti9fp5pX0WTlx
 EcWw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=D3t70nG+
Subject: [Intel-wired-lan] [PATCH net-next 0/3] xsk: pre-existing AF_XDP TX
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

