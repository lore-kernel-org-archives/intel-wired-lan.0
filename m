Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421E60A262B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HK381jER
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CE52605C9;
	Tue, 20 Oct 2026 06:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DCvtjCWkB_MC; Tue, 20 Oct 2026 06:59:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 582936068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792479557;
	b=FPJset2/nqxd9HLSq8KpTpm1mS/g7S3XWouthKVPUQv3LdkVp8Nb+GCeNjckxBcxI5SY
	 oyvSggk6fvhUiRTA3H9OfFgUvs8rFuXp5wi7CP26SYhalGGizmLUC/zp5cBCAaUUHJUgy
	 aV8eiBIN6XPUq3e31+ZhPDQ7XF2AUdNkml3UBvWxrQsVlN910CtMoLr2Dhm8J9u46uyJY
	 TGDkLUeZf/eB7Ts5LSkTvSMLfe7zNLvF7OLCN/SSyaBAY8RteZbMKtEnCK0L2DnXbZq8L
	 iEOfVPdvTkbTPx0b9v7o/T2libU2n2ojwmh95MrMVBY2/yqLl+tb5X7eFLZ5ALVxqWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792479557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Message-ID:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=QuEsDR7RHYH3nA6kHKamgCn2oIruoqZ330sAtiBO7VY=;
	b=bRunqF45QimzL28MA2ImMm1rYWEnHlsDsl9Ws2DDKoAVg9pL8KUT0mfbDgP+B1KRDD5B
	 Bu+DMMpnNyOMO/DmIcWZ4LPFvxCtzFBgHlHaolAyFB/nwcE5ntaoLTbuVekR/YUOX5vby
	 LAE1n0g7ZZFccjtcRYlvnmHqKXmkQDItE7T3hPAA4H9WDI3cvoLSh1BnIsbCs/rvSihZZ
	 sZ1rHCylQz0V+ghHQXVT40BFHE3LtnjKIXdRgMlZB5hixVHOoSLNHDEb8t3QoheIbbX7T
	 VtZKMrwFTF4fJX4PF1oTMxh7MKRLsXTCrfIQbazLpMNMOJz3FtIQR5Mt7cKfL+UiALQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792479557;
	bh=QuEsDR7RHYH3nA6kHKamgCn2oIruoqZ330sAtiBO7VY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=HK381jERMlegw//3xU+czZ1p67M79cqYfqVrUi2p4jzAtgB/aInpAKxB64tNUM5qs
	 uGDIgdtA6rJhgTnXckqOWnh8JsL8FBLr74R+h7Fxs5JaehGK6kLHTdD9JeGF4Q4ODX
	 dGkYJS1T0uzTCkHilDBOMGVW1aCp3mlDkNr14TL7ArszQekaiNEjvzTBGU9gDL8sV9
	 +ta9TOOnkxqs/oUvehaycem1zHs8bMligsq8tvRmldNh0/2msAcZhB1eFPBYMiuVAx
	 hew3Arrl9b7iTau4Zk9eFRQQAecNu9hVd7rptFO+QqFWMi4fsndO4aJHgpoCr8O623
	 MBcGa/Z9CFn4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 582936068B;
	Tue, 20 Oct 2026 06:59:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD62823A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3B7B8101A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWMhApKdHxdO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 06:59:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 933E280DF9
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792479554;
 b=RgYvhFjUWDywuw1NlsRAX3tP4qhAEQ4Q5U57RRnY54nQC4pNoEqpbg0gaeV69R452PpW
 4SLCUdpkI/xWJeGFHepTZyL/FVs2lNWlRwuWNK8LC48h8lKCEzR5nUcPeGfqlH2NKUFQi
 LoHzrPecB4UyUCxJR36Du+0AJNAQgqtI28ML/38qITZPKMdoAkMHFFYgYJW0Ncyp/HuhO
 fawRGRsrFDsDBIclzwDAJE/WnKbKlc+xGLtJJlvFp+rBjhmHg/piNMGqMzmRqVHOP+luS
 1tWLtxYOQfBbsExLnJGBRvVKFsPfUDEc4GnYPCWQ5LoKug4YNSOCE5x1rzx5zBVFctg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792479554;
 h=Received-SPF:Received:Received:Message-ID:From:Subject:Reply-To:To:
 Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date; bh=QuEsDR7RHYH3nA6kHKamgCn2oIruoqZ330sAtiBO7VY=;
 b=aY5IJbbzChjTzLsbm8y+rMiHZ+VU7XRNVKbz4NxT82J4oOMqhXZOpwVlAOuwzDy3YDQs
 SWxCN6Sciby2rGuinvaYsV2XuijQXxme5vJrlC650HJhFwgIki7khyWMwIoHhYvZxbuad
 pKCwA7suG6V6n0Hay4ZMnP7D4T1JSVLgJu+GRK/gd1mRb7Oi7Ql/TwPcsXnJVKpmWsVkQ
 +5WwXMbUiR0NUSCkDOfD2RbKYKHOFdWOxOl9tL5THyTKwZ0pn5Tl07ieNIRV/51KLfVHv
 6GfK69N2y2/5o8tlZOYcL4e6rE9+TL80S4LRN7CVmGLXpR16968KtL3/sautj3hyZIQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 933E280DF9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:59:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9155408FF;
 Tue, 20 Oct 2026 06:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B81F000C4;
 Tue, 20 Oct 2026 06:59:13 +0000 (UTC)
