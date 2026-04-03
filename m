Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ACDE85367
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 13:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1116E40F52;
	Fri,  3 Apr 2026 13:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Uwu9CRIIeyj; Fri,  3 Apr 2026 13:07:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF46A40ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775221623;
	bh=eX9Ro0g3ZwcrU0LsDEwPDxGhO6+poXF2La5ETCti+cE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mtotqdAA7hftxw/3q4ZjnqsU6+/bhlkaBXoyQ5vdLWT+5xSAlK5jbWhKHM5VBVQyX
	 hCpvFSWdCsG43tP22UTTxOTGoZ5bKK1B133xdbzKJ1O/WmWFHEepYCK6k3PKLJGOyM
	 tCs+yAhEL3lCsUUndcxDDhv7Cx2lRu/Qh2v5lEUZPHowsigIuk5eZU+v9E/8xUBH9w
	 0g/7O6v4/KzgXnsRzRW2yW5H8NajOIJVeMFXG6mA9scL7kNnYedzzicbjB5cKDBSyM
	 DDyx6oixcuntc1nXCeBWjd0crUKxfMEVkqiuoKhBfHKUUx8sDQJzzTL7ml16BbfCoQ
	 3GBadtpr1uTGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF46A40ED8;
	Fri,  3 Apr 2026 13:07:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9496E1A9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 771FC81BCF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:07:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GRnPkEQzR0oo for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 13:07:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D396081BCB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D396081BCB
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D396081BCB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:07:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 29F8C43CD0;
 Fri,  3 Apr 2026 13:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3F5C4CEF7;
 Fri,  3 Apr 2026 13:06:59 +0000 (UTC)
Date: Fri, 3 Apr 2026 14:06:57 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>
Message-ID: <20260403130657.GA110554@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-8-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-8-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775221621;
 bh=MvYZp7NV0bNnPtYiJFZfLQoMzo5b+sKc6tBosXsoARQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FhQc29t9aN3aV20vOc5k64lTHEW45zjofrD97FHnigtk+rlCSt6BMhK3bgOPvlVKo
 nnqQ0VYdOtLuB6opGrZdhre6IkqhEiFpSsB6NQzcvtSqEOvRYibnaT/SP/YcD0ksIi
 yB0sfgFz451i0LdGQod6HTZb01faG2UYdi1YmFByyHRRktCz1Tq9UqtOMfSm0YxP+C
 sODW71Kcws6NC5BdfhLrA8inCBvgYiHD5Yh8n45J8pEf2OQGfo8U9PSIJrsakzXhCU
 n/4jFMNVCoqQY/u2gmVAe4+YD6u8CkeGP50ZyLAjq69Rb1JtLPoY2l+Ehhszp7aYNZ
 WHH+gc9a+2eZw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=FhQc29t9
Subject: Re: [Intel-wired-lan] [PATCH net] ice: stop DCBNL requests during
 driver unload
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

On Fri, Mar 27, 2026 at 08:23:31AM +0100, Aleksandr Loktionov wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> With a chatty lldpad, DCB configuration requests can arrive through
> the DCBNL API while the driver is tearing down PF resources, leading
> to use-after-free and NULL dereference crashes.
> 
> Set ICE_SHUTTING_DOWN in pf->state at the start of ice_remove() and
> check this bit at the beginning of every DCBNL callback that accesses
> resources freed during the remove path.
> 
> Fixes: b94b013eb626 ("ice: Implement DCBNL support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> @@ -308,6 +326,8 @@ ice_dcbnl_get_pfc_cfg(struct net_device *netdev, int prio, u8 *setting)
>  	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>  	struct ice_port_info *pi = pf->hw.port_info;
>  
> +	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
> +		return;
>  	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
>  	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
>  		return;

I think this problem predates this patch. But AI review warns
that callers pass an setting without initialising the data it points to,
and expect it to be initialised on return. But that doesn't happen
if the function exits early.

It suggests that callers should initialise *setting, and the AI generated
review states this is the case for other callbacks. (I did not check this
claim.)

It seems to me this is not strictly an ICE problem, although a quick
scan showed up a mix of driver that ensure that the setting parameter
is always initialised before return, and those that don't.

I think this problem is orthogonal to this patch, but seems to want
fixing.

...
