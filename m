Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E07C4829B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Feb 2024 11:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF86960D51;
	Mon, 12 Feb 2024 11:57:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sjO_HpQGB9pp; Mon, 12 Feb 2024 11:57:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B873F60B93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707739039;
	bh=rwOQsI7UG+LMbnYeDVraf1HohZqV+BbQvycgY/ATzfo=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jA117GmBAijqku2x33gtylIrJBjkfcN4P80bRj6jcTbIzvpnKWV+bhaTpR7GHcVkd
	 ypb8M8EF0pNxxwJAe9/fDlHc/H+XDqJMK1oCtEiDSaNPss0fJ8PFoD9Ev5l8znd0kX
	 yTgmR5pw5S/OoCquo6CAtKlSBaUTHiG+eRZ7xm2z1AkCU4InkrB+LmP9FoOMzl9wP9
	 RrNeW2Lbv32ZtWDUD5kdzDv2ykiIu/Tt4+SZa9Z64AOwam5cDpqmzQM1Qxad+Hf4JA
	 SaTdHOFlQ2yfgIWAr3d8LAVP41FOJwnxWyvd7ICgfjMTqdixDCxAUFGQixVUlWh3/W
	 CcuClbyZZS5aQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B873F60B93;
	Mon, 12 Feb 2024 11:57:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id EC0681BF360
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Feb 2024 11:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE37A83E99
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Feb 2024 11:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LGyDvgCsXn2S for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Feb 2024 11:57:17 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=naamax.meir@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DB70083E95
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB70083E95
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB70083E95
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Feb 2024 11:57:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12347857"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; d="scan'208";a="12347857"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2024 03:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="7203745"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.12.48.215])
 ([10.12.48.215])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2024 03:57:12 -0800
Message-ID: <aa9a43d6-6558-4af6-9a7b-2e35341c179c@linux.intel.com>
Date: Mon, 12 Feb 2024 13:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20240206-igc_leds-v3-1-390ce3d18250@linutronix.de>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240206-igc_leds-v3-1-390ce3d18250@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707739037; x=1739275037;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=f6EiuWub7HHpiZW+ID8+bBipEsnHV42m62i4qfxzd5A=;
 b=IzCHOWhVELsrLByGJ2IHgQ5MhokbRC07SYKVk4ITbXx3TytQVGEHdR0I
 KIauGU02xXWVCh/CAwIWiTi8AJAiM59Z4V38rj2egjxV0GIAdHsOPDQuF
 MXlr/YuVSxhb4GtUTC8EDKgyBhXOxeEzpYVy7JlrJ523ztQWTqui7yoUj
 WXwNnJNU62brFsu3rIf9YnfIxpm33xw8HRDxms/yQV81LO6X9Kw2GRPj3
 /9lW5f/DidywuRgIkEolHxEMFTQtseqJP8VDZoy6F6SX1ELcs3TJrfWw2
 J0D/JLSGzlI61LNLW+xIaV3ogkbLjOLfG8pi3IL7w0oeY3eyLUvPVP+eh
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IzCHOWhV
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igc: Add support for LEDs
 on i225/i226
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
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2/6/2024 16:27, Kurt Kanzenbach wrote:
> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> from user space using the netdev trigger. The LEDs are named as
> igc-<bus><device>-<led> to be easily identified.
> 
> Offloading link speed and activity are supported. Other modes are simulated
> in software by using on/off. Tested on Intel i225.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes since v2:
> 
>   * Offload activity if possible (Andrew)
> 
> Changes since v1:
> 
>   * Add brightness_set() to allow software control (Andrew)
>   * Remove offloading of activity, because the software control is more flexible
>   * Fix smatch warning (Simon)
> 
> Previous versions:
> 
>   * v1: https://lore.kernel.org/netdev/20240124082408.49138-1-kurt@linutronix.de/
>   * v2: https://lore.kernel.org/netdev/20240201125946.44431-1-kurt@linutronix.de/
> ---
>   drivers/net/ethernet/intel/Kconfig        |   8 +
>   drivers/net/ethernet/intel/igc/Makefile   |   1 +
>   drivers/net/ethernet/intel/igc/igc.h      |   5 +
>   drivers/net/ethernet/intel/igc/igc_leds.c | 280 ++++++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_main.c |   6 +
>   drivers/net/ethernet/intel/igc/igc_regs.h |   1 +
>   6 files changed, 301 insertions(+)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
