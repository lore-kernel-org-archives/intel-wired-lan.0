Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FC4D730A4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 05:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A60140ED9;
	Fri,  3 Apr 2026 05:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HcLZ6kBN11ho; Fri,  3 Apr 2026 05:40:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B5EC40EB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775194838;
	bh=3HP65Wbp6c7caA8mKhI4gnrR4+sZckpn+mAFFtFGwec=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2dCzVVvWFJqK63lfu7afBCugAI1fec2kwVyGtB40qqXXybfFvLtN//vfN10eOcuCV
	 crToFGkjMwCzqxfQgeGPYtn8PTKJ9MqscJlo9BNGjYGmglJAfMzMtb08W2ia/YVzPF
	 O16/MfH4c3gMuK1tdXgQwwFvFkKD8nQGwVFbRnS5Dtv8+qIj3SItvfRXU5FaXiRQhH
	 vQFMCpagvE/f4BDTkWn1d+1aO+G4HZDh8ljBmvmxDCgtWAZJEE20ftDz/MI7Djb5om
	 dT+LSqhMcptC7JfbVymA0AfA3hq8KlL2KM3Y88BPTUZHuYiwEny3koHjPXMNXhzZF0
	 seguHsbwY98fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B5EC40EB7;
	Fri,  3 Apr 2026 05:40:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CCC722CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAACE4008E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqmINMo6gRzc for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 05:40:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D790740071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D790740071
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D790740071
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:35 +0000 (UTC)
X-CSE-ConnectionGUID: LJsTkArBRiC61K3bUfIahw==
X-CSE-MsgGUID: 2HaZ2y7XREK0dVJsAf8kQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981743"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="75981743"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 22:40:36 -0700
X-CSE-ConnectionGUID: XGEOCKz+TqCNZh4w12tywg==
X-CSE-MsgGUID: bxWItmfeRa+BDBmhC4o+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223904920"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:34 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>
Date: Fri,  3 Apr 2026 07:40:21 +0200
Message-ID: <20260403054029.3789616-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775194836; x=1806730836;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5i52DSlag8ooB9dvEM2JShL1gCTUtifV13OheZYkeQY=;
 b=NaWOLbYw1KFWAgXi68e3zSQnxIuaaIEH0h4KTzHZ6n7UWuHvHCfCKZg9
 1dgEVVYmmZvXFigqUsm3igVlBFN2hrWp8Bz7RjE9SOrqGvDKJEZZv07yl
 Svf8MihR+MYkNf0SuMw/DP6lqVkcBJMIFps82beTj3hxcGgA0bZqJY4GV
 olusQzAMoLSktcXAz3ouaZU2eziQbgX/9E56HUFOwEIeKgNGvq9Bncko9
 enmJVcpHIEXxI7OBMm2I7UHV5AuCK3FJo8GAzN4VUZ6Qg0EjxCU8+nFWz
 8Skv3WrVHO3F7UF0jdcmq8wFblDl6MyXUx/w+/pu56xBlUr20vkjzl2Dv
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NaWOLbYw
Subject: [Intel-wired-lan] [PATCH iwl-net 3/10] ice: disallow service task
 to run while driver is unloading
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

From: Dave Ertman <david.m.ertman@intel.com>

When the driver has entered the unload path (specifically ice_remove())
the service task should not be running. If a tick of the service task
has already been scheduled, it needs to be intercepted.

Add a check in the service task for the ICE_SHUTTING_DOWN bit.

Fixes: 9162a897d234 ("ice: stop DCBNL requests during driver unload")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b5adb13..60b2558 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3056,6 +3056,7 @@ static void ice_service_task(struct work_struct *work)
 	/* bail if a reset/recovery cycle is pending or rebuild failed */
 	if (ice_is_reset_in_progress(pf->state) ||
 	    test_bit(ICE_SUSPENDED, pf->state) ||
+	    test_bit(ICE_SHUTTING_DOWN, pf->state) ||
 	    test_bit(ICE_NEEDS_RESTART, pf->state)) {
 		ice_service_task_complete(pf);
 		return;
-- 
2.52.0
