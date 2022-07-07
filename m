Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E07ECCA480
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 Jul 2022 10:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B39DA4198B;
	Thu,  7 Jul 2022 10:21:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B39DA4198B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657189260;
	bh=zBU0vy6c2gPeoLArOWlSCnzwhyKTDihUgnpQ7pO69Ts=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qi4GO9tIp/7DWMIWKFkn1zBzWZ5zExT4NzQF4NP9nWsQY4kFL9U4PiFFJ+WJ0YBCN
	 F9u1tDmIbQb9poQ9w/T5iRGy34k/x/X0/boCFrOu6pIjeQEdMA7YBNpYn59lGmIvM2
	 Jc+fF1weTz3pPFEbctncjbXBEXZJVO61WEa7wjUSrZ75QSVO5pcXIzGIF71gb8PzSP
	 QCknVL8ZxwJEevkaJHNweOmjtEc8uhhTuGuy5xx10G2P6aanBO8KrsyQqZ+7NMfbA6
	 g/FFZPH33fKJRHAOClERRUh0LI3Dw+5myeKa1gOclg+qBlaBwa3YO1CldaSzWERKPh
	 K2o5z30J8vklg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6eareYmyb-W; Thu,  7 Jul 2022 10:20:59 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BB6A418B8;
	Thu,  7 Jul 2022 10:20:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BB6A418B8
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 5BC511BF86C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Jul 2022 10:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36500418B8
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Jul 2022 10:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36500418B8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D-XAcL6N4VEw for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 Jul 2022 10:20:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DDB641886
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DDB641886
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Jul 2022 10:20:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="267018033"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; d="scan'208";a="267018033"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 03:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; d="scan'208";a="696458251"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2022 03:20:52 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  7 Jul 2022 12:20:43 +0200
Message-Id: <20220707102044.48775-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220707102044.48775-1-maciej.fijalkowski@intel.com>
References: <20220707102044.48775-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657189255; x=1688725255;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z6ljLWA0yJSS4H0haMyrgiV+yyrZhPfOehdjPjrbD2U=;
 b=JJJGOnEr+tGrtXuRK4iB8Cqupf/OUFWlveB3hsBbqSnz8JsrItrG+0jl
 mqbc+epOKfC4/jYtgcuArXlVtft4834iL0x+SGTtVLur5gxonNdmzId3a
 giVqr9i0H/NhhzbneciAha78ITqp+w2U7wqllUMh7dgQWN1LfG+pUTmmo
 Xc6ymGqq0ZHGV8d+xO/U9uGrxlC1YMVmEur+yDsVCJS2FAUA/dSaJzNsC
 ctjKm27oY2qkcl2DQPOkzIv2lnIfpKMf7egIjaUnzmjFKT2GgeEOQqnxX
 AhRmS9lAlAS7de/8qlwNq92AmLWK8IRNO1rS/9KWK4XBE1H6msB/NrYrS
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JJJGOnEr
Subject: [Intel-wired-lan] [PATCH intel-net 2/2] ice: do not setup vlan for
 loopback VSI
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
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com,
 anatolii.gerasymenko@intel.com, kuba@kernel.org, davem@davemloft.net,
 magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Currently loopback test is failiing due to the error returned from
ice_vsi_vlan_setup(). Skip calling it when preparing loopback VSI.

Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c1ac2f746714..2c40873bcbb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6010,10 +6010,12 @@ int ice_vsi_cfg(struct ice_vsi *vsi)
 	if (vsi->netdev) {
 		ice_set_rx_mode(vsi->netdev);
 
-		err = ice_vsi_vlan_setup(vsi);
+		if (vsi->type != ICE_VSI_LB) {
+			err = ice_vsi_vlan_setup(vsi);
 
-		if (err)
-			return err;
+			if (err)
+				return err;
+		}
 	}
 	ice_vsi_cfg_dcb_rings(vsi);
 
-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
