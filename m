Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496BFCA0EFF
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 Aug 2025 15:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0576940C48;
	Wed, 27 Aug 2025 15:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CNGKI29WwYHq; Wed, 27 Aug 2025 15:15:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCE9040C78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1756307752;
	bh=gI/Z2gBQpdNB8ltIxqFU8ygCnflHFmAzN9+mK+qs5pU=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=659wd4RpJo/Dmvt93slmx0v/UNFT+FYTKgOosvCTLi4gdd7VP0upS8uvE9zQ6UZqf
	 uh0Wolo/1Sl9bX9OUAAdgmbyqGlbVL9q22Vbucp/mXrojovTsDNMK6JppSRjQ8kJMn
	 aJ+Lgcm5bva4U2hUteNNvmvH2JXv6kOX3T7XenSekHMPC458rYaaGn+dHIT5TLoP9C
	 RjaArJU1nZcqh/Ti2nh8AB4uC3CA5sHIvQW7eaTeoTLUJYghPQ80tCgM5he8CbI6QM
	 UUF2J/jr9HbqY3Ea3vOe9w/fAA2NkVeFt83AC1aq9IA8wo7PSj01Hc7sKodTi3xAVm
	 GAfQK63vg80DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCE9040C78;
	Wed, 27 Aug 2025 15:15:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C4CB4B0B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Aug 2025 03:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFB0660B51
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Aug 2025 03:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TF3fpFZs_pbg for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 Aug 2025 03:29:10 +0000 (UTC)
X-Greylist: delayed 307 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 27 Aug 2025 03:29:09 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 412C260B09
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 412C260B09
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.254.49.229;
 helo=mail-m49229.qiye.163.com; envelope-from=zhen.ni@easystack.cn;
 receiver=<UNKNOWN> 
Received: from mail-m49229.qiye.163.com (mail-m49229.qiye.163.com
 [45.254.49.229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 412C260B09
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Aug 2025 03:29:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [218.94.118.90])
 by smtp.qiye.163.com (Hmail) with ESMTP id f401266f;
 Wed, 27 Aug 2025 11:23:56 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Zhen Ni <zhen.ni@easystack.cn>
Date: Wed, 27 Aug 2025 11:23:48 +0800
Message-Id: <20250827032348.1374048-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98e98dbb2b022akunm24051186c08aa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0JIVk8YHkJPHhhKH0oaHVYVFAkWGhdVGRETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-Mailman-Approved-At: Wed, 27 Aug 2025 15:15:51 +0000
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=easystack.cn
Subject: [Intel-wired-lan] [PATCH] i40e: Fix potential invalid access when
 MAC list is empty
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

list_first_entry() never returns NULL — if the list is empty, it still
returns a pointer to an invalid object, leading to potential invalid
memory access when dereferenced.

Fix this by checking list_empty() before calling list_first_entry(),
and only copying the MAC address when the list is not empty.

Fixes: e3219ce6a775 ("i40e: Add support for client interface for IWARP driver")
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 5f1a405cbbf8..0a72157aee0e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -359,12 +359,13 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
 	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
 		goto free_cdev;
 
-	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
-			       struct netdev_hw_addr, list);
-	if (mac)
+	if (!list_empty(&cdev->lan_info.netdev->dev_addrs.list)) {
+		mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
+				       struct netdev_hw_addr, list);
 		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
-	else
+	} else {
 		dev_err(&pf->pdev->dev, "MAC address list is empty!\n");
+	}
 
 	pf->cinst = cdev;
 
-- 
2.20.1

