Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB79CA5FA9
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 20:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC19A80848;
	Mon, 28 Sep 2026 20:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7aPAA2zZdia; Mon, 28 Sep 2026 20:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B6E328084F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790626379;
	b=nH03G4vsM6AqvbwMV4zRlBKs/VeynnoASk16IU4ligO4het0sosfc0WUMn33Zh+O9nGN
	 TyArptlvZrqA5LizOc6bbu/Z+PaxDCALo0OxmPWUuQ2TEKR3Kz3YbN2TKQAB3+YZJ3oAM
	 jb4alRmdtm8HPvKtzwvgccCKPE6AfCJkHq7+SZKsqPNCdvN9hVeQ8zBpxlU8y5QfvbDHH
	 +R/jZM64TfjhMOFI/pJXPhh7fPyGzaZgKTyzDdgWaH/VeyGXAofKTg1AZq/LhIAE9u8GG
	 rjSjKcsY+E64pfGoE3tDnnwfCSFJCfW8y4lwuJ3Uowfo1vdmXkn2pwYXiKp4paWCwZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790626379;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+D6P40lfEsKeI87Pmu6nvL+KVm9Ec7GxuM4pjmuXFGM=;
	b=ZaUQdE/vpufNrrD6DqAa+PUoQ7r59M5WM+QDsvg5NHksPOs3iWzBWCRPwYimxPPZrskk
	 ZVqA4ObTk9AGWab4mCVWXY2Do8fdVnErlTf1PQnC3MpL9DumPEOYRex7SehBQQ+1tE/qJ
	 7M5f/+BBAJ6OtKX7Sfewcga5Aw1peQcpjzCADX2GRjDb684dapeLJPZJFayNxJnJp3YS3
	 eNk2whNAF4/+SEbsgSzpPI88GvxKZd6dloJLlV3lami0ca9hdOwNuQg2OItIBMyq9C5tF
	 xhPK3mmEmJZzwIyM26oxct17dUWPeJ9sOE0MDkWbOZxFkWzQq7MstCG253xyMn08h7g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790626379;
	bh=+D6P40lfEsKeI87Pmu6nvL+KVm9Ec7GxuM4pjmuXFGM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ir+23QMolsiWo3Zm7w8AQvPqq3UqehYuevjJFSd0TU6u0o+nmtriNMPJS0R3idsPi
	 vaylytB37NcMW4Nh7c6EAOd/3y6MryS8U5lIBeqjhkoeqzSwC1e5vzhgz1ohUvpWRO
	 pPf5Rpw1OkMNMpnpSQ6R3tN0/N+DbiZU0mGpEleIbHSWFCKtxj3fdnMjXnpMIi6t9O
	 OtQYUuZB38ffBGbYSLY+nZ6pPvyGrLrXdM/dI2G09fO9bZ5iJhKOMBK40NaWkJqxEQ
	 997Ged9CTSaPnWE9PwHgpiouacKejXFxIa+S7gQa4i2WXxvgO6icovzWTLBLfslyBB
	 FB/96DMxS6ECg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6E328084F;
	Mon, 28 Sep 2026 20:12:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 322FA335
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 20:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1823060616
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 20:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NZj-64SCA_9V for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 20:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 24E54605B7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790626376;
 b=ojPQAkHGQRfOhyCrBSi/l/qUM+HpnIVSMFe/KNKWlf80sK+Qi2bRc8PERuT2zSsT6eNH
 rPLWkjq7eAilxI+sjaaUPeToQDHBuRgxEfah6ZEpKibnWGnweZTIvU/n6MKCQFJDYCUfE
 89EhX/pgdudsSpk4VDjACHd1jwklY8DE5+6LhBqJ+hpdzZSHWCmIdPveZ1+UJ+UTO7ohU
 M5OkOw7LlPBJ4fnuAZSssEZER5ZzbKMhwyUN5kjQL75nXS/tKuXZpdkX4uPVvmW/vv0Dw
 gkxvwo82LjUD7m/5TkUUoB5jH042h/SXZA2eOBs/eNZL9V9FNkVqvWjs6i67uZHZMzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790626376;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=+D6P40lfEsKeI87Pmu6nvL+KVm9Ec7GxuM4pjmuXFGM=;
 b=E3m0Im8qceWRUrnMBmv9Z3iUsRLrA7z8leUqwxmGzg1khDGhAQCbTdFNtXEG/wEqJBV8
 LrTckRhcKn/+a88y9GXztcmmZD+qBCwDKakH+wflGK5jfSwgbX/muvgtBIA/g+wP9XFfv
 wFgUYPn2Py5lPClQsFHurr3uMSTVO5NkYqBhOSIGrLAZ/kwXEIRrMMzcMMUE7/Pjxxbza
 +JHkX1vW2zUveelk1+rp4i2gxMRXVapea7Xog2ztt4hhmgt9aFQLwSKtQEhQgFFkKChC8
 9Gq2PktsL8971FUnVO/vXR1PfNN0En8dM2IfuV7rVyPg5rFyT6/aaATDci3I0d3aDkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=G+ufFdgd; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=G+ufFdgd
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24E54605B7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790626376; x=1822162376; h=date:from:to:subject:message-id;
 bh=CW3GAZlP3wJWcxRHDAx9eZ73WBtEkMJkwnGSw4VTlXA=;
 b=G+ufFdgdCjWiwlpOjdTDaDKhJXIR9fLEyTHycNk3cJdtt3A7Dg9Uf6TU
 ru0R8KQk/lQfRXuvkbOqIm8nhw5msAW3B4r54d0Bo24wBeOe0TN7DwioY
 JHvDjsu+dRX/46A7GEKkbqyO/rEYvyiYxMUkuQHHhnE8sxB2Wj5iVZbjX
 Spk+EHUvp8i+6gA0ukvcYvajo5F+1Vd1i1kjh2jeuTtqFGojlsDYlb8Vm
 2qxNYHA1r8aEPPTYoQpyzW1JxgAOy6cyDLqoK21luMedRJbk5tmclmwpL
 G/uylxPeBI16L/Nxr3aeYJyMpN2DBtif5aBlr+DATqjY2NXVB2cLzPTpP A==;
