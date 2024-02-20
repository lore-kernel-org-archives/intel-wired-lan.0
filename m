Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4D0C48BC4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Feb 2024 11:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DC514119B;
	Tue, 20 Feb 2024 11:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 346q9uXedKxD; Tue, 20 Feb 2024 11:06:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6A41409E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708427182;
	bh=uTtprKqNKBCDh0Kc5xL88L8VlaoWb83zfIy5NAsZbKI=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHJ/aUA51tcj1EH7ePPW6nLku5MQslZ+LRew/1BIaS/IXvKAfXU0dvLYJvh+zVw4F
	 aHAlie3pq31ZbtKGxWZOgnPs8LWqEdFRAgh8GexvaLqRCqU+61OCsJQE/nXTBl9qZe
	 B+PFHOlBdyH71OLZhySpihbFpCI86uIRC5qkNdGk7auxQDfzoHn7qhAXbT2SfyvwdI
	 XyDo1et+0yZmaFAIipprjeij1x/cp5FLvInciSo0K6GfRSPGW0qxdOeI75WytICRmB
	 bWJtvY9Rcum/0KzMw6V2MswzpB1ZG6HrpSfM7UHXYmaPBDOQ459aOpXUgSu6doWMk+
	 NEfERaQVcrj+Q==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6A41409E9;
	Tue, 20 Feb 2024 11:06:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 439321BF3A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Feb 2024 11:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C798608A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Feb 2024 11:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s77dqvbC8p8q for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Feb 2024 11:06:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=naamax.meir@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AD3B56075D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD3B56075D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD3B56075D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Feb 2024 11:06:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6347683"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6347683"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 03:06:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; d="scan'208";a="35772894"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.12.48.215])
 ([10.12.48.215])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 03:06:17 -0800
Message-ID: <a6cfc273-03e0-428d-ae6f-7c0fe8501a05@linux.intel.com>
Date: Tue, 20 Feb 2024 13:06:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sasha Neftin <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20240211073058.2978195-1-sasha.neftin@intel.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240211073058.2978195-1-sasha.neftin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708427180; x=1739963180;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=Nifh9fZj3MtIgaijtwnXF0YKfrfmZPHEK6I5yNeL60k=;
 b=oKUZtgePDZ5t1P/xBWHVlwdVNiCU5oWI/DOLUAq/N7sEoS/NcnED895L
 NbdOFAXkyYvlzrlEbo3XJbC1k+rkhbjTeIdiEuwn48v7cOqYTihl9+NHC
 JaNCVAmGp/0jAh7kWWn7kgOcS0kfA6FTAyWsmHFWpiEDfEXvYpVtEwN8c
 CwEBzt1K967q7BmMGDXE+fWIER2wYgCncA2EM09jOThnglEi0sDAAEPU/
 1IZVGm+1f0qarIR5l/QmXq/zl+CWiUN4Fh9o2a1hAZxttakFEnTjhpuLp
 q5aDbkA/BMYYT3c9YLhhCsiRflZ77p4waM06IpGJmXXHvx05LzzpJ5+m3
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oKUZtgeP
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/1] igc: Refactor runtime
 power management flow
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2/11/2024 09:30, Sasha Neftin wrote:
> Following the corresponding discussion [1] and [2] refactor the 'igc_open'
> method and avoid taking the rtnl_lock() during the 'igc_resume' method.
> The rtnl_lock is held by the upper layer and could lead to the deadlock
> during resuming from a runtime power management flow. Notify the stack of
> the actual queue counts 'netif_set_real_num_*_queues' outside the
> '_igc_open' wrapper. This notification doesn't have to be called on each
> resume.
> 
> Test:
> 1. Disconnect the ethernet cable
> 2. Enable the runtime power management via file system:
> echo auto > /sys/devices/pci0000\.../power/control
> 3. Check the device state (lspci -s <device> -vvv | grep -i Status)
> 
> Link: https://lore.kernel.org/netdev/20231206113934.8d7819857574.I2deb5804
> ef1739a2af307283d320ef7d82456494@changeid/#r [1]
> Link: https://lore.kernel.org/netdev/20211125074949.5f897431@kicinski-fedo
> ra-pc1c0hjn.dhcp.thefacebook.com/t/ [2]
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 32 +++++++++++------------
>   1 file changed, 15 insertions(+), 17 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
