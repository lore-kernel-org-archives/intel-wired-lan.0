Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDC4C61DA3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Feb 2023 13:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0467A605BA;
	Fri, 24 Feb 2023 13:38:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0467A605BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677245881;
	bh=ak+2hDsz/WqHVFcwBFTa+RLVRQceW+WRrGTumYm1R7Q=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eUatP166a5g32oIIiCX1IDkM3FtAdUmGx3MZR0dpwYj4Tc0j/vLDN3sukbKywnecn
	 TrswFpRZzR/mAWS4E9RdRF3nr6sV1coWu8+HAmAXLTYVCS93XTSWp/rA7Nj3jlj/4B
	 qOa3k3HR3r84uVpoQ+ipfl4XekFhV4+NlZjrd35NtPj0DNMvDbZpKJn9zkStFNESSr
	 MzBheCimMuuK9duvpaPv8iTMzDfqrjak/uJIZ/GkyKUQ1eBEfcSyBVEE7VgYPU8UjB
	 JiGxePiCF0CCt4zEDxTy0CmnF1rxXktXEnhQe3N3xfWRR4df+pcX6BT1nzY8DWsb88
	 kSggvlEFQIj2A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iao4FHsQ34bi; Fri, 24 Feb 2023 13:38:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F1BE60B44;
	Fri, 24 Feb 2023 13:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F1BE60B44
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 972381BF30B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Feb 2023 13:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CBD28137C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Feb 2023 13:37:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CBD28137C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rI6IsHiiANpQ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Feb 2023 13:37:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8818181376
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8818181376
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Feb 2023 13:37:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="335709480"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; d="scan'208";a="335709480"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2023 05:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="703188757"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; d="scan'208";a="703188757"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 24 Feb 2023 05:37:52 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pVYGl-0002Rp-1v;
 Fri, 24 Feb 2023 13:37:51 +0000
Date: Fri, 24 Feb 2023 21:37:49 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63f8bdad.+38N0O9ejjxXkW1w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677245876; x=1708781876;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=gjJWvpISME2EVcOg8F4eHMagGK+4hs2IxAEPUYypRIc=;
 b=NJb+AfIvP5wY5+uy40ajd2UfQTdBLlVVPSwOEwV4+3Rl2s1Rai/Be9Zk
 s336qNOUDX6wjIlA/PHp3U1/6JfoBd/bOMR4csXjm/MToUSIBDzRYtBr3
 r7lh//kRPU18I4971ZUt+cEYQqeOL/d/zVyK1IUsP4c1wsidfcLsqklsQ
 YxYadl3wpHtdhCSnlbDH7qX/D2OGZBF6Uqsd/OntvZWahwtSK2xYJwKb0
 UIZ6Q6xKfztKDc5xjHK0wgYY7+HkVb6TlKONgEmv6N0VGF8h+cn0xqIBO
 7bniK3dKNNYxCrqAbUnxxP2P4jNDQ1t0oGPQ9vTMF39Ob1DjV1W0emxgW
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NJb+AfIv
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 a6b811cb402f4beb7c8a56345a40bf6c65bd771d
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: a6b811cb402f4beb7c8a56345a40bf6c65bd771d  net/mlx5e: Remove hairpin write debugfs files

elapsed time: 726m

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
