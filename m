Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137D81093168
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 01:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1EC68452E;
	Fri, 20 Mar 2026 01:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5GfdpcvKTTtP; Fri, 20 Mar 2026 01:25:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09CCD8452F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773969911;
	bh=0WCep2sMd+XcNQUXoONoloTYC004nnvk8vp16Ef+qqc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kre6art6odvVyATPUYImTMq01lVCBZLqDAuLFcA38E2UomP6ZPJVGKitJnXQDnKMm
	 BWUAJF4h4FJWJCW2qV6/yHgRBTgoh3nogZ86LX5qqvYZNJEG/e1+ZXkW2fKV0ctVfH
	 EDY/i0JHCir+PcuJIN2IYXVzF/GhUG4DcHcOZV9RzWM+n+VC+AZySVFtmOrSzEel6E
	 088qvK0thcuiFto443tCbLo+7189U4y0aBzBJ9CbPbsa4WFpPQEIyOvckKqkedPo3c
	 VNHiPUIw7qGX7jJULOOTKOKXyWSNUfXBLuFBTumX9m5K+1YEI/D2+BbuogK4kj0QV3
	 7LqjLyvgMFPWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09CCD8452F;
	Fri, 20 Mar 2026 01:25:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D870265
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FC888452B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K10_zicRyeXb for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 01:25:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.171;
 helo=mail-dy1-f171.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0F41E84527
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F41E84527
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F41E84527
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:07 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2c0bcd8f194so2173846eec.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 18:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969907; x=1774574707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0WCep2sMd+XcNQUXoONoloTYC004nnvk8vp16Ef+qqc=;
 b=qtQDeOYRbo2JtYd75RUdRITtdn54knuXZiwx5Y+7vkXfMsOlXvqnhrH1Rk+RnNumjL
 ed5rZzyZAnDigQqI4AfLLrWv3YNS5yQDLQfwzZEvoOxLS4CVou2yZphLpFIrw5RrAqLd
 cXpguZUpH9whYrGt2+BfMzuNgtG6DbF85EKnqbjad8rf+TDyOuwp8bRi75ZczTa7SP36
 Ny6OMSW2bJCdTHD3T/s20O/pilhbbZr0lkTZco7cpWsyreEKfcKcfjHmKzD/RKHNsBzc
 a58c1U0QB9ZqEZNmk/u/nXetOORNNlA2oD6v/6ugpDGsa1ojs2fsSdqCN11nNp2FUXWz
 of1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxKTYai5CaTEpeoS5DLalW74cEzvVTjbfXjaFA7KUHld10OX4jqSq7nkVtI/cDPIrsM8qIn4lwLDUt/dQtplQ=@lists.osuosl.org
X-Gm-Message-State: AOJu0YziouuxYkmFUaD2tQQhDGVYJY0/hKId9vEyfXerdrBhXiUJfzD8
 GnH6R9XOvySypoGKatpoRcUH4DjZgS7vnqE042+8RZP6gNl2nzGZ8l4=
X-Gm-Gg: ATEYQzxRtXGYjx3ne/xf0nrng4BZySE4P8dqqHacYbuglM/lxkuGEAvaLk+yrqZC8tN
 K+9KDjireFLsMxjJ9beQ6EoPyuWXBdv+7RNJQKLLdkJYcxn9Af4iHLWaBpZucppEFO3mJUy2l0M
 o9vmlEOXLWICW6QQ5qX2+ixmpSsARdqexcBQNCZGnKq/HqDbPCw4aNgcF0Lk33F6+SIiXT4Kom3
 q0gaTcx24FJg+XsEmmHYf/E+EB0SKT9CPIwxHVXQfNP3/0npDpD2+1Er3tRd321VaOOCUnndLUm
 NgynTTqY01A/QSrMwcmMxk1MoZEYiXS9VU6e/VCHqLVdHD2gobRnVEpaQfB95BQZsbG1XZL+rUs
 iXWt2x7lwKGCqOdrbTUSeysPSuYvSD4KZZDcmSwP+BZUZ8B5S+DhNeccuFxTNL9A3v8qJ7CNyIe
 g8m1g4ewrDG6ZT0wzcKNIlq7jRB7J0DyEjFdn47MKU8ZIjGwchVgZFNzJIGRyCtjKnk14KlsFqE
 KvFof966eUrdjehcw==
