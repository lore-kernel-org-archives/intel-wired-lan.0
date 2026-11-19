Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C67606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=405Ek+lS;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G96QqB/v
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4F6780D48;
	Thu, 19 Nov 2026 00:18:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5GWklbyjl4v; Thu, 19 Nov 2026 00:18:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB64B80D5B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795047508;
	b=tgNqthCO5z1mja18u3tQuDIhgdHkTy8Vu7J8C3hug86KT6V29ij3yPOx5JaP/g5yzKBL
	 vmwQKqQoV2UlZQEzympp2SUxeHngmTJusPkc55HrCOx+yDps4M9Bt9Jl4pZq0DKzBKEUA
	 BpaLntjlK+JbPOjdiZ2DVXRl4X0lTw2KMoeqhoqf8vUoq5tm7AH/9YQXMr39ubHKWrwY6
	 cHSXtPXpNyRJ4/hUvNBOm6Z7vcKZf6f6vrXi3/EazAed9CYOdyEV0Q+/5sCHiBsirDGFe
	 d7xtYFDMoE+i0ErCYlmCCh4XhU9PDAiaz0hw2wkReMPJ9gL+Iae16ve0jbsb2PhkxAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795047508;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z2DBHCmHTP3xW/vJ0//1Be7Aj6KhE+VRGo18KZltksQ=;
	b=qj0OfE9nBHA0x7DO/XBOnMQcdT906dqWaQXxf7MoxBgus9NcEhcAT9yL5OejsCWNkCnQ
	 hZ0LVNqWlNRlAvNku+rjUTZw/uBJxiyt4oa+QN+SrFB0NhiO8Og/eksDBJ2j0jwB1np1Q
	 920XntR9nCkgPWn8jRNOZVkYvR3AnfrddnRSKWTIBWgfaJqDWlyCBG5ckq/rpBm5Xeqfh
	 e8NR10f4PP/INqWwZQI5YE3PO3KKehXBhIJhYlaDf0IQIX9vY3yWcm7e/3BRJUcaGPAnt
	 Gi6fTYUgU2XWjd61aUiEQsb3shfhFAYM6ck0Z16ntxsQRYn+JN+a3ODRbuhZyU+l6rA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795047508;
	bh=z2DBHCmHTP3xW/vJ0//1Be7Aj6KhE+VRGo18KZltksQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=405Ek+lSp4Qts9CLUPSCb2tv1yKtxc2j67rYgyiSDgsoRnd6G0KWikcO5tYuy77J1
	 BaoSLSVrqdgqrGF9lJqRcZWXP9KNnh0q05AJekCHULUka6lNRhgbq3VJsBYFdr49YI
	 CMx8r7+ue4qHWTk2yzdIPqWWN9c0z4bVxWsTEj6JVnbI+vEjIhJqISqG1DhD1g2qhh
	 tFqWKVioIITOJVyqGdE2qnVFovC0yMos/JRGxLFwAH4f1bQ2DzN9sa6NKT7koJ8yu6
	 J95OluVMfIC0EddchFx10nQz8rO87p3eBLT5+UUFor1iw4ZamgEKsGRP5q/9c8KxHy
	 +aD+Vl5g8gdpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB64B80D5B;
	Thu, 19 Nov 2026 00:18:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 490DD49B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 00:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EA6A60A9C;
 Thu, 19 Nov 2026 00:18:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KV5j42kKhD4G; Thu, 19 Nov 2026 00:18:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1CE61606FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=acelan@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=fail (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=G96QqB/v
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CE61606FF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 00:18:25 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2efef1516b5so9146095ad.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795047505; x=1795652305; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z2DBHCmHTP3xW/vJ0//1Be7Aj6KhE+VRGo18KZltksQ=;
 b=G96QqB/v93NRBGFE/WWy5NOMSIuLfI3qV7aGpyC4C9PEVCRUi/7TpLydIF2/66NHyb
 OwIWcbTxbelA3QLWfuNMTtb+ln3PTsUHyeN0qUnZnwdF6UumyPl0+lEd3LmQCB+LGg//
 hDHnFPOhUxxJ5eTh3/6LchylmJdwOfXpbBXWgLQrhDiVMiTqWPfc3wTTx9jw8Jasv8v3
 iklOGqK939PpQmD4YBHgU+I74FBaN4NPJKLBG01qxootranmT+gTVx7DUN2v7RSjtSkZ
 s41rJ4UBAsuyqJdrYttH/v4o5+jSRCicqLSXD6HjjzkZQ31B/zCX84Sya9BlOr+xn99r
 4nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795047505; x=1795652305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z2DBHCmHTP3xW/vJ0//1Be7Aj6KhE+VRGo18KZltksQ=;
 b=XuPf3KjWXh9bcfA8m65Tb/AOfH/XaCg6RXsdrEzxjdQR/R7CyU8xChUP0EFHo654e8
 HpQPZeiplZi3E/HIPIFr/gy8ARMMJzqw+/++gTU5JB6W7lLS//ILS+x3ajnjlRxlkoDX
 LQpCUUwZ9OQ4ihz2ckwkkv1NW06vhcwGbJE5OSx9EfIct+uTchdPyBi+8ntgyuvDvrlP
 e5ko9JGaUEHmoBAZd+77Ym/5i8Ilfvn35xNz5jl0WHU33qpSEtmEXJii9HidXP67fhBv
 cB7BG++UYdM/I7Kcjmo4cscrA3Ea3C6odGYxjtVqDEtKNca1dn424u9c1JRoshyKz29t
 ir+A==
X-Forwarded-Encrypted: i=1;
 AL+hErEQNS8cAEZuEo5awMxeaXO7dwqCUxuO9nNxTP03VI3RCkP8/BXTF5IYKisVuOvoUqh0qbsYFHVZJnEcVSMSR64=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8aJaVc4P6zkTnY1w6w+ybEoi7J8LZB8fsfRf3MG2FUdi812Y/Z
 lZYicu7TQd0TT7WkoTEuSdODyX3oITxxkX9atSGayp3xBLkI4yzzKIN/
X-Gm-Gg: AZFdTZdvqHtZWnqjisJCgQQ/30ECiQiHeWBcuJ3R/Ftg1FD5oG8Ka5SOb5wzvxexfiK
 TEisB9qmum6asRHT5/Hy6Qcy0dQRaL7G9M3dGyuhHR3Nd0YcKvMfQJT7HpE/HNnxR5xTloNWuDk
 aaz+cVdxWZOoqFfLvS6XJJjPGtz85AxMxIK2EjL4U/rH7jIYCuGMgXHqSzZt3VsNMyPekR3t00X
 wa9wi6s7VO6RvTFci5u5GZpszgmQU22AbTkaBBIpF/Yg8h2UtfT94FV3udnQqOzAiXuKwnNY8gX
 HNcQUhRSgOebTuh3qw0jevHQ4l8J46nUcoTef1baBJTqyU8EIuYI1ZvPqhQnXrZYXCrZZ0Ds9FI
 K06ucNn/Hzd1P3HcOxqV5OsCiUVPC4sLxxUvCbid6L2Y7UndbmtpSgVlA+FG9MZeSAsS6o8MLIl
 YSLozz31zqDdXD9bhQiESzghrbHkP/UxlRZBWisC4qXaTOFmY4V/Q+MMmupQ5VzmbdJz4jp1duO
 hDlGFFdEyXBkFzF4nN/7ettxPKiRdraV1yt3Prdh8kR1JqO/xuCbZ//AGmQ8aWwgR4QmchTKhao
 8/0cyRaAX0r0YsAbMz1Nn5mw9WdwT6FueCPJxQuVwfG4EknDLjd1y0Iywg==
X-Received: by 2002:a17:903:8c7:b0:2ef:f3df:7d7d with SMTP id
 d9443c01a7336-2eff75632eamr43088815ad.51.1795047504854; 
 Wed, 18 Nov 2026 16:18:24 -0800 (PST)
Received: from localhost (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff62e38eesm20799395ad.76.2026.11.18.16.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 16:18:23 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] e1000e: add Dell Pro 5 Micro P5M1260 to disable K1 list
Date: Thu, 19 Nov 2026 08:18:18 +0800
Message-ID: <20261119001818.513503-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

K1 was re-enabled on MTL and later platforms by
commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake").
Since then, the Dell Pro 5 Micro P5M1260 (Panther Lake, I219
[8086:57b3]) no longer enters S0ix during s2idle. Every suspend ends
with:

  intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)

The PMC low power mode status dump shows the GbE IP is never power
gated (GBE_PGD0_PG_STS, GBE_D3_STS and GBE_VNN_REQ_STS all 0), while
the CPU itself reaches C10.

Disabling K1 at runtime restores S0ix on the same unit, kernel and
BIOS:

  # ethtool --set-priv-flags enp0s31f6 disable-k1 on

30/30 s2idle cycles then reach S0ix with ~93% of the suspend time
spent in hardware sleep. After a reboot (flag back to off) the next
60/60 cycles fail again. The system also passed before the commit
above, when K1 was disabled by default on this platform.

Add the system to disable_k1_list so K1 is disabled by default.

Cc: stable@vger.kernel.org
Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake")
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f85dab5c55c5..23103064f27a0 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -74,6 +74,13 @@ static const struct dmi_system_id disable_k1_list[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 5"),
 		},
 	},
+	{
+		.ident = "Dell Pro 5 Micro P5M1260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 Micro P5M1260"),
+		},
+	},
 	{}
 };
 
-- 
2.53.0

