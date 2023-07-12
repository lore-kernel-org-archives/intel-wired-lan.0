Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EEBC0015E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Jul 2023 11:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33AB540136;
	Wed, 12 Jul 2023 11:05:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33AB540136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689159926;
	bh=0j1HrBDtVEht2A5VvZlr1T5nJRmXAs7PfOpovG3jQus=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tUuTV9KNqSv41GLcY6vKvYkJodLPcNi5hJUuxp4t7zNJiXyyRs5+nGI44+bEHux04
	 nP9g+Sazm9OkbP4qq6XfI/gj9tDbhxr2iGZ1OlPeNcRMSRREsGC22AeW8KMjyPoa/u
	 +eLJsnDVSHJUuCiwDVIEN3TvtHxGL0CgZ1yV1EXkzDC1LtJNuJEZkTvJE59eORd9ZE
	 lCmUYc2SxZ4HHoqRft/eCuTtWWkkvJnFxMvmxZsLJrgBeOAZWp1KIVZfeGXXPfHJ7T
	 bvbjf9G1tVGq6OJAvviBxpQAWISwXJ3pnwEM5OsOerzhCdh6y3UwEYcFIRYSFaW9EA
	 0kSeUwWi6qnMQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9HMMmHGak4qu; Wed, 12 Jul 2023 11:05:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 390CF4156F;
	Wed, 12 Jul 2023 11:05:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 390CF4156F
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 780B91BF97D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jul 2023 11:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFB5E60E44
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jul 2023 11:05:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFB5E60E44
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OyPzc7zrJDPR for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Jul 2023 11:05:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08C916110B
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08C916110B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jul 2023 11:05:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430993776"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430993776"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 04:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835093744"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835093744"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 04:04:58 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id F1A1F369EA;
 Wed, 12 Jul 2023 12:04:56 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 12 Jul 2023 13:03:28 +0200
Message-Id: <20230712110337.8030-4-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712110337.8030-1-wojciech.drewek@intel.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689159910; x=1720695910;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3RNXBz0b2iMk57rGPLkqp0DFMnsytIe6vyXi1AWbzvc=;
 b=cqCXsLi2wbk7QAZFd9be3hECSlxYLH+EAlqADKD5EYXDuL19hc3Rc2lw
 82lpKxD4C78USKUpi7ImqSQ0Nzw9OeU2Q+WB2gWKl5Ck2pGRea22oXMLC
 aAFXlnX43uaOO7dqTmmPKdWZMGVMreMValj7rUHwGGgAUW66gVOvHkOpp
 rurS2/rRHkICpCnIWWPa1+SQW+UTSnIThFdh+metPO3kkxwkifV9tjQA7
 qe+22DRdpiXuiUz6SJ/GtxEK4ftmZCQJuK9BviiTpkzGv5IM/aoNL71Oi
 c+ukCbJnW/pc2NCVbV7IQufqcO6gtvHh+Zb1QWy+YO0G1bs/GSl9zdAqr
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cqCXsLi2
Subject: [Intel-wired-lan] [PATCH iwl-next v6 03/12] ice: Don't tx before
 switchdev is fully configured
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org, vladbu@nvidia.com,
 kuba@kernel.org, simon.horman@corigine.com, dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

There is possibility that ice_eswitch_port_start_xmit might be
called while some resources are still not allocated which might
cause NULL pointer dereference. Fix this by checking if switchdev
configuration was finished.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index be5b22691f7c..15a4c148c28b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -331,6 +331,9 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	np = netdev_priv(netdev);
 	vsi = np->vsi;
 
+	if (!vsi || !ice_is_switchdev_running(vsi->back))
+		return NETDEV_TX_BUSY;
+
 	if (ice_is_reset_in_progress(vsi->back->state) ||
 	    test_bit(ICE_VF_DIS, vsi->back->state))
 		return NETDEV_TX_BUSY;
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
