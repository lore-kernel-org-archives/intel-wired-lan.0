Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A695CC77B61
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Apr 2023 15:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35A3B40901;
	Tue, 25 Apr 2023 15:44:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35A3B40901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682437461;
	bh=RkjKwP9+T0ANRPQ/OqrmJbA56KhFKBZrVdVOJwt+9aw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tuMvl/ZpCSKn3e2Qp7CF7wHv8LiTwLFmabH1zyzkcu4ch1yskdw7pfnRduXKYIT1N
	 mbi19zhtWXVZIXkYLB6xNm+7DcJUCtsvfv0pzaFzW34KQ6Gk9G0oe+uQymlshcHF+5
	 v65VvZq3FmGTeryLpBvtNBppjpWMCduCvDrTFulEiu7XUoTjfyrWvemsvE7DLu2B+0
	 hrpAUTZlf96riu2Bc8XIodymSF99QYa9r9x7QUJ8aSpJOVTQ92sDXtmgi8dbmGxMeJ
	 L5GivyaTAj7LhiU1cNyn6swbg5fSM8h9HlUDAblkgEYZEspvcb+gDSBk1jIZ4a6kSz
	 UVG4gyljvr4gQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v4OaaS_6ZNj7; Tue, 25 Apr 2023 15:44:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 479CC409BD;
	Tue, 25 Apr 2023 15:44:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 479CC409BD
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C77101BF834
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Apr 2023 15:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 945E44092C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Apr 2023 15:44:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 945E44092C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9boE_NyYzHoL for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Apr 2023 15:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21F5A40928
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21F5A40928
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Apr 2023 15:44:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="346832876"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; d="scan'208";a="346832876"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2023 08:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="782910132"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; d="scan'208";a="782910132"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2023 08:44:15 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com
Date: Tue, 25 Apr 2023 17:44:14 +0200
Message-Id: <20230425154414.154351-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1682437457; x=1713973457;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qvyYXHYjP1eXOmIC8q9fZRQjy2qqljzCRixeV0QVQoU=;
 b=R5MsSjTTdsrK/CcU7U2TxhoRr6r8+x3tUq5sKMvCqqvK/OAIqZGYrUGA
 W+yRUAS5Nmk8yhNmkIYpgHfWJ/bLO5zGRr3IBskdGOWHZa6IBMCNwPSVQ
 ozrUSjSNobEj0kb7c2+WWVxrMDvKPDVFMZNkhCN9/AWvAAPeym94yY+Vh
 NCwzQhisG+lXVLizBDIhM4rSo31Db1wbC4qyDLV0Ucx14AqO9itzgnXjw
 WFW2l3hR0miaSzHpogIkfMTjeJO/bmUwV7gGdXOHBESC1e5Khq6s/LxVC
 MSzhEPw5rF9Y33Dahe66L/YDi66Gwntdux/ZbWiIGgtt7CbTsc0vWo0ZW
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=R5MsSjTT
Subject: [Intel-wired-lan] [PATCH net v1] igb: fix nvm.ops.read() error
 handling
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add error handling into igb_set_eeprom() function, in case
nvm.ops.read() fails just quit with error code asap.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 7d60da1..1567822 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -822,6 +822,8 @@ static int igb_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = hw->nvm.ops.read(hw, last_word, 1,
 				   &eeprom_buff[last_word - first_word]);
+		if (ret_val)
+			goto out;
 	}
 
 	/* Device's eeprom is always little-endian, word addressable */
@@ -839,7 +841,7 @@ static int igb_set_eeprom(struct net_device *netdev,
 	/* Update the checksum if nvm write succeeded */
 	if (ret_val == 0)
 		hw->nvm.ops.update(hw);
-
+out:
 	igb_set_fw_version(adapter);
 	kfree(eeprom_buff);
 	return ret_val;
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
