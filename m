Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3514103E199
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 15:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CAAE81DF5;
	Wed, 18 Mar 2026 15:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gwgsCra7vLkp; Wed, 18 Mar 2026 15:03:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC49681E99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773846207;
	bh=ZI1/cLnyDnVOs4qvF1/y00bhWF98dmH7Q3P7jVrTCz8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vrPXtszwA4FayAqMKr2pg4m/9EjsWzrGY/RSRoGwctsOrsOaVmJKc73yBPl2tmDd3
	 UYKIb49SVSXw7g//tv0byVoxhSNW+SeU97qnyvuF0Kot+y2/YB83CWjlKVkapPHBmv
	 EWmHqL/cDDzhgvokNmyn7svpU1LlHJPNKarWQ5UQhNP2l2PotGZLySzH+HsqUGNFG6
	 wSraDJhfSZrFVXZzNVGjO1m07Alk4sI6K1LSlDo1NpCZsSbXD2scjUOkD2UMCCu10r
	 WWc849leFtDlR23zhr1gsT4dZf9GD4O1Ew7LtEd3ueYorjpL/RD3ieagvIkeFwV/pr
	 5vkTvGG5pnQZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC49681E99;
	Wed, 18 Mar 2026 15:03:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A48AE1BD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A71E40BA6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PaRDO96ACNun for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 15:03:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.174;
 helo=mail-dy1-f174.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D2E2840BA5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2E2840BA5
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2E2840BA5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:24 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2c0e3a2605fso12438eec.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 08:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773846204; x=1774451004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZI1/cLnyDnVOs4qvF1/y00bhWF98dmH7Q3P7jVrTCz8=;
 b=N3s0yo+5BMS2f6mYOcgRZOG689gsLQab/PeQzF2HKhu20m0DE1rACNTHKbgT1va1YG
 34sE40mRvJFiNBAPZAmpNZJ4R96uGwhOZ4pxSXptJYZQI3ADxb68y+IbkWxZTlcKt+ZB
 XKppYxQnP6OqddwcaEZMlNTz9BzVvaV85JASVASmUX6A8dtBQF6tbPLKirHNl/17GvBy
 Su15dv5SVIufgBsM+ScDB8f+aZs3pz/MFL8hyQhbAJFtXOf+yjHi9I0OYLJM7oNCEbkE
 n8RqG5sUPGtT4g4Hlfe/taRag+wgpdBZP2EtBU5hXk/gO36KlRP1s8Eiyk18QLrGsvLp
 kK0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjm/npRwwwUR54H9xwdv0sCgRU+y7xHmpthlzq0sKaKvHzLmZIkrOPHOmVKVOseCr/eA+JMxYVImX/5dXIQ6w=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyxpDsLFzwlQCWF9lxTVplRLg7quD4cVZrAGLZ8CokHLHuo79dQ
 omkiv5PEjLcCh4p1uZMe3TTYKRDPL43Rqm99laA/1fY4cnAdwFtGosk=
X-Gm-Gg: ATEYQzxgaAjeUtaX+ebLZMsPdmuOeqyCG++JpXbsB3N0SFTItMQK2s88lxMD1AK+Pt2
 Vj8OePjCWizxHQFgQwSkuIacjDESsemtxN0YPm1aTYf3j1ueP1j2NHvuUxibDTJDoMgFYnuAhgK
 +lYs3+vR9Xj3vg0+FcudxNOU2K9rLXIR1ShAxn4mkNUrJYsukZTWSc1gCFQcPBVEqqQ0Fz0MHrN
 hofdxSGgnxdFIlYeoLSiGfiw3vdHwbIEN0ByZjOK+uIIgGRyCGaY9+l7F5fNq+IJokYr1xcYJlb
 jV+Q3kC2yHu1Ls835pAHmjDGlTUY57B1awG4oIz8mz+E91YPngKcDyOJZ60XVN6BiOkTBndzWWS
 ckDPMHo6JgKruxlA/Duwf9YwWg5XlqqrO9ln0AtKdSVIYXWJwRNC3RP/OrlXbXcChFDyzlBI06Y
 DdYh9DwwELH2WmmlTAes9YRTnPfVhnKrHcWwMgZt95IZXPwo1AyMz7Xkjp8FVbUNYatSf3Y3YY1
 Cv+1V8XsSlaB5wddw==
X-Received: by 2002:a05:7300:3724:b0:2be:126c:e335 with SMTP id
 5a478bee46e88-2c0e5011ac8mr1873924eec.10.1773846202672; 
 Wed, 18 Mar 2026 08:03:22 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e56062e4sm4123423eec.30.2026.03.18.08.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:03:22 -0700 (PDT)
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
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
Date: Wed, 18 Mar 2026 08:03:01 -0700
Message-ID: <20260318150305.123900-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v2 09/13] iavf: convert to
 ndo_set_rx_mode_async
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

Convert iavf from ndo_set_rx_mode to ndo_set_rx_mode_async.
iavf_set_rx_mode now takes explicit uc/mc list parameters and
uses __hw_addr_sync_dev on the snapshots instead of __dev_uc_sync
and __dev_mc_sync.

The iavf_configure internal caller passes the real lists directly.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7925ee152c76..6632d35ad0fe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1147,14 +1147,18 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
 /**
  * iavf_set_rx_mode - NDO callback to set the netdev filters
  * @netdev: network interface device structure
+ * @uc: snapshot of uc address list
+ * @mc: snapshot of mc address list
  **/
-static void iavf_set_rx_mode(struct net_device *netdev)
+static void iavf_set_rx_mode(struct net_device *netdev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
-	__dev_uc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
-	__dev_mc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(uc, netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(mc, netdev, iavf_addr_sync, iavf_addr_unsync);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	spin_lock_bh(&adapter->current_netdev_promisc_flags_lock);
@@ -1207,7 +1211,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	iavf_set_rx_mode(netdev);
+	iavf_set_rx_mode(netdev, &netdev->uc, &netdev->mc);
 
 	iavf_configure_tx(adapter);
 	iavf_configure_rx(adapter);
@@ -5150,7 +5154,7 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_open		= iavf_open,
 	.ndo_stop		= iavf_close,
 	.ndo_start_xmit		= iavf_xmit_frame,
-	.ndo_set_rx_mode	= iavf_set_rx_mode,
+	.ndo_set_rx_mode_async	= iavf_set_rx_mode,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= iavf_set_mac,
 	.ndo_change_mtu		= iavf_change_mtu,
-- 
2.53.0