X-Received: by 2002:a05:7300:e208:b0:2b0:52cc:fe69 with SMTP id
 5a478bee46e88-2c109567323mr694475eec.5.1773969906707; 
 Thu, 19 Mar 2026 18:25:06 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b31ebd5sm1142605eec.27.2026.03.19.18.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:25:06 -0700 (PDT)
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
Date: Thu, 19 Mar 2026 18:24:51 -0700
Message-ID: <20260320012501.2033548-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
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

Add ndo_set_rx_mode_async callback that drivers can implement instead
of the legacy ndo_set_rx_mode. The legacy callback runs under the
netif_addr_lock spinlock with BHs disabled, preventing drivers from
sleeping. The async variant runs from a work queue with rtnl_lock and
netdev_lock_ops held, in fully sleepable context.

When __dev_set_rx_mode() sees ndo_set_rx_mode_async, it schedules
dev_rx_mode_work instead of calling the driver inline. The work
function takes two snapshots of each address list (uc/mc) under
the addr_lock, then drops the lock and calls the driver with the
work copies. After the driver returns, it reconciles the snapshots
back to the real lists under the lock.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst |  8 +++
 include/linux/netdevice.h               | 20 ++++++
 net/core/dev.c                          | 95 +++++++++++++++++++++++--
 3 files changed, 116 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 35704d115312..dc83d78d3b27 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -289,6 +289,14 @@ struct net_device synchronization rules
 ndo_set_rx_mode:
 	Synchronization: netif_addr_lock spinlock.
 	Context: BHs disabled
