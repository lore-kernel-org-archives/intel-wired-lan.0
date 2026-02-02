Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9D7E7FDF0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Feb 2026 21:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB27A409B0;
	Mon,  2 Feb 2026 21:49:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1GhuADizTFh; Mon,  2 Feb 2026 21:49:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BFDE4098C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770068973;
	bh=onma8b13fazTQSuJ1U483JL+Qh7tV3/YrRy5KvtVfa8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h/wOriu3XYOoesOnanhIrg6vKnyxGth0+wuF1eG0wiCrLAma1IjsT+n1ZfZgJAqZQ
	 lLJAhYkbX1FswclhLdi0FlwSYU3kaa1DCktZqg1i+c4i/n++8yMOzmtnPcH/+LJQPy
	 jPVOMfIc/p+Mo9kQXQQ2rKpX8OV0dMXAaQYsnYXjCY8xfcPXE7cB8PyKc+YY5fM2/O
	 lr2SM2nmXXFThCIQGNG7lQ8i9ummgAo0vepAK33W0HMximkqe8f/UAPO3EmzGElY5w
	 l5GhXF1nlwh8ebosvpaCxdXgS/zVIFi7CuZuKIOHMwL/EvQrfjp8lnkys3Nx+MjM7F
	 kQGDV+BfVtUzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BFDE4098C;
	Mon,  2 Feb 2026 21:49:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DFC65F5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Feb 2026 21:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9F0D40123
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Feb 2026 21:49:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BNDCD1nQeV7I for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Feb 2026 21:49:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 842EC40112
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 842EC40112
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 842EC40112
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Feb 2026 21:49:30 +0000 (UTC)
X-CSE-ConnectionGUID: 0waYu/KMSNugMs+rDYzUyQ==
X-CSE-MsgGUID: RlHMnUR2Rji9QMteIzHVYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71317556"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; d="scan'208";a="71317556"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 13:49:29 -0800
X-CSE-ConnectionGUID: 1mLhGU+kRviswRU3MKb1ZA==
X-CSE-MsgGUID: 3/hN4atiQQuJCR8s9tAfFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; d="scan'208";a="208743963"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 02 Feb 2026 13:49:24 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1vn1nN-00000000fzM-1pxx;
 Mon, 02 Feb 2026 21:49:21 +0000
Date: Tue, 3 Feb 2026 05:48:33 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Leon Romanovsky <leon@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-rdma@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Richard Cochran <richardcochran@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
Message-ID: <202602030538.6ok1xugA-lkp@intel.com>
References: <20260202171638.17427-8-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202171638.17427-8-ivecera@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770068970; x=1801604970;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EY2CrS28kRVeb7uWnMWJfY8xjXKXRdCHiuTKy5sQkoY=;
 b=bKYcQ3L1AlHtTx3aL3vINnmlrJcTWTV6JnNoVpMC3EQsPEtmRHmHWAJB
 dgptjY9N5Kot5pOko6ts1ab6b8O44jrgbtqZXhhnr5iRaSPPWc/iMVD2X
 6n59WqhjMpg0CZy84KMj4SarOsZZcISyRMzpwIB96B+9PgLOo0DylPFEX
 ah1kQP7GvM/X7AOAHCfVeQySIts0XkZ8d5Jik7jszVh4rHjXB+n1dxBKJ
 R62cBqbpYYSjEeJuWV+rbTr7+UGvHFEeraMEWgFKIXD5HdvRPx2Y7ndib
 OJWa5XTPbHXhjsE/pn9ZAAMjRX/rcjS9BRsU67ibRnLlU/x5Ft0GWFAuA
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bKYcQ3L1
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 7/9] dpll: Add reference
 count tracking support
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

Hi Ivan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-Allow-associating-dpll-pin-with-a-firmware-node/20260203-012705
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260202171638.17427-8-ivecera%40redhat.com
patch subject: [Intel-wired-lan] [PATCH net-next v4 7/9] dpll: Add reference count tracking support
config: i386-randconfig-141-20260203 (https://download.01.org/0day-ci/archive/20260203/202602030538.6ok1xugA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602030538.6ok1xugA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602030538.6ok1xugA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/rtnetlink.c:61:
>> include/linux/dpll.h:235:1: error: expected identifier or '('
     235 | {
         | ^
   1 error generated.


vim +235 include/linux/dpll.h

877c40367bc8a7 Ivan Vecera 2026-02-02  232  
877c40367bc8a7 Ivan Vecera 2026-02-02  233  static inline struct dpll_pin *
bed78c2008cb37 Ivan Vecera 2026-02-02  234  fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker);
877c40367bc8a7 Ivan Vecera 2026-02-02 @235  {
877c40367bc8a7 Ivan Vecera 2026-02-02  236  	return NULL;
877c40367bc8a7 Ivan Vecera 2026-02-02  237  }
5f18426928800c Jiri Pirko  2023-09-13  238  #endif
5f18426928800c Jiri Pirko  2023-09-13  239  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
