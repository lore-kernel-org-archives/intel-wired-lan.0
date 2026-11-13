Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42C606EBFD
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=x4N3GSre;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frzhCYKQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A3728128E;
	Fri, 13 Nov 2026 16:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wlRnBX1K58zm; Fri, 13 Nov 2026 16:46:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D86781378
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794588383;
	b=qNem3E02cc9piQ8LYbPFWo+hMqb3nls8KEF/IOgjYJww3SKY9x7OctMc3DL+OEQ/XYKR
	 HS4rnMklvBFhiF2Ve5NHk+WJfDj1msdR+jGId1hZ9PdmtgdU33Zn++eHK4oB/ZFilt8Eh
	 UWq6GR523PCaGQ+4zEqmSX5jzvLi+MgrlWtSherCz8CgsWYNYSPe5pgDtfxJ1Z9hf83+J
	 3guVa3cyiu47ljAoJWrT1DYcXTKsD/Xc96q0gZbP63d4Y+m49qrEMmRc7rfbCiI1m8z+B
	 eNAqpJn2TeygvPIL2LjuuWPC2KTIOxFcB3mbjASCJeFQuQ4pbOTNbmpcIFIB3O6vaTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=EiBKfYLc8qp/Ho/d43KCOlC95cu1bvcjVqbCs8bIE/g=;
	b=Po7Bl8D6dpmPkrdveX3jODXv2/A1qsVnBdEFcdjD8LCyHVW52fq7FvQkKMxT1IwA40MH
	 2l1WKInVpiAbQVKaD41O+3eIFPDxZpTqzJLhRvKssb/8GCoYDzizXWyNO+5k6ZDHR/F/N
	 wN2l36sPnTf+oKF7i7quuXsj+GH4wxgfUDRO1wDOt3AVbTMwLS1SIQlXJ9x4bWxD0LYbr
	 SsMNOOZrl+0/D2GEEi5vAlhjue7xgbJCM078RwAJ/AutPdE95dTsUPPXr5Cui+s8lm0y5
	 3bVnmwXVwri0JmauDoHEuaeuyaUT9RoOmlM5oQvXUy2/ZaLlCrLtkj7iLlkm0MrgNkg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794588383;
	bh=EiBKfYLc8qp/Ho/d43KCOlC95cu1bvcjVqbCs8bIE/g=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=x4N3GSreVkBz8dkzQRSHikgqLU8s2NyhWcTHoojXn+CNlic+w+zrtOayeBHEA+HTv
	 yKE5REsgUaSdkh6h0kVV6PP5jwfqqula/bFnFH+7hy2cYSUbfcNmKLSAhvTd3vRgx3
	 xb9DiyDoX74hP0ST2q1k2LzBhOXN586F8ybM1D95FFaHIIWYZjHTC0XtMjJz9gvxD0
	 x0xolBkRxNNwvGHjuCyl7FqXLgrGI3uQEyx15QlhKk1ujoQUEEKsHeYcZWGV4aawMT
	 Vaxabg9wUvuP3S6ILKm2WG+KqdhT6Mw/pcnwXaHnrfXzAv6DEAbDo89RPIuW2iuwHx
	 IqJvB5Khao2mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D86781378;
	Fri, 13 Nov 2026 16:46:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA640178F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBA756063F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AoJbOjKh9tVU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 16:46:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9CA960639
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=frzhCYKQ
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9CA960639
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:46:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A7A2843CC4;
 Fri, 13 Nov 2026 16:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4BA1F000C5;
 Fri, 13 Nov 2026 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794588379;
 bh=EiBKfYLc8qp/Ho/d43KCOlC95cu1bvcjVqbCs8bIE/g=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=frzhCYKQVysyN0K2Yo81e9akVgZN5b+pDT7A559I8C328LYGdbBbDvXJTu30EUJvi
 AkpoNAWejUcVlRiaKAnDtNxWjGJxRsPmsA61RudiX/8fwO8cV/qN4AilKoZgU5jEoc
 7vj2iq2WYx1QUDe/Gl2ZAQ6MSnRShoBocdGnPyHjTcL254lHK+3C9n/lD2eazp33t3
 idXL+VEF+J7qEGRbksimuDxNb1tMRwLZs1pYlr7xPXndGHAQAeHyBoQp2/JIdKVHIZ
 jl4jScOQAaDgFYTWlhyNlKWunC28RSlkExkQ7fh3lt56L2Kl/ki9jWaftptaiwS+Wf
 7yDuAMjGufj0g==
