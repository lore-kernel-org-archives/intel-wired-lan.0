Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9ECC00140
	for <intel-wired-lan@archiver.kernel.org>; Wed, 10 Aug 2022 14:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAB7C40150;
	Wed, 10 Aug 2022 14:22:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAB7C40150
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660141335;
	bh=5ePSwwPWgMCiEluLEj8P55YQ/Fg8ydZUytEnNWST08M=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9ugVqd/ge9XoQ4Zr6DLVlfJtx0LlmoxkbayxBxeIQHJdN6F1Msu9A8BF59ls9CwEK
	 tbG/fT9OfrhqrXfse0xNx+TaEToInoZ9ggNDNhvGYroeI0ZtGMabE/tx+kfMZPZPn5
	 njrLn7XJNUIfDJdcPRLwo0Fj7hHLnM0JXz8IhJKnkFCViWPh8dFpZJovPVt00jxKpV
	 waIgapsB3jl2/6pu243ZeHADkUuwcAZSaBZfRgTfszbt4JHLN0RAFLdc5r1T9RtKNQ
	 keunLKTs19t1Oe+DDgl3OFdQRhtvx1mVVSkzQifdkizoI5hMaP8LyKaAHjmmilHy1J
	 vD4vZVJQ6n2Bg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S4xmapg5amHY; Wed, 10 Aug 2022 14:22:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id CEEDD40C0D;
	Wed, 10 Aug 2022 14:22:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEEDD40C0D
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CD7A31BF488
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Aug 2022 14:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3A3840C0D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Aug 2022 14:22:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3A3840C0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Ys_fvVLgC59 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 10 Aug 2022 14:22:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E25AF40150
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E25AF40150
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Aug 2022 14:22:05 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="291882968"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; d="scan'208";a="291882968"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2022 07:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; d="scan'208";a="638121316"
Received: from gsiwik.igk.intel.com ([10.102.18.50])
 by orsmga001.jf.intel.com with ESMTP; 10 Aug 2022 07:22:05 -0700
From: Grzegorz Siwik <grzegorz.siwik@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 10 Aug 2022 16:21:53 +0200
Message-Id: <1660141315-216111-3-git-send-email-grzegorz.siwik@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1660141315-216111-1-git-send-email-grzegorz.siwik@intel.com>
References: <1660141315-216111-1-git-send-email-grzegorz.siwik@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660141325; x=1691677325;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=tdfPy750Bwa8VnuF1iY/taI8Jwt/ShtYtRgv/FfLNTM=;
 b=IuBPFaqIOSGa2qd9z1xgblEexdonA6fE3wWOwzUBn4bueBdJ3snIYO5P
 cFkIj+IoEXaAsq0xm9gIWQGnKlOEMkYX3/V4emiebORoikm1pduXHdooc
 UVYLa0H22F3YKagwr3GyigXVLxJ6kmrGh7/mqbXET+8frbQAZNz66k9ht
 wbnCSTBOkhGaJORqJCjVEnNJr0cFZtguQk4dLop7jOajyBm7lRVuppOQy
 M+OPMjZI3vaM2pUTIGzGz+YN7Uw93AQldPJL3C8GmMF1zbxfzeMbnf8nP
 fSwnVEPvKT+/L6mBznJ4cj2+vm6cIaJXATGjlUB5dcplcNIzkU4We2Yyk
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IuBPFaqI
Subject: [Intel-wired-lan] [PATCH net v3 2/4] ice: Ignore ERR_ALREADY_EXISTS
 when setting promisc mode
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
Cc: Grzegorz Siwik <grzegorz.siwik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Ignore EEXIST error when setting promiscuous mode.
This fix is needed because the driver could set promiscuous mode
when it still has not cleared properly.
Promiscuous mode could be set only once, so setting it second
time will be rejected.

Fixes: 5eda8afd6bcc ("ice: Add support for PF/VF promiscuous mode")
Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
Link: https://lore.kernel.org/all/CAK8fFZ7m-KR57M_rYX6xZN39K89O=LGooYkKsu6HKt0Bs+x6xQ@mail.gmail.com/
---
 v2: Fixed error message when setting same promiscuous mode
---
 v3: Fixed style issues, changed to return directly.
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 8a60052..0aa4871 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4428,7 +4428,7 @@ static u8 ice_determine_promisc_mask(struct ice_fltr_info *fi)
 		else
 			status = ice_set_vsi_promisc(hw, vsi_handle,
 						     promisc_mask, vlan_id);
-		if (status)
+		if (status && status != -EEXIST)
 			break;
 	}
 
-- 
1.8.3.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
