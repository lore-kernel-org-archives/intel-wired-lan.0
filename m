Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B47CA9ED1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 13:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 920DF80CDC;
	Mon, 12 Oct 2026 13:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXeAP0FzQABd; Mon, 12 Oct 2026 13:44:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AF5F80DA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791812662;
	b=JIno/aiMUndaFHX2FrtXndNGRpUnMwv3DGt4NaWKBsvA/dvfFzmnfhQ6D2gvC527UeMA
	 uwaFm/xjhwwKFAwjUh6AhTbpp7wMCrLAQ+oGn9M/0eg5xPRmTpRuuREjB2yltw9NIjQQO
	 FYTh0XOcXu7MH2LU6lcqP+iJp6ig5yH6NfoX8fywmnnXmFXnFpg01FpoRBuMj7rRtNlfJ
	 NH9qdB+nHqfSzXRLtMk8QKUlplQAAmNDp2mXqP1sETUCDyOsAV45SQkeAq1ZDI3t9BMIF
	 TEArAEiQIQ3129kXSjr0MQHH6/h4oSDSO32TBLHR+jZqgABkRbs4qWhjXI6brV7MQBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791812662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rSXOVARc7XokSlHb/1EW9mCZnVqM9JzDR/yhRMjpEJs=;
	b=IkD9gtlf509ypDxghrRbqxUzB0RnCUm2wSXsVPVorypiJiGK4cNhX3ljYb2hI0fX+zn+
	 apuAkGYfoTY6jrtrGIBBfS2RLMfx5bwgb4OfpfPOsTTfXGE2dFoUjgGnuwDd8uu5cSgQX
	 5tTjiKZYdz9R8t7H10olzX+l2tAhSU1x357kQvf2uh27VbG5NAf5F7ApcPKpqpVKi3zSm
	 frk+Oz352ABVCsJQ9CFH7QQPwlsejvX59uOqFZmATIlTRX6SqpSOEH85S0vdgIjCZAlsY
	 +VxrRg4nCTpz6FWGmuC1fvv2aniZn7fNKgAGDCcpYzEWRX6B7WPBNNBrzTEXYJl2Cbg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791812662;
	bh=rSXOVARc7XokSlHb/1EW9mCZnVqM9JzDR/yhRMjpEJs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FFIdzRgLciP3ey34GAReEppLEumw29oEBI/Sy6w7dzsd06HE8K6piQ6TJzAnQb3jA
	 ifSinOouqmza2qw8T7KXKmaiH0bIU/KBts+V2kZuSiyGSNeGhFtHP8SX3BNceKN+O6
	 DX4gAvNfZYWCoRatGUlkG/xgiWl3MT+PkUEq8sydtt3VVkeRd902CqQWDQibAIGH1m
	 IYq2n7/Y+39PXDVN2yPZNwrx+rUKYIfcxbHzfJh1XV/wjt45AMsN3gWK8T2Q8mbnQ0
	 gag8aUxx3OWuipYDiDB+MB0D24ZfQ+uYpFqmLNu7FBuVwwtUgZM4p0Cx3D6GXFwyCW
	 hutgSQq00eyiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AF5F80DA2;
	Mon, 12 Oct 2026 13:44:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 14E80179
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06C244004D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:44:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbFrRmRLKzGd for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 13:44:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A636E4010F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791812659;
 b=oZhrrmmBlpYHPVJ4MHqSYVTDPkevVcyNxmKiGhnRvj41VTT9HN41GkMCxitSrdBn3/xl
 t2GdiDFFVbFz1M5er/h9CT/IODXSgGvKRJGEXiwfWDCD4LwdPVFUkUHvaia2p8eRwyl3n
 4Adhj9dYDKdLBVz3kMy4brmCKodfywDPH2mR7DK4OIyAvKru6GalLBO0sfCdaX3qfiBUy
 6rsOF6vOj7tq1Ccct0PU+eCxmSyLSzd1jTvDIbuoJESgmxgsx+tn1RwvLYEG1M1Z6tyJe
 KLwkNQiBtXkahIytiIHJPFvk3sC8sRr0qK8Y1hNN1YHe/FDbMyse32qSfvxcPecYHKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791812659;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=rSXOVARc7XokSlHb/1EW9mCZnVqM9JzDR/yhRMjpEJs=;
 b=ZoWUHZFIAiA9uWCDY4FM6RXxw3vaUt/Y2EEAFKWM6hCq9WfQxQiZqvHT5dU3xwrsfEDE
 DyT5aNDQ17GS1QCThmd+pggnzkamuaWfex5i3Ugw+4IWQcdIgBYeNNAMB2yHtXKc537Nw
 zdaXfPYCCB7MFLCsRpOrq4uN8b6Swab8183wqSwxIoTB/mcz1U/XhbthT1iLV8+gjiG6H
 zU3v53ex0XKoQK1kus44bgMg8IiSSEQBMzDyhTdzqTSlSH0ex0ilisZiANch0CpKpPweM
 frD+dmPph8yy/tHRW241UzmNxbaE28ACtw0K5XeIKmU06c4q6ZGaJWfzrvMt6QNFK2g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UNFVBnW0; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UNFVBnW0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A636E4010F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791812660; x=1823348660; h=date:from:to:subject:message-id;
 bh=4aMD1ffD1j97LQO7EIlktYHTGMP0ff38VW+8AxpKbIU=;
 b=UNFVBnW0aB3O5fiCAzeobrpFAtC2q9lJ7dn/+RwjXT4LmxHehKkRx89h
 i2xQR97QrhnXeHWwJ0EyACE840CcTCgNjtJKbe1tBgrRlgK1fLFzLiCFt
 Fg7ow7IuliEuL9c/oTn0wHOd8vnH7bI4raq9FYrYaWXcpRp+6jj89B0SG
 6ALSJcHrSKLhopT8Vs3zem+XVI38lVdKfrJ9hfe0ZEVPskM6Zyv3J1Vur
 FRHeNvTKZkXDcQZfM0bFwKa22vR4H74CWXFNHCRjioXz+yrVvC3/JGMSL
 MSOVxTIOh4W+Lz7m+0rSiBhsPXjuKKLZHtLEkfXqLxfslBg5Bm9UiNGYU w==;
