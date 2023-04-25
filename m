Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F4EC77B61
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Apr 2023 15:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 813FE40901;
	Tue, 25 Apr 2023 15:45:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 813FE40901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682437559;
	bh=gKO7TQO3IPtNxBYOMnkCn5S+VsFh14mbQ5vElK3I4Qo=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=3+iMGcPsSMdDocu33nGOKg6HZg8Y6pi+3cg1/YDMrI3Li3b06llBkLdJ436GpGVFT
	 /nFKMc9ykMoyLTKvrR4E9ZPPJiZpQXyAJOa8qAYusIKVm2l6R2TD0BUWl0efWNgtII
	 ws70jD7e/0mhC+5nxOeBr2A/WMPDifO+wdaegE+gDp2cj4uDHHDzAverNp4FHzzNy8
	 joym/xydwkb45uvbd7moq5VKVPepCV1vHUviMkP6ekW7G03ipYmlf/AgtxGemW/bhJ
	 ue9aDjG9heEqVFJv3yTJ+a3yxMz8HMUwBnK8XQTlAp+Bfj9cW4ShQKbmWo3BDCjbbm
	 gxlszhSGbJ2Dg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ge51swSzLOQz; Tue, 25 Apr 2023 15:45:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A58B409BD;
	Tue, 25 Apr 2023 15:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A58B409BD
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 9D95C1BF834
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Apr 2023 15:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 723B3410B7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Apr 2023 15:45:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 723B3410B7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lCuXAxDBPIgy for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Apr 2023 15:45:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8129640983
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8129640983
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Apr 2023 15:45:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="345561619"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; d="scan'208";a="345561619"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2023 08:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="693550474"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; d="scan'208";a="693550474"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orsmga002.jf.intel.com with ESMTP; 25 Apr 2023 08:45:54 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com
Date: Tue, 25 Apr 2023 17:45:54 +0200
Message-Id: <20230425154554.154424-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1682437556; x=1713973556;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=G0zLbL2ASNsHq7yK9FJ2GU/BllM5vl9ZTIe+J7+imi0=;
 b=i4HCEnh5tuRlflTyMMVvKfy6ez7MGMkyCVPkmmHwyqokR45urC2WfUcc
 1CUhKEBCzhsifuYFhcy66w6mBYrQx8EReJ1lzMzA+oET0riSG6J0m5KQe
 CeT1VUXH63eHylbLMuysRjcXdeUxyalHkzBjVf60vG485HmkOjDqV8TjV
 qHKwiqjdWbjE3EofcbqrL3cwVSDpO4yJKtoVnGQC22VzXeFLLhpt1kxv+
 w9nyyAM6z9baKtM0so446w0z+xfjfFZGaMnPKPOVbGNfpQ6iurwYmIRMU
 k7d2gQxg7sySpdH/EiUSuuYFq55xcXwfCtoGIJe/aHo8ZnPuHBvXeub6E
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=i4HCEnh5
Subject: [Intel-wired-lan] [PATCH net v1] igb: fix bit_shift to be in [1..8]
 range
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

In igb_hash_mc_addr() the expression:
        "mc_addr[4] >> 8 - bit_shift", right shifting "mc_addr[4]"
shift by more than 7 bits always yields zero, so hash becomes not so different.
Add initialization with bit_shift = 1 and add a loop condition to ensure
bit_shift will be always in [1..8] range.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index 205d577..caf91c6 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -426,7 +426,7 @@ void igb_mta_set(struct e1000_hw *hw, u32 hash_value)
 static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
 {
 	u32 hash_value, hash_mask;
-	u8 bit_shift = 0;
+	u8 bit_shift = 1;
 
 	/* Register count multiplied by bits per register */
 	hash_mask = (hw->mac.mta_reg_count * 32) - 1;
@@ -434,7 +434,7 @@ static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
 	/* For a mc_filter_type of 0, bit_shift is the number of left-shifts
 	 * where 0xFF would still fall within the hash mask.
 	 */
-	while (hash_mask >> bit_shift != 0xFF)
+	while (hash_mask >> bit_shift != 0xFF && bit_shift < 4)
 		bit_shift++;
 
 	/* The portion of the address that is used for the hash table
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
