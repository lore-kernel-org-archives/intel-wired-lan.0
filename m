Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF60C10F1E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Dec 2022 21:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E51E040376;
	Thu, 15 Dec 2022 21:37:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E51E040376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671140242;
	bh=+oJyVdXtPFMu2ZKhwwmvvAN9MUV0NZLXy1tWiLHhPyQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Zg5Yr2dEd8xPbwx2vbr26SFwS0n3NxRidCejA0VATSg0lWSxRVPQyxvsjfXcdB+pp
	 sox0sKi6AnI6VLJ9rnXXh8TIrKONqLiWbfnGT0IfTp3YjmdSLGlOLd7jz3j9SYsjp6
	 nTzOAfa1C00jkV58wnwjePl781fCuoZXWk5ev9lrwxUsCyhJfInswzZnyoZFOwYHky
	 dRLNC7N3l99YfB9A9mXy5xyey4byqk5KdJg7Bq5ugnoSEhswwpcQ0osNSsJlk07fKe
	 JYOtrsjPXHbK70ymoKZV9REahRoxrtvJvgVaK7C+xPVRb88D8SXOQhX8a9HV+gK/a8
	 SjMyazg167xew==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XdniJ_KFy-t1; Thu, 15 Dec 2022 21:37:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D745040499;
	Thu, 15 Dec 2022 21:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D745040499
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 0825C1BF2C8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Dec 2022 21:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2DA741B77
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Dec 2022 21:37:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2DA741B77
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zFuiK6u_9SNX for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Dec 2022 21:37:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18CEE4015D
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18CEE4015D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Dec 2022 21:37:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="383139027"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; d="scan'208";a="383139027"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2022 13:37:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="756502427"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; d="scan'208";a="756502427"
Received: from unknown (HELO anguy11-linux.jf.intel.com) ([10.166.241.12])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2022 13:37:18 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 15 Dec 2022 13:36:25 -0800
Message-Id: <20221215213625.45008-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671140240; x=1702676240;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bWdXp+uY0e7dPM33CxlU7Is89UCY6U0otvpoH2aqP20=;
 b=Muze9lpre5DJTUKi3ZruA2AyMwZI/WndyNxrlv69r9MH7Bs8gcHCak2/
 +OIt2f4rLg1wYxjcey9OxzIBXqmnGzMcN/n2CNNCVD7NJrCcWHQ5WqdFD
 367ffDWG3uFRWujiXQmrn0p/75Ltce+NbLnaQo36jAoCt29OkpB+nMQQ1
 br7NulLWC/zqJNtslszdlycmP2jAZyFW4YGgxOys/nWquJu8hBtnFAu6y
 tcsANS2M0Ng2sy5Sg4maWG16wAeax5g1ryrU+mS4nsq7tgZPSqe0Wxm6P
 FIQWm8QXo+VYoPvgFe/99fRT2hwbhjsrpWBDGTGKmOWHo1HJ0PYPpGKHd
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Muze9lpr
Subject: [Intel-wired-lan] [PATCH net-next] ice: Explicitly return 0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Previous checks, and goto, will catch all errors meaning these returns
will only return 0; explicitly return 0 for these cases.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 3a7e629145a5..a97b137e21c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -859,7 +859,7 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 	if (err)
 		goto dcb_init_err;
 
-	return err;
+	return 0;
 
 dcb_init_err:
 	dev_err(dev, "DCB init failed\n");
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 626480677cc1..c5459d0ff4d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -664,7 +664,7 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
 	if (status)
 		goto err_start_rx_ring;
 
-	return status;
+	return 0;
 
 err_start_rx_ring:
 	ice_vsi_free_rx_rings(vsi);
-- 
2.20.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
