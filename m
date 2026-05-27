Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E80CD5BD0
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 May 2026 15:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BCB541E5C;
	Wed, 27 May 2026 15:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PGwB7PDeYxiq; Wed, 27 May 2026 15:21:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B28A41E3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779895308;
	bh=L4JvB8zmfLhyCH5RmecUwJB8gs5HNGzG6nxv4Q9PYZc=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qEFie+6BrguRgu5JxpLZrdjaKlf79dND+BCIO3Zm5BGXq1Oy9EKpjt8MAZgwCpRze
	 zeNE2bQ4d/o60hgQxCYA08dGBV66wcCW0jbsypfb2LzTTdydG0vBWfatMiEM5qIJIO
	 Ne/NIIOjd23mdXHomfMIRqz/yZ4hNtVD18nqwFmUS/rA7wwvzR1S8gaTkiYEP1Wa21
	 eou6rKxQ9/MS6cCzn6oO+LKXYa/d8WfCvjV42Ua0AUaDRXOBI9/4to4qd17N9v8u+a
	 wsLlubTQ6jqLZCpMCFQP6jlO/o6uRBxrZuTNpGrbmmAwRCHjTj9l0sskHeOzdS3PuG
	 mhX5qUOzdUcvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B28A41E3E;
	Wed, 27 May 2026 15:21:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 03EA721F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 May 2026 11:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7D94613AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 May 2026 11:07:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pypEuzg8bEWt for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 May 2026 11:07:22 +0000 (UTC)
X-Greylist: delayed 307 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 27 May 2026 11:07:20 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 57677613AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57677613AD
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.224.82.130;
 helo=mail-m82130.xmail.ntesmail.com; envelope-from=dawei.feng@seu.edu.cn;
 receiver=<UNKNOWN> 
Received: from mail-m82130.xmail.ntesmail.com (mail-m82130.xmail.ntesmail.com
 [156.224.82.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57677613AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 May 2026 11:07:20 +0000 (UTC)
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 400701e33;
 Wed, 27 May 2026 19:02:07 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jesse.brandeburg@intel.com, sln@onemain.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 Dawei Feng <dawei.feng@seu.edu.cn>, stable@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>
Date: Wed, 27 May 2026 19:02:05 +0800
Message-Id: <20260527110205.1780595-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e6919500903a2kunmc4d7ecc43a9e3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUNIVk5JQxpOHU9OSElDQlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
 5DQ1VKS0tVS1kG
X-Mailman-Approved-At: Wed, 27 May 2026 15:21:47 +0000
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 b=fdcZNoytiqVTMEEmwEnbmex0Y1AkGfokDoeVK/FAqs8BroYuQVbZIyOOzfT/pJthOVyQUWlIyEEASP8Nmw04wFHf6xUSq7xXW4U962Q3dBcgafEc8V7H2KxzWT+1HIbbJ68BvAt9ys/pEs7Po85jJSNJbEyLPGecLLWlQVQInkc=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=L4JvB8zmfLhyCH5RmecUwJB8gs5HNGzG6nxv4Q9PYZc=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=seu.edu.cn
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=fdcZNoyt
Subject: [Intel-wired-lan] [PATCH net] i40e: fix netdev leak in
 i40e_vsi_setup() error paths
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

i40e_config_netdev() allocates vsi->netdev for main and VMDQ VSIs. If
i40e_netif_set_realnum_tx_rx_queues(), i40e_devlink_create_port(), or
register_netdev() fails, i40e_vsi_setup() goes to err_netdev without
releasing the netdev. The existing cleanup only frees the netdev after a
successful register_netdev(), so these error paths leak the allocation.

Reorder the error paths at err_netdev to ensure proper cleanup of the
allocated device.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc5.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
Intel Ethernet Controller XL710 family adapter to test with, no runtime
testing was able to be performed.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Cc: stable@vger.kernel.org

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6d4f9218dc68..1ced01b0cc09 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14491,13 +14491,15 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
-		free_netdev(vsi->netdev);
-		vsi->netdev = NULL;
 	}
 err_dl_port:
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 err_netdev:
+	if (vsi->netdev) {
+		free_netdev(vsi->netdev);
+		vsi->netdev = NULL;
+	}
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
 err_vsi:
 	i40e_vsi_clear(vsi);
-- 
2.34.1

