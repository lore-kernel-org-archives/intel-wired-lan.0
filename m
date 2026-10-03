Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F6ECA5FE2
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 00:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23C9040BBB;
	Sat,  3 Oct 2026 00:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0v6OZLEPWbyJ; Sat,  3 Oct 2026 00:51:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3601340DBC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790988711;
	b=aVlEFIfkaEVsT/VF0/IWF/4soW4Ifx5ae39Jiz+co03kj2eYUBeoQuE4lGwTagFdYD6E
	 oYAyWsUrIH3T7GprHQZA/J79bl7HrqJMoGrcbbyDWdBgzwG8JlewPIIECsBToY4+C7Ugj
	 AXnVsVJh6Vy3OQ5z0wVwkrNbsAerZSmf7wjQeyFwrf3oM1yxME5fclKp3+UMd/mrp2PrQ
	 I4jfcL8Rs8EEWuxZbvmWLwNmbTDGy5/kwiVUCUGBdMPCd78JmgkcaUwWgYdm+C28ClnRm
	 2HNY8so0ciK/tVHq9gBT060k7E0ITLZAFx61vGOSv9xYEP1dryUVwK84s1loHPBQdNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790988711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1YLKcnDhf9iatsuXrBkZ4pPCxf3+1cgvc+9oBz4Y2Ho=;
	b=JQrE1hiBunWIOJi1f9b+XyX2pVJr+nAVKvETI20LqYysAgUfZoLYe1eb2LGZw3UsVKc2
	 XrB8W6wN4QaDYwAaBDBYomloPmGJLCIRN9kSXCQOKm6xvJadKI9hhhnbk5F5cHpvsVLT+
	 DIoraT5bww54fnD3h/EqQyHwzPZnyqfR6UiRSvReX3A98zfc4iitbT+wI+Em5zats7ui+
	 w5SipfRyop4libPsYgg7XDFi4fQShxmVUR8SO4X6MTsPl3wYEzDHfiuksen7FqJRHXudB
	 fiRuzlHJSZZEAETse9lmWy7o9wPbNVtg7pIljQU6Gd2iFxQwsBsMjxdmRghbPCrZTjw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790988711;
	bh=1YLKcnDhf9iatsuXrBkZ4pPCxf3+1cgvc+9oBz4Y2Ho=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZfGsViLkzI/HMSMnIhva/ZWFJrMVQMgrtvOntYcGBoNypoWmv4/OX5EfphZMq4NCC
	 kv61zxbkfdjmndicgSacpzAGAt+2xP9Lw2gqnpwNAXJy/gtDZR+cDkOGXFcWhYuQ1O
	 UQAZoyEJPOf6kzghTbkaTiOgBa+nh+YdND3SoNlbhLgZh+SSr0CqihMuRcrxGJjOhC
	 /kPb1uF6HhXhAoa7QkPq6u+qZ34ZT7BhakoRAF1zwWqatDcQGUkBx0V+JCBpMWEZEf
	 F8eGV3uLBwxS5lG/6hcu8cOpBVSl+xhaqTZVC3sqO0kKYPv+2BPwrjV6IEuULUP+qt
	 5RYqMc8g9tSPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3601340DBC;
	Sat,  3 Oct 2026 00:51:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AC4DA435
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 00:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA0B181108
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 00:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7IcX0ixpd-J9 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 00:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1D18C811DC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790988706;
 b=VsRTnkt0i9ObxnNreIA/ZAzw1/wF7mX9QqzBAdtL4taoInCqzyC4s6KFwBjgGgIBWRt9
 KTc9pr1wElOg4Ngl6k5QJgy7dUTB5P8blEyd9/G7oFvHjtY/5LLzeVhhFVCY80Qkh1lHP
 GsBy+jrmLac2FOH30SE7eEmUMz0rS7qvTyuo2qD8ZtN02hyuRRrrSmBcIfKU1gk9fUord
 clmZv9YqAqge2Wr2KfGEWLN6t74i1kwOtkaScqhaBtySt5vByIQ0mStzE07ZZvqYTQNyy
 +v/dvixv8shIN08OZ/mkpmjhMy3ntUTj62S9143XwBMgNilWL1xuZsJWwGftFb0Ff5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790988706;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=1YLKcnDhf9iatsuXrBkZ4pPCxf3+1cgvc+9oBz4Y2Ho=;
 b=CZ86mwKQAY7ujiFGK5liEfG9ULlmqdz3sJtRfXguWdoNpGrzRl39zSNI7//eN21vIpGN
 s/jXp95lS0/T/6iC4IFfh8STEmbZraQlaovP7jsGLlye0iTHzFd63K5JR3+aRQbGrUNc/
 LDmml6bmrBWz6e8WGMh/BQmca4McEm9UaB8RGRQgmXMsg7/8q3D3reehGSh0018hNR+5g
 Aa8PwJpfIVUjT8NIAZwvq640Gt3HKUebvl7HUFkwTPvbWrsRFfB+q17p3PhsOL6pcmw7P
 vhO9ZsUrzS/9Fz5lM2xCBx1hKgcx81XX+gyXCUlGuF2G+nUE/9RHW2sS1sfkkdYMalQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=beINZ8K1; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=beINZ8K1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D18C811DC
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 00:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790988706; x=1822524706; h=date:from:to:subject:message-id;
 bh=KL6szcj/zW9eZrcZw3N2+k2gw4RM1WdIV21U6Jn1aCw=;
 b=beINZ8K1hks2LFVCLG+ubjF2ST774N+JaNd3xfa3eklMsdnGiXlmFRV7
 ZJIhnPbe4WpbhRkJLIs70kWUTOeGyhw188UIAocb3Dtnr++ShBnCtjV+m
 zXsIBPnj9P491a5ucET4gGsGjlcmA85Jvvgv06ZMt8bEzFhnZ6Lgy4pZO
 wskfDx9URblLM/i5cEPBxBBDbI31fft+YjpSI00NET7RKbJ5M77EnvTlg
 A7oLc6VEDcTesZUDiA9tDbIZd2D8ZHch88M/vlIg7aQXDqOluCIQmtwIZ
 qt/poECOqzHZPIgIad749c2ZidOhry0gehNWiY10bHvOjLxjAyF/T6O02 A==;
