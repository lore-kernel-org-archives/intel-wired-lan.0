Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11373C00140
	for <intel-wired-lan@archiver.kernel.org>; Tue,  2 Aug 2022 11:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C9FB405C8;
	Tue,  2 Aug 2022 11:52:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C9FB405C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659441155;
	bh=jxgyLzYFTIrDHx3VzCGoUgbxur8XP8z5XeG5XU83Uy0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=tuGavCb1SpkOUme7kDENdHJBZ7iF927xEpj0Qw//nqvprT/r8gMIMPPhcFkf1E/jt
	 pxdx+9GLVajcFSqKz8lYoDRPYtgXJ8mOdPrbixXxwkBJ1jYvniVQ6NLtemBiF5p/Y7
	 kGesu6HErbIqKGki0xMtiyE/dDZZ3DqgT2boU+3BpFnaAEvx5gFQ+yuFby4bHesNu0
	 yOtGPGKRTovX3uC09c2onY5VmV5UJefWi/AcF5iLgbXzX4UCzALUsE96ttIkxY1QH+
	 nM4E+DcMsHIjvsYFBnUTjsC8IrjCeKMhqLLUDP+Emi/XrZ0hGD5G9A3DnNle/tJm1N
	 qHhOPCxFbqx+Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lv7kvTQ0IZfu; Tue,  2 Aug 2022 11:52:34 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F9C3405CD;
	Tue,  2 Aug 2022 11:52:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F9C3405CD
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id ADF211BF409
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 11:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94612405C8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 11:52:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94612405C8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SxOUlbmXNqdS for <intel-wired-lan@lists.osuosl.org>;
 Tue,  2 Aug 2022 11:52:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6CD0401C9
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6CD0401C9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 11:52:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="289401279"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; d="scan'208";a="289401279"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2022 04:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; d="scan'208";a="728807626"
Received: from amlin-018-068.igk.intel.com (HELO localhost.igk.intel.com)
 ([10.102.18.68])
 by orsmga004.jf.intel.com with ESMTP; 02 Aug 2022 04:52:29 -0700
From: Mateusz Palczewski <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  2 Aug 2022 13:51:40 +0200
Message-Id: <20220802115142.65176-1-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659441151; x=1690977151;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qUFnl17N6vr42UK8aBdofZpU0qkaNBGFU6K7ZQZnpt8=;
 b=GBK30eWU68B5RKTrfy1P7cyZtsDRW60LDX54LfLL2sL+oa4v/X6LLK7a
 w2YlODLujpirR6UzMftbGzRXfWdnkn3yI1Igo3g2gnesK2FKuCPIvGEC1
 POp/Xs27e/cFtZ/DDXgIK8Ckz41baK3YpEjOLmsC8KRXTlhc5XVhhhTlq
 bpBUOfsRaneVqIYR65sFdM8iND1rmYt2NS/wj29hCBILiejFmujtjhEwa
 vLkk+AE4TEY5rfFtqi/1kGDzFTf0UzYXoylDFu0vECLUdqw5CkiKhEHaE
 976Hk0VNP0rWJiENJHvxZ7wI2ksbrcZZ9ICZ1yBmJtZgkVGAKGuC8SKIZ
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GBK30eWU
Subject: [Intel-wired-lan] [PATCH net v2 0/2] iavf: Fix close path on
 shutdown and remove in iavf driver.
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
Cc: Slawomir Laba <slawomirx.laba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Slawomir Laba <slawomirx.laba@intel.com>

iavf_shutdown was implementing an incomplete version
of iavf_remove. It misses several calls to the kernel like
iavf_free_misc_irq, iavf_reset_interrupt_capability, iounmap
that might break the system on reboot or hibernation.

Fix a deadlock introduced by commit
974578017fc1f ("iavf: Add waiting so the port is initialized in remove")
due to race condition between iavf_shutdown and iavf_remove, where
iavf_remove stucks forever in while loop since iavf_shutdown already
set __IAVF_REMOVE adapter state.

---
 v2: Fixed author
---

SlawomirX Laba (2):
  iavf: Fix shutdown pci callback to match the remove one
  iavf: Fix race condition between iavf_shutdown and iavf_remove

 drivers/net/ethernet/intel/iavf/iavf_main.c | 59 ++++++++-------------
 1 file changed, 22 insertions(+), 37 deletions(-)

-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
