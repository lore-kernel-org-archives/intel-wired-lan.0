Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBD71093163
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 01:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1218A616AE;
	Fri, 20 Mar 2026 01:25:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtDLQY1XJgvm; Fri, 20 Mar 2026 01:25:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B238D616AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773969911;
	bh=suEW+QJFcSsgWhqrlb5+SoMaziekppWcaVGrKT6pk3Q=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mS2zM12jNPMB764LqGLTfH8LssLnsWQfz4WE+LoWhDYG6XHVqRZyYqD3m0Yv9upTr
	 2kIx+7mmjokCNcgd8lzoX33VX9AVaaej9aBwF16YCzmQplT4XX1Q+f9kl1OPTaiv8y
	 1XJTuCxbpAgJ21ZEJMxWuHvSstkfBOuIBdraPteAUN4lna07ZHs1ymVdZE05C+nzae
	 lgCtp46gUKkKpLX/4X3yxgvSceoKQtXG0fZC7vwyKbD7EHMZ5iHiIkf3Fq1Dvs/vvb
	 5YLaiK+qwCTNiFcAxIEkmh1YgdRDEbdR2TnH0YIqCW8mSAu+mlo0L3k+1FeU6ULyUX
	 3ugl4SWKowPcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B238D616AC;
	Fri, 20 Mar 2026 01:25:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CF2F1B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42AAF616AB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ryC6U7yokE0j for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 01:25:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.175;
 helo=mail-dy1-f175.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7E4C9616AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E4C9616AA
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E4C9616AA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:09 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso1112566eec.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 18:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969908; x=1774574708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=suEW+QJFcSsgWhqrlb5+SoMaziekppWcaVGrKT6pk3Q=;
 b=OH3VmU0gA/6o7Gv611/47KtDrt0Vnj0aKKxCljPRmnrZeEo0hket0mJ8hR7CNRDfpD
 Uwx6ksTlbdu0yUfi19CIRybDUk0ylNg48DqZVUsAJFplhgKei+co6WzRa2g8XhUujYmJ
 lVx33XlCXV8RTF9y7Kwsh68a6nvohC8mXjCwps43UYdF9zSLdxyl4mRe44Vw4wkHoBYR
 cDYabfrsw0UkVSmCpIg15+QOpd7NIXd3HS27hPZ7VWXw+mk+oEoAvx6ZaHdD6i4zgIdY
 HWF9RaDo2uaNGQmzrW+YinmxB5SI0AzIu6tYTDgczzfcOp2uB87BstsQLUF+A7IIbsKC
 Ch6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWknLiUpwmUsza6XrdCL5lXmk76Mzt8flROnkPHSyyRR6/Zy08sYw2H35TokESVHfFK050ywGpKvy4Hd7CB1H8=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yy3Gz91altDGbtddVnZxkdyDPaVcZtIoEbpATZ9IrMVOwYhx0ap
 XZ75mt4avOIMA0ZLIbJjD0fNxTPtvFxJ5z/AhRP9yfEIlp3OqU73b60=
X-Gm-Gg: ATEYQzx5Pm1V0tzcsPp+ih9aWkZUw45Fc7JQpCv9FCOzjfwXHVt68kJIttecNTUDAv3
 KgAb5uJKI051Nizt6CFFPzPCypjCI5zzAObD02E9uq8URUF3kqhMhBEqbfM+XtUBOMYGxFclkxA
 7pjIcIJXus5XaZ08WlF6Xxd+S3h+2eKQhQdDnaMBF7LJU1gd90DTiSJLpUJSUv7D3ss2/KXLWV4
 cXqE9XDAL1wfj2yyjo+od66Ui7mUUDV25xiqtCToa+cZArE/xI4BC9OYfN4XeLeLGHhaNH9VIje
 dAKE/CLcRonBatRNePtX3OGsNcgg4DpGwceF+cDD40JC5BaAccXTVPCYM7VeJ4BOVUET85Nv/xU
 hJUiWGEgPI2ZhOU4bTSSzbRdneH3Oz1xU9+NSX1Q2dkCseiG5KncaPWLOGYz8PnMPRn4OpTv4+l
 2RLGmtqFsYVvLYmO0Tl2/izEahCsF/HRSAXI624rj4b/iCk9ubgYuYmZ16RNt3SmTZnqDp1ZJSY
 OLsc6ZtgITj5k8Knw==
X-Received: by 2002:a05:7300:6428:b0:2a4:701a:b9ba with SMTP id
 5a478bee46e88-2c10987b1cbmr609228eec.14.1773969908079; 
 Thu, 19 Mar 2026 18:25:08 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b2e6c30sm1101353eec.25.2026.03.19.18.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:25:07 -0700 (PDT)
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
Date: Thu, 19 Mar 2026 18:24:52 -0700
Message-ID: <20260320012501.2033548-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v3 04/13] net: move promiscuity
 handling into dev_rx_mode_work
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

Move unicast promiscuity tracking into dev_rx_mode_work so it runs
under netdev_ops_lock instead of under the addr_lock spinlock. This
is required because __dev_set_promiscuity calls dev_change_rx_flags
and __dev_notify_flags, both of which may need to sleep.

