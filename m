Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1FFC6FA86
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Sep 2022 08:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C3CF41B45;
	Thu,  8 Sep 2022 08:07:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C3CF41B45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1662624449;
	bh=/kdG6YzSUrPAsl+jZopruPa7+9ljgI7Fw6QuNP6hnNA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Uw32vqD7ZgeNhH77y7hjqN4rKCkrIRu2Li7BfW40Fo3xIrV9A8+Oy2ypyvjQ/RW91
	 zWODUcy0Wq2cKhb0OMJsEFyuFcmiqAYhLUiC+Qp2isAAIBp97cgMebfXU4ZE6wGsu5
	 2Y26Ru+svgJmZET8o5V9eV3p0j/+RSfoJ/Xk9AIR6Z7KILedmHBRq8HhANclfo8+d7
	 WIGjqVAkB8rLFqlanIhDOo/8kus3Y7/u3fGJ/tPN11jbXyYSrAbDlJbiLYYiXmmTOG
	 6gNqBDISPMOePVjdcbe0ttRa8Rrh7TSLLXS+mVnsqbRQ/8kwoJF+7GuCua8u4Cdjnq
	 9fzpBJiyxMgmg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hs7j6EJx0wHU; Thu,  8 Sep 2022 08:07:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BEC041B4F;
	Thu,  8 Sep 2022 08:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4BEC041B4F
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 6CC2D1BF5A9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Sep 2022 08:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4736E60ADA
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Sep 2022 08:07:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4736E60ADA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 96dkYVIN77gR for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Sep 2022 08:07:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10E6E60AC2
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 10E6E60AC2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Sep 2022 08:07:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="383398240"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; d="scan'208";a="383398240"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2022 01:07:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; d="scan'208";a="676582057"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmsmga008.fm.intel.com with ESMTP; 08 Sep 2022 01:07:18 -0700
From: Kamil Maziarz <kamil.maziarz@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  8 Sep 2022 10:07:10 +0200
Message-Id: <20220908080710.716153-1-kamil.maziarz@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662624440; x=1694160440;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8Qy4yZ8FMcj0gHsQiO1px5ZQs1rqUlWVpj1thsX48Eo=;
 b=k/69uG1nJHHQkuZCVvmKkICoWMK2gzyPCRonUDq+WsgtCl1ODWrzDsTP
 7nAskmLfnax1vAgqaMZoZh01VkdPXGQ5z5YfF4Bi5eRyQO1YBJvoy5KDH
 60GCFW4q4JilWTiJMoZ2/IxshQu7y+Vbx3gtYxu+4FhPbloBbx06D6z+J
 y4mJcsNqGTgXmTn/rT8IjT486Z7BS8qtrah0b5zykRQm4VrGCy2q5Qg5o
 2AujSGoeJPPr5CEC7hnbDLBL6zno0VpKUUW2QHNfojQIHdE5SYXv0vt3l
 ddBXneYea/Dmwkcpyj76Rem6duw9/Nm/Hj5DZyLSt3cbbqtlnKCcnRxDa
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=k/69uG1n
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add appropriate error
 message logged for incorrect duplex setting
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
Cc: Alicja Kowalska <alicjax.kowalska@intel.com>,
 Kamil Maziarz <kamil.maziarz@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Alicja Kowalska <alicjax.kowalska@intel.com>

Nothing logged in dmesg for attempting to set incorrect duplex.
Add appropriate error message logged for incorrect duplex setting.

Signed-off-by: Alicja Kowalska <alicjax.kowalska@intel.com>
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 7e75706f76db..2299f13cea77 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1287,8 +1287,10 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	 * trying to set something that we do not support.
 	 */
 	if (memcmp(&copy_ks.base, &safe_ks.base,
-		   sizeof(struct ethtool_link_settings)))
+		   sizeof(struct ethtool_link_settings))) {
+		netdev_err(netdev, "Only speed and autoneg are supported.\n");
 		return -EOPNOTSUPP;
+	}
 
 	while (test_and_set_bit(__I40E_CONFIG_BUSY, pf->state)) {
 		timeout--;
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
