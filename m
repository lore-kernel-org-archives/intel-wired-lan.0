Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DC0CD8CA4
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 Jun 2026 14:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0086945BE9;
	Tue,  9 Jun 2026 14:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1AGMmxP1OC87; Tue,  9 Jun 2026 14:27:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 051D645AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781015250;
	bh=fZe+AvGu6g0N6sslh5TZxvd9YdT5FqREW1tepqDbKN8=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OJeRGK/3EJLWVaTsjnF4kebqN4Ek9emkgvFqQIbsa55wcYM36Vfd0pqRzZN6dspay
	 XYh1DgrTJBlZZ3d0EPpAi9fPQ9ooTPBNkLFm0G3kz3TQ39vJdeXYuVhGXHR3SXRw5M
	 NxDrPOZ96sFi0JfeaoJRxwub0l0cf2pHX/qw/oME8LBvj9kUz2+t7PBNP0hBnEMgWh
	 30/Qzly8sv2zWbCtNy2qjGKMCOsx3haHIE2oc3NkQ0pimq52aHxHj0iEqpziywn/A8
	 K0iygJuyIrxX5JK0YQYKANQAv0mpdlTzW3IMv/Cr5PEJB8unejSlQA8HzTfUNMx2MR
	 +TefXDgJVWnqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 051D645AC6;
	Tue,  9 Jun 2026 14:27:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 676EC190
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Jun 2026 14:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CD4F4273B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Jun 2026 14:27:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 22mnzBSCNXRV for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 Jun 2026 14:27:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1C2E640680
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C2E640680
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C2E640680
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Jun 2026 14:27:26 +0000 (UTC)
X-CSE-ConnectionGUID: Mxl/mGkKQymwKk2vfd1eSQ==
X-CSE-MsgGUID: JcsolVKJStmcGk8P7sqfiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="107213036"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="107213036"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 07:27:26 -0700
X-CSE-ConnectionGUID: 6tqw48DKRHCJg2OyMoYNvQ==
X-CSE-MsgGUID: csqgTnwCSRSXu9Qqitz4fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="239537131"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.94.249.113])
 ([10.94.249.113])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 07:27:23 -0700
Message-ID: <ea66e44e-c9b0-4942-af6f-0b76e3f065a1@linux.intel.com>
Date: Tue, 9 Jun 2026 16:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dawei Feng <dawei.feng@seu.edu.cn>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>
References: <20260609125021.3873270-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260609125021.3873270-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781015247; x=1812551247;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Hc73zFAvz2tICSssvWylf3xw9PZh/KwFdXDcFohR1PI=;
 b=nTknKs6TUjP+KoOqcGkwtfB5+/0feRSakSxxSgnswPL+HseUN8J84+90
 eYNv973Y4vywY00lTwrjueGZSFt26vF1520hyH3f5vK0hApojQdM4dEwc
 JHBuQTFptrKUT2Z+24ciOfKHU3hlZgTi47VequI+NbVY5XmceA254tWrW
 R5SmbRUSLn/td0PpbY+UZd/KXVgEikqq79MD/679Mwa/WgARULyUQ4JIl
 Xc4dZZ+KkgE5yLX0Ib1xDZhW4/OcrslihXp28ZGazG+iE5ws7P/UDlhDL
 4NthKEUNDRyxwqsEpU1DFB1QBncWEKQTmDcTyumIzoTQkJxYUtXkxn/AV
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nTknKs6T
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix memory leak in
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



On 09.06.2026 14:50, Dawei Feng wrote:
> While ice_lbtest_prepare_rings() correctly frees Rx rings if
> ice_vsi_start_all_rx_rings() fails, the earlier error paths for
> ice_vsi_setup_rx_rings() and ice_vsi_cfg_lan() jump past this cleanup.
> If Rx ring setup or LAN configuration fails, the function leaks the
> initialized Rx resources.
> 
> Fix this by routing these earlier failures to the existing
> err_start_rx_ring label. This ensures the Rx rings are properly freed
> before tearing down the Tx state.
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

IMO last two paragraphs should not be included in commit message,
rather after ---.

> Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index f28416a707d7..7c81ca313645 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1065,11 +1065,11 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
>  
>  	status = ice_vsi_setup_rx_rings(vsi);
>  	if (status)
> -		goto err_setup_rx_ring;
> +		goto err_start_rx_ring;
>  
>  	status = ice_vsi_cfg_lan(vsi);
>  	if (status)
> -		goto err_setup_rx_ring;
> +		goto err_start_rx_ring;
>  
>  	status = ice_vsi_start_all_rx_rings(vsi);
>  	if (status)
> @@ -1079,7 +1079,6 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
>  
>  err_start_rx_ring:
>  	ice_vsi_free_rx_rings(vsi);
> -err_setup_rx_ring:
>  	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);

Correct me if I'm wrong, but looks like unroll order is reversed:
ice_vsi_stop_lan_tx_rings() unrolls ice_vsi_cfg_lan()
ice_vsi_free_rx_rings() unrolls ice_vsi_setup_rx_rings()
(was reversed before this patch too, but since we're fixing it, might as well)

>  err_setup_tx_ring:
>  	ice_vsi_free_tx_rings(vsi);

Thanks,
Marcin
