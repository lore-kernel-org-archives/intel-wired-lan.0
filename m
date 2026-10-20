Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC596606A322
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=NlM3te1X;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R8K9Mb2U
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8376780FA3;
	Tue, 20 Oct 2026 22:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFGULYjI60p1; Tue, 20 Oct 2026 22:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC48A80F92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792534340;
	b=Y+nQAaC3PlvS9jYkDvsYNdrITJJgqdiicGOLwdSMzdHZcVjFgyp9ySe66sdOk/1ekSha
	 RNK8uJmsNo0WN/AKN3V8eGiZGtp7Z9qpWEDRc0A5p0mOIG9gisL+t5yB3wsVJDCB/wocF
	 0wZ8j8uYtaqn79GXyr/wusFWqxCD4qk5a+04wUZ6dH4eGgvHS73luuYm5uRcTWwXOJZnh
	 VsqlYZX1luXLP/83VbN4f1siY8YDDOmArWecDaD9m+qI71oug83PCFpUhZGF+lt7LJLeJ
	 xUL+avZZU2+0muaoUKG8y04mmum+zuWBuBIlTVHPPdhNzIEDojUB8Y73ab5BH/baywA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792534340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U7au3t5kVB0xpJz0eh7kC1WMWHmi+UbqpJJZk5QKNJc=;
	b=Q3DlorYJ0IFHwgWrMW5unSYA3SB7DytagEgqSeBSJnfvKZep2oBNk6lseiSOifvBPrto
	 zlzaS1Dt2Cz2SlhWsuJ42zKZuCyV1Sj87K05S/sRnlldldMrjkTLfs/M4cgtYahLfKVBZ
	 7ZD1pGE/2/8bJ/9fT3JUwnEljBnyEuSvvQXLRzobNxjOBWFFH7os7Lpo5IgTSIFOk2/SG
	 9Ti6N3Uz29DpR/bL7zVg9+xipR7tZtCzGEHoibJMVqB4BkyZk77XvvVNYdoVs7RZFfgJp
	 SK5e+mpXOhUiotmwbQk4nHwWGJDkMQRBqlu+t4WWsOnnllmTRHgGyae9jqsQPKh6kTA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792534340;
	bh=U7au3t5kVB0xpJz0eh7kC1WMWHmi+UbqpJJZk5QKNJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NlM3te1XwS5xfbLF/vpZPXgyvhvkH4Vie+SWyjbiwC/CKaudm+4OF06tPN8zVUrUu
	 polnVmiPwWmBPYtbRsa/Fxa076rFDmQuf5oqerv/8QXpRtLZNltdz655SJj9d3dYjN
	 6iISDbjtrjgIvgwvinTojILgWCNnwjeqLgMJMNd1T2w4ztrLex8lFtB+DAgpiJbsg5
	 U0LYBvjfwP20DIHt7odSmfNY5GzyK7qCu/RagZvPFIg5obl6awax0IZ9PPNaVDbI3c
	 ath7jyVV7jNmkuXN+vtXMfHoUpINQs25kIydsRRTrZoZkhdhav+pBSlkMhr/agLqwJ
	 +U5Xqko/uvqzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC48A80F92;
	Tue, 20 Oct 2026 22:12:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60E403A4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 22:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46C17407AD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 22:12:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mlY92VHYOjHq for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 22:12:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6AE0407A4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792534333;
 b=O7iJjFLn6lKZgRCeyt9ObrSFXlNkkiDN1dt+UcVfT2NkA4Zssvvw3DR1RUGi0r9C5n69
 mTqtWlZQmiLmj8U4zEpC0L8p42CqtOVYf21mNNHy5rxvKcjbXsuXWRxD1egm5PHszcyZl
 9LeGIj++GiRtx/fFT+jJ3oZROwdQ26bsSW1hY1PLSgtJvGVo+5kcTpEAdvF9v9kKc6WHS
 caJ57RNnpiNCSHnpk+PzXLo7ggjEOi6wR0OvI5wbRKD89zc8untpGHdReY/jhfLVT6Ngk
 SQEcC7Tje4ZW28YSs7hg2QEKvgH0kbuxpqPuiCFNQGQIOPnxt6zcXUBIHz7tBurYmOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792534333;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=U7au3t5kVB0xpJz0eh7kC1WMWHmi+UbqpJJZk5QKNJc=;
 b=cPhl3F7jDTZlJw2TckKzoFBCSNpFRlPaY1+ujCvEHd5eB1MU3q0D/5iBZ/lrU1an+wZ2
 H69TDnibLlcgm18uggf3P3J7UzCZIdBllwmjdbL/K5qsRZRn4ak08Y9QR6rVibgmbOws5
 00MiVebya4gzRzYLMtdxwMvmnomufGKjCX1P/G9vbBCTkLvoc7/iVPON8DNEyr35V5IQO
 1E9Gb5zR1gm65zbHqBvWvdsZDJUTHP5plXYykumtV0UJEJ95AdoGDSYzXlz7JkJ+XSz/2
 qyntv6HYMDpSH+u59+36z3dxoav12EzYVwNQwSDz8IMu+ztlzOFcU4P3GQqD5Ap91+g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R8K9Mb2U; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=R8K9Mb2U
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6AE0407A4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792534331; x=1824070331;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nMLnoNUxgbBDXPR0Eskw1VxGB7hT2iifAx/KYRgAfCk=;
 b=R8K9Mb2U/borkIYLWZHLDIWsSDDr+yAzMUnCO2jRCmA6y7UlFenYJWDS
 HOtRv4iN4/ZpmIxCrN95LtIK2eenioYZvetKfmGIcXPMAppmCU1q5qaU1
 zWOapJXQqFniY5dD8OKa4bPpGoeS/gv5pbfYG8b4rREqTAKI/kbdQBWRq
 Io5dEVFyck/Lsb/2+PgPSnNQ8bkhe5zr2qHPUaRszm0O18l+E+GDjUoad
 PeCBYP7sc6pWXWIbS9u3xq5B033My/y9NNBv1HT67OEZkgXmiUNDUC1qi
 nA3RzgCuzB/dy4RS4VHbc2dNTCHkAFvo5qgSQxNinsDrwQQT9QJ3WQA9x w==;
