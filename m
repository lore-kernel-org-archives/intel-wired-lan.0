Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376AE606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=joYqlhmu;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f8MQgnEp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BB1B409B0;
	Thu, 26 Nov 2026 12:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eOCpi9w5UJSb; Thu, 26 Nov 2026 12:30:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4F4DD40919
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696237;
	b=P9AqJG2/T02m/b2t+pm5eeVReeRWwjTJJN/+p43iakIxEDWG/nPgidh1e1pEpI99ME6U
	 R9mO43PHzY9eTr2EP7fpfttTY8fTeoSYGAn8lRyx39onY2f1wylWo9V9pBR8zixJIrE5K
	 CKfjxxi4s/9mOULEkm7IhD2SxQsakdVoebHhLkrIbzCTcxSC8zoYlsmcYJ4AFyUsrca7I
	 c7E40tt4fk01nOtp7/wqvlGlC5sY+m7mKglh3aGgsKoIAV7CQcYY0vUiFfgsAD8f4klJ4
	 SpGPyB5xgLsx/7GQSoMrXjl3aQK9+NeCsa8e5op0SqsOljNYd7+eWt8nCM8MIcC93Og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696237;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kMy49RoR5yYN3JFIqLXgy/SXChyWh5WvYnXte7sgT+I=;
	b=Mr7/Be6RyOLt/KJstHanIsrmIDbFFI6+663D8Ooqoh8fb+THT8wtl6diEP/uNDTitY8V
	 3SIxePwsIVT0iUOZ1Fj6r+rz1qkLQ3kIyeUzIB6jIymIMo4X08XwGsaRwmsXMSXHGU2TF
	 zO7u/DhK5LXqM8nAZZX/vBshkEOkotYpRxSvbPQFFlXOtlYfLAKT3N5xWsXl4WVqmbmMn
	 gI2x+lTLu/IQb287rBGRiLlqAbJrIhxWOxHMnnC53zmIrBfik2QTIPrkttmroa61l9Hop
	 jp4YYc9qfwUfIX/t1p9UPC7JUk1a6XGNnChrpNPfpP0YpAyEJ4/Z4etUtDuF8AygE8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795696237;
	bh=kMy49RoR5yYN3JFIqLXgy/SXChyWh5WvYnXte7sgT+I=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=joYqlhmuy8/7iNJ1g/Lj77IoHHJsFAyD1B9k6AUHmq1/FhObs13j+UCRCPsLvxymY
	 +eu378p4ErVUU72c1T6OT8pY7nSPtNudUNBvlxyfwZd+IBaaHmKuwNy6HmUOgbDqUv
	 grgIMVSwzz6mnECJQezbey1opZbYUbySF8iAcC/7Yhqn4cqhT6tbK5JpikvzU26BPk
	 mCpXmZ5P7YVk7fm7gyhIVpHAYW9Bejs0V+28vlBCzh6p1nTAN6Xj2vqQu9sNRe2D9Y
	 xqtJ51SxNNF53L38d5g1oJnkP/ahA/7y0JOfWKyi2lN6cMCYZ2LbpeaCd0cttFpjl2
	 B0Q9eiSoYPt2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F4DD40919;
	Thu, 26 Nov 2026 12:30:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A70F7325
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82D6740474
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TDi22atVxvry for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 12:30:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ADA8C40116
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=f8MQgnEp
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADA8C40116
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795696234; x=1827232234; h=date:from:to:subject:message-id;
 bh=5B6u3MhZ7aurRUa6QPpWgbS2ot6M63H9e4gY+5tJvD8=;
 b=f8MQgnEpf2GNbTPPJg/0d+fHZJEFJJzgDXRHITZyzRd+lJlleGerMR5c
 M/SzN+6BdHaf4Rrtuva0NhOKOLdvJ1mJjkkbMaf5X4Ojfqfmh+SjIr63R
 FyC5E1TJ0IhetfXU9kWV2hlzD+lTJ9sD6MHzJuFmfc4NU/m5CHrXjIc9J
 JN3Qohl/JxMsRcpAVoM6yBjAU1/qHQhkJz08zpZJ5WnzJbOlg4MtkJg8j
 s8ZC8ZOuovwD0vEEynA5PNQa0PtgpG0XzRYEgUUpMPDY/G5Ayd2lM1/L7
 +1bH5MRARZo/YdGgLAdhN2wizOl/iYG3noCQ1zwqdm8Oec4lVf98MdNoA A==;
