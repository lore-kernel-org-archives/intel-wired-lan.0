Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19339C982ED
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 11:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B76F0605FA;
	Mon, 21 Sep 2026 11:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cwbDdhpin5mD; Mon, 21 Sep 2026 11:34:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0CF8E606A5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789990447;
	b=KRKphvgd0qn+7Vsmz8X8trMXGuJ8qKv84QpavQ+VeMdGdwgVQqS+zoYfF9q4LapisLco
	 9LzcZhy4ffk21fcVsrkJovxSaxw3PLw8DlW0Q/PLm1PcSeSfJ7wM2GFUDSVpCxx0U+s+Y
	 9rKacqZR/qLEy+3yaUnI5Ytyr1Yt/0KK7sT5iu12QdxfX9r6z0I4pGkqnmZfXQBrqJp+E
	 D2FXO33jyG2PMrCLxunCrM307EL8JNMjV7CLWcnQ164V4w817wnkLdie8BoB+FfVEBqtu
	 rFrigmKyi8sEJfhl5fwB9nffHLP0NTzCHkxdpzHmhN6RyDppwmgk3mhpFv8YLBKFpyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789990447;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kN7vmmuVJzTD1XjLHTv3ZlgewycecPKrXLoSDAxiCGo=;
	b=FEwppmq4Xp2Fz4+rddHnFH/uPGlZDNXTXk0tQa41scsl86ChTZWXC1EFnlL6nAxL95Kr
	 VvwgAehBCLDaKsVKCaQj6lGVvCWWgQ+NhF6Bwpoec5OBBdg7zeD5MHDgs7Uw3cACEYTE1
	 TUoiLqlJtNsefDEP8TM9waCfXhyIQ3oF1ge5u+TNYfThOW8UY/GDUgzO9WxB9dLbcTxCZ
	 gKZGKooMvqeQW8vLj2+v+1WX2d5wotSlWOFthLWUf5ynZlNgHBbC6CLTOj1R6XENM5caQ
	 7A7ErQk+jfVH2cpdLBZUzieMAbYGYi6QlN2/9HJmHFFfySIuVB0mJpUR1qB5E0BkWzg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789990447;
	bh=kN7vmmuVJzTD1XjLHTv3ZlgewycecPKrXLoSDAxiCGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k6yuP1OZxoC3U1CNdJCLDGtH+NquxtS3ohlkEvG9f1hFC4Jm0R4lW4DSjGS/rdSV0
	 n9TmzUYA3lS0jz/s+1NhmxLYuH1yUHRTFE6qU9IseRt/HCk2/n3RzyvcTBv1GkQxsd
	 Cc8k6Zqxk05tkzN6WKc0qufZTxOn2Jwxp/Ie8Sgj0FBm7SSyuYCF0EVmNVl3m+dOxx
	 LN/2eaOqmQCZLmXLmBWvrRdXQuwy0mJys+2YG+kbShP5BQgznW/78jkn8kAeCxH9Zi
	 6Bm7xayweondDiH7BFYRSpBYD1XRObiQlVJkQgiMtvbw4yYnwQgtKPoW1FRiOJQyWp
	 jSV9IaUAerWkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CF8E606A5;
	Mon, 21 Sep 2026 11:34:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F037912C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 11:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E192140B05
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 11:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lTzG2eySp_6 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 11:34:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D4ABA40AFA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789990444;
 b=aBss/kIMhoQxAnEy8Pg1ybt5x5auF8mVTfmVnp1H5TFC+wf04x0eFKGCkoz5d1U8wgSE
 Ikj0nAlt1Q/uRj6yN/3o40GMjITYaJ/0WSpW0nmWU9W9sgbFI9FRSOV/08hZBYesg9UrA
 J2zRHTrkg6uiFG2ELl3lcTqEMi8UcW6/9W24miGTABDPYM5ymzXMbx0+tJbIf7/f19XJG
 2IGqmJjxjQhWtzpoNDbApXRrQH8zYIbwQIt2ypqWe/Jw+gfb1HUuXSK7fQbcDLkK+UPTe
 gxOOoomx1KUeptk6sJRUUnwxVyD/5Uzar1PSLXcIp0NvM0TpqxXFjtth989Xl1PCR1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789990444;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=kN7vmmuVJzTD1XjLHTv3ZlgewycecPKrXLoSDAxiCGo=;
 b=hSE4DSbw41clMmiXmxk3TqHwfxQ3TTricjlbIhZWgqU5zoUMdEwfehp8e4lTJb4bJE87
 x1/lmAO4qmjLKCRLSfNUuza96Y2XfaamB6il9LSqR8yEwhO8w4+pYN9q9GTyyl/onsD5w
 BiXlYZYnBsgUQBb0wPDbOryug8DldAMpiWODcCrprjYY+uJ6Zpl2exGi+49IwL0fYkiXH
 pygyFiF52CdhQgOVN6zxhQXriph6o6dl8cqwAK5Lz1QoS4UX7yHdygcLvcgECk0RIwYrS
 yLv9XIr49g6G0DLEM/c92IcsWhFj8GyRV2BGpQaji84DjYPXzUtnjkhYD5RN7GMt/LA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Tdqo+wx2; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Tdqo+wx2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4ABA40AFA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789990444; x=1821526444;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OWarSK6EoT0aqZXoUNieaTaxM5MZdtHgPk3Ij30+lYw=;
 b=Tdqo+wx2y7yCvM6Y8svN45wGbYTsoVPb5NI2wiuGJgkmsF6EHNh0dDxG
 A6k9yneRSU0fHyFA+bFAkfbxzMz2u8zDPMT9DKKOLNI6ogdcEyJodYdcA
 UMTeXHdyu2xJYrKuGtSXvnGbRmQK+2hLA50OrfcJK3RXPl908//qRYA8q
 CbHQDWZoQ+uo6eMXP0lEiew35ilKt8G5QR0SIdlJFQUdkru12B/EBlIb1
 63gDfDr/VqClMRQPN5n4c3lJE+11CuiU8OYSKpED6JBlAD7B3gKdto0OI
 C4Q3DThgpImtKUPOewxohqgJ9eni64cqJ9KvWCrxA9Utxce49jJhTyc4b Q==;
