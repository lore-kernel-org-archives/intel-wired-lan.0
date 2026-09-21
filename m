Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117BAC982ED
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 11:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6FAF80D45;
	Mon, 21 Sep 2026 11:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MKK1GQ0Q_a1G; Mon, 21 Sep 2026 11:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 15F9F80D35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789990506;
	b=RDQlK9bDXvttx8bt+B2WzBHJe0LqPKQCqWd8sg1rb/kCbFA4QHS5xba706UITvq8Mb2E
	 6cg6w/aRmpCC4EaRAzF59U/A/vWfagoD3NsqIkD6P6ud+AtSpjB1NJYMdv8jSFMFI1CWr
	 VcGlsYjcCMmrf/gkfyVqD0o5miGixqbiT8dsAtvy5XHW7PWzfwOqc7zEWwOfh195GKYKT
	 YyAuRIdF7pFhlKjXAJYGRhcJlFp0VpqxgxfBS2p8ZHlr9eyWRKzCJnt3L/PrVQuUAifEb
	 BHJOQhYZgLXtwiHx7V+f2692wd+Rz3cBr5MoFEEQudGMMXfydE9yJAbhO+Mi4quAKrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789990506;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=407X5Oc1qoGKw4+pVH/7saM0bUZ7/6BURllqVfRHmV8=;
	b=aytXroZNUp7ZLIbWJGkJDvRVSp715DmscG/15wmDRgZrkYbVcG2Mx0o3OZbEJ2wYO4Fr
	 Onifu8bFXstGVpqElVZRRnBaVvRtHMxSLX4kgZJYIAlTLyqpcEPHeBZkqq9V2mCNuQrgk
	 ID92tALjEAE1/RCGZYLJa4H+zeBhOe+JOKmyz9g8ae/JmAmPC/yf4pNMVkExZBnD9ODfb
	 pJO843kjt6/BgsBomQ7Jtgm5J8T0QKZEd0sUkrBkIkCZQ5UsoR5qMrBVeuIXiLixyJ7Oy
	 uaIm2g6WAq/h6Hs6Ot4rf7Jace5f0pIfvE4sfR/5YRe3MhVIfV+x4tuCkjPnnxS2sqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789990506;
	bh=407X5Oc1qoGKw4+pVH/7saM0bUZ7/6BURllqVfRHmV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=atvQ/yOvIpGAO7e8xIEJGO95uXVLIX8lMOjNDqYLm4mDEpKni3gemnG75weUYahSm
	 nsymOWBumXYBwshy2wUY46ggaeBKlc33/PAjAkwVCEEXy1QFzgxemdCfZgJ6jqUGbJ
	 nCgEXu3ZjCiC1U2hNMe19O98wPqxV4UVOQXlGyDlk9eA+mGTHt3QiwIeBGY26pRn0Z
	 T26sS0qxb7o3AhZP64Y5NFf5zQE4eaV8wEvWmB8sRXwXQ0fJzIhODYR+YsrMHTePkO
	 L2pITI9bui8llHdkOJfHzNim0jSjNjJFPgqUXsY3LSSIOIHT+90yZOwErDPTK+7sBK
	 1Ks7u9iErDX6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15F9F80D35;
	Mon, 21 Sep 2026 11:35:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E8FC12C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 11:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0463D40129
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 11:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nTj_q9c8-hK for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 11:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F34BB40111
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789990503;
 b=I8UuUyn9inXnvHn9Vac+XBay/C41YBXrWyg+0p1tK8KDPaHXyZyXh/RtdYOEijFacHUt
 2TSBIVtqK2YDZCEm1+h87CFkeMGaHG1ajV7LJN7O3t96RHZ/XIdsMAtO75dHRK0MVdhe+
 QMFlCKfk7Y34nz14ksot+j/RYJusT+aJNpGob1C63lfUY3ZxWuiHh6cArt8KoJX56IWSD
 9xNJmg4TmE/zAdChF2iZBSxv9SWYmY1O8AI0nl+kIuoCSzPJaTqMILfPPPPev/HzMpn4E
 vhYAtq9EjE8aiOJtq6IF9fJeLrZDBD1PVXEk8ZpsNnqcJYr6MKPQ2gr378kO4lsiSAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789990503;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-IronPort-AV:Received:
 X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=407X5Oc1qoGKw4+pVH/7saM0bUZ7/6BURllqVfRHmV8=;
 b=W6A5elWMJk56PPR44I37lZThZEyYRup1sH+u4gs3OtygjK4Q+rOZspYAhyENg4E45o2b
 FNrKMhFnUoL4k4lppBTphAyzussrlxG8oj+EBC/CpIQk2XL162agK0BxmTqzGUaTZN8+B
 QWVMWGJLsYuGjyUDktWohkK2PXsmQk9acwChg0FQRTmSEazJHbb4J3EDEZnLKl4gI07HB
 hWXEPF35QLn8H8I1RZfLFCR+0FyHcHZ2un76eiBdicxBuutpD6k/XdLsssfZ5D042y7YL
 ttt2sxe6DyEqtz/1T39dY6gZ1L8pvEzXyHtb3hIZ6SkAuWqgL3yoji/pKOJVrkW7n1Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oHiENTAH; 
 arc=none smtp.remote-ip=192.198.163.4
