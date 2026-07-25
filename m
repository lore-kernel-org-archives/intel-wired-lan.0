Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC5C531C9
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Jul 2026 15:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6E04407BE;
	Sat, 25 Jul 2026 15:11:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QPSUe7zM6ggG; Sat, 25 Jul 2026 15:11:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D68140770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784992270;
	bh=SL7hBFcGY09oOgMOCy23V3evuH2qRKq0H2TcKBdPEAk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mCHyKUZQfWjKJeHrYF7FXIxOFtdY2TkIXLU9sm3S/5t/YqpkdOKScHjmzPvNs5zOI
	 W1Yjt+OslMJCfTKeoAGo3G7Lj/1/9feupamfdKFvxA/E2FiIiIig2FRWzMkc2xWVlz
	 YL0MdjFJLuu1tE4CBs/3FKH7huqaYih9JoEw5lfRn+lxM7ukVs+Aw2HVIPB2l/+YHY
	 BiWx7gmGgDrMvwcH6PdoOuB0Ba4OZq8dJE5XKVt7e+suov9x567Xjf+v6YLvSX2cuY
	 y07CKw+e1XxbgTGvINz+vKLgS73N7f7OLX5NDKzciLPXWOHq3oULpgeTAO21bDSEVN
	 sXWyyiMcIGodg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D68140770;
	Sat, 25 Jul 2026 15:11:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 544EFEB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 15:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50CC9400A2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 15:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xGCt2cqn3J8 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Jul 2026 15:11:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=ekffu200098@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 82CB740090
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82CB740090
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82CB740090
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 15:11:07 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so1471444a91.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 08:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784992267; x=1785597067;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SL7hBFcGY09oOgMOCy23V3evuH2qRKq0H2TcKBdPEAk=;
 b=kWSDZhhx0+oPrqqJsvDAq3dTkALrf45cycFEVBob0PxOMoayo8fkJX8K8HRHgEZuTP
 NHIWikc6mraz3KlFtWL1JRZCG6o3RUU2mQbHOsAQaFi5i9GvsvR3wrVIjvNUtJqF28RB
 ZNo7QWD3sRBCM2ZfnvTNYMan3R5C8Vp/taawL0cxtvfphjzFFU7CyZOWcS6Bamp+5y9n
 ylTi4aN+cuIgp30ZAB9tvhpgl9GJ2ITMSRGpBKQBj5ua0PhmMzT9VpZBefiqpJNd76v7
 Wk2EI84cjNJ0zK9Zg0jYQEXxKLUAu3Z73T5Qw3s6+q9ar5cnRcouK7BpC5FF1+NM5ZeH
 YVhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzQIfAum2R+Jgngd7of6TznglXwS+PPC4vxc83S+SIJ+lwIfJA6kjyMgELT/GT5jQEUT9WfeUXOYvWSyHib88=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzG7tl9+PZWyALd+MjHgkvfCfcxMGxrErBYQ9lRStT6VExEDQ7H
 2by9bpuBJi2/2EnwWmgOx87EQDeVpLdjNf+N5iNVX8OKVQgTM+SbPEbB
X-Gm-Gg: AR+sD12kVxy4QVKoiH84eb7XpYpmXYdAxRzRqG44cryXiA5OX+Yroqo/8yHkwb9POwv
 dIqiNT3Lo0qLnC6xtkFK28EfLD2A1FRCSJXkKtN8yDM6hLUiNMqXHu8CxE+c+DQar0Un/DP5EAJ
 Xoxan4Qkxryz8ENefbD1ZQhudLee53jG0okNudOg8VFByEIz0xwal0bxKHbngvOhlr+rtdbPCSE
 0r6KCWe9ZlI6oJ79l78lJz5ia5qwcZA/Ee0nzaf8ue9j4Pr9IrCA+5KHGTEeoG/R/hXEnNIpwMy
 93PUSTBfbJa/uczBvA4Cr3bWB7OJXgHBtDl55VveIM74pBY2XTssfSl7dKkWYYy/qjNg5JF2HMt
 5Rt/CDxmmarq9Yy6Wyr7H1zl6B9iHA8stPYfm5up5M7D+mWUniFu6LbaycgnxDrqb7/ErXe9+
