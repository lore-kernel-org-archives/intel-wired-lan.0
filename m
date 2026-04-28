Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1C7FF8868
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 09:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EBF3406F6;
	Tue, 28 Apr 2026 09:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iLPGV36YtYS6; Tue, 28 Apr 2026 09:45:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3E3F406DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777369517;
	bh=hXPiyDd0ZkUo1HEJIGDPriqEgPNiky49ElRO6OeQArk=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fNHkeRlFiKVew9iwfi122F8ZZeZG9ECO3b6GljUslLr0RJ/kHUjSzIR1XqbQG4i1M
	 6Vo6c9wzzf+8/FMoKfLkChaLppozVzCbEYJQRifEJl3X6jzDnhA7BZbu+SZTThUX9R
	 W5gQtEHegohiqmHlDQL/GTzKLTC30LJVJx5GvO9seyPyB+ZcpFl21UxPppIgg6ATll
	 ikUKtGT9yZZjqLCLbM5Nv9qjUTzbOaemWH8xJrekrCl8Uyll5Z6cJTon6p5CpPk0wT
	 gfLgSrmMaFtbCjSzyaGZ0GC5E00eusphpL54jNlaqV0zNN1z+yhPopI6Dda1dq7io1
	 3wgvohSwFdK+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3E3F406DD;
	Tue, 28 Apr 2026 09:45:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A58923D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 09:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37D0460F63
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 09:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRjLaQ3oJzhR for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 09:45:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4737C60F60
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4737C60F60
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4737C60F60
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 09:45:13 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0A9F34C288718F;
 Tue, 28 Apr 2026 11:44:51 +0200 (CEST)
Message-ID: <f9fbc8c3-3b1d-456c-a389-4f95bf07822a@molgen.mpg.de>
Date: Tue, 28 Apr 2026 11:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vincent Chen <vincent.chen@sifive.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20260427031158.2665916-1-vincent.chen@sifive.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260427031158.2665916-1-vincent.chen@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [RFC PATCH] ice: allow creating VFs when
 !CONFIG_ICE_SWITCHDEV
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

Dear Vincent,


Thank you for your patch.

Am 27.04.26 um 05:11 schrieb Vincent Chen via Intel-wired-lan:
> Currently ice_eswitch_attach_vf() is called unconditionally in
> ice_start_vfs() and ice_reset_all_vfs(), which causes VF creation
> to fail when CONFIG_ICE_SWITCHDEV is not defined or switchdev mode
> is not enabled at runtime.

I’d add a blank line between paragraphs.

> Fix this by adding switchdev mode checks at the call sites before
> calling ice_eswitch_attach_vf(), consistent with how
> ice_eswitch_attach_sf() is already handled in ice_devlink_port_new().
> Also remove the redundant check inside ice_eswitch_attach_vf() itself.

*Also* is a good indicator to make it a separate patch. I’d favor this 
in this case.

> This is similar to commit aacca7a83b97 ("ice: allow creating VFs for
> !CONFIG_NET_SWITCHDEV") which fixed the same issue for the previous
> ice_eswitch_configure() API.
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_eswitch.c |  3 ---
>   drivers/net/ethernet/intel/ice/ice_sriov.c   | 14 ++++++++------
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  3 ++-
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f0969035f..c709decb26d5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -512,9 +512,6 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
>   	struct ice_repr *repr;
>   	int err;
>   
> -	if (!ice_is_eswitch_mode_switchdev(pf))
> -		return 0;
> -
>   	repr = ice_repr_create_vf(vf);
>   	if (IS_ERR(repr))
>   		return PTR_ERR(repr);
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 843e82fd3bf9..6a0b724e46f9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -484,12 +484,14 @@ static int ice_start_vfs(struct ice_pf *pf)
>   			goto teardown;
>   		}
>   
> -		retval = ice_eswitch_attach_vf(pf, vf);
> -		if (retval) {
> -			dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
> -				vf->vf_id, retval);
> -			ice_vf_vsi_release(vf);
> -			goto teardown;
> +		if (ice_is_eswitch_mode_switchdev(pf)) {
> +			retval = ice_eswitch_attach_vf(pf, vf);
> +			if (retval) {
> +				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
> +					vf->vf_id, retval);
> +				ice_vf_vsi_release(vf);
> +				goto teardown;
> +			}
>   		}
>   
>   		set_bit(ICE_VF_STATE_INIT, vf->vf_states);
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index de9e81ccee66..71595410174c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -807,7 +807,8 @@ void ice_reset_all_vfs(struct ice_pf *pf)
>   		ice_vf_rebuild_vsi(vf);
>   		ice_vf_post_vsi_rebuild(vf);
>   
> -		ice_eswitch_attach_vf(pf, vf);
> +		if (ice_is_eswitch_mode_switchdev(pf))
> +			ice_eswitch_attach_vf(pf, vf);
>   
>   		mutex_unlock(&vf->cfg_lock);
>   	}

The diff looks good.


Kind regards,

Paul
