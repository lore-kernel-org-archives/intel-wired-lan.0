Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E877C88E7B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E2796077E;
	Tue, 15 Sep 2026 12:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e6YeS10AWH4P; Tue, 15 Sep 2026 12:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6B8E56077C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476972;
	b=lCDQLGBA+OcRjGiEuQTAIYddZxFIUj99kWu8NHmTHgYivEKMW1YxRmaQYoTdn1A+lZH1
	 EMIJ99LyD5SAwvnnOg1VDwZJPgtXAT5zrNslSYadVCS8mV6KjdjUp4NduR2G2R7WdttqX
	 HT3bWk2UxvcvgvL6Kvri+AbT7uPu41O7A/hBCCcZeOV0D0NWdVQsK2D0nWS73D5DAMMIe
	 vKfJ9478Pe17AGp4RUycvRb2XDgef6ntrvtPElzYILhijPlpYMOKXWbrUXSC0RxrG6E8W
	 SQ/6Byi6VEAFzBdYLmhUHg68nGZIDJOe1XXfnYruNKJzfCFoRuO5BZsx7UxJHt1Kp5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4kq2YCiyJkXHBqb9Qmr9XRWDDAzrONZ+YXKObzvbJrA=;
	b=acF2tNfi6cjJV9HUSRoJDl3lso5NcRHDxVut0BFiKYDsUrRSbb0CqbV+doWuFg+gjNaN
	 0JihJ9uJAQNNyZReCj9v/PHjMICcjHHSNAitXvXHHenyJK/fUt0IYem8xkfYaaqvGaonM
	 PCyEREh73gFRIKbPxkNTltWrQ9CK6qE7jOz71FYBMKMVpxmb3OAHaXt3/YKOCgAFtBds8
	 fAfeJR35UVahr1rhqPPZ3zfV0ECnwsaLv4/uJ3vWeb6/sRyfYtITvr/bvDo06rlhcBuCO
	 SKF8rrcHXFPpJjk1UOof7D8FV8voRioLwFhGu9j0EzxiomNb7ipiEUez79xDKhS4B2Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476972;
	bh=4kq2YCiyJkXHBqb9Qmr9XRWDDAzrONZ+YXKObzvbJrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8kWeIzgemNAzjjf2ukgn0FXRQtzMdSMnLnWamtyWRAgQWnNS8T657CkcPnRPi41TZ
	 5j79wT4LVKckWItf5G7hp61k25XxoTyJNtKcxi1NZ4jRarL5waH1ojmh+po2oWBhj5
	 LTOT4u5FkSOO4KQvgkmczUAqutpuaK6qWCZRwiLWDuP7TkGq68fnc3+Zhqa1JaG6nt
	 sdkzaL3Jb/Jrn44VJ7jP28KJuIBA7yDqshgfKJQF7sGZlShddvfGelL4+k1RM6aZci
	 iUDxxC1f3clgJb79QRL8/M6OZt55pR1oG9Zo+GnWD9BA75MHLp+yYuTC9mGjTdssEu
	 hyPrLsjmeSjrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B8E56077C;
	Tue, 15 Sep 2026 12:56:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 56D5D259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D2A4401DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pl8_3GEDuJMW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3FF594002B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476969;
 b=jCZNknlGIYfwmFxcoP39S4GQ4CywMnv9tTKuMdQM22Qk6yJJEWCDiIjSYrjWW2y4JUQz
 kjghqBcDKCC963+g2UK2CsAWiDn337T4VexLLDE0W+Cv8H4AabUctLJ4a3pZva2M1O2Q0
 E6joLSo0cNvg8vmhti2KHMHdfSqLei7ZEPbMRdcAOa9RYbwvT7WwgeEvnsG+h6TeW35ft
 wIRetB9+QZUsqUgx8NCnv+RXvUurxk4Efcapz2a5GIkGqlkznj2oqLtGn7OB9DK+0tpJX
 DmbMHO9IS7PmgdOJylg312tGtiC3HObGTKw53kaOGWq+V3/fDIrSZhLoe53fPCkb5sA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476969;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4kq2YCiyJkXHBqb9Qmr9XRWDDAzrONZ+YXKObzvbJrA=;
 b=qali9DXK17kB5W4x2Zkz/HyxpxxcvUFEJfKmpuJkfoDTBbRxeX5fDdoxdabVcQdaZa8k
 1mwy30LyqenA5g8O3wvlKjQjOVzxK7X8DV6d4f775bnSgYVZ20ziyS+CKQtXTAlJR+3pV
 Tttnc+FG7QeBSygL2rwqp/eXJHx9FcD0FVXvN2YZxgUJViICI0aiCUruZcejQT4l9FeCK
 ku7CNfobRC5hBX6v4pXNcc+c2hh9LnQr3ZohOHLE8TqEJqq1lgxC4S2jlkPM9TjNykBq1
 b9KGWPVNlaozELEMIr+pqKl+XHeCQbiBk2Cfqqy+N6Yvz2HgFBIWHEGJtjppZTLCVNw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fFiaNLRH; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fFiaNLRH
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FF594002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476969; x=1821012969;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SVi2QyFt7LAfpt1ccmZ+QuM4IbdNUnhyGVGSXCmWt90=;
 b=fFiaNLRHo/1ADviMCKdUup0KXV1WxtptT3O0++OnbSiKP+NsoKuL7U+D
 zQ9KfZFbX38EwoxlSugeslvJlDZBT4GfL4HgGlhNy1Nh4HkFQc0AOyDii
 4jQpMsaPOK2gF5vWhsb8uTGS35c94lm7oKYUtBuef8GLZUIegi3wWTyZg
 nwNGSkYGVLmLLw4dRBMaAHAsNCIoZ55PgM879yLHDhCWEojy6xe/L4gjb
 iGLjO0sYCMmYLtb9yT6oG3jsr71djdtYD9OBNWh5X+It9lqzHLZoV8M1b
 g5/Pp1+HtJk4RZHcY+BOkUb8CFkd6uaovyjLHjUBqyLCD2pXD71tpyiVw g==;
