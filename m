Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA2DC6FD1F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 Mar 2024 10:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C13740160;
	Tue, 26 Mar 2024 10:18:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5FaH2Jt27FKN; Tue, 26 Mar 2024 10:18:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAD4C404ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1711448314;
	bh=rYmkEHi4VavxMXgDPhKWUPnIcThKgoTAuUBbdxJ2wus=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SJNIxBqS96J5tqU8BQOY99wMvAlIecfTRB/4ck1XknnkSlO5qw9IXFw21Mrj6xSII
	 Mx5T+/xkLQj0bB7UAFskmFrZAc+VsyJcJSXlqpCnkfB4Ta89rTvggU2jWA/qhekY+p
	 QXkM+TW2Xq1urGxZV79s+8wbBFJeQJmyDdRzWG1gmLg75Qqs2H3QcHHrkLkqkEgsFS
	 Rgv67lcyIWI3DCfmugmLRaxe8Wj9SaOJiwGYszm2Ar1bfbA2HSb+cLdTgdYd8YpuF+
	 VJ0r5FL7hSdb6SVMJ2m4qvyCwUKm0Ymn7BysYLF/1JR4rkZgYtlzpJDBxR98E7Y+d/
	 y5dSMoo2TL3UQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAD4C404ED;
	Tue, 26 Mar 2024 10:18:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 735BC1BF383
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Mar 2024 10:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F19140578
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Mar 2024 10:18:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UrRMfbaCvVTN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 Mar 2024 10:18:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=naamax.meir@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A1408404ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1408404ED
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1408404ED
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Mar 2024 10:18:32 +0000 (UTC)
X-CSE-ConnectionGUID: Ixdmc9j4ToyVug1AaRM6yw==
X-CSE-MsgGUID: 9Y0lZcc+SseloAfVwYkySg==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6701996"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6701996"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 03:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; d="scan'208";a="20603452"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.12.48.215])
 ([10.12.48.215])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 03:18:31 -0700
Message-ID: <9eb5694c-cab6-43fd-bfbe-f696c1ec08df@linux.intel.com>
Date: Tue, 26 Mar 2024 12:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vitaly Lifshits <vitaly.lifshits@intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20240303105132.2696814-1-vitaly.lifshits@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240303105132.2696814-1-vitaly.lifshits@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711448312; x=1742984312;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VCibbg6d7djel/0sBTu3bJf8AEwblpFIA4OLyIEmDa0=;
 b=frIRfNL/aA0QzjcamhFEf9BzxvutcRsg/KjMZ8TjcXtgoeIQ2wQhwD0m
 2rXPJ22CoP5UZC6diX7hBN18GN57PJ0Ii4qnlTuHDV7I+MsS3o76Y7Q7L
 KffHFv/Rek0quBEaiLWLLnDGGk0wZIE9IXtRTglYIP2jE38S1oB3CNTA5
 Xq1e+h5QWNEDcwWtzX1SodEu+Y33QKjwgDSImUnlsGH7p2e1DQWEIynmL
 fuon051SgUesZtqNAdq/2sz5J+/xfscVPB+RdI/cJqviuY6f7hL5HOYoE
 ppDOJ1MaJ4qaqSFsWYYxD6+qEr6EEzWTeXH66GdUniD4lyZ9PMFRNyXjJ
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=frIRfNL/
Subject: Re: [Intel-wired-lan] [PATCH RESEND iwl-net v2 1/1] e1000e: move
 force SMBUS from enable ulp function to avoid PHY loss issue
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
Cc: Dima Ruinskiy <dima.ruinskiy@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 3/3/2024 12:51, Vitaly Lifshits wrote:
> Forcing SMBUS inside the ULP enabling flow leads to sporadic PHY loss on
> some systems. It is suspected to be caused by initiating PHY transactions
> before the interface settles.
> 
> Separating this configuration from the ULP enabling flow and moving it to
> the shutdown function allows enough time for the interface to settle and
> avoids adding a delay.
> 
> Fixes: 6607c99e7034 ("e1000e: i219 - fix to enable both ULP and EEE in Sx state")
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Co-developed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> ---
> v2: address community review
> v1: initial version
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 19 -------------------
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 18 ++++++++++++++++++
>   2 files changed, 18 insertions(+), 19 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
