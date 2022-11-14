Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92A8C43217
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Nov 2022 13:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A824415C7;
	Mon, 14 Nov 2022 13:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A824415C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668431556;
	bh=ypR3RkunOmlQrQb4xaMqRRxvFKN1+pTQHcFCrP3Ei5E=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=2mthQD8HiH/RBSA7wLAiKNJDzlPk5EVqti6WWXyfrj2hCL2mfysgX4s13ZWf2lkgJ
	 k8/2I6SGDfSCzcPMR8VyO/xWQHmjokNqAK1nlReQeAs5f+exB12ACkDM1aaj6ZhTsg
	 JqcGfQCvqii0L3JTqU7MxYIFhYzFqtGhUpFcrT/8wGX/lmmtAFvynqaj+ObBAcPQCT
	 hsCPXcQLJkpLj3HoVIs8c0FTkBs2QiaRFjTb/i56Hnc98zixBOJH4zwegLJm5y7/bJ
	 fQtf/+7+Yb8w4UoLBuYpF2ZZ3U7Hm3fA1tChYV/UB5v5sEAfir/Nr/eBJKZFcbitsE
	 Pyz2wk5sCAstQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4GtVqO_PVyWo; Mon, 14 Nov 2022 13:12:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 370A6415D7;
	Mon, 14 Nov 2022 13:12:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 370A6415D7
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 89B171BF379
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 13:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6463E81826
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 13:12:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6463E81826
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3KNVPgZEKdO4 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Nov 2022 13:12:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B4AB817D3
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B4AB817D3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 13:12:27 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313766728"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; d="scan'208";a="313766728"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2022 05:12:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="616306013"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; d="scan'208";a="616306013"
Received: from wasp.igk.intel.com ([10.102.20.192])
 by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 05:12:22 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Date: Mon, 14 Nov 2022 13:57:49 +0100
Message-Id: <20221114125755.13659-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221114125755.13659-1-michal.swiatkowski@linux.intel.com>
References: <20221114125755.13659-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668431547; x=1699967547;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=unS16nVWy3isgLs85nEntpNArvPSZg+8ZBDHAbDTZtc=;
 b=NkCU/8CdQD/DFnNQCnf4mLUMz11a4P5b5Sb8cwnkbiW1wYCva+aPexYC
 NzFJXvcF8UreOmN9vnIOrAKrPgpu5osOAeYXITFUmtnPwpKTDBd4zGQOx
 UMUASHnD3C233uXiu86u0FsGf2cM50JsiJFfC+Kb4+AyIkYDw+DKefi8e
 f5xNWN07cDSnchOETMp9zjfRuwIvY4eBq2QGwUtd7uWPqREu4TnGs7+YT
 ePFVNOGN5jiSQfZxwxifjgqgCcExO+jLrwfWwv4XoYm55vqOK2wxEojXt
 8BPMW3kumB/wmsGE54lR4YryBuWcfcYHdkmOtkYReqRGfqfuui9GcsYTI
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NkCU/8Cd
Subject: [Intel-wired-lan] [PATCH net-next 07/13] ice: sync netdev filters
 after clearing VSI
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
Cc: mustafa.ismail@intel.com, leszek.kaliszczuk@intel.com, jiri@nvidia.com,
 intel-wired-lan@lists.osuosl.org, shiraz.saleem@intel.com,
 przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

In driver reload path the netdev isn't removed, but VSI is. Remove
filters on netdev right after removing them on VSI.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fltr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.c b/drivers/net/ethernet/intel/ice/ice_fltr.c
index 40e678cfb507..aff7a141c30d 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.c
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.c
@@ -208,6 +208,11 @@ static int ice_fltr_remove_eth_list(struct ice_vsi *vsi, struct list_head *list)
 void ice_fltr_remove_all(struct ice_vsi *vsi)
 {
 	ice_remove_vsi_fltr(&vsi->back->hw, vsi->idx);
+	/* sync netdev filters if exist */
+	if (vsi->netdev) {
+		__dev_uc_unsync(vsi->netdev, NULL);
+		__dev_mc_unsync(vsi->netdev, NULL);
+	}
 }
 
 /**
-- 
2.36.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
