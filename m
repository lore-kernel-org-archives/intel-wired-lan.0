Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F11CC4167B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Dec 2023 15:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C314D41625;
	Tue,  5 Dec 2023 15:34:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C314D41625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701790477;
	bh=62ddAf/k35UGe38LGkYayH/eanikdYmg8m6/qzWg2Q0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=LtqDuac3e/c639vkqfjmkKk0HbqMUEGyncxgQe6rP0ljTJF/710iAsAPhcw3BbQ7t
	 21V2V+FXppMQbYOyQ1u/4swgpEFjKLG0sGJR693mqm4tRknXZaJB++CdD+PWA42ywA
	 CsgSH5FClxL4cYuLjtHZdbwmUhEM9IKqpDret+umRFukBOjDx7RRenzg34rIcbjzmk
	 9nOrYReORYao6/S9DHYjx69wXscvDXPBa9S3IHFXjRzgF2bZlB/BRzXojmDddDIdrE
	 eRq8U5nbJqES6703lRvcHhFZh4/6MdQj9iKSVZXJZXAh5uVGPmXysCm++aXnsQ/xPy
	 IXi/iV0oGtQ+A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LYDCGVSQg-NP; Tue,  5 Dec 2023 15:34:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCCE7418F0;
	Tue,  5 Dec 2023 15:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCCE7418F0
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 07C4A1BF373
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 15:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE5884352A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 15:34:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE5884352A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ThaXu0P07fFI for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Dec 2023 15:34:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8187E43554
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 15:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8187E43554
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="378935329"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; d="scan'208";a="378935329"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 07:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894416023"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; d="scan'208";a="894416023"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga004.jf.intel.com with ESMTP; 05 Dec 2023 07:34:29 -0800
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id E64A1369E5;
 Tue,  5 Dec 2023 15:34:28 +0000 (GMT)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  5 Dec 2023 16:26:20 +0100
Message-Id: <20231205152620.568183-1-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701790473; x=1733326473;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xKJsV2VIWWPX82sNFGSjSZGbewbDfqmBqUfrgSjb0eQ=;
 b=K/gUXENWc+3fuRRD+41ETxc3lPGmnpz27RnXjnENS1YBeKdvbxxGjg9P
 xKuHmpfhEA3teFeeVp20IYnsHD2cjpacoSqhfodiMDRVS74e27n7j5auy
 3xFnqXIsfWqeHD6hHlZx9CBMR6DGuqCNQFAzsjQE7Jdb9DOvkB1/3TJ4Q
 D5tb9cZZOJQfpCNuhx3LLUjtDxXVW9nclkkt1cY3BakQVxFfaZJUxK9C3
 03L926CkUZoxlzBOvxeMkqbqxrs+34SHzoorhYSsb3aVmEIWHXdnhyyhp
 WNg5lGq05wkhZxjq9GHUBG09iV5gX5f49fF56tExHgXmISz4NIPtIrjTu
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=K/gUXENW
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: Do not get coalesce
 settings while in reset
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
Cc: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>, netdev@vger.kernel.org,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Getting coalesce settings while reset is in progress can cause NULL
pointer deference bug.
If under reset, abort get coalesce for ethtool.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bde9bc74f928..2d565cc484a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3747,6 +3747,9 @@ __ice_get_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 
+	if (ice_is_reset_in_progress(vsi->back->state))
+		return -EBUSY;
+
 	if (q_num < 0)
 		q_num = 0;
 
-- 
2.37.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
