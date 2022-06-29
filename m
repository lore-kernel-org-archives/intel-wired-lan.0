Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9382C433EF
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jun 2022 15:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B967605B0;
	Wed, 29 Jun 2022 15:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B967605B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656515492;
	bh=ZSqMPTIXYRExm76hGR0Ea2guPKIooMAiXkvL7vBAmjk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=3jy7Vo3v+/WKq3tYq44eIU5VYql7A1FpkpR0DMtOS7S1iZFl8i1I5QmYX/Er6xUlX
	 YmmmqJvXXF87hLGJ+504wBhTCa0qiCXpQJwDZX+6ZRK+DmpmCeib564jomiSyZBgGa
	 UQgo1eMMkzG3uJZSu0Hawp0G4zCrbgrJqJ/3MJF6K3zpL7IYdW7u8U/PWuFrkUV37T
	 jBhKbl70CyYe/+CSF/vmInV00wvhzLY729FXjSW4j70he47fgF1H3nO/dZP6P81PrD
	 U2n/PbpxhG2DUp+KlrB92nbEmQ1sePAG0I2B154c2Yyo3SX56GKXX9qd589aV7Z07C
	 MemMvbGFSNJSg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SNHfWCk2fa1s; Wed, 29 Jun 2022 15:11:31 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7112612F7;
	Wed, 29 Jun 2022 15:11:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7112612F7
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9392F1BF325
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 13:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BA374158E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 13:38:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BA374158E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N1aMqhwqKHFv for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jun 2022 13:38:49 +0000 (UTC)
X-Greylist: delayed 00:11:38 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60029415AF
Received: from smtpbg.qq.com (unknown [43.155.67.158])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60029415AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 13:38:48 +0000 (UTC)
X-QQ-mid: bizesmtp67t1656509207tmr49ddo
Received: from localhost.localdomain ( [182.148.13.66])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Jun 2022 21:26:43 +0800 (CST)
X-QQ-SSF: 0100000000200060C000B00A0000000
X-QQ-FEAT: ArfJXynxbT1zj6XR+vr5fd6e+cizYfSbP15s5FozpOGYmXoY8KIjYo6OA0aRE
 I8Lph/UCdValtELq7XTbFO+0YM6+nczzMd4npR/q64TlfTl9SNKdAKrnQ5mB08Un/FxmlTz
 DAiYxe/1mZzQiMo2icS4y8chd7/DFdaajMzs4wsG8WWUrS4LLMnToxudiEbAYn6D8s5F8di
 M2SA5jJcFfNE8cvPIjfn23z35LGaMnkhiePu3nfXoXMNqmANFR2RreThKagt1ait73moNb/
 B4J4cT0GLVXZCKY4qVIvX6kUOOG1D/YI1B+Hba1uYuFllfBPGKe8tyQ+Nk6FXgovdKO6aVl
 vPcb1DAjWWKNUGb8tA=
X-QQ-GoodBg: 0
From: Jilin Yuan <yuanjilin@cdjrlc.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Wed, 29 Jun 2022 21:26:36 +0800
Message-Id: <20220629132636.31592-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Mailman-Approved-At: Wed, 29 Jun 2022 15:11:26 +0000
Subject: [Intel-wired-lan] [PATCH] intel/e1000:fix repeated words in comments
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

Delete the redundant word 'frames'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 1042e79a1397..e23b64c332dd 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -2000,7 +2000,7 @@ s32 e1000_force_mac_fc(struct e1000_hw *hw)
 	 *      1:  Rx flow control is enabled (we can receive pause
 	 *          frames but not send pause frames).
 	 *      2:  Tx flow control is enabled (we can send pause frames
-	 *          frames but we do not receive pause frames).
+	 *          but we do not receive pause frames).
 	 *      3:  Both Rx and TX flow control (symmetric) is enabled.
 	 *  other:  No other values should be possible at this point.
 	 */
-- 
2.36.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
