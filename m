Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3533CC6FD1F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Mar 2023 12:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA416418B0;
	Wed, 22 Mar 2023 12:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA416418B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1679489351;
	bh=VOy3RbV317UUTVXQ+g8QhD2xbD5BXmymibik2DMfmAk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=k6TTWp6kkCWJf1g22iihS/+XK5XZtyhQMH1zzqyON5PW/Hb9ppNtkA+IuFOG2zBFb
	 DHtzH9bp5587lB4s7WCbCBdYTASUgpYSIlqVils5smg8/08/vrZkuzvN5H6ZmHaumu
	 R4akrAAis/92pWP7HKaQ8NJ8CxFt+gLxs/68rmle6GYQ2PJ0BPmY3qujgKvvDdJLUT
	 04e8syaXT5XOPBMAWyJxzioAhDGDZ28DIbJ0BvYJ1yGWiOF7CXpyuTA+elIvqC1axk
	 ym7W+ZPy2YoAkX2PkmPcLi4N6BFcqgrnfhubsHaeqS1wy/AQcKhZOAhOIvqRFBksHF
	 zQ2/7twJeVlpQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XiOs5uN_g28V; Wed, 22 Mar 2023 12:49:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C003418A0;
	Wed, 22 Mar 2023 12:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C003418A0
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DF07C1BF82D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 12:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6AD5613B3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 12:49:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6AD5613B3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zMF1bPfK8w2z for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Mar 2023 12:49:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 589D760D52
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 589D760D52
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 12:49:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="318846352"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; d="scan'208";a="318846352"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 05:49:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="631987288"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; d="scan'208";a="631987288"
Received: from unknown (HELO ocsbesrhlrepo01.igk.intel.com) ([10.237.94.20])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 05:49:05 -0700
From: Radoslaw Tyl <radoslawx.tyl@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 22 Mar 2023 13:48:20 +0100
Message-Id: <20230322124820.128431-1-radoslawx.tyl@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1679489347; x=1711025347;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8WFFWKXKtwqdrrTjK8u3SaJGEUX12ZLSEFIvBwOzcjM=;
 b=DHf/h9nG5RkunorA4oVesgWdN7FUFFm7KioBMpt7KQxYnIUGQbpvXwby
 yFTmkvTXOjdTnaxeIP6OQJhM6C7bsTaDLSWGHwlkGBaL2Y4I0dfMT17PI
 tK1Y6fkqBDLJJ9Vax7MwmRot4f5zJMXbiTDwZeiumrnYMqbtj7TrBwygp
 aDseusHOWwrxe9xoelROevZTeIfWEBw4Uj2myDliQlcx636VE47kPkHaP
 6Ms2mbdrLbNfHDmKiiacH5KaprlctScQtHegUG8TOR6WVnuEYYQuUOdQU
 a6zJxinMBEH5ECiG1P+JU5mHAH4ylh/6qyKtSAGC+EG025TRmXUDK5pWf
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DHf/h9nG
Subject: [Intel-wired-lan] [PATCH net] i40e: fix registers dump after run
 ethtool adapter self test
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
Cc: Radoslaw Tyl <radoslawx.tyl@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fix invalid registers dump from ethtool -d ethX after adapter self test
by ethtool -t ethY. It causes invalid data display.

The problem was caused by overwriting i40e_reg_list[].elements
which is common for ethtool self test and dump.

Fixes: 22dd9ae8afcc ("i40e: Rework register diagnostic")
Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_diag.c | 11 ++++++-----
 drivers/net/ethernet/intel/i40e/i40e_diag.h |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.c b/drivers/net/ethernet/intel/i40e/i40e_diag.c
index 5b3519c6e362..97fe1787a8f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.c
@@ -44,7 +44,7 @@ static int i40e_diag_reg_pattern_test(struct i40e_hw *hw,
 	return 0;
 }
 
-struct i40e_diag_reg_test_info i40e_reg_list[] = {
+const struct i40e_diag_reg_test_info i40e_reg_list[] = {
 	/* offset               mask         elements   stride */
 	{I40E_QTX_CTL(0),       0x0000FFBF, 1,
 		I40E_QTX_CTL(1) - I40E_QTX_CTL(0)},
@@ -78,27 +78,28 @@ int i40e_diag_reg_test(struct i40e_hw *hw)
 {
 	int ret_code = 0;
 	u32 reg, mask;
+	u32 elements;
 	u32 i, j;
 
 	for (i = 0; i40e_reg_list[i].offset != 0 &&
 					     !ret_code; i++) {
 
+		elements = i40e_reg_list[i].elements;
 		/* set actual reg range for dynamically allocated resources */
 		if (i40e_reg_list[i].offset == I40E_QTX_CTL(0) &&
 		    hw->func_caps.num_tx_qp != 0)
-			i40e_reg_list[i].elements = hw->func_caps.num_tx_qp;
+			elements = hw->func_caps.num_tx_qp;
 		if ((i40e_reg_list[i].offset == I40E_PFINT_ITRN(0, 0) ||
 		     i40e_reg_list[i].offset == I40E_PFINT_ITRN(1, 0) ||
 		     i40e_reg_list[i].offset == I40E_PFINT_ITRN(2, 0) ||
 		     i40e_reg_list[i].offset == I40E_QINT_TQCTL(0) ||
 		     i40e_reg_list[i].offset == I40E_QINT_RQCTL(0)) &&
 		    hw->func_caps.num_msix_vectors != 0)
-			i40e_reg_list[i].elements =
-				hw->func_caps.num_msix_vectors - 1;
+			elements = hw->func_caps.num_msix_vectors - 1;
 
 		/* test register access */
 		mask = i40e_reg_list[i].mask;
-		for (j = 0; j < i40e_reg_list[i].elements && !ret_code; j++) {
+		for (j = 0; j < elements && !ret_code; j++) {
 			reg = i40e_reg_list[i].offset +
 			      (j * i40e_reg_list[i].stride);
 			ret_code = i40e_diag_reg_pattern_test(hw, reg, mask);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.h b/drivers/net/ethernet/intel/i40e/i40e_diag.h
index e641035c7297..c3ce5f35211f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.h
@@ -20,7 +20,7 @@ struct i40e_diag_reg_test_info {
 	u32 stride;	/* bytes between each element */
 };
 
-extern struct i40e_diag_reg_test_info i40e_reg_list[];
+extern const struct i40e_diag_reg_test_info i40e_reg_list[];
 
 int i40e_diag_reg_test(struct i40e_hw *hw);
 int i40e_diag_eeprom_test(struct i40e_hw *hw);
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
