Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A77C19F2A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 11 Aug 2022 13:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D96F402AA;
	Thu, 11 Aug 2022 13:16:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D96F402AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660223816;
	bh=lhzEU5vmcQu421COOvuK/Slv4lLtEMjTjnJDHibyMmg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nuRXgHYscT3wcjkJHMb4iBYWB60ozY6OYIRfHg+OCZy3pDYcrw3d/5Q5mN6TdrQh6
	 Lis4Q0N/Y/Y5rUUxl0qJS9/Wi669p0Qoi3x80KH10zD0DEbJ6O0aJyZZem4OxOgXpJ
	 rKj13/MMCemXAlamSzW5vw5k92HuNtxcyr6mkUxS5vvZIxKHwUdfxwFU0MIzn5jlYx
	 Fq8KQg9UdEDjJTgFYULOqBQlK07HpHmGlf5FyzHC7t4eVBLWIEx04kJKQdTMgRD/3u
	 Hm4KaVCW3iH38ThMHnCYR1SII00Y5K0nUmu0n0VBDI75opTNQ2icoutCZfdOQaP2tO
	 z0RvcaMZJlxFg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w91fWozudog7; Thu, 11 Aug 2022 13:16:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C5EC41591;
	Thu, 11 Aug 2022 13:16:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C5EC41591
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 549E31BF2F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Aug 2022 13:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E21441591
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Aug 2022 13:16:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E21441591
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vMAy2R2YGeUp for <intel-wired-lan@lists.osuosl.org>;
 Thu, 11 Aug 2022 13:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1584D402AA
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1584D402AA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Aug 2022 13:16:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="274397611"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; d="scan'208";a="274397611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2022 06:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; d="scan'208";a="634219892"
Received: from gsiwik.igk.intel.com ([10.102.18.50])
 by orsmga008.jf.intel.com with ESMTP; 11 Aug 2022 06:16:46 -0700
From: Grzegorz Siwik <grzegorz.siwik@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 11 Aug 2022 15:16:39 +0200
Message-Id: <1660223801-254272-3-git-send-email-grzegorz.siwik@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1660223801-254272-1-git-send-email-grzegorz.siwik@intel.com>
References: <1660223801-254272-1-git-send-email-grzegorz.siwik@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660223807; x=1691759807;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=2X9TBOo1Y7/WixLlyH/IlPJPWQlsBfGyjPuytLrWBJY=;
 b=civVRlmqj1QJDieW0tgfjKyHKHUkl5+j+DhVmm8jOiASdQgFZdJey0YF
 fd9VG2dnWIkPGGkfJNIqQAddb0aZnLnZk2FLSPkefGsMUU7UYwEkgfpWt
 C7xGtRMamJ+Stg1OEwnWAhR28yaHqusuaAFUoZP7IUyre9hbIAOtLQCVT
 jgPOdkSiNQhMNwOWBQlL9MEU1cKRWpoGhYpKhNf/hud/ytRGc91MgJQd6
 82lWyzWb3sj+MZ8agNHMkc3G1RQKoUP5DeQBqsB7vyoQtoPQYtDNwvTDo
 gFA9lg2yOt3tExbcrYJv7AyXfKeHyL4M7HzPoTNNcEVDEpUgRQkQVCG6B
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=civVRlmq
Subject: [Intel-wired-lan] [PATCH net v4 2/4] ice: Ignore ERR_ALREADY_EXISTS
 when setting promisc mode
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
Cc: Grzegorz Siwik <grzegorz.siwik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Ignore EEXIST error when setting promiscuous mode.
This fix is needed because the driver could set promiscuous mode
when it still has not cleared properly.
Promiscuous mode could be set only once, so setting it second
time will be rejected.

Fixes: 5eda8afd6bcc ("ice: Add support for PF/VF promiscuous mode")
Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
Link: https://lore.kernel.org/all/CAK8fFZ7m-KR57M_rYX6xZN39K89O=LGooYkKsu6HKt0Bs+x6xQ@mail.gmail.com/
---
 v2: Fixed error message when setting same promiscuous mode
---
 v3: Fixed style issues, changed to return directly.
---
 v4: Fixed problem with patch applying
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 8a60052..0aa4871 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4428,7 +4428,7 @@ static u8 ice_determine_promisc_mask(struct ice_fltr_info *fi)
 		else
 			status = ice_set_vsi_promisc(hw, vsi_handle,
 						     promisc_mask, vlan_id);
-		if (status)
+		if (status && status != -EEXIST)
 			break;
 	}
 
-- 
1.8.3.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
