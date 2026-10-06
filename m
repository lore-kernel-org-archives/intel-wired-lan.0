Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8DCA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 10:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C29C4059A;
	Tue,  6 Oct 2026 10:06:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q7QAzqz6hNEJ; Tue,  6 Oct 2026 10:06:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E43CB40596
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791281161;
	b=NAZ3WjqFniAwYngqLY9woszIGddHNx+o53lBBBipVQeb3V863nm7am4dxhYDG+2t/c2d
	 ebu6aexfoDxbN8bA6pdfZMV7REwYl8spaZXrRrlu6DM6QuWN2CnSFoqeL8sjhBfvVTf0F
	 u61ywIUIjMcpD0vhvkBM1Yn6QPD2RTPw5L25GX+kphQNt8SJV2/t4446gAhLk32jiLoCo
	 7EQdWsrIulvQBRhIC61mOHsQzG6ort4wBMUbVWfhOXA/gswYvMW0/uHZYLv8v+cBW1h8X
	 Y79bH/4kme6vrXH12w60+GlaRQLQOLTVjV6nt7VW1qMpEx6f8cMromlApmCFcJqDguw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791281161;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W4HleV+vq44iQ7wp/Ip3vtkwtQdlSkRy6ae2mF5V5qY=;
	b=O1HcwOyhbiHVRjS52AKjCUX3Xiv8daSQgW6v6fQSc5JYO64w2q04VFskmHteU6dv5Oav
	 HKBGYpVxhNolv+OPDfczeJwXcYij6fjSHKyl4RlKwRZ9iF7Bsy4FZ8PG19u7asvZP1m3w
	 wmR97wK4xDqbpVhPn0OVRNbIbhxlW840dutkZHappGQUrhfUkIO/8hJYOJY8BxaAIEFt6
	 zFz5HW8qZUv9RVcXxwDOR2jqalnV180ZEIzIecCjomTxK1HiJrzZlITy5h4W6oYN6ZbLI
	 9h0JjRhyiVdROpettOAPHwrPVzAoha1REnZhiL46+OhUknPDcUvP1pWYiuySkN04BLg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791281160;
	bh=W4HleV+vq44iQ7wp/Ip3vtkwtQdlSkRy6ae2mF5V5qY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YyOi9inMyxSIwSFTQCkEn0vtTUmvQJlVu8SY+ZMyleM/koKq6lAKgQ14/W8Rj2Fuz
	 rbQimYTs15uW/tOxr2iVS+F5u8ugVUsJhiI7SbYFkzZzvW5xqNMiE9qV1uIyyO/zso
	 OyKx83LpWmuUN15yRVCkjOdCIjUXajRyCa59lKtBUaan2TGLgJeHfk+ENX14Rikesu
	 qjoJrGLu2hpmVv8MgZvQuelk5qGEjZhh1nAhBRIuoNgJI53NONm8JqJEEoINtKhdGM
	 mkfEU8GrUG7sEImpI2+JRVRNeCN6JpfIYAF2rWN+FVJuRAE2ipFPdKeSiIQl/7EUmf
	 IP1NNuFBc2RVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E43CB40596;
	Tue,  6 Oct 2026 10:06:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CB51032F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD635605D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jm5yGs9hvkBq for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 09:45:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EF468605CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791279939;
 b=NjG4z6aRxephAp6TqKblmvs4L0E2WePed3t2G1F90NfjgGUEqFxo7OAgNgl3tSPbHtAl
 aaSjmBxXTDZ23c3Op9B8pl2aUQ+z+7qezetRj/ajd8aFGNepUSQuqZmMl4i4wq5QzvVZB
 gBZ9aZ34W+FZOiwAfUgUtffi/canlFWPtTakKlEgbQEWDW/pMh4+GbNdK5qm1IjSYS+ia
 E/aZkw+2sW3pf2bqK88CNs2v5wKyVq/DcKDWkha/M8Xoc/JLvyZmVUv7BfXyEEmtHA8zH
 zd2P7uYKk/TlEDkz3OsIjqr2gfZsmnrqxIKgxSdkVlWsTtqHf7ge1p9mDtFHcEvjSbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791279939;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=W4HleV+vq44iQ7wp/Ip3vtkwtQdlSkRy6ae2mF5V5qY=;
 b=oQv1pyHMc8ftVf88RR5/sUHAMOKhhvy9K7Yput9c+vNeNkub0qy3ZvLHi0lmvUgk58tU
 1ImFSO/78KSXdmUtgAGveb18rM4Io3U6CNwMNzUZDmRhfWqKTaf5dWI6G5jpCWBZbAvGK
 qUSU0PKAbsCkPGpMoCA9GjEO1u/y5adxjZ8ow8YCES08tCddIGOHM0mCBk9P7wBr0zoG5
 Bz0BGkM8eaDIofhF2hcNVIDdBgqvR4+k4KaJ9G4adUF9opJAFIVGQU8Bi09VrG2vWyMTC
 P+TNzLFbChfTErIovmbUE/bCchdqHCBNBX2uAp91mcp2Fdoudsh8t4IdkilXG0o1OVw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JO5eVyEN; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JO5eVyEN
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF468605CB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791279939; x=1822815939;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=G0RMDVPMM2hwlFSpbrhPYNCtMgmpeYWhbTajxBtUajM=;
 b=JO5eVyENCvZ5n97s+UVXzWFgw4RLw2JbcNDq7PT/DGK0wawkKWL/2KLH
 umxRtPnYL1gx1kHjmHY4B+CZDXN1vjjFpXPJRaPox/svc6RB4VAXP1+ev
 Y8hEzRtFSqqIbY/6x5B6azI1UCo8w9O0W14aqA9Z8yqYgdPvnsbqlqbOH
 4Q7nEYJb/mP31hxyr5Pg4azOBpDBHLTwdmdIps3gY46zbtveVH6+UlNN8
 H18xfMS7nsQqVDqfNyvtUOcKJT1RoKm++8rn/GWpfQ3eL6ZV7pwRxYkak
 5yWfLRUHcok49F7lCjF58RnodsHFBOehZWDGIT0uQrrzW1Svno8irn6Xg A==;
