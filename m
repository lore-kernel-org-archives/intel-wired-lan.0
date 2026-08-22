Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30184C5DF8C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F0B840C82;
	Sat, 22 Aug 2026 00:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2tQcK1bWwRW; Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357703;
	bh=Io/nMFSjMGkqT1f/XLN8nxhqH+XoxGeVF4YZZqKWg7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfgngCxiuelm2u9eJlyWqwGquQXRfFugD0obiUfA1HNWD7IyC35d/Ig21lZfjO8Xa
	 y30C1Ye0MTGayrBdlROKPsZi0ql9REVNO/19n2qPp6gYp4ogEYsM3PGNC/FR0BHXjr
	 DPTUW1fHZ3K8FZ/x8J5hJFCoYwbv+BmZ1DqL0EFgjcwP5mtGp60hvtv9quFGgA6yyw
	 94fcPWlVAvQyH/uCNLBsPiL6FslR6VXPR/U0Waz4QAzT29oMaBCVM8YDgBPrBpiwRG
	 JdGJgF4CyovLjhzHSxSTb2cHqQI7Pg1lHDYvgO/zaa6I01hZbzdtLLEAHYisMH4D5z
	 Wq7eA5/vLKwxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E78840C08;
	Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9593693F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 938FD81337
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 51SOjmD2vtXR for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=j5oUfbOT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F198F81323
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357699; x=1818893699;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=sib9qqtcxzaLDr8babf9+IviWNuGQFt7unClwffkimA=;
 b=j5oUfbOTNKK4eoUJRThBPuPnjdvWYclVDFI8MOyCRxh6qsDsX5Rjza1T
 l1F9+VSBt9IdURDlxGkO8Hz8DH9HfYw4kJCtiOaoHM8zOt3HA8y8UrEbD
 OaI/rpErC/8JyhSZmpXHOjtc7/5Wv0IlEAoj/SLC1ts5O5AP9dkRnbKzD
 D0PA4+OBHDpD+GmTYyQ+Ts5TpN7+1lQA4E2Ek6jRAljnWL0wxI5dKKqFV
 WSTyD/Fc0Eq0FRDsu4CnKyDlLnLlfBwoy2bdT7Raq67t/Or/SPIIGLJvb
 0bbVnaMDDaz06e9FlND3//ev63ldWs1UTCqVOul18FyTtkXRcZR+x/ba5 A==;
X-CSE-ConnectionGUID: v6SizTnNRf6BCEMtRQgnmg==
X-CSE-MsgGUID: geJ4Z414TZqSVB9afeXv5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584753"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584753"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:57 -0700
X-CSE-ConnectionGUID: f5WOeVKqSCCFqRDhTucdAg==
X-CSE-MsgGUID: kGYJ8wLpS5ewARmwwQFVHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836457"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:56 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:06 -0700
Subject: [PATCH iwl-net 01/12] ice: use reference counting and RCU for PTP
 port access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-1-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=13310;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=sib9qqtcxzaLDr8babf9+IviWNuGQFt7unClwffkimA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOlz8E91/T4N3HaS8ty7+4Y5P+qpU7xZOichKdOO99O
 vmS1yKko5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlM42T4Kyvwn6l59raoRe/2
 zufJlNMTNPTyNq9qKNKMjX8+RWOOIMP/4gZZv8KinaUdrsXbGj48y/q0WODYlZ23ndI8vFd/7n3
 CBQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

The ice adapter structure maintains a list of ports associated with the
adapter. This is used for supporting PTP, where the clock owner must handle
many operations that require access to the PTP port structures of the
associated PFs.

This is implemented using a linked list and a mutex. This sort of works,
but a few places within the code do not acquire the mutex when iterating
the list. This includes ice_ptp_flush_all_tx_tracker(),
ice_ptp_restart_all_phy(), and ice_ptp_prepare_rebuild_sec().

Fixing this is tricky, especially since it is not clear if we can simply
acquire the lock around the complete iterations.

The pattern of use for the port list is read-mostly with modifications only
happening during PF initialization when elements are inserted. This
typically only happens during early boot, though a PF could in principle be
removed or loaded at arbitrary times via bind and unbind operations.

The use of a mutex does mean the driver can sleep while holding it, but it
still creates complicates with lock ordering and prevents iterating the
list in any code path that *can't* sleep.

Instead, use the RCU primitives for the port linked list, along with a
reference count on the port. The kref reference counter ensures that we can
safely acquire pointers with a guarantee of their lifetime, ensuring the
associated PF will not be removed until the reference is released.

For port iterations which are short and definitely can't sleep, wrap the
entire loop with rcu_read_lock() and rcu_read_unlock().

