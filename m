Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9A9C4167B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 Dec 2023 16:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F1C741762;
	Mon, 11 Dec 2023 16:42:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F1C741762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702312948;
	bh=wKwQ4eYsKEwXT3XXCNLGQwBLZPy4U+Ac7JejFRuXAuU=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=lyIJ6+ONiqS6MkK/dlf2ByiK2jknLxreqWxGDISlL5D14FDxs4Nx4jGAbMHvmC1T1
	 RQ7B5nfWNe+nWRTwHxCeqKf42Hxl9r8LQHBMxZ2o8BJWyU4k7ScF/9EGXGNlZfLz4z
	 BqEVaqMO8Lqiq+4pMO0Dp2wG3PpGArGaD6NZUhqZnIQvxNxoiEx54DdZPMwoSdoGSw
	 87QPQWPbnaE/4YfUeDL4zs4+dX69x1ap9/nj6pxA25wbWThyyNBJOzoh71cqqDWbZD
	 4Gphzbape//ucorIPSl3ZFRvi9yXuPKphz6do3tsZFJyEmXrXQhwSr1DfiKLzc+J7F
	 wObNFMd86g47A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lLB4iLjpsE_j; Mon, 11 Dec 2023 16:42:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55E3B416DB;
	Mon, 11 Dec 2023 16:42:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55E3B416DB
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 3E8011BF3C1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Dec 2023 03:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15AAB80BC3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Dec 2023 03:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15AAB80BC3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zgqkWXhYHVFC for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 Dec 2023 03:00:21 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 670F780A58
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Dec 2023 03:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 670F780A58
X-UUID: 0b105c8e154d4308be340be35614f20c-20231211
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33, REQID:19a20f34-c316-4582-9f89-476ca1073edf, IP:5,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-10
X-CID-INFO: VERSION:1.1.33, REQID:19a20f34-c316-4582-9f89-476ca1073edf, IP:5,
 URL
 :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-10
X-CID-META: VersionHash:364b77b, CLOUDID:931283fd-4a48-46e2-b946-12f04f20af8c,
 B
 ulkID:231211105935IA61I4Z6,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
 02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
 L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 0b105c8e154d4308be340be35614f20c-20231211
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
 (envelope-from <chentao@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1052257917; Mon, 11 Dec 2023 10:59:34 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Mon, 11 Dec 2023 10:59:27 +0800
Message-Id: <20231211025927.233449-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Dec 2023 16:42:26 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: Fix null pointer dereference in
 iavf_print_link_message
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
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 64c4443dbef9..1b50d351f28b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1444,6 +1444,8 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
 		speed = kasprintf(GFP_KERNEL, "%d Mbps", link_speed_mbps);
 	}
 
+	if (!speed)
+		return;
 	netdev_info(netdev, "NIC Link is Up Speed is %s Full Duplex\n", speed);
 	kfree(speed);
 }
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
