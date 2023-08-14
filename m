Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BD7C001B0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Aug 2023 13:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DA8860B04;
	Mon, 14 Aug 2023 13:58:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DA8860B04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692021514;
	bh=QgfHoeYob0220oquUi9+j1NSiY7xFEqOMskPzMFcW/0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=LXnJtmhh796pETSvX1vpI59bx8bXzhR1y9IgK++nyg8cw7p0MC63eRjQgX8jUohth
	 b377AX9VYyigvVWTrofMlpxCyMgYOgvMS67lwBk+4fu7GsdsEvyNIDXfbLjMp8REW2
	 QiNrgwAM/9VCVvfifPvZ1yv52NXxXwbnSdrbnbzd39ZoNwaU2Xv4KYwYem/2v7E29P
	 305Ha7K/paAwShDhhyX9a7H11BqV/ILezL/P1lg1Hl0GG9TGLvqKZJE3IeMHREgM08
	 9m1vKFZ1hOXWJsDHRHmqTT6kY1dS3teUSzY2do8sJm2Cp3e+7puoEBKj+P9RBakIDh
	 lE0umrYatFQPA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXbHizkkalXt; Mon, 14 Aug 2023 13:58:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 222EC60B48;
	Mon, 14 Aug 2023 13:58:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 222EC60B48
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1571E1BF396
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Aug 2023 13:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4C1380BBD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Aug 2023 13:58:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4C1380BBD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iNVpL7Xng40X for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Aug 2023 13:58:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AA7D81DFC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Aug 2023 13:58:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AA7D81DFC
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPbW26mpYzNn02;
 Mon, 14 Aug 2023 21:54:54 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 21:58:25 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <yuehaibing@huawei.com>
Date: Mon, 14 Aug 2023 21:58:21 +0800
Message-ID: <20230814135821.4808-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Subject: [Intel-wired-lan] [PATCH net-next] net: e1000e: Remove unused
 declarations
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Commit bdfe2da6aefd ("e1000e: cosmetic move of function prototypes to the new mac.h")
declared but never implemented them.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/e1000e/mac.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/mac.h b/drivers/net/ethernet/intel/e1000e/mac.h
index 6ab261119801..563176fd436e 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.h
+++ b/drivers/net/ethernet/intel/e1000e/mac.h
@@ -29,8 +29,6 @@ s32 e1000e_set_fc_watermarks(struct e1000_hw *hw);
 s32 e1000e_setup_fiber_serdes_link(struct e1000_hw *hw);
 s32 e1000e_setup_led_generic(struct e1000_hw *hw);
 s32 e1000e_setup_link_generic(struct e1000_hw *hw);
-s32 e1000e_validate_mdi_setting_generic(struct e1000_hw *hw);
-s32 e1000e_validate_mdi_setting_crossover_generic(struct e1000_hw *hw);
 
 void e1000e_clear_hw_cntrs_base(struct e1000_hw *hw);
 void e1000_clear_vfta_generic(struct e1000_hw *hw);
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