Message-ID: <sashiko-outbox-178444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 1/3] ice: avoid RTNL deadlock when notifying the
 RDMA auxiliary driver
To: "Petr Oros" <poros@redhat.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261019065301.3983537-2-poros@redhat.com>
References: <20261019065301.3983537-1-poros@redhat.com>
 <20261019065301.3983537-2-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 06:58:42 +0000
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] ice: dropping AFTER_TC_CHANGE in ice_send_event_to_aux() wedges RD=
MA QPs
- [High] ice: incomplete rollback on -EBUSY in ice_pf_dcb_cfg() and callers
- [Medium] ice: unsynchronized oicr_err_reg RMW in ice_service_task() races=
 with IRQ
--

commit a8b3bc9a99973600d50df0cc57d6ed5765f24c84
Author: Petr Oros <poros@redhat.com>

ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver

This commit switches ice_send_event_to_aux() from device_lock() to
device_trylock() to avoid an ABBA deadlock between the auxiliary device
lock and rtnl_lock during RDMA auxiliary device probing. When the lock is
contended, ice_pf_dcb_cfg() aborts with -EBUSY before changing traffic
classes, and ice_service_task() re-arms pending error and MTU change bits.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/e=
thernet/intel/ice/ice_dcb_lib.c
> index 0bc6dd3756879..2022b46c990cb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> @@ -355,8 +355,10 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcb=
x_cfg *new_cfg, bool locked)
>  	struct iidc_rdma_event *event;
>  	int ret =3D ICE_DCB_NO_HW_CHG;
>  	struct ice_vsi *pf_vsi;
> +	bool dcb_ena;
> =20
>  	curr_cfg =3D &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
> +	dcb_ena =3D test_bit(ICE_FLAG_DCB_ENA, pf->flags);
> =20
>  	/* FW does not care if change happened */
>  	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
> @@ -406,7 +408,12 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcb=
x_cfg *new_cfg, bool locked)
>  	}
> =20
>  	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
> -	ice_send_event_to_aux(pf, event);
> +	if (!ice_send_event_to_aux(pf, event)) {
> +		assign_bit(ICE_FLAG_DCB_ENA, pf->flags, dcb_ena);
> +		kfree(event);
> +		ret =3D -EBUSY;
> +		goto free_cfg;
> +	}

[Severity: High]
When ice_send_event_to_aux() returns false here, does aborting with -EBUSY
leave earlier state changes in ice_pf_dcb_cfg() and its callers
unreverted?

Earlier in ice_pf_dcb_cfg(), when ice_dcb_get_num_tc(new_cfg) > 1, the
devlink rate tree is torn down before reaching ice_send_event_to_aux():

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:ice_pf_dcb_cfg()
	if (ice_dcb_get_num_tc(new_cfg) > 1) {
		...
		ice_tear_down_devlink_rate_tree(pf);

		set_bit(ICE_FLAG_DCB_ENA, pf->flags);
	}

Taking the goto free_cfg path restores ICE_FLAG_DCB_ENA, but leaves the VF
devlink rate tree destroyed.

