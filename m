Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35473C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Dec 2022 04:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B069041601;
	Fri,  9 Dec 2022 04:18:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B069041601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670559498;
	bh=YSqkXEWoWCjz0scNhrwAjjgaygITTQSRH6F+DtUlrZE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=r8rcY+8j9Y3Ap12tYzwfrMujdmAdGjx0q31sEJVxXbep4SfpYlnNyKgWJ9ylBrPIv
	 N+P+TIj12Gak3LepqGKFddzm4OJ1hvJLy7CT9NSG/lEEAL1LEA7pYUtJ3Kcx6LITMM
	 HnVlx6rf7vx/e/s5yCpbDtBGMM7REzu0vrKEJEMXbpk7gA9Na16rwVoNJRiQtD7SG+
	 S6DBa450y+EZxMCLmDlWYZOo0ICOn3MA5pOubsD4yGJ8u2re5X5laHVKN1jtKKMwHU
	 E1S4ykFWfLwRkRW+tYH79rtGsOpg6c6VwSE6ngWHUHK0eMF1wjxg23K4p0Sx5TV1EK
	 RIdo8iTZN1+VA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id drZip7WjVlLg; Fri,  9 Dec 2022 04:18:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 829984182B;
	Fri,  9 Dec 2022 04:18:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 829984182B
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 4E4681BF3A9
 for <intel-wired-lan@osuosl.org>; Fri,  9 Dec 2022 04:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 098CD81F9E
 for <intel-wired-lan@osuosl.org>; Fri,  9 Dec 2022 04:18:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 098CD81F9E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JVZ_I3qJZhCs for <intel-wired-lan@osuosl.org>;
 Fri,  9 Dec 2022 04:18:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6680781F9C
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6680781F9C
 for <intel-wired-lan@osuosl.org>; Fri,  9 Dec 2022 04:18:08 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="300796324"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="300796324"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2022 20:18:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649427532"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="649427532"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2022 20:18:06 -0800
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org,
	vinicius.gomes@intel.com
Date: Fri,  9 Dec 2022 12:15:18 +0800
Message-Id: <20221209041522.30153-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221209041522.30153-1-muhammad.husaini.zulkifli@intel.com>
References: <20221209041522.30153-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670559488; x=1702095488;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=4rIjhoR7GXOi9x4Ljx3ok2ujD9Y5sUM8ovmGWyeMV64=;
 b=mdYzLEwtqg7eq2nHtojSg6XFwxp28n96KK0Iz6wa3AHXH88RIAr0PQZ/
 XYDCqiGZxU5fSRweBuXnEvKvtKuQ6grFp21RFUISZpQeTO35ul4QXXEDH
 ke1O4g1pduMgds1kjU/3Pa4lhZYM0ejxjN8Em903qFzUt96aWHeba06U1
 vcUBU7QXLX4oIJN8ajk0S8buP2JzWdxxoB+8GC7g79J/kPiyupF+bdDTC
 xwfFEh0qsov1BxajZnn/xEGw3UPhEvRyJvjHNOL2ixMdzd5mCLadN9evs
 rOnn/X0rI7+EE07tR85PDwnhgmHW6i667J6s+Qmn+okID94XDigOpSs9p
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mdYzLEwt
Subject: [Intel-wired-lan] [PATCH net v1 2/6] igc: Use strict cycles for Qbv
 scheduling
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

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Configuring strict cycle mode in the controller forces more well
behaved transmissions when taprio is offloaded.

When set this strict_cycle and strict_end, transmission is not
enabled if the whole packet cannot be completed before end of
the Qbv cycle.

Fixes: 82faa9b79950 ("igc: Add support for ETF offloading")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index f975ed807da1..684aedd4d088 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -140,15 +140,8 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		wr32(IGC_STQT(i), ring->start_time);
 		wr32(IGC_ENDQT(i), ring->end_time);
 
-		if (adapter->base_time) {
-			/* If we have a base_time we are in "taprio"
-			 * mode and we need to be strict about the
-			 * cycles: only transmit a packet if it can be
-			 * completed during that cycle.
-			 */
-			txqctl |= IGC_TXQCTL_STRICT_CYCLE |
-				IGC_TXQCTL_STRICT_END;
-		}
+		txqctl |= IGC_TXQCTL_STRICT_CYCLE |
+			IGC_TXQCTL_STRICT_END;
 
 		if (ring->launchtime_enable)
 			txqctl |= IGC_TXQCTL_QUEUE_MODE_LAUNCHT;
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
