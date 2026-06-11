Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CBECD98D7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 11 Jun 2026 16:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20C4281DF5;
	Thu, 11 Jun 2026 16:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6Ri811EmZ6a; Thu, 11 Jun 2026 16:28:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F4FD81DF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781195321;
	bh=CGyIRICgRd/NqZ0bteifkSKQIsXCGKNhxGk/EF3/cmY=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DNywrr0QzN2qr4i+AJGX9upJOc86/AcS+7CLISkl5riUU1866Nmowf9ISTLKKC1yy
	 8BWYssNgOqgmlDaH3oQJYS78ZlN1bXl2ffz4pSmDSKGecTF9exOcqLz3oGV5w9DcYl
	 JyrIsc/55pQsQfsKXqjgwn//Xy7j1gi+DSgPTOGyjEOd6BPc81W6X6dMbhjmk/lBU8
	 OBfu037YIlJd6yJ885o9Zx6mzpdutxpm3tBhyQQkJOk3WREONrlSyP24bh1OKreen3
	 HlVPVYVFOA89uKQCHRjmhAi0CWS6q1rjC5m5jv6wmo90O244redPky9T2uCq4Y2tuP
	 j87ezQRx0R28Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F4FD81DF1;
	Thu, 11 Jun 2026 16:28:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30376192
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 16:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2015F40B6F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 16:28:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j98f5p9-NIoT for <intel-wired-lan@lists.osuosl.org>;
 Thu, 11 Jun 2026 16:28:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1141340B6C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1141340B6C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1141340B6C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 16:28:38 +0000 (UTC)
X-CSE-ConnectionGUID: dSAuPNmvS2WrjXBcB/+Jbg==
X-CSE-MsgGUID: M5yxOupuTcO9sZ1mPk4tuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81997702"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="81997702"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 09:28:38 -0700
X-CSE-ConnectionGUID: uzMx9dBpTBG2E2LPhIiqaQ==
X-CSE-MsgGUID: qud89/ILT0GMkTpBqsxf3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="276720633"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.20.168])
 ([10.246.20.168])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 09:28:35 -0700
Message-ID: <8d96249e-1492-4111-83e7-b84914e6dc90@linux.intel.com>
Date: Thu, 11 Jun 2026 18:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dawei Feng <dawei.feng@seu.edu.cn>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zilin@seu.edu.cn, stable@vger.kernel.org
References: <20260611161204.605962-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260611161204.605962-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781195319; x=1812731319;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=C0oszD8SAqpd1jfUd3Z9NcqatEKo9eoDC7luL7OG+UU=;
 b=Lu6dPLx6GcyFI+MLZIt7SrYpATlCl8CyyLH36uDziriGefqKR4Eg3YuO
 WV+NlIrXIH22RvVyDiuoohu7c43vCMkBePr3FzfTOLIEUDGMdOnvQ0hRp
 MowzqfD4GyRNjKfsaYcnZpAPzoIhVMnjYP2Xn87BVEn3c5WcMfjmjWzKA
 3cVgZ+zulYc/Hhk9/+swMYfsJwP64gAAmx9TRuFD1GYOy0ob5lrhKKHAE
 +F1ccr+qLS1znpsBY0E9cYEpgebNo5uhaFrLfnIVRrK7uu1mEmwvhy5G8
 SC6xL7qE/Kad291euXvoN67/nJQd80t+qx+75VwZpLihUqRH19PuLTi4x
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Lu6dPLx6
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: fix memory leak in
 ice_lbtest_prepare_rings()
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



On 11.06.2026 18:12, Dawei Feng wrote:
> ice_lbtest_prepare_rings() frees Rx rings only when
> ice_vsi_start_all_rx_rings() fails. If ice_vsi_setup_rx_rings() fails
> after allocating some descriptors, or if ice_vsi_cfg_lan() fails after
> the Rx rings were prepared, the function reaches the Tx cleanup path
> without releasing the initialized Rx resources.
> 
> Fix this by adding separate unwind paths for Rx setup failure and LAN
> configuration failure. The Rx setup failure path releases the partially
> prepared Rx rings before freeing Tx rings, while later failures first
> undo the LAN Tx configuration and then release the Rx rings in reverse
> setup order.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1-rc5.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have an
> Intel E800 Series adapter available to run the ethtool offline loopback
> selftest, no runtime testing was able to be performed.
> 
> Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

LGTM
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
> Changes in v2:
> - Fix cleanup order
> 
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index f28416a707d7..10a4abc66974 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1069,18 +1069,18 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
>  
>  	status = ice_vsi_cfg_lan(vsi);
>  	if (status)
> -		goto err_setup_rx_ring;
> +		goto err_cfg_lan;
>  
>  	status = ice_vsi_start_all_rx_rings(vsi);
>  	if (status)
> -		goto err_start_rx_ring;
> +		goto err_cfg_lan;
>  
>  	return 0;
>  
> -err_start_rx_ring:
> -	ice_vsi_free_rx_rings(vsi);
> -err_setup_rx_ring:
> +err_cfg_lan:
>  	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
> +err_setup_rx_ring:
> +	ice_vsi_free_rx_rings(vsi);
>  err_setup_tx_ring:
>  	ice_vsi_free_tx_rings(vsi);
>  