In addition, several callers mutate DCB state before calling
ice_pf_dcb_cfg() and do not roll it back or propagate -EBUSY:

1. In drivers/net/ethernet/intel/ice/ice_dcb_nl.c, ice_dcbnl_setapp()
registers the app via dcb_ieee_setapp(), sets new_cfg->dscp_mapped,
calls ice_aq_set_pfc_mode() to switch hardware to DSCP-based PFC, and
appends to new_cfg->app[], then overwrites the -EBUSY return with
ICE_DCB_NO_HW_CHG:

	ret =3D ice_pf_dcb_cfg(pf, new_cfg, true);
	/* return of zero indicates new cfg applied */
	if (ret =3D=3D ICE_DCB_HW_CHG_RST)
		ice_dcbnl_devreset(netdev);
	else
		ret =3D ICE_DCB_NO_HW_CHG;

A subsequent retry of ice_dcbnl_setapp() for the same DSCP value will then
fail with -EINVAL because test_and_set_bit(app->protocol,
new_cfg->dscp_mapped) sees the bit already set. ice_dcbnl_cee_set_all()
similarly masks -EBUSY with ICE_DCB_NO_HW_CHG.

2. In drivers/net/ethernet/intel/ice/ice_dcb_lib.c, both
ice_dcb_sw_dflt_cfg() and ice_dcb_init_cfg() zero
pi->qos_cfg.local_dcbx_cfg with memset() before calling ice_pf_dcb_cfg().
If ice_pf_dcb_cfg() aborts at goto free_cfg before memcpy(curr_cfg,
new_cfg, ...), local_dcbx_cfg remains zeroed out while the hardware
retains the previous configuration.

3. In drivers/net/ethernet/intel/ice/ice_dcb_nl.c, ice_dcbnl_setets(),
ice_dcbnl_setpfc(), and ice_dcbnl_delapp() modify
pf->hw.port_info->qos_cfg.desired_dcbx_cfg in-place before calling
ice_pf_dcb_cfg() without restoring it on failure.