For longer operations, or those which might sleep, we need to close the
critical section between each loop iteration. To make this safe, start
the loop iteration with rcu_read_lock(), then acquire a reference for the
port with kref_get_unless_zero. If this returns 0, the port is already in
the process of being removed, so that port should be skipped when
iterating. Once a reference to the port is acquired, exit the RCU critical
section. Then, perform the desired operations on the port, followed by
releasing the reference with kref_put and then re-entering a critical
section at the end of the loop body. Note that kref_put() is done outside
the RCU critical section. This is safe, as the port will not be freed until
all references are dropped.

The ice_ptp_release_port_rcu() function is used as the release function for
the kref_put() call. To avoid a potential infinite loop of new references,
the release function simply uses a wake_up_var() call to wake the closing
thread. The ice_ptp_cleanup_pf() function will remove the port from the linked
list using list_del_rcu, then release its primary reference, then wait for all
references to drop via wait queue. Finally synchronize_rcu() is called to
guarantee the port remains valid for at least one RCU grace period. Then PF
removal will continue.

This flow ensures that all accesses to ports via the port list will remain
valid until either the RCU critical sections end, or the references have
been dropped.

One major complication of this reference count is that ice_ptp_port is
embedded inside of other structures and not merely allocated. As a result,
we can't use the standard pattern of kfree_rcu() to just delay freeing
until references are dropped, and instead are delaying PF port teardown. If
any code path leaks the reference, the driver will be unable to teardown.
Instead, a 15 second timeout with a WARN() is used when waiting to finally
allow PF teardown to continue. This has the risk of potentially allowing
use-after-free, assuming some path really is stuck for 15 seconds. However,
this both less likely and a less bad outcome compared to blocking
indefinitely on a reference leak.

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   4 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |   7 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 118 +++++++++++++++++++--------
 4 files changed, 96 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 4f695f32da3d..39923dedd534 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -19,13 +19,13 @@ struct ice_pf;
  *
  * This structure contains data used to maintain a list of adapter ports
  *
