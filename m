Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE6AC19F2D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 Aug 2022 10:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC25B40585;
	Tue,  9 Aug 2022 10:51:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC25B40585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660042269;
	bh=bBn5V2jplZa6Gc7dA9U/62QXYcDf1QqQ5FrMwyUv74U=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=TAKPCZmnJq3G763V9+4U2IYFCwqvbnHqTJ+6BBp+b+UgwfBPRRN7RfME0I9itopjG
	 DhOG5/kuFci6qp2RLRhhEa8qD+H4hZRqURjMhl91XD/piIgse71Z7sVISv6p+cd37Q
	 R8x7bc+qEK1QqSlfeOs+QzuJ1nx2uWrSnU/THg8vaJbd4Y4dyLkVXJPrRHcCIKTGuO
	 j4yhTu75v5v9LaQUHlnDZ4eceJjOXYA7uVoQJodkjyn8dnntpiBd7UDkislbWPUpX2
	 C+INfRcACiUGdgQvzPZuSBmyAJcIW7ydaJmDraOm7k606+yALru5A+jC9w5jeEoRhH
	 VosKXocyqPZZA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwtyMgDy1j0I; Tue,  9 Aug 2022 10:51:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 02F23405B0;
	Tue,  9 Aug 2022 10:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02F23405B0
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id B7C5A1BF333
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 10:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9149940580
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 10:51:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9149940580
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jx23yJfSjyEC for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 Aug 2022 10:51:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D845340522
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D845340522
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 10:51:05 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="271191600"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; d="scan'208";a="271191600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2022 03:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; d="scan'208";a="580751163"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orsmga006.jf.intel.com with ESMTP; 09 Aug 2022 03:51:02 -0700
From: Kamil Maziarz <kamil.maziarz@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  9 Aug 2022 13:05:08 +0000
Message-Id: <20220809130508.281453-1-kamil.maziarz@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660042265; x=1691578265;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hF9yUngWf1ruzMIzrZ7nPIRF3nJpkTZNDfq56i+BMV8=;
 b=CUUj/NMBR5w/aBUdaBcw0dG0qEapLBk7jR5B1B4s5TraXM/Qo8rYDGDv
 +DDNDxUOirmVsjk0jbdv8VH1wW4oafu7enECrIZB6yv1bksErmmqhI+jm
 aZM+MSlneBlb2K92qeAQt4P5T+zvh5JTUZWg62Htzp3oiDmpLfTP47crr
 K/zovDzLAzu4scQ9tyZ+/lpoomBAnTRj6AiTA7tXOP3FdGY5XWfv8PPjE
 hfsk3il988W4aULwRHMywGw+81Dbgz/CxGjwmvGT0JMu4dC/QqHcAX68x
 qn1Rf9Y9RRSY5TfzRWekCI6zRb8Pqzk686psLR2nw+ecJEcWYajxbbZ3T
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CUUj/NMB
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Disallow ip4 and ip6
 l4_4_bytes
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
Cc: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
 Kamil Maziarz <kamil.maziarz@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>

Return -EOPNOTSUPP, when user requests l4_4_bytes for raw IP4 or
IP6 flow director filters. Flow director does not support filtering
on l4 bytes for PCTYPEs used by IP4 and IP6 filters.
Without this patch, user could create filters with l4_4_bytes fields,
which did not do any filtering on L4, but only on L3 fields.

Fixes: 36777d9fa24c ("i40e: check current configured input set when adding ntuple filters")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Kamil Maziarz  <kamil.maziarz@intel.com>
---
 v3: removed footer and added Fixes tag
---
 v2: changed author and tree
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 156e92c43780..6695dbe61a04 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4447,11 +4447,7 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 			return -EOPNOTSUPP;
 
 		/* First 4 bytes of L4 header */
-		if (usr_ip4_spec->l4_4_bytes == htonl(0xFFFFFFFF))
-			new_mask |= I40E_L4_SRC_MASK | I40E_L4_DST_MASK;
-		else if (!usr_ip4_spec->l4_4_bytes)
-			new_mask &= ~(I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
-		else
+		if (usr_ip4_spec->l4_4_bytes)
 			return -EOPNOTSUPP;
 
 		/* Filtering on Type of Service is not supported. */
@@ -4490,11 +4486,7 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 		else
 			return -EOPNOTSUPP;
 
-		if (usr_ip6_spec->l4_4_bytes == htonl(0xFFFFFFFF))
-			new_mask |= I40E_L4_SRC_MASK | I40E_L4_DST_MASK;
-		else if (!usr_ip6_spec->l4_4_bytes)
-			new_mask &= ~(I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
-		else
+		if (usr_ip6_spec->l4_4_bytes)
 			return -EOPNOTSUPP;
 
 		/* Filtering on Traffic class is not supported. */
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
