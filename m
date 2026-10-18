Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD449CCF2C9
	for <intel-wired-lan@archiver.kernel.org>; Sun, 18 Oct 2026 15:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5600080F80;
	Sun, 18 Oct 2026 15:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IbLp7n2PsvQR; Sun, 18 Oct 2026 15:47:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 112B380F81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792338431;
	b=a3K0n/XJh6svK3RURc6VB/AYAo2bFBZRzXmYKLGOY2FSKDRp+mVimYmBbUGdaM9+IkPC
	 MDWBA2oXqH3OQgXweYSuBnr1fZA6KexbIp9/QO8g1N3ixcciplzZ8JCBJFcMs8EXWSuBH
	 Nlatuzes9NYfavC0Pi1MTT2xXlWGTv13+35LYsOkErfNDNwHEejQhspWih6kCYZTCR+8Q
	 Rl6ChRDcg4sjOiOKPVy4VG1xdH7CUtwi4cSXdzYAO3vTxypNzDBnIrPWGVKT07vIpL10C
	 A5JR351gSKU7l+E2bcDxebPXy/IllHiljbLfFJ9t3u3MtJNgTVy4gf7nGjBZSs/nIYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792338431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Y8J1RglLQBqj95hQ+TQwpDQGCXy1ohQyEcHOpK/wmis=;
	b=gyCMLhtmdbeTk8rG/Jas5eXI55Vj0TkZinApXOih6VixgFmAQgVbOW/sgaYFTn42fjAS
	 wPp4/s4J5X5jIwMcSt0duRPMr1peAlmuFnzExlFvILWyrP/pBybBAMFoU+Pau6na5jJx6
	 YoYruDCwACoBAlXMo6KC9CCaza/I0uHB1XPvAdc/TC82W4KjbBJXXwk76A547Q/IgcX6A
	 R24EYDW6uIZsEocLcBLZaRppDR7r5Jd8Ze5QIVGjN+CT0IOW5FYnn6Q5G6EKAPW9OemvF
	 SAXrlpmIpkc2YzOgsgFLMd+1+LIn/c58GX3exp+9NE5cyjBY77TiYZZRu/btSbcpsjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JL9z2l5W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792338431;
	bh=Y8J1RglLQBqj95hQ+TQwpDQGCXy1ohQyEcHOpK/wmis=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iRGmXrQABp2ZamijU+MYfD6qORPfI6zU9j90+nr5JRcuILSgd7iZ0iSTeg8QnH+cH
	 GB0i2oTxg5iCX2NlIDtLX22x+zizmLu9ZVjNMXorWCNsm2qNDLhae2e2Ktn80Kw9R2
	 +NY+/XOYHx3LzEh9VK049BzS+WTa7e9CJuUI28cCThkuNNziF1dEE4fGwm1bU8SsUA
	 9y7CYR/Tf/VrF8NnVxZ+KRlGgRglJxBsI70K/tGnj205B8mrLPacm6XCW/sxjkzn57
	 GLf+l1oDFy4tXj1nBmuHMNfQJqfkn1jTTtAzeU22+k7YHOeVHULxDR8V/N9gfNgDpf
	 VTK8g56+zT/tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 112B380F81;
	Sun, 18 Oct 2026 15:47:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E33A2255
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 15:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC5B080F81
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 15:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjWVJRDyNZQ3 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 18 Oct 2026 15:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB52A80F80
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792338428;
 b=NYZ/g95GImlyaAdJ4PWdcRrrUYfCLCenCTXIfd+mJAGUlOqqKWV5CGmzCTBoPQHgyX46
 yBkA3RL1hUSmg/edHxhPzoWk9G3XmLqebsOOd0w1nRQl2jHUayx49ZmqUHGGaBkuUSnv0
 lBgDppi8RIcThTkVRePbM2SKUp4uff8uOuPYKOnVnaMvpvvyIZyODgV+5sq2Ukyh2d/Sn
 fqfLLUBOCdHN7V6cZxnefTEE7CKaP4KbeTbxcc0lHh1um7xOWxaXvhpB/QTVJnaoqBTBu
 uiFBGETDQz2Vv+B64XJA0S+5CbIM83RIlw/+zrPDF+25bX7Yc29VRMrjP+AsgJc1sMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792338428;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=Y8J1RglLQBqj95hQ+TQwpDQGCXy1ohQyEcHOpK/wmis=;
 b=My1MVPR+QFsOZzuezwB8ym/e9BxmjvI8ojYRteezpDrXVQs91G1nK2UyJsh24ZMDI+V1
 qNLdTNqM/KtfKfOrlghTjqj6C8BK12eM9E6ilB8ppkqq+Em4r0XWvcc03E52EWKFec177
 Fna9C3o+UXliZ8AVFaLkvX8gcDKpb5TzCZk3L1WwFxuM6bWeNkuBRE1C57yjHCbduqV1u
 +L56GKk77DNYntl6l0h//ndwKvbUxmpTF4Gx3wxoc5KCCw6JhXYx65DtAKi/gJoEunOXV
 DdMaLx9g9RBrMwjcSO0iLSumOkQlvQZfYZFSNJlWW6QmsBgz/BjSoZMZRu//EIlfSsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JL9z2l5W; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JL9z2l5W
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB52A80F80
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792338428; x=1823874428; h=date:from:to:subject:message-id;
 bh=iPhMWPKkLgjVOPtQsv0U2B9SVue4KTyOBXYowxT1IaA=;
 b=JL9z2l5W6ucD8Dqbong5i02yAgWM6ylhTmbruTu+J15ZZMROI4ryuUZJ
 w6v2dd2GceCmqz+o8UkFOd5uKUnpcGvebOMN73q6vXKqwnHvPpdE6vzVa
 Xw+qI3WmfdB9gZmVcip9y6z8LV1lGkFIQ8IAecRr/fZy+FPjiUfd2w2WS
 fZvt9A32DSwOY+w/WVlNwD7so+8ToS7W++jFgz4ypODA9mzI+0L6zaloP
 ceYjTeZHfZkd+snesfLAq9aAgxqXJKJs2OVUdJmqylXbDSmEVh8EkTtr2
 CdAbNg/sB9g46lOukUFEYwpmZU4hhRTP23u+AslikS/yY0gvfxMJhOeKm g==;
