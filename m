Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647A0C77B7A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 29 May 2023 13:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D292C4187F;
	Mon, 29 May 2023 13:09:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D292C4187F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685365759;
	bh=cQMWJislBzSj/q638PRbauXTeyKdCAPuuZQhLTdpubQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=bUFbDbQS1+rlQs6fPIECrprhTJmWLXuC+zOfkATgBjDVsSBReRNpNt8X0MXmJTkZ0
	 kRpmbzWb5uLWOKvakoXo+HZ7Z19ggNSN9+M7Bs7JesH7jsJDOuccmJM3ANm7ttwdRm
	 Ndx9vcfQ1b1dolWLJpPYYyRs7zAOxLnYek+mcwJZMXzWqW7dgjtPnvKEKuG6jE9TxL
	 6BqvadINbXTERAT3WQKsEEo6d+AIU9NwLpDLnOB/o98tHaiI6/P4+ffxWKmalf65yM
	 AWE936IcIZDwj16O7wFy3BQotopHrjSGGAz/m2iUjQMGnr8fpJj8D+RCc2+xXXRppI
	 S6OSfhRkh3dsw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FZ3pXoc-vKFQ; Mon, 29 May 2023 13:09:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A322541877;
	Mon, 29 May 2023 13:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A322541877
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id E07361BF404
 for <intel-wired-lan@lists.osuosl.org>; Mon, 29 May 2023 13:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C579361298
 for <intel-wired-lan@lists.osuosl.org>; Mon, 29 May 2023 13:09:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C579361298
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QLHKSlCJv_vw for <intel-wired-lan@lists.osuosl.org>;
 Mon, 29 May 2023 13:09:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F83A607C9
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F83A607C9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 29 May 2023 13:09:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="353544826"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="353544826"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 06:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="850398901"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="850398901"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga001.fm.intel.com with ESMTP; 29 May 2023 06:09:14 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id E033B34907;
 Mon, 29 May 2023 14:09:13 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 29 May 2023 15:08:06 +0200
Message-Id: <20230529130806.81157-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685365756; x=1716901756;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dOeUv8Cx8S/3xZOo0LdsApkn/2k7AmJTci0AkI1mn2g=;
 b=WY/KaSoJySY6h5feHvSyIPahVuBNuOI8QDbRnLcXHJwLWKedT6faE84F
 ajjV76wxHzIC5CXp7qZdluYxmAgr96j+H+4Dis+DuEdTlMIVA3zj60PRo
 ty+KkfSu+XhKSEAmrCyodqwIEjs8BjOXC+pYVfIpzuQ88Pm3WyzO5thNr
 gtEKaWhHJk+WessZle2EiBcgY4v9fUQtLctyuahz5w1aK62N3osASTJR6
 xiOIHRkHY58bEzpu1mzvfqpGd2FMweQK73a2Nmxokyi+4J36ntUNXcsJ0
 25mEzADfZRPXuCCMQ2vHCGgMTkVvMuAxybpxld6h7Q7NQ8ZXhpab7CR2P
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WY/KaSoJ
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: Fix mem leak when creating
 guard rule
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
Cc: anthony.l.nguyen@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Free list in ice_eswitch_br_guard_rule_create when
rule creation is successful.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
Tony, could you squash this patch into
"ice: Add guard rule when creating FDB in switchdev",
http://patchwork.ozlabs.org/project/intel-wired-lan/patch/20230524122121.15012-9-wojciech.drewek@intel.com/
---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index c225287be9e1..2463ededb9d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -226,6 +226,8 @@ ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
 	if (err)
 		goto err_add_rule;
 
+	kfree(list);
+
 	return rule;
 
 err_add_rule:
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
