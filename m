Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67067ECAAD5
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Sep 2022 10:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F19A2813E7;
	Tue,  6 Sep 2022 10:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F19A2813E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1662461117;
	bh=DHrOKyeWIRJgAhN2UCcoyfCI69P+PkF4EXmx/iEmab0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=88sR0yp/lrpFRjZNJHYkgrXWtioyZ43vb/NISBqQtYpzBMqjPs0TByAHvJMhmbCIv
	 ssvmh/j6qKA20c1L/4IcsS10GOiFYBjMISYuq3+WLF0KDu1EJC88C01s7/Pm/OHHZY
	 02cy4/e1W5jTvd2aL0uE99YI9pz+kt096cLwD/1enEdAB5ugyWS+qQYUP2dJqAp3ZQ
	 SbZAzG6FnlGYO/2h5f5x2xs7nBTHYhFeWi0UwIK++q3TKEXr1t6qScCJKV8wkvHyO+
	 r2VUNDyPGTjwBBh76akZZnJSZLuN8LHgka9mlm0k3kLLD9rTVPOKWj0ASVbQhaRuGs
	 tMoSGp5IFJfHw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L6jLXCGgBs5F; Tue,  6 Sep 2022 10:45:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6C0B81815;
	Tue,  6 Sep 2022 10:45:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6C0B81815
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id D933C1BF25F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Sep 2022 10:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD33C404B5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Sep 2022 10:45:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD33C404B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZxEybn2hkIC for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Sep 2022 10:45:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B34E44049B
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B34E44049B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Sep 2022 10:45:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="296562825"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; d="scan'208";a="296562825"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2022 03:45:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; d="scan'208";a="644121884"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2022 03:45:09 -0700
Date: Tue, 6 Sep 2022 12:45:00 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <YxckrI4ZWgBybPK5@localhost.localdomain>
References: <55ff1825aee6e655c41cb6770ca44f0fbdbfec00.1662301068.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55ff1825aee6e655c41cb6770ca44f0fbdbfec00.1662301068.git.christophe.jaillet@wanadoo.fr>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662461112; x=1693997112;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nAdc8Rr843R6WJOu79NKjIig8n6+aOXK81VmIUMIj3g=;
 b=HiFz1FbpuAwumwd00puhhiWe/WiQXFpJ4Nw3c+v6RMFhW/6h8FmE0g0P
 l4WccCx0J6HqFOGO4gwsjergL3QE+RgYgkBUDT3EsjpKD6R+H/Cl/DNRY
 T3YnvSJ1SlG5zFXEqCmVRezWKLRRo4ZLhtD+cPiWvDIkzG7oTIPtzV4gc
 RgO58ZhpS8n0GoudI1COPVOc/TjhDW00/mFzuoFsHjMSUBRJDwLCiuOcU
 ZlsDPPkVEB1qFNx9ic4E93O0adA/PIkkt9C2STM4lq1GoDL9YicauYpaI
 3779+zfRfRkYkmdOuXX+tDICUSZZDQGgIlSNVgvglA6JEmibG6lUgYSMB
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HiFz1Fbp
Subject: Re: [Intel-wired-lan] [PATCH] ice: switch: Simplify memory
 allocation
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
Cc: intel-wired-lan@lists.osuosl.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, Sep 04, 2022 at 04:18:02PM +0200, Christophe JAILLET wrote:
> 'rbuf' is locale to the ice_get_initial_sw_cfg() function.
> There is no point in using devm_kzalloc()/devm_kfree().
> 
> use kzalloc()/kfree() instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> As a side effect, it also require less memory. devm_kzalloc() has a small
> memory overhead, and requesting ICE_SW_CFG_MAX_BUF_LEN (i.e. 2048) bytes,
> 4096 are really allocated.
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index 697feb89188c..eb6e19deb70d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -2274,9 +2274,7 @@ int ice_get_initial_sw_cfg(struct ice_hw *hw)
>  	int status;
>  	u16 i;
>  
> -	rbuf = devm_kzalloc(ice_hw_to_dev(hw), ICE_SW_CFG_MAX_BUF_LEN,
> -			    GFP_KERNEL);
> -
> +	rbuf = kzalloc(ICE_SW_CFG_MAX_BUF_LEN, GFP_KERNEL);
>  	if (!rbuf)
>  		return -ENOMEM;
>  
> @@ -2324,7 +2322,7 @@ int ice_get_initial_sw_cfg(struct ice_hw *hw)
>  		}
>  	} while (req_desc && !status);
>  
> -	devm_kfree(ice_hw_to_dev(hw), rbuf);
> +	kfree(rbuf);
>  	return status;
>  }
>  
> -- 
> 2.34.1
> 

Thanks for catching that
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
