Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314A8CCA47B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Jul 2022 12:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEA37812FC;
	Tue,  5 Jul 2022 12:52:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEA37812FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657025528;
	bh=sxRhQXRPHrxHa1mon6+o9zs7jvYJTiyc7RaJKtuXkHY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=D+rohMwJ1BCrFl1cVHOWH/CtFdA3MvOIpqrulmJglgdWulNpeCnvDMm+YB0nILU8N
	 jAvqtQfLZUmGsD4zZf0BwazDLORNMr6aH+I6JFIwKBvvmxeTfO6Vf4hKLAIARcoXI/
	 s/zSxW4FgUcNdLltE/CTg5SGy+2Y2BdHUhwADLffgTMIRGFBU2vL83YK1nwIsdGUhD
	 CRiflRR5BkYSlQudr4+9aYax/PIFQ6kdVJdv5xkBPa7I4Nu78AO5/ucwhJEA+3jGaZ
	 gvcZNWWPd57fzW/xqJAzrqXfI7Lm2bCNa6S9SCXgHdZzS89udNeK7I3PWkZ161221V
	 gJSbxRkmNy5aQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DkfsKoQAGhAF; Tue,  5 Jul 2022 12:52:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFCB082716;
	Tue,  5 Jul 2022 12:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFCB082716
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DC0591BF36D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Jul 2022 01:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C258A60AAC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Jul 2022 01:08:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C258A60AAC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sC2JXvSUbxGw for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Jul 2022 01:08:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 901DD60AA7
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 901DD60AA7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Jul 2022 01:08:49 +0000 (UTC)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LcPd86CJKzhYZG;
 Tue,  5 Jul 2022 09:06:20 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Jul
 2022 09:08:12 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>, 
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>, <ast@kernel.org>, 
 <daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>
Date: Tue, 5 Jul 2022 09:13:04 +0800
Message-ID: <20220705011304.230622-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 05 Jul 2022 12:51:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: i40e_reset_vf should
 return false if reset vf timeout
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
Cc: yuehaibing@huawei.com, shaozhengchao@huawei.com, weiyongjun1@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

when trigger vf reset, but vf status is not ready, i40e_reset_vf
should not do other cleanup action. The current logic is always return
true. But it can't cover timeout scenary, and the looping in function
i40e_vc_reset_vf is useless. 
Waiting for 120ms will cover most normal scenary. And the caller 
function should try again when timeout or accept that resetting vf 
failed.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index d01fb592778c..42262009a00c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1564,11 +1564,17 @@ bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 	if (flr)
 		usleep_range(10000, 20000);
 
-	if (!rsd)
-		dev_err(&pf->pdev->dev, "VF reset check timeout on VF %d\n",
-			vf->vf_id);
 	usleep_range(10000, 20000);
 
+	if (!rsd) {
+		reg = rd32(hw, I40E_VPGEN_VFRSTAT(vf->vf_id));
+		if (!(reg & I40E_VPGEN_VFRSTAT_VFRD_MASK)) {
+			dev_err(&pf->pdev->dev, "VF reset check timeout on VF %d\n",
+				vf->vf_id);
+			return false;
+		}
+	}
+
 	/* On initial reset, we don't have any queues to disable */
 	if (vf->lan_vsi_idx != 0)
 		i40e_vsi_stop_rings(pf->vsi[vf->lan_vsi_idx]);
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