X-Received: by 2002:a17:90b:580c:b0:38e:7f1b:f01 with SMTP id
 98e67ed59e1d1-38f2977c3b9mr2576061a91.36.1784992266734; 
 Sat, 25 Jul 2026 08:11:06 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f031d1d6csm2907665a91.0.2026.07.25.08.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 08:11:05 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: kuba@kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Arthur Kiyanovski <akiyano@amazon.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 David Arinzon <darinzon@amazon.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Ivan Vecera <ivecera@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Kory Maincent <kory.maincent@bootlin.com>,
 Manish Chopra <manishc@marvell.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Rahul Verma <rahulv@marvell.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Shahed Shaikh <shshaikh@marvell.com>,
 Sukhdeep Singh <sukhdeeps@marvell.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: GR-Linux-NIC-Dev@marvell.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 UNGLinuxDriver@microchip.com
Date: Sun, 26 Jul 2026 00:08:48 +0900
Message-ID: <20260725150852.859188-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784992267; x=1785597067; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SL7hBFcGY09oOgMOCy23V3evuH2qRKq0H2TcKBdPEAk=;
 b=CLhNydDtDPk3BgNmhAaM3bRPGHGmaHUO6MusW+aq9Jkzfvn+78oHCtvZTIlHKVmOIt
 v0oBQjV8eYHwPKwQYxhKDOnQoTQZC4VgaXmrulgfAuCV0MVZLeTwK7MR/w3HAgGtiElF
 Sfjh1Csr9PVegiAkbLpv75OHlb+onBPlcr4lK5D7D/DggKP5cr9MwOOG95/F+I+ddXEE
 zlLYK15PUS1FZVO04ICWfngnUxlmzEiMiOmduHvqTJNDx3t0KrUbTptOe73Typk72Mar
 tTvJbH3sWcpMB8fKWh7DjUpEA9b77bV9o2Kv+frDWOiFdLAmZrXRe0luN4FY2Q+L0mhF
 7I1Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CLhNydDt
Subject: [Intel-wired-lan] [PATCH net-next v2 0/4] net: remove conditional
 returns with no effect
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

Hello,

This series removes conditional returns where both branches return
the same value, so the check has no effect. As suggested by Jakub, the
netdev patches of the treewide v1 series [1] are posted separately.

All patches are generated by the Coccinelle script, which you can
find in v1.

The patch grouping is unchanged from v1. If you would rather split,
merge or drop any of the patches, just let me know and I will address
it in the next version.

---
Changes from v1 [1]
- Collect Reviewed-by tags
- Change base to net-next/main
- Filter only netdev patches

[1] https://lore.kernel.org/all/20260723184538.3888637-1-ekffu200098@gmail.com/
---

Sang-Heon Jeon (4):
  dpll: zl3073x: remove conditional return with no effect
  net: ethernet: remove conditional return with no effect
  net: remove conditional return with no effect
  net: intel: remove conditional return with no effect

 drivers/dpll/zl3073x/dpll.c                           | 6 +-----
 drivers/dpll/zl3073x/out.c                            | 8 ++------
 drivers/net/ethernet/amazon/ena/ena_netdev.c          | 6 +-----
 drivers/net/ethernet/aquantia/atlantic/aq_macsec.c    | 6 +-----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 6 +-----
 drivers/net/ethernet/freescale/gianfar.c              | 6 +-----
 drivers/net/ethernet/intel/i40e/i40e_main.c           | 8 +-------
 drivers/net/ethernet/intel/igb/e1000_i210.c           | 6 +-----
 drivers/net/ethernet/intel/igc/igc_phy.c              | 6 +-----
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c    | 7 +------
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 6 +-----
 drivers/net/ethernet/renesas/rtsn.c                   | 7 +------
 drivers/net/phy/microchip_t1.c                        | 6 +-----
 drivers/net/pse-pd/tps23881.c                         | 6 +-----
 14 files changed, 15 insertions(+), 75 deletions(-)

-- 
2.43.0

