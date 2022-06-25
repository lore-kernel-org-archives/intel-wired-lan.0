Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1681C43334
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Jun 2022 00:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 662A681DCA;
	Sat, 25 Jun 2022 00:33:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 662A681DCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656117223;
	bh=XfzaXWHCOZzz4yfFrJ4dXJ1B9Hv3owEVmu81LBQIJjg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dbm4TbKhPVVR02h+iUEwuQiTU3KWgap7lb6rqLY6iyxma7kRE7SiAgTS3MR+r/yM9
	 /6RhRIfLUzocTxRSGxuj0c4u2gX4nSINQVkHQglFPCOJa6hHB35nrwmvf5EWAULkFh
	 IWmULZgZxyvrKpJmBANaGhHdSCDD1N0El1CRVIY28vzSobX+LAN1BY18jyQJ3bu8vI
	 Klt5aR8Id9nxrZbxThWbWZCXnuo7uTNn2/17ocr0jMx3uIkH1obh/uyDXzRKR1H2nQ
	 I8q/JDYySjKSkRQ0MObPURmQhUdO3Ke20MwqvPIW5xgOtKp3ULsaSgsA13xJj+UiEM
	 PjlpWqeGYmX1w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qG4ptzlnxG_v; Sat, 25 Jun 2022 00:33:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6227D82897;
	Sat, 25 Jun 2022 00:33:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6227D82897
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8D00F1BF423
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jun 2022 00:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64111410E3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jun 2022 00:33:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64111410E3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rRvbtaFfHK5W for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Jun 2022 00:33:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D710C410DE
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D710C410DE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jun 2022 00:33:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="306593183"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; d="scan'208";a="306593183"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2022 17:33:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; d="scan'208";a="915886366"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2022 17:33:18 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 24 Jun 2022 17:33:01 -0700
Message-Id: <20220625003302.3501801-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220625003302.3501801-1-jesse.brandeburg@intel.com>
References: <20220625003302.3501801-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656117209; x=1687653209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MOHDc+LDTC3jRAEcPgJ5zJBb+otHwbV52tZ/PS/6mxs=;
 b=FTtlw4zK67wuvsPAX/fj4D3boHE6OfZldC6W/+z6s5MvnelTVTDJd1Q7
 ZZI8Zart3ZlwEPzbAwEkVDsNgMLz/tB1IkYqp7n487goEESkL6kcC4av3
 Idktj39zkrdzj8R6ynjsP3eaQrpNoTfIouBBGLHXWudHEdgG8ZfSOUEnz
 k1VIZbSXAw9pzau0ZdU23ranrp77iOJRs4I9KQdNMPg7cOSY+jdbmP/3H
 HmMmC2R3jai2MqCsnAtPudendNxVtESC5lyN5YK+GD6+YS0JLyA3RlWwW
 O7j4hTmUfCAeY8k5mJ9lOV3XBF1DZ1VpUJRPP2OLqtH0alohTIvKNrGpQ
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FTtlw4zK
Subject: [Intel-wired-lan] [PATCH net v1 1/2] iavf: Fix handling of dummy
 receive descriptors
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
Cc: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>

Fix memory leak caused by not handling dummy receive descriptor properly.
iavf_get_rx_buffer now sets the rx_buffer return value for dummy receive
descriptors. Without this patch, when the hardware writes a dummy
descriptor, iavf would not free the page allocated for the previous receive
buffer. This is an unlikely event but can still happen.

[Jesse: massaged commit message]

Fixes: efa14c398582 ("iavf: allow null RX descriptors")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 7bf8c25dc824..06d18797d25a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1285,11 +1285,10 @@ static struct iavf_rx_buffer *iavf_get_rx_buffer(struct iavf_ring *rx_ring,
 {
 	struct iavf_rx_buffer *rx_buffer;
 
-	if (!size)
-		return NULL;
-
 	rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
 	prefetchw(rx_buffer->page);
+	if (!size)
+		return rx_buffer;
 
 	/* we are reusing so sync this buffer for CPU use */
 	dma_sync_single_range_for_cpu(rx_ring->dev,
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
