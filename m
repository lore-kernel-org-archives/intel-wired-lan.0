Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADA8C43334
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jun 2022 15:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C49B605B0;
	Wed, 29 Jun 2022 15:11:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C49B605B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656515505;
	bh=OBuXyo2oV/N5RKCVlR1TqCHTOzipq9SkViaidRdI2E8=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=7RQGGoD3oFs+UVOqlpUgz4LOxjL9w3ryzSv3lIN/Cvb6QtEYnXfACGqEQACBdqWEj
	 920buU/6SIJ3w5U4oxD9O6wAnCe5EqBRZpj9/sC5hLBOLu/x8udc3CFJru2ATwxMgf
	 ed1xPOpaHr9KkZIiaetAF9RryNd7HPlvvb9AG3dLSI3fTuJm0NR9hBMSsH4+FmGa6K
	 oOLRuMqf51Q7r+KQHb4I+F9tH8Y5nDTp68atsNkcKyZ5ISfBunItt0JcIeHikmnM3o
	 OzMgrESZnt+k/rRhYNyj4+d7GTzSgfTrFIzYxTSSrZihr+rf9sHETQm1lL22UEENdM
	 vJSrLV6csw58Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dMh_ZE-sHUdF; Wed, 29 Jun 2022 15:11:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36F48606A9;
	Wed, 29 Jun 2022 15:11:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36F48606A9
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id CCA021BF28F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 14:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A60AE840E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 14:04:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A60AE840E0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrnQ9bASWTjW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jun 2022 14:04:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42FA5840DC
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42FA5840DC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 14:04:34 +0000 (UTC)
X-QQ-mid: bizesmtp63t1656511447t5k5iapr
Received: from localhost.localdomain ( [182.148.13.66])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Jun 2022 22:03:59 +0800 (CST)
X-QQ-SSF: 0100000000200060C000C00A0000000
X-QQ-FEAT: 3uawQE1sH+2MKe39u4T+sQMZuK7zrFp2/8EpLwS4FOyKK8QBIIkGb6ZhK+FVV
 VyvUFiDUrUD9efbZQkW8A5KeW2IFH5aZ6ngwzVCnB01UMfdV5m/hc86xqccf1l6vVrf89ZZ
 +RSSwjwNh+s9N0/B1X+GgyGcH3e1cFoa+gnDD9pNO7hM9HqE3X7XDSiY2ZRTlqhlRblhLil
 s4hjRGc13E23C50JsrnZwA/e6LKZd4OUDlN5U6x0ADvPxvt2EK9em5AoUYBXVgTjYVjp3pL
 MM2Ub6HzZLpa6ysLB1+5+OHBu/0DlBpkX7PHD0Yvt1m00rHpPaqwfW2+5oHqFubGPw2eBxr
 arUS3qO
X-QQ-GoodBg: 0
From: Jilin Yuan <yuanjilin@cdjrlc.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Wed, 29 Jun 2022 22:03:52 +0800
Message-Id: <20220629140352.51610-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Mailman-Approved-At: Wed, 29 Jun 2022 15:11:26 +0000
Subject: [Intel-wired-lan] [PATCH] intel/iavf:fix repeated words in comments
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
Cc: Jilin Yuan <yuanjilin@cdjrlc.com>, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Delete the redundant word 'a'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7dfcf78b57fb..548302b1cb8d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4162,7 +4162,7 @@ static netdev_features_t iavf_features_check(struct sk_buff *skb,
 	}
 
 	/* No need to validate L4LEN as TCP is the only protocol with a
-	 * a flexible value and we support all possible values supported
+	 * flexible value and we support all possible values supported
 	 * by TCP, which is at most 15 dwords
 	 */
 
-- 
2.36.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
