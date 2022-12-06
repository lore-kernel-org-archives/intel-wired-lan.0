Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8278C352A1
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Dec 2022 16:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6CD72400BB;
	Tue,  6 Dec 2022 16:34:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CD72400BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670344498;
	bh=l4ZUPIZKX/o9IC2Jms5EkXejirYMhnsItTgyzvU3qCs=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=vy+9jXvd1J/787zN3yfPP1jamZVzB7bhT8UGvi2VT37hjGNWBbENCEdgKKIYDvC8C
	 tfTmb6yV9BDQtzZjjhl58y7KPVGMppdKnuo5o4OOguhB+Dq4X9BIGM0lv3fXaWhFMt
	 sAd3lpArwhV2oCQ3RGCJ5ox1343g7aVPMDItAEYn5NuMTFqpYqjQLoyMXtv6BeFfTA
	 Vdsa3VOKioeNIxF0J4Y928wrpbmiXBxKekvjFviHwCMp/8oowqBLC6KHKe9eVMzJ/A
	 TA2z0oMH7djWxR6pg9rZTVdnFlopJMQ71R4Aw1GVHwfb08yJiio4akYUUSDwtquAcQ
	 4GeR9Gpl553ag==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KYEgjsEnY1OQ; Tue,  6 Dec 2022 16:34:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A08F40272;
	Tue,  6 Dec 2022 16:34:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A08F40272
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 8D44A1BF215
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Dec 2022 10:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 684E381E3E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Dec 2022 10:32:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 684E381E3E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p3f0d82y7kT5 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Dec 2022 10:32:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3BEC81E34
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3BEC81E34
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Dec 2022 10:32:28 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NRGtJ3zyLz15N7B;
 Tue,  6 Dec 2022 18:31:36 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 6 Dec
 2022 18:32:23 +0800
From: Yuan Can <yuancan@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <alice.michael@intel.com>, <piotr.marczak@intel.com>,
 <jeffrey.t.kirsher@intel.com>, <leon@kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Date: Tue, 6 Dec 2022 10:29:59 +0000
Message-ID: <20221206102959.20255-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 06 Dec 2022 16:34:43 +0000
Subject: [Intel-wired-lan] [PATCH net v2] intel/i40e: Fix potential memory
 leak in i40e_init_recovery_mode()
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
Cc: yuancan@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

If i40e_vsi_mem_alloc() failed in i40e_init_recovery_mode(), the pf will be
freed with the pf->vsi leaked.
Fix by free pf->vsi in the error handling path.

Fixes: 4ff0ee1af016 ("i40e: Introduce recovery mode support")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
Changes in v2:
- Add net in patch title
- Add Leon Romanovsky's reviewed by
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b5dcd15ced36..d23081c224d6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15536,6 +15536,7 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	pci_disable_pcie_error_reporting(pf->pdev);
 	pci_release_mem_regions(pf->pdev);
 	pci_disable_device(pf->pdev);
+	kfree(pf->vsi);
 	kfree(pf);
 
 	return err;
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