X-Greylist: delayed 62 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 21 Sep 2026 11:35:02 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oHiENTAH
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F34BB40111
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789990503; x=1821526503;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+4/pUrCrEAsoMfa0UqzGzEZRrJcEJa2HeEByYqKSunQ=;
 b=oHiENTAHO6/2Gp5i41Dy9WxboqLQuyuVNqwaa3m3olfjzhP2vPJOLp6i
 1KX4qkgN3qzXg4xEuiuknSj3QGPnhXen4srAzpda74nkaOlBQjqkW9W7s
 OKGW/heTSwjGtRyVILvp2TtUMvvzAq9E252MeWSrKlrCQx5lEm775DyZf
 RZdJP3s7l7LdxGz6ZeBdCqNWWifpUC3D0ktGYLM0NizquSlul9nn4UniS
 A27AuccObb7/P60gjab+nZJjriDQ4NfkO9mbfA8K2yoG2gLuGWP0aAyyJ
 mSp5uOaIZ/XDaahk8U/5Bgyop6QoroGSwjzWNXxSdW1lNVHcZ0UXDoJko g==;
X-CSE-ConnectionGUID: fjvzIxeVQy+3DJvy8hQHdQ==
X-CSE-MsgGUID: tsYea+77RGmnwMZN+F2R0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="999634"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="999634"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 04:34:00 -0700
X-CSE-ConnectionGUID: +qIGTfE4SjKNk712w0iRXg==
X-CSE-MsgGUID: 4oer0P/OToSO7Fzy8DQpbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="269131831"
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 04:33:59 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
 by linux.intel.com (Postfix) with ESMTP id 2D1AD20B5708;
 Mon, 21 Sep 2026 04:33:58 -0700 (PDT)
Message-ID: <e48dad69-8f82-4e50-a016-4dd32b05782c@linux.intel.com>
Date: Mon, 21 Sep 2026 13:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 2/3] ice: fix autoneg disable when link partner
 doesn't support AN
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
 <20260918133234.4169074-3-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260918133234.4169074-3-aleksandr.loktionov@intel.com>
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
> From: Konrad Knitter <konrad.knitter@intel.com>
> 
> Disabling autonegotiation was silently ignored when autoneg had not yet
> completed (ICE_AQ_AN_COMPLETED was not set), leaving the configuration
> unchanged with no error. This could prevent link from forming if the
> link partner requires non-autoneg mode.
> 
> Extend the condition to also allow disabling autoneg when the link
> partner reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the
> ICE_AQ_LP_AN_ABILITY check on the link being up so that stale or
> zeroed an_info when link is down does not produce a false positive.
> Introduce the helper ice_autoneg_disable_allowed() to make the check
> explicit.
> 
> Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 ++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index a257b7d..4ce198f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2501,6 +2501,28 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
>  	return adv_link_speed;
>  }
>  
> +/**
> + * ice_autoneg_disable_allowed - check if autoneg can be disabled
> + * @p: port info
> + *
> + * Check if autonegotiation can be disabled based on link state.
> + * ICE_AQ_LP_AN_ABILITY is only valid when the link is up; gate that
> + * check accordingly to avoid false positives from stale link data.
> + *
> + * Return: true if autoneg has completed, or if the link is up and the
> + *         link partner does not advertise autonegotiation capability.
> + */
> +static bool ice_autoneg_disable_allowed(struct ice_port_info *p)
> +{
> +	u8 an_info = p->phy.link_info.an_info;
> +
> +	if (an_info & ICE_AQ_AN_COMPLETED)
> +		return true;
> +	/* ICE_AQ_LP_AN_ABILITY is only valid when link is up */
> +	return (p->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
> +	       !(an_info & ICE_AQ_LP_AN_ABILITY);
> +}
> +
>  /**
>   * ice_setup_autoneg
>   * @p: port info
> @@ -2539,8 +2561,8 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
>  			}
>  		}
>  	} else {
> -		/* If autoneg is currently enabled */
> -		if (p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) {
> +		/* If autoneg completed or link partner does not support AN */
> +		if (ice_autoneg_disable_allowed(p)) {
>  			/* If autoneg is supported 10GBASE_T is the only PHY
>  			 * that can disable it, so otherwise return error
>  			 */


Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