X-CSE-ConnectionGUID: /3sYZRJ2RaaZDB0Nfs0c2w==
X-CSE-MsgGUID: NOrt4bakQR+V1Eoz6YbwKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91357542"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; d="scan'208";a="91357542"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 13:12:53 -0700
X-CSE-ConnectionGUID: eoo5S0h2TSyWU8AVxd1liQ==
X-CSE-MsgGUID: MJR3VPhARV27ye3bJmQ6Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; d="scan'208";a="278360406"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 28 Sep 2026 13:12:49 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xBHiO-00000000OSV-2l4S;
 Mon, 28 Sep 2026 20:12:44 +0000
Date: Tue, 29 Sep 2026 04:12:43 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 c73657d5fb766dd0071ca71bcdc828d90c1be8c4
Message-ID: <202609290440.WGnFyUYz-lkp@intel.com>
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
branch HEAD: c73657d5fb766dd0071ca71bcdc828d90c1be8c4  ice: describe generic DPLL pins from firmware pin classification

elapsed time: 3633m

configs tested: 329
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2102-20260927    gcc-8.5.0  cocci
alpha                randconfig-r2202-20260928    gcc-8.5.0  smatch
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                          haps_hs_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260928    clang-24
arc                   randconfig-1000-20260929    clang-17
arc                   randconfig-1001-20260928    clang-24
arc                   randconfig-1001-20260929    clang-17
arc                     vdk_hs38_smp_defconfig    gcc-16.1.0
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                            h3600_defconfig    gcc-16.1.0
arm                          lpc32xx_defconfig    gcc-16.1.0
arm                          mv78xx0_defconfig    gcc-16.1.0
arm                         mvebu_v5_defconfig    clang-24
arm                   randconfig-1000-20260928    clang-24
arm                   randconfig-1000-20260929    clang-17
arm                   randconfig-1001-20260928    clang-24
arm                   randconfig-1001-20260929    clang-17
arm                   randconfig-1002-20260928    clang-24
arm                   randconfig-1002-20260929    clang-17
arm                   randconfig-1003-20260928    clang-24
arm                   randconfig-1003-20260929    clang-17
arm                  randconfig-r2107-20260927    clang-17   cocci
arm                  randconfig-r2300-20260927    clang-22   sparse
arm                  randconfig-r2300-20260928    clang-17   sparse
arm                  randconfig-r2304-20260927    clang-22   sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260928    gcc-15.2.0
arm64                 randconfig-1001-20260928    gcc-15.2.0
arm64                 randconfig-1002-20260928    gcc-15.2.0
arm64                 randconfig-1003-20260928    gcc-15.2.0
arm64                randconfig-r2104-20260928    gcc-12.5.0 cocci
arm64                randconfig-r2301-20260928    clang-17   sparse
arm64                randconfig-r2303-20260928    clang-17   sparse
arm64                randconfig-r2305-20260927    gcc-15.2.0 sparse
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260928    gcc-15.2.0
csky                  randconfig-1001-20260928    gcc-15.2.0
csky                 randconfig-r2106-20260927    clang-17   cocci
csky                 randconfig-r2107-20260928    gcc-12.5.0 cocci
csky                 randconfig-r2300-20260927    gcc-15.2.0 sparse
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260928    gcc-8.5.0
hexagon               randconfig-1001-20260928    gcc-8.5.0
hexagon              randconfig-r2104-20260927    clang-24   cocci
hexagon              randconfig-r2304-20260927    gcc-15.2.0 sparse
hexagon              randconfig-r2304-20260928    clang-17   sparse
hexagon              randconfig-r2306-20260927    clang-22   sparse
hexagon              randconfig-r2306-20260928    gcc-16.1.0 sparse
hexagon              randconfig-r2308-20260928    gcc-16.1.0 sparse
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20260928    clang-22
i386        buildonly-randconfig-1001-20260928    clang-22
i386        buildonly-randconfig-1002-20260928    clang-22
i386        buildonly-randconfig-1003-20260928    clang-22
i386        buildonly-randconfig-1004-20260928    clang-22
i386        buildonly-randconfig-1005-20260928    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260928    gcc-14
i386                  randconfig-1001-20260928    gcc-14
i386                  randconfig-1002-20260928    gcc-14
i386                  randconfig-1003-20260928    gcc-14
i386                  randconfig-1004-20260928    gcc-14
i386                  randconfig-1005-20260928    gcc-14
i386                  randconfig-1006-20260928    gcc-14
i386                  randconfig-1007-20260928    clang-22
i386                  randconfig-1008-20260928    clang-22
i386                  randconfig-1009-20260928    clang-22
i386                  randconfig-1010-20260928    clang-22
i386                  randconfig-1011-20260928    clang-22
i386                  randconfig-1012-20260928    clang-22
i386                  randconfig-1013-20260928    clang-22
i386                  randconfig-2100-20260927    clang-22   cocci
i386                  randconfig-2100-20260928    gcc-14     cocci
i386                  randconfig-2101-20260927    clang-22   cocci
i386                  randconfig-2101-20260928    gcc-14     cocci
i386                  randconfig-2102-20260927    clang-22   cocci
i386                  randconfig-2102-20260928    gcc-14     cocci
i386                  randconfig-2103-20260927    clang-22   cocci
i386                  randconfig-2103-20260928    gcc-14     cocci
i386                  randconfig-2200-20260927    clang-22   smatch
i386                  randconfig-2200-20260928    clang-22   smatch
i386                  randconfig-2300-20260927    clang-22   sparse
i386                  randconfig-2300-20260928    clang-22   sparse
i386                  randconfig-2301-20260927    clang-22   sparse
i386                  randconfig-2301-20260928    clang-22   sparse
i386                  randconfig-2302-20260927    clang-22   sparse
i386                  randconfig-2302-20260928    clang-22   sparse
i386                 randconfig-r2107-20260927    clang-24   cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260928    gcc-8.5.0
loongarch             randconfig-1001-20260928    gcc-8.5.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2102-20260928    clang-17   cocci
m68k                 randconfig-r2301-20260927    gcc-15.2.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2202-20260927    gcc-13.4.0 smatch
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                       fuloong2e_defconfig    gcc-16.1.0
mips                       loongson3_defconfig    gcc-16.1.0
mips                         omega2p_defconfig    gcc-16.1.0
mips                 randconfig-r2103-20260927    gcc-8.5.0  cocci
mips                 randconfig-r2106-20260928    gcc-12.5.0 cocci
mips                 randconfig-r2200-20260927    gcc-14.3.0 smatch
mips                 randconfig-r2202-20260927    clang-17   smatch
mips                 randconfig-r2305-20260927    clang-22   sparse
mips                         vocore2_defconfig    gcc-16.1.0
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260928    gcc-8.5.0
nios2                 randconfig-1001-20260928    gcc-8.5.0
nios2                randconfig-r2303-20260927    clang-22   sparse
nios2                randconfig-r2303-20260927    gcc-15.2.0 sparse
nios2                randconfig-r2307-20260928    gcc-16.1.0 sparse
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20260927    gcc-13.4.0 cocci
openrisc             randconfig-r2101-20260928    clang-17   cocci
openrisc             randconfig-r2106-20260927    clang-24   cocci
openrisc             randconfig-r2200-20260927    gcc-16.1.0 smatch
openrisc             randconfig-r2201-20260928    gcc-11.5.0 smatch
openrisc             randconfig-r2309-20260928    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260928    clang-24
parisc                randconfig-1000-20260929    gcc-8.5.0
parisc                randconfig-1001-20260928    clang-24
parisc                randconfig-1001-20260929    gcc-8.5.0
parisc               randconfig-r2100-20260927    gcc-8.5.0  cocci
parisc               randconfig-r2103-20260927    gcc-13.4.0 cocci
parisc               randconfig-r2105-20260928    gcc-12.5.0 cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       bamboo_defconfig    clang-24
powerpc                  linkstation_defconfig    clang-24
powerpc                  mpc834x_itx_defconfig    clang-24
powerpc                       ppc6xx_defconfig    gcc-16.1.0
powerpc                      rainier_defconfig    clang-24
powerpc               randconfig-1000-20260928    clang-24
powerpc               randconfig-1000-20260929    gcc-8.5.0
powerpc               randconfig-1001-20260928    clang-24
powerpc               randconfig-1001-20260929    gcc-8.5.0
powerpc              randconfig-r2105-20260927    clang-17   cocci
powerpc              randconfig-r2201-20260927    clang-24   smatch
powerpc              randconfig-r2302-20260927    gcc-15.2.0 sparse
powerpc              randconfig-r2305-20260928    clang-17   sparse
powerpc                      redwood_defconfig    gcc-16.1.0
powerpc                          wii_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260928    clang-24
powerpc64             randconfig-1000-20260929    gcc-8.5.0
powerpc64             randconfig-1001-20260928    clang-24
powerpc64             randconfig-1001-20260929    gcc-8.5.0
powerpc64            randconfig-r2100-20260928    clang-17   cocci
powerpc64            randconfig-r2102-20260927    gcc-13.4.0 cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260928    clang-24
riscv                 randconfig-1000-20260929    clang-24
riscv                 randconfig-1001-20260928    clang-24
riscv                 randconfig-1001-20260929    clang-24
riscv                 randconfig-2000-20260927    clang-24
riscv                 randconfig-2000-20260928    gcc-8.5.0
riscv                 randconfig-2001-20260927    clang-24
riscv                 randconfig-2001-20260928    gcc-8.5.0
riscv                randconfig-r2103-20260928    clang-17   cocci
riscv                randconfig-r2201-20260927    gcc-8.5.0  smatch
riscv                randconfig-r2301-20260927    clang-22   sparse
riscv                randconfig-r2307-20260927    clang-24   sparse
riscv                randconfig-r2308-20260927    clang-24   sparse
s390                              alldefconfig    gcc-16.1.0
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260928    clang-24
s390                  randconfig-1000-20260929    clang-24
s390                  randconfig-1001-20260928    clang-24
s390                  randconfig-1001-20260929    clang-24
s390                  randconfig-2000-20260927    clang-24
s390                  randconfig-2000-20260928    gcc-8.5.0
s390                  randconfig-2001-20260927    clang-24
s390                  randconfig-2001-20260928    gcc-8.5.0
s390                        zfcpdump_defconfig    clang-24
sh                                 allnoconfig    clang-24
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    clang-24
sh                         edosk7705_defconfig    gcc-16.1.0
sh                             hp6xx_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260928    clang-24
sh                    randconfig-1000-20260929    clang-24
sh                    randconfig-1001-20260928    clang-24
sh                    randconfig-1001-20260929    clang-24
sh                    randconfig-2000-20260927    clang-24
sh                    randconfig-2000-20260928    gcc-8.5.0
sh                    randconfig-2001-20260927    clang-24
sh                    randconfig-2001-20260928    gcc-8.5.0
sh                   randconfig-r2308-20260927    clang-22   sparse
sh                   randconfig-r2309-20260927    clang-22   sparse
sh                            se7712_defconfig    gcc-16.1.0
sh                    sh7770_generic_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260928    clang-17
sparc                 randconfig-1001-20260928    clang-17
sparc                 randconfig-2000-20260927    gcc-16.1.0
sparc                 randconfig-2000-20260928    gcc-13.4.0
sparc                 randconfig-2001-20260927    gcc-16.1.0
sparc                 randconfig-2001-20260928    gcc-13.4.0
sparc                randconfig-r2105-20260927    clang-24   cocci
sparc                randconfig-r2306-20260927    clang-24   sparse
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260928    clang-17
sparc64               randconfig-1001-20260928    clang-17
sparc64               randconfig-2000-20260927    gcc-16.1.0
sparc64               randconfig-2000-20260928    gcc-13.4.0
sparc64               randconfig-2001-20260927    gcc-16.1.0
sparc64               randconfig-2001-20260928    gcc-13.4.0
sparc64              randconfig-r2101-20260927    gcc-8.5.0  cocci
sparc64              randconfig-r2200-20260928    gcc-11.5.0 smatch
um                                 allnoconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260928    clang-17
um                    randconfig-1001-20260928    clang-17
um                    randconfig-2000-20260927    gcc-16.1.0
um                    randconfig-2000-20260928    gcc-13.4.0
um                    randconfig-2001-20260927    gcc-16.1.0
um                    randconfig-2001-20260928    gcc-13.4.0
um                   randconfig-r2202-20260927    gcc-14     smatch
um                   randconfig-r2302-20260927    clang-22   sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260928    gcc-14
x86_64      buildonly-randconfig-1001-20260928    gcc-14
x86_64      buildonly-randconfig-1002-20260928    gcc-14
x86_64      buildonly-randconfig-1003-20260928    gcc-14
x86_64      buildonly-randconfig-1004-20260928    gcc-14
x86_64      buildonly-randconfig-1005-20260928    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260928    gcc-14
x86_64                randconfig-1001-20260928    gcc-14
x86_64                randconfig-1002-20260928    gcc-14
x86_64                randconfig-1003-20260928    gcc-14
x86_64                randconfig-1004-20260928    gcc-14
x86_64                randconfig-1005-20260928    gcc-14
x86_64                randconfig-1006-20260928    gcc-14
x86_64                randconfig-1007-20260928    gcc-14
x86_64                randconfig-1008-20260928    gcc-14
x86_64                randconfig-1009-20260928    gcc-14
x86_64                randconfig-1010-20260928    gcc-14
x86_64                randconfig-1011-20260928    gcc-14
x86_64                randconfig-1012-20260928    clang-22
x86_64                randconfig-1013-20260928    clang-22
x86_64                randconfig-1014-20260928    clang-22
x86_64                randconfig-1015-20260928    clang-22
x86_64                randconfig-1016-20260928    clang-22
x86_64                randconfig-1017-20260928    clang-22
x86_64                randconfig-2100-20260927    clang-22   cocci
x86_64                randconfig-2100-20260928    gcc-12     cocci
x86_64                randconfig-2101-20260927    clang-22   cocci
x86_64                randconfig-2101-20260928    gcc-12     cocci
x86_64                randconfig-2102-20260927    clang-22   cocci
x86_64                randconfig-2102-20260928    gcc-12     cocci
x86_64                randconfig-2103-20260927    clang-22   cocci
x86_64                randconfig-2103-20260928    gcc-12     cocci
x86_64                randconfig-2200-20260927    gcc-14     smatch
x86_64                randconfig-2200-20260928    gcc-14     smatch
x86_64                randconfig-2300-20260927    clang-22   sparse
x86_64                randconfig-2300-20260927    gcc-14     sparse
x86_64                randconfig-2300-20260928    clang-22   sparse
x86_64                randconfig-2301-20260927    clang-22   sparse
x86_64                randconfig-2301-20260927    gcc-14     sparse
x86_64                randconfig-2301-20260928    clang-22   sparse
x86_64                randconfig-2302-20260927    clang-22   sparse
x86_64                randconfig-2302-20260927    gcc-13     sparse
x86_64                randconfig-2302-20260928    clang-22   sparse
x86_64               randconfig-r2302-20260928    clang-17   sparse
x86_64               randconfig-r2307-20260927    clang-22   sparse
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
xtensa                             allnoconfig    clang-24
xtensa                randconfig-1000-20260928    clang-17
xtensa                randconfig-1001-20260928    clang-17
xtensa                randconfig-2000-20260927    gcc-16.1.0
xtensa                randconfig-2000-20260928    gcc-13.4.0
xtensa                randconfig-2001-20260927    gcc-16.1.0
xtensa                randconfig-2001-20260928    gcc-13.4.0
xtensa               randconfig-r2100-20260927    gcc-13.4.0 cocci
xtensa               randconfig-r2104-20260927    clang-17   cocci
xtensa               randconfig-r2201-20260927    gcc-16.1.0 smatch
xtensa               randconfig-r2309-20260927    clang-24   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