Message-ID: <sashiko-outbox-213224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v3 2/4] ice: avoid RTNL deadlock when notifying
 the RDMA auxiliary driver
To: "Petr Oros" <poros@redhat.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261113161453.1234851-3-poros@redhat.com>
References: <20261113161453.1234851-1-poros@redhat.com>
 <20261113161453.1234851-3-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:46:18 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] ice: inconsistent QoS state on error path in ice_pf_dcb_cfg()
- [Medium] ice: unrolled DCB state and zeroed local_dcbx_cfg when
  ice_pf_dcb_cfg() fails
- [Medium] ice: read of pf->cdev_info before adev_mutex in
  ice_aux_dev_trylock()
--

commit 5ebebfa9f362bf112076cd4d87281d6a453d0c5c
Author: Petr Oros <poros@redhat.com>

ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver

This commit replaces blocking device_lock() acquisitions when sending events
to the RDMA auxiliary driver with ice_aux_dev_trylock() to prevent an ABBA
deadlock between rtnl_lock and the auxiliary device lock.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/e=
thernet/intel/ice/ice_dcb_lib.c
> index 5355519726df9..dba74d940d25b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
[ ... ]
> @@ -422,16 +429,26 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dc=
bx_cfg *new_cfg, bool locked)
>  		goto free_cfg;
>  	}
> =20
> -	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
> -	ice_send_event_to_aux(pf, event);
> -	kfree(event);
> -
>  	/* avoid race conditions by holding the lock while disabling and
>  	 * re-enabling the VSI
>  	 */
>  	if (!locked)
>  		rtnl_lock();
> =20
> +	if (!ice_dcb_tc_contig(new_cfg->etscfg.prio_table)) {
> +		ret =3D ice_dcb_noncontig_cfg(pf);
> +		goto unlock_rtnl;
> +	}
> +
> +	if (!ice_aux_dev_trylock(pf)) {
> +		assign_bit(ICE_FLAG_DCB_ENA, pf->flags, dcb_ena);
> +		ret =3D -EBUSY;
> +		goto unlock_rtnl;
> +	}

[Severity: Medium]
Does this leave local_dcbx_cfg zeroed and ICE_FLAG_DCB_ENA cleared when
ice_aux_dev_trylock() fails with -EBUSY?

When new_cfg has non-contiguous traffic classes, ice_pf_dcb_cfg() clears
ICE_FLAG_DCB_ENA at the start of the function and calls
ice_dcb_noncontig_cfg() -> ice_dcb_sw_dflt_cfg(), which zeroes
pi->qos_cfg.local_dcbx_cfg via memset() before calling the nested
ice_pf_dcb_cfg():

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:ice_dcb_sw_dflt_cfg() {
	...
	memset(&pi->qos_cfg.local_dcbx_cfg, 0, sizeof(*dcbcfg));
	...
	ret =3D ice_pf_dcb_cfg(pf, dcbcfg, locked);
}

If the nested ice_pf_dcb_cfg() then hits contention in ice_aux_dev_trylock()
and returns -EBUSY, its dcb_ena is already false and local_dcbx_cfg is
already zeroed, and the outer ice_pf_dcb_cfg() jumps straight to unlock_rtnl
without restoring curr_cfg from old_cfg or ICE_FLAG_DCB_ENA from its saved
dcb_ena. Direct calls to ice_dcb_sw_dflt_cfg() and ice_dcb_init_cfg()
similarly zero local_dcbx_cfg before calling ice_pf_dcb_cfg() without
restoring it on -EBUSY.

In addition, for multi-TC configs, ice_pf_dcb_cfg() calls
ice_dcb_prep_multi_tc() (tearing down the devlink rate tree) before
ice_aux_dev_trylock(), and ice_dcbnl_setapp() updates the dcbnl app table,
new_cfg->dscp_mapped, new_cfg->app[], and hardware PFC mode before calling
ice_pf_dcb_cfg() without rolling them back on -EBUSY.

