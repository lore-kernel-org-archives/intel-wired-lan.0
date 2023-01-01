Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A07BC4332F
	for <intel-wired-lan@archiver.kernel.org>; Sun,  1 Jan 2023 11:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06F3660DCA;
	Sun,  1 Jan 2023 11:15:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06F3660DCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1672571717;
	bh=U62+BM0secWAJlEqy6/EMyokrmbMLYGfNceLWz3XtJw=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=WT6sUSWmilxbiGHXr/9QwYMkPfWGV7btr5iDMhE4F5Nsw1YWlI/cJdYdQ4IixtdPq
	 vwtdqXzOQzCFNdyVVZTzcZafWRi5zVTf7QXB0x4YDDuSAIrvweJ7Y4Ot/Ri+ryeil0
	 gZN0n5I/kqsPym/wW0WiN5EEW/vQZz+67BX42dwg/PFlvr5AraawFzU/E93lVnV3Yx
	 FfTebQzf+jLdiGDwYv8KquiDUkVEzRDLRfi3iFu76oRe1EUbMGcVI12TxlfIE3w13c
	 sKovFHPsRXldrN4C/I90/c9XyAYuxz0gldtm4Ie6ier+Tf4T8LJZRqZCcyhJ+6eoj/
	 gC4rU4+Mme+DQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MWkKCeP2m9Eh; Sun,  1 Jan 2023 11:15:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 224F660E11;
	Sun,  1 Jan 2023 11:15:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 224F660E11
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id AE21E1BF392
 for <intel-wired-lan@osuosl.org>; Sun,  1 Jan 2023 11:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93B6A402C5
 for <intel-wired-lan@osuosl.org>; Sun,  1 Jan 2023 11:15:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93B6A402C5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qO3yPs9mxdCf for <intel-wired-lan@osuosl.org>;
 Sun,  1 Jan 2023 11:15:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE0C1402BA
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE0C1402BA
 for <intel-wired-lan@osuosl.org>; Sun,  1 Jan 2023 11:15:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="319076345"
X-IronPort-AV: E=Sophos;i="5.96,291,1665471600"; d="scan'208";a="319076345"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jan 2023 03:15:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="828331256"
X-IronPort-AV: E=Sophos;i="5.96,291,1665471600"; d="scan'208";a="828331256"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.11.251])
 ([10.13.11.251])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jan 2023 03:15:11 -0800
Message-ID: <26dc7694-128e-3529-83f7-b52ab338abca@linux.intel.com>
Date: Sun, 1 Jan 2023 13:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 intel-wired-lan@osuosl.org, vinicius.gomes@intel.com
References: <20221215225211.1071-1-muhammad.husaini.zulkifli@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20221215225211.1071-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672571713; x=1704107713;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VXXl42xujqT01DrBebD6kSyyIgx3j1rgm8JVY6xGrMA=;
 b=Y6CKJ0Sh/GZeVmGhfDbxAdx1nj8P9nLwsJ7Yx14CdHaJLOWPpUhRW6Fv
 onOl4g1zN5GH3YApnChRMgGts1355kv4WD4PwfgrKarxwWNLHv3bBIx20
 QJDNTIksVKWSwngzv13A65BZbP/f3UFer3Y/i0sze8ybqXk1NjpHwn+Ob
 gYsOY55JgCXxgPt/lpMUcZGgB9ds6Tw2rJUr/a50BGgDTOoWfeUST1nkq
 2w/wt1RjNoNk3RF/dVOKzeMVUm7AgqacaF1yPmFDlsM633K7uOhKoZdPx
 qMBboOqLCTIy96lB+QArDUdXU4yrIR9V/dlHN/Lf9ZatgBb2dYDt4QwTs
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Y6CKJ0Sh
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] igc: Add
 qbv_config_change_errors counter
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
Cc: anthony.l.nguyen@intel.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 12/16/2022 00:52, Muhammad Husaini Zulkifli wrote:
> Add ConfigChangeError(qbv_config_change_errors) when user try to set the
> AdminBaseTime to past value while the current GCL is still running.
> 
> The ConfigChangeError counter should not be increased when a gate control
> list is scheduled into the future.
> 
> User can use "ethtool -S <interface> | grep qbv_config_change_errors"
> command to check the counter values.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> ---
> V1 -> V2: Fix wrong tree applied
> ---
> ---
>   drivers/net/ethernet/intel/igc/igc.h         | 1 +
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 1 +
>   drivers/net/ethernet/intel/igc/igc_main.c    | 1 +
>   drivers/net/ethernet/intel/igc/igc_tsn.c     | 6 ++++++
>   4 files changed, 9 insertions(+)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
