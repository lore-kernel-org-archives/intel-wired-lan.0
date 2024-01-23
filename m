Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D533DC47258
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jan 2024 18:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16B1140612;
	Tue, 23 Jan 2024 18:06:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16B1140612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706033197;
	bh=7ssa/j3dpmDkZ3OgBuIT0XpwLPpx9/Pz3jRWEPzs1hQ=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=30ApX+HIjlf0Ys6C1c4kLgwFNAsvgc4eFfoKoNDROPATidKxZubRMq7X4IXzKgrPT
	 pQpP8GHQdCs+RktpOglpUhBYyzzgRjwcw6U6t5SC7J6LGhr2zto7y0VP95c5Fy2yvc
	 xBQ6biIhPqAz1GzVK0OR9YfB0lfa9NvzVUvIq2UmqDh0Y76ty39neMKGns5f3z7tai
	 0FCvrIAkM6APxLa5hOM55WBuG0/ICab7O7mHvr8ODhnSSBi8GEzUqsEOXLoI+gj22C
	 1XCUh0r9Bs1kzozfolK5t7bbVQNhD8G6PY5iJOL+dSYY1NVl+SjeG7gpWo1flmk1PA
	 pK1D0/ltTZAIw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wRsrIHF4jM4q; Tue, 23 Jan 2024 18:06:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07D5140558;
	Tue, 23 Jan 2024 18:06:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07D5140558
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B14751BF35C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 18:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87F674092D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 18:06:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87F674092D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eoC8qm8JxbfM for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jan 2024 18:06:33 +0000 (UTC)
X-Greylist: delayed 324 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 23 Jan 2024 18:06:32 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA5094091A
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA5094091A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 18:06:32 +0000 (UTC)
Message-ID: <6b8ade34-d7f4-452d-9893-ace80c97dfed@linux.dev>
Date: Tue, 23 Jan 2024 18:00:57 +0000
MIME-Version: 1.0
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20240123111849.9367-1-wojciech.drewek@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240123111849.9367-1-wojciech.drewek@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1706032861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ssa/j3dpmDkZ3OgBuIT0XpwLPpx9/Pz3jRWEPzs1hQ=;
 b=N2sVSMFycdcjLYUK54iPsNp1bCJQ4+B/mlsOEmOERuS39v1z076zSJdJRoc8X4sXNN7sOu
 gU92ZM2dVq+uhOGmDQJUmUj4oZJI4/gDA8rLiN+pnXfMzmyk413KVq+etiiBMKei17kT8z
 osAgyQ8zjwhmjdCz7m8VgpGap/kwpO0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=N2sVSMFy
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Remove and readd netdev
 during devlink reload
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
Cc: netdev@vger.kernel.org, jiri@resnulli.us
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 23/01/2024 11:18, Wojciech Drewek wrote:
> Recent changes to the devlink reload (commit 9b2348e2d6c9
> ("devlink: warn about existing entities during reload-reinit"))
> force the drivers to destroy devlink ports during reinit.
> Adjust ice driver to this requirement, unregister netdvice, destroy
> devlink port. ice_init_eth() was removed and all the common code
> between probe and reload was moved to ice_load().
> 
> During devlink reload we can't take devl_lock (it's already taken)
> and in ice_probe() we have to lock it. Use devl_* variant of the API
> which does not acquire and release devl_lock. Guard ice_load()
> with devl_lock only in case of probe.
> 
> Introduce ice_debugfs_fwlog_deinit() in order to release PF's
> debugfs entries. Move ice_debugfs_exit() call to ice_module_exit().
> 
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice.h         |   3 +
>   drivers/net/ethernet/intel/ice/ice_debugfs.c |  10 +
>   drivers/net/ethernet/intel/ice/ice_devlink.c |  68 ++++++-
>   drivers/net/ethernet/intel/ice/ice_fwlog.c   |   2 +
>   drivers/net/ethernet/intel/ice/ice_main.c    | 189 ++++++-------------
>   5 files changed, 139 insertions(+), 133 deletions(-)
> 

[...]

> +/**
> + * ice_devlink_reinit_up - do reinit of the given PF
> + * @pf: pointer to the PF struct
> + */
> +static int ice_devlink_reinit_up(struct ice_pf *pf)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +	struct ice_vsi_cfg_params params = {};

no need for empy init here ...

> +	int err;
> +
> +	err = ice_init_dev(pf);
> +	if (err)
> +		return err;
> +
> +	params = ice_vsi_to_params(vsi);

... because it's completely overwritten here.

> +	params.flags = ICE_VSI_FLAG_INIT;
> +
> +	rtnl_lock();
> +	err = ice_vsi_cfg(vsi, &params);
> +	if (err)
> +		goto err_vsi_cfg;
> +	rtnl_unlock();
> +
> +	/* No need to take devl_lock, it's already taken by devlink API */
> +	err = ice_load(pf);
> +	if (err)
> +		goto err_load;
> +
> +	return 0;
> +
> +err_load:
> +	rtnl_lock();
> +	ice_vsi_decfg(vsi);
> +err_vsi_cfg:
> +	rtnl_unlock();
> +	ice_deinit_dev(pf);
> +	return err;
> +}
> +


