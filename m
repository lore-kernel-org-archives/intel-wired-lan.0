Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE01DC4828F
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Feb 2024 15:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7108D60A97;
	Thu,  1 Feb 2024 15:42:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7108D60A97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706802149;
	bh=5OHPML0YuzxUvh1mScoK5x/euRiHUCD1cnE2zK5rbNg=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=6VipVEPzteY/Cv79Yuyz9+n2VjDyhwAepgPK3ASklmgkJGIyRvP6stZaOmwBkU2dA
	 n8wI85OPIRbhy3uixWo7dOcfFTnVGnU3zwlGyQEwmLwxA8vGnmMK+lPo7TX288P3Av
	 dB1nglakdgpuTCcutrYRkrQbU7LCF1SIMeaAjCbHZJYpPy8oLrIH/z/ddUg1FvUIKC
	 gPZObI68Uy/TbPjvlk4GRLqmxzok9dovgxqPj9u/5nFq9dqxOoUvJaaVBxhwIameL8
	 vaj720HpklUmsBG4N702HIK6bZ/1oWhph5GB/43OvZQg2XfL2yNjDCumJefcK4SdGm
	 Vn4zSIRz7oZ+A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZrQmGbLU_kzF; Thu,  1 Feb 2024 15:42:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9463E60B27;
	Thu,  1 Feb 2024 15:42:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9463E60B27
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 3A2CB1BF97E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Feb 2024 15:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FA2B84684
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Feb 2024 15:42:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FA2B84684
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Dgw1LOafL2Z for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Feb 2024 15:42:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4575C84682
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Feb 2024 15:42:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4575C84682
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10551401"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="10551401"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2024 07:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4418153"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmviesa005.fm.intel.com with ESMTP; 01 Feb 2024 07:42:24 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  1 Feb 2024 16:42:17 +0100
Message-Id: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706802146; x=1738338146;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=swRC6Qpw9COjx9ww7MlyDqVkOihziKADyrjB65UCFoc=;
 b=OqH96o2CKtD8HZva8Kb5PjJUV9fQdV/0wMKR15wmg7lp1MgIoeAwTnQa
 BVDrx/yWo5Dr98TVeUTfbXnI/zTv13X0/3QlB4VvwwPe03+T5SkDAroGN
 FYrYxAc//kkV+iFV4KgDRh+XBxnCiGPmx61ag1uRpDzjhNaPPgXhnPfv+
 z8GhLWmOB2FBGaZAan+VQ9OUnaDjqlRWmBZ3SFp0JcajlT/T+ZaqZToV0
 Hu8s4VU1vlYqK77nwY2xHW1I1p9FsZ6x0fhRRAYWQq4MdcIRbrNH2rMkf
 w2dNM8p6SkVx9Kwm73bde6cVnHZHU2WTR2tUbVSwHCF/3pC4F8rvKAKg+
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OqH96o2C
Subject: [Intel-wired-lan] [PATCH iwl-net 0/2] i40e: disable XDP Tx queues
 on ifdown
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
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 anthony.l.nguyen@intel.com, magnus.karlsson@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Seth reported in [0] that he couldn't get traffic flowing again after a
round of down/up of interface that i40e driver manages.

While looking into fixing Tx disable timeout issue I also noticed that
there is a doubled function call on Rx side which is fixed in patch 1.

Thanks,
Maciej

[0]: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/

Maciej Fijalkowski (2):
  i40e: avoid double calling i40e_pf_rxq_wait()
  i40e: take into account XDP Tx queues when stopping rings

 drivers/net/ethernet/intel/i40e/i40e_main.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

-- 
2.34.1