X-CSE-ConnectionGUID: QVktaHEQRRSt9gdA5rIXWQ==
X-CSE-MsgGUID: urmPvKa2Q5+Sf/anIHJGbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="91781417"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="91781417"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 17:51:44 -0700
X-CSE-ConnectionGUID: 1YQnkwofTq6wo0k5ccU6Ew==
X-CSE-MsgGUID: 4RHXUOf7QemwOE9FvJ8+EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="275477570"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 02 Oct 2026 17:51:44 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xCnyX-00000000Td1-2Oze;
 Sat, 03 Oct 2026 00:51:41 +0000
Date: Sat, 03 Oct 2026 08:50:55 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 ced3ba3885733a5c6c79bd28576c893b9f4cc299
Message-ID: <202610030852.90FZHWg0-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: ced3ba3885733a5c6c79bd28576c893b9f4cc299  igc: Group frame size macros in igc_tsn.h

elapsed time: 2018m

configs tested: 332
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2105-20261001    gcc-15.2.0 cocci
alpha                randconfig-r2107-20261001    gcc-8.5.0  cocci
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                       axs103_smp_defconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                      haps_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20261002    clang-17
arc                   randconfig-1000-20261003    clang-17
arc                   randconfig-1001-20261002    clang-17
arc                   randconfig-1001-20261003    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                         mvebu_v5_defconfig    gcc-16.1.0
arm                         neponset_defconfig    gcc-16.1.0
arm                            omap1_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261002    clang-17
arm                   randconfig-1000-20261003    clang-17
arm                   randconfig-1001-20261002    clang-17
arm                   randconfig-1001-20261003    clang-17
arm                   randconfig-1002-20261002    clang-17
arm                   randconfig-1002-20261003    clang-17
arm                   randconfig-1003-20261002    clang-17
arm                   randconfig-1003-20261003    clang-17
arm                  randconfig-r2303-20261001    clang-24   sparse
arm                         spear6xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261002    gcc-12.5.0
arm64                 randconfig-1000-20261003    gcc-9.5.0
arm64                 randconfig-1001-20261002    gcc-12.5.0
arm64                 randconfig-1001-20261003    gcc-9.5.0
arm64                 randconfig-1002-20261002    gcc-12.5.0
arm64                 randconfig-1002-20261003    gcc-9.5.0
arm64                 randconfig-1003-20261002    gcc-12.5.0
arm64                 randconfig-1003-20261003    gcc-9.5.0
arm64                randconfig-r2201-20261001    gcc-16.1.0 smatch
arm64                randconfig-r2300-20261001    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261002    gcc-12.5.0
csky                  randconfig-1000-20261003    gcc-9.5.0
csky                  randconfig-1001-20261002    gcc-12.5.0
csky                  randconfig-1001-20261003    gcc-9.5.0
csky                 randconfig-r2305-20261001    gcc-15.2.0 sparse
csky                 randconfig-r2309-20261001    clang-24   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261002    gcc-13.4.0
hexagon               randconfig-1000-20261003    gcc-16.1.0
hexagon               randconfig-1001-20261002    gcc-13.4.0
hexagon               randconfig-1001-20261003    gcc-16.1.0
hexagon              randconfig-r2103-20261001    clang-24   cocci
hexagon              randconfig-r2304-20261001    gcc-15.2.0 sparse
hexagon              randconfig-r2308-20261001    clang-22   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261002    clang-22
i386        buildonly-randconfig-1000-20261003    gcc-14
i386        buildonly-randconfig-1001-20261002    clang-22
i386        buildonly-randconfig-1001-20261003    gcc-14
i386        buildonly-randconfig-1002-20261002    clang-22
i386        buildonly-randconfig-1002-20261003    gcc-14
i386        buildonly-randconfig-1003-20261002    clang-22
i386        buildonly-randconfig-1003-20261003    gcc-14
i386        buildonly-randconfig-1004-20261002    clang-22
i386        buildonly-randconfig-1004-20261003    gcc-14
i386        buildonly-randconfig-1005-20261002    clang-22
i386        buildonly-randconfig-1005-20261003    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261002    gcc-14
i386                  randconfig-1001-20261002    gcc-14
i386                  randconfig-1002-20261002    gcc-14
i386                  randconfig-1003-20261002    gcc-14
i386                  randconfig-1004-20261002    gcc-14
i386                  randconfig-1005-20261002    gcc-14
i386                  randconfig-1006-20261002    gcc-14
i386                  randconfig-1007-20261002    clang-22
i386                  randconfig-1008-20261002    clang-22
i386                  randconfig-1009-20261002    clang-22
i386                  randconfig-1010-20261002    clang-22
i386                  randconfig-1011-20261002    clang-22
i386                  randconfig-1012-20261002    clang-22
i386                  randconfig-1013-20261002    clang-22
i386                  randconfig-2100-20261001    gcc-14     cocci
i386                  randconfig-2101-20261001    gcc-14     cocci
i386                  randconfig-2102-20261001    clang-22   cocci
i386                  randconfig-2102-20261001    gcc-14     cocci
i386                  randconfig-2103-20261001    gcc-13     cocci
i386                  randconfig-2103-20261001    gcc-14     cocci
i386                  randconfig-2200-20261001    clang-22   smatch
i386                  randconfig-2300-20261001    clang-22   sparse
i386                  randconfig-2300-20261001    gcc-14     sparse
i386                  randconfig-2301-20261001    gcc-14     sparse
i386                  randconfig-2302-20261001    gcc-14     sparse
i386                 randconfig-r2101-20261001    gcc-14     cocci
i386                 randconfig-r2102-20261001    gcc-14     cocci
i386                 randconfig-r2200-20261001    clang-22   smatch
i386                 randconfig-r2308-20261001    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261002    gcc-13.4.0
loongarch             randconfig-1000-20261003    gcc-16.1.0
loongarch             randconfig-1001-20261002    gcc-13.4.0
loongarch             randconfig-1001-20261003    gcc-16.1.0
loongarch            randconfig-r2107-20261001    gcc-15.2.0 cocci
loongarch            randconfig-r2302-20261001    gcc-15.2.0 sparse
loongarch            randconfig-r2303-20261001    gcc-13.4.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2106-20261001    gcc-8.5.0  cocci
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2202-20261001    gcc-8.5.0  smatch
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            jazz_defconfig    gcc-16.1.0
mips                       loongson3_defconfig    gcc-16.1.0
mips                 randconfig-r2104-20261001    gcc-11.5.0 cocci
mips                 randconfig-r2105-20261001    gcc-9.5.0  cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261002    gcc-13.4.0
nios2                 randconfig-1000-20261003    gcc-16.1.0
nios2                 randconfig-1001-20261002    gcc-13.4.0
nios2                 randconfig-1001-20261003    gcc-16.1.0
nios2                randconfig-r2300-20261001    gcc-11.5.0 sparse
nios2                randconfig-r2307-20261001    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261002    gcc-14.3.0
parisc                randconfig-1000-20261003    gcc-11.5.0
parisc                randconfig-1001-20261002    gcc-14.3.0
parisc                randconfig-1001-20261003    gcc-11.5.0
parisc               randconfig-r2102-20261001    clang-24   cocci
parisc               randconfig-r2104-20261001    gcc-15.2.0 cocci
parisc               randconfig-r2202-20261001    gcc-8.5.0  smatch
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20261002    gcc-14.3.0
powerpc               randconfig-1000-20261003    gcc-11.5.0
powerpc               randconfig-1001-20261002    gcc-14.3.0
powerpc               randconfig-1001-20261003    gcc-11.5.0
powerpc              randconfig-r2303-20261001    gcc-15.2.0 sparse
powerpc64             randconfig-1000-20261002    gcc-14.3.0
powerpc64             randconfig-1000-20261003    gcc-11.5.0
powerpc64             randconfig-1001-20261002    gcc-14.3.0
powerpc64             randconfig-1001-20261003    gcc-11.5.0
powerpc64            randconfig-r2307-20261001    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261002    clang-24
riscv                 randconfig-1000-20261003    gcc-12.5.0
riscv                 randconfig-1001-20261002    clang-24
riscv                 randconfig-1001-20261003    gcc-12.5.0
riscv                 randconfig-2000-20261001    gcc-10.5.0
riscv                 randconfig-2000-20261001    gcc-9.5.0
riscv                 randconfig-2001-20261001    gcc-10.5.0
riscv                 randconfig-2001-20261001    gcc-8.5.0
riscv                randconfig-r2300-20261001    gcc-15.2.0 sparse
riscv                randconfig-r2304-20261001    gcc-13.4.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261002    clang-24
s390                  randconfig-1000-20261003    gcc-12.5.0
s390                  randconfig-1001-20261002    clang-24
s390                  randconfig-1001-20261003    gcc-12.5.0
s390                  randconfig-2000-20261001    gcc-10.5.0
s390                  randconfig-2000-20261001    gcc-9.5.0
s390                  randconfig-2001-20261001    clang-17
s390                  randconfig-2001-20261001    gcc-10.5.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261002    clang-24
sh                    randconfig-1000-20261003    gcc-12.5.0
sh                    randconfig-1001-20261002    clang-24
sh                    randconfig-1001-20261003    gcc-12.5.0
sh                    randconfig-2000-20261001    gcc-10.5.0
sh                    randconfig-2000-20261001    gcc-16.1.0
sh                    randconfig-2001-20261001    gcc-10.5.0
sh                   randconfig-r2301-20261001    gcc-15.2.0 sparse
sh                   randconfig-r2305-20261001    gcc-16.1.0 sparse
sh                    sh7724_generic_defconfig    gcc-16.1.0
sh                             titan_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261002    clang-24
sparc                 randconfig-1000-20261003    clang-17
sparc                 randconfig-1001-20261002    clang-24
sparc                 randconfig-1001-20261003    clang-17
sparc                 randconfig-2000-20261001    clang-24
sparc                 randconfig-2000-20261001    gcc-12.5.0
sparc                 randconfig-2001-20261001    clang-24
sparc                 randconfig-2001-20261001    gcc-14.3.0
sparc                randconfig-r2101-20261001    clang-24   cocci
sparc                randconfig-r2103-20261001    gcc-8.5.0  cocci
sparc                randconfig-r2106-20261001    gcc-15.2.0 cocci
sparc                randconfig-r2200-20261001    gcc-8.5.0  smatch
sparc                randconfig-r2301-20261001    gcc-16.1.0 sparse
sparc                        sparc64_defconfig    gcc-16.1.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261002    clang-24
sparc64               randconfig-1000-20261003    clang-17
sparc64               randconfig-1001-20261002    clang-24
sparc64               randconfig-1001-20261003    clang-17
sparc64               randconfig-2000-20261001    clang-24
sparc64               randconfig-2001-20261001    clang-24
sparc64               randconfig-2001-20261001    gcc-8.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261002    clang-24
um                    randconfig-1000-20261003    clang-17
um                    randconfig-1001-20261002    clang-24
um                    randconfig-1001-20261003    clang-17
um                    randconfig-2000-20261001    clang-17
um                    randconfig-2000-20261001    clang-24
um                    randconfig-2001-20261001    clang-24
um                   randconfig-r2100-20261001    clang-17   cocci
um                   randconfig-r2100-20261001    clang-24   cocci
um                   randconfig-r2201-20261001    clang-24   smatch
um                   randconfig-r2306-20261001    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261002    gcc-14
x86_64      buildonly-randconfig-1000-20261003    clang-22
x86_64      buildonly-randconfig-1001-20261002    gcc-14
x86_64      buildonly-randconfig-1001-20261003    clang-22
x86_64      buildonly-randconfig-1002-20261002    gcc-14
x86_64      buildonly-randconfig-1002-20261003    clang-22
x86_64      buildonly-randconfig-1003-20261002    gcc-14
x86_64      buildonly-randconfig-1003-20261003    clang-22
x86_64      buildonly-randconfig-1004-20261002    gcc-14
x86_64      buildonly-randconfig-1004-20261003    clang-22
x86_64      buildonly-randconfig-1005-20261002    gcc-14
x86_64      buildonly-randconfig-1005-20261003    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261002    gcc-14
x86_64                randconfig-1001-20261002    gcc-14
x86_64                randconfig-1002-20261002    gcc-14
x86_64                randconfig-1003-20261002    gcc-14
x86_64                randconfig-1004-20261002    gcc-14
x86_64                randconfig-1005-20261002    gcc-14
x86_64                randconfig-1006-20261002    clang-22
x86_64                randconfig-1006-20261003    clang-22
x86_64                randconfig-1007-20261002    clang-22
x86_64                randconfig-1007-20261003    clang-22
x86_64                randconfig-1008-20261002    clang-22
x86_64                randconfig-1008-20261003    clang-22
x86_64                randconfig-1009-20261002    clang-22
x86_64                randconfig-1009-20261003    clang-22
x86_64                randconfig-1010-20261002    clang-22
x86_64                randconfig-1010-20261003    clang-22
x86_64                randconfig-1011-20261002    clang-22
x86_64                randconfig-1011-20261003    clang-22
x86_64                randconfig-1012-20261002    clang-22
x86_64                randconfig-1013-20261002    clang-22
x86_64                randconfig-1014-20261002    clang-22
x86_64                randconfig-1015-20261002    clang-22
x86_64                randconfig-1016-20261002    clang-22
x86_64                randconfig-1017-20261002    clang-22
x86_64                randconfig-2100-20261001    gcc-14     cocci
x86_64                randconfig-2101-20261001    gcc-13     cocci
x86_64                randconfig-2101-20261001    gcc-14     cocci
x86_64                randconfig-2102-20261001    clang-22   cocci
x86_64                randconfig-2102-20261001    gcc-14     cocci
x86_64                randconfig-2103-20261001    clang-22   cocci
x86_64                randconfig-2103-20261001    gcc-14     cocci
x86_64                randconfig-2200-20261001    clang-22   smatch
x86_64                randconfig-2300-20261001    clang-22   sparse
x86_64                randconfig-2300-20261001    gcc-14     sparse
x86_64                randconfig-2301-20261001    clang-22   sparse
x86_64                randconfig-2301-20261001    gcc-14     sparse
x86_64                randconfig-2302-20261001    gcc-14     sparse
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
xtensa                randconfig-1000-20261002    clang-24
xtensa                randconfig-1000-20261003    clang-17
xtensa                randconfig-1001-20261002    clang-24
xtensa                randconfig-1001-20261003    clang-17
xtensa                randconfig-2000-20261001    clang-24
xtensa                randconfig-2000-20261001    gcc-10.5.0
xtensa                randconfig-2001-20261001    clang-24
xtensa                randconfig-2001-20261001    gcc-8.5.0
xtensa               randconfig-r2302-20261001    gcc-8.5.0  sparse
xtensa               randconfig-r2305-20261001    gcc-8.5.0  sparse
xtensa               randconfig-r2306-20261001    gcc-13.4.0 sparse
xtensa               randconfig-r2309-20261001    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
