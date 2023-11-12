Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37C6C4332F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Nov 2023 16:19:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89BB941465;
	Mon, 13 Nov 2023 16:19:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89BB941465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699892374;
	bh=OMFejgpAHxvnQuWxc1ZF7k6X+yckk9gWoTdiL+HFFEA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=h9Lz4xSHMJZ9DWqJhqZWw/jv9mkFJaZL13w+mn8OcavCscBQta3bkbDDDJ02nlaxM
	 DVao9LIlgndpw+CXogPqgtD6XJ4i1anfl7Pvx/4eSbRcuqn75qCfS/BCEEI4crGvuk
	 zF0pJstliKgzp8YH+RaC9HEgr+7sWZ43Vo88wEkBVuPkceop6+Q/vEo67pfeJOwwWW
	 Pd42qMB6u/Zb5FOD5sIt0+Mi60SnNBO37fzTxAw8qr8ucJ/NwKj4Z6o/EVLMV5X+LC
	 v601Gwyy0Yp2JdVMjHBXdqUYblhq8E8vQCO+ECUeIdrnCstglIHy+k7EVKGxwUGYNN
	 DD1hN3Lov2eFA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kRnAeWQXYCqD; Mon, 13 Nov 2023 16:19:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D3D240C4E;
	Mon, 13 Nov 2023 16:19:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D3D240C4E
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 0BB241BF3B8
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Nov 2023 11:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7B3A82293
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Nov 2023 11:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7B3A82293
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uOq2xsCDoO3s for <intel-wired-lan@lists.osuosl.org>;
 Sun, 12 Nov 2023 11:07:08 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9816E82290
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Nov 2023 11:07:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9816E82290
X-UUID: fa3d835d8c464354840980aaff8161ed-20231112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32, REQID:9711d560-b41b-47c0-bc77-f47bc3bdfb95, IP:15,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:-5
X-CID-INFO: VERSION:1.1.32, REQID:9711d560-b41b-47c0-bc77-f47bc3bdfb95, IP:15,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-5
X-CID-META: VersionHash:5f78ec9, CLOUDID:588f6efc-4a48-46e2-b946-12f04f20af8c,
 B
 ulkID:231112183317SMX1J234,BulkQuantity:4,Recheck:0,SF:17|19|44|66|38|24|1
 02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
 :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: fa3d835d8c464354840980aaff8161ed-20231112
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
 (envelope-from <chentao@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1461195268; Sun, 12 Nov 2023 19:01:50 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jeffrey.t.kirsher@intel.com, shannon.nelson@amd.com
Date: Sun, 12 Nov 2023 19:01:46 +0800
Message-Id: <20231112110146.3879030-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 13 Nov 2023 16:19:27 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Use correct buffer size
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>,
 kunwu.chan@hotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The size of "i40e_dbg_command_buf" is 256, the size of "name" is
at most 256, plus a null character and the format size,
the total size should be 516.

Fixes: 02e9c290814c ("i40e: debugfs interface")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 999c9708def5..d42355fa7217 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -72,7 +72,7 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
 {
 	struct i40e_pf *pf = filp->private_data;
 	int bytes_not_copied;
-	int buf_size = 256;
+	int buf_size = 516;
 	char *buf;
 	int len;
 
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
