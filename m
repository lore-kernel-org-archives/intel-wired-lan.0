Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C79EB64D8
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Jun 2023 14:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 081A961321;
	Wed, 14 Jun 2023 14:53:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 081A961321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686754427;
	bh=9y/9GsKY6zjS+HqsnUsUt/ybJ2BEWiVGFHC1IhSbnIw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=z88Xm9kBg2lq7T7Q7+p9iGrI7RNWC/abripmjRuyX87UeFbaPgSBbT2EROGTqsN68
	 mFznBQ6ihV51mi0mVsu8C8NgcwA0dYtV51IZvIiHtp4lLPwCEQYNFAQpaOpVDq8sQa
	 WezSseJhoMOXiEWLpK7/h7l4ITLeruD6yDO6Xu3970wtrmNMPTQTPyeaWVWFfBxO4r
	 OJO8U2RVAwX6SRxMas7rmwmYIvVMIsDgmbmEoJdWlzrapE/3ul4F/BwYLbu5Am9Qms
	 pp3wpWKauhRPjZzjksd7VYpbozia8E3MPx8G3ymDddnV3eOMQj+KDgEbyGJLP8IzNl
	 ctsX6b4litXeQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BbZAcLU5k_Jk; Wed, 14 Jun 2023 14:53:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 677AB6133B;
	Wed, 14 Jun 2023 14:53:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 677AB6133B
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 9DD0F1BF2B7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Jun 2023 14:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7547140201
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Jun 2023 14:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7547140201
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OXu4qQGFsuFa for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Jun 2023 14:53:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC96F40182
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC96F40182
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Jun 2023 14:53:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="387040586"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; d="scan'208";a="387040586"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 07:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782114900"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; d="scan'208";a="782114900"
Received: from pgardocx-mobl1.igk.intel.com ([10.237.95.41])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 07:53:16 -0700
From: Piotr Gardocki <piotrx.gardocki@intel.com>
To: netdev@vger.kernel.org
Date: Wed, 14 Jun 2023 16:53:02 +0200
Message-Id: <20230614145302.902301-4-piotrx.gardocki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614145302.902301-1-piotrx.gardocki@intel.com>
References: <20230614145302.902301-1-piotrx.gardocki@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686754398; x=1718290398;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aiy2x7WzA9Zv0AUyWsyvj/l73+iJBj7g8yRezUPEHv4=;
 b=bAo14M4MXD2jnWQ0gwRC/LrE1hOB4eOlS3vqK1Cmr4oAjjdEI3e6Zgpm
 EtW6TEGFce+nxEPchZ2nwP4M7DO27jpmXVVBjZLbDvYfsi1mtkYafbk/Y
 HiLipOcF4ajlF+GGmJm6R5js+AVliA4seiKqIDr+wtpOCGOpbpDXDTFCm
 lfmJZ8yQX18bnjXAwX/x3XtfMcJV/IulOsSGcqtaKI3Z0wkfvdosl5ZB/
 iHfTaGIdRndGR/p+lAbIlEhWlrdAEFrONlJn2lU36yf66kA2bYBXdFPF/
 TYfUQEer2V5ACcjdMn5m5/6RUeD6LwTy0mRTAF7Rj8AggYn3g7L8yDhdw
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bAo14M4M
Subject: [Intel-wired-lan] [PATCH net-next v3 3/3] ice: remove unnecessary
 check for old MAC == new MAC
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
Cc: pmenzel@molgen.mpg.de, przemyslaw.kitszel@intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 simon.horman@corigine.com, kuba@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The check has been moved to core. The ndo_set_mac_address callback
is not being called with new MAC address equal to the old one anymore.

Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index caafb12d9cc7..f0ba896a3f46 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5624,11 +5624,6 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
 	if (!is_valid_ether_addr(mac))
 		return -EADDRNOTAVAIL;
 
-	if (ether_addr_equal(netdev->dev_addr, mac)) {
-		netdev_dbg(netdev, "already using mac %pM\n", mac);
-		return 0;
-	}
-
 	if (test_bit(ICE_DOWN, pf->state) ||
 	    ice_is_reset_in_progress(pf->state)) {
 		netdev_err(netdev, "can't set mac %pM. device not ready\n",
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