X-CSE-ConnectionGUID: jUJkR/dBQdmERJnE3+S32A==
X-CSE-MsgGUID: RGtLs+bTTPm8WQC8KW66Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="89423259"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="89423259"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 04:34:03 -0700
X-CSE-ConnectionGUID: b7zaCkNOSQmuCZlogyh8Zg==
X-CSE-MsgGUID: ibFLg4ziTeWp4WVsY81uBg==
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 04:34:03 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
 by linux.intel.com (Postfix) with ESMTP id D5CCC20B5708;
 Mon, 21 Sep 2026 04:34:01 -0700 (PDT)
Message-ID: <f00e7805-2da6-4124-a90a-ff74bd08896c@linux.intel.com>
Date: Mon, 21 Sep 2026 13:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 3/3] ice: support RDMA on 4+-port E830 devices
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
 <20260918133234.4169074-4-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260918133234.4169074-4-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 18.09.2026 15:32, Aleksandr Loktionov wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> E810 and E82X devices do not support RDMA on configurations with more
> than 4 ports. This limitation does not apply to E830 devices, which
> have a different hardware design and support RDMA regardless of the
> port count.
> 
> Narrow the RDMA capability disable condition to skip E830 devices.
> Move the 'RDMA functionality is not available' notice inside that same
> condition so it is only printed when RDMA is actually being disabled,
> instead of unconditionally whenever num_funcs > 4 -- otherwise E830
> would log a spurious warning even though RDMA stays enabled.
> 
> Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 0463310..1c4421f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2510,16 +2510,16 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
>  		caps->maxtc = 4;
>  		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
>  			  caps->maxtc);
> -		if (caps->rdma) {
> +		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
>  			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
>  			caps->rdma = 0;
> -		}
>  
> -		/* print message only when processing device capabilities
> -		 * during initialization.
> -		 */
> -		if (caps == &hw->dev_caps.common_cap)
> -			dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");
> +			/* print message only when processing device
> +			 * capabilities during initialization.
> +			 */
> +			if (caps == &hw->dev_caps.common_cap)
> +				dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");
> +		}
>  	}
>  }
>  

Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
