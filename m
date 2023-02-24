Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F8EC61DA3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Feb 2023 15:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDE3740903;
	Fri, 24 Feb 2023 15:10:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDE3740903
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677251402;
	bh=bgEa1GIDzltIQlW2zRzRd977exMSu13YuNwtw6cgCEI=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cxF5p6k8iP/7u2iteTSvMLvlLJRdQ6/WPtB37YI5ZcOntOGjEsWCshm+6SaZz05ZY
	 dL6+GqESp7qeDt+846QvtyrDRrCtwNA/BbD2DFF2godTYsRZuHsvWOy6vujI+a6Bq/
	 KNPOvTc1yzcJEP0e5TASab2OyWjoOgJcxluES35SNKYxzyWQTM161NiBCSlGJ1toQZ
	 dUEU+O6rhZQUJizv0TfTIHRJoo/7CGuKTATjMZEi24NVJ0zfoYpJxubSUYLTOlTQG5
	 RokEDCxDfDDgFfdUKPbor0w7iE7r6J4uf7KSkjE5xASwpZnHNQTexUKIVoH1xDkKMo
	 H7Cpb7uOvCD/g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQgsn-K9Dr_T; Fri, 24 Feb 2023 15:10:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95B024090B;
	Fri, 24 Feb 2023 15:10:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95B024090B
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 68E9A1BF282
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Feb 2023 15:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E8CB82155
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Feb 2023 15:10:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E8CB82155
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wyua1vvyBTfU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Feb 2023 15:09:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8323682154
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8323682154
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Feb 2023 15:09:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="419726380"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; d="scan'208";a="419726380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2023 07:09:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="782386925"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; d="scan'208";a="782386925"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 24 Feb 2023 07:09:54 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pVZhp-0002UH-22;
 Fri, 24 Feb 2023 15:09:53 +0000
Date: Fri, 24 Feb 2023 23:09:53 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63f8d341.ALH3zKHaZo3LMzzk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677251399; x=1708787399;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=fEgy+BjTW/y88v6y8KzKPtBmV7zQ4dLtltPzVQrFanU=;
 b=CDs98fJSlsGfHJZne+uGdt9LL8yGKxXEAhOYtmlkXXEjOWBxsC1ue9X3
 UKr3Ph7uguGY855tZs/FVCMtQw9VI+HevGoeoCnbZ6aHeqQRhPJr3e+9V
 oRWZ3ddlAeJzpg2PQNYYL4gA+MtaomHdbegm70RsLWaxlWTz6tyOY0j4P
 RhiTFUU7mtK9MSZr8agQcElBeyfrsXhRRCvhoiVL21O1/4jednnuOkCt6
 BQvEarU7DokWEXzZvi8qrigF39APTZ7Ty1bJ4haBQY4tWk12l5lLD4T19
 th945znDXRmx4GJbhLJSlG4AegcffYE9wWxataVUmhEk/CyKTkFYcVztA
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CDs98fJS
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 4481cc4cca9e0f785ed201f3ef0abcfe0e3ca3f9
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 4481cc4cca9e0f785ed201f3ef0abcfe0e3ca3f9  ice: remove unnecessary CONFIG_ICE_GNSS

elapsed time: 818m

configs tested: 19
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
clang                                   alpha   defconfig
gcc                                       arc   defconfig
gcc                                       arm   defconfig
gcc                                     arm64   defconfig
gcc                                      csky   defconfig
gcc                                      i386   defconfig
gcc                                      ia64   defconfig
gcc                                 loongarch   defconfig
gcc                                      m68k   defconfig
gcc                                     nios2   defconfig
gcc                                    parisc   defconfig
gcc                                  parisc64   defconfig
gcc                                     riscv   defconfig
gcc                                     riscv   rv32_defconfig
gcc                                      s390   defconfig
gcc                                     sparc   defconfig
gcc                                        um   i386_defconfig
gcc                                        um   x86_64_defconfig
gcc                                    x86_64   defconfig
gcc                                                  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
