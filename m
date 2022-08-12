Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851B7C00140
	for <intel-wired-lan@archiver.kernel.org>; Fri, 12 Aug 2022 13:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D6E3140BEB;
	Fri, 12 Aug 2022 13:26:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D6E3140BEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660310762;
	bh=742I0ZlBAa8qYfeX311sAHbiNjz17zJFutIhKJZOB10=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fj6R9QOdxoeVZraeGL86/1aXaxsmybbT8oBQ/nYUGPH7RHi/0AMSJNHAwl6jALtwS
	 X/W4ZlznCKBflsb7UAoHFYlRap8DNA+IUxFqEfPkoZr30SbFkbYGcvsEtkSJ58gXOH
	 N90hYJIW0eMYc8Smiw8VoUFzdM1bL9drWxysm6tZbBnKrUjjUQFC5XJUO1YPKYKH8P
	 mV+FvB9PDsHprboYSQxzxyp+SIZ8z9WVnJkgkQ5LF1X9+f/zDzLbb16XXPe0g/1/Xm
	 PDx9XEnXnO9GzGhe8iLKnjHIkKkDH0kQLkKlleSHRgj1/LF1N1EkfB21Bcd2/MYzip
	 3BeRyrKgyf4PQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m7TCe_rmpKVk; Fri, 12 Aug 2022 13:26:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C30F440BF5;
	Fri, 12 Aug 2022 13:26:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C30F440BF5
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 32D821BF23C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Aug 2022 13:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E66683DEE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Aug 2022 13:25:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E66683DEE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OuK5226fBxlu for <intel-wired-lan@lists.osuosl.org>;
 Fri, 12 Aug 2022 13:25:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B9E083147
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B9E083147
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Aug 2022 13:25:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="290346955"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; d="scan'208";a="290346955"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2022 06:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; d="scan'208";a="674075750"
Received: from gsiwik.igk.intel.com ([10.102.18.50])
 by fmsmga004.fm.intel.com with ESMTP; 12 Aug 2022 06:25:57 -0700
From: Grzegorz Siwik <grzegorz.siwik@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 12 Aug 2022 15:25:47 +0200
Message-Id: <1660310750-290943-2-git-send-email-grzegorz.siwik@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1660310750-290943-1-git-send-email-grzegorz.siwik@intel.com>
References: <1660310750-290943-1-git-send-email-grzegorz.siwik@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660310758; x=1691846758;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=NYQP5Z6Zy1r5fO1OvsHj9TIMlx5EZ6n6HC1sUNDAtM0=;
 b=UndRvCyUKGigjZMM+Bq4DLrcNjGqNn5mHmm3KRIt8aMDt9jvjZQGmVjv
 LcMyYxA6Q1lAt0ajHM7AG8+/ml/COT+ue8LkQ6t/qyk52oy1o+LlPBnzG
 2PBobZfrSuyME4gMpmkocAJ3zKDiPorwKhkkBqR4CULQcjBG6stnbrw7g
 4+x1K7/Yr1VkMq/fU1cqP14BBYiqDD75vfAzFPIZNTI/BKmj/GUTI0jWn
 agABgFPlQr0m8nq9Y5qAYW9UhOITiR7hSZ11fDByhGrCscB92DEw7xiY2
 8HE6ovyfEE+2CBVW+wTfPIwNaNxuJ1XNCNDEqR4qec3P4j0KvJBsvLjRE
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UndRvCyU
Subject: [Intel-wired-lan] [PATCH net v5 1/4] ice: Fix double VLAN error
 when entering promisc mode
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

Avoid enabling or disabling vlan 0 when trying to set promiscuous
vlan mode if double vlan mode is enabled. This fix is needed
because the driver tries to add the vlan 0 filter twice (once for
inner and once for outer) when double VLAN mode is enabled. The
filter program is rejected by the firmware when double vlan is
enabled, because the promiscuous filter only needs to be set once.

This issue was missed in the initial implementation of double vlan
mode.

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
 v5: Fixed incorrect title patch issue
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 8d8f3ee..8a60052 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4414,6 +4414,13 @@ static u8 ice_determine_promisc_mask(struct ice_fltr_info *fi)
 		goto free_fltr_list;
 
 	list_for_each_entry(list_itr, &vsi_list_head, list_entry) {
+		/* Avoid enabling or disabling vlan zero twice when in double
+		 * vlan mode
+		 */
+		if (ice_is_dvm_ena(hw) &&
+		    list_itr->fltr_info.l_data.vlan.tpid == 0)
+			continue;
+
 		vlan_id = list_itr->fltr_info.l_data.vlan.vlan_id;
 		if (rm_vlan_promisc)
 			status = ice_clear_vsi_promisc(hw, vsi_handle,
-- 
1.8.3.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
