Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8A1F483D7
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Mar 2026 18:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5077040BF1;
	Mon, 23 Mar 2026 18:28:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l162JLd3UT82; Mon, 23 Mar 2026 18:28:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCC4540BF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774290511;
	bh=tVKv4h6csSNr26F3fg2SyyHjtvzkcdDJQ8W+IAxz4h4=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vUW7abtp4z0DvumuxbzHQ+VtMWV4sDXenFluBSPRR9UXUsezqg1EWaZu11OlBVE10
	 DZK9ovpt2hCx0doJ6MwVrvMO81GDAN/frPaUtHVayQ4tiPwL11/Pw/AP9wOeHteZH/
	 f2dDlIwEKdAlGpFcsoGIoqHxDEd3GOV+8uPWzj6W2OoYzRzbuKY207JWNzSQ4EAfRu
	 O/n0u4NoONfURTdxm2+xGaqfuMnTYfu766sAOKkEtMu4My56fq0mOllOQIVm4BetvC
	 qTtbuJzBOcPfl+YEYHQCcYjiJ0X0r4fX1dOZR/Kideco1k4S78x3fZDMQG6sUxZsIt
	 j8Fp0pvC9GblQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCC4540BF5;
	Mon, 23 Mar 2026 18:28:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7A721D3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 18:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD42C821A1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 18:28:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hPtwmZ5pVX_Y for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Mar 2026 18:28:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=technoboy85@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E1D828219F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1D828219F
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1D828219F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 18:28:28 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so29615465e9.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 11:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774290507; x=1774895307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVKv4h6csSNr26F3fg2SyyHjtvzkcdDJQ8W+IAxz4h4=;
 b=Y9OL1sIERlOYWYnJRZWOF1rP0cJ74S4/t4sg4wlb7n9De0EFF0jTkSDpEzkw/N9CgR
 nXOYb98eLlKgtkmmX4ztFyCW2gyXOEfeDXzchZakuHK2cMMBHbASWjXj4xHzQhS22DyA
 oLqyvn3k9RBsPv62w8VkZl08EpDs0cLZXuQRjghiZBASq9Fuvyj5POHsqfiLQL83LJ23
 trQwm/xL7y+HPSgmQxPa0X/2QKvZe9xj2CMLJnN5oehgxnE6Pbv4ecWUjVFEbWTXboLm
 Y6aCNYsTkJZi5ZdkGqkEqHGjoapLci/ClrGJza0P5dqSaw0YvwI32T4J4ELUf24fB2zu
 tBvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUTPCL5mXQBUWXeQ8GjQvf9jxeKmdzh0zOJIowioJwJuwBa1CuFXr8I4nlLBmvHg12UecCARrWAX0Ul4r9eJw=@lists.osuosl.org
X-Gm-Message-State: AOJu0YztMOmHwmawEPYe/muoGTHdkNo+SZgLonz+G89o3/QJtq/BvVTw
 VkDdAnOa/itxXt7KZ8yIq23NbIbRneNAHqEd0d4NKYysIini7KVFDbRi
X-Gm-Gg: ATEYQzzaQdg+vpOXltKHBUtpEoGzRxsUO6tfFrBl6ylZ96G4DWWDjXXZ6WaqxHHtx0H
 /nCp3wjrlGQcT1Vbh6pKKo74onFCR+TRjM7rszLwhe87UbcFN6eFQ9UnnJZLQRe06lm2XJPDL4S
 KM/PAdzXcqAFKaYLWhcFPlVA2DN0kdiYoZgL2m3N0pHtbWXlpK2jNh+ZV7CKmtvnmUHeDsodYNA
 wAils5SFh2aFiJIAllh5y3blUxSjRVWolEu6irgi8NcbWEidCq03+1DRR9Jfb+BRcpMaxHF5PEg
 jUM9kbp3BFmuyW0vqhyfxJzGbqKIya2jN+wbVsSPEx8kFN8tIaHWdKfkffLeJy9voJGTWrfiKGh
 3AADJGmLhnpLLcaeeJAJleFaaqK2Mx3+NhpYzz2q0uePddqAaV6Yd+tmkULB4c4LuYdKbgf3qHK
 ifF9kCfWcfrRjNCInuWSK/tY3kV18n66PMhb2wCmQNWDC6tAccsE/3UJ8KbiqaTgdN35tn0Z7AG
 Wg=
X-Received: by 2002:a05:600c:3b07:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-486fedab424mr187730755e9.4.1774290506520; 
 Mon, 23 Mar 2026 11:28:26 -0700 (PDT)
Received: from turbo.teknoraver.net (net-37-119-137-97.cust.vodafonedsl.it.
 [37.119.137.97]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714decsm28448751f8f.31.2026.03.23.11.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 11:28:25 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Date: Mon, 23 Mar 2026 19:28:21 +0100
Message-ID: <20260323182823.5813-1-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774290507; x=1774895307; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tVKv4h6csSNr26F3fg2SyyHjtvzkcdDJQ8W+IAxz4h4=;
 b=VbIafx7cjxk3HlDbihE3/9Wl9vgBbgvmwfGeCnJ7/9NzFAixSNtZukV8/4ZGTrqJ59
 YCZAimC6vuQXbwn6j1fFYm9ypnPWeiiHwX/SdgLmjrMHavhqAglBMHcv+tCp8iNfSOND
 NCTrrWSIORNhW6Hqo0XSAbiNDaD/MLjNxFfF5i1BncjvY9JfCg0S49mlZxCRigZ3d7El
 E7iC4N/r92eJtRlrNrX6BjO72Q7WJtJj3W8IOVsyodTF/dVL34cPmvg76ky3z6sqyjpv
 Rtn6tpJtjVQpPeGdqD2Ae3xEKhYbeE9TdX/hEqHVsJaQ82n/esIZ8zyP7pQq81wh1Fmx
 IU0Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VbIafx7c
Subject: [Intel-wired-lan] [PATCH net-next v4 0/2] e1000e: add XDP support
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

Add XDP support to e1000e driver. First patch adds basic XDP support,
while the second one adds support for AF_XDP.
Tested on an Intel 82574L Gigabit card with xdp-bench and xdp-trafficgen

v2: added a missing 'select PAGE_POOL' which triggered a build failure
with some configurations.
v3: removed a leftover file.
v4: bugfixes

Matteo Croce (2):
  e1000e: add basic XDP support
  e1000e: add XDP_REDIRECT support

 drivers/net/ethernet/intel/Kconfig         |   1 +
 drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 610 ++++++++++++++++++++-
 3 files changed, 617 insertions(+), 12 deletions(-)

-- 
2.53.0

