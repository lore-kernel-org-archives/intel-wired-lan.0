Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63AFC76196
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Apr 2023 07:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 450114058C;
	Tue, 11 Apr 2023 07:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 450114058C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681198432;
	bh=BxrtMSSq4nmbruIJuNDZQUwJfg3WcwN/S9UQkXFUh6Y=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MCyR+P+fFmx7vvIMXyWteLBcF0n7abh5/2AEp1EENesysqk+Z7t6or0ywrbxmRk6D
	 QRkn4hjD1mrQj3GYkmcDw5LSUvpAenN0cqSCcIDSki4tX9cFVzZE6v7+tkUFvJjjpz
	 Z8q8agcpwvxc1RxqeSM0RpCsSHsM9gKBn+WSixboBO4Rv2Dws3/ZKe/LKtt7hzWkqF
	 sKKAZjcdnw7hfL02JVtQimiV5Ja2fAF9dkVT0y9yfIj4ccX8DapzczfWBO++4/6tWA
	 hBJhhKXIlIWwmOXY7GXlGNKBcy5udSmXirIdih1u1za0DvwW5Ljk2xBrnhzR67UW6e
	 G2rNynokFZung==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l4QgRNfeBnpj; Tue, 11 Apr 2023 07:33:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30D5B4059D;
	Tue, 11 Apr 2023 07:33:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30D5B4059D
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id ADA7B1BF39C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Apr 2023 07:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83EC960709
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Apr 2023 07:33:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83EC960709
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yYDoKFX-ADc3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Apr 2023 07:33:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96165606F5
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96165606F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Apr 2023 07:33:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="342312488"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; d="scan'208";a="342312488"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2023 00:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="688516588"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; d="scan'208";a="688516588"
Received: from s240.igk.intel.com (HELO DevelopmentVM.nql.local)
 ([10.102.18.202])
 by orsmga002.jf.intel.com with ESMTP; 11 Apr 2023 00:33:36 -0700
From: Jan Sokolowski <jan.sokolowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 11 Apr 2023 09:37:07 +0200
Message-Id: <20230411073707.19230-1-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1681198428; x=1712734428;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=S8IbMTn52lt0O/7xMmXWtL8bjxdxSizvB3vhKhGsRXY=;
 b=Euo3inSbwnZQFOe9jPKb6dDjqDmJykhN9n9qwhFCIjbj7E+evfsIPt/Z
 GViVKa1FDAZ0uiXUxTHd7bHyXdVm7+5FsCmjbVrrj0ioubJmLFvhfwehH
 92cuWT+AFTUyHqaDv3F1TYTfWL3rbAltiF7q/0VB1+2FgXFJtIMGXWpQp
 DtgmU8Ham3L6f0pyLTQEI/TUkUHuD1gu6aPjN+5dlwCeftreDnrGuzo29
 NficX00p3kvrxA+Dc4r9sJpO8Le0hNFPghsy62k/2q5sTc6ROxK6BllOF
 hv9o1uhQDzfL6dtMrJUU3BXgvQ7snVJMp//ltvnPLPy1/guVegce4MNj9
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Euo3inSb
Subject: [Intel-wired-lan] [PATCH net v1] ice: fix undersized tx_flags field
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

As not all ICE_TX_FLAGS_* fit in current 16-bit limited
tx_flags field, some flags would not properly apply.

Fix that by removing 16 bit limitation.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Fixes: aa1d3faf71a6 ("ice: Robustify cleaning/completing XDP Tx buffers")
---
 drivers/net/ethernet/intel/ice/ice_txrx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index fff0efe28373..46c108cc5283 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -183,7 +183,7 @@ struct ice_tx_buf {
 		unsigned int nr_frags;	/* used for mbuf XDP */
 	};
 	u32 type:16;			/* &ice_tx_buf_type */
-	u32 tx_flags:16;
+	u32 tx_flags;
 	DEFINE_DMA_UNMAP_LEN(len);
 	DEFINE_DMA_UNMAP_ADDR(dma);
 };
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
