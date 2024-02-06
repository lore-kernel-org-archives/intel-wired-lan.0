Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364F0C48286
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Feb 2024 03:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAD5741BB1;
	Tue,  6 Feb 2024 03:46:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAD5741BB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707191173;
	bh=i6Jx8vFnHk4jldH7NvS9zuOMZSMqAU7U2lSWjVjOe9A=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nmDvhCJpt8MRwYRF7UcoVui40sxtBdS/M7gm71oIst7DiCZdfDYZBRFJdlevdF17w
	 nZFX/Z0O2SJxOJaz/N06fvGjFf/w57mv8+HboyIFt4QvpB8dZYQBwMYDhDWh9NX6Ql
	 JxFflt2BNd5ms63/CMCz20uKWumi9k98pkKISK4U9BN8UnIIFAh0W05MoYBIsuLCR3
	 y5NuAKuo7aGGO5bfOZPEt7YNrjnJMN9MFHgThH+1slJDmlR43qKYivIG4b9dz8c9a8
	 gcEr6/etWau+zKm7/jvsdMCfO276nQ3L0gknfN+gmmjqG/WjUh63WUiO+Ja0lKtyln
	 v8Gg7+xX+WAig==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yQ_-0skW953Y; Tue,  6 Feb 2024 03:46:12 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32BD341D65;
	Tue,  6 Feb 2024 03:46:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32BD341D65
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id C93731BF215
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 03:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C395F81F99
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 03:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZrdgcEUbCDP for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Feb 2024 03:45:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=alan.brady@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 204E981F97
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 204E981F97
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 204E981F97
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 03:45:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824869"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="824869"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2024 19:38:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="5653951"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
 by orviesa004.jf.intel.com with ESMTP; 05 Feb 2024 19:38:41 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  5 Feb 2024 19:38:03 -0800
Message-Id: <20240206033804.1198416-10-alan.brady@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240206033804.1198416-1-alan.brady@intel.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707191147; x=1738727147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fOVVUq5YZJbAxXbHKCRGKfuq9aA9oE8cegWnzCKCG58=;
 b=Dv5RAOPEUGCD1R5eITbZnHF/evQdYg+8n+Uh5K/Y5fzzDC0UE/HzsLRq
 SXSr1Xd35I06gwJg69q8TyHG4k4ZVJlYvuzPDL+lhoZTojf8DGSCl87PD
 OwSJuaWu9fWLaUdwZRCGE3M5BQhOQ1MED/0pgIBfy+3yp16A/FO8TVs1E
 BAFtubyZhhQAo1kFha6ms8G9FfJn6eU98xeP1AlWrIAgx3607FlqEZN14
 RO6fpq/rIDRRqzVP6iow6fEJO5lagZafo3clZmlJ7ekll+9C1mnW9P5Tz
 4N4YNGAM6xmsAT1IIJyeXSa/qDjgXEK+ZpDXTzKkiEUuyySaaXH5kvvHT
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Dv5RAOPE
Subject: [Intel-wired-lan] [PATCH v4 09/10 iwl-next] idpf: fix minor
 controlq issues
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
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, Alan Brady <alan.brady@intel.com>,
 przemyslaw.kitszel@intel.com, igor.bagnucki@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

While we're here improving virtchnl we can include two minor fixes for
the lower level ctrlq flow.

This adds a memory barrier to idpf_post_rx_buffs before we update tail
on the controlq.  We should make sure our writes have had a chance to
finish before we tell HW it can touch them.

This also removes some defensive programming in idpf_ctrlq_recv. The
caller should not be using a num_q_msg value of zero or more than the
ring size and it's their responsibility to call functions sanely.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_controlq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index c7f43d2fcd13..4849590a5591 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -516,6 +516,8 @@ int idpf_ctlq_post_rx_buffs(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 			/* Wrap to end of end ring since current ntp is 0 */
 			cq->next_to_post = cq->ring_size - 1;
 
+		dma_wmb();
+
 		wr32(hw, cq->reg.tail, cq->next_to_post);
 	}
 
@@ -546,11 +548,6 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 	int err = 0;
 	u16 i;
 
-	if (*num_q_msg == 0)
-		return 0;
-	else if (*num_q_msg > cq->ring_size)
-		return -EBADR;
-
 	/* take the lock before we start messing with the ring */
 	mutex_lock(&cq->cq_lock);
 
-- 
2.40.1