X-CSE-ConnectionGUID: wKdIrU48R2yr4WzM6N12ew==
X-CSE-MsgGUID: zjfy6tRMQyuBt1iKFTlrMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="3211"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="3211"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:45:39 -0700
X-CSE-ConnectionGUID: IG6Cjor4QuuKNFM61Guorw==
X-CSE-MsgGUID: 29Ob4rt6SOODysHJBcAsOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280350289"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 02:45:38 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v3 4/5] ixgbe: Restore previous XDP program on
 ixgbe_setup_tc() failure
Date: Tue,  6 Oct 2026 09:45:33 +0000
Message-ID: <20261006094534.418657-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
References: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
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

When enabling or disabling an XDP program requires a queue
reconfiguration, ixgbe_xdp_setup() swaps in the new program with
xchg() before calling ixgbe_setup_tc(). If ixgbe_setup_tc() fails,
the adapter was left pointing at the new program even though the
reconfiguration did not complete, leaking the reference to the old
program and leaving inconsistent state.

ixgbe_setup_tc() may have already reconfigured the queues for the new
program before failing. The XDP ring layout then no longer matches the
previous program, for example when removing a program has removed the
XDP TX rings. Restore the previous program and rebuild the queues for
it so adapter->xdp_prog remains consistent with the ring configuration.
Otherwise, a later open could run XDP without XDP TX rings and
dereference a NULL ring. ixgbe_setup_tc() handles the device having
been left down by the failed reconfiguration.

Fixes: 3fe1d0a48d21 ("ixgbe: XDP: fix checker warning from rcu pointer")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1f23a035a90b..6ef51b822a50 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7348,6 +7348,25 @@ static void ixgbe_free_all_rx_resources(struct ixgbe_adapter *adapter)
 			ixgbe_free_rx_resources(adapter->rx_ring[i]);
 }
 
+static bool ixgbe_ring_resources_allocated(struct ixgbe_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++)
+		if (adapter->tx_ring[i] && adapter->tx_ring[i]->desc)
+			return true;
+
+	for (i = 0; i < adapter->num_xdp_queues; i++)
+		if (adapter->xdp_ring[i] && adapter->xdp_ring[i]->desc)
+			return true;
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		if (adapter->rx_ring[i] && adapter->rx_ring[i]->desc)
+			return true;
+
+	return false;
+}
+
 /**
  * ixgbe_max_xdp_frame_size - returns the maximum allowed frame size for XDP
  * @adapter: device handle, pointer to adapter
@@ -9921,6 +9940,7 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
 	struct ixgbe_hw *hw = &adapter->hw;
+	bool running;
 
 	/* Hardware supports up to 8 traffic classes */
 	if (tc > adapter->dcb_cfg.num_tcs.pg_tcs)
@@ -9933,7 +9953,17 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 	 * match packet buffer alignment. Unfortunately, the
 	 * hardware is not flexible enough to do this dynamically.
 	 */
-	if (netif_running(dev))
+	if (!netif_device_present(dev))
+		return -ENETDOWN;
+
+	running = netif_running(dev);
+
+	/* If a previous ixgbe_open() failed, the netdev can still be
+	 * administratively up after IRQs and ring resources have already been
+	 * released. Skip ixgbe_close() only in that state; ixgbe_down() leaves
+	 * resources for ixgbe_close() to release.
+	 */
+	if (running && ixgbe_ring_resources_allocated(adapter))
 		ixgbe_close(dev);
 	else
 		ixgbe_reset(adapter);
@@ -10972,8 +11002,14 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 			synchronize_rcu();
 		err = ixgbe_setup_tc(dev, adapter->hw_tcs);
 
-		if (err)
+		if (err) {
+			xchg(&adapter->xdp_prog, old_prog);
+			err = ixgbe_setup_tc(dev, adapter->hw_tcs);
+			/* An ndo_bpf error leaves old_prog attached in the core. */
+			if (err)
+				return err;
 			return -EINVAL;
+		}
 		if (!prog)
 			xdp_features_clear_redirect_target(dev);
 	} else {
-- 
2.53.0

