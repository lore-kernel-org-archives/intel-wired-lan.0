Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9356C44501
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Jul 2026 14:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F7CC8111F;
	Tue, 14 Jul 2026 14:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id taxua52sLu-t; Tue, 14 Jul 2026 14:14:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEA1A810E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784038464;
	bh=WwOfLsExLQjsVnTkdyekpwvjPk3qh4c4ouoSE36sVDI=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bA1dw/sotfrpUhq2y243ChBiwERZyT4EMi/sLKq5x6PU01d+gm256K4E6vjmdj3Zy
	 BLCkvBgANUz7yRN6r53mWJJ7rubJwNbH9E2j/SckTj7jWFCJafAP47ExfBNe8V7T6Z
	 FHLwycKI3YtULkxfdAb4z+DMjnXEHqkswfQCYgT/c8o30uhR9TULLqGwZmdKU2PQ5/
	 5j64cTGJLQocv5Ex4qBkIsj+VkdWiSsbkBydYXufWvF+96tfXIhmXf4VjgH22Romuc
	 0ga4+wkszIS0LkdM65PBGcJUQ3KAQ0xYPY2XLtZNSsGVGeyUtEDkLO8stdAw/rZy4F
	 gatCTHCxlRyAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEA1A810E6;
	Tue, 14 Jul 2026 14:14:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C95A5128
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jul 2026 14:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA79D810E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jul 2026 14:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4Of-eNnZThv for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Jul 2026 14:14:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BAB22810D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAB22810D1
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAB22810D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jul 2026 14:14:22 +0000 (UTC)
X-CSE-ConnectionGUID: RnmCivFZTgGPm4x/lUX4nw==
X-CSE-MsgGUID: F4MF9PMvRceuzngpWcotZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="107453768"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="107453768"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 07:14:21 -0700
X-CSE-ConnectionGUID: XNDBffWPQcqRRTw6K42CzA==
X-CSE-MsgGUID: fIA3r63tQkqMBAwAez07mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="252485361"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.20.168])
 ([10.246.20.168])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 07:14:18 -0700
Message-ID: <36c68c94-0382-4d31-b114-fde2a5ad35cf@linux.intel.com>
Date: Tue, 14 Jul 2026 16:14:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xuanqiang.luo@linux.dev, intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, sridhar.samudrala@intel.com,
 wojciech.drewek@intel.com, piotr.raczynski@intel.com,
 michal.swiatkowski@linux.intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784038462; x=1815574462;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VkST+EdPPIavkd2tO6RlXwaE19h/M8XpmMIEdjDPk5I=;
 b=lHG+XdUuGwv61L/31aIasQ9oGJ4O7QovgOIcm2zpWBHI4gV4q9e6jgCQ
 RQ4f7nKThlqUJWwyJOD0I4H9AbgvwM/4d6u6Y3UYBqEzaAYaCKe+gmN6o
 2HqwCAawRiHMkNMextLGTMhm1+G7sOGvcgrhC9Og+fV6IUGHLCaMPp6oW
 gezPQYtU9IOkbjrqOoPJjOKQi+P4JFqBwM829McFOlDx+D51iWAao/92m
 x/osAQ0AhZ/N+/teBV4kmWrxpCsTSxFo6mTN3txMd26HqVGo7sXxEvi8o
 XTxsuiPbaP2sEuOoOzyceLM1qkiHmYdulgKCSM5wx6S+CCQ7tPlNhhUtE
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lHG+XdUu
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free in
 dynamic port cleanup
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



On 14.07.2026 08:39, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the dynamic
> port from pf->dyn_ports. However, it frees the VSI before reading the
> index for the erase, resulting in a use-after-free.
> 
> Follow the reverse of the allocation order in ice_alloc_dynamic_port()
> by erasing the xarray entry before freeing the VSI.
> 
> Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Thank you!
I wonder how such a glaring issue survived in the codebase for so long.
Perhaps ice_vsi_free() exited early for some reason.

> ---
>  drivers/net/ethernet/intel/ice/devlink/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
> index 2a2e56777f9f7..3ede246490027 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/port.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/port.c
> @@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
>  
>  	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
>  	ice_eswitch_detach_sf(pf, dyn_port);
> -	ice_vsi_free(dyn_port->vsi);
>  	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
> +	ice_vsi_free(dyn_port->vsi);
>  	kfree(dyn_port);
>  }
>  

