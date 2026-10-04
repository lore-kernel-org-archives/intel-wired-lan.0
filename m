Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1AACA5FEC
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Oct 2026 19:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D7F260614;
	Sun,  4 Oct 2026 19:06:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6naEGfqlrKYs; Sun,  4 Oct 2026 19:06:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C6A80606D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791140794;
	b=Z/w9tPYvHZ4PwP5unlfJLmY9MDYqLpiFbAZg2plTApUlxMSbXQLsKWSfn1hhMvRCcAQv
	 3H1BLNpnvEAZ4jMfaYqays1jC0InVDsRV+A/KTNlQNuf5AJGqEPExZWQRMEQFiitrdVdu
	 nYhhs5MVzytn/ZUYzXDdsLDM1zcwC4X90MgRT8R7GqPST6Bi+wWuKF5cChGHUSOC3KzMr
	 YevILYfMt8kqDp4r63HB+OBEaDoUZKriM667IfTPybhv2vXLKuPt+e0kvLK3687p8z/Sn
	 YOgqki2ipTqAo01uBK9jXkUjiqoOjVHba0NHUNDfopvmMIcVJ4EjGfx0W5qidFwy5AA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791140794;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LyOcoo7UCMfWRo3wyCORjUBJJnbfFZytBbil3XQwz+s=;
	b=Yqdfx8CFcHGY0IkkgVRpymYKSwbS0rVPfk8uGRLK9Ja/b18ZWaJp3Blnlq5U38Mf/90a
	 ns/uFa+NAJ2P+WvjlA7JGCo5gcXIgF067IzA6WAzFbuJV80WjhwTYbmNVTvi5PRL0/CYp
	 QGLh8akSWF/sTB8BmcOMeG4jktEeT8+z+dhfFevLanY2sLbPN5NCBosISil7v8WU703Ui
	 8iz/gfXbay7BVvZgc5qC4omuOtah8YurcVRxjqPEpBimBKBWzbFyNOiciOLQd1bpBrpF/
	 VhOJATyVEjZ2tkcNq7jTNohNuxvDYSQM9wnIfAu/8xbVQlTTlGEMCtJ2K2Gmm4IGJqA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GZAnFTk+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791140794;
	bh=LyOcoo7UCMfWRo3wyCORjUBJJnbfFZytBbil3XQwz+s=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CBUAmG9tD1G9QnU0LjYzg1AnNa3XniDe+tt84f7uAcdp8ePrwe3o8tGZAqaenj+6k
	 3cEXZ/D5wkaV+bNi+X/qrLKysRbZQg3ltINH+/VMq/tBN+oshtqJliLDUPQ3xCytGC
	 ywvAwOPLxyY9HGu9p/BUEZzbN0nsjWWwtQ8mu/jO8yaMqS9rA6/3no9hU7qAasjVt+
	 0pgsX436f3SduCjrBcObpMeWIBOi72XDDRYZQOvGGnxsnoy/6h072n8y/Pz4MXL3S1
	 ataY8ALTOq0Eae+rd+QX3DDEDuAJn1EK+DNzTUGpFFUvZphfx9TcG5T3wQM506cTEL
	 KN0w2Wq0iuRXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6A80606D6;
	Sun,  4 Oct 2026 19:06:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E58622B
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E748C606D6
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:06:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 36UluaHG4p1E for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 19:06:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4796C60614
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791140791;
 b=QFBKhPn9iMtavJD4GijpGMQV9iDhTK9tFwgcV15PI3OhdLnW5XJQQ9Bt7yEN6hALOCch
 INKztDEeAt2RkYtZX2aJTNLll0cHweYZx6m4cSK3GfJIYjDTpduOm68CWeOxJYKscjKK8
 MYG78/izVMI5Nxm7ygnOL5slzeZQ77YSYanc0JBbDwgZIhSZLycnuhB8+EB11+yc8EdLF
 cTVUDUJu9vISagqJP8ckm8p2liCDvfs5+wz8M8bM7pu/cLA/Vn5/vXNMyxZSgYol3riVO
 s+KhO0UyuHSLx28xf6TNrVmnoCz8dhlm5XfxesdaPA8SSCLJmZoeUoKcoGCX/QpKREg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791140791;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=LyOcoo7UCMfWRo3wyCORjUBJJnbfFZytBbil3XQwz+s=;
 b=UhNb1ec+xsB/z2lhkhvrySW+KGqCCftEc+xiwtVvaHZWgsDyekecPzZf6xnqSdW5RAxF
 SCmJ1vOeyEhD01h9cmhwF3aKqs97ZaVA6AbyufaMXLUaody4jRt5LS9xstRqkfzXfW+1a
 BXISinjDuwzaOI5qBcPSEvGFyRjTOQY/bhT8w3BcIEiBruA8gr9O1oCKeZ8MFaR0dLkam
 LbTtqjH/ZmGJGg7H6aNBFzD+yUGL6Mpw/Rss3PQgfbpAsK7z25hZrJYdJPp7PyWtX0urW
 iOyd3UboV1MDJtkssMr4z6t5YHcfzHd1P1rxXRfxe5ubPMtfe21ofeZNS0egvGMZC3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GZAnFTk+; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GZAnFTk+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4796C60614
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791140791; x=1822676791; h=date:from:to:subject:message-id;
 bh=omOhM0c+KDdk21de34D86J7aRG8w9DC399bLMjaTj0o=;
 b=GZAnFTk+/SvkdwHLpVJ7jDeVplsiL7xiIcgzQ7PzwNNc4ABt4zU5wUAn
 JHUAtlRsksyU6jVafzICOy7wo6Z5JocNYFOeyaV7cGl+qtRa16bSY2sTO
 MrDKDqCs7IYjSb3YxZ3djYdliADtqaM+4ILXD9Bcxgl1HWxhGCa92Fk7C
 lNTbzEMkRoFrDfyRWN4Sj0HLc8xgPRA0zUWZgoe2wgLsoZ8iTjaiSXH09
 zfKNOd/81uyWFgWH2bgXKWt/L46zQHkFFaUWWXjALPJLxc5GMlE7D2JYF
 qvN991qsicYal8awdweLZQMPrBEtjomqlYmUGyAoOnhGupnVajCQ3bCVM w==;
