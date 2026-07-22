Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F641C44536
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jul 2026 12:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 626D780EEF;
	Wed, 22 Jul 2026 12:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VV3C0WoHFbxe; Wed, 22 Jul 2026 12:31:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 770D280EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784723477;
	bh=Ni8v8tsPkLcEatQPmSgD6nUXuOQEPncsU/xalKrrQmo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UNh0OwlCFhy0jGxTObMdHc+vw/0mi6Tk1QT4ndDNi9C4BcMqykTf/eadZ4Vpnw+1D
	 DHMJ3UbBUVtQvecqg8p9c9I1dtviMGjf71KkVqWq+UnDeQEVZkVGMG9ikQTs2OcMg5
	 J61+4YxnW9micBPfYWQZTn0uROvPKmJ4R9nvWhBNEGaksWgtkUveExOGJSVrbldOvh
	 Siv8FkqbsGlpNXp8Bvx6/Aa3oHqvOAP5rgri/G2ZPgXdgYtU21sxHg+kWdrPryK82U
	 H2ZHSkeXoFzNgZTsJ52vNuH4hX+CpRNtuf4pQ9/5J+ZkAp17CA9rOhVRpf6zVPWBFF
	 pgqxYdIdkiKjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 770D280EF2;
	Wed, 22 Jul 2026 12:31:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7BC742A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 12:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE56E40692
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 12:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OflzDlvBUj-f for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jul 2026 12:31:14 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B963B4067B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B963B4067B
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B963B4067B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 12:31:14 +0000 (UTC)
X-CSE-ConnectionGUID: 8+LTkK8LQdCXMLkmboG5dw==
X-CSE-MsgGUID: KQ/pRznXTgqm8rpUgnJO/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="110898841"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="110898841"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 05:31:14 -0700
X-CSE-ConnectionGUID: bYMxh8NgS8OYpmOPjJuZzA==
X-CSE-MsgGUID: YCf+IHfnQIumaoMOkhWqZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="288080175"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by orviesa002.jf.intel.com with ESMTP; 22 Jul 2026 05:31:13 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wmW6Q-00000000Yix-0j4k;
 Wed, 22 Jul 2026 12:31:10 +0000
Date: Wed, 22 Jul 2026 20:30:36 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607222023.Qn5ibikv-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784723475; x=1816259475;
 h=date:from:to:subject:message-id;
 bh=f9PET1yfQvzotdpQ06dPxWkVHzCNsXAZfqh+pLEsEDQ=;
 b=irGSCFciuGnMl+zlFv4MpdzxOQ7Y0HeiT1APsgn7aWbtpy3rSZG6u/d1
 gsdl2EPNNOz1vHJ8Cde0pAJBS7Oq5YRqg/DIer10MNeGemxdgzN6b2o+K
 3U/z81DjoX0n+uCYbZPae9Suq3Zm1DsVEOCuOHr2q6oio12QHt1k9qpVb
 HKGs6wkbBhXRzN2gDBmjB5bSXZeSuzL+q204+CirWgvValb/Gu0qy/mF6
 mhKqPOTFZYo5hHWvalyb1Drxw1/WJ1uYnQ5QckPOPMwLGTDSEvyO22qsD
 YIbIo8q4QdqPaf0V988A6i4FGigP7sxQTMlbjIgCBrOYqCYp+9e23/wed
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=irGSCFci
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 534ae9d0d70cd9fd4879bb853e62cf8947ea01be
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 534ae9d0d70cd9fd4879bb853e62cf8947ea01be  ice: rephrase LLDP filter fallback message

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 777m

configs tested: 74
configs skipped: 1

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260722    gcc-12.5.0
arc                  randconfig-002-20260722    gcc-14.3.0
arm                  randconfig-001-20260722    clang-19
arm                  randconfig-002-20260722    clang-24
arm                  randconfig-003-20260722    clang-24
arm                  randconfig-004-20260722    clang-24
arm                        s3c6400_defconfig    gcc-16.1.0
arm64                randconfig-001-20260722    clang-18
arm64                randconfig-002-20260722    clang-18
arm64                randconfig-003-20260722    gcc-16.1.0
arm64                randconfig-004-20260722    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260722    gcc-10.5.0
csky                 randconfig-002-20260722    gcc-16.1.0
hexagon              randconfig-001-20260722    clang-24
hexagon              randconfig-002-20260722    clang-24
i386                            allmodconfig    gcc-14
i386                 randconfig-001-20260722    gcc-14
i386                 randconfig-002-20260722    gcc-14
i386                 randconfig-005-20260722    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260722    gcc-16.1.0
loongarch            randconfig-002-20260722    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260722    gcc-8.5.0
nios2                randconfig-002-20260722    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260722    gcc-9.5.0
parisc               randconfig-002-20260722    gcc-8.5.0
powerpc              randconfig-001-20260722    gcc-8.5.0
powerpc              randconfig-002-20260722    clang-18
powerpc64            randconfig-001-20260722    gcc-8.5.0
powerpc64            randconfig-002-20260722    clang-24
riscv                randconfig-002-20260722    gcc-10.5.0
s390                 randconfig-001-20260722    gcc-13.4.0
s390                 randconfig-002-20260722    gcc-11.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260722    gcc-16.1.0
sh                   randconfig-002-20260722    gcc-16.1.0
sparc                randconfig-001-20260722    gcc-15.2.0
sparc                randconfig-002-20260722    gcc-16.1.0
sparc64              randconfig-001-20260722    gcc-11.5.0
sparc64              randconfig-002-20260722    gcc-9.5.0
um                   randconfig-001-20260722    gcc-14
um                   randconfig-002-20260722    clang-24
x86_64     buildonly-randconfig-001-20260722    clang-22
x86_64     buildonly-randconfig-002-20260722    gcc-14
x86_64     buildonly-randconfig-003-20260722    gcc-14
x86_64     buildonly-randconfig-004-20260722    clang-22
x86_64     buildonly-randconfig-005-20260722    gcc-14
x86_64     buildonly-randconfig-006-20260722    clang-22
x86_64               randconfig-011-20260722    clang-22
x86_64               randconfig-012-20260722    clang-22
x86_64               randconfig-013-20260722    gcc-14
x86_64               randconfig-014-20260722    clang-22
x86_64               randconfig-015-20260722    gcc-14
x86_64               randconfig-016-20260722    clang-22
x86_64               randconfig-071-20260722    clang-22
x86_64               randconfig-072-20260722    clang-22
x86_64               randconfig-073-20260722    clang-22
x86_64               randconfig-074-20260722    clang-22
x86_64               randconfig-075-20260722    clang-22
x86_64               randconfig-076-20260722    clang-22
xtensa               randconfig-001-20260722    gcc-8.5.0
xtensa               randconfig-002-20260722    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
