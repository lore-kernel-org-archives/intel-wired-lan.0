Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90972C19F32
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Mar 2025 13:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48F0441245;
	Wed,  5 Mar 2025 13:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ba8xNwqS6f0Y; Wed,  5 Mar 2025 13:30:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A683741244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1741181439;
	bh=GZ6eUls3PorKa11dVvPyk7+F7F5lgUhnxd95XsSf6vA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xnj1Mx2pE0pFEvYhawzuaeMav6yo16kt26BMeDXfPQ6hqMsgA36OQULzjnfspX/lw
	 XKcDILDVR+Etf343xupo+IIHz7lDaM+DmC8QBTajDzvSNgv2exum0QkHdAhEo2aITD
	 E0Y9Piksk8DCj5v9UyMd8YsDbRx32ulMzHueyw3wJ7IAbcXpy5iA4ICu8E9uLuEmM0
	 2fHY/PEEntvAEPcI6GJeRk+Ct646Gbl9zYXQ/pzJC8kwHBR6Agh0UacsIoeF61wtcI
	 PAb6sVeOdgSCVI7pbJVF/UG1D9CRvPbEcoRajGNaCNcansY7894l4USSxHFLP8Jru5
	 Md1B8bpOZJKiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A683741244;
	Wed,  5 Mar 2025 13:30:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CD0E295F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Mar 2025 13:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFCF24108B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Mar 2025 13:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lwv5VvB91RAm for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Mar 2025 13:30:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=martyna.szapar-mudlaw@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2994840D7D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2994840D7D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2994840D7D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Mar 2025 13:30:35 +0000 (UTC)
X-CSE-ConnectionGUID: qAWuRUMyQkySWCPZ1Lu0Vg==
X-CSE-MsgGUID: HGhJnD2qQFuqlIv59eIzpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53132234"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="53132234"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 05:30:35 -0800
X-CSE-ConnectionGUID: DQhfG1J3SgS0CWpqLR1I9Q==
X-CSE-MsgGUID: pBZISIueQuWngEfuj9HNfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="149448411"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.99.188])
 ([10.245.99.188])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 05:30:33 -0800
Message-ID: <ad9799ed-5313-4787-b982-c8fc82a281a2@linux.intel.com>
Date: Wed, 5 Mar 2025 14:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20250226113409.446325-1-mateusz.polchlopek@intel.com>
 <20250303095405.GQ1615191@kernel.org>
 <b5e34397-0b81-4132-86d0-498a111cc363@linux.intel.com>
Content-Language: en-US
In-Reply-To: <b5e34397-0b81-4132-86d0-498a111cc363@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741181436; x=1772717436;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=qv6kfjqWgUm1Ww2zop913jEHSJdaLvMGKPpK+c/LYhQ=;
 b=jGagbmI+di1OP3YE9PLe8LYrgCOgmb5xqX8fXfxHZX5s+VdwaNfxMrKg
 rdwgKj14814Wvud9Q6o7t28R2/Ij2VMNY0qNpSsa1c5XZSu73DuSeuPH7
 GYGnJ99c4IXUNtfRmJf387Z/GGgBZIpzSOhn3fjV17IgibTQaFBtMKKPJ
 rayneZPfLzbEVgDyaubq9Vpg063ZJppVQRODiehyrML+ci7kNyfHYijXI
 /M4wp64vKXNJAjAsKUwQaAr7KIx9IVRyony3IMVm1oOvZ7gzJpq531nX8
 agkh7SyeYBVeaQHT2A3FlzQKi88BG8eEE2ShZmc15J7TPPiYXGAWp3koA
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jGagbmI+
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: refactor the Tx
 scheduler feature
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



On 3/4/2025 2:43 PM, Szapar-Mudlaw, Martyna wrote:
> 
> 
> On 3/3/2025 10:54 AM, Simon Horman wrote:
>> On Wed, Feb 26, 2025 at 12:33:56PM +0100, Mateusz Polchlopek wrote:
>>> Embed ice_get_tx_topo_user_sel() inside the only caller:
>>> ice_devlink_tx_sched_layers_get().
>>> Instead of jump from the wrapper to the function that does "get" 
>>> operation
>>> it does "get" itself.
>>>
>>> Remove unnecessary comment and make usage of str_enabled_disabled()
>>> in ice_init_tx_topology().
>>
>> Hi Mateusz,
>>
>> These changes seem reasonable to me.
>> But I wonder if they could be motivated in the commit message.
>>
>> What I mean is, the commit message explains what has been done.
>> But I think it should explain why it has been done.
> 
> Hi Simon,
> 
> I'm replying on behalf of Mateusz since he's on leave, and we didn't 
> want to keep this issue waiting too long.
> Would such extended commit message make sense and address your concerns?
> 
> "Simplify the code by eliminating an unnecessary wrapper function. 
> Previously, ice_devlink_tx_sched_layers_get() acted as a thin wrapper 
> around ice_get_tx_topo_user_sel(), adding no real value but increasing 
> code complexity. Since both functions were only used once, the wrapper 
> was redundant and contributed approximately 20 lines of unnecessary 
> code. By directly calling ice_get_tx_topo_user_sel(), improve 
> readability and reduce function jumps, without altering functionality.
> Also remove unnecessary comment and make usage of str_enabled_disabled() 
> in ice_init_tx_topology()."
> 
> Thank you,
> Martyna

Sorry, I caused some confusion in the previous version of proposed 
commit message. Here’s the corrected one:

"Simplify the code by eliminating an unnecessary wrapper function. 
Previously, ice_devlink_tx_sched_layers_get() acted as a thin wrapper 
around ice_get_tx_topo_user_sel(), adding no real value but increasing 
code complexity. Since both functions were only used once, the wrapper 
was redundant and contributed approximately 20 lines of unnecessary 
code. Remove ice_get_tx_topo_user_sel() and moves its instructions 
directly into ice_devlink_tx_sched_layers_get(), improving readability 
and reducing function jumps, without altering functionality.
Also remove unnecessary comment and make usage of str_enabled_disabled() 
in ice_init_tx_topology()."

> 
>>
>>> Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>
>> ...
>>
> 
> 

