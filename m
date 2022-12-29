Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C433DC4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Dec 2022 19:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A4CF60758;
	Thu, 29 Dec 2022 19:06:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A4CF60758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1672340784;
	bh=s/d+rJpw6qDe5bOKbftOMLdRekacbcuxosATec820YY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=6MaU+GZjwb3pf/grch1bcJqQPxwKmx7mpHlA+05WKhmx3h6UQ4W1zi673B8bCskjw
	 KPb7N2v397etMNRImF+E3HdootLF4sjg+XQbj/jFPm+PI6U6sU126otfGjprS5de47
	 AbSdHME8k6AqHMJDMBMC35o1MNg4w6J4Vpn607l1Og4heOYG1uFw6TeuutcmAAIyH7
	 QThhYkkZoidofe7u1hwb80x29gCfmhKsg22UgvYX4xJWIu9aC9+CEUHZp61ay8p3T0
	 Ty56AP9mNWknqDJWBlcGC5boBOznn0T6pWCEW1j6tGFvHBF/Ieg6BCJR+LWmesFQH4
	 BhFTg55QWLRJA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlBXmOeQUjQt; Thu, 29 Dec 2022 19:06:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60E0B60768;
	Thu, 29 Dec 2022 19:06:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60E0B60768
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 705581BF2B4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Dec 2022 19:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45C85400DD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Dec 2022 19:06:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45C85400DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eYz0k7DOUJTX for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Dec 2022 19:06:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D27F1400BF
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D27F1400BF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Dec 2022 19:06:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="321172311"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; d="scan'208";a="321172311"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Dec 2022 11:06:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="684288841"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; d="scan'208";a="684288841"
Received: from unknown (HELO anguy11-linux.jf.intel.com) ([10.166.241.12])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Dec 2022 11:06:18 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	benjamin.mikailenko@intel.com
Date: Thu, 29 Dec 2022 11:05:20 -0800
Message-Id: <20221229190520.69402-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672340779; x=1703876779;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ErHw2rh2vxIA/caS5UpmM5kmHQN8Os4kw9AtEztwFeg=;
 b=U6xoX4xpTPxlGfI0cv+ohlkF/i9hKsptVNDFR9cYCpOrQEGRrYQsE8Qk
 FYsBbYiR8pvJvKtjHmx9XklX/+D6V06UZFCcLf5hsqT/dB77oeulFWKT9
 evurIeIFZu6mCiBHXGvjS09B3P7ZBACXJW2uWy6I4n2q+VGdiRRoZ9BFD
 CPDvHwWlj/XlQlIP6apc+38ef56EkURzlUpacjKcX7JL1tUw07NlV3Ne2
 y50B0/21bTDKxokn8RU5sXUuN0szoRD39zSPBiJvRxqTpIcNs1LXA1JsO
 7cLWYKfj9pcd+cgqyZLEDmlhAEvEeBTZJasbyG9+q6MaOc8RGaTaE4KcH
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=U6xoX4xp
Subject: [Intel-wired-lan] [PATCH net-next] ice: Remove excess space
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

smatch reports inconsistent indenting due to an extra space; remove it to
resolve the issue.

smatch warnings:
drivers/net/ethernet/intel/ice/ice_lib.c:1673 ice_vsi_alloc_ring_stats() warn: inconsistent indenting

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8e9243635496..716ade0e43a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -434,7 +434,7 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
 			if (!ring_stats)
 				goto err_out;
 
-			 WRITE_ONCE(rx_ring_stats[i], ring_stats);
+			WRITE_ONCE(rx_ring_stats[i], ring_stats);
 		}
 
 		ring->ring_stats = ring_stats;
-- 
2.35.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
