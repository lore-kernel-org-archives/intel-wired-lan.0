Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE24C43217
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Oct 2022 08:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A308460B03;
	Fri, 14 Oct 2022 08:45:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A308460B03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1665737144;
	bh=aZvfKiPlbE2qUZBCCg15XCh3Nrj9qYHsegrBAY7ZnSM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=5uCsMN6GJqxIR2lrJXMMmVzEyRaWZyzUpgHk9+r2miWVXcRNaEa7QJ0RVj718JwSO
	 z+r1gLYriinBl6ErnF9oxW4r5Y8Nop0VWRNM8ChZrzTBG2gXQoBjw7N87b5EI6030y
	 gpDieXYRe0DMTCsFPeyuT/NDc1NmvTK8iU79sz9SM4lV+AZCsD5y6DJQOIIJQN2jbl
	 u1FOzVqLBWN//ubAxH8aj96YvojdnW+hZWEVgfET2pLw9y8UJPcMo92BvAROOC4WMe
	 3ENV8WX/p4TmkIu1uI+6PEkl4iHkHNA7M+LMmHs2+IwRpIx/u6V82bMFKVJvqi2NiU
	 qUwploBs2qZ1Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0QEXthJ5UoD9; Fri, 14 Oct 2022 08:45:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB73F60B73;
	Fri, 14 Oct 2022 08:45:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB73F60B73
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id BC95B1BF859
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Oct 2022 08:45:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3B3E40C57
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Oct 2022 08:45:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3B3E40C57
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CL_5PS2baA12 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Oct 2022 08:45:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E005440298
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E005440298
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Oct 2022 08:45:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="288607881"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; d="scan'208";a="288607881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2022 01:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="752847637"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; d="scan'208";a="752847637"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orsmga004.jf.intel.com with ESMTP; 14 Oct 2022 01:45:39 -0700
From: Kamil Maziarz <kamil.maziarz@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 14 Oct 2022 10:45:37 +0200
Message-Id: <20221014084537.2578025-1-kamil.maziarz@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665737141; x=1697273141;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UV25x0Y03qpTxAHLaGCYv8StvdVTcdoIyzngJTeltEI=;
 b=g4EKEZmQ5PUZRNst2Oh2ePAR64K4ZlzUDyKdHGj9ITwVCTIBnVmcNGUO
 FjIfMPgsEpwLi385k7WyR9Z/NV5hZ+UeXyo0Dfl+shwiULWzs6IIU959U
 kGq8TARUp5DLclAOSsG7e2sa8T0FGCF9HUNXkndlMLhYGGAyBA6BNTARP
 gyEhQbas2p23ahQ5H2NFHJulNtYBhAMse2HUdALFDGGAFQeDTSyP7gzlr
 LN92kvRlCog6+eiUn5OuNqbKBbxiVoL0HtdDYPJxqGv1Bf0fn7xjUF+CK
 yzpFQ+GPyIqgZzC5JYuCLGpXL3NrEfPa7yTXmhdoR5ssHQcS9IzH7BJBI
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=g4EKEZmQ
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix VF driver counting VLAN
 0 filters
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
Cc: Michal Jaron <michalx.jaron@intel.com>,
 Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
 Kamil Maziarz <kamil.maziarz@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Michal Jaron <michalx.jaron@intel.com>

VF driver mistakenly counts VLAN 0 filters, when no PF driver
counts them.
Do not count VLAN 0 filters, when VLAN_V2 is engaged.
Counting those filters in, will affect filters size by -1, when
sending batched VLAN addition message.

Fixes: 968996c070ef ("iavf: Fix VLAN_V2 addition/rejection")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Michal Jaron <michalx.jaron@intel.com>
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 5a9e6563923e..24a701fd140e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2438,6 +2438,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 			if (f->is_new_vlan) {
 				f->is_new_vlan = false;
+				if (!f->vlan.vid)
+					continue;
 				if (f->vlan.tpid == ETH_P_8021Q)
 					set_bit(f->vlan.vid,
 						adapter->vsi.active_cvlans);
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
