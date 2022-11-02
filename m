Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D6BC4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Nov 2022 15:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B845340AA8;
	Wed,  2 Nov 2022 15:36:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B845340AA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667403370;
	bh=jH+nNaPEfVaPvueOOVEDp1YnLrV6PVFkatzs891Pfko=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=GmiZAyrVzcelQfugfK2Q1GwZFo/39lqnfRil9W2DgeWZr3psAqf9h7RXAexUUgHHU
	 p2XkRrUV6osFmnXFxaURh9NT2OmRXwCg0tHWGy/qNrBSrof72BCRdWPzc52egfbN5x
	 ZufNsTI8hCLwHdtjvwh6LTiNIQfjESZrXUmGHluaUHDnjHbm/ZuG99TygBgt/kJMMC
	 2IlF8DmebSuutfbafKLGvgcl5JMQMMc2U5NKAGGlrlsu1NNbiPEhzL3imQ/94dyH9d
	 XmuNCOXmdx6UXrulSXUJC5Rkw3GRxAWRlaFJDNPqHXCECkwIRBinZlnzK3qSkozGlN
	 IDDVBt7YL7g7A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VMMHog2SFLO6; Wed,  2 Nov 2022 15:36:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9908440A91;
	Wed,  2 Nov 2022 15:36:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9908440A91
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8D48F1BF3FF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Nov 2022 05:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CEA341609
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Nov 2022 05:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CEA341609
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQKWO5mXg40m for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Nov 2022 05:31:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38217415F1
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38217415F1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Nov 2022 05:31:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=yang.lee@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0VTmC.cG_1667367100; 
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VTmC.cG_1667367100) by smtp.aliyun-inc.com;
 Wed, 02 Nov 2022 13:31:41 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: jesse.brandeburg@intel.com
Date: Wed,  2 Nov 2022 13:31:39 +0800
Message-Id: <20221102053139.848-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 02 Nov 2022 15:36:02 +0000
Subject: [Intel-wired-lan] [PATCH -next] ixgbe: Remove unneeded semicolon
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
Cc: Yang Li <yang.lee@linux.alibaba.com>, intel-wired-lan@lists.osuosl.org,
 richardcochran@gmail.com, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

./drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1305:2-3: Unneeded semicolon

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2688
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index fd3f77a9e28d..0310af851086 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1302,7 +1302,7 @@ static void ixgbe_ptp_init_systime(struct ixgbe_adapter *adapter)
 	default:
 		/* Other devices aren't supported */
 		return;
-	};
+	}
 
 	IXGBE_WRITE_FLUSH(hw);
 }
-- 
2.20.1.7.g153144c

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
