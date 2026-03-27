Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F357410BA431
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB38183C23;
	Fri, 27 Mar 2026 07:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GOu-Ui3NZEnu; Fri, 27 Mar 2026 07:23:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 054AF827A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596218;
	bh=7P8hGlecmQr20nAtPit5lbQW4/g9MdVvcqPsoku4ZYI=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=95whfT1F7pVZMHTz1gkXQdzANWa2l8rRIDJbO7wCPNq9lWoqHbmbA4Pi6M4upzRjc
	 /VuqhrJhxU8b0xi3o3ecQC2M+7O4iCV0gN8tN36u7DOXPlnjjevVOhwQ1DvZZeLbTN
	 lIH9681BQSKRI3eDuxUKEDWJjMoW97H0HOGiWAbuU2WCNjyWBxtuXLSYBxGufuxv8s
	 hGtZ+EQF1KTZJyfrHYAgvkyZHtAVP9U5E3eUu1LXBzt3ab4mgimPfhk9fsoql50Lx1
	 DQeMDf8p8g9G8w/OrxoLTROhkj7QGrmVTe3faIhs5VyIrpcHK33xaT3ppHHAY1RRzT
	 wgfVmIv27xCpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 054AF827A0;
	Fri, 27 Mar 2026 07:23:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 925EA249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 842FD415FA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yXxG757MI_CG for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:23:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E540B41574
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E540B41574
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E540B41574
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:23:35 +0000 (UTC)
X-CSE-ConnectionGUID: b9osulzsRG6od6ceqqzUjA==
X-CSE-MsgGUID: WFfKnDeqSZyhjnXGRoDTkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733963"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75733963"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:23:35 -0700
X-CSE-ConnectionGUID: XY/SgQUmTIyPDG7gpUf/Xw==
X-CSE-MsgGUID: Ll3cd2eDSzuEUk/PQinWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255739078"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:34 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri, 27 Mar 2026 08:23:24 +0100
Message-ID: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596216; x=1806132216;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=r+G9qCQlC2UPALPlilVAYlqAgt+L21Z8ORPZYuoYQ5Y=;
 b=d2HzcHjB3vw74nH48CpfsD4PVAtlY0OzC3DO86o237gdbbs/QiETsxf7
 v4bPP0Yxv15ncWI1pXIl7EGsLqzfpPDP55+kSHTEJhJQ3GmepgBebOvtE
 FA5SvHJWra+wuI6DjXwwNgOc4gJYnoP7PmlyojK1yc5iyqvPiR4GBIWoO
 NrEjNbs8QXScfMEwAttFqHK6vF4SWdj/EcoZ5QIzIexSYJjYNXDZCXKSJ
 qT0nwed8UegIWt1H9a7leF7evTc5a9w4gGjuI/3jjzjaqbWlFxu8qv+BY
 5oACE/B7D5ptSr2L1MHMpTUkHHbQsXO8ycCoYFZlcoohGhH/57GINTvrF
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=d2HzcHjB
Subject: [Intel-wired-lan] [PATCH net] ice: fix null-ptr dereference on
 false-positive tx timeout
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

From: Michal Kubiak <michal.kubiak@intel.com>

Due to some kernel bugs the Tx timeout event may be false-positive.
For example, the kernel commit 95ecba62e2fd ("net: fix races in
netdev_tx_sent_queue()/dev_watchdog()") fixes race conditions that can
also occur during the ice driver initialization.

In case of such false-positive Tx timeouts there can be no real Tx
transaction started, so the SKB pointer can be NULL. Therefore, the call
devlink_fmsg_dump_skb() can crash because of NULL-ptr dereference.

Fix that by checking the SKB pointer before dereferencing it.

Fixes: 2a82874a3b7b ("ice: add Tx hang devlink health reporter")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/devlink/health.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index 8e9a8a8..4275329 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -409,7 +409,8 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
 	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
 				     event->tx_ring->count * sizeof(struct ice_tx_desc));
-	devlink_fmsg_dump_skb(fmsg, skb);
+	if (skb)
+		devlink_fmsg_dump_skb(fmsg, skb);
 	devlink_fmsg_obj_nest_end(fmsg);
 
 	return 0;
-- 
2.52.0