X-CSE-ConnectionGUID: KDpUDpylRBOx8rYO9qc7Kg==
X-CSE-MsgGUID: uZdmdkJPSvK+73pPhCT3ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="418845"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="418845"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 06:44:18 -0700
X-CSE-ConnectionGUID: LXCWpzJqTKiBK5KajIAW/Q==
X-CSE-MsgGUID: M0EJGNBFRHygFlfsHgu1pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="816829"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 12 Oct 2026 06:44:18 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xGGK6-00000000BYf-3whR;
 Mon, 12 Oct 2026 13:44:14 +0000
Date: Mon, 12 Oct 2026 21:43:15 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 d2e3fa79cfab4d5c5715d6503a77c8648ef3c76c
Message-ID: <202610122112.eYYCeQAN-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: d2e3fa79cfab4d5c5715d6503a77c8648ef3c76c  ice: keep the RSS hash function on indirection-only updates

elapsed time: 3419m

configs tested: 335
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2102-20261010    gcc-12.5.0 cocci
alpha                randconfig-r2104-20261010    gcc-16.1.0 cocci
alpha                randconfig-r2107-20261010    gcc-8.5.0  cocci
alpha                randconfig-r2201-20261010    gcc-8.5.0  smatch
alpha                randconfig-r2303-20261010    gcc-16.1.0 sparse
alpha                randconfig-r2306-20261010    gcc-10.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261012    gcc-8.5.0
arc                   randconfig-1001-20261012    gcc-8.5.0
arc                  randconfig-r2302-20261010    gcc-8.5.0  sparse
arc                  randconfig-r2304-20261010    gcc-13.4.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    gcc-11.5.0
arm                                  defconfig    gcc-16.1.0
arm                           exynos_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261012    gcc-8.5.0
arm                   randconfig-1001-20261012    gcc-8.5.0
arm                   randconfig-1002-20261012    gcc-8.5.0
arm                   randconfig-1003-20261012    gcc-8.5.0
arm                  randconfig-r2105-20261010    gcc-8.5.0  cocci
arm                  randconfig-r2300-20261010    clang-22   sparse
arm                  randconfig-r2303-20261010    gcc-8.5.0  sparse
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261012    clang-24
arm64                 randconfig-1001-20261012    clang-24
arm64                 randconfig-1002-20261012    clang-24
arm64                 randconfig-1003-20261012    clang-24
arm64                randconfig-r2101-20261010    gcc-10.5.0 cocci
arm64                randconfig-r2107-20261010    gcc-16.1.0 cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261012    clang-24
csky                  randconfig-1001-20261012    clang-24
csky                 randconfig-r2100-20261010    gcc-13.4.0 cocci
csky                 randconfig-r2111-20261010    gcc-16.1.0 cocci
csky                 randconfig-r2300-20261010    gcc-16.1.0 sparse
csky                 randconfig-r2306-20261010    clang-24   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261011    clang-24
hexagon               randconfig-1000-20261012    clang-17
hexagon               randconfig-1001-20261011    clang-24
hexagon               randconfig-1001-20261012    clang-17
hexagon              randconfig-r2200-20261010    clang-24   smatch
hexagon              randconfig-r2306-20261010    gcc-16.1.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261012    clang-22
i386        buildonly-randconfig-1001-20261012    clang-22
i386        buildonly-randconfig-1002-20261012    clang-22
i386        buildonly-randconfig-1003-20261012    clang-22
i386        buildonly-randconfig-1004-20261012    clang-22
i386        buildonly-randconfig-1005-20261012    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261011    clang-22
i386                  randconfig-1000-20261012    gcc-14
i386                  randconfig-1001-20261011    clang-22
i386                  randconfig-1001-20261012    gcc-14
i386                  randconfig-1002-20261011    clang-22
i386                  randconfig-1002-20261012    gcc-14
i386                  randconfig-1003-20261011    clang-22
i386                  randconfig-1003-20261012    gcc-14
i386                  randconfig-1004-20261011    clang-22
i386                  randconfig-1004-20261012    gcc-14
i386                  randconfig-1005-20261011    clang-22
i386                  randconfig-1005-20261012    gcc-14
i386                  randconfig-1006-20261011    clang-22
i386                  randconfig-1006-20261012    gcc-14
i386                  randconfig-1007-20261012    clang-22
i386                  randconfig-1008-20261012    clang-22
i386                  randconfig-1009-20261012    clang-22
i386                  randconfig-1010-20261012    clang-22
i386                  randconfig-1011-20261012    clang-22
i386                  randconfig-1012-20261012    clang-22
i386                  randconfig-1013-20261012    clang-22
i386                  randconfig-2100-20261010    clang-22   cocci
i386                  randconfig-2100-20261010    gcc-13     cocci
i386                  randconfig-2100-20261010    gcc-14     cocci
i386                  randconfig-2101-20261010    clang-22   cocci
i386                  randconfig-2101-20261010    gcc-13     cocci
i386                  randconfig-2101-20261010    gcc-14     cocci
i386                  randconfig-2102-20261010    clang-22   cocci
i386                  randconfig-2102-20261010    gcc-13     cocci
i386                  randconfig-2103-20261010    clang-22   cocci
i386                  randconfig-2103-20261010    gcc-13     cocci
i386                  randconfig-2104-20261010    gcc-13     cocci
i386                  randconfig-2105-20261010    gcc-13     cocci
i386                  randconfig-2200-20261010    gcc-12     smatch
i386                  randconfig-2300-20261010    gcc-14     sparse
i386                  randconfig-2301-20261010    gcc-14     sparse
i386                  randconfig-2302-20261010    clang-22   sparse
i386                  randconfig-2302-20261010    gcc-14     sparse
i386                 randconfig-r2305-20261010    gcc-8.5.0  sparse
i386                 randconfig-r2308-20261010    gcc-16.1.0 sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261011    clang-24
loongarch             randconfig-1000-20261012    clang-17
loongarch             randconfig-1001-20261011    clang-24
loongarch             randconfig-1001-20261012    clang-17
loongarch             randconfig-2000-20261010    gcc-8.5.0
loongarch             randconfig-2001-20261010    gcc-8.5.0
loongarch            randconfig-r2108-20261010    gcc-12.5.0 cocci
loongarch            randconfig-r2304-20261010    gcc-8.5.0  sparse
loongarch            randconfig-r2309-20261010    gcc-16.1.0 sparse
loongarch            randconfig-r2311-20261010    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                         mvme16x_defconfig    gcc-16.1.0
m68k                 randconfig-r2100-20261010    gcc-12.5.0 cocci
m68k                 randconfig-r2110-20261010    gcc-16.1.0 cocci
m68k                 randconfig-r2303-20261010    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2103-20261010    gcc-10.5.0 cocci
microblaze           randconfig-r2309-20261010    gcc-12.5.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           eyeq6_defconfig    gcc-16.1.0
mips                 randconfig-r2100-20261010    gcc-10.5.0 cocci
mips                 randconfig-r2301-20261010    gcc-8.5.0  sparse
mips                 randconfig-r2309-20261010    clang-24   sparse
mips                           rm200_defconfig    gcc-11.5.0
nios2                          3c120_defconfig    gcc-11.5.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261011    clang-24
nios2                 randconfig-1000-20261012    clang-17
nios2                 randconfig-1001-20261011    clang-24
nios2                 randconfig-1001-20261012    clang-17
nios2                 randconfig-2000-20261010    gcc-8.5.0
nios2                 randconfig-2001-20261010    gcc-8.5.0
nios2                randconfig-r2106-20261010    gcc-8.5.0  cocci
nios2                randconfig-r2308-20261010    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2301-20261010    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261011    clang-24
parisc                randconfig-1000-20261012    gcc-8.5.0
parisc                randconfig-1001-20261011    clang-24
parisc                randconfig-1001-20261012    gcc-8.5.0
parisc                randconfig-2000-20261010    gcc-8.5.0
parisc                randconfig-2001-20261010    gcc-8.5.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                        eiger_defconfig    gcc-11.5.0
powerpc                    lite5200b_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261011    clang-24
powerpc               randconfig-1000-20261012    gcc-8.5.0
powerpc               randconfig-1001-20261011    clang-24
powerpc               randconfig-1001-20261012    gcc-8.5.0
powerpc               randconfig-2000-20261010    gcc-14
powerpc               randconfig-2001-20261010    gcc-14
powerpc              randconfig-r2107-20261010    clang-20   cocci
powerpc              randconfig-r2201-20261010    gcc-16.1.0 smatch
powerpc              randconfig-r2301-20261010    gcc-16.1.0 sparse
powerpc              randconfig-r2302-20261010    gcc-8.5.0  sparse
powerpc              randconfig-r2305-20261010    gcc-15.2.0 sparse
powerpc64             randconfig-1000-20261011    clang-24
powerpc64             randconfig-1000-20261012    gcc-8.5.0
powerpc64             randconfig-1001-20261011    clang-24
powerpc64             randconfig-1001-20261012    gcc-8.5.0
powerpc64             randconfig-2000-20261010    gcc-14
powerpc64             randconfig-2001-20261010    gcc-14
powerpc64            randconfig-r2104-20261010    clang-20   cocci
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261012    clang-24
riscv                 randconfig-1001-20261012    clang-24
riscv                 randconfig-2000-20261010    gcc-16.1.0
riscv                 randconfig-2000-20261010    gcc-9.5.0
riscv                 randconfig-2001-20261010    clang-24
riscv                 randconfig-2001-20261010    gcc-16.1.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261012    clang-24
s390                  randconfig-1001-20261012    clang-24
s390                  randconfig-2000-20261010    clang-17
s390                  randconfig-2000-20261010    gcc-16.1.0
s390                  randconfig-2001-20261010    gcc-15.2.0
s390                  randconfig-2001-20261010    gcc-16.1.0
s390                 randconfig-r2102-20261010    gcc-10.5.0 cocci
s390                 randconfig-r2305-20261010    gcc-16.1.0 sparse
s390                 randconfig-r2307-20261010    gcc-16.1.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                             migor_defconfig    gcc-11.5.0
sh                    randconfig-1000-20261012    clang-24
sh                    randconfig-1001-20261012    clang-24
sh                    randconfig-2000-20261010    gcc-16.1.0
sh                    randconfig-2001-20261010    gcc-16.1.0
sh                   randconfig-r2101-20261010    gcc-14.3.0 cocci
sh                   randconfig-r2102-20261010    gcc-12.5.0 cocci
sh                   randconfig-r2105-20261010    gcc-16.1.0 cocci
sh                   randconfig-r2200-20261010    gcc-9.5.0  smatch
sh                   randconfig-r2310-20261010    clang-24   sparse
sh                    secureedge5410_defconfig    gcc-11.5.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261011    gcc-9.5.0
sparc                 randconfig-1000-20261012    clang-20
sparc                 randconfig-1001-20261011    gcc-9.5.0
sparc                 randconfig-1001-20261012    clang-20
sparc                 randconfig-2000-20261010    gcc-16.1.0
sparc                 randconfig-2000-20261010    gcc-8.5.0
sparc                 randconfig-2001-20261010    gcc-16.1.0
sparc                randconfig-r2106-20261010    clang-20   cocci
sparc                randconfig-r2109-20261010    gcc-12.5.0 cocci
sparc                randconfig-r2200-20261010    gcc-16.1.0 smatch
sparc                randconfig-r2304-20261010    gcc-16.1.0 sparse
sparc                randconfig-r2307-20261010    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261011    gcc-9.5.0
sparc64               randconfig-1000-20261012    clang-20
sparc64               randconfig-1001-20261011    gcc-9.5.0
sparc64               randconfig-1001-20261012    clang-20
sparc64               randconfig-2000-20261010    gcc-16.1.0
sparc64               randconfig-2000-20261010    gcc-8.5.0
sparc64               randconfig-2001-20261010    clang-21
sparc64               randconfig-2001-20261010    gcc-16.1.0
sparc64              randconfig-r2103-20261010    gcc-15.2.0 cocci
sparc64              randconfig-r2200-20261010    gcc-16.1.0 smatch
sparc64              randconfig-r2308-20261010    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261011    gcc-9.5.0
um                    randconfig-1000-20261012    clang-20
um                    randconfig-1001-20261011    gcc-9.5.0
um                    randconfig-1001-20261012    clang-20
um                    randconfig-2000-20261010    clang-24
um                    randconfig-2000-20261010    gcc-16.1.0
um                    randconfig-2001-20261010    clang-24
um                    randconfig-2001-20261010    gcc-16.1.0
um                   randconfig-r2105-20261010    clang-20   cocci
um                   randconfig-r2106-20261010    gcc-16.1.0 cocci
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261012    clang-22
x86_64                randconfig-1001-20261012    clang-22
x86_64                randconfig-1002-20261012    clang-22
x86_64                randconfig-1003-20261012    clang-22
x86_64                randconfig-1004-20261012    clang-22
x86_64                randconfig-1005-20261012    clang-22
x86_64                randconfig-1006-20261012    clang-22
x86_64                randconfig-1007-20261012    clang-22
x86_64                randconfig-1008-20261012    clang-22
x86_64                randconfig-1009-20261012    clang-22
x86_64                randconfig-1010-20261012    clang-22
x86_64                randconfig-1011-20261012    clang-22
x86_64                randconfig-1012-20261012    gcc-14
x86_64                randconfig-1013-20261012    gcc-14
x86_64                randconfig-1014-20261012    gcc-14
x86_64                randconfig-1015-20261012    gcc-14
x86_64                randconfig-1016-20261012    gcc-14
x86_64                randconfig-1017-20261012    gcc-14
x86_64                randconfig-2000-20261010    gcc-14
x86_64                randconfig-2001-20261010    gcc-14
x86_64                randconfig-2100-20261010    clang-22   cocci
x86_64                randconfig-2101-20261010    clang-22   cocci
x86_64                randconfig-2102-20261010    clang-22   cocci
x86_64                randconfig-2103-20261010    clang-22   cocci
x86_64                randconfig-2104-20261010    clang-22   cocci
x86_64                randconfig-2105-20261010    clang-22   cocci
x86_64                randconfig-2200-20261010    gcc-14     smatch
x86_64                randconfig-2300-20261010    clang-22   sparse
x86_64                randconfig-2300-20261010    gcc-14     sparse
x86_64                randconfig-2301-20261010    clang-22   sparse
x86_64                randconfig-2301-20261010    gcc-14     sparse
x86_64                randconfig-2302-20261010    clang-22   sparse
x86_64                randconfig-2302-20261010    gcc-14     sparse
x86_64               randconfig-r2104-20261010    gcc-8.5.0  cocci
x86_64               randconfig-r2201-20261010    clang-22   smatch
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
xtensa                           iss_defconfig    gcc-16.1.0
xtensa                   nommu_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20261011    gcc-9.5.0
xtensa                randconfig-1000-20261012    clang-20
xtensa                randconfig-1001-20261011    gcc-9.5.0
xtensa                randconfig-1001-20261012    clang-20
xtensa                randconfig-2000-20261010    gcc-10.5.0
xtensa                randconfig-2000-20261010    gcc-16.1.0
xtensa                randconfig-2001-20261010    gcc-16.1.0
xtensa               randconfig-r2101-20261010    gcc-12.5.0 cocci
xtensa               randconfig-r2202-20261010    gcc-8.5.0  smatch
xtensa               randconfig-r2300-20261010    gcc-8.5.0  sparse
xtensa               randconfig-r2302-20261010    gcc-16.1.0 sparse
xtensa               randconfig-r2307-20261010    clang-24   sparse
xtensa                     xip_kc705_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
