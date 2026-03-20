Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17441093163
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 01:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 499A341BB1;
	Fri, 20 Mar 2026 01:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKvWuXN2Ni4k; Fri, 20 Mar 2026 01:25:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 051A741BAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773969906;
	bh=6rpuLOskCPApojyOfZj7pXXkMzfKSIlGWmqpeqvyGp0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XnbyO9N9Z8g7YAZoCWAHmXK8mQxPJYTj94jHHhS6WjMTalWsXeVDql9Ki1dwvQQI8
	 06khpFJ832fo8gbKgcw+LA/KtAUS/rncq3NVjNLVIbAcjjwytTvrGFXAtuSQRA0Mdi
	 yVi24tMlAD3hATQVUL9e6QEdMr62N0HUF+GSqAFlN8tEkUSBNA5YikqmkQI7ELawAo
	 QZzo43xRV4PnWEvfDeC1d+xjTMI3F4B9JoQx7inYeGGnoCa19eIxZiG0AHaEZbpr1X
	 R2jmeAEzyteL6RA5PlrfQIOPnoZ/hAyu/52aamuQS89yUvzRv8aAv065uJMrkZas5V
	 YBJ7XcBtODbSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 051A741BAD;
	Fri, 20 Mar 2026 01:25:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 061AC298
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBE5C41329
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F_b5ig3_eRA5 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 01:25:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.42;
 helo=mail-dl1-f42.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 35B284057B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35B284057B
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35B284057B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:04 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso2688113c88.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 18:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969903; x=1774574703;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rpuLOskCPApojyOfZj7pXXkMzfKSIlGWmqpeqvyGp0=;
 b=GnAlr23gRUVsUIIMxvdJv4kHMX28x4VIJfEFz4vRX6jKH5fuJOILW1cY8Qu3zZAc27
 /B8LkKPpSXCrzzfgtLDmBxmIimqjzx+YtLxCYTHbQhYK2pC1LHHc4BGYhxej685wVocg
 eRRYgnUEO0vs5bIQqY3V55tO6vFxkXrMMgSiHYfg7FQc9dwE+2gqejIybTmqeb0SKJOn
 QqvQJf7djur+Po6ZUHM+1y8p26v/fTbaNEtqmKDnhu+Mbjp+MfSZJ1WhQ8NPHq+wpIbU
 erZM+M53Dk+KCiFnoNDcdbt4ajaQT4t/c2O1pP2De8kU2xJafXbeMeZoxai56WAEIwKu
 qFFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXblT+FYSf8oECLh/qAXPZAgVd2quWGZYsGMBh2NsZzx8orJrfGLmGs+n2Suu+ygdIuwiDHsLJwNOahj35Hl8M=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyxcjrPCZ4S+V6pRs3cbkR9ZF8Pt8lKbwxbeEjTMGNGkbikSDit
 bA1afT77Reh0RD98nOjMbgncniM5AQJLqv8UHVK9Cht59XGCtMgrJus=
X-Gm-Gg: ATEYQzwhRn1eplmi9k/GSgdZ5J51s9Wm5NH1ZSmd40n7mJrUgdFVt2G/UHbj+YSVR1r
 VM92hz9uIZl4bkA6f1ouGeA6LD+IyZMc8RSCBm5eJF9CqkdrOj8cDCNDwOzQ1Kaquv/00qSOK/N
 NE2Hk6OB8HCQvYqj5Xx/ItT/ME24GhKsV/KEo8lKfhyivsCtKXBQFKFDMraMSb/DebbjDLlE6P0
 KJyPIwUXvnsQEXX4xOs3/1JdRQb3JjwwH7QMAK50SR2WEAZOEaqDpi1EkGutaY3afwmDjHKFMDu
 uUZEzEhy3LZe2VzgQyT2r1mk0LcwC2nfVhLikYpdp8PdEN3Ch6UoSCwwsB58JAl+H3gs9pFCs1B
 nY89VFqr6xWJeFv9xFU/Hy0lJA+sKV2v2lKeY53HDbgLPdr+x6TCh4ofBkHet5VJn4QkpK8i3hj
 Ocph3sBGo8lzjk7tlKe2cWBm0gSS1MxdmB50gFKE7JTqZ9wgkYT38e0b9sHNt4zoY2FPlKdd43j
 9oDnpxYhRoHMeVSfA==
