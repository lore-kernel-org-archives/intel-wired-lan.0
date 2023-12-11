Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2176BC10DC3
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 Dec 2023 16:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B01A641933;
	Mon, 11 Dec 2023 16:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B01A641933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702312952;
	bh=b/ZV5WgUARdinkoGEyS8Pvj8+WT84/L8o2q2yPHyyNM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=fiPpQEnUvXTnr7vyoZk+ilq9sgyTHkyx6vQGH6GhLpSYJ4qAb/sFqSnZlx8UE7m0h
	 7OrnVE2IqRCRhV4MZ/89v2VREhkukKc2Jqe1azHCVXF27sHpN+KS6cCzj6jHA/8ATp
	 GbV8XIlUQkhlpu53QFBxGkCb5BSYN4cG6JvkjcVIR0al5G85f57hoBDw8s+Mpe51mD
	 X5V5bSdoFtWD23nb9CPfXZ1GFKUw2b+OiElrN9cr/YnwUgIUMVCWuoZ2WUJ6wXqyMA
	 So1Tfnrxgx3GoGmnRcjHIXvHUTetFQzFMkPobDqKLvczRqttSkFG+YzF9T4vRZxGbB
	 sOPWd4za3BWrQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLHyPbzjY-ko; Mon, 11 Dec 2023 16:42:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5DC7417BD;
	Mon, 11 Dec 2023 16:42:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5DC7417BD
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id EA9C41BF32B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Dec 2023 03:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3D838215C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Dec 2023 03:13:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3D838215C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 49WguISRyivq for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 Dec 2023 03:13:55 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EEEA82157
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Dec 2023 03:13:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EEEA82157
X-UUID: b0aed6746fa9462dbc846b22f61b057a-20231211
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33, REQID:62e02d26-f187-4327-b2ae-62bc0e600995, IP:5,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-15
X-CID-INFO: VERSION:1.1.33, REQID:62e02d26-f187-4327-b2ae-62bc0e600995, IP:5,
 URL
 :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-15
X-CID-META: VersionHash:364b77b, CLOUDID:5c8e0a61-c89d-4129-91cb-8ebfae4653fc,
 B
 ulkID:231211111344YBK1WEVE,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
 02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
 L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: b0aed6746fa9462dbc846b22f61b057a-20231211
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
 (envelope-from <chentao@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1392175482; Mon, 11 Dec 2023 11:13:41 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Mon, 11 Dec 2023 11:13:36 +0800
Message-Id: <20231211031336.235634-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Dec 2023 16:42:26 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Add null pointer check to
 igb_set_fw_version
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
Cc: Kunwu Chan <chentao@kylinos.cn>, Kunwu Chan <kunwu.chan@hotmail.com>,
 przemyslaw.kitszel@intel.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jacob.e.keller@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 1978d3ead82c ("intel: fix string truncation warnings")
Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b2295caa2f0a..6838f6fccb80 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3102,6 +3102,8 @@ void igb_set_fw_version(struct igb_adapter *adapter)
 		break;
 	}
 
+	if (!lbuf)
+		return;
 	/* the truncate happens here if it doesn't fit */
 	strscpy(adapter->fw_version, lbuf, sizeof(adapter->fw_version));
 	kfree(lbuf);
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
