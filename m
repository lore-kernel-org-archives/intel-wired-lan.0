Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B264C4167B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Nov 2023 10:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0763B4354D;
	Wed, 29 Nov 2023 10:30:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0763B4354D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701253826;
	bh=qu6+JVfjhHISVIg1wbdeJ3zVO7tSlyM7CgrL26GCcE0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=C067xHdA8LlBFGJdu3BNTapSn0T0oUU0ogCRbov8el8Y5ooY995yWty5K3ThQoaHB
	 lkoJsv2NHkajkkViCU2OmGWFlsE8P/duMZKwSHDMB3DzzrbalGYzbCaEjRxlypKiv8
	 Hrz2r5j7bfv6kCJXsBZRdjmjEP6HzCVAYq2uXyR5+0PnSHwXaoKddHfbJMfuji9Og0
	 uSKSgC6HJlm4Omgyup6zT3ufFo7NaA+kcoO9sH7At8ZAxQ0AKiKw7r/buBcnzdU1wj
	 8m6vq7A8OLeFarPAJ8ctw135Cgd8F8SR04PzGmIUgm875hLHzLSYOlzC2y+W4H99cO
	 Lbc76sXh5qwlw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZgIra2fH1gj; Wed, 29 Nov 2023 10:30:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4641405D9;
	Wed, 29 Nov 2023 10:30:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4641405D9
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id EBC8B1BF2B5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Nov 2023 10:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEE3741835
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Nov 2023 10:30:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEE3741835
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yb5glVRTB5Qf for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Nov 2023 10:30:22 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 29 Nov 2023 10:30:21 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8B5F41827
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8B5F41827
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Nov 2023 10:30:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="121481"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="121481"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 02:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="718712474"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; d="scan'208";a="718712474"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
 by orsmga003.jf.intel.com with ESMTP; 29 Nov 2023 02:23:12 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Date: Wed, 29 Nov 2023 11:23:11 +0100
Message-Id: <20231129102311.2780151-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701253821; x=1732789821;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=v1nCldua3WBiSnVPuy5LnS6E/cq1uTZoCreErVFP1p4=;
 b=CPJqc+Rrw2CUggG4XwK6+p95jbPfuzVYBz/1A+jrg3EK4HqfUco4FSUS
 yjKUJtvpT+mgWT4DLb9zErsq0hV/0rOgU6eyYi+NRaWAxnftIEzjjZcYs
 0TChPfqnUwOBkcH+WDqL8v+DN1NWBPkGDOCfVX3ceVWkqkytdN8uHl1Xf
 t0dbm4MRu3bqK778q8MPdSeA0Rr2/wlgYzg1UOH89123Y+G1rdDmmhuzx
 kwZLkNxj74mjfqaEpyL39C4eK93WMKgN5Y0lJMTVI0zVnVUYdYmrNCz0y
 Nibblky0AJ0kAB+9r6WziZKmiakyRkwD/u2NvpdE0b4odPe3iczI4LuvR
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CPJqc+Rr
Subject: [Intel-wired-lan] [PATCH iwl-net v2] i40e:Fix filter input checks
 to prevent config with invalid values
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
Cc: netdev@vger.kernel.org, Andrii Staikov <andrii.staikov@intel.com>,
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

Prevent VF from configuring filters with unsupported actions or use
REDIRECT action with invalid tc number. Current checks could cause
out of bounds access on PF side.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1->v2 add 'Fixes:' tag into commit message
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3f99eb1..031b15c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3521,16 +3521,16 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 	bool found = false;
 	int bkt;
 
-	if (!tc_filter->action) {
+	if (tc_filter->action != VIRTCHNL_ACTION_TC_REDIRECT) {
 		dev_info(&pf->pdev->dev,
-			 "VF %d: Currently ADq doesn't support Drop Action\n",
-			 vf->vf_id);
+			 "VF %d: ADQ doesn't support this action (%d)\n",
+			 vf->vf_id, tc_filter->action);
 		goto err;
 	}
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > I40E_MAX_VF_VSI) {
+	    tc_filter->action_meta > vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