> @@ -458,13 +475,25 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dc=
bx_cfg *new_cfg, bool locked)
>  		goto out;
>  	}
> =20
> -	ice_pf_dcb_recfg(pf, false);
> +	ice_pf_dcb_recfg(pf, true);
> =20
>  out:
> +	cdev =3D pf->cdev_info;
> +	if (cdev) {
> +		privd =3D cdev->iidc_priv;
> +		ice_setup_dcb_qos_info(pf, &privd->qos_info);
> +	}
> +	clear_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
> +	set_bit(IIDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
> +	ice_send_event_to_aux(pf, event);
> +	ice_aux_dev_unlock(pf);

[Severity: High]
If ice_query_port_ets() fails and jumps to out, does populating
privd->qos_info and sending IIDC_RDMA_EVENT_AFTER_TC_CHANGE transition
active RDMA queue pairs to the error state?

When ice_query_port_ets() fails, curr_cfg and PRTDCB_TUP2TC already hold
new_cfg, but ice_pf_dcb_recfg() is skipped so vsi->tc_cfg.ena_tc and the VSI
scheduler nodes still only have the old traffic classes. Running
ice_setup_dcb_qos_info() at out populates privd->qos_info with the unapplied
traffic classes, so when irdma handles IIDC_RDMA_EVENT_AFTER_TC_CHANGE and
calls ice_add_rdma_qset() to resume its QPs on those TCs, ice_cfg_vsi_rdma()
and ice_ena_vsi_rdma_qset() fail with -EINVAL and irdma moves the QPs to
IB_QPS_ERR. The ice_query_port_ets() error path also leaves curr_cfg and
ICE_FLAG_DCB_ENA unrolled.

> diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ether=
net/intel/ice/ice_idc.c
> index 09dfcffeb5df9..9e8bff128e0e6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_idc.c
> +++ b/drivers/net/ethernet/intel/ice/ice_idc.c
> @@ -30,34 +30,62 @@ ice_get_auxiliary_drv(struct iidc_rdma_core_dev_info =
*cdev)
>  			    struct iidc_rdma_core_auxiliary_drv, adrv.driver);
>  }
> =20
> +/**
> + * ice_aux_dev_trylock - take the locks that guard the RDMA AUX driver
> + * @pf: pointer to PF struct
> + *
> + * Return: true when the locks are held, false when the auxiliary device=
 lock
> + * was contended and nothing is held.
> + */
> +bool ice_aux_dev_trylock(struct ice_pf *pf)
> +{
> +	struct iidc_rdma_core_dev_info *cdev =3D pf->cdev_info;
> +
> +	mutex_lock(&pf->adev_mutex);
> +	if (cdev && cdev->adev && !device_trylock(&cdev->adev->dev)) {
> +		mutex_unlock(&pf->adev_mutex);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * ice_aux_dev_unlock - release the locks taken by ice_aux_dev_trylock()
> + * @pf: pointer to PF struct
> + */
> +void ice_aux_dev_unlock(struct ice_pf *pf)
> +{
> +	struct iidc_rdma_core_dev_info *cdev =3D pf->cdev_info;
> +
> +	if (cdev && cdev->adev)
> +		device_unlock(&cdev->adev->dev);
> +	mutex_unlock(&pf->adev_mutex);
> +}

[Severity: Medium]
Can reading pf->cdev_info before acquiring pf->adev_mutex in
ice_aux_dev_trylock() cause an unbalanced device_unlock(&cdev->adev->dev) or
a use-after-free?

In ice_load(), the netdev and its dcbnl_ops are registered before
ice_init_rdma() allocates pf->cdev_info and ice_rdma_finalize_setup() ->
ice_plug_aux_dev() sets cdev->adev under pf->adev_mutex:

CPU0                                  CPU1
ice_dcbnl_setets()                    ice_load()
  ice_pf_dcb_cfg()                      ...
    ice_aux_dev_trylock()               ice_init_rdma()
      cdev =3D pf->cdev_info; /* NULL */    pf->cdev_info =3D kzalloc(...);
                                        ice_rdma_finalize_setup()
                                          ice_plug_aux_dev()
                                            mutex_lock(&pf->adev_mutex)
                                            cdev->adev =3D adev;
                                            mutex_unlock(&pf->adev_mutex)
      mutex_lock(&pf->adev_mutex)
      /* cdev is NULL, skips trylock */
    ice_send_event_to_aux()
    ice_aux_dev_unlock()
      cdev =3D pf->cdev_info;
      device_unlock(&cdev->adev->dev)  <-- unlocks unheld mutex

Conversely, if ice_aux_dev_trylock() samples a non-NULL pf->cdev_info while
racing with ice_unload() or ice_suspend() calling ice_deinit_rdma(),
dereferencing cdev->adev after mutex_lock(&pf->adev_mutex) reads freed
memory. Reading pf->cdev_info after mutex_lock(&pf->adev_mutex) (and
protecting pf->cdev_info teardown under pf->adev_mutex) would avoid both.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113161453.1234=
851-1-poros@redhat.com?part=3D2