>  	kfree(event);
> =20
>  	/* avoid race conditions by holding the lock while disabling and
> diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ether=
net/intel/ice/ice_idc.c
> index 102d63c3018b1..7fd35ce966ea6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_idc.c
> +++ b/drivers/net/ethernet/intel/ice/ice_idc.c
> @@ -34,30 +34,42 @@ ice_get_auxiliary_drv(struct iidc_rdma_core_dev_info =
*cdev)
>   * ice_send_event_to_aux - send event to RDMA AUX driver
>   * @pf: pointer to PF struct
>   * @event: event struct
> + *
> + * Return: false when the auxiliary device lock was contended.
>   */
> -void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *ev=
ent)
> +bool ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *ev=
ent)
>  {
>  	struct iidc_rdma_core_auxiliary_drv *iadrv;
>  	struct iidc_rdma_core_dev_info *cdev;
> +	bool sent =3D true;
> =20
>  	if (WARN_ON_ONCE(!in_task()))
> -		return;
> +		return true;
> =20
>  	cdev =3D pf->cdev_info;
>  	if (!cdev)
> -		return;
> +		return true;
> =20
>  	mutex_lock(&pf->adev_mutex);
>  	if (!cdev->adev)
>  		goto finish;
> =20
> -	device_lock(&cdev->adev->dev);
> +	if (!device_trylock(&cdev->adev->dev)) {
> +		dev_dbg(ice_pf_to_dev(pf),
> +			"auxiliary device busy, dropped RDMA event 0x%lx\n",
> +			*event->type);
> +		sent =3D false;
> +		goto finish;
> +	}

[Severity: High]
Can dropping IIDC_RDMA_EVENT_AFTER_TC_CHANGE here leave RDMA QPs
permanently suspended or initialized with stale QoS parameters?

In ice_pf_dcb_cfg(), IIDC_RDMA_EVENT_BEFORE_TC_CHANGE is delivered first,
and ice_send_event_to_aux() immediately releases device_unlock(&cdev->adev-=
>dev).
In the RDMA auxiliary driver, icrdma_iidc_event_handler() handles
BEFORE_TC_CHANGE by calling icrdma_prep_tc_change(), which sets
iwdev->vsi.tc_change_pending =3D true, suspends all QPs via
irdma_sc_suspend_resume_qps(&iwdev->vsi, IRDMA_OP_SUSPEND), and resets the
work scheduler tree via irdma_ws_reset(&iwdev->vsi).

After reconfiguring the VSI and hardware, ice_pf_dcb_cfg() calls
ice_pf_dcb_recfg(), which sends IIDC_RDMA_EVENT_AFTER_TC_CHANGE and
ignores the return value:

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:ice_pf_dcb_recfg()
		set_bit(IIDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
		ice_send_event_to_aux(pf, event);
		kfree(event);

If cdev->adev->dev is contended when AFTER_TC_CHANGE is sent (for example,
by a concurrent sysfs or driver-core operation taking device_lock() on
cdev->adev->dev), ice_send_event_to_aux() drops the event. Because only
the AFTER_TC_CHANGE path in icrdma_iidc_event_handler() ->
irdma_change_l2params() clears vsi->tc_change_pending =3D false and calls
irdma_sc_suspend_resume_qps(vsi, IRDMA_OP_RESUME):

drivers/infiniband/hw/irdma/icrdma_if.c:icrdma_iidc_event_handler()
	} else if (*event->type & BIT(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE)) {
		if (iwdev->vsi.tc_change_pending)
			return;

		icrdma_prep_tc_change(iwdev);
	} else if (*event->type & BIT(IIDC_RDMA_EVENT_AFTER_TC_CHANGE)) {
		...
		if (!iwdev->vsi.tc_change_pending)
			return;
		...
		irdma_change_l2params(&iwdev->vsi, &l2params);

dropping AFTER_TC_CHANGE leaves iwdev->vsi.tc_change_pending stuck true,
all existing QPs suspended, new QP work-scheduler additions rejected with
-EBUSY in irdma_ws_add(), and later BEFORE_TC_CHANGE events returning
early because tc_change_pending is already set.

Similarly, if icrdma_probe() starts right after BEFORE_TC_CHANGE ran (when
adev->dev.driver was still NULL) or concurrently with
ice_dcb_process_lldp_set_mib_change() -> ice_pf_dcb_recfg(), icrdma_probe()
can read idc_priv->qos_info before ice_setup_dcb_qos_info() updates it,
block on rtnl_lock() in irdma_ib_register_device() while holding
device_lock(&adev->dev), cause ice_pf_dcb_recfg() to drop AFTER_TC_CHANGE,
and finish probing with stale TC/QoS parameters.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index c26cef0214552..595a2099c9564 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -2385,11 +2385,16 @@ static void ice_service_task(struct work_struct *=
work)
>  		struct iidc_rdma_event *event;
> =20
>  		event =3D kzalloc_obj(*event);
> -		if (event) {
> +		if (!event) {
> +			set_bit(ICE_AUX_ERR_PENDING, pf->state);
> +		} else {
>  			set_bit(IIDC_RDMA_EVENT_CRIT_ERR, event->type);
>  			/* report the entire OICR value to AUX driver */
>  			swap(event->reg, pf->oicr_err_reg);
> -			ice_send_event_to_aux(pf, event);
> +			if (!ice_send_event_to_aux(pf, event)) {
> +				pf->oicr_err_reg |=3D event->reg;
> +				set_bit(ICE_AUX_ERR_PENDING, pf->state);
> +			}

[Severity: Medium]
Can the read-modify-write on pf->oicr_err_reg here race with
ice_misc_intr() and lose newly reported OICR error bits?

pf->oicr_err_reg is a plain u32 updated by the hardirq handler
ice_misc_intr():

drivers/net/ethernet/intel/ice/ice_main.c:ice_misc_intr()
	if (oicr & ICE_AUX_CRIT_ERR) {
		pf->oicr_err_reg |=3D oicr;
		set_bit(ICE_AUX_ERR_PENDING, pf->state);
		ena_mask &=3D ~ICE_AUX_CRIT_ERR;
	}

In ice_service_task(), pf->oicr_err_reg |=3D event->reg runs in process
context with interrupts enabled. If ice_misc_intr() fires between the load
and store of pf->oicr_err_reg, the store from ice_service_task() will
overwrite the bits just recorded by the interrupt handler.

>  			kfree(event);
>  		}
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065301.3983=
537-1-poros@redhat.com?part=3D1
