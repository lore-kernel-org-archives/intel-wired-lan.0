Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BCB103E198
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 15:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D3B640B5B;
	Wed, 18 Mar 2026 15:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Y1IqyJhxhhc; Wed, 18 Mar 2026 15:03:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2AD040BAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773846202;
	bh=Ca+gBPWdaS3D9IVR2rmhybZb8dy4jn4+7E3W6do17GA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xnJyq0Kbmo56tCh3YkxoHPdoIQe5e9oYcBGu9LONCHQ31xqemZrwOt74ONqfjyMBd
	 frNIuq2QkSEsVshi73xEv7QJ5XrkxwrYGHbd3BPWiBTFon2GlJoNumH7ERmA3rKe0o
	 Nmj7ZNHjg2H1+AO4giAJSTU72F0G8K7UTADQktcAq+yZgu5vzflvB4GNSfvoSqLWd3
	 +xW5uYZPlyBsH03xiPf/dG5JUzhhgiqufc1zTzrPPqNSCMnBZufOgBXyz/n/Gp3sQJ
	 hIccQ0ANWZZJiEsJ/ICgu2mY6xTXkKLDxRSyQRrVdqu561IxVQ9LyL85TzRiA/WGWZ
	 txHiHklS2X7oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2AD040BAE;
	Wed, 18 Mar 2026 15:03:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D5B921BD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C733240407
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rb65NidyM0yq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 15:03:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.177;
 helo=mail-dy1-f177.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F0114402D7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0114402D7
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F0114402D7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:19 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2c0ea57fea7so9579eec.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 08:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773846199; x=1774450999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ca+gBPWdaS3D9IVR2rmhybZb8dy4jn4+7E3W6do17GA=;
 b=TLuivTjKfSoIuBtMmuvwDwGq979fjg58kcMS81TfcBH5EnLnnIK1WG1Ef1x7K3S25G
 IHPvBVdXaVsvNMI3ZdSlGGDgGy6mTbnSVJveWyV1Odlp3AQA/eXdFtac11O9fPby7hZ4
 VdrEJMIvK6cLnmdP95lXBRA1/2SqH8+jebUX4BOhV4gHwSnhify1i4ZiKKXKP7XNgRxK
 9bvXgO6x+ALOs5eEvv7jMLsr6NLzdW66P6ol+oZ66R7nzRvF1yWU1/aAPm1eUmrF7bhE
 yVrSa1esepFnFLuP84mmvejmbue4YV/mSOKCXAVjeSQnaxboquOd0jJ1fRTXnKE/+sgK
 tI8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEjdooSd3MPLgNW2dt+ZTMPfKtfmXGOBs8nEWZ52U0622ijR60ing03pJ1YNkaQVUUdnvNOAekz/H4Zq1kHEc=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwO9GeMyxV3Yxluqo+NtwLfVdAxstZuDrjyHbVm03VNcmHoR+AI
 r1xK2lO91AzAU7avO+5/wIONkAhA2s17W493fzknVOYy0FSsoqSCpVc=
X-Gm-Gg: ATEYQzxKMIE8F97jbXHc84IYnPJrbs1Wmv8tUDq5Q4KfOXgvJP2E28W3MIHv2top0yo
 wABw5Rpg9M4fweZ645938D9HRPUoybxEEKDnYoS7+r7364z/+RZjjhzHgy+yPrfyVY0CMmzAl7V
 OqgFbaZlHNmLvIL68GCx3jRbxaPN90pPaeqwPYct6vvMiwBbSbEdTFlOU48lh8ushDgqT8IEUPJ
 Df7inpZLlUDytZrsjKFMHeyybLzv2Kfpsj68+LqX2DlVxZpBJJqauzk0bx35NhnhcJd+Wc8oyNS
 jOge89AUTDfVd6CkcRZY+86OJC9F/UuvyY9wM29UY9YBgnv1Y8gJjPqsxk/TC6XSU8jqWhkdE3Q
 F1nyzB3SB9YUzO0d8vFmJub8AmY9ZB3hTvB/vPCTacCX2iiR6CrE/wRFvwV6nJtgMD846Ig1yrx
 jdzUixvl0m/+4RnKIS7itsFcqjiYDhjjmsRjVOONnq0M2HRNS4jk8h2SBYYrY4NqQRVvUmTrw5h
 m4Szmxg0DoVEdJ6lg==
X-Received: by 2002:a05:7301:658a:b0:2ba:6978:2b4 with SMTP id
 5a478bee46e88-2c0e519749fmr1615494eec.20.1773846195984; 
 Wed, 18 Mar 2026 08:03:15 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e55ee672sm5054384eec.28.2026.03.18.08.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:03:15 -0700 (PDT)
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
 leon@kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Date: Wed, 18 Mar 2026 08:02:58 -0700
Message-ID: <20260318150305.123900-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v2 06/13] mlx5: convert to
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

Convert mlx5 from ndo_set_rx_mode to ndo_set_rx_mode_async. The
driver's mlx5e_set_rx_mode now receives uc/mc snapshots and calls
mlx5e_fs_set_rx_mode_work directly instead of queueing work.

mlx5e_sync_netdev_addr and mlx5e_handle_netdev_addr now take
explicit uc/mc list parameters and iterate with
netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.

