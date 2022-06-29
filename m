Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3946C43334
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jun 2022 15:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 408B5417A2;
	Wed, 29 Jun 2022 15:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 408B5417A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656515534;
	bh=ogimsncGh6H1VYOBJNJ3UerANmvOo8aABHq8i4Bl32k=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=HWkQHCWI2QDbeQYhtN3CsAVuUbLurskLzKk2WmHiocGlhJTtdPSpTpjdQc6LRrpDK
	 bNNJMuOtTo9r9OfNaHA7kuM4mi4FkcRlAw1qZRpNRDx5YT2vE1XAfFcW1wQYT4MCKt
	 vhqE0mfN1TzVNSqlcYkU6CucfzP3XovaxhOd5bnUdqZUMdqVKMcuOPX21LPAqbX0Vi
	 wjYUaqIi/odbwI0DdsilJdFC4QAhg70/NZgU+ZTINnltdDEO+MveXlFagPyJLVFjFa
	 PlwI0G2f4hs3ltfq77ct57ed0feR62n9qE3Ijf6IISlQbmqyH+ilHLWBx8MFhYGVOK
	 mDPK0i5aH8k0g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wu-N2IeXW41T; Wed, 29 Jun 2022 15:12:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9DAF41A6D;
	Wed, 29 Jun 2022 15:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9DAF41A6D
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1C07A1BF28F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 14:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E916C415B2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 14:31:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E916C415B2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RGuBuNwsQb5x for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jun 2022 14:31:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2538401B1
Received: from smtpbg.qq.com (unknown [43.155.67.158])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2538401B1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 14:30:59 +0000 (UTC)
X-QQ-mid: bizesmtp80t1656512707t4q4eqwx
Received: from localhost.localdomain ( [182.148.13.66])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Jun 2022 22:25:04 +0800 (CST)
X-QQ-SSF: 0100000000200060C000C00A0000000
X-QQ-FEAT: TwPVgCEnUPnJO5LRHT5GJze7vZ8UMdtnokyDiXgpBnFr3S8dIu5E6zQolWsMZ
 R9RQhNdONWtFEZCORBctel/rSVnKlNE4CRFpY4nGmY/2YK1PYQeJ+JfeRnZIWAY0K6/tgI1
 HcVdFe/Ttv0O9PZ+GZXVeC1KaU4TnWoGCpFk1/yeV1wTVxVFaxOx/rA7GDn6uTE6xV3b4XW
 Wy7kKctW33NRgf/StvjuAt2d4S/5q5P1UXnU+djjkv79v3/38G34xoI3f5zVFf8qE/BYaZB
 gjfR4F29/GgEr1u9CVklgTVmfQhhAWJyQt2gKk18GWfaQDHreAj3S6hTqZRFxc0/DGUKBNG
 C/Q0a/BgEGT2M8XOvs=
X-QQ-GoodBg: 0
From: Jilin Yuan <yuanjilin@cdjrlc.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Wed, 29 Jun 2022 22:24:57 +0800
Message-Id: <20220629142457.16887-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Mailman-Approved-At: Wed, 29 Jun 2022 15:11:26 +0000
Subject: [Intel-wired-lan] [PATCH] intel/igc:fix repeated words in comments
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
Cc: netdev@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Delete the redundant word 'frames'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 67b8ffd21d8a..a5c4b19d71a2 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -193,7 +193,7 @@ s32 igc_force_mac_fc(struct igc_hw *hw)
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