X-CSE-ConnectionGUID: em8fHETSRiemVPGMX5Hqsw==
X-CSE-MsgGUID: h3XcNI2dSaG+Os02PJps5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607077"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112607077"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:55 -0700
X-CSE-ConnectionGUID: Hg/7Z68QRw+R9IW5vH3RXw==
X-CSE-MsgGUID: cE0OiWPZRyW13+J2Pfgjkg==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:53 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kiran Patil <kiran.patil@intel.com>
Subject: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference in
 iavf_detect_recover_hung
Date: Tue, 15 Sep 2026 14:55:47 +0200
Message-ID: <20260915125551.3976068-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Kiran Patil <kiran.patil@intel.com>

iavf_watchdog_task() and iavf_reset_task() both run as work items on the
same ordered adapter->wq, so they can't race with each other. However,
iavf_set_ringparam() (and other ethtool ops) call iavf_reset_step()
directly from process context under the netdev instance lock, without
going through that workqueue at all. iavf_reset_step() can free and
reallocate adapter->tx_rings and the q_vectors array via
iavf_reinit_interrupt_scheme() while adapter->state still reads
__IAVF_RUNNING, so the watchdog task can concurrently call
iavf_detect_recover_hung() and dereference a NULL q_vector inside
iavf_force_wb(), or index into a NULL tx_rings array, causing a crash.

Guard against this by:
- returning early if vsi->back->tx_rings itself is NULL, since
  num_active_queues can still be nonzero while the array is being
  reallocated;
- skipping rings whose q_vector is NULL;
- reading tx_ring->q_vector once with READ_ONCE() into a local variable
  and reusing that same value for both the NULL check and the
  iavf_force_wb() call, instead of re-reading the field right before
  use, which would leave a window for the concurrent reset to swap it
  from underneath us in between.

Also move the tx_ring declaration into the loop body and drop the
redundant outer NULL initialisation, which the compiler can never
observe since an array-element address is always non-NULL.

Fixes: 07d44190a389 ("i40e/i40evf: Detect and recover hung queue scenario")
Cc: stable@vger.kernel.org
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 50 ++++++++++++---------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index c30abf1..f1c26a9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -176,7 +176,6 @@ static void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector)
  **/
 void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 {
-	struct iavf_ring *tx_ring = NULL;
 	struct net_device *netdev;
 	unsigned int i;
 	int packets;
@@ -194,29 +193,38 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 	if (!netif_carrier_ok(netdev))
 		return;
 
+	/* tx_rings can be freed/reallocated by a concurrent reset */
+	if (!vsi->back->tx_rings)
+		return;
+
 	for (i = 0; i < vsi->back->num_active_queues; i++) {
-		tx_ring = &vsi->back->tx_rings[i];
-		if (tx_ring && tx_ring->desc) {
-			/* If packet counter has not changed the queue is
-			 * likely stalled, so force an interrupt for this
-			 * queue.
-			 *
-			 * prev_pkt_ctr would be negative if there was no
-			 * pending work.
-			 */
-			packets = tx_ring->stats.packets & INT_MAX;
-			if (tx_ring->prev_pkt_ctr == packets) {
-				iavf_force_wb(vsi, tx_ring->q_vector);
-				continue;
-			}
+		struct iavf_ring *tx_ring = &vsi->back->tx_rings[i];
+		struct iavf_q_vector *q_vector;
 
-			/* Memory barrier between read of packet count and call
-			 * to iavf_get_tx_pending()
-			 */
-			smp_rmb();
-			tx_ring->prev_pkt_ctr =
-			  iavf_get_tx_pending(tx_ring, true) ? packets : -1;
+		/* read once, q_vector can be reassigned by a concurrent reset */
+		q_vector = READ_ONCE(tx_ring->q_vector);
+		if (!q_vector || !tx_ring->desc)
+			continue;
+
+		/* If packet counter has not changed the queue is
+		 * likely stalled, so force an interrupt for this
+		 * queue.
+		 *
+		 * prev_pkt_ctr would be negative if there was no
+		 * pending work.
+		 */
+		packets = tx_ring->stats.packets & INT_MAX;
+		if (tx_ring->prev_pkt_ctr == packets) {
+			iavf_force_wb(vsi, q_vector);
+			continue;
 		}
+
+		/* Memory barrier between read of packet count and call
+		 * to iavf_get_tx_pending()
+		 */
+		smp_rmb();
+		tx_ring->prev_pkt_ctr =
+		  iavf_get_tx_pending(tx_ring, true) ? packets : -1;
 	}
 }
 
-- 
2.52.0

