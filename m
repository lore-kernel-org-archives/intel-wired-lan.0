Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB06C53219
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Jul 2026 14:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 858914095C;
	Tue, 28 Jul 2026 14:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EDrHHlwWTjw6; Tue, 28 Jul 2026 14:56:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EB0F4093C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785250602;
	bh=lS8Ja9nSE5Ir24NGy0StdvGzh04DG4Pk6cJxfFeYUE8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hKbGj5z22tEyKGNP0lBW26CQhUd1tIR/KATgnnuyniy9R9V7JUQLLwSAWp4VBZjRc
	 hMHEOmQ8BdOfM3P4qpb420B40Vl3mGxuIZdXLDkOXzd5ZQgGXraN1NOv/nVH/75Jb2
	 8m9GlQrctOFeZeyhhcFPXJ74rAj3N/CWM4DbpiZB2SPlFBGOTL/eIvr3z060mQyYDd
	 FvVl800SR8qhDYQTq2HsSt76x6rq1boqnIPrUtlm5jn7cQZ1zbxWjpUWNjflHkl+9/
	 0+O35P/HZjJ7DEEAtM111DnZdIY5g6TtpUZ4e/o++5pBXs2yRNiRlnm0IV0louK82/
	 XD3bp5rTVxdOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EB0F4093C;
	Tue, 28 Jul 2026 14:56:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60C93490
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 14:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 528B740328
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 14:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wsPlKzkj-miW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Jul 2026 14:56:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 725CE40323
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 725CE40323
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 725CE40323
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 14:56:38 +0000 (UTC)
X-CSE-ConnectionGUID: hgOSI5OERS2vAI7jvQD8dg==
X-CSE-MsgGUID: 1Gy2SofnRt+ig7Amy724Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="88373602"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="88373602"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 07:56:39 -0700
X-CSE-ConnectionGUID: 7KJh3ZRpToqox7U7D9Uf9A==
X-CSE-MsgGUID: 9TE8b0yBRm6uCQTkZRuSbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="264731355"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa005.fm.intel.com with ESMTP; 28 Jul 2026 07:56:37 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wojER-00000000eSk-2ANo;
 Tue, 28 Jul 2026 14:56:35 +0000
Date: Tue, 28 Jul 2026 22:55:45 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607282225.enWFUZxP-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785250600; x=1816786600;
 h=date:from:to:subject:message-id;
 bh=GMIYamPabUMi4NJCNyVo4ewT6r+tNHX2NLx3xwjCmT8=;
 b=bTkndiqAL3pOYE1ZIB4V8RogIbLbxMtWGN9dSK2Yjqj9g+Sb6L8pS7d1
 Ybl9mU9OtHyiPOqHFulnr05VuYkWx85Clwwk6QJER2QEZCE4tTAX50u+/
 xNkSmrPWbjsQh+yqiFoBRBqniprOf5prdpt+HuoUOEZkJ4kiavWU+rB9I
 +CT6bDewIDvMZSURFDEisrv8ekMna2bZzAJrtiAjJanwgo+7/VZjMEGJy
 Qt+wc+Nfok+ztwKuIxjiYZ8iUPxJ4qcG/95o4Y9QCd2pZvsiOGmoM5j6y
 woSiXMObBQAaTBLxEb8DDu0rcdtDjg7AKhMPhDdE2VO7vnA1JNjqh86lp
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bTkndiqA
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 d621cef13189b54ee67019d170a6d8ec727785aa
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
branch HEAD: d621cef13189b54ee67019d170a6d8ec727785aa  i40e: trigger PF reset when re-enabling ATR via ethtool

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 839m

configs tested: 20
configs skipped: 1

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
csky                  allmodconfig    gcc-16.1.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
loongarch  randconfig-001-20260728    gcc-16.1.0
mips          eyeq6lplus_defconfig    gcc-16.1.0
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
parisc     randconfig-001-20260728    gcc-8.5.0
riscv      randconfig-002-20260728    gcc-8.5.0
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260728    gcc-16.1.0
sh         randconfig-002-20260728    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
