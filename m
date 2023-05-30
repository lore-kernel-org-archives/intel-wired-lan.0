Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FD8C77B73
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 May 2023 17:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87F6081FF0;
	Tue, 30 May 2023 17:46:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87F6081FF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685468804;
	bh=SL0j+fIKKxGr5jGkRyB6RX+WYUs6vwkxrklm34ph4eQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kFMY2/+ucelYXUvj+v0MVz1SUPf1yAhrMPCN4U6Akumg5vKt0wF7AyTATkgfV6pPC
	 B1XdbduXWPapKAnf8lE89+D9KYfZIXYWY7x5W0n5jscVjkf3NR4sBNV1UmKwsCHU+d
	 rTBydo5/mDD7U6rn8X9uf5LSSlyThyCv5x0nfMwrF5dmZlv65s325B78jNje0iK+7z
	 h/AtLzR9/6PPfqJU8PS/YQNJYgtOm58VQBQ3/qGehcwLSEfnyxLcEbegTXlZ9c0r/2
	 tZxMH71X9uPJR7u+O/asrmj3oZhSZUlBuvKiJMxRyhNEn0Nd+/uzMulrJT3JwytwpM
	 EtDNwQ9JE3baw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OB60fkam6fUV; Tue, 30 May 2023 17:46:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93D3681FC1;
	Tue, 30 May 2023 17:46:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93D3681FC1
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 15EB51BF966
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 May 2023 17:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EC3A81F2D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 May 2023 17:46:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EC3A81F2D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jcNZbzMy6DcW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 May 2023 17:46:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0EC181F36
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0EC181F36
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 May 2023 17:46:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="358253148"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; d="scan'208";a="358253148"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 10:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="776430986"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; d="scan'208";a="776430986"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.1])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 10:46:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 30 May 2023 10:46:02 -0700
Message-ID: <20230530174605.2772054-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.40.0.471.gbd7f14d9353b
In-Reply-To: <20230530174605.2772054-1-jacob.e.keller@intel.com>
References: <20230530174605.2772054-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685468783; x=1717004783;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+vO9sAKa9BWHWRDXCbEdl9U+f86O7UOa/Gkyy+073tI=;
 b=QSycdx+qcsSHcfGXjBs2Cxzd1YZFWl0qhEoa7KWP4eWhJ5RU04XjZXsV
 I6VE0PtJd/foNzjRZHB42YLAYwh6Kmqk54H/qlQDkDf5AWN4/Wk5DXLz0
 QZ/HKLpCZq1Jc7u/vCkM0t5LYP9VlU73/ASyxKQ6BWYA6Z7uaxWkk+Mkw
 lY52wRcodON1+5kMObJeb72Rm2RbS75UkQid7rg8QID44n2w8VQiMV9ug
 TuM+2dmo+EOw2Zqlx5EDkhgziNLnytr1zW1woYwnQ3mB1xD+JcZmt2zdg
 hedgKY546OofLPmI9s3FveWQuIaB5eCRh4WQJT8hEeYCIseCJJbeYUT8H
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QSycdx+q
Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/5] ice: always return
 IRQ_WAKE_THREAD in ice_misc_intr()
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
Cc: Karol Kolacinski <karol.kolacinski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Karol Kolacinski <karol.kolacinski@intel.com>

Refactor the ice_misc_intr() function to always return IRQ_WAKE_THREAD, and
schedule the service task during the soft IRQ thread function instead of at
the end of the hard IRQ handler.

Remove the duplicate call to ice_service_task_schedule() that happened when
we got a PCI exception.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Chances since v1:
* Rewrote commit message, no longer justifying change with reference to
  CONFIG_PREEMT_RT, as this is no longer true since v5.8. We still would
  like this change since it simplifies the ice_misc_intr() function and
  would more closely align with what we provided to our customer on an older
  stable kernel.

 drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9e4d7d884115..8b59632ec6b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3058,7 +3058,6 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 {
 	struct ice_pf *pf = (struct ice_pf *)data;
 	struct ice_hw *hw = &pf->hw;
-	irqreturn_t ret = IRQ_NONE;
 	struct device *dev;
 	u32 oicr, ena_mask;
 
@@ -3139,10 +3138,8 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 	if (oicr & PFINT_OICR_TSYN_TX_M) {
 		ena_mask &= ~PFINT_OICR_TSYN_TX_M;
-		if (!hw->reset_ongoing) {
+		if (!hw->reset_ongoing)
 			pf->oicr_misc |= PFINT_OICR_TSYN_TX_M;
-			ret = IRQ_WAKE_THREAD;
-		}
 	}
 
 	if (oicr & PFINT_OICR_TSYN_EVNT_M) {
@@ -3159,7 +3156,6 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 					       GLTSYN_STAT_EVENT2_M);
 
 			pf->oicr_misc |= PFINT_OICR_TSYN_EVNT_M;
-			ret = IRQ_WAKE_THREAD;
 		}
 	}
 
@@ -3180,16 +3176,12 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 		if (oicr & (PFINT_OICR_PCI_EXCEPTION_M |
 			    PFINT_OICR_ECC_ERR_M)) {
 			set_bit(ICE_PFR_REQ, pf->state);
-			ice_service_task_schedule(pf);
 		}
 	}
-	if (!ret)
-		ret = IRQ_HANDLED;
 
-	ice_service_task_schedule(pf);
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 
-	return ret;
+	return IRQ_WAKE_THREAD;
 }
 
 /**
@@ -3204,6 +3196,8 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 	if (ice_is_reset_in_progress(pf->state))
 		return IRQ_HANDLED;
 
+	ice_service_task_schedule(pf);
+
 	if (pf->oicr_misc & PFINT_OICR_TSYN_EVNT_M) {
 		ice_ptp_extts_event(pf);
 		pf->oicr_misc &= ~PFINT_OICR_TSYN_EVNT_M;
-- 
2.40.0.471.gbd7f14d9353b

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