X-CSE-ConnectionGUID: XK/BTkpBTSWfS9Ex47uTpQ==
X-CSE-MsgGUID: GuS8Dk1OSMCtCCY5G4RAGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="920215"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="920215"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 08:47:05 -0700
X-CSE-ConnectionGUID: nZWDyHJkSzGXJgVKKgNlVg==
X-CSE-MsgGUID: 3fWMeEMJQVORtMfYWkKWSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2277081"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 18 Oct 2026 08:47:04 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xIT6E-00000000KXi-1Eyh;
 Sun, 18 Oct 2026 15:47:02 +0000
Date: Sun, 18 Oct 2026 23:46:33 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 29483e6efe1e5b7ee587b01d20c1053121374990
Message-ID: <202610182330.vpL4nRPY-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 29483e6efe1e5b7ee587b01d20c1053121374990  ice: don't clear in_use until HW clears ready bitmap

elapsed time: 3013m

configs tested: 327
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261017    gcc-10.5.0
arc                   randconfig-1000-20261018    gcc-8.5.0
arc                   randconfig-1001-20261017    gcc-10.5.0
arc                   randconfig-1001-20261018    gcc-8.5.0
arc                   randconfig-2000-20261016    gcc-8.5.0
arc                   randconfig-2001-20261016    gcc-8.5.0
arc                         vdk_hs38_defconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                        aspeed_g4_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                       footbridge_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                        netwinder_defconfig    gcc-16.1.0
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261017    gcc-10.5.0
arm                   randconfig-1000-20261018    gcc-8.5.0
arm                   randconfig-1001-20261017    gcc-10.5.0
arm                   randconfig-1001-20261018    gcc-8.5.0
arm                   randconfig-1002-20261017    gcc-10.5.0
arm                   randconfig-1002-20261018    gcc-8.5.0
arm                   randconfig-1003-20261017    gcc-10.5.0
arm                   randconfig-1003-20261018    gcc-8.5.0
arm                   randconfig-2000-20261016    gcc-12.5.0
arm                   randconfig-2001-20261016    gcc-8.5.0
arm                  randconfig-r2305-20261016    clang-24   sparse
arm                        spear13xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261017    clang-24
arm64                 randconfig-1000-20261018    gcc-14.3.0
arm64                 randconfig-1001-20261017    clang-24
arm64                 randconfig-1001-20261018    gcc-14.3.0
arm64                 randconfig-1002-20261017    clang-24
arm64                 randconfig-1002-20261018    gcc-14.3.0
arm64                 randconfig-1003-20261017    clang-24
arm64                 randconfig-1003-20261018    gcc-14.3.0
arm64                 randconfig-2000-20261016    gcc-13.4.0
arm64                 randconfig-2001-20261016    clang-18
arm64                randconfig-r2202-20261016    clang-17   smatch
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261017    clang-24
csky                  randconfig-1000-20261018    gcc-14.3.0
csky                  randconfig-1001-20261017    clang-24
csky                  randconfig-1001-20261018    gcc-14.3.0
csky                  randconfig-2000-20261016    gcc-16.1.0
csky                  randconfig-2001-20261016    gcc-12.5.0
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261017    clang-21
hexagon               randconfig-1000-20261018    clang-21
hexagon               randconfig-1001-20261017    clang-21
hexagon               randconfig-1001-20261018    clang-21
hexagon               randconfig-2000-20261016    clang-22
hexagon               randconfig-2001-20261016    clang-22
hexagon              randconfig-r2110-20261016    clang-18   cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261017    gcc-14
i386        buildonly-randconfig-1000-20261018    clang-22
i386        buildonly-randconfig-1001-20261017    gcc-14
i386        buildonly-randconfig-1001-20261018    clang-22
i386        buildonly-randconfig-1002-20261017    gcc-14
i386        buildonly-randconfig-1002-20261018    clang-22
i386        buildonly-randconfig-1003-20261017    gcc-14
i386        buildonly-randconfig-1003-20261018    clang-22
i386        buildonly-randconfig-1004-20261017    gcc-14
i386        buildonly-randconfig-1004-20261018    clang-22
i386        buildonly-randconfig-1005-20261017    gcc-14
i386        buildonly-randconfig-1005-20261018    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261017    clang-22
i386                  randconfig-1000-20261018    gcc-14
i386                  randconfig-1001-20261017    clang-22
i386                  randconfig-1001-20261018    gcc-14
i386                  randconfig-1002-20261017    clang-22
i386                  randconfig-1002-20261018    gcc-14
i386                  randconfig-1003-20261017    clang-22
i386                  randconfig-1003-20261018    gcc-14
i386                  randconfig-1004-20261017    clang-22
i386                  randconfig-1004-20261018    gcc-14
i386                  randconfig-1005-20261017    clang-22
i386                  randconfig-1005-20261018    gcc-14
i386                  randconfig-1006-20261017    clang-22
i386                  randconfig-1006-20261018    gcc-14
i386                  randconfig-1007-20261017    clang-22
i386                  randconfig-1007-20261018    gcc-14
i386                  randconfig-1008-20261017    clang-22
i386                  randconfig-1008-20261018    gcc-14
i386                  randconfig-1009-20261017    clang-22
i386                  randconfig-1009-20261018    gcc-14
i386                  randconfig-1010-20261017    clang-22
i386                  randconfig-1010-20261018    gcc-14
i386                  randconfig-1011-20261017    clang-22
i386                  randconfig-1011-20261018    gcc-14
i386                  randconfig-1012-20261017    clang-22
i386                  randconfig-1012-20261018    gcc-14
i386                  randconfig-1013-20261017    clang-22
i386                  randconfig-1013-20261018    gcc-14
i386                  randconfig-2000-20261016    clang-22
i386                  randconfig-2001-20261016    clang-22
i386                  randconfig-2200-20261016    clang-22   smatch
i386                  randconfig-2300-20261016    gcc-14     sparse
i386                  randconfig-2301-20261016    clang-22   sparse
i386                  randconfig-2302-20261016    clang-22   sparse
i386                 randconfig-r2104-20261016    clang-22   cocci
i386                 randconfig-r2106-20261016    gcc-14     cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261017    clang-21
loongarch             randconfig-1000-20261018    clang-21
loongarch             randconfig-1001-20261017    clang-21
loongarch             randconfig-1001-20261018    clang-21
loongarch             randconfig-2000-20261016    gcc-16.1.0
loongarch             randconfig-2001-20261016    clang-18
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5475evb_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                        bmips_be_defconfig    gcc-16.1.0
mips                       bmips_stb_defconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                            ip30_defconfig    clang-24
mips                            mtx1_defconfig    gcc-16.1.0
mips                    sb1250_swarm_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261017    clang-21
nios2                 randconfig-1000-20261018    clang-21
nios2                 randconfig-1001-20261017    clang-21
nios2                 randconfig-1001-20261018    clang-21
nios2                 randconfig-2000-20261016    gcc-8.5.0
nios2                 randconfig-2001-20261016    gcc-11.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261017    gcc-15.2.0
parisc                randconfig-1000-20261018    clang-24
parisc                randconfig-1001-20261017    gcc-15.2.0
parisc                randconfig-1001-20261018    clang-24
parisc                randconfig-2000-20261016    gcc-8.5.0
parisc                randconfig-2001-20261016    gcc-10.5.0
parisc               randconfig-r2111-20261016    gcc-8.5.0  cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    clang-24
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261017    gcc-15.2.0
powerpc               randconfig-1000-20261018    clang-24
powerpc               randconfig-1001-20261017    gcc-15.2.0
powerpc               randconfig-1001-20261018    clang-24
powerpc                      redwood_defconfig    gcc-16.1.0
powerpc                     socrates_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261017    gcc-15.2.0
powerpc64             randconfig-1000-20261018    clang-24
powerpc64             randconfig-1001-20261017    gcc-15.2.0
powerpc64             randconfig-1001-20261018    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261017    clang-19
riscv                 randconfig-1000-20261018    clang-17
riscv                 randconfig-1001-20261017    clang-19
riscv                 randconfig-1001-20261018    clang-17
riscv                 randconfig-2000-20261016    clang-24
riscv                 randconfig-2001-20261016    clang-24
riscv                randconfig-r2200-20261016    clang-24   smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261017    clang-19
s390                  randconfig-1000-20261018    clang-17
s390                  randconfig-1001-20261017    clang-19
s390                  randconfig-1001-20261018    clang-17
s390                  randconfig-2000-20261016    clang-24
s390                  randconfig-2001-20261016    gcc-8.5.0
s390                 randconfig-r2304-20261016    gcc-13.4.0 sparse
sh                                alldefconfig    gcc-16.1.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                             migor_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261017    clang-19
sh                    randconfig-1000-20261018    clang-17
sh                    randconfig-1001-20261017    clang-19
sh                    randconfig-1001-20261018    clang-17
sh                    randconfig-2000-20261016    gcc-16.1.0
sh                    randconfig-2001-20261016    gcc-12.5.0
sh                   randconfig-r2301-20261016    gcc-10.5.0 sparse
sh                           rsk7264_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261017    gcc-15.2.0
sparc                 randconfig-1000-20261018    clang-24
sparc                 randconfig-1001-20261017    gcc-15.2.0
sparc                 randconfig-1001-20261018    clang-24
sparc                 randconfig-2000-20261016    gcc-16.1.0
sparc                 randconfig-2001-20261016    gcc-12.5.0
sparc                randconfig-r2107-20261016    gcc-8.5.0  cocci
sparc                        sparc32_defconfig    clang-24
sparc64                           alldefconfig    gcc-16.1.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261017    gcc-15.2.0
sparc64               randconfig-1000-20261018    clang-24
sparc64               randconfig-1001-20261017    gcc-15.2.0
sparc64               randconfig-1001-20261018    clang-24
sparc64               randconfig-2000-20261016    clang-24
sparc64               randconfig-2001-20261016    clang-24
sparc64              randconfig-r2300-20261016    clang-20   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261017    gcc-15.2.0
um                    randconfig-1000-20261018    clang-24
um                    randconfig-1001-20261017    gcc-15.2.0
um                    randconfig-1001-20261018    clang-24
um                    randconfig-2000-20261016    clang-17
um                    randconfig-2001-20261016    gcc-14
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261017    gcc-14
x86_64      buildonly-randconfig-1000-20261018    clang-22
x86_64      buildonly-randconfig-1001-20261017    gcc-14
x86_64      buildonly-randconfig-1001-20261018    clang-22
x86_64      buildonly-randconfig-1002-20261017    gcc-14
x86_64      buildonly-randconfig-1002-20261018    clang-22
x86_64      buildonly-randconfig-1003-20261017    gcc-14
x86_64      buildonly-randconfig-1003-20261018    clang-22
x86_64      buildonly-randconfig-1004-20261017    gcc-14
x86_64      buildonly-randconfig-1004-20261018    clang-22
x86_64      buildonly-randconfig-1005-20261017    gcc-14
x86_64      buildonly-randconfig-1005-20261018    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261017    gcc-14
x86_64                randconfig-1000-20261018    clang-22
x86_64                randconfig-1001-20261017    gcc-14
x86_64                randconfig-1001-20261018    clang-22
x86_64                randconfig-1002-20261017    gcc-14
x86_64                randconfig-1002-20261018    clang-22
x86_64                randconfig-1003-20261017    gcc-14
x86_64                randconfig-1003-20261018    clang-22
x86_64                randconfig-1004-20261017    gcc-14
x86_64                randconfig-1004-20261018    clang-22
x86_64                randconfig-1005-20261017    gcc-14
x86_64                randconfig-1005-20261018    clang-22
x86_64                randconfig-1006-20261017    clang-22
x86_64                randconfig-1006-20261018    clang-22
x86_64                randconfig-1007-20261017    clang-22
x86_64                randconfig-1007-20261018    clang-22
x86_64                randconfig-1008-20261017    clang-22
x86_64                randconfig-1008-20261018    clang-22
x86_64                randconfig-1009-20261017    clang-22
x86_64                randconfig-1009-20261018    clang-22
x86_64                randconfig-1010-20261017    clang-22
x86_64                randconfig-1010-20261018    clang-22
x86_64                randconfig-1011-20261017    clang-22
x86_64                randconfig-1011-20261018    clang-22
x86_64                randconfig-1012-20261017    clang-22
x86_64                randconfig-1012-20261018    gcc-14
x86_64                randconfig-1013-20261017    clang-22
x86_64                randconfig-1013-20261018    gcc-14
x86_64                randconfig-1014-20261017    clang-22
x86_64                randconfig-1014-20261018    gcc-14
x86_64                randconfig-1015-20261017    clang-22
x86_64                randconfig-1015-20261018    gcc-14
x86_64                randconfig-1016-20261017    clang-22
x86_64                randconfig-1016-20261018    gcc-14
x86_64                randconfig-1017-20261017    clang-22
x86_64                randconfig-1017-20261018    gcc-14
x86_64                randconfig-2200-20261016    gcc-14     smatch
x86_64                randconfig-2300-20261016    clang-22   sparse
x86_64                randconfig-2301-20261016    clang-22   sparse
x86_64                randconfig-2302-20261016    clang-22   sparse
x86_64               randconfig-r2105-20261016    clang-22   cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261017    gcc-15.2.0
xtensa                randconfig-1000-20261018    clang-24
xtensa                randconfig-1001-20261017    gcc-15.2.0
xtensa                randconfig-1001-20261018    clang-24
xtensa                randconfig-2000-20261016    gcc-12.5.0
xtensa                randconfig-2001-20261016    gcc-10.5.0
xtensa               randconfig-r2302-20261016    gcc-15.2.0 sparse
xtensa               randconfig-r2303-20261016    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