Change ASSERT_RTNL() to netdev_ops_assert_locked() in
__dev_set_promiscuity, netif_set_allmulti and __dev_change_flags
since these are now called from the work queue under the ops lock.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst |  4 ++
 net/core/dev.c                          | 79 +++++++++++++++++--------
 2 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index dc83d78d3b27..5cdaa1a3dcc8 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -298,6 +298,10 @@ struct net_device synchronization rules
 	Notes: Sleepable version of ndo_set_rx_mode. Receives snapshots
 	of the unicast and multicast address lists.
 
+ndo_change_rx_flags:
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
+
 ndo_setup_tc:
 	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
 	(i.e. no ``rtnl_lock`` and no device instance lock). The rest of
diff --git a/net/core/dev.c b/net/core/dev.c
index fedc423306fc..fc5c9b14faa0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9574,7 +9574,7 @@ static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 	kuid_t uid;
 	kgid_t gid;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	promiscuity = dev->promiscuity + inc;
 	if (promiscuity == 0) {
@@ -9610,16 +9610,8 @@ static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 
 		dev_change_rx_flags(dev, IFF_PROMISC);
 	}
-	if (notify) {
-		/* The ops lock is only required to ensure consistent locking
-		 * for `NETDEV_CHANGE` notifiers. This function is sometimes
-		 * called without the lock, even for devices that are ops
-		 * locked, such as in `dev_uc_sync_multiple` when using
-		 * bonding or teaming.
-		 */
-		netdev_ops_assert_locked(dev);
+	if (notify)
 		__dev_notify_flags(dev, old_flags, IFF_PROMISC, 0, NULL);
-	}
 	return 0;
 }
 
@@ -9641,7 +9633,7 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	allmulti = dev->allmulti + inc;
 	if (allmulti == 0) {
@@ -9671,12 +9663,36 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
+/**
+ * dev_uc_promisc_update() - evaluate whether uc_promisc should be toggled.
+ * @dev: device
+ *
+ * Must be called under netif_addr_lock_bh.
+ * Return: +1 to enter promisc, -1 to leave, 0 for no change.
+ */
+static int dev_uc_promisc_update(struct net_device *dev)
+{
+	if (dev->priv_flags & IFF_UNICAST_FLT)
+		return 0;
+
+	if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
+		dev->uc_promisc = true;
+		return 1;
+	}
+	if (netdev_uc_empty(dev) && dev->uc_promisc) {
+		dev->uc_promisc = false;
+		return -1;
+	}
+	return 0;
+}
+
 static void dev_rx_mode_work(struct work_struct *work)
 {
 	struct net_device *dev = container_of(work, struct net_device,
 					      rx_mode_work);
 	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc;
 	int err;
 
 	__hw_addr_init(&uc_snap);
@@ -9704,16 +9720,29 @@ static void dev_rx_mode_work(struct work_struct *work)
 		if (!err)
 			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
 						      dev->addr_len);
-		netif_addr_unlock_bh(dev);
 
 		if (err) {
 			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
 			__hw_addr_flush(&uc_snap);
 			__hw_addr_flush(&uc_ref);
 			__hw_addr_flush(&mc_snap);
+			netif_addr_unlock_bh(dev);
 			goto out;
 		}
 
+		promisc_inc = dev_uc_promisc_update(dev);
+
+		netif_addr_unlock_bh(dev);
+	} else {
+		netif_addr_lock_bh(dev);
+		promisc_inc = dev_uc_promisc_update(dev);
+		netif_addr_unlock_bh(dev);
+	}
+
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
+
+	if (ops->ndo_set_rx_mode_async) {
 		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
 
 		netif_addr_lock_bh(dev);
@@ -9722,6 +9751,10 @@ static void dev_rx_mode_work(struct work_struct *work)
 		__hw_addr_list_reconcile(&dev->mc, &mc_snap,
 					 &mc_ref, dev->addr_len);
 		netif_addr_unlock_bh(dev);
+	} else if (ops->ndo_set_rx_mode) {
+		netif_addr_lock_bh(dev);
+		ops->ndo_set_rx_mode(dev);
+		netif_addr_unlock_bh(dev);
 	}
 
 out:
@@ -9740,28 +9773,22 @@ static void dev_rx_mode_work(struct work_struct *work)
 void __dev_set_rx_mode(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc;
 
 	/* dev_open will call this function so the list will stay sane. */
 	if (!netif_up_and_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
 		queue_work(rx_mode_wq, &dev->rx_mode_work);
 		return;
 	}
 
-	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
-		/* Unicast addresses changes may only happen under the rtnl,
-		 * therefore calling __dev_set_promiscuity here is safe.
-		 */
-		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
-			__dev_set_promiscuity(dev, 1, false);
-			dev->uc_promisc = true;
-		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
-			__dev_set_promiscuity(dev, -1, false);
-			dev->uc_promisc = false;
-		}
-	}
+	/* Legacy path for non-ops locked HW devices. */
+
+	promisc_inc = dev_uc_promisc_update(dev);
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
 
 	if (ops->ndo_set_rx_mode)
 		ops->ndo_set_rx_mode(dev);
@@ -9811,7 +9838,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 	unsigned int old_flags = dev->flags;
 	int ret;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	/*
 	 *	Set the flags on our device.
-- 
2.53.0

