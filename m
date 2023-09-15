Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956CCEED603
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 Sep 2023 15:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E99641986;
	Fri, 15 Sep 2023 15:13:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E99641986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694790782;
	bh=jgvo5rnchQfa5BSdIezi6vTxyfyU2PKM53g77zA1UoI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=C2WPHKPMKf8UAa0/pe1qHJuIAWGYO1aHLZGePc8nWkXwaM4AJGopeLlzago1ALn6U
	 2cnYTBdbuQ7nDd6wfRfNnQ/weJLzt7001DTA5e0wbPYdcKLOShgVQmcEG1Qri4hZR1
	 L1Nzx4Yvy67/jW0RxspF9d8HiRqVMBKclmDV5KA2ELuzELaGsUljvPEkijEzGkTzSa
	 6mZQ4C5G8UzLYcMQtkUfyu+moIpYUc/ROREuDhOHv4Rq+CDV6jtbHLvx9j3I2rsSqX
	 u/Fu9mDSTRGorP8o6h4EoZPvnQU6L/rlYR1tJIalB2wFmSjM8Qyjxab3PWxLTDrfiU
	 4dlSWspwDT8Yg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXAnDsDQLEy2; Fri, 15 Sep 2023 15:13:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E4B741971;
	Fri, 15 Sep 2023 15:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E4B741971
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id AFDF01BF3D2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Sep 2023 15:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 851B283B87
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Sep 2023 15:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 851B283B87
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LjngA9wjXsoT for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 Sep 2023 15:12:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDD4B83C01
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Sep 2023 15:12:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDD4B83C01
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410209432"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; d="scan'208";a="410209432"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 08:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="868741789"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; d="scan'208";a="868741789"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga004.jf.intel.com with ESMTP; 15 Sep 2023 08:12:35 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 596EE33E83;
 Fri, 15 Sep 2023 16:12:34 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 15 Sep 2023 17:09:58 +0200
Message-Id: <20230915150958.592564-7-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230915150958.592564-1-pawel.chmielewski@intel.com>
References: <20230915150958.592564-1-pawel.chmielewski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694790757; x=1726326757;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9LKvTxSevpLEFQm5EUNabCxtuXlzk26Ycue2YeA3lIk=;
 b=jpsryX3cXPcxbreC86kR9CvCnys+JUJStOYNhZuf/vUU7P95aRac12aC
 v++SdrZ4VIY9lJB4RlETnVc7d1oUQn9922peld6rpFFxwESFHrLZXe3Zi
 fLL9vjL87KtPsuj2a3xIYtvdfOvfluAJ166vFaiv3AIJKWAqaAqJvx6hf
 JRQ8NWnGoSRiuTHxd/P7FHnWGUUcKpJMNB2N6psJJzSffLqxFHYAidbvS
 KfjzrfAJ9WWS4MVSrnbNo/drh68+1OedJryINgaSe7K2BpqM9RyAuWlDX
 DNo7WtJ/AdidOKuUDT4d99tDfX1opkhCyGmpbclc4KkAT82hgRGrpxzbs
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jpsryX3c
Subject: [Intel-wired-lan] [PATCH iwl-next v4 6/6] ice: Hook up 4 E830
 devices by adding their IDs
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
Cc: Pawel Chmielewski <pawel.chmielewski@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, andrew@lunn.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

As the previous patches provide support for E830 hardware, add E830
specific IDs to the PCI device ID table, so these devices can now be
probed by the kernel.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9562ba928aae..5b16c03d2461 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5587,6 +5587,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD) },
 	/* required last entry */
 	{}
 };
-- 
2.37.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
