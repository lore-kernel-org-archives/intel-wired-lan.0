Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EFD10BA435
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E28A061283;
	Fri, 27 Mar 2026 07:23:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w0a88lXcZ-aG; Fri, 27 Mar 2026 07:23:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE8CE6127C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596224;
	bh=nCSYgWIB15/P3SeLWfLqOrRUFazcrXBtYBUsYjcfe5U=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D2OB+p8vVhTmWyOqzpdmRa77RuFkb4l9kI2J0N8XzWaZQ7VZgw5fTioe4RASD01Db
	 t+jkXlk6U38naU056m8XLkv+AI0JEtpv98RDOd4QyNe66kHYocV8nUGv3jc8vNKtbY
	 LeMZQyky89lPCQd/BPMft6mPoJJW1G4FqmWVDsN+14sqvLGGbpUkU7DP/blJGxgXMq
	 tBgqibzEGqwjJTl4c9kurPqhj3poB5rJNCD/7Skwjm595L4Yl31JVsPpZKi9vd/2It
	 PcNXVuM601PG1sQXEjSF1pVSxtFlp6S2I9eBImJZZSKra/RDSB/F14gqx8goF0R0WU
	 9WHUl7Wokk8Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE8CE6127C;
	Fri, 27 Mar 2026 07:23:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E8B4B249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9F23415FA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fKa8ZgA3EMGM for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:23:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D7BBD41574
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7BBD41574
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7BBD41574
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:23:41 +0000 (UTC)
X-CSE-ConnectionGUID: HffCr0g3RJCWa3JqxuqDGg==
X-CSE-MsgGUID: OSgc3wbFRX2IzMloPRzLcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733974"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75733974"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:23:41 -0700
X-CSE-ConnectionGUID: oW78nACyQZCHMhKDGVyJxQ==
X-CSE-MsgGUID: MuZ9vhdqSlaFa4OmXDk+sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255739100"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>
Date: Fri, 27 Mar 2026 08:23:28 +0100
Message-ID: <20260327072332.130320-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596222; x=1806132222;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ingbZmd2Pb3SYiTnzq1cCDdJm7Fy7ywH4K9TDIc577s=;
 b=SSx4Qi6WdwlRau3K1erec1ZB/z8NgT3vCveWVZweNJBAh9aZyyrK//Ev
 4fLb/ULUe91gxyDg/Ws1pYHqcDlQOcu8+PoJKH8DFP1sh81OHilQidEbM
 oo/e8nX5yRvju8sKECyd/hgdk5AO12TB5WtuTWPaM9Rc8nDP17NadmdBZ
 YLtTilXZI9MWJ1DKrWdNMtLtpew4MSLQihjO0CfzwjENvJerWh6RTxVbH
 kMMx9kxbiqCXDSiGzN3MnRtXmyhUPQ/EnkfJrlNm9HqJ5jNkPTw5BYYWS
 a0r1sBywhuT1hLultz8aa8JhhhhZ2MzyCtVay3lFFWszBjwiqEPDEZwS4
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SSx4Qi6W
Subject: [Intel-wired-lan] [PATCH net] ice: fix setting promisc mode while
 adding VID filter
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

From: Marcin Szycik <marcin.szycik@intel.com>

There are at least two paths through which VSI promiscuous mode can be
independently configured via ice_fltr_set_vsi_promisc():
- ice_vlan_rx_add_vid() (netdev op)
- ice_service_task() -> ... -> ice_set_promisc()

Both paths may try to program promiscuous mode concurrently. One such
scenario is:

1. Add ice netdev to bond
2. Add the bond netdev to bridge
3. ice netdev enters allmulticast mode (IFF_ALLMULTI)
4. Service task programs promisc mode filter
5. Bridge -> bond calls ice_vlan_rx_add_vid()

Crucially, ice_vlan_rx_add_vid() fails if ice_fltr_set_vsi_promisc()
returns any error, including -EEXIST. This causes VLAN filtering setup
to fail on the bond interface. ice_set_promisc() already handles -EEXIST
correctly.

Fix by adding the same -EEXIST check to ice_vlan_rx_add_vid(): if the
promisc filter is already programmed, continue without returning error.

Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
Cc: stable@vger.kernel.org
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8896805..cf116bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3755,7 +3755,7 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 		ret = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
 					       ICE_MCAST_VLAN_PROMISC_BITS,
 					       vid);
-		if (ret)
+		if (ret && ret != -EEXIST)
 			goto finish;
 	}
 
-- 
2.52.0

