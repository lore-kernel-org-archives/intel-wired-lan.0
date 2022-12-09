Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2F8C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Dec 2022 04:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF9E24012E;
	Fri,  9 Dec 2022 04:18:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF9E24012E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670559508;
	bh=XVAYIj2B7bu5/yxQ0YluMM3TJd8JN+o47o7t0sljupw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=4vixCNmc6DPZpELIMd72pzXrUqNR27CWhZYmWm8MFyK8euoOd9wor1n0ZO3bhTR9c
	 4HJh9q7L/nob26rxEslAUDSuj5gy9Eat46OpK0nypryuCgCv0sD/Q1/uZK+1Y2NlBZ
	 6EJJ3U14yEI/HGcv+b4kISqiESfr8XPlM3ioGpb5kbraRh8TG0wLDCM1Bjon1jpIuu
	 1qT74HBTlj56XELn14klYg/obI/BKzRJMrS7O1dDXh9uSaFTRY4h06ExKN/Lj4kK8D
	 PZiJgqvz+IUplGtftsovbs7mN66zrIJhrCfDGY8VPCTxGnUGLD3hAErNmvMWglQNA0
	 Y+chDeNZFRiHw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pfxvNYXO9Q_s; Fri,  9 Dec 2022 04:18:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C98D24029F;
	Fri,  9 Dec 2022 04:18:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C98D24029F
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id CB65C1BF3A9
 for <intel-wired-lan@osuosl.org>; Fri,  9 Dec 2022 04:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2D1C81F9E
 for <intel-wired-lan@osuosl.org>; Fri,  9 Dec 2022 04:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2D1C81F9E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LUBoNN3ryFTM for <intel-wired-lan@osuosl.org>;
 Fri,  9 Dec 2022 04:18:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAE0381F38
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DAE0381F38
 for <intel-wired-lan@osuosl.org>; Fri,  9 Dec 2022 04:18:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="300796339"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="300796339"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2022 20:18:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649427543"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="649427543"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2022 20:18:10 -0800
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org,
	vinicius.gomes@intel.com
Date: Fri,  9 Dec 2022 12:15:20 +0800
Message-Id: <20221209041522.30153-5-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221209041522.30153-1-muhammad.husaini.zulkifli@intel.com>
References: <20221209041522.30153-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670559491; x=1702095491;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=x9L1nLE3oXgBhZYTY79+RupTV7aVIOwkFqPDiRhNYoI=;
 b=BowN+IPKNfJA2LwDdZdgK95/WdN8cSwN+DgjQhQ8nKQXmf3kORmZ8+/a
 AXSlB1zMI/OjLhZeVYrBJx/PM9JKuWVZUfZKkx1/Ju43ux9MIOZozOEc0
 VGMrl/BWtweex8tnKbjkS8BT2YHhhW+/89J2H/9mJhBftFC2psTcQ9fxQ
 9w751yybRug14dXlmNLEfEZkZ3MIiL58/D51rBP81ryN5UdYDFsiaJ84t
 V7hwhBjQON1Wxfb7220LC+x8hJXrZeWBoAZudxCvNBgau8Ln54aunInDl
 mVuhHqpfWhdku2RAu40swXzu/PYcafjeOqIbOfssyTf/K44zJdqOhKkIm
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BowN+IPK
Subject: [Intel-wired-lan] [PATCH net v1 4/6] igc: allow BaseTime 0
 enrollment for Qbv
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: muhammad.husaini.zulkifli@intel.com, anthony.l.nguyen@intel.com,
 tee.min.tan@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Tan Tee Min <tee.min.tan@linux.intel.com>

Introduce qbv_enable flag in igc_adapter struct to store the Qbv on/off.
So this allow the BaseTime to enroll with zero value.

Fixes: 61572d5f8f91 ("igc: Simplify TSN flags handling")
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 2 ++
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 7e90f93bdda8..5da8d162cd38 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -184,6 +184,7 @@ struct igc_adapter {
 
 	ktime_t base_time;
 	ktime_t cycle_time;
+	bool qbv_enable;
 
 	/* OS defined structs */
 	struct pci_dev *pdev;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a88840bbeeaf..6a95718bd575 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6027,6 +6027,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	u32 start_time = 0, end_time = 0;
 	size_t n;
 
+	adapter->qbv_enable = qopt->enable;
+
 	if (!qopt->enable)
 		return igc_tsn_clear_schedule(adapter);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 684aedd4d088..bb10d7b65232 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -36,7 +36,7 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 {
 	unsigned int new_flags = adapter->flags & ~IGC_FLAG_TSN_ANY_ENABLED;
 
-	if (adapter->base_time)
+	if (adapter->qbv_enable)
 		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
 
 	if (is_any_launchtime(adapter))
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
