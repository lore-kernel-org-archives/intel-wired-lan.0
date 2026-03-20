Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E111093170
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A55641BB0;
	Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wO89ayTqE4iw; Fri, 20 Mar 2026 01:25:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9C3F41BBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773969917;
	bh=ZI1/cLnyDnVOs4qvF1/y00bhWF98dmH7Q3P7jVrTCz8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aFfKqvhE9ZrWrQpEektqapwzV5Oz4dsu3dnNQo2owH3O/NXV1JjIpnKwXA7MuZYG5
	 9ORw4RF+MnJKuNliiLj5KGEr/wuDeL87J6+LA1hdtfpyS94bJLMAJUzpzKnUe2fSkR
	 mjOYOZgEnQYHkz61IeZwFZpVHS2f2sYIHsA+O2+b0E/uZDC9PI35O7zBjMzNIVD2T4
	 4S2/2ZKcZ2qR5G8kgze120ARb2LyiOrubKU3/RbBvesforeDd+I9FrrWRF5mlJ0m7b
	 27mfYI6yi5cajLyGp7dShMl7LlrqejUg8mRkLh848STM+zQwZzJOvEnBw2Mbrsvgot
	 0CXMcqhkZ+SQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9C3F41BBC;
	Fri, 20 Mar 2026 01:25:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FBE91B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45D2784536
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wRITko9dBOVI for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 01:25:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.54;
 helo=mail-dl1-f54.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9361D8452D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9361D8452D
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9361D8452D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:15 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-127380532eeso4102449c88.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 18:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969914; x=1774574714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZI1/cLnyDnVOs4qvF1/y00bhWF98dmH7Q3P7jVrTCz8=;
 b=phDNgaajzgubKy90tEuAJJTo+5I+Xc4RibC8mf5n1wKGtCcWL6TmBOTbSNh3lxAd2T
 9hDnygLurgCBGnCD+wGTEdxV98RB5bQbYfr9guCnX9tLx06Xv1yeJP4rI1clDS6wX2de
 swDdeZnNZemdtkK2wWE48kNVQmdcoSXM7qRejfhz6ze74DDyARn4LryJyvvn28glxShA
 9010EfYglRXQXkI9avft7BKky7x4rwLeMjB7agUqIe/ONCQiqImVbeV0Wo6iF3thwCwh
 LnQSOdaU901FTWZMsGCbUCslQSHNIsU9AzT57JqUeWsCAqjvC6yCo1TyMYZL8/0L26so
 NATQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3GuclBAF7Ag3BehBz80bNLR/40nz89shaXSbYbFuVODpaj1TmX3zDuPbopOM1/botrHParbyxjDn/9iwbpFM=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzcREblTAngpdLZfh7B3eK+/Gw2y5VA5Cs5c3XvApJJI2YL3zp6
 5F9bgyRMWf3MXw+dD4LkV5v15RVZA7e34k3U24OSw/LrBg14Bpw4VDg=
X-Gm-Gg: ATEYQzwlr0Ippade5JDLvJVpp8khx5FPbXK/zwxwVXCVuDVnm5Dyk+ZBpIZVmogfK0e
 PbvFffFiqqR/aWsQ46axFCXU1OibdBZyoF8rmxP1805cjIyEvfxEg2ZqFpKk00WjnWFEyICvBEq
 LIRpBiRzJ3MXFzfrrC/lvVr+fvK/2XlpPTbsuMD1SaXOBJeaZa5AkIeWWARAcsFOll0HOImIcLT
 884py7JYJcs569yejA7rNLM5jVmpeYhGqabL9T4qfdANlttzkeYptIqVLpkZIAVDpQ59DkWJD9J
 oh/P3phVbzDkM3n6Kz48jd1kM6cx3095/fe3ZKxhfJEKu0iv6rFGtJM5b6MuoBiAFztI99EvlS3
 Jq9PirsvC99grTagjWTLlmTp4VzO11s+oNwqEi2LWpXltMmb7BEAqMbxoiK/40e1L8C9LVhn1U+
 pDRNdPOIKFlGy0aDTP/WopMlSXxX6iEPh4DE7hDrYm3v/Zh23R7bnkmzc9f/NebKeaKRNYVIgMH
 P28s7PHNyb7IAmpk5E6aYha1pYq
X-Received: by 2002:a05:7022:2227:b0:128:ce44:be8f with SMTP id
 a92af1059eb24-12a726572c7mr659849c88.2.1773969914275; 
 Thu, 19 Mar 2026 18:25:14 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a733dd8c0sm761096c88.5.2026.03.19.18.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:25:13 -0700 (PDT)
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
Date: Thu, 19 Mar 2026 18:24:57 -0700
Message-ID: <20260320012501.2033548-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v3 09/13] iavf: convert to
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