- * @ports: list of ports
+ * @list: list of ports
  * @lock: protect access to the ports list
  */
 struct ice_port_list {
-	struct list_head ports;
+	struct list_head list;
 	/* To synchronize the ports list operations */
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index c4b0da7ce20e..da2003ba3bb0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -5,6 +5,8 @@
 #define _ICE_PTP_H_
 
 #include <linux/ptp_clock_kernel.h>
+#include <linux/rculist.h>
+#include <linux/kref.h>
 #include <linux/kthread.h>
 
 #include "ice_ptp_hw.h"
@@ -138,6 +140,7 @@ struct ice_ptp_tx {
  * and determine when the port's PHY offset is valid.
  *
  * @list_node: list member structure
+ * @ref: reference counter for use with adapter ports list
  * @tx: Tx timestamp tracking for this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
  * @ps_lock: mutex used to protect the overall PTP PHY start procedure
@@ -149,6 +152,7 @@ struct ice_ptp_tx {
  */
 struct ice_ptp_port {
 	struct list_head list_node;
+	struct kref ref;
 	struct ice_ptp_tx tx;
 	struct kthread_delayed_work ov_work;
 	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 2dc3629d6d0f..d1643bf8a1b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -66,18 +66,17 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 		mutex_init(&adapter->cpi_phy_lock[i]);
 	refcount_set(&adapter->refcount, 1);
 
-	mutex_init(&adapter->ports.lock);
-	INIT_LIST_HEAD(&adapter->ports.ports);
+	spin_lock_init(&adapter->ports.lock);
+	INIT_LIST_HEAD(&adapter->ports.list);
 
 	return adapter;
 }
 
 static void ice_adapter_free(struct ice_adapter *adapter)
 {
-	WARN_ON(!list_empty(&adapter->ports.ports));
+	WARN_ON(!list_empty(&adapter->ports.list));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
-	mutex_destroy(&adapter->ports.lock);
 
 	kfree(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index eaec36ab6ae3..1d647ccce7c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/rculist.h>
+#include <linux/wait_bit.h>
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
@@ -673,20 +675,33 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf->ptp.tx_hwtstamp_good += tstamp_good;
 }
 
+static void ice_ptp_release_port_rcu(struct kref *ref)
+{
+	wake_up_var(ref);
+}
+
 static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 {
 	struct ice_ptp_port *port;
 
-	mutex_lock(&pf->adapter->ports.lock);
-	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
 		struct ice_ptp_tx *tx = &port->tx;
 
-		if (!tx || !tx->init)
+		if (!tx->init)
 			continue;
 
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+
+		rcu_read_unlock();
+
 		ice_ptp_process_tx_tstamp(tx);
+
+		kref_put(&port->ref, ice_ptp_release_port_rcu);
+		rcu_read_lock();
 	}
-	mutex_unlock(&pf->adapter->ports.lock);
+	rcu_read_unlock();
 }
 
 /**
@@ -808,8 +823,16 @@ ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
 {
 	struct ice_ptp_port *port;
 
-	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+		rcu_read_unlock();
 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
+		kref_put(&port->ref, ice_ptp_release_port_rcu);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
 }
 
 /**
@@ -1424,16 +1447,21 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
  */
 static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
-	struct list_head *entry;
+	struct ice_ptp_port *port;
 
-	list_for_each(entry, &pf->adapter->ports.ports) {
-		struct ice_ptp_port *port = list_entry(entry,
-						       struct ice_ptp_port,
-						       list_node);
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+		rcu_read_unlock();
 
 		if (port->link_up)
 			ice_ptp_port_phy_restart(port);
+
+		kref_put(&port->ref, ice_ptp_release_port_rcu);
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 }
 
 /**
@@ -2694,19 +2722,19 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
 
 static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 {
+	bool have_tstamps = false;
 	struct ice_ptp_port *port;
 
-	scoped_guard(mutex, &pf->adapter->ports.lock) {
-		list_for_each_entry(port, &pf->adapter->ports.ports,
-				    list_node) {
-			struct ice_ptp_tx *tx = &port->tx;
-
-			if (ice_port_has_timestamps(tx))
-				return true;
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
+		if (ice_port_has_timestamps(&port->tx)) {
+			have_tstamps = true;
+			break;
 		}
 	}
+	rcu_read_unlock();
 
-	return false;
+	return have_tstamps;
 }
 
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
@@ -2890,14 +2918,16 @@ void ice_ptp_queue_work(struct ice_pf *pf)
 static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 					enum ice_reset_req reset_type)
 {
-	struct list_head *entry;
+	struct ice_ptp_port *port;
 
-	list_for_each(entry, &pf->adapter->ports.ports) {
-		struct ice_ptp_port *port = list_entry(entry,
-						       struct ice_ptp_port,
-						       list_node);
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
 		struct ice_pf *peer_pf = ptp_port_to_pf(port);
 
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+		rcu_read_unlock();
+
 		if (!ice_is_primary(&peer_pf->hw)) {
 			if (rebuild) {
 				/* TODO: When implementing rebuild=true:
@@ -2909,7 +2939,11 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 				ice_ptp_prepare_for_reset(peer_pf, reset_type);
 			}
 		}
+
+		kref_put(&port->ref, ice_ptp_release_port_rcu);
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 }
 
 /**
@@ -3086,11 +3120,11 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&ptp->port.list_node);
-	mutex_lock(&pf->adapter->ports.lock);
+	kref_init(&ptp->port.ref);
 
-	list_add(&ptp->port.list_node,
-		 &pf->adapter->ports.ports);
-	mutex_unlock(&pf->adapter->ports.lock);
+	spin_lock(&pf->adapter->ports.lock);
+	list_add_rcu(&ptp->port.list_node, &pf->adapter->ports.list);
+	spin_unlock(&pf->adapter->ports.lock);
 
 	/* Seed the per-PHY Tx reference clock usage map for this port.
 	 * Only meaningful on E825 (other MAC types don't expose tx-clk
@@ -3113,12 +3147,32 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 static void ice_ptp_cleanup_pf(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
+	struct kref *ref;
 
-	if (pf->hw.mac_type != ICE_MAC_UNKNOWN) {
-		mutex_lock(&pf->adapter->ports.lock);
-		list_del(&ptp->port.list_node);
-		mutex_unlock(&pf->adapter->ports.lock);
-	}
+	if (pf->hw.mac_type == ICE_MAC_UNKNOWN)
+		return;
+
+	/* The PF cannot be removed until there are no more remaining
+	 * outstanding references to the PTP port. To make sure this is true,
+	 * first remove the port from the list, then drop the primary
+	 * reference this PF holds on the port. Once done, wait until all
+	 * existing references are dropped. Finally, synchronize_rcu() to
+	 * ensure that all RCU critical sections that might attempt to
+	 * dereference the port are finished.
+	 */
+
+	spin_lock(&pf->adapter->ports.lock);
+	list_del_rcu(&ptp->port.list_node);
+	spin_unlock(&pf->adapter->ports.lock);
+
+	ref = &ptp->port.ref;
+	kref_put(ref, ice_ptp_release_port_rcu);
+
+	dev_WARN_ONCE(ice_pf_to_dev(pf),
+		      !wait_var_event_timeout(ref, !kref_read(ref), 15 * HZ),
+		      "Timed out waiting for port references to release. Continuing to unload anyways.");
+
+	synchronize_rcu();
 }
 
 /**

-- 
2.55.0.814.gc42f45431d0f