X-Received: by 2002:a05:7301:9f0c:b0:2b8:4c95:365d with SMTP id
 5a478bee46e88-2c1095f54afmr757541eec.10.1773969902833; 
 Thu, 19 Mar 2026 18:25:02 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b35116bsm1575407eec.30.2026.03.19.18.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:25:02 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com, johannes@sipsolutions.net,
 sd@queasysnail.net, jianbol@nvidia.com, dtatulea@nvidia.com,
 sdf@fomichev.me, mohsin.bashr@gmail.com, jacob.e.keller@intel.com,
 willemb@google.com, skhawaja@google.com, bestswngs@gmail.com,
 aleksandr.loktionov@intel.com, kees@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Date: Thu, 19 Mar 2026 18:24:48 -0700
Message-ID: <20260320012501.2033548-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v3 00/13] net: sleepable
 ndo_set_rx_mode
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

This series adds a new ndo_set_rx_mode_async callback that enables
drivers to handle address list updates in a sleepable context. The
current ndo_set_rx_mode is called under the netif_addr_lock spinlock
with BHs disabled, which prevents drivers from sleeping. This is
problematic for ops-locked drivers that need to sleep.

The approach:
1. Add snapshot/reconcile infrastructure for address lists
2. Introduce dev_rx_mode_work that takes snapshots under the lock,
   drops the lock, calls the driver, then reconciles changes back
3. Move promiscuity handling into the scheduled work as well
4. Convert existing ops-locked drivers to ndo_set_rx_mode_async
5. Add a warning for ops-locked drivers still using ndo_set_rx_mode
6. Add a selftest exercising the team+bridge+macvlan topology that
   triggers the addr_lock -> ops_lock ordering issue

v3:
- module_export(__rtnl_unlock) (nipa)
- s/netdev_uc_count/netdev_hw_addr_list_count/ in bnxt (Aleksandr)

v2:
- wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit (syzbot)
- simplify mlx5e_sync_netdev_addr for !uc (Cosmin)
- switch to snapshot in bnxt_cfg_rx_mode (Michael)
- add team to net/config (Jakub)

Stanislav Fomichev (13):
  net: add address list snapshot and reconciliation infrastructure
  wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit
  net: introduce ndo_set_rx_mode_async and dev_rx_mode_work
  net: move promiscuity handling into dev_rx_mode_work
  fbnic: convert to ndo_set_rx_mode_async
  mlx5: convert to ndo_set_rx_mode_async
  bnxt: convert to ndo_set_rx_mode_async
  bnxt: use snapshot in bnxt_cfg_rx_mode
  iavf: convert to ndo_set_rx_mode_async
  netdevsim: convert to ndo_set_rx_mode_async
  dummy: convert to ndo_set_rx_mode_async
  net: warn ops-locked drivers still using ndo_set_rx_mode
  selftests: net: add team_bridge_macvlan rx_mode test

 Documentation/networking/netdevices.rst       |  12 +
 drivers/net/dummy.c                           |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  55 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  14 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |  30 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  16 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  20 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +-
 drivers/net/netdevsim/netdev.c                |   8 +-
 include/linux/netdevice.h                     |  26 ++
 net/core/dev.c                                | 176 ++++++++--
 net/core/dev.h                                |   1 +
 net/core/dev_addr_lists.c                     | 110 +++++-
 net/core/dev_addr_lists_test.c                | 321 +++++++++++++++++-
 net/core/rtnetlink.c                          |   1 +
 net/wireless/core.c                           |   1 +
 net/wireless/nl80211.c                        |   2 +-
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/rtnetlink.sh      |  44 +++
 22 files changed, 765 insertions(+), 94 deletions(-)

-- 
2.53.0

