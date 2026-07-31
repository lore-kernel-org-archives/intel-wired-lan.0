Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E4BC54F54
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 12:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5B1F60B52;
	Fri, 31 Jul 2026 12:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ms2ITlSZE0k7; Fri, 31 Jul 2026 12:49:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1666360AD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785502176;
	bh=VtdjD1e/vpmmj2husgdgiPdzsCCitvPPyPIwmj8O8Ws=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KgkKDpru9e9Lkg5WZVu0bQenF0/i8jNszbBV3GwAsZHVC+kIYPWBff7aBZHeKOegY
	 U0Hl2pGKo2/y2uYRs3UCx2HXy/zJqvHMm+ENVR0cvV+crVIfdZfyDqibUtjxaTVWTy
	 lUzd/OCQ35gTY3Whnq5Vb/Uq2DydrfpbBqhumzFVY202aUgumt4P91BBV/Dfepj6M+
	 hC/OFm6DUHabStN8UEF5BE+A2ob/kMr+rTo77Kzhx9Yxp6sgJB22a1bapbF/ao7/kl
	 ItbyiNkVsNsug1faqZHFdLCa6qkjUeMD2GP1ij/8qXFG6tOqoh1+Xoxpm4TCBUQNKT
	 wIt+tzvuhSOFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1666360AD0;
	Fri, 31 Jul 2026 12:49:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D5DE37F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5482541109
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R4f5AFfTFhZz for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 12:49:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 89E9F410E7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89E9F410E7
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89E9F410E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:33 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81f64e8dfbcso12475707b3.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 05:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502172; x=1786106972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VtdjD1e/vpmmj2husgdgiPdzsCCitvPPyPIwmj8O8Ws=;
 b=kUaHBJuOgOB9jsj4noZwat34OpAvea1GsKXFL0cUWzNneT7lBgNMMgsQsK4OkkzLEJ
 aREWYxejD79G+/9bfVVczi6j0JO9YEzTGiciDNuIBBZPceYKY1dLUBXC8seiNz3j8bbb
 9ez9HXHKMvrNH/d84UYw8WGaQignRffivTvo6nuAOMrWzNMT209EHHGUX7N0ZEDIyLOV
 Fp1CJ4TpUVeWQProAkczcasN45eyc0q2i5/V1J8TSjqiWmlDCx8+cie/JttzVOKBxYgo
 Eoxh7iln3XMhTQakM7bKVGEgnJwmvNJ25lj+SBtOoGd0HecFuWGM8dzdq0lHZRDixB3X
 GeSw==
X-Gm-Message-State: AOJu0YxPyte7MD+WrTMLACzLHCJympqK+HFOldRbU4bn+gkrKyGLWcQm
 51VMYVsSfwEPcMjhbP13MIBF1FbO86ZB/4Wz8v/J+Zr5l7XnSiy4At0AUyGjQ9GM
X-Gm-Gg: AR+sD12nQ2XzQXGWKJJEj5ILktLuPIWQqePp3WkFLAWjmcqIwhBcUj1HQsEahjgDTO/
 cFi250U1dPcpXuOPyrLlBKrFS3c89K1Q8CEU/CDmIZPIr0TGJd23fo6CT41VxB8mWF7+JtqAGmJ
 2N+Ycg3m6Vux5oj/GbyyEy+Ulsh40gwKl4L3Pp+DbrUyENWxFUId4OP3FknepbYtswoAJBzFxGx
 QTRVEeCSMJp7gngzFNRIg2cO4wSXrU5o5w+BK4MstQJLAwbFNrytqRd+MumdEapF7hDGJkWpRqt
 8/Uczshz/ARLm0z0Lags3cSE/R/aRxJSucZ/WLv7CAibugp9iUSGP1Xl7fmwuYHDpnGz9CxO0M2
 7vBo60wkC/9BA9k9FfFF3nKE4b2h6whB+jzjTaYnqHbdSl1JD3BGEKM5gZ83cYI4h+663SypAgf
 e4ApLsaEcOYaWHXSK5tlI4Qi6u0v8Q0JymJI1bYkk3
X-Received: by 2002:a05:690c:4b85:b0:81e:98d3:cac7 with SMTP id
 00721157ae682-81fcbfb5b1fmr14136117b3.12.1785502172163; 
 Fri, 31 Jul 2026 05:49:32 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fcd108f0bsm5695367b3.35.2026.07.31.05.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:49:31 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Matt Vollrath <tactii@gmail.com>
Date: Fri, 31 Jul 2026 08:41:06 -0400
Message-ID: <20260731124109.99065-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785502172; x=1786106972; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VtdjD1e/vpmmj2husgdgiPdzsCCitvPPyPIwmj8O8Ws=;
 b=IS4w0E89cFz7fKbQfWcxaqxOBj4ywPJVWfmJnNPGVaKwDKw00xMxjEPVDMiLxjdXYY
 9mGRtS6yP7EcsRAbCz+dgxBFJ8KcRJei1cCI4E5JsXzUuEiQXsXqKRdUjUobiMHbsaqa
 RXvpU0kPmzj76bxNn0rOtpKFem6hr2ubVnxsUjHLwXmnp3OIgcZjpOx6+wUaKxF2SjKr
 nkHKK1f0kZfznXxYP88286OptcrctVFVBvln0Bgl+X21mzJRImKzlJnEVpio/XhQUzZa
 Mt1kb+4AY+KHO+jyFMS3ZZkT8NBVFb01hRoi3NCynprrf5mEBQI/BxrOzeUz+yT9R37V
 kNCg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IS4w0E89
Subject: [Intel-wired-lan] [PATCH iwl-next 0/3] iavf: defer loading
 netmem_desc
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

In a few places libeth and the iavf driver inspect which page pool is
attached to a netmem_ref. This forces an immediate load of the
netmem_desc struct for each buffer in the Rx loop.

Defer or eliminate these loads of netmem_desc from the driver fast path
by using the page_pool ref in the first cache line of iavf_ring instead.

There are only two paths out of the Rx loop where netmem_desc needs to
be consumed:
* The "very rare" case of libeth_rx_sync_for_cpu calling
  libeth_rx_recycle_slow and indicating that there was no data. This
  could be similarly factored out, but not by this series.
* GRO merging a frame into an existing aggregate stream. In this case,
  the cold load of netmem_desc may overlap the payload prefetch started
  by iavf_build_skb, which is now no longer dependent on netmem_desc to
  start.

Matt Vollrath (3):
  libeth: add __libeth_rx_sync_for_cpu
  iavf: use __libeth_rx_sync_for_cpu
  iavf: use cached page_pool ref in skb helpers

 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 18 ++++++----
 include/net/libeth/rx.h                     | 37 +++++++++++++++------
 2 files changed, 37 insertions(+), 18 deletions(-)


base-commit: 5c458073553f0ef74f5c8db1bd459c87c722a299
-- 
2.43.0

