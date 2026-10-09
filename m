Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF67CA6019
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 13:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1BC3408B0;
	Fri,  9 Oct 2026 13:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L68DB32boSrL; Fri,  9 Oct 2026 13:05:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E395D408AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791551137;
	b=HA2Y9ilB92c76vUxNkmaFuoydg4Fh3jiExGY+sRUJdeP+XleTkWMWR4IQRY91iBMtLMt
	 VFtZz7yCYPIR29SP+xzjnZ7slNUzUb6a5DW/tgbXuZ4YPK7sQcWvz+RbEaMcYdyWdbN6y
	 8zyUWq/hbIMmR6ZCcngWSPvLo1RZXAa8uaUR0+mT7Kb8kqic8ox0Youe3SZoyBBs7ZFJO
	 4RXJX8tX/o3GS7UAQyre84x7yJ+z/qGxitJearP3GRCi0mjpVrlMW+KOCD8/3T7id1t+i
	 XL4C37x+wxfz1YJl71/K1ZjTGs0W9NQVABQsV0krpw+dquGa+AXCJ1Nx+v7qthuFU9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791551137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=nticlbH/kEitXMO0Q3PrRgzefpvclEfLz/YGXTWSlQA=;
	b=YIm/hw777RDlZohzJoumGTOZlaSkfoEliAM/fFEx23m0RYgK2G9r3BbS5/h2y5F2vRpW
	 OaPW2D2eZ3ghemx8mV7zMes8eJWvOoGDQCxdxla/ckzdyPYWnIAVqH36dipUCQ0eR2/sw
	 IdXI/gSJJkjpFORKrr0qK+xyTJ4g9wcRUxXg6jbNEwsLrYWv7xBl5XdKCqX65cvSF/C6v
	 ljtEtlNOTvwP4jKemkzgiyXeIRG08AbjBeSrX0Po8wNeZO4KBpk8WoCGU5RC8E364wUSY
	 iM5hutp5iEDSp8OyuvNFCHigYxsh1vQkX65CwV1ELNNK02A6VgbL8Lw7xap8oIj7KKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgjQs0eJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791551136;
	bh=nticlbH/kEitXMO0Q3PrRgzefpvclEfLz/YGXTWSlQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RqUzPyl/JVO3xxtxiBSIqEi3fva20VaulfuDsxVeb/eseJzn5PA7vAOfod5jBswdN
	 s+NrTEXJnvdpORluCVMpXBrbwG3m6WQhf6a0x3HCAaGmFWtHi5WEEybpCYW0nb/4rw
	 RhwWus3nVMtZm4/7ryTbV0WsUm2irB/JxetgbHhGG+9Je+1UvPPFyc8VtJJX38jvHZ
	 DRslNMa2+h8R3eVVKjA7O/eHw0ECxLJe0APkYzOUtRKlruQWXVfND9NJHw6X6vPW0I
	 c+P4iLJQFwrC6Rg4uHf2t1J3qtODXEix0VDhbgJtrpWXruorKHpnA+XJJBZCyS1ZVR
	 CU7HFgL6lrAgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E395D408AB;
	Fri,  9 Oct 2026 13:05:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0208375
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBE25408AC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2-NzBOJpLf3l for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 13:05:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E501E408AB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791551134;
 b=CCB6Gy9595PFNwExB0zQB0oPNaxtedEOvnoelxocNJ4+/Y0NBs+yoefElbviLb5QlECE
 ez2ae82wHe3lP3gs/shNbvRIhWlTgP6pkzC5f0ZJhCapld/yCoRt+Dcp/N0/BZR3B4cuy
 KBGnvcZklQMKjtmH/UU+g0SrQwnJcmjzGWMPwnkrZnqn4jAGidRYZE3rxohXm7eEtjATU
 1lPFD4My/VdShU8ta8dbkttfo8eSKxsB8HtWcHrfRPXdL3gA/tSCc+GooVvItwdrz5HLd
 DkoLAs/m1MMxak3p/5DsI4ycEhE5JKozDpzqoKcsBuY58qNcTCUdpIiNvYltEUKrHJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791551134;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=nticlbH/kEitXMO0Q3PrRgzefpvclEfLz/YGXTWSlQA=;
 b=EGINI/xXMpD4dVphfh77d67zRz+d5IAonTLB7Wfg8teXziX9/bj+AyxdNE6sHw2iEY8n
 fDxfKbn6PNzDc4yFUsWe2jYx7mkVw5Gif62QY4XXEj5RSnytndJF7VtBO/6Z7IG3TsZlA
 xxSopwDNBYmU3KoAhTVAX6dilTGEre3yWZJ+2O8dRQEIQuOZtfrsFPPRP2xqEFoIONCnt
 KGi4owVnPNz9koz1onCot7Ax1WaQktssa9Ed53kv3j34CGkvtwNnx7qWELI/i2Wr3n1Aj
 tLTrc7+HcIAgCr11EEnaM5JoKikv06kvwlcfYVc2QbD0C8PMn1Kczl+gkXd19rhW4Eg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YgjQs0eJ; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YgjQs0eJ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E501E408AB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:05:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D056C6053E;
 Fri,  9 Oct 2026 13:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721031F000FF;
 Fri,  9 Oct 2026 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791551131;
 bh=nticlbH/kEitXMO0Q3PrRgzefpvclEfLz/YGXTWSlQA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YgjQs0eJDsZ5pg1g7fct1jAMzVpSdZ8hNizpGG47oG3UwzIMlgpbavfi0aGM7pU48
 0AkSNc2Fc6TNCeMy1p/tGR+gEAJoxs76E3aVYjdAKQ4qWMXlbR93MDdI3GwPhFqJrR
 L1Jw1ablZsp8XhG2i5EZn0lhBYr+iDPxMIttvhcPwaL3Bq1Veh99mqf4CuOpwHjUKC
 Tv2JkEQo2i/hg9IItn5hJ3z8eyhqr2s900a/EOKTY8On9FXcNZ17U7mR8OFbY2Umvd
 k2YIlXpTBxiCBLUtI6pHNbrHOyWnfJCO0EHaAJ5xRds6P35GNtjBDteMgpih2sywOa
 7d91IMyoWNkBg==
