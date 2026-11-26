Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C447606A31E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OCS52xRq;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MDSthQ9V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A4766064A;
	Thu, 26 Nov 2026 13:19:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KY6cyiakPd5u; Thu, 26 Nov 2026 13:19:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE3DD6066C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795699180;
	b=BOVKlKgmMHB4U5vt0Z48PuT0cEmd4AV1lY3QHN8ag+bSUQaLKmxW34lItlGmPJfaKDPN
	 HhlZIRs+EgDIGfGc/vM0H+KuEmWRKljohSYWiqRSSONlKEjwxmDcYCrDV03RsGPBsRkqD
	 qhI5p80rsAB6hDEurhMkf0oe62LmA4PRCDg4QNbhmtLsx5sDYP8XIe00L6kwZRlYYCEbZ
	 zANQkgC+PqQEc4o6+lgYldIyOw26rz/1Jp25xyqooLB3xi9bA3caseis/8XHMkFJ19tbO
	 I+22I93dczYhRXQz8haXmZNSBBvxEXmkHQ1ppS83xRo1yAZjxtvIxhiseIDjbNlEo3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795699180;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pTcuGdieH3wdmNsxAhucJD705zfPtc7KwGkOtZ8IrRg=;
	b=URGr7VKOjZD2R836tMY0NGBCRFCjiOkM22X7NQvxMSCmHqv3S0tpnadjvF/Qvo8TPcTi
	 5dsle2E091Y17gKmhyqfzFWl3RaN9CsEo5ihevEPyaHuljgVURUEpjpvVIoBHLPkiAmyy
	 Uio0lvAoQawX/sB8uH7ncmsudLlBjayAvlhNa386jnNtBEHB88LoRxRfNwURPJ8/FJ4o0
	 dea4dvcZ8ljwmiLl35WkvP3lJ0mue2uxtlixIpQ0i+iP7/nEvBIxgiEXWQOdNPPcBF9IH
	 Gmbq9HuTaOQsfgI6zEZwIJGc7ZtVLS+2NaYNOZcBCdanqkkUq5qbUGeZ66LEciazDFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795699180;
	bh=pTcuGdieH3wdmNsxAhucJD705zfPtc7KwGkOtZ8IrRg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OCS52xRqwhtHzmHHrmJdpP00KvG46/sGAbFAEJORt8WmE0tQs4doeqlArK7edpe7m
	 psMlBubwXejJcKuDYJ6P1hzDsCYbLm2LW0sxB3S/w68Tv9l1kh7CghmWexRCYV/HVP
	 eyLBN5YDuOZPNAcRGuXbvxU9cRo6oVR5cAC2CAiT+2OKO8g9E7lgOXnuxeaYVex25g
	 4Dmx5aEA2rFKuwMcSRJmILxzIPUPmoNDn6BAbzyrlxglXgeCtFIzv2FFPXKJbOg+0L
	 fCf6sqOnl4QsSCctuCw1n5DkKb/Yk3crgFil4b3uVgiiS6FRgZXX6ngMltm1XUWVQh
	 jh9NBkiBEMHNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE3DD6066C;
	Thu, 26 Nov 2026 13:19:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E8EC1AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 13:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7061340538
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 13:19:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P92wPOLdXyKe for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 13:19:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF9AC40554
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MDSthQ9V
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF9AC40554
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795699178; x=1827235178; h=date:from:to:subject:message-id;
 bh=JswhfhJrhnJM6QPr6O8s79+uSH3MfBdDZmqvtPg5TN4=;
 b=MDSthQ9VSACy2AygKE/6iYd5yjX596L6PJBc+QLkuiC+ldoLp5Z+0vNx
 +2+dP7JUjphw5w0nAwYFuiq9TPcv03hGsVMvssIyRFPIqD4bNukmRLI5X
 hJKqCTEWrgJRyo8H2EBVopRNUjnfpLsBvb0WJNNtfvC34F2HuaH4hdAI4
 Jzw4c6SMdk7+GKsalzKQK5o4xUylfdNkbaxCfSDxJAixHteXzr4K0UquC
 A0Ni1vonYK7UENIJgR5Es8UTTat00zj7NVASyvpbmat/fF1trRU5RAA9h
 9dHW/y8PkTHYwDZTXdSxkIIR3JqPD6qbWqzB8bSuCclZ3DLE1G6YdD1W7 g==;
