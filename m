Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C432C433EF
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Jul 2022 17:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D7F740184;
	Tue, 12 Jul 2022 17:37:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D7F740184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657647477;
	bh=Bjndl0NTUoIwHUmH7x03ifMJ3rgdhtam3GL/wmIMO/c=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=PEQggBOjjEGCw1J60QUkb3NUhGBflfeyu7g7yoLOvirxaj+QnuQO5rG4EUWQ2oCrA
	 6iulK475w/RKCHZpaRczyCKD5S8+kXOxwR5VafoHuPzXsXrW4Dy48lv2VjQQJChH/E
	 Iv6AMYgzmbEpMG5FawTQIAZrOVqqOZDpueLZMvLan1ntIoltKWKVP2u4JDp2qNv0RN
	 TtGk6+gAlfNpvlgS/Ol3+TMwCgSKXWDobCVIApvQiyLaFQ99hAeo9QT4rpzKH6496I
	 5Z6FWldGLSJZsA1XK6t6kSVadN2JCNqyUzLZemngx94YMKx5i149BP8r9OjOK7yzwI
	 tncNaVutPzu+Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JIqeNXRoQCGr; Tue, 12 Jul 2022 17:37:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F2A54074E;
	Tue, 12 Jul 2022 17:37:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F2A54074E
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 5C78C1BF846
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Jul 2022 15:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4482D82BE5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Jul 2022 15:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4482D82BE5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oCO25G-dOTgg for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Jul 2022 15:17:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 693A680AF5
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 693A680AF5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Jul 2022 15:17:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="283715967"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; d="scan'208";a="283715967"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2022 08:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; d="scan'208";a="737519980"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.232.13])
 by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2022 08:17:44 -0700
From: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 12 Jul 2022 11:14:22 -0400
Message-Id: <20220712151422.50489-1-benjamin.mikailenko@intel.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 12 Jul 2022 17:37:54 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657639065; x=1689175065;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fBV6mJf5Yz0LRPIUWk1vdQOSZVbSoRHrKLYg96E83R8=;
 b=OI8tFciogonBTmzMWozoqPWlk6Nt5M9zJgXV2oyNhOLrWvce72s6l0pp
 bZGAADPYMDBTq9KXSqnj8An8n9aEzDyq87QmHIv/ugsgmrHimXlQyGI6s
 qJiDUMrSxnx3602vNf5n+iCp2JbA0cHOkbxWMpbuNZOz8yfHHvQM3dHeT
 W8sdayDGd7OBr1JPqyoR2shZ9bBABy2Glfi2o80sbd07tTSE4KtOn7FxX
 aCvg2G100IFsaM4WhIg7/BrwFPD7bTOLD3otkkcM5XADAz6W5DmibqpWk
 0NDvBThPk4Xe+0PE6Sbp83q2x0bkMProZN+phhI5qYbPKoIfDfq1K1wHh
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OI8tFcio
Subject: [Intel-wired-lan] [PATCH net v4] ice: Fix VSI configuration for
 non-PF network devices
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
Cc: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This fixes an issue for a failing loopback test
"ethtool -t offline ethx". Do not set Rx mode
and VSI VLAN for non-PF network devices.

Fixes: c7f2c42b80ed ("ice: Fix a few null pointer dereference issues")
Signed-off-by: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 752bd8a10495..e4ae67da5b77 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6010,7 +6010,7 @@ int ice_vsi_cfg(struct ice_vsi *vsi)
 {
 	int err;
 
-	if (vsi->netdev) {
+	if (vsi->netdev && vsi->type == ICE_VSI_PF) {
 		ice_set_rx_mode(vsi->netdev);
 
 		err = ice_vsi_vlan_setup(vsi);
-- 
2.34.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
