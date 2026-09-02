Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137E8C61DD3
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 03:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFAB4407B2;
	Wed,  2 Sep 2026 03:29:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SqkM2q_8IiUG; Wed,  2 Sep 2026 03:29:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788319779;
	bh=BpoVdObqkq/zS7Ov+RMRDQgEpXGAbsWdSRwORcEMa8o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FOtZiEIigZmJXJ6he4gQ7mcdSGGdl+s+hsSkLC5Sw+qnHn442W+Sn/acMU8FETCq4
	 bfOW3D1SfvaVj1IAaWBZFBra3fb3C8/ut+kizEFxXz2sA4ZV1btp3XHc4IfQmdRpzI
	 k41Rpx31pT/ml8NQN9s0sVLjyxWiLzwIbpFs7uQEtubq5Mpx7gT7KRvBkwW/4hejt/
	 lYo3olJTILiPaEASUHpZMD1pbADvrUCYuKIO3L+2SRQ2tTFjuO5J491aUEGNLFM9Rw
	 IgwSHk3xHQsL+KZHy764AavjkuYvu8WeaLIaXs4oGiGo9aNcDgyrmKOZbOmzGKVfrx
	 Jnaz/54XHNJww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4417D4073A;
	Wed,  2 Sep 2026 03:29:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5005C2FC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38DB780E27
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zb6WSoFiBSwo for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 03:29:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kJjsINsJ
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D50680DD1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:36 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso484572a91.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 01 Sep 2026 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788319775; x=1788924575; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BpoVdObqkq/zS7Ov+RMRDQgEpXGAbsWdSRwORcEMa8o=;
 b=kJjsINsJIhTtijmsgHxv17acvAhU3v6GnSxdiR5YxCjczWHkVoTNGOxEgZwfdKbbPp
 53jcZeQhT9lxNOjj7bQ+rUu4/i5B4Khlp5gm5U9x+avSWHaNjdGLp4nv9Tgn1Iezxl7H
 zRuAZivX/IZdWKAyaziZDKh3w+Kc+eHyLzKavjgB4f0E9z1fhCJb7vAfS5YF8e+e7TcG
 NcWLZEWdH8gNWfrwUgfXI5occg9mAOC7i8HcfV+16XoprLRYmw7Hj5/KBIHiMwpCzFbu
 J+2DdCWZNjgcubt7c3yXr+oMF4614RCHXFfcAKlM7NWudYYELrpI1CeOhAOuo51apffr
 J2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788319775; x=1788924575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BpoVdObqkq/zS7Ov+RMRDQgEpXGAbsWdSRwORcEMa8o=;
 b=hhI/Wbecn8lt0F1Gu6kDDwhKGTA9USo1qInw7lSJh1bS1+f6/XJCNl78wd5FZ5AclC
 00wGO6pmD/byha9sN3tdVnLVpL1XDlpgynMVVlysAmGQntnIzuUubfvga+WLuFpP2Xq8
 8JG3RQbePuDAmNiieOUJvapw98mHGPgqUYRnvHQFxjUjBpXIkh1Imlx3NIsmb8zRx+rY
 wgMD+3fFe5HQsJYx8veOT17UiOkBOPOP1c23zmQLd3YebMuKWSB3FQz2JxGRP8Hu2+d6
 y1p9ipID4GC2jhlLB4iuMXQFKaFizIPK8NesKyofV9p0PhAQEB2Y2V6EPfg/FaoiD3qi
 0KZA==
X-Gm-Message-State: AFuF++kKNovd98nqlEV4o7aLUqG5yLrSh+4CfdB3WPN6AcpMGhHf8oLP
 /X7mnJz0CuGAKAWI4rGvzDMDr0uHrJRBnk4OynelJryW0X2sBPXebM4yLGShw3MBluQ=
X-Gm-Gg: AYBFou1xdlWAVfIwQfMMBhk/1v2bVTmYFTXAc7EGiLZTtWPrW6L+RgQaeD/yHftGbhU
 lvZZ4Vja28P+O7oLa68XQy27AiQ2dtDNteJzEdJplCNb/aA9MvB8pB5l2VjlkFj3/PT6fDdHe3i
 B12AmGxsY9nluclEGKQZAXdltk5tplSW6loal6o5RH5sZ/yD7yK7H3z+gX1UQzcYiMEFmLEEVT3
 BborcIcSwJO6wN8ZCH1NBKu0P2udLG1blVBtom+KG3kfqN6k8vMNhf927hQL2O9eztCK2Km6Oop
 pYaI6C0LO/u27iJSD0ytsJwb8hSqLoxYT7fmKFVeGx7m12s/Li9f8SV2RgV+f7Zi1Cr52GMiZPd
 av88zzjm/Yf7p9Y+JBUVnQH2GQpyVLGo40bslA4/HGmWUMz3hccsZmEHWnz4ZQFAnU4F8OH26SB
 L6ycEGJRR9ULDgFbY1bkQnADOMUeO75F/siUIU+qP3
X-Received: by 2002:a17:90a:ec85:b0:395:5f43:4ec4 with SMTP id
 98e67ed59e1d1-39aedc3b980mr2784795a91.0.1788319775344; 
 Tue, 01 Sep 2026 20:29:35 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07baa594sm3099307eec.22.2026.09.01.20.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 20:29:34 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-net 0/3] e1000e: fix Rx bugs
Date: Tue,  1 Sep 2026 23:29:10 -0400
Message-ID: <20260902032913.661570-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Fix some longstanding bugs in Rx.

The first two patches address DMA mapping failure handling, eliminating
some conditions which would result in DMA_MAPPING_ERROR being sent to
h/w or to dma_unmap_page() or dma_unmap_single(). A teardown leak in the
packet-splitting path is also fixed in the process.

The third patch fixes buffer overruns when RXALL is set.

Matt Vollrath (3):
  e1000e: fix Rx skb DMA map error sentinel
  e1000e: fix ps_pages DMA map error sentinel
  e1000e: fix NETIF_F_RXALL buffer overrun

 drivers/net/ethernet/intel/e1000e/netdev.c | 75 ++++++++++++++--------
 1 file changed, 47 insertions(+), 28 deletions(-)


base-commit: 1d2929d0850fff683b8aff051275945e65f082c8
-- 
2.43.0

