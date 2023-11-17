Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B32EC072A2
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Nov 2023 16:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9A1541F57;
	Fri, 17 Nov 2023 16:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9A1541F57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700239477;
	bh=9qzsbWlTUkoVq5XE09MgvmCrx0zccU8bPyvhz4HdGjc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=8Sn7b3RsZv7xYnuE7vaJpxpatVbPFEtalFm6szej8p4KXY35fZRMRPiatFar6OdU1
	 XTitX+za1i7mE3DGt+3VHBiOe+mRUo6B7hkRIaObMxqxac5YirU6h2mRxEU9CsOkGo
	 OReq2H5+seShLggCh4CevhhuiepjN22oZN6DPZXof//q0PcyCVTJnHkESw+d//PnwN
	 hquMhI1OkI9c3hMBUdlUtmI+uAXOTx15nYfBJtFv9pgIW2gxzuYUGenWJ6M5XW2RcZ
	 2HM74i0aWoXpYUPFKCl85lG3us6UVJZcG3pmql2T6lUxd0W4vZp7VaNr6/b6qadhJV
	 fZlHG3hZeMJ6Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJtyUT2c652j; Fri, 17 Nov 2023 16:44:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id F254841F58;
	Fri, 17 Nov 2023 16:44:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F254841F58
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id CB7171BF31D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Nov 2023 16:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F53C612B7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Nov 2023 16:44:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F53C612B7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zvryzAmV4Pc4 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Nov 2023 16:44:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9632860AA4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Nov 2023 16:44:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9632860AA4
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="395255359"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="395255359"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 08:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="759222042"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="759222042"
Received: from sbahadur1-bxdsw.sj.intel.com ([10.232.237.139])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 08:44:31 -0800
From: Sachin Bahadur <sachin.bahadur@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 17 Nov 2023 08:44:27 -0800
Message-Id: <20231117164427.912563-1-sachin.bahadur@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700239473; x=1731775473;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eIGdtsz/mNJhff6NvN0ClvX0hucp+LPmBNcUNRv5aF4=;
 b=W+/cSjxv9/8lfhzKOUcbcL9nHEKOnawIkuUB30ZVQanMPRtTYaDUWEFF
 190o3BuMbiiTeKnF88kG0TgVgdi/UC7BPf1W/X3x91ob/ytipHV9WFUtc
 q6NI0Y6hhpEUl/ydYqL3DRMB8KAWIMNQtlqIgsa5yU9IDHipsKMKNd8LG
 g0J5CdaLPkvCT2plRPyqNmz00cmLUUtDvvlAahlPltx4YlO9LaWUUMhRl
 JIEbXXSB+rzpR82kG7I8gvxzfXw1QHNbhwIGbVVZlF1/0lXSBtaURf9F/
 kpZJCgHDgL1+dq2vU+Z3efW1cnLCXCe0SZcVF1TAXWbUSCWGr5EXsWUkg
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=W+/cSjxv
Subject: [Intel-wired-lan] [PATCH iwl-net v3] ice: Block PF reinit if
 attached to bond
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

PF interface part of LAG should not allow driver reinit via devlink. The
Bond config will be lost due to driver reinit. ice_devlink_reload_down is
called before PF driver reinit. If PF is attached to bond,
ice_devlink_reload_down returns error.

Fixes: trailer
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index f4e24d11ebd0..5fe88e949b09 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -457,6 +457,10 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
 					   "Remove all VFs before doing reinit\n");
 			return -EOPNOTSUPP;
 		}
+		if (pf->lag && pf->lag->bonded) {
+			NL_SET_ERR_MSG_MOD(extack, "Remove all associated Bonds before doing reinit");
+			return -EBUSY;
+		}
 		ice_unload(pf);
 		return 0;
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
