Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E10C43334
	for <intel-wired-lan@archiver.kernel.org>; Wed, 13 Jul 2022 13:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6042E83E70;
	Wed, 13 Jul 2022 13:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6042E83E70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657719704;
	bh=51H6Vt1rCTAcwV33XRZheFfvbm3wQ/QBTpMHMsgnoHE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XB28q7Pwil5WEeejwFvJTYs8MRvq3L+UpnK3O73slH3BFsHGSRjp1bDaD6AB9jelM
	 8+CSLmofBqCiFpfqpJfeOmrFB71PamdHI+TQU5mF2aJgR06TkliIKs63HIt4SQVf3b
	 Qdn43hW8+imMW75wgpIcRtkbOrwLeBIO+h1WtI0mq8MEL+oCawPdn3jpYqpd9sDsJL
	 mkqH4t82K1bT5iYjDqIn/9Ah36BXx8ouYKBvcDwJ9EC0jsopc/1Wm6dO7TOmhzfP6Z
	 Px4VrXM0Ijs3kBDkjvK89pAb2jFXxRmGJGivbVwvMHzHi9FeTNyzgJJzQNs/svvWOZ
	 b0abqn3UGEgZQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z65epjMuuWPW; Wed, 13 Jul 2022 13:41:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73EC283E80;
	Wed, 13 Jul 2022 13:41:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73EC283E80
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 37B481BF376
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Jul 2022 13:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1017741BDE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Jul 2022 13:41:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1017741BDE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gifNd4-4S8D6 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 13 Jul 2022 13:41:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF9704220F
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF9704220F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Jul 2022 13:41:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="282765820"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; d="scan'208";a="282765820"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2022 06:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; d="scan'208";a="685160977"
Received: from amlin-018-068.igk.intel.com (HELO localhost.igk.intel.com)
 ([10.102.18.68])
 by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2022 06:41:38 -0700
From: Mateusz Palczewski <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 13 Jul 2022 15:41:20 +0200
Message-Id: <20220713134120.2745317-1-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657719700; x=1689255700;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dB3dSwl3KE4NJJj7bl1AXG5tJdqzkVSfmyYYpKx9M/0=;
 b=AgSdKYo5Waox9o7jd5Lnh9+UY0TXr5enhGJRyKYHbvMU4ecyi+smt/12
 g7Rm/e6acMTGG5sSrQSB5W/glohaIN1gZKVwOBIUaVjRojCwoElSm1IH9
 SAbn4Y3EtKmjlgh+Oox8OpNWeH7lq8XhwBQLty/diiNRJp2yk29nr/5Au
 3CquoyEUE9F8jIfxdm2QD1abDZr05VKQBp/wNtLSHc32YFj/3++rF+0Kx
 xj4NdpUgjqGFfCfpFx7LhfvQRJL0FxObf/i79FYz4mOkoaBvGMLhmGfst
 cZ95sLEn8pQBHdKvVe3ZL3vFdQfNnv9t2Xuidn4TIqFwU/BYOh10hHzXh
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AgSdKYo5
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix to stop tx_timeout
 recovery if GLOBR fails
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

When a tx_timeout fires, the PF attempts to recover by incrementally
resetting.  First we try a PFR, then CORER and finally a GLOBR.  If the
GLOBR fails, then we keep hitting the tx_timeout and incrementing the
recovery level and issuing dmesgs, which is both annoying to the user
and accomplishes nothing.

If the GLOBR fails, then we're pretty much totally hosed, and there's
not much else we can do to recover, so this makes it such that we just
kill the VSI and stop hitting the tx_timeout in such a case.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Alan Brady <alan.brady@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 685556e968f2..71a8e1698ed4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -384,7 +384,9 @@ static void i40e_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 		set_bit(__I40E_GLOBAL_RESET_REQUESTED, pf->state);
 		break;
 	default:
-		netdev_err(netdev, "tx_timeout recovery unsuccessful\n");
+		netdev_err(netdev, "tx_timeout recovery unsuccessful, device is in non-recoverable state.\n");
+		set_bit(__I40E_DOWN_REQUESTED, pf->state);
+		set_bit(__I40E_VSI_DOWN_REQUESTED, vsi->state);
 		break;
 	}
 
-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
