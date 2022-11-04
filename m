Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2D9C433FE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Nov 2022 12:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8703D82089;
	Fri,  4 Nov 2022 12:02:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8703D82089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667563358;
	bh=MKrYE65Vd5XfBc9oQ0ghbRCYG/V/lsvRp07nt2XmAc4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=UBoeYlEVnm1a1zOGn/22Cs9EVxpitPi4ilQvh30YkBHnHzQzEXJLjhhmvEMstAFUd
	 Li54tk9Sqlox5TkxrdwxGuyKxiZuALD1NEHGeaku/8ic2riSd4yiu30mfUc159dIrT
	 r1NHzXixZvBXKfFu71FwlJn0yKEIAma9joEfH13gn95QHtbzGYK7MfAnKScM+eddZG
	 iJj/4OZJB89yxA1Mr0RsBSlHkaGmkPNnL38V6SN9Qh3AfAX5ZLfem4IO6oNx7RcxDJ
	 RaEQi9asOlGF7O/uKt9iNgrSMypsWLloY8YVLfwWQ7EDz1OJXFGHZCw/ykK0HlsWsy
	 /Dj15S+LHG97g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zk7pdvQgxdLP; Fri,  4 Nov 2022 12:02:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ED948208B;
	Fri,  4 Nov 2022 12:02:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8ED948208B
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 5A1F01BF396
 for <intel-wired-lan@osuosl.org>; Fri,  4 Nov 2022 12:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33B8F4192D
 for <intel-wired-lan@osuosl.org>; Fri,  4 Nov 2022 12:02:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33B8F4192D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aa3Qh3FBdxjh for <intel-wired-lan@osuosl.org>;
 Fri,  4 Nov 2022 12:02:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0075441927
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0075441927
 for <intel-wired-lan@osuosl.org>; Fri,  4 Nov 2022 12:02:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="311689399"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; d="scan'208";a="311689399"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2022 05:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="637561976"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; d="scan'208";a="637561976"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by fmsmga007.fm.intel.com with ESMTP; 04 Nov 2022 05:02:32 -0700
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Date: Fri,  4 Nov 2022 20:00:37 +0800
Message-Id: <20221104120037.26717-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667563355; x=1699099355;
 h=from:to:cc:subject:date:message-id;
 bh=mm1XyJF+qrI2PAzfYYO3Jn4H9txIN0rBwUVgc8YR4B0=;
 b=JtRqWwC22VELQ/TZ9wZbzaPgjz34T1mRSnSiRJi8AxsoZyfnG1y4e5ES
 Oqf2aM8E1hog04gYpIoJvu1Wfo95GEJkP4EwGcsu1bWDzw3KcU2EBwQjx
 N9FIXZL6k3WpzvaO1ke4wuFGMd8SWZHvQX3FFLvBUYLeHwInlon3i/hJi
 Sy7zpTgai+HsCTOlHcSa1Moz9i/Q3an9oy1F1cnDZoX+gsF6X1ZNcNuWv
 mLXzR1e0iI5YY9DPgLG1zQNeH8cXmMxs7h6sTyAxAA9aijlnbjhCZrZkf
 DT8W6HtJmWkvwybSCTkVOkmbhBdfFq+yHycvM7DBHLE1VGArJZjeBg865
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JtRqWwC2
Subject: [Intel-wired-lan] [PATCH v1] igc: Add checking for basetime less
 than zero
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
Cc: muhammad.husaini.zulkifli@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Using the tc qdisc command, the user can set basetime to any value.
Checking should be done on the driver's side to prevent registering
basetime values that are less than zero.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4f98e0a5ccd38..6301757980903 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5928,6 +5928,9 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	if (!qopt->enable)
 		return igc_tsn_clear_schedule(adapter);
 
+	if (qopt->base_time < 0)
+		return -ERANGE;
+
 	if (adapter->base_time)
 		return -EALREADY;
 
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