Message-ID: <sashiko-outbox-165586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v3 1/3] ice: attach and detach VF representors
 outside of vf->cfg_lock
To: "Linkui Xiao" <xiaolinkui@126.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261008125754.3520773-2-xiaolinkui@126.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-2-xiaolinkui@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:05:31 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ice: UAF in NAPI Rx path due to missing RCU grace period after xa_=
erase
- [Medium] net/ice: silent failure to apply VF MAC/VLAN to hardware due to =
TOCTOU race
--

commit 32649319eb3be01d6b10e730f49f29871e5cb572
Author: Linkui Xiao <xiaolinkui@kylinos.cn>

ice: attach and detach VF representors outside of vf->cfg_lock

This patch moves the detach and attach of VF representors outside of
the vf->cfg_lock to resolve a lock inversion between cfg_lock, the
devlink instance lock, and RTNL.

> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/et=
hernet/intel/ice/ice_vf_lib.c
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -789,9 +789,21 @@ void ice_reset_all_vfs(struct ice_pf *pf)
> =20
>  	/* free VF resources to begin resetting the VSI state */
>  	ice_for_each_vf(pf, bkt, vf) {
> +		/* Detach the representor before cfg_lock and attach it after
> +		 * releasing it again: both take the devlink instance lock and
> +		 * then RTNL, while __ice_set_vf_mac(), ice_set_vf_port_vlan()
> +		 * and the representor ethtool reset take cfg_lock under RTNL.
> +		 * Take cfg_lock once ahead of the detach to wait out a reset
> +		 * that is already inside the lock; ICE_VF_DIS, raised above,
> +		 * keeps later ones out.
> +		 */
>  		mutex_lock(&vf->cfg_lock);
> +		mutex_unlock(&vf->cfg_lock);
> =20
>  		ice_eswitch_detach_vf(pf, vf);

[Severity: High]
Does this code leave a window for a use-after-free in the NAPI Rx path?

During teardown, ice_eswitch_detach() calls unregister_netdev() which
waits for existing RCU readers. However, the representor pointer remains
in the eswitch.reprs XArray during and after unregister_netdev().

Because the pointer is still in the XArray, a concurrent NAPI Rx thread
calling ice_eswitch_get_target() can successfully fetch it via xa_load()
even after unregister_netdev() completes.

The teardown path then removes the pointer via xa_erase() and immediately
calls ice_repr_destroy(), executing free_netdev() and kfree() with no
additional RCU grace period. If a NAPI thread fetched the pointer just
before xa_erase(), it will dereference freed memory.

> +
> +		mutex_lock(&vf->cfg_lock);
> +
>  		vf->driver_caps =3D 0;
>  		ice_vc_set_default_allowlist(vf);
> =20
>  		ice_vf_fdir_exit(vf);
>  		ice_vf_fdir_init(vf);
>  		/* clean VF control VSI when resetting VFs since it should be
>  		 * setup only when VF creates its first FDIR rule.
>  		 */
>  		if (vf->ctrl_vsi_idx !=3D ICE_NO_VSI)
>  			ice_vf_ctrl_vsi_release(vf);
> =20
>  		ice_vf_pre_vsi_rebuild(vf);
>  		if (ice_vf_rebuild_vsi(vf)) {
>  			dev_err(dev, "VF %u VSI rebuild failed, leaving VF disabled\n",
>  				vf->vf_id);
>  			mutex_unlock(&vf->cfg_lock);
>  			continue;
>  		}
>  		ice_vf_post_vsi_rebuild(vf);
> =20
> +		mutex_unlock(&vf->cfg_lock);

[Severity: Medium]
Does this sequence leave a window where a concurrent VF MAC or VLAN update
can silently fail to apply to the hardware?

If a user configures the VF MAC, __ice_set_vf_mac() calls
ice_check_vf_ready_for_cfg() before acquiring vf->cfg_lock.

If a PF reset occurs simultaneously, ice_reset_all_vfs() sets ICE_VF_DIS
globally. If this happens right after __ice_set_vf_mac() passes its check,
__ice_set_vf_mac() will wait to acquire vf->cfg_lock.

As seen in the lines above, ice_reset_all_vfs() acquires vf->cfg_lock and
rebuilds the VF VSI using the old MAC address. After ice_reset_all_vfs()
releases the lock, __ice_set_vf_mac() acquires it, updates the software
MAC, and calls ice_reset_vf().

Because ICE_VF_DIS is still set by the PF reset, ice_reset_vf() aborts
the hardware reprogram. __ice_set_vf_mac() then returns success based on
its earlier check, leaving the hardware enforcing the old MAC while
software tools report the new one.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008125754.3520=
773-1-xiaolinkui@126.com?part=3D1