X-CSE-ConnectionGUID: /NjxtCR4TCWNi/XrtYiSvA==
X-CSE-MsgGUID: sj+cfJQjTHWUAV+armXPjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1266411"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1266411"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 15:12:08 -0700
X-CSE-ConnectionGUID: azN0FdMLQ1efTuEjWMSWzA==
X-CSE-MsgGUID: lh+vEJaNSF+VOlWv6EDDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2913292"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 20 Oct 2026 15:12:04 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xJI3t-00000000OZi-2Ui4;
 Tue, 20 Oct 2026 22:12:01 +0000
Date: Wed, 21 Oct 2026 06:11:12 +0800
From: kernel test robot <lkp@intel.com>
To: Binbin Deng <18983559317@163.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Binbin Deng <18983559317@163.com>
Subject: Re: [PATCH v1] i40e: Lock VF cloud filter list operations
Message-ID: <202610210619.K13qhCpp-lkp@intel.com>
References: <20261020025856.519623-1-18983559317@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020025856.519623-1-18983559317@163.com>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Binbin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]
[also build test WARNING on tnguy-net-queue/dev-queue linus/master v7.3 next-20261019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Deng/i40e-Lock-VF-cloud-filter-list-operations/20261020-105856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20261020025856.519623-1-18983559317%40163.com
patch subject: [PATCH v1] i40e: Lock VF cloud filter list operations
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20261021/202610210619.K13qhCpp-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 2c419645e808a6667eee9dbb16c828f77e2fd2f0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261021/202610210619.K13qhCpp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610210619.K13qhCpp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3739 function parameter 'i40e_vf_cloud_filter_lock' not described in 'DEFINE_MUTEX'
>> Warning: drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3739 expecting prototype for i40e_del_all_cloud_filters(). Prototype was for DEFINE_MUTEX() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
