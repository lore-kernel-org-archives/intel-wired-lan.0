Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BD1C61DA4
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Mar 2023 20:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA27B60D89;
	Mon, 13 Mar 2023 20:36:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA27B60D89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678739782;
	bh=47JVm7bAOb/LeWM/pov1F/ncAbfq419Kr5Q/ElEYKTw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=G/bNRZzaP3yIDo7jPl3k4QN/3n/K7104/uilZ9AMaTaF6ZzLlv1J+/jpHg2o+CrT9
	 /ZUmci88i290UJ9HdkztWJ4pLSVzh04u2dJXZEwD5XP0OsLBgaaEWABZNtf18gnLMI
	 i3Bo6Js0mk/QjCO7PzI3tsCHxmRG8KITw+GV5TlvymTFTFLnLyoKmhfvChCGZVWVh4
	 CC7H5QH1SCO8Z22EbYu9a2d82vUBwuaRtnT1vSI08VM0XOcFmsKC/pZ0DRm94JyZfR
	 jSpj5g2mzbuD8GCHTC2VOuH+fObCXpD84rh08ZiMbB60qrlzIUVzJ2Inkyzc5ckxR2
	 YxlbvZer+phyg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sRywE89y42ER; Mon, 13 Mar 2023 20:36:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B3A760E26;
	Mon, 13 Mar 2023 20:36:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B3A760E26
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 306601BF2C2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Mar 2023 20:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11ACB41726
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Mar 2023 20:36:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11ACB41726
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S5TgDnpBU4V0 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Mar 2023 20:36:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 528924173A
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 528924173A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Mar 2023 20:36:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="364913215"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; d="scan'208";a="364913215"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 13:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="747732593"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; d="scan'208";a="747732593"
Received: from jbrandeb-saw1.jf.intel.com ([10.166.28.102])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 13:36:17 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 13 Mar 2023 13:36:06 -0700
Message-Id: <20230313203608.1680781-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1678739779; x=1710275779;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yiPGkCuFWRqq/+zZ5dNxbmWknE3r/SafDd8SL+ywou8=;
 b=ex2+MNAZtOcD/RCBcmyDnZy+FbcBR9cumGkWy++wUYkTaWVjIFluAkmq
 YOCWPqz2YDJ30UxawPRxI8fTbqPy4jKkQIoiAgAK8C3JO7k70CrPewhAX
 EOXDqpykYKJBj+MhLL74I/TUBDpi9VePJPzKx3B1ZJRmJTwcJ1n1iFpz6
 no+hzV5+y7/2VCyuFzrvmg6vbVV0MaMXX/DxU6ZPCqCa/wIDd/dog+U30
 UfH+VvkTjAldP1W0VcEKin40b7NsVwhI5U8mjLJrP9nCmd5DnfsWgMC9r
 Bf3bHJWzzk+H/NMGKNYRZouXFSedG4iuB+oCKOmyyKM18UL54569aZdH4
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ex2+MNAZ
Subject: [Intel-wired-lan] [PATCH net v1 0/2] ice_switch fixes series
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fix a couple of small issues, with a small refactor to correctly handle
a possible misconfiguration of RDMA filters, and some trivial function
headers that didn't match their function.

Brett Creeley (1):
  ice: Fix ice_cfg_rdma_fltr() to only update relevant fields

Jesse Brandeburg (1):
  ice: fix W=1 headers mismatch

 drivers/net/ethernet/intel/ice/ice_switch.c   | 26 ++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  1 +
 3 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
