Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75854C43334
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Jun 2022 13:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 121FE83F14;
	Tue, 28 Jun 2022 13:43:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 121FE83F14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656423805;
	bh=/mYp7aXNzaHkl5w9sSxWjSrMmSIfq6NCzsOgyKvxgqU=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=374FjYGXRlXMcMuhcMcU7FsPrplNl0/4ZeUxQnvyTUPJYVmyJZABsEBn30+xNo/Wd
	 66a6MjUu8fN/mEiSq+qP4EJrGPiRnfJNuRFjVeZoXt6a/oQ91OpfaVDJivwiBVKgR6
	 2EB+EM2702sIwsbU8e7iYKGPUCbnZiMtjCstXJsoZbpIrjEHUh7tPEMqmUMFZyxEZ/
	 0FA14yT3W0UwZJuhOYLSYoS3S4eDk95lunog7slb28YBWJE+UrLA21gN6jqFX57SCt
	 AhwYlOKmHNlCVoIwTVKJ58/tUjKvC+Yxr3JNQ/Yxye3h05r8mmKq5kSIa0Ttbt63nr
	 LhVDYXntwGn7w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E7c5DrRSrGYj; Tue, 28 Jun 2022 13:43:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22FA083F47;
	Tue, 28 Jun 2022 13:43:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22FA083F47
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id AADFF1BF28B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jun 2022 13:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83D674087E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jun 2022 13:43:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83D674087E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J40KCvHe-JoU for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Jun 2022 13:43:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CACE4006B
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CACE4006B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jun 2022 13:43:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="261546594"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="261546594"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 06:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="836678159"
Received: from amlin-018-068.igk.intel.com (HELO localhost.igk.intel.com)
 ([10.102.18.68])
 by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2022 06:43:20 -0700
From: "Palczewski, Mateusz" <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 28 Jun 2022 15:43:08 +0200
Message-Id: <20220628134308.706012-1-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656423801; x=1687959801;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KTQ6RpJFT/xHNddEGva2SgecDnp2aFY4bDOlMbhM3ac=;
 b=gyXwVHHAbW28I/Gt50CIySHJ/Ujh29hociG3K1lqF6UyLOHl2HrJ79z0
 68676PaYCT5oroovPL68O4qBJSduZ2p3cqYKOz0jZ1Uwuv1HRyIpssyN0
 HE61/dDn9mV0wlAcDacNDes9haZ8fnzL2b0yIa2aa/Cv9KyRiBQUu+QQl
 j3SRvVpu3aYLMa7UAywgVK36gP6gwRNso6G3zGXwZyvn6o8uxRilRmkrX
 WtomZTU4YbjXv2OE+5GMWjAOXtNvY8SDRCrYChyDxzf3zTf2C3H5Wjwto
 F1jj7hdr8vPLOYU3y1oVzr/BWXMPcQxsYmHDAjre4aCHwGV3O3uOWIIAq
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gyXwVHHA
Subject: [Intel-wired-lan] [PATCH net v2 0/3] iavf: Fix pending DMA
 allocations while released from device
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

Fix multiple issues that can arise, when VF cannot configure ASQ/ARQ properly.
Failing to do so can lead to driver hang, null ptr dereference and possible
DMA allocations leak.

---
 v2: Add comment to make code more understandable
---

Przemyslaw Patynowski (3):
  iavf: Fix reset error handling
  iavf: Fix NULL pointer dereference in iavf_get_link_ksettings
  iavf: Fix adminq error handling

 drivers/net/ethernet/intel/iavf/iavf_adminq.c  | 15 +++++++++++++--
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  6 ++++++
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 14 ++++++++++----
 3 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
