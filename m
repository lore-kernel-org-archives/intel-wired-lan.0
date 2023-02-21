Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC7BC61DA3
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Feb 2023 08:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6962082422;
	Tue, 21 Feb 2023 08:01:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6962082422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676966494;
	bh=zd8hi0h7fGSvpC5gIpvu+bgv6j8+ZxF8bqnb6oFI/A0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LGBJoExXLGBA4aIIV44LL2k9kPKjsugVBZAGbjZ9oMHYeR/snEho8H4ra0qhJc9U/
	 Udx69ehuvvBUaanS48w4P+FUiD1/ClWTeLA4ThhSc8ow8278l+o9PXo6pDcPgBPjfL
	 VoqRDI3haA9fNvHbpBFoD7eZkhcI3zXcN8Y1HkLe+i7pux2YinpFfk5i6BdhNlcUVP
	 JdIzzL3aQ0hBU5+7FWd4kLJx7BgcHfN6aSvQoEoK+1Y21xPH6tiyWHI2fg+OkSgXeX
	 8iUlds4jX5UQpc6rfkq7itvXqoQonUuuAPNvqGJs0eJ/1nfdv2m5JcHlOG79Qyom06
	 ZpBozUukcw8Ig==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4adH1wBvhhhq; Tue, 21 Feb 2023 08:01:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AA4C82430;
	Tue, 21 Feb 2023 08:01:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AA4C82430
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id EC5661BF2EF
 for <intel-wired-lan@osuosl.org>; Tue, 21 Feb 2023 08:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C450861161
 for <intel-wired-lan@osuosl.org>; Tue, 21 Feb 2023 08:01:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C450861161
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aKBgH3NczkE8 for <intel-wired-lan@osuosl.org>;
 Tue, 21 Feb 2023 08:01:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04D7C61160
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04D7C61160
 for <intel-wired-lan@osuosl.org>; Tue, 21 Feb 2023 08:01:30 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-3-Ky_KPNUVMxWKQYCX01xhGw-1; Tue, 21 Feb 2023 03:01:28 -0500
X-MC-Unique: Ky_KPNUVMxWKQYCX01xhGw-1
Received: by mail-wm1-f70.google.com with SMTP id
 s18-20020a7bc392000000b003deaf780ab6so1529256wmj.4
 for <intel-wired-lan@osuosl.org>; Tue, 21 Feb 2023 00:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1676966487;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=20m9O9S935OXurO2qATakjHtcSQgyRGzklNBw5/tXJQ=;
 b=76irJz2Y7wOw2oOAxPg7uXYzEIkTDOtiFaoPPTajV+IAwEzxR6OuFvTotgH/LO3RFe
 Egx/x6bjR7XXHjwJDJ0G0fyaxFyWVreFqOYQVJf3X2iPFWIGvgFVdWMlNLdOV9U9MKae
 u5zK76tBES0aEN2NNMTDhcUHYg/P3OV1HUp8TCMffQKkAkzT7VLXSmHkqFptWTGUeduX
 oXGCRRfJYdLLAe6hRs0C5wdM65qol0e7om1OOy2Bq982chgJawH0Wd06ro3HWMliLnvn
 FNP+e+a6cbY8aQLArQKXDs2BczxbACfAcViMpHCKpaj/spjghfZReSXblQHbldj/JQmp
 pkfw==
X-Gm-Message-State: AO0yUKUjHOQkQNKKgX0l8QLzR5EHHeiNOH+ZPPV4GCX0V7yhsxzZCUW/
 A17vkNSD+zjdoD9+78Utotgv5/wiMj+j3YAKZ7GGGSQJxtfI0XdVm7O04uzxjcZ8+6sQO09rut7
 CkhEwr9CCMrzr+Ydrty2eUg==
X-Received: by 2002:a05:600c:a05:b0:3dc:3b1a:5d2d with SMTP id
 z5-20020a05600c0a0500b003dc3b1a5d2dmr3447684wmp.0.1676966487531; 
 Tue, 21 Feb 2023 00:01:27 -0800 (PST)
X-Google-Smtp-Source: AK7set+d8BkkknfvE1kWSeXLnDiDryM/K0/dpHAcEiLlRRMcgi2qSCb8KXSRJ0F4bHenQXyCTAd4yQ==
X-Received: by 2002:a05:600c:a05:b0:3dc:3b1a:5d2d with SMTP id
 z5-20020a05600c0a0500b003dc3b1a5d2dmr3447629wmp.0.1676966486898; 
 Tue, 21 Feb 2023 00:01:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
 by smtp.gmail.com with ESMTPSA id
 az35-20020a05600c602300b003daf672a616sm958872wmb.22.2023.02.21.00.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 00:01:26 -0800 (PST)
Message-ID: <7dcc62b6536be05c784a50bf8a6da89eb3003697.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>, netdev@vger.kernel.org
Date: Tue, 21 Feb 2023 09:01:25 +0100
In-Reply-To: <20230217220359.987004-1-pawel.chmielewski@intel.com>
References: <20230217220359.987004-1-pawel.chmielewski@intel.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1676966489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3yXs3yxCgj/8R+9EjQNp1VSlaK1pR74ORMtuTLFyqc=;
 b=ZvoHckLNinr0SxrOQ+CDgHNmJCUw+axRte5DzM3AK8Xt1Yf3DBVep0Gm7TWz/yUDRx3qPk
 KgWAHR3igTGHkJQSPwf3UcdHEfUYiuVq7HG445hjE5BMwUQEH3MLqunZu3RcGyyJWXHLzj
 MrSwd3ZyJW/bPXUw+gg1+yA2jTLVov8=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZvoHckLN
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/1] ice: Change assigning
 method of the CPU affinity masks
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
Cc: intel-wired-lan@osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, 2023-02-17 at 23:03 +0100, Pawel Chmielewski wrote:
> With the introduction of sched_numa_hop_mask() and for_each_numa_hop_mask(),
> the affinity masks for queue vectors can be conveniently set by preferring the
> CPUs that are closest to the NUMA node of the parent PCI device.
> 
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> ---
> Changes since v2:
>  * Pointers for cpumasks point to const struct cpumask
>  * Removed unnecessary label
>  * Removed redundant blank lines
> 
> Changes since v1:
>  * Removed obsolete comment
>  * Inverted condition for loop escape
>  * Incrementing v_idx only in case of available cpu
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 1911d644dfa8..30dc1c3c290f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -121,9 +121,6 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
>  
>  	if (vsi->type == ICE_VSI_VF)
>  		goto out;
> -	/* only set affinity_mask if the CPU is online */
> -	if (cpu_online(v_idx))
> -		cpumask_set_cpu(v_idx, &q_vector->affinity_mask);
>  
>  	/* This will not be called in the driver load path because the netdev
>  	 * will not be created yet. All other cases with register the NAPI
> @@ -662,8 +659,10 @@ int ice_vsi_wait_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx)
>   */
>  int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
>  {
> +	const struct cpumask *aff_mask, *last_aff_mask = cpu_none_mask;
>  	struct device *dev = ice_pf_to_dev(vsi->back);
> -	u16 v_idx;
> +	int numa_node = dev->numa_node;

The above breaks the build when CONFIG_XPS and CONFIG_NUMA are not
defined.

Note: net-next is now closed, please post the new revision after the
merge window, when net-next will re-open.

Thank,

Paolo

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