X-CSE-ConnectionGUID: aN9rfB92Tz+udAy12xvNbQ==
X-CSE-MsgGUID: +lrcDqV9SBmUMBc23bEYiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4616177"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4616177"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:19:37 -0800
X-CSE-ConnectionGUID: yHuGfrZ0RbWzjZYG1t10Tg==
X-CSE-MsgGUID: McyrkMEFSG2ZyU4UQRdcGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12175936"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 05:19:35 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWZNt-00000001UAE-16Kx;
 Thu, 26 Nov 2026 13:19:33 +0000
Date: Thu, 26 Nov 2026 21:18:41 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:200GbE] BUILD SUCCESS
 b59205c573db2068985baf41e6fa078a9d766c8d
Message-ID: <20261126211841.6X8LLZWg-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 200GbE
branch HEAD: b59205c573db2068985baf41e6fa078a9d766c8d  idpf: release PTP before freeing vports on the init task error path

elapsed time: 883m

configs tested: 461
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261125    gcc-8.5.0
alpha                 randconfig-2000-20261126    gcc-13.5.0
alpha                 randconfig-2001-20261125    gcc-8.5.0
alpha                 randconfig-2001-20261126    gcc-13.5.0
alpha                 randconfig-2200-20261126    gcc-9.5.0  smatch
alpha                randconfig-r2107-20261126    gcc-14     cocci
alpha                randconfig-r2108-20261126    gcc-11.5.0 cocci
alpha                randconfig-r2110-20261126    clang-24   cocci
alpha                randconfig-r2111-20261126    gcc-14.4.0 cocci
alpha                randconfig-r2308-20261126    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                      haps_hs_smp_defconfig    gcc-16.2.0
arc                         nsim_700_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261126    gcc-16.2.0
arc                   randconfig-1001-20261126    gcc-16.2.0
arc                   randconfig-2000-20261126    gcc-9.5.0
arc                   randconfig-2001-20261126    gcc-9.5.0
arc                   randconfig-2002-20261126    gcc-9.5.0
arc                   randconfig-2003-20261126    gcc-9.5.0
arc                   randconfig-2004-20261126    gcc-9.5.0
arc                   randconfig-2005-20261126    gcc-9.5.0
arc                   randconfig-2200-20261125    gcc-14.4.0 smatch
arc                   randconfig-2200-20261126    gcc-8.5.0  smatch
arc                  randconfig-r2103-20261125    gcc-11.5.0 cocci
arc                  randconfig-r2106-20261126    gcc-14     cocci
arc                  randconfig-r2106-20261126    gcc-14.4.0 cocci
arc                  randconfig-r2108-20261126    gcc-14     cocci
arc                  randconfig-r2110-20261126    gcc-14     cocci
arc                  randconfig-r2111-20261126    gcc-14     cocci
arc                  randconfig-r2303-20261126    gcc-14.4.0 sparse
arc                  randconfig-r2308-20261126    gcc-8.5.0  sparse
arc                  randconfig-r2309-20261126    gcc-12.5.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                             dove_defconfig    gcc-16.2.0
arm                             mmp2_defconfig    clang-24
arm                   randconfig-1000-20261126    gcc-16.2.0
arm                   randconfig-1001-20261126    gcc-16.2.0
arm                   randconfig-1002-20261126    gcc-16.2.0
arm                   randconfig-1003-20261126    gcc-16.2.0
arm                   randconfig-2000-20261125    clang-22
arm                   randconfig-2000-20261126    gcc-11.5.0
arm                   randconfig-2001-20261125    clang-22
arm                   randconfig-2001-20261126    gcc-11.5.0
arm                   randconfig-2002-20261125    clang-22
arm                   randconfig-2002-20261126    gcc-11.5.0
arm                   randconfig-2200-20261126    gcc-8.5.0  smatch
arm                  randconfig-r2100-20261126    gcc-8.5.0  cocci
arm                  randconfig-r2101-20261126    clang-24   cocci
arm                  randconfig-r2105-20261126    gcc-8.5.0  cocci
arm                  randconfig-r2107-20261126    gcc-14     cocci
arm                  randconfig-r2110-20261126    gcc-11.5.0 cocci
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261126    gcc-8.5.0
arm64                 randconfig-1001-20261126    gcc-8.5.0
arm64                 randconfig-1002-20261126    gcc-8.5.0
arm64                 randconfig-1003-20261126    gcc-8.5.0
arm64                 randconfig-2000-20261125    clang-22
arm64                 randconfig-2000-20261126    gcc-11.5.0
arm64                 randconfig-2001-20261125    clang-22
arm64                 randconfig-2001-20261126    gcc-11.5.0
arm64                 randconfig-2002-20261125    clang-22
arm64                 randconfig-2002-20261126    gcc-11.5.0
arm64                 randconfig-2200-20261126    clang-24   smatch
arm64                randconfig-r2103-20261126    clang-24   cocci
arm64                randconfig-r2109-20261126    gcc-14.4.0 cocci
arm64                randconfig-r2308-20261126    clang-24   sparse
arm64                randconfig-r2311-20261126    gcc-8.5.0  sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261126    gcc-8.5.0
csky                  randconfig-1001-20261126    gcc-8.5.0
csky                  randconfig-2000-20261125    gcc-14.4.0
csky                  randconfig-2000-20261126    gcc-13.5.0
csky                  randconfig-2001-20261125    gcc-14.4.0
csky                  randconfig-2001-20261126    gcc-13.5.0
csky                  randconfig-2200-20261126    gcc-13.5.0 smatch
csky                 randconfig-r2102-20261126    clang-24   cocci
csky                 randconfig-r2102-20261126    gcc-14.4.0 cocci
csky                 randconfig-r2103-20261126    clang-18   cocci
csky                 randconfig-r2103-20261126    gcc-8.5.0  cocci
csky                 randconfig-r2105-20261125    gcc-11.5.0 cocci
csky                 randconfig-r2305-20261125    gcc-12     sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261126    gcc-11.5.0
hexagon               randconfig-1001-20261126    gcc-11.5.0
hexagon               randconfig-2000-20261125    gcc-14.4.0
hexagon               randconfig-2000-20261126    gcc-13.5.0
hexagon               randconfig-2001-20261125    gcc-14.4.0
hexagon               randconfig-2001-20261126    gcc-13.5.0
hexagon               randconfig-2200-20261126    clang-17   smatch
hexagon              randconfig-r2104-20261126    gcc-8.5.0  cocci
hexagon              randconfig-r2307-20261126    gcc-12.5.0 sparse
hexagon              randconfig-r2309-20261126    gcc-8.5.0  sparse
hexagon              randconfig-r2311-20261126    clang-24   sparse
hexagon              randconfig-r2311-20261126    gcc-10.5.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261126    gcc-14
i386        buildonly-randconfig-1001-20261126    gcc-14
i386        buildonly-randconfig-1002-20261126    gcc-14
i386        buildonly-randconfig-1003-20261126    gcc-14
i386        buildonly-randconfig-1004-20261126    gcc-14
i386        buildonly-randconfig-1005-20261126    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261126    clang-22
i386                  randconfig-1001-20261126    clang-22
i386                  randconfig-1002-20261126    clang-22
i386                  randconfig-1003-20261126    clang-22
i386                  randconfig-1004-20261126    clang-22
i386                  randconfig-1005-20261126    clang-22
i386                  randconfig-1006-20261126    clang-22
i386                  randconfig-2000-20261125    gcc-14
i386                  randconfig-2000-20261126    clang-22
i386                  randconfig-2001-20261125    gcc-14
i386                  randconfig-2001-20261126    clang-22
i386                  randconfig-2002-20261125    gcc-14
i386                  randconfig-2002-20261126    clang-22
i386                  randconfig-2003-20261125    gcc-14
i386                  randconfig-2003-20261126    clang-22
i386                  randconfig-2004-20261125    gcc-14
i386                  randconfig-2004-20261126    clang-22
i386                  randconfig-2005-20261125    gcc-14
i386                  randconfig-2005-20261126    clang-22
i386                  randconfig-2100-20261126    clang-22   cocci
i386                  randconfig-2101-20261126    clang-22   cocci
i386                  randconfig-2102-20261126    clang-22   cocci
i386                  randconfig-2103-20261126    clang-22   cocci
i386                  randconfig-2104-20261126    clang-22   cocci
i386                  randconfig-2105-20261126    clang-22   cocci
i386                  randconfig-2200-20261126    gcc-14     smatch
i386                  randconfig-2300-20261126    gcc-14     sparse
i386                  randconfig-2301-20261126    gcc-14     sparse
i386                  randconfig-2302-20261126    gcc-14     sparse
i386                 randconfig-r2102-20261125    gcc-11.5.0 cocci
i386                 randconfig-r2110-20261126    gcc-14     cocci
i386                 randconfig-r2301-20261125    gcc-12     sparse
i386                 randconfig-r2303-20261125    gcc-12     sparse
i386                 randconfig-r2304-20261125    gcc-12     sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.2.0
loongarch             randconfig-1000-20261126    gcc-11.5.0
loongarch             randconfig-1001-20261126    gcc-11.5.0
loongarch             randconfig-2000-20261126    gcc-12.5.0
loongarch             randconfig-2001-20261126    gcc-12.5.0
loongarch             randconfig-2200-20261126    gcc-14.4.0 smatch
loongarch            randconfig-r2101-20261126    clang-24   cocci
loongarch            randconfig-r2102-20261126    clang-24   cocci
loongarch            randconfig-r2106-20261126    gcc-11.5.0 cocci
loongarch            randconfig-r2307-20261126    gcc-10.5.0 sparse
loongarch            randconfig-r2307-20261126    gcc-8.5.0  sparse
m68k                              alldefconfig    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    clang-24
m68k                  randconfig-2000-20261125    gcc-8.5.0
m68k                  randconfig-2000-20261126    gcc-13.5.0
m68k                  randconfig-2001-20261125    gcc-8.5.0
m68k                  randconfig-2001-20261126    gcc-13.5.0
m68k                 randconfig-r2101-20261125    gcc-11.5.0 cocci
m68k                 randconfig-r2104-20261126    gcc-8.5.0  cocci
m68k                 randconfig-r2105-20261126    gcc-14.4.0 cocci
m68k                 randconfig-r2109-20261126    clang-24   cocci
m68k                 randconfig-r2110-20261126    gcc-14.4.0 cocci
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261125    gcc-8.5.0
microblaze            randconfig-2000-20261126    gcc-13.5.0
microblaze            randconfig-2001-20261125    gcc-8.5.0
microblaze            randconfig-2001-20261126    gcc-13.5.0
microblaze            randconfig-2200-20261126    gcc-9.5.0  smatch
microblaze           randconfig-r2100-20261126    clang-24   cocci
microblaze           randconfig-r2102-20261126    gcc-8.5.0  cocci
microblaze           randconfig-r2105-20261126    gcc-8.5.0  cocci
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                          bigsur_defconfig    gcc-16.2.0
mips                      cu1000-neo_defconfig    clang-24
mips                       loongson3_defconfig    clang-24
mips                         omega2p_defconfig    clang-24
mips                  randconfig-2000-20261126    gcc-16.2.0
mips                  randconfig-2001-20261126    gcc-16.2.0
mips                  randconfig-2002-20261126    gcc-16.2.0
mips                  randconfig-2200-20261126    gcc-15.3.0 smatch
mips                 randconfig-r2101-20261126    gcc-8.5.0  cocci
mips                 randconfig-r2106-20261126    clang-24   cocci
mips                 randconfig-r2106-20261126    gcc-14     cocci
mips                 randconfig-r2108-20261126    clang-24   cocci
mips                 randconfig-r2109-20261126    clang-24   cocci
mips                 randconfig-r2300-20261125    gcc-12     sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261126    gcc-11.5.0
nios2                 randconfig-1001-20261126    gcc-11.5.0
nios2                 randconfig-2000-20261126    gcc-12.5.0
nios2                 randconfig-2001-20261126    gcc-12.5.0
nios2                 randconfig-2200-20261125    gcc-8.5.0  smatch
nios2                 randconfig-2200-20261126    gcc-9.5.0  smatch
nios2                randconfig-r2101-20261126    gcc-8.5.0  cocci
nios2                randconfig-r2104-20261126    clang-18   cocci
nios2                randconfig-r2106-20261126    clang-24   cocci
nios2                randconfig-r2107-20261126    gcc-14     cocci
nios2                randconfig-r2108-20261126    gcc-14.4.0 cocci
nios2                randconfig-r2310-20261126    gcc-10.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261126    gcc-16.2.0
openrisc              randconfig-2001-20261126    gcc-16.2.0
openrisc              randconfig-2002-20261126    gcc-16.2.0
openrisc              randconfig-2200-20261125    gcc-10.5.0 smatch
openrisc              randconfig-2200-20261126    gcc-9.5.0  smatch
openrisc             randconfig-r2100-20261126    gcc-14.4.0 cocci
openrisc             randconfig-r2304-20261126    gcc-14.4.0 sparse
openrisc             randconfig-r2310-20261126    clang-24   sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                randconfig-1000-20261126    gcc-13.5.0
parisc                randconfig-1001-20261126    gcc-13.5.0
parisc                randconfig-2000-20261126    gcc-12.5.0
parisc                randconfig-2001-20261126    gcc-12.5.0
parisc                randconfig-2200-20261126    gcc-15.3.0 smatch
parisc               randconfig-r2107-20261126    gcc-11.5.0 cocci
parisc               randconfig-r2111-20261126    clang-24   cocci
parisc               randconfig-r2111-20261126    gcc-14     cocci
parisc               randconfig-r2306-20261126    gcc-12.5.0 sparse
parisc               randconfig-r2307-20261126    gcc-8.5.0  sparse
parisc               randconfig-r2308-20261126    clang-24   sparse
parisc               randconfig-r2310-20261126    gcc-12.5.0 sparse
parisc               randconfig-r2310-20261126    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    gcc-16.2.0
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                       chrp32_defconfig    clang-24
powerpc                    currituck_defconfig    gcc-16.2.0
powerpc                    motionpro_defconfig    gcc-16.2.0
powerpc                      mpc5200_defconfig    clang-24
powerpc               randconfig-1000-20261126    gcc-13.5.0
powerpc               randconfig-1001-20261126    gcc-13.5.0
powerpc               randconfig-2000-20261126    clang-24
powerpc               randconfig-2001-20261126    clang-24
powerpc               randconfig-2002-20261126    clang-24
powerpc               randconfig-2200-20261126    clang-24   smatch
powerpc              randconfig-r2100-20261125    gcc-11.5.0 cocci
powerpc              randconfig-r2101-20261126    gcc-14.4.0 cocci
powerpc              randconfig-r2104-20261126    gcc-14.4.0 cocci
powerpc              randconfig-r2110-20261126    clang-24   cocci
powerpc              randconfig-r2302-20261126    gcc-14.4.0 sparse
powerpc              randconfig-r2306-20261126    gcc-8.5.0  sparse
powerpc              randconfig-r2308-20261126    gcc-10.5.0 sparse
powerpc                      stx_gp3_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261126    gcc-13.5.0
powerpc64             randconfig-1001-20261126    gcc-13.5.0
powerpc64             randconfig-2000-20261126    clang-24
powerpc64             randconfig-2001-20261126    clang-24
powerpc64             randconfig-2002-20261126    clang-24
powerpc64             randconfig-2200-20261126    clang-24   smatch
powerpc64            randconfig-r2101-20261126    clang-18   cocci
powerpc64            randconfig-r2104-20261126    clang-24   cocci
powerpc64            randconfig-r2306-20261126    clang-24   sparse
powerpc64            randconfig-r2307-20261126    clang-24   sparse
powerpc64            randconfig-r2309-20261126    gcc-10.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                     nommu_virt_defconfig    gcc-16.2.0
riscv                 randconfig-2000-20261126    gcc-10.5.0
riscv                 randconfig-2001-20261126    gcc-10.5.0
riscv                 randconfig-2002-20261126    gcc-10.5.0
riscv                 randconfig-2003-20261126    gcc-10.5.0
riscv                 randconfig-2004-20261126    gcc-10.5.0
riscv                 randconfig-2005-20261126    gcc-10.5.0
riscv                 randconfig-2200-20261126    gcc-8.5.0  smatch
riscv                randconfig-r2107-20261126    clang-24   cocci
riscv                randconfig-r2302-20261125    gcc-12     sparse
riscv                randconfig-r2309-20261126    clang-24   sparse
riscv                randconfig-r2309-20261126    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                  randconfig-2000-20261126    clang-24
s390                  randconfig-2001-20261126    clang-24
s390                  randconfig-2002-20261126    clang-24
s390                  randconfig-2003-20261126    clang-24
s390                  randconfig-2004-20261126    clang-24
s390                  randconfig-2005-20261126    clang-24
s390                  randconfig-2200-20261126    gcc-16.2.0 smatch
s390                 randconfig-r2102-20261126    gcc-8.5.0  cocci
s390                 randconfig-r2105-20261126    clang-24   cocci
s390                 randconfig-r2107-20261126    gcc-14.4.0 cocci
s390                 randconfig-r2108-20261126    gcc-14     cocci
s390                 randconfig-r2110-20261126    gcc-14     cocci
s390                 randconfig-r2300-20261126    gcc-14.4.0 sparse
s390                 randconfig-r2301-20261126    gcc-14.4.0 sparse
s390                 randconfig-r2310-20261126    clang-24   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-2000-20261125    gcc-14.4.0
sh                    randconfig-2000-20261126    gcc-9.5.0
sh                    randconfig-2001-20261125    gcc-14.4.0
sh                    randconfig-2001-20261126    gcc-9.5.0
sh                    randconfig-2002-20261125    gcc-14.4.0
sh                    randconfig-2002-20261126    gcc-9.5.0
sh                    randconfig-2003-20261125    gcc-14.4.0
sh                    randconfig-2003-20261126    gcc-9.5.0
sh                    randconfig-2004-20261125    gcc-14.4.0
sh                    randconfig-2004-20261126    gcc-9.5.0
sh                    randconfig-2005-20261125    gcc-14.4.0
sh                    randconfig-2005-20261126    gcc-9.5.0
sh                    randconfig-2200-20261126    gcc-16.2.0 smatch
sh                   randconfig-r2103-20261126    gcc-8.5.0  cocci
sh                   randconfig-r2104-20261125    gcc-11.5.0 cocci
sh                   randconfig-r2108-20261126    gcc-14     cocci
sh                   randconfig-r2311-20261126    gcc-8.5.0  sparse
sh                            se7712_defconfig    gcc-16.2.0
sh                            sh2007_defconfig    clang-24
sh                      sh7710voipgw_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                 randconfig-1000-20261126    clang-17
sparc                 randconfig-1001-20261126    clang-17
sparc                 randconfig-2000-20261126    gcc-8.5.0
sparc                 randconfig-2001-20261126    gcc-8.5.0
sparc                 randconfig-2200-20261126    gcc-13.5.0 smatch
sparc                randconfig-r2101-20261126    gcc-8.5.0  cocci
sparc                randconfig-r2102-20261126    clang-18   cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261126    clang-17
sparc64               randconfig-1001-20261126    clang-17
sparc64               randconfig-2000-20261126    gcc-8.5.0
sparc64               randconfig-2001-20261126    gcc-8.5.0
sparc64               randconfig-2200-20261125    gcc-15.3.0 smatch
sparc64               randconfig-2200-20261126    gcc-12.5.0 smatch
sparc64              randconfig-r2103-20261126    gcc-14.4.0 cocci
sparc64              randconfig-r2106-20261126    gcc-14     cocci
sparc64              randconfig-r2108-20261126    clang-24   cocci
sparc64              randconfig-r2305-20261126    gcc-14.4.0 sparse
sparc64              randconfig-r2306-20261126    clang-24   sparse
sparc64              randconfig-r2307-20261126    clang-24   sparse
sparc64              randconfig-r2309-20261126    clang-24   sparse
sparc64              randconfig-r2310-20261126    gcc-8.5.0  sparse
sparc64              randconfig-r2311-20261126    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261126    clang-17
um                    randconfig-1001-20261126    clang-17
um                    randconfig-2000-20261126    gcc-8.5.0
um                    randconfig-2001-20261126    gcc-8.5.0
um                    randconfig-2200-20261125    clang-17   smatch
um                    randconfig-2200-20261126    gcc-12     smatch
um                   randconfig-r2100-20261126    clang-24   cocci
um                   randconfig-r2105-20261126    clang-18   cocci
um                   randconfig-r2105-20261126    clang-24   cocci
um                   randconfig-r2109-20261126    gcc-14     cocci
um                   randconfig-r2306-20261126    gcc-8.5.0  sparse
um                   randconfig-r2308-20261126    gcc-12.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261126    clang-22
x86_64      buildonly-randconfig-1001-20261126    clang-22
x86_64      buildonly-randconfig-1002-20261126    clang-22
x86_64      buildonly-randconfig-1003-20261126    clang-22
x86_64      buildonly-randconfig-1004-20261126    clang-22
x86_64      buildonly-randconfig-1005-20261126    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261126    clang-22
x86_64                randconfig-1001-20261126    clang-22
x86_64                randconfig-1002-20261126    clang-22
x86_64                randconfig-1003-20261126    clang-22
x86_64                randconfig-1004-20261126    clang-22
x86_64                randconfig-1005-20261126    clang-22
x86_64                randconfig-2000-20261125    gcc-14
x86_64                randconfig-2000-20261126    clang-22
x86_64                randconfig-2001-20261125    gcc-14
x86_64                randconfig-2001-20261126    clang-22
x86_64                randconfig-2002-20261125    gcc-14
x86_64                randconfig-2002-20261126    clang-22
x86_64                randconfig-2003-20261125    gcc-14
x86_64                randconfig-2003-20261126    clang-22
x86_64                randconfig-2004-20261125    gcc-14
x86_64                randconfig-2004-20261126    clang-22
x86_64                randconfig-2005-20261125    gcc-14
x86_64                randconfig-2005-20261126    clang-22
x86_64                randconfig-2100-20261125    clang-22   cocci
x86_64                randconfig-2100-20261126    gcc-14     cocci
x86_64                randconfig-2101-20261125    clang-22   cocci
x86_64                randconfig-2101-20261126    gcc-14     cocci
x86_64                randconfig-2102-20261125    clang-22   cocci
x86_64                randconfig-2102-20261126    gcc-14     cocci
x86_64                randconfig-2103-20261125    clang-22   cocci
x86_64                randconfig-2103-20261126    gcc-14     cocci
x86_64                randconfig-2104-20261125    clang-22   cocci
x86_64                randconfig-2104-20261126    gcc-14     cocci
x86_64                randconfig-2105-20261125    clang-22   cocci
x86_64                randconfig-2105-20261126    gcc-14     cocci
x86_64                randconfig-2200-20261126    clang-22   smatch
x86_64                randconfig-2300-20261126    gcc-14     sparse
x86_64                randconfig-2301-20261126    gcc-14     sparse
x86_64                randconfig-2302-20261126    gcc-14     sparse
x86_64               randconfig-r2100-20261126    gcc-8.5.0  cocci
x86_64               randconfig-r2103-20261126    gcc-8.5.0  cocci
x86_64               randconfig-r2105-20261126    gcc-8.5.0  cocci
x86_64               randconfig-r2109-20261126    gcc-11.5.0 cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261126    clang-17
xtensa                randconfig-1001-20261126    clang-17
xtensa                randconfig-2000-20261125    gcc-14.4.0
xtensa                randconfig-2000-20261126    gcc-13.5.0
xtensa                randconfig-2001-20261125    gcc-14.4.0
xtensa                randconfig-2001-20261126    gcc-13.5.0
xtensa                randconfig-2200-20261126    gcc-11.5.0 smatch
xtensa               randconfig-r2100-20261126    clang-18   cocci
xtensa               randconfig-r2107-20261126    clang-24   cocci
xtensa               randconfig-r2111-20261126    clang-24   cocci
xtensa               randconfig-r2111-20261126    gcc-11.5.0 cocci
xtensa               randconfig-r2306-20261126    gcc-10.5.0 sparse
xtensa               randconfig-r2311-20261126    gcc-12.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