X-CSE-ConnectionGUID: gmmOEeKdQj+u8lbyYVQ1+A==
X-CSE-MsgGUID: 0NTvf2fSTrChq22gq6lzIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="108199882"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="108199882"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2026 12:06:29 -0700
X-CSE-ConnectionGUID: LU3OH6qZRrGC9vk4UTG7Bw==
X-CSE-MsgGUID: TW3k4VxUShaWIwMlics4XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="314662125"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 04 Oct 2026 12:06:28 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xDRXV-00000000V09-3gme;
 Sun, 04 Oct 2026 19:06:25 +0000
Date: Mon, 05 Oct 2026 03:05:53 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 a83267db14681b3be481e02a4d5a38177507006c
Message-ID: <202610050350.Yo5n4wPQ-lkp@intel.com>
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
branch HEAD: a83267db14681b3be481e02a4d5a38177507006c  ice: remove redundant cross-timestamp PTP command

elapsed time: 2252m

configs tested: 427
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2202-20261002    gcc-10.5.0 smatch
alpha                randconfig-r2301-20261002    gcc-8.5.0  sparse
alpha                randconfig-r2307-20261002    gcc-13.4.0 sparse
arc                               alldefconfig    clang-24
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                           axs103_defconfig    clang-17
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261003    clang-17
arc                   randconfig-1000-20261004    clang-22
arc                   randconfig-1001-20261003    clang-17
arc                   randconfig-1001-20261004    clang-22
arc                  randconfig-r2103-20261003    gcc-11.5.0 cocci
arc                  randconfig-r2300-20261002    clang-24   sparse
arc                  randconfig-r2301-20261003    gcc-14     sparse
arc                  randconfig-r2305-20261002    clang-24   sparse
arc                         vdk_hs38_defconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    clang-21
arm                        aspeed_g5_defconfig    gcc-16.1.0
arm                           collie_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                            h3600_defconfig    gcc-16.1.0
arm                           ixp4xx_defconfig    clang-24
arm                       jornada720_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                          orion5x_defconfig    clang-21
arm                              pxa_defconfig    clang-24
arm                   randconfig-1000-20261003    clang-17
arm                   randconfig-1000-20261004    clang-22
arm                   randconfig-1001-20261003    clang-17
arm                   randconfig-1001-20261004    clang-22
arm                   randconfig-1002-20261003    clang-17
arm                   randconfig-1002-20261004    clang-22
arm                   randconfig-1003-20261003    clang-17
arm                   randconfig-1003-20261004    clang-22
arm                  randconfig-r2104-20261003    gcc-15.2.0 cocci
arm                  randconfig-r2202-20261002    clang-24   smatch
arm                          s3c6400_defconfig    clang-21
arm                            sama5_defconfig    gcc-16.1.0
arm                          socfpga_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261003    gcc-9.5.0
arm64                 randconfig-1000-20261004    gcc-16.1.0
arm64                 randconfig-1001-20261003    gcc-9.5.0
arm64                 randconfig-1001-20261004    gcc-16.1.0
arm64                 randconfig-1002-20261003    gcc-9.5.0
arm64                 randconfig-1002-20261004    gcc-16.1.0
arm64                 randconfig-1003-20261003    gcc-9.5.0
arm64                 randconfig-1003-20261004    gcc-16.1.0
arm64                randconfig-r2101-20261002    gcc-14     cocci
arm64                randconfig-r2101-20261002    gcc-8.5.0  cocci
arm64                randconfig-r2102-20261002    clang-24   cocci
arm64                randconfig-r2103-20261002    clang-24   cocci
arm64                randconfig-r2105-20261002    gcc-14.3.0 cocci
arm64                randconfig-r2200-20261003    gcc-16.1.0 smatch
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261003    gcc-9.5.0
csky                  randconfig-1000-20261004    gcc-16.1.0
csky                  randconfig-1001-20261003    gcc-9.5.0
csky                  randconfig-1001-20261004    gcc-16.1.0
csky                 randconfig-r2106-20261003    gcc-15.2.0 cocci
csky                 randconfig-r2107-20261002    gcc-14     cocci
csky                 randconfig-r2309-20261002    gcc-14.3.0 sparse
hexagon                           alldefconfig    clang-21
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261003    gcc-16.1.0
hexagon               randconfig-1000-20261004    gcc-16.1.0
hexagon               randconfig-1001-20261003    gcc-16.1.0
hexagon               randconfig-1001-20261004    gcc-16.1.0
hexagon              randconfig-r2100-20261003    gcc-11.5.0 cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261003    gcc-14
i386        buildonly-randconfig-1000-20261004    clang-22
i386        buildonly-randconfig-1001-20261003    gcc-14
i386        buildonly-randconfig-1001-20261004    clang-22
i386        buildonly-randconfig-1002-20261003    gcc-14
i386        buildonly-randconfig-1002-20261004    clang-22
i386        buildonly-randconfig-1003-20261003    gcc-14
i386        buildonly-randconfig-1003-20261004    clang-22
i386        buildonly-randconfig-1004-20261003    gcc-14
i386        buildonly-randconfig-1004-20261004    clang-22
i386        buildonly-randconfig-1005-20261003    gcc-14
i386        buildonly-randconfig-1005-20261004    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261003    gcc-14
i386                  randconfig-1000-20261004    gcc-14
i386                  randconfig-1001-20261003    gcc-14
i386                  randconfig-1001-20261004    gcc-14
i386                  randconfig-1002-20261003    gcc-14
i386                  randconfig-1002-20261004    gcc-14
i386                  randconfig-1003-20261003    gcc-14
i386                  randconfig-1003-20261004    gcc-14
i386                  randconfig-1004-20261003    gcc-14
i386                  randconfig-1004-20261004    gcc-14
i386                  randconfig-1005-20261003    gcc-14
i386                  randconfig-1005-20261004    gcc-14
i386                  randconfig-1006-20261003    gcc-14
i386                  randconfig-1006-20261004    gcc-14
i386                  randconfig-1007-20261003    gcc-14
i386                  randconfig-1007-20261004    clang-22
i386                  randconfig-1008-20261003    gcc-14
i386                  randconfig-1008-20261004    clang-22
i386                  randconfig-1009-20261003    gcc-14
i386                  randconfig-1009-20261004    clang-22
i386                  randconfig-1010-20261003    gcc-14
i386                  randconfig-1010-20261004    clang-22
i386                  randconfig-1011-20261003    gcc-14
i386                  randconfig-1011-20261004    clang-22
i386                  randconfig-1012-20261003    gcc-14
i386                  randconfig-1012-20261004    clang-22
i386                  randconfig-1013-20261003    gcc-14
i386                  randconfig-1013-20261004    clang-22
i386                  randconfig-2100-20261002    gcc-14     cocci
i386                  randconfig-2100-20261003    gcc-14     cocci
i386                  randconfig-2101-20261002    gcc-14     cocci
i386                  randconfig-2101-20261003    gcc-14     cocci
i386                  randconfig-2102-20261002    gcc-14     cocci
i386                  randconfig-2102-20261003    gcc-14     cocci
i386                  randconfig-2103-20261002    gcc-14     cocci
i386                  randconfig-2103-20261003    gcc-14     cocci
i386                  randconfig-2200-20261002    gcc-14     smatch
i386                  randconfig-2300-20261002    gcc-12     sparse
i386                  randconfig-2300-20261003    clang-22   sparse
i386                  randconfig-2301-20261002    gcc-12     sparse
i386                  randconfig-2301-20261003    clang-22   sparse
i386                  randconfig-2302-20261002    gcc-12     sparse
i386                  randconfig-2302-20261003    clang-22   sparse
i386                 randconfig-r2104-20261002    gcc-14.3.0 cocci
i386                 randconfig-r2304-20261002    clang-22   sparse
i386                 randconfig-r2309-20261002    gcc-13.4.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261003    gcc-16.1.0
loongarch             randconfig-1000-20261004    gcc-16.1.0
loongarch             randconfig-1001-20261003    gcc-16.1.0
loongarch             randconfig-1001-20261004    gcc-16.1.0
loongarch            randconfig-r2301-20261002    clang-24   sparse
loongarch            randconfig-r2303-20261002    clang-24   sparse
loongarch            randconfig-r2304-20261002    clang-24   sparse
loongarch            randconfig-r2307-20261003    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                         m5407c3_defconfig    clang-17
m68k                 randconfig-r2100-20261002    gcc-14     cocci
m68k                 randconfig-r2106-20261002    gcc-12.5.0 cocci
m68k                 randconfig-r2306-20261002    gcc-13.4.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2200-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2202-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2304-20261002    gcc-8.5.0  sparse
microblaze           randconfig-r2308-20261002    clang-22   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm47xx_defconfig    gcc-16.1.0
mips                       maltaaprp_defconfig    clang-17
mips                 randconfig-r2106-20261002    gcc-14.3.0 cocci
mips                 randconfig-r2300-20261003    gcc-14     sparse
mips                 randconfig-r2303-20261002    clang-22   sparse
mips                 randconfig-r2303-20261002    gcc-8.5.0  sparse
mips                            rs90_defconfig    gcc-16.1.0
mips                         vocore2_defconfig    clang-17
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261003    gcc-16.1.0
nios2                 randconfig-1000-20261004    gcc-16.1.0
nios2                 randconfig-1001-20261003    gcc-16.1.0
nios2                 randconfig-1001-20261004    gcc-16.1.0
nios2                randconfig-r2100-20261002    gcc-8.5.0  cocci
nios2                randconfig-r2300-20261002    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2104-20261002    gcc-14     cocci
openrisc             randconfig-r2308-20261002    gcc-13.4.0 sparse
openrisc             randconfig-r2308-20261002    gcc-14.3.0 sparse
openrisc                  simple_smp_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261003    gcc-11.5.0
parisc                randconfig-1000-20261004    gcc-12.5.0
parisc                randconfig-1001-20261003    gcc-11.5.0
parisc                randconfig-1001-20261004    gcc-12.5.0
parisc               randconfig-r2107-20261002    gcc-12.5.0 cocci
parisc               randconfig-r2307-20261002    clang-22   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                    microwatt_defconfig    gcc-16.1.0
powerpc                      mpc512x_defconfig    clang-21
powerpc                      mpc83xx_defconfig    clang-17
powerpc                      powernv_defconfig    clang-24
powerpc               randconfig-1000-20261003    gcc-11.5.0
powerpc               randconfig-1000-20261004    gcc-12.5.0
powerpc               randconfig-1001-20261003    gcc-11.5.0
powerpc               randconfig-1001-20261004    gcc-12.5.0
powerpc64             randconfig-1000-20261003    gcc-11.5.0
powerpc64             randconfig-1000-20261004    gcc-12.5.0
powerpc64             randconfig-1001-20261003    gcc-11.5.0
powerpc64             randconfig-1001-20261004    gcc-12.5.0
powerpc64            randconfig-r2100-20261002    clang-24   cocci
powerpc64            randconfig-r2107-20261002    gcc-14.3.0 cocci
powerpc64            randconfig-r2201-20261002    clang-24   smatch
powerpc64            randconfig-r2302-20261002    gcc-8.5.0  sparse
powerpc64            randconfig-r2302-20261003    gcc-14     sparse
powerpc64            randconfig-r2309-20261002    clang-22   sparse
powerpc64            randconfig-r2309-20261003    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261003    gcc-12.5.0
riscv                 randconfig-1000-20261004    gcc-11.5.0
riscv                 randconfig-1001-20261003    gcc-12.5.0
riscv                 randconfig-1001-20261004    gcc-11.5.0
riscv                 randconfig-2000-20261002    gcc-9.5.0
riscv                 randconfig-2000-20261003    gcc-16.1.0
riscv                 randconfig-2001-20261002    gcc-9.5.0
riscv                 randconfig-2001-20261003    gcc-16.1.0
riscv                randconfig-r2101-20261002    clang-24   cocci
riscv                randconfig-r2102-20261003    gcc-11.5.0 cocci
riscv                randconfig-r2103-20261002    gcc-14     cocci
riscv                randconfig-r2300-20261002    clang-22   sparse
riscv                randconfig-r2302-20261002    clang-24   sparse
riscv                randconfig-r2306-20261002    gcc-14.3.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261003    gcc-12.5.0
s390                  randconfig-1000-20261004    gcc-11.5.0
s390                  randconfig-1001-20261003    gcc-12.5.0
s390                  randconfig-1001-20261004    gcc-11.5.0
s390                  randconfig-2000-20261002    gcc-9.5.0
s390                  randconfig-2000-20261003    gcc-16.1.0
s390                  randconfig-2001-20261002    gcc-9.5.0
s390                  randconfig-2001-20261003    gcc-16.1.0
s390                 randconfig-r2305-20261003    gcc-14     sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    clang-17
sh                                j2_defconfig    clang-21
sh                    randconfig-1000-20261003    gcc-12.5.0
sh                    randconfig-1000-20261004    gcc-11.5.0
sh                    randconfig-1001-20261003    gcc-12.5.0
sh                    randconfig-1001-20261004    gcc-11.5.0
sh                    randconfig-2000-20261002    gcc-9.5.0
sh                    randconfig-2000-20261003    gcc-16.1.0
sh                    randconfig-2001-20261002    gcc-9.5.0
sh                    randconfig-2001-20261003    gcc-16.1.0
sh                   randconfig-r2201-20261002    gcc-12.5.0 smatch
sh                   randconfig-r2306-20261003    clang-24   sparse
sh                           sdk7786_defconfig    clang-21
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261003    clang-17
sparc                 randconfig-1000-20261004    gcc-14
sparc                 randconfig-1001-20261003    clang-17
sparc                 randconfig-1001-20261004    gcc-14
sparc                 randconfig-2000-20261002    clang-24
sparc                 randconfig-2000-20261003    gcc-14
sparc                 randconfig-2001-20261002    clang-24
sparc                 randconfig-2001-20261003    gcc-14
sparc                randconfig-r2101-20261003    gcc-11.5.0 cocci
sparc                randconfig-r2102-20261002    gcc-8.5.0  cocci
sparc                randconfig-r2103-20261002    gcc-8.5.0  cocci
sparc                randconfig-r2201-20261002    gcc-8.5.0  smatch
sparc                randconfig-r2301-20261002    clang-22   sparse
sparc                randconfig-r2305-20261002    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261003    clang-17
sparc64               randconfig-1000-20261004    gcc-14
sparc64               randconfig-1001-20261003    clang-17
sparc64               randconfig-1001-20261004    gcc-14
sparc64               randconfig-2000-20261002    clang-24
sparc64               randconfig-2000-20261003    gcc-14
sparc64               randconfig-2001-20261002    clang-24
sparc64               randconfig-2001-20261003    gcc-14
sparc64              randconfig-r2104-20261002    gcc-12.5.0 cocci
sparc64              randconfig-r2105-20261002    gcc-12.5.0 cocci
sparc64              randconfig-r2106-20261002    gcc-14     cocci
sparc64              randconfig-r2200-20261002    gcc-15.2.0 smatch
sparc64              randconfig-r2305-20261002    clang-22   sparse
um                                alldefconfig    clang-17
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261003    clang-17
um                    randconfig-1000-20261004    gcc-14
um                    randconfig-1001-20261003    clang-17
um                    randconfig-1001-20261004    gcc-14
um                    randconfig-2000-20261002    clang-24
um                    randconfig-2000-20261003    gcc-14
um                    randconfig-2001-20261002    clang-24
um                    randconfig-2001-20261003    gcc-14
um                   randconfig-r2200-20261002    gcc-14     smatch
um                   randconfig-r2304-20261003    gcc-14     sparse
um                   randconfig-r2307-20261002    gcc-14.3.0 sparse
um                   randconfig-r2308-20261003    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261003    clang-22
x86_64      buildonly-randconfig-1000-20261004    gcc-14
x86_64      buildonly-randconfig-1001-20261003    clang-22
x86_64      buildonly-randconfig-1001-20261004    gcc-14
x86_64      buildonly-randconfig-1002-20261003    clang-22
x86_64      buildonly-randconfig-1002-20261004    gcc-14
x86_64      buildonly-randconfig-1003-20261003    clang-22
x86_64      buildonly-randconfig-1003-20261004    gcc-14
x86_64      buildonly-randconfig-1004-20261003    clang-22
x86_64      buildonly-randconfig-1004-20261004    gcc-14
x86_64      buildonly-randconfig-1005-20261003    clang-22
x86_64      buildonly-randconfig-1005-20261004    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261003    clang-22
x86_64                randconfig-1000-20261004    gcc-14
x86_64                randconfig-1001-20261003    clang-22
x86_64                randconfig-1001-20261004    gcc-14
x86_64                randconfig-1002-20261003    clang-22
x86_64                randconfig-1002-20261004    gcc-14
x86_64                randconfig-1003-20261003    clang-22
x86_64                randconfig-1003-20261004    gcc-14
x86_64                randconfig-1004-20261003    clang-22
x86_64                randconfig-1004-20261004    gcc-14
x86_64                randconfig-1005-20261003    clang-22
x86_64                randconfig-1005-20261004    gcc-14
x86_64                randconfig-1006-20261003    clang-22
x86_64                randconfig-1006-20261004    clang-22
x86_64                randconfig-1007-20261003    clang-22
x86_64                randconfig-1007-20261004    clang-22
x86_64                randconfig-1008-20261003    clang-22
x86_64                randconfig-1008-20261004    clang-22
x86_64                randconfig-1009-20261003    clang-22
x86_64                randconfig-1009-20261004    clang-22
x86_64                randconfig-1010-20261003    clang-22
x86_64                randconfig-1010-20261004    clang-22
x86_64                randconfig-1011-20261003    clang-22
x86_64                randconfig-1011-20261004    clang-22
x86_64                randconfig-1012-20261003    clang-22
x86_64                randconfig-1012-20261004    gcc-13
x86_64                randconfig-1013-20261003    clang-22
x86_64                randconfig-1013-20261004    gcc-13
x86_64                randconfig-1014-20261003    clang-22
x86_64                randconfig-1014-20261004    gcc-13
x86_64                randconfig-1015-20261003    clang-22
x86_64                randconfig-1015-20261004    gcc-13
x86_64                randconfig-1016-20261003    clang-22
x86_64                randconfig-1016-20261004    gcc-13
x86_64                randconfig-1017-20261003    clang-22
x86_64                randconfig-1017-20261004    gcc-13
x86_64                randconfig-2100-20261002    gcc-14     cocci
x86_64                randconfig-2100-20261003    clang-22   cocci
x86_64                randconfig-2101-20261002    gcc-14     cocci
x86_64                randconfig-2101-20261003    clang-22   cocci
x86_64                randconfig-2102-20261002    gcc-14     cocci
x86_64                randconfig-2102-20261003    clang-22   cocci
x86_64                randconfig-2103-20261002    gcc-14     cocci
x86_64                randconfig-2103-20261003    clang-22   cocci
x86_64                randconfig-2200-20261002    clang-22   smatch
x86_64                randconfig-2200-20261003    gcc-14     smatch
x86_64                randconfig-2300-20261002    gcc-12     sparse
x86_64                randconfig-2300-20261003    clang-22   sparse
x86_64                randconfig-2301-20261002    gcc-12     sparse
x86_64                randconfig-2301-20261003    clang-22   sparse
x86_64                randconfig-2302-20261002    gcc-12     sparse
x86_64                randconfig-2302-20261003    clang-22   sparse
x86_64               randconfig-r2102-20261002    gcc-14     cocci
x86_64               randconfig-r2105-20261002    gcc-14     cocci
x86_64               randconfig-r2201-20261003    clang-22   smatch
x86_64               randconfig-r2303-20261003    gcc-14     sparse
x86_64               randconfig-r2306-20261002    clang-22   sparse
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
xtensa                        common_defconfig    clang-21
xtensa                randconfig-1000-20261003    clang-17
xtensa                randconfig-1000-20261004    gcc-14
xtensa                randconfig-1001-20261003    clang-17
xtensa                randconfig-1001-20261004    gcc-14
xtensa                randconfig-2000-20261002    clang-24
xtensa                randconfig-2000-20261003    gcc-14
xtensa                randconfig-2001-20261002    clang-24
xtensa                randconfig-2001-20261003    gcc-14
xtensa               randconfig-r2105-20261003    gcc-15.2.0 cocci
xtensa               randconfig-r2107-20261003    gcc-15.2.0 cocci
xtensa               randconfig-r2302-20261002    clang-22   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
