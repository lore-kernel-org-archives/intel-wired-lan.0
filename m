Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBEAFA373D
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Oct 2022 04:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22FA281331;
	Sun, 30 Oct 2022 04:55:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22FA281331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667105757;
	bh=m38cJ4VfQWC2BhL423BZLU3wj8R+MjCp4ynD8/u/1b4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tLHkTQx20SglG0b5P4CDK60j+i2LHEpaTiby5IPjLHVaMKw/nf29EG9a0C5uBxLNu
	 B26j02y5IH088/nQlcTVixmMmjvDj/5Mc7IGmlVrVjruB4v52Rjp5DC4vU8Q06jApL
	 yAdQomgE4T9Lzic9yVvoUP7PqyPp4Qxue5pFsdDtodKMDyC2jHVLts5TpEoL9Jg0F+
	 25G1giFMRgelotgdg5cE0NCifp3RTEiTFEbzwyardapYifnCyM6aIUZ+W8EKschVJ9
	 jaXlvLoxT59WvY0/fOL+MpFFeL7Rd3/+ExXbE/ShCQrISLe9TP0HRDKjYbk9XTkiVi
	 FfCsl1xHCg8Kg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n6genFV0WwKk; Sun, 30 Oct 2022 04:55:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DD6881367;
	Sun, 30 Oct 2022 04:55:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DD6881367
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id EB2421BF36A
 for <intel-wired-lan@osuosl.org>; Sun, 30 Oct 2022 04:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DAF64046B
 for <intel-wired-lan@osuosl.org>; Sun, 30 Oct 2022 04:55:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DAF64046B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tnVxj711YkLk for <intel-wired-lan@osuosl.org>;
 Sun, 30 Oct 2022 04:55:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48EC9404DF
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48EC9404DF
 for <intel-wired-lan@osuosl.org>; Sun, 30 Oct 2022 04:55:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="335367899"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; d="scan'208";a="335367899"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2022 21:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="635707905"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; d="scan'208";a="635707905"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2022 21:55:18 -0700
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Date: Sun, 30 Oct 2022 12:53:24 +0800
Message-Id: <20221030045324.25207-6-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221030045324.25207-1-muhammad.husaini.zulkifli@intel.com>
References: <20221030045324.25207-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667105737; x=1698641737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=0FfqC7/W+AwOcM5405J9hZdI+BhYQD5j5JLUvFMFp/I=;
 b=ah2aU5rpXcL+R01R3xTfGFR1uLQhA1bVqq0cI9Ay7ZznOB62Cs7WA8HL
 eOOJhgBzvCD8POFbmUvyHCuFEg1wUK/ZVqcz5jAoodwijKlqQ/qzpzsJT
 tuXfgSyNlCgnyYXUijvgdWfgF/lqJf1mOefbGK/EYKCs1nLr5eSiiyepR
 P7d/3ZOSjLFOYc7d4puYaMjEsptX+QlxAenZ1/UrWnuE7BwaSmd1yfjBg
 AMWD+89Qo+KDuYXZqWuGzF1N01kz2OAup+mvqtkmW/aOLfSb7hQ4VloHH
 A69L+LvfSEOfN/4TWO+v+YyI8NNiiH0iUa7wxPHVZyorlDc7EhhCBrUYs
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ah2aU5rp
Subject: [Intel-wired-lan] [PATCH 5/5] igc: Set Qbv start_time and end_time
 to end_time if not being configured in GCL
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
Cc: muhammad.husaini.zulkifli@intel.com, tee.min.tan@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Tan Tee Min <tee.min.tan@linux.intel.com>

The default setting of end_time minus start_time is whole 1 second.
Thus, if it's not being configured in any GCL entry then it will be
staying at original 1 second.

This patch is changing the start_time and end_time to be end_time as
if setting zero will be having weird HW behavior where the gate will
not be fully closed.

Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 0b05d889db7d..3dfed282f726 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5928,6 +5928,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	struct igc_hw *hw = &adapter->hw;
 	u32 start_time = 0, end_time = 0;
 	size_t n;
+	int i;
 
 	adapter->qbv_enable = qopt->enable;
 
@@ -5945,7 +5946,6 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 
 	for (n = 0; n < qopt->num_entries; n++) {
 		struct tc_taprio_sched_entry *e = &qopt->entries[n];
-		int i;
 
 		end_time += e->interval;
 
@@ -5984,6 +5984,18 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 		start_time += e->interval;
 	}
 
+	/* Check whether a queue gets configured.
+	 * If not, set the start and end time to be end time.
+	 */
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		if (!queue_configured[i]) {
+			struct igc_ring *ring = adapter->tx_ring[i];
+
+			ring->start_time = end_time;
+			ring->end_time = end_time;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