Fallback to netdev's uc/mc in a few places and grab addr lock.

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  5 +++-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   | 30 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 16 +++++++---
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index c3408b3f7010..091b80a67189 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -201,7 +201,10 @@ int mlx5e_add_vlan_trap(struct mlx5e_flow_steering *fs, int  trap_id, int tir_nu
 void mlx5e_remove_vlan_trap(struct mlx5e_flow_steering *fs);
 int mlx5e_add_mac_trap(struct mlx5e_flow_steering *fs, int  trap_id, int tir_num);
 void mlx5e_remove_mac_trap(struct mlx5e_flow_steering *fs);
-void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs, struct net_device *netdev);
+void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
+			       struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc);
 int mlx5e_fs_vlan_rx_add_vid(struct mlx5e_flow_steering *fs,
 			     struct net_device *netdev,
 			     __be16 proto, u16 vid);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 9352e2183312..b6c6779f131c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -610,20 +610,26 @@ static void mlx5e_execute_l2_action(struct mlx5e_flow_steering *fs,
 }
 
 static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
-				   struct net_device *netdev)
+				   struct net_device *netdev,
+				   struct netdev_hw_addr_list *uc,
+				   struct netdev_hw_addr_list *mc)
 {
 	struct netdev_hw_addr *ha;
 
-	netif_addr_lock_bh(netdev);
+	if (!uc || !mc) {
+		netif_addr_lock_bh(netdev);
+		mlx5e_sync_netdev_addr(fs, netdev, &netdev->uc, &netdev->mc);
+		netif_addr_unlock_bh(netdev);
+		return;
+	}
 
 	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);
-	netdev_for_each_uc_addr(ha, netdev)
+
+	netdev_hw_addr_list_for_each(ha, uc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_uc, ha->addr);
 
-	netdev_for_each_mc_addr(ha, netdev)
+	netdev_hw_addr_list_for_each(ha, mc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_mc, ha->addr);
-
-	netif_addr_unlock_bh(netdev);
 }
 
 static void mlx5e_fill_addr_array(struct mlx5e_flow_steering *fs, int list_type,
@@ -725,7 +731,9 @@ static void mlx5e_apply_netdev_addr(struct mlx5e_flow_steering *fs)
 }
 
 static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
-				     struct net_device *netdev)
+				     struct net_device *netdev,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_l2_hash_node *hn;
 	struct hlist_node *tmp;
@@ -737,7 +745,7 @@ static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
 		hn->action = MLX5E_ACTION_DEL;
 
 	if (fs->state_destroy)
-		mlx5e_sync_netdev_addr(fs, netdev);
+		mlx5e_sync_netdev_addr(fs, netdev, uc, mc);
 
 	mlx5e_apply_netdev_addr(fs);
 }
@@ -821,7 +829,9 @@ static void mlx5e_destroy_promisc_table(struct mlx5e_flow_steering *fs)
 }
 
 void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
-			       struct net_device *netdev)
+			       struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_l2_table *ea = &fs->l2;
 
@@ -851,7 +861,7 @@ void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
 	if (enable_broadcast)
 		mlx5e_add_l2_flow_rule(fs, &ea->broadcast, MLX5E_FULLMATCH);
 
-	mlx5e_handle_netdev_addr(fs, netdev);
+	mlx5e_handle_netdev_addr(fs, netdev, uc, mc);
 
 	if (disable_broadcast)
 		mlx5e_del_l2_flow_rule(fs, &ea->broadcast);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7009da94f0b..e86cf1ee108d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4108,11 +4108,16 @@ static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 }
 
-static void mlx5e_set_rx_mode(struct net_device *dev)
+static void mlx5e_set_rx_mode(struct net_device *dev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	mlx5e_nic_set_rx_mode(priv);
+	if (mlx5e_is_uplink_rep(priv))
+		return; /* no rx mode for uplink rep */
+
+	mlx5e_fs_set_rx_mode_work(priv->fs, dev, uc, mc);
 }
 
 static int mlx5e_set_mac(struct net_device *netdev, void *addr)
@@ -5287,7 +5292,7 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_setup_tc            = mlx5e_setup_tc,
 	.ndo_select_queue        = mlx5e_select_queue,
 	.ndo_get_stats64         = mlx5e_get_stats,
-	.ndo_set_rx_mode         = mlx5e_set_rx_mode,
+	.ndo_set_rx_mode_async   = mlx5e_set_rx_mode,
 	.ndo_set_mac_address     = mlx5e_set_mac,
 	.ndo_vlan_rx_add_vid     = mlx5e_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid    = mlx5e_vlan_rx_kill_vid,
@@ -6272,8 +6277,11 @@ void mlx5e_set_rx_mode_work(struct work_struct *work)
 {
 	struct mlx5e_priv *priv = container_of(work, struct mlx5e_priv,
 					       set_rx_mode_work);
+	struct net_device *dev = priv->netdev;
 
-	return mlx5e_fs_set_rx_mode_work(priv->fs, priv->netdev);
+	netdev_lock_ops(dev);
+	mlx5e_fs_set_rx_mode_work(priv->fs, dev, NULL, NULL);
+	netdev_unlock_ops(dev);
 }
 
 /* mlx5e generic netdev management API (move to en_common.c) */
-- 
2.53.0