+	Notes: Deprecated in favor of sleepable ndo_set_rx_mode_async.
+
+ndo_set_rx_mode_async:
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
+	Context: process (from a work queue)
+	Notes: Sleepable version of ndo_set_rx_mode. Receives snapshots
+	of the unicast and multicast address lists.
 
 ndo_setup_tc:
 	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 469b7cdb3237..b05bdd67b807 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1117,6 +1117,16 @@ struct netdev_net_notifier {
  *	This function is called device changes address list filtering.
  *	If driver handles unicast address filtering, it should set
  *	IFF_UNICAST_FLT in its priv_flags.
+ *	Cannot sleep, called with netif_addr_lock_bh held.
+ *	Deprecated in favor of sleepable ndo_set_rx_mode_async.
+ *
+ * void (*ndo_set_rx_mode_async)(struct net_device *dev,
+ *				 struct netdev_hw_addr_list *uc,
+ *				 struct netdev_hw_addr_list *mc);
+ *	Sleepable version of ndo_set_rx_mode. Called from a work queue
+ *	with rtnl_lock and netdev_lock_ops(dev) held. The uc/mc parameters
+ *	are snapshots of the address lists - iterate with
+ *	netdev_hw_addr_list_for_each(ha, uc).
  *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
@@ -1437,6 +1447,9 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_set_rx_mode_async)(struct net_device *dev,
+							 struct netdev_hw_addr_list *uc,
+							 struct netdev_hw_addr_list *mc);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -1903,6 +1916,7 @@ enum netdev_reg_state {
  *				has been enabled due to the need to listen to
  *				additional unicast addresses in a device that
  *				does not implement ndo_set_rx_mode()
+ *	@rx_mode_work:		Work queue entry for ndo_set_rx_mode_async()
  *	@uc:			unicast mac addresses
  *	@mc:			multicast mac addresses
  *	@dev_addrs:		list of device hw addresses
@@ -2293,6 +2307,7 @@ struct net_device {
 	unsigned int		promiscuity;
 	unsigned int		allmulti;
 	bool			uc_promisc;
+	struct work_struct	rx_mode_work;
 #ifdef CONFIG_LOCKDEP
 	unsigned char		nested_level;
 #endif
@@ -4661,6 +4676,11 @@ static inline bool netif_device_present(const struct net_device *dev)
 	return test_bit(__LINK_STATE_PRESENT, &dev->state);
 }
 
+static inline bool netif_up_and_present(const struct net_device *dev)
+{
+	return (dev->flags & IFF_UP) && netif_device_present(dev);
+}
+
 void netif_device_detach(struct net_device *dev);
 
 void netif_device_attach(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 200d44883fc1..fedc423306fc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2381,6 +2381,8 @@ static void netstamp_clear(struct work_struct *work)
 static DECLARE_WORK(netstamp_work, netstamp_clear);
 #endif
 
+static struct workqueue_struct *rx_mode_wq;
+
 void net_enable_timestamp(void)
 {
 #ifdef CONFIG_JUMP_LABEL
@@ -9669,22 +9671,84 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
-/*
- *	Upload unicast and multicast address lists to device and
- *	configure RX filtering. When the device doesn't support unicast
- *	filtering it is put in promiscuous mode while unicast addresses
- *	are present.
+static void dev_rx_mode_work(struct work_struct *work)
+{
+	struct net_device *dev = container_of(work, struct net_device,
+					      rx_mode_work);
+	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int err;
+
+	__hw_addr_init(&uc_snap);
+	__hw_addr_init(&mc_snap);
+	__hw_addr_init(&uc_ref);
+	__hw_addr_init(&mc_ref);
+
+	rtnl_lock();
+	netdev_lock_ops(dev);
+
+	if (!netif_up_and_present(dev))
+		goto out;
+
+	if (ops->ndo_set_rx_mode_async) {
+		netif_addr_lock_bh(dev);
+
+		err = __hw_addr_list_snapshot(&uc_snap, &dev->uc,
+					      dev->addr_len);
+		if (!err)
+			err = __hw_addr_list_snapshot(&uc_ref, &dev->uc,
+						      dev->addr_len);
+		if (!err)
+			err = __hw_addr_list_snapshot(&mc_snap, &dev->mc,
+						      dev->addr_len);
+		if (!err)
+			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
+						      dev->addr_len);
+		netif_addr_unlock_bh(dev);
+
+		if (err) {
+			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
+			__hw_addr_flush(&uc_snap);
+			__hw_addr_flush(&uc_ref);
+			__hw_addr_flush(&mc_snap);
+			goto out;
+		}
+
+		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
+
+		netif_addr_lock_bh(dev);
+		__hw_addr_list_reconcile(&dev->uc, &uc_snap,
+					 &uc_ref, dev->addr_len);
+		__hw_addr_list_reconcile(&dev->mc, &mc_snap,
+					 &mc_ref, dev->addr_len);
+		netif_addr_unlock_bh(dev);
+	}
+
+out:
+	netdev_unlock_ops(dev);
+	rtnl_unlock();
+}
+
+/**
+ * __dev_set_rx_mode() - upload unicast and multicast address lists to device
+ * and configure RX filtering.
+ * @dev: device
+ *
+ * When the device doesn't support unicast filtering it is put in promiscuous
+ * mode while unicast addresses are present.
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 
 	/* dev_open will call this function so the list will stay sane. */
-	if (!(dev->flags&IFF_UP))
+	if (!netif_up_and_present(dev))
 		return;
 
-	if (!netif_device_present(dev))
+	if (ops->ndo_set_rx_mode_async) {
+		queue_work(rx_mode_wq, &dev->rx_mode_work);
 		return;
+	}
 
 	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
 		/* Unicast addresses changes may only happen under the rtnl,
@@ -11708,6 +11772,16 @@ void netdev_run_todo(void)
 
 	__rtnl_unlock();
 
+	/* Make sure all pending rx_mode work completes before returning.
+	 *
+	 * rx_mode_wq may be NULL during early boot:
+	 * core_initcall(netlink_proto_init) vs subsys_initcall(net_dev_init).
+	 *
+	 * Check current_work() to avoid flushing from the wq.
+	 */
+	if (rx_mode_wq && !current_work())
+		flush_workqueue(rx_mode_wq);
+
 	/* Wait for rcu callbacks to finish before next phase */
 	if (!list_empty(&list))
 		rcu_barrier();
@@ -12099,6 +12173,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #endif
 
 	mutex_init(&dev->lock);
+	INIT_WORK(&dev->rx_mode_work, dev_rx_mode_work);
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
@@ -12203,6 +12278,8 @@ void free_netdev(struct net_device *dev)
 
 	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
 
+	cancel_work_sync(&dev->rx_mode_work);
+
 	/* Flush device addresses */
 	dev_addr_flush(dev);
 
@@ -13296,6 +13373,10 @@ static int __init net_dev_init(void)
 	if (register_pernet_device(&default_device_ops))
 		goto out;
 
+	rx_mode_wq = alloc_ordered_workqueue("rx_mode_wq", 0);
+	if (!rx_mode_wq)
+		goto out;
+
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action);
 	open_softirq(NET_RX_SOFTIRQ, net_rx_action);
 
-- 
2.53.0