X-CSE-ConnectionGUID: NAd57jkdRhCf1LJLZvKrrA==
X-CSE-MsgGUID: dQfppH1ZQdmbNee5Gwr53Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4690213"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4690213"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 04:30:33 -0800
X-CSE-ConnectionGUID: lDuviLP4T9qxGPa7xOnmlQ==
X-CSE-MsgGUID: Yb5OjSqYQsyYm8G7cK8XlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12460018"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 26 Nov 2026 04:30:30 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWYcO-00000001U5F-0Rlx;
 Thu, 26 Nov 2026 12:30:28 +0000
Date: Thu, 26 Nov 2026 20:29:38 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:100GbE] BUILD SUCCESS
 e20f88c4f08bc9dba09c48ddc9806015f79fb20b
Message-ID: <20261126202938.BIbTVVJF-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: e20f88c4f08bc9dba09c48ddc9806015f79fb20b  ncsi: Initialize vid in set_one_vid() to handle concurrent VLAN removal

elapsed time: 1050m

configs tested: 607
configs skipped: 10

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
alpha                 randconfig-2200-20261125    gcc-10.5.0 smatch
alpha                 randconfig-2200-20261126    gcc-9.5.0  smatch
alpha                randconfig-r2100-20261125    gcc-9.5.0  cocci
alpha                randconfig-r2100-20261126    gcc-10.5.0 cocci
alpha                randconfig-r2107-20261126    gcc-14     cocci
alpha                randconfig-r2108-20261126    gcc-11.5.0 cocci
alpha                randconfig-r2111-20261126    gcc-14.4.0 cocci
alpha                randconfig-r2301-20261125    gcc-11.5.0 sparse
alpha                randconfig-r2305-20261125    gcc-12     sparse
alpha                randconfig-r2309-20261125    gcc-8.5.0  sparse
alpha                randconfig-r2310-20261126    gcc-10.5.0 sparse
alpha                randconfig-r2311-20261125    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                      haps_hs_smp_defconfig    gcc-16.2.0
arc                         nsim_700_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261126    gcc-16.2.0
arc                   randconfig-1001-20261126    gcc-16.2.0
arc                   randconfig-2000-20261125    gcc-10.5.0
arc                   randconfig-2000-20261126    gcc-9.5.0
arc                   randconfig-2001-20261125    gcc-10.5.0
arc                   randconfig-2001-20261126    gcc-9.5.0
arc                   randconfig-2002-20261125    gcc-10.5.0
arc                   randconfig-2002-20261126    gcc-9.5.0
arc                   randconfig-2003-20261125    gcc-10.5.0
arc                   randconfig-2003-20261126    gcc-9.5.0
arc                   randconfig-2004-20261125    gcc-10.5.0
arc                   randconfig-2004-20261126    gcc-9.5.0
arc                   randconfig-2005-20261125    gcc-10.5.0
arc                   randconfig-2005-20261126    gcc-9.5.0
arc                   randconfig-2200-20261125    gcc-14.4.0 smatch
arc                   randconfig-2200-20261126    gcc-8.5.0  smatch
arc                  randconfig-r2104-20261125    gcc-9.5.0  cocci
arc                  randconfig-r2106-20261126    gcc-14     cocci
arc                  randconfig-r2106-20261126    gcc-14.4.0 cocci
arc                  randconfig-r2108-20261126    gcc-14     cocci
arc                  randconfig-r2111-20261125    gcc-10.5.0 cocci
arc                  randconfig-r2303-20261126    gcc-14.4.0 sparse
arc                  randconfig-r2304-20261125    gcc-11.5.0 sparse
arc                  randconfig-r2306-20261126    clang-18   sparse
arc                  randconfig-r2308-20261126    gcc-8.5.0  sparse
arc                  randconfig-r2309-20261126    gcc-12.5.0 sparse
arm                               alldefconfig    gcc-16.2.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                             dove_defconfig    gcc-16.2.0
arm                            omap1_defconfig    gcc-16.2.0
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
arm                   randconfig-2200-20261125    clang-21   smatch
arm                   randconfig-2200-20261126    gcc-8.5.0  smatch
arm                  randconfig-r2100-20261126    gcc-8.5.0  cocci
arm                  randconfig-r2101-20261126    clang-24   cocci
arm                  randconfig-r2105-20261125    gcc-8.5.0  cocci
arm                  randconfig-r2105-20261126    gcc-8.5.0  cocci
arm                  randconfig-r2106-20261126    clang-24   cocci
arm                  randconfig-r2107-20261125    gcc-9.5.0  cocci
arm                  randconfig-r2107-20261126    gcc-14     cocci
arm                  randconfig-r2110-20261125    gcc-10.5.0 cocci
arm                  randconfig-r2110-20261126    gcc-11.5.0 cocci
arm                  randconfig-r2304-20261126    clang-22   sparse
arm                  randconfig-r2306-20261125    gcc-8.5.0  sparse
arm                  randconfig-r2311-20261126    clang-18   sparse
arm                            u8500_defconfig    gcc-16.2.0
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
arm64                 randconfig-2200-20261125    gcc-13.5.0 smatch
arm64                 randconfig-2200-20261126    clang-24   smatch
arm64                randconfig-r2103-20261126    clang-24   cocci
arm64                randconfig-r2104-20261125    gcc-8.5.0  cocci
arm64                randconfig-r2109-20261126    gcc-14.4.0 cocci
arm64                randconfig-r2301-20261126    clang-22   sparse
arm64                randconfig-r2302-20261126    clang-22   sparse
arm64                randconfig-r2310-20261126    clang-18   sparse
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
csky                  randconfig-2200-20261125    gcc-16.2.0 smatch
csky                  randconfig-2200-20261126    gcc-13.5.0 smatch
csky                 randconfig-r2102-20261126    clang-24   cocci
csky                 randconfig-r2103-20261126    clang-18   cocci
csky                 randconfig-r2103-20261126    gcc-8.5.0  cocci
csky                 randconfig-r2108-20261125    gcc-9.5.0  cocci
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261126    gcc-11.5.0
hexagon               randconfig-1001-20261126    gcc-11.5.0
hexagon               randconfig-2000-20261125    gcc-14.4.0
hexagon               randconfig-2000-20261126    gcc-13.5.0
hexagon               randconfig-2001-20261125    gcc-14.4.0
hexagon               randconfig-2001-20261126    gcc-13.5.0
hexagon               randconfig-2200-20261125    clang-17   smatch
hexagon               randconfig-2200-20261126    clang-17   smatch
hexagon              randconfig-r2103-20261126    gcc-10.5.0 cocci
hexagon              randconfig-r2104-20261126    gcc-8.5.0  cocci
hexagon              randconfig-r2109-20261126    clang-24   cocci
hexagon              randconfig-r2302-20261126    gcc-11.5.0 sparse
hexagon              randconfig-r2307-20261126    gcc-12.5.0 sparse
hexagon              randconfig-r2309-20261126    clang-18   sparse
hexagon              randconfig-r2309-20261126    gcc-8.5.0  sparse
hexagon              randconfig-r2311-20261125    gcc-15.3.0 sparse
hexagon              randconfig-r2311-20261126    clang-24   sparse
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
i386                  randconfig-2100-20261125    clang-22   cocci
i386                  randconfig-2100-20261126    clang-22   cocci
i386                  randconfig-2101-20261125    clang-22   cocci
i386                  randconfig-2101-20261126    clang-22   cocci
i386                  randconfig-2102-20261125    clang-22   cocci
i386                  randconfig-2102-20261126    clang-22   cocci
i386                  randconfig-2103-20261125    clang-22   cocci
i386                  randconfig-2103-20261126    clang-22   cocci
i386                  randconfig-2104-20261125    clang-22   cocci
i386                  randconfig-2104-20261126    clang-22   cocci
i386                  randconfig-2105-20261125    clang-22   cocci
i386                  randconfig-2105-20261126    clang-22   cocci
i386                  randconfig-2200-20261125    clang-22   smatch
i386                  randconfig-2200-20261126    gcc-14     smatch
i386                  randconfig-2300-20261125    clang-22   sparse
i386                  randconfig-2300-20261126    gcc-14     sparse
i386                  randconfig-2301-20261125    clang-22   sparse
i386                  randconfig-2301-20261126    gcc-14     sparse
i386                  randconfig-2302-20261125    clang-22   sparse
i386                  randconfig-2302-20261126    gcc-14     sparse
i386                 randconfig-r2106-20261125    gcc-14     cocci
i386                 randconfig-r2108-20261125    gcc-10.5.0 cocci
i386                 randconfig-r2109-20261126    clang-22   cocci
i386                 randconfig-r2110-20261126    gcc-14     cocci
i386                 randconfig-r2111-20261126    clang-24   cocci
i386                 randconfig-r2304-20261125    gcc-12     sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.2.0
loongarch             randconfig-1000-20261126    gcc-11.5.0
loongarch             randconfig-1001-20261126    gcc-11.5.0
loongarch             randconfig-2000-20261125    clang-19
loongarch             randconfig-2000-20261126    gcc-12.5.0
loongarch             randconfig-2001-20261125    clang-19
loongarch             randconfig-2001-20261126    gcc-12.5.0
loongarch             randconfig-2200-20261125    clang-18   smatch
loongarch             randconfig-2200-20261126    gcc-14.4.0 smatch
loongarch            randconfig-r2101-20261126    clang-24   cocci
loongarch            randconfig-r2102-20261126    clang-24   cocci
loongarch            randconfig-r2106-20261125    gcc-14     cocci
loongarch            randconfig-r2106-20261125    gcc-9.5.0  cocci
loongarch            randconfig-r2106-20261126    gcc-11.5.0 cocci
loongarch            randconfig-r2300-20261126    clang-22   sparse
loongarch            randconfig-r2307-20261126    gcc-10.5.0 sparse
m68k                              alldefconfig    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                  randconfig-2000-20261125    gcc-8.5.0
m68k                  randconfig-2000-20261126    gcc-13.5.0
m68k                  randconfig-2001-20261125    gcc-8.5.0
m68k                  randconfig-2001-20261126    gcc-13.5.0
m68k                  randconfig-2200-20261125    gcc-15.3.0 smatch
m68k                 randconfig-r2104-20261126    gcc-10.5.0 cocci
m68k                 randconfig-r2104-20261126    gcc-8.5.0  cocci
m68k                 randconfig-r2109-20261126    clang-24   cocci
m68k                 randconfig-r2110-20261126    gcc-14.4.0 cocci
m68k                 randconfig-r2309-20261125    gcc-15.3.0 sparse
m68k                 randconfig-r2309-20261126    clang-18   sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261125    gcc-8.5.0
microblaze            randconfig-2000-20261126    gcc-13.5.0
microblaze            randconfig-2001-20261125    gcc-8.5.0
microblaze            randconfig-2001-20261126    gcc-13.5.0
microblaze            randconfig-2200-20261125    gcc-8.5.0  smatch
microblaze            randconfig-2200-20261126    gcc-9.5.0  smatch
microblaze           randconfig-r2100-20261126    clang-24   cocci
microblaze           randconfig-r2102-20261126    gcc-8.5.0  cocci
microblaze           randconfig-r2107-20261126    clang-24   cocci
microblaze           randconfig-r2109-20261125    gcc-9.5.0  cocci
microblaze           randconfig-r2301-20261125    gcc-12     sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                          bigsur_defconfig    gcc-16.2.0
mips                         maltaup_defconfig    clang-20
mips                  randconfig-2000-20261125    gcc-16.2.0
mips                  randconfig-2000-20261126    gcc-16.2.0
mips                  randconfig-2001-20261125    gcc-16.2.0
mips                  randconfig-2001-20261126    gcc-16.2.0
mips                  randconfig-2002-20261125    gcc-16.2.0
mips                  randconfig-2002-20261126    gcc-16.2.0
mips                  randconfig-2200-20261125    clang-24   smatch
mips                 randconfig-r2106-20261125    gcc-10.5.0 cocci
mips                 randconfig-r2109-20261125    gcc-14     cocci
mips                 randconfig-r2110-20261125    gcc-9.5.0  cocci
mips                 randconfig-r2111-20261125    gcc-14     cocci
mips                 randconfig-r2302-20261125    gcc-12     sparse
mips                    sb1250_swarm_defconfig    clang-20
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261126    gcc-11.5.0
nios2                 randconfig-1001-20261126    gcc-11.5.0
nios2                 randconfig-2000-20261125    clang-19
nios2                 randconfig-2000-20261126    gcc-12.5.0
nios2                 randconfig-2001-20261125    clang-19
nios2                 randconfig-2001-20261126    gcc-12.5.0
nios2                 randconfig-2200-20261125    gcc-8.5.0  smatch
nios2                 randconfig-2200-20261126    gcc-9.5.0  smatch
nios2                randconfig-r2100-20261125    gcc-8.5.0  cocci
nios2                randconfig-r2101-20261126    gcc-8.5.0  cocci
nios2                randconfig-r2104-20261126    clang-18   cocci
nios2                randconfig-r2106-20261126    clang-24   cocci
nios2                randconfig-r2108-20261126    gcc-14.4.0 cocci
nios2                randconfig-r2111-20261126    clang-22   cocci
nios2                randconfig-r2300-20261125    gcc-11.5.0 sparse
nios2                randconfig-r2300-20261126    gcc-11.5.0 sparse
nios2                randconfig-r2307-20261126    clang-18   sparse
nios2                randconfig-r2308-20261126    gcc-10.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261125    gcc-16.2.0
openrisc              randconfig-2000-20261126    gcc-16.2.0
openrisc              randconfig-2001-20261125    gcc-16.2.0
openrisc              randconfig-2001-20261126    gcc-16.2.0
openrisc              randconfig-2002-20261125    gcc-16.2.0
openrisc              randconfig-2002-20261126    gcc-16.2.0
openrisc              randconfig-2200-20261125    gcc-10.5.0 smatch
openrisc              randconfig-2200-20261126    gcc-9.5.0  smatch
openrisc             randconfig-r2102-20261125    gcc-8.5.0  cocci
openrisc             randconfig-r2105-20261125    gcc-9.5.0  cocci
openrisc             randconfig-r2105-20261126    gcc-10.5.0 cocci
openrisc             randconfig-r2304-20261126    gcc-14.4.0 sparse
openrisc             randconfig-r2305-20261126    gcc-11.5.0 sparse
openrisc             randconfig-r2306-20261126    clang-18   sparse
openrisc             randconfig-r2306-20261126    gcc-10.5.0 sparse
openrisc             randconfig-r2310-20261125    gcc-15.3.0 sparse
openrisc             randconfig-r2311-20261126    gcc-10.5.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261126    gcc-13.5.0
parisc                randconfig-1001-20261126    gcc-13.5.0
parisc                randconfig-2000-20261125    clang-19
parisc                randconfig-2000-20261126    gcc-12.5.0
parisc                randconfig-2001-20261125    clang-19
parisc                randconfig-2001-20261126    gcc-12.5.0
parisc                randconfig-2200-20261125    gcc-12.5.0 smatch
parisc                randconfig-2200-20261126    gcc-15.3.0 smatch
parisc               randconfig-r2107-20261125    gcc-14     cocci
parisc               randconfig-r2107-20261126    gcc-11.5.0 cocci
parisc               randconfig-r2109-20261125    gcc-10.5.0 cocci
parisc               randconfig-r2111-20261126    clang-24   cocci
parisc               randconfig-r2111-20261126    gcc-14     cocci
parisc               randconfig-r2306-20261125    gcc-15.3.0 sparse
parisc               randconfig-r2306-20261126    gcc-12.5.0 sparse
parisc               randconfig-r2307-20261126    gcc-8.5.0  sparse
parisc               randconfig-r2308-20261126    clang-24   sparse
parisc               randconfig-r2310-20261126    gcc-12.5.0 sparse
parisc               randconfig-r2310-20261126    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       arches_defconfig    gcc-16.2.0
powerpc                      asp8347_defconfig    gcc-16.2.0
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                    currituck_defconfig    gcc-16.2.0
powerpc                   iss476-smp_defconfig    clang-20
powerpc                    motionpro_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261126    gcc-13.5.0
powerpc               randconfig-1001-20261126    gcc-13.5.0
powerpc               randconfig-2000-20261125    gcc-9.5.0
powerpc               randconfig-2000-20261126    clang-24
powerpc               randconfig-2001-20261125    gcc-9.5.0
powerpc               randconfig-2001-20261126    clang-24
powerpc               randconfig-2002-20261125    gcc-9.5.0
powerpc               randconfig-2002-20261126    clang-24
powerpc               randconfig-2200-20261125    gcc-11.5.0 smatch
powerpc               randconfig-2200-20261126    clang-24   smatch
powerpc              randconfig-r2102-20261125    gcc-9.5.0  cocci
powerpc              randconfig-r2110-20261126    clang-24   cocci
powerpc              randconfig-r2111-20261125    gcc-14     cocci
powerpc              randconfig-r2302-20261126    gcc-14.4.0 sparse
powerpc              randconfig-r2303-20261126    clang-22   sparse
powerpc              randconfig-r2305-20261126    clang-22   sparse
powerpc              randconfig-r2306-20261126    gcc-8.5.0  sparse
powerpc              randconfig-r2310-20261125    gcc-8.5.0  sparse
powerpc                      stx_gp3_defconfig    gcc-16.2.0
powerpc                      tqm5200_defconfig    clang-20
powerpc                       tqm8xx_defconfig    clang-20
powerpc                  xes_mpc85xx_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261126    gcc-13.5.0
powerpc64             randconfig-1001-20261126    gcc-13.5.0
powerpc64             randconfig-2000-20261125    gcc-9.5.0
powerpc64             randconfig-2000-20261126    clang-24
powerpc64             randconfig-2001-20261125    gcc-9.5.0
powerpc64             randconfig-2001-20261126    clang-24
powerpc64             randconfig-2002-20261125    gcc-9.5.0
powerpc64             randconfig-2002-20261126    clang-24
powerpc64             randconfig-2200-20261125    gcc-13.5.0 smatch
powerpc64             randconfig-2200-20261126    clang-24   smatch
powerpc64            randconfig-r2101-20261125    gcc-9.5.0  cocci
powerpc64            randconfig-r2101-20261126    clang-18   cocci
powerpc64            randconfig-r2104-20261126    clang-24   cocci
powerpc64            randconfig-r2108-20261125    gcc-14     cocci
powerpc64            randconfig-r2306-20261126    clang-24   sparse
powerpc64            randconfig-r2308-20261126    clang-18   sparse
powerpc64            randconfig-r2311-20261126    clang-18   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                     nommu_virt_defconfig    gcc-16.2.0
riscv                 randconfig-1001-20261126    clang-20
riscv                 randconfig-2000-20261125    gcc-13.5.0
riscv                 randconfig-2000-20261126    gcc-10.5.0
riscv                 randconfig-2001-20261125    gcc-13.5.0
riscv                 randconfig-2001-20261126    gcc-10.5.0
riscv                 randconfig-2002-20261125    gcc-13.5.0
riscv                 randconfig-2002-20261126    gcc-10.5.0
riscv                 randconfig-2003-20261125    gcc-13.5.0
riscv                 randconfig-2003-20261126    gcc-10.5.0
riscv                 randconfig-2004-20261125    gcc-13.5.0
riscv                 randconfig-2004-20261126    gcc-10.5.0
riscv                 randconfig-2005-20261125    gcc-13.5.0
riscv                 randconfig-2005-20261126    gcc-10.5.0
riscv                 randconfig-2200-20261125    gcc-8.5.0  smatch
riscv                 randconfig-2200-20261126    gcc-8.5.0  smatch
riscv                randconfig-r2102-20261126    gcc-10.5.0 cocci
riscv                randconfig-r2103-20261125    gcc-8.5.0  cocci
riscv                randconfig-r2107-20261126    clang-22   cocci
riscv                randconfig-r2107-20261126    clang-24   cocci
riscv                randconfig-r2110-20261125    gcc-14     cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261126    clang-20
s390                  randconfig-1001-20261126    clang-20
s390                  randconfig-2000-20261125    clang-24
s390                  randconfig-2000-20261126    clang-24
s390                  randconfig-2001-20261125    clang-24
s390                  randconfig-2001-20261126    clang-24
s390                  randconfig-2002-20261125    clang-24
s390                  randconfig-2002-20261126    clang-24
s390                  randconfig-2003-20261125    clang-24
s390                  randconfig-2003-20261126    clang-24
s390                  randconfig-2004-20261125    clang-24
s390                  randconfig-2004-20261126    clang-24
s390                  randconfig-2005-20261125    clang-24
s390                  randconfig-2005-20261126    clang-24
s390                  randconfig-2200-20261125    gcc-15.3.0 smatch
s390                  randconfig-2200-20261126    gcc-16.2.0 smatch
s390                 randconfig-r2102-20261126    gcc-8.5.0  cocci
s390                 randconfig-r2103-20261125    gcc-9.5.0  cocci
s390                 randconfig-r2105-20261126    clang-24   cocci
s390                 randconfig-r2107-20261126    gcc-14.4.0 cocci
s390                 randconfig-r2108-20261126    gcc-14     cocci
s390                 randconfig-r2110-20261126    gcc-14     cocci
s390                 randconfig-r2300-20261126    gcc-14.4.0 sparse
s390                 randconfig-r2301-20261126    gcc-14.4.0 sparse
s390                 randconfig-r2303-20261125    gcc-11.5.0 sparse
s390                 randconfig-r2305-20261125    gcc-11.5.0 sparse
s390                 randconfig-r2310-20261126    clang-24   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          apsh4a3a_defconfig    clang-20
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261126    clang-20
sh                    randconfig-1001-20261126    clang-20
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
sh                    randconfig-2200-20261125    gcc-14.4.0 smatch
sh                    randconfig-2200-20261126    gcc-16.2.0 smatch
sh                   randconfig-r2107-20261125    gcc-10.5.0 cocci
sh                   randconfig-r2109-20261125    gcc-14     cocci
sh                   randconfig-r2110-20261125    gcc-14     cocci
sh                   randconfig-r2308-20261125    gcc-15.3.0 sparse
sh                    rts7751r2dplus_defconfig    clang-20
sh                            se7619_defconfig    gcc-16.2.0
sh                            se7712_defconfig    gcc-16.2.0
sh                      sh7710voipgw_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261126    clang-17
sparc                 randconfig-1001-20261126    clang-17
sparc                 randconfig-2000-20261125    gcc-8.5.0
sparc                 randconfig-2000-20261126    gcc-8.5.0
sparc                 randconfig-2001-20261125    gcc-8.5.0
sparc                 randconfig-2001-20261126    gcc-8.5.0
sparc                 randconfig-2200-20261125    gcc-14.4.0 smatch
sparc                 randconfig-2200-20261126    gcc-13.5.0 smatch
sparc                randconfig-r2101-20261126    gcc-10.5.0 cocci
sparc                randconfig-r2101-20261126    gcc-8.5.0  cocci
sparc                randconfig-r2102-20261126    clang-18   cocci
sparc                randconfig-r2108-20261126    clang-24   cocci
sparc                randconfig-r2110-20261126    clang-22   cocci
sparc                randconfig-r2111-20261125    gcc-9.5.0  cocci
sparc                randconfig-r2307-20261125    gcc-15.3.0 sparse
sparc                randconfig-r2307-20261126    clang-18   sparse
sparc                randconfig-r2308-20261125    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261126    clang-17
sparc64               randconfig-1001-20261126    clang-17
sparc64               randconfig-2000-20261125    gcc-8.5.0
sparc64               randconfig-2000-20261126    gcc-8.5.0
sparc64               randconfig-2001-20261125    gcc-8.5.0
sparc64               randconfig-2001-20261126    gcc-8.5.0
sparc64               randconfig-2200-20261125    gcc-15.3.0 smatch
sparc64               randconfig-2200-20261126    gcc-12.5.0 smatch
sparc64              randconfig-r2106-20261126    gcc-14     cocci
sparc64              randconfig-r2108-20261126    clang-24   cocci
sparc64              randconfig-r2300-20261125    gcc-12     sparse
sparc64              randconfig-r2303-20261125    gcc-12     sparse
sparc64              randconfig-r2304-20261126    gcc-11.5.0 sparse
sparc64              randconfig-r2305-20261126    gcc-14.4.0 sparse
sparc64              randconfig-r2307-20261126    clang-24   sparse
sparc64              randconfig-r2309-20261126    clang-24   sparse
sparc64              randconfig-r2310-20261126    clang-18   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261126    clang-17
um                    randconfig-1001-20261126    clang-17
um                    randconfig-2000-20261125    gcc-8.5.0
um                    randconfig-2000-20261126    gcc-8.5.0
um                    randconfig-2001-20261125    gcc-8.5.0
um                    randconfig-2001-20261126    gcc-8.5.0
um                    randconfig-2200-20261125    clang-17   smatch
um                    randconfig-2200-20261126    gcc-12     smatch
um                   randconfig-r2100-20261126    clang-24   cocci
um                   randconfig-r2105-20261126    clang-18   cocci
um                   randconfig-r2105-20261126    clang-24   cocci
um                   randconfig-r2108-20261125    gcc-14     cocci
um                   randconfig-r2109-20261126    gcc-14     cocci
um                   randconfig-r2301-20261126    gcc-11.5.0 sparse
um                   randconfig-r2302-20261125    gcc-11.5.0 sparse
um                   randconfig-r2308-20261126    gcc-12.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    clang-20
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
x86_64                randconfig-2200-20261125    gcc-14     smatch
x86_64                randconfig-2200-20261126    clang-22   smatch
x86_64                randconfig-2300-20261125    clang-22   sparse
x86_64                randconfig-2300-20261126    gcc-14     sparse
x86_64                randconfig-2301-20261125    clang-22   sparse
x86_64                randconfig-2301-20261126    gcc-14     sparse
x86_64                randconfig-2302-20261125    clang-22   sparse
x86_64                randconfig-2302-20261126    gcc-14     sparse
x86_64               randconfig-r2100-20261126    gcc-8.5.0  cocci
x86_64               randconfig-r2103-20261126    gcc-8.5.0  cocci
x86_64               randconfig-r2105-20261126    gcc-8.5.0  cocci
x86_64               randconfig-r2106-20261126    clang-22   cocci
x86_64               randconfig-r2107-20261125    gcc-14     cocci
x86_64               randconfig-r2108-20261126    clang-22   cocci
x86_64               randconfig-r2109-20261126    gcc-11.5.0 cocci
x86_64               randconfig-r2303-20261126    gcc-11.5.0 sparse
x86_64               randconfig-r2307-20261125    gcc-8.5.0  sparse
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
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261126    clang-17
xtensa                randconfig-1001-20261126    clang-17
xtensa                randconfig-2000-20261125    gcc-14.4.0
xtensa                randconfig-2000-20261126    gcc-13.5.0
xtensa                randconfig-2001-20261125    gcc-14.4.0
xtensa                randconfig-2001-20261126    gcc-13.5.0
xtensa                randconfig-2200-20261125    gcc-16.2.0 smatch
xtensa                randconfig-2200-20261126    gcc-11.5.0 smatch
xtensa               randconfig-r2100-20261126    clang-18   cocci
xtensa               randconfig-r2101-20261125    gcc-8.5.0  cocci
xtensa               randconfig-r2111-20261126    gcc-11.5.0 cocci
xtensa               randconfig-r2309-20261126    gcc-10.5.0 sparse
xtensa               randconfig-r2311-20261126    gcc-12.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
