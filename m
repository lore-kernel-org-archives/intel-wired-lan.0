Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38743606A319
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9sHlqLKb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCeuiimh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BFBD607F6;
	Tue, 20 Oct 2026 06:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bCNNIJibwrs6; Tue, 20 Oct 2026 06:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27DA96068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792479574;
	b=ZYTWdHImypx6XWgZp5gugfrH52jsO2XMoqElGTVQQ5IO4MJhSP1ln8RqI/cxJrcueeAv
	 NX16U5fVcerSguvn8u/ge1kfi12BUVwdD+FtmYdytr65mo2wApgZwjAS6HJOCmK5L1Chg
	 w6PG9IrQgOpsxSPJHXW4bEc+iiixT1sYO9BYZlp2Les7/3VKnXISRTIYIvOA6bSKOky4f
	 9OTY0kazVqOMNxBZnDZwO8yHCr2p7Hn9bNSZ7r7iKm+15TEtpKRxhZR0HzAZqepba1Jun
	 itkdfO1elJxS5+E1bd0dTmcDuUh1WOSJHHWDLGnw+wIDsRjdjjLTMvyb8OyWtHowdpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792479574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=HjNQOKTa7/o0E+d+gj3w7S25jbHSnzDajJrBidz02oc=;
	b=fI3mLqM9XRHk846KI3nIKZaAxZsjCtgPbJhE8pe5K5WmNvzXRTVpz29jnq1llXI1cvEG
	 HifN53NOckk5ukvYRLwoxwAwP7Bt3O03h4GmmEuTDZPnMt51rd+8TZMBpI5UPLvVg6cja
	 xm3hShKvR577a/a1sWFQ8m8JOQ0YXNKcCZUW/uwcIgWqmLjYsy/gmdGkBskKtRGKgOOc0
	 fxvxbnsFNUaYPQnXkGuHpVeFEouyY6zUiR2jYapeAjljP9JGRjYRyqauiYR1yP5uw44fy
	 bMjZKB65JLKP4R0k2fJne45kozsVE8nMaZ1IHJBRZoWDbfV2k2ltnfz+7GNvyxNIJAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792479574;
	bh=HjNQOKTa7/o0E+d+gj3w7S25jbHSnzDajJrBidz02oc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=9sHlqLKbhmIAfpFpx/cYUsrpuRiKAPUljJPLCTgjdFpEqQAM82fl1D0z3/3eMuE8W
	 Kr2JikjUVGEqum/soMTOprCsScA9nX4VfbSE+wnNdoz6MDhkpYnc/gMswOZWeJT908
	 KC7bGLB6JTb0pGv3lLCu5TVZ1QE1HnkMgmkN53cS9wsmyyxFWrKl6FzmrZwPG9BaCM
	 zlGbvns+n8StkNqA6eB9tSXfIQll28xIITxxFmubdEHSWSbOmlQKTX3YMlkVa/rK+z
	 CxeK6a+6lwATxjU0arFFaEwlUqmlHeqH2vjcRvhIF9XVNLiHHps5ryuf9mr62AVGvZ
	 tw12SgGBPHe2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27DA96068B;
	Tue, 20 Oct 2026 06:59:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CED9023A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B522C4064C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zf92dp3m4IGt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 06:59:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8384E405F4
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792479571;
 b=a99YsrKwQ0wk2KP106+u1GXj2DbWvsThxfjGf1xAI/Qb/Nr32ZHMiTo4RoStBNi8tYzn
 3O9UkoXsynBHmJmI92OFEyPsmtadQRZNTK8f1INkmB7SosdQNVgt+jcUlZ2Gzmp1mgQMC
 IHYHOc2WtJDxGGrpHlfZkPPY0NsI4hZYSH1aBTzKxC6HQkoEdCnZ7+XxemjSsrPPUCXif
 rS9UvP1rX1ct3BnZRoB5+gqyHDvDpYUIS4RFMDT/TtNM5gIiq4+Q0PCf217filrEg4hgg
 kWvRiLHANTrvqh3OZE2R+Qacwzb5RtMexNnVngnUPEpR8wCWoQzCTqJh4s7kN5lOIrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792479571;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=HjNQOKTa7/o0E+d+gj3w7S25jbHSnzDajJrBidz02oc=;
 b=KHMLhE9NtKtYrx6o5t+GWk4t14quXcQq5yRc1mnnOhq7y+xKbO/Eeppvde6heQ1yxRc6
 CwP3kft+GqXhZF7yaMs3R7r1gz4Kcw2v+yOYXb6QzIw5tetZRIVJXongAY5Sr45TGZvRl
 2U1lGa7BL9brM2jbXJfN4Y3/o1A77dBFiZ9R9Zl3CVcl4iTO6ddx3PKfDiHpg0zfVZo9I
 v4Hh0DU9BDwYSYzM1MBngjiR1A03WG+jp/IFHaAQ14KKEmiaOTAWTgQOjNC/DSZo8PKhr
 yH4a/tFYOikLkHh4805i1HAxRHgXlg8p75i0VFSNAEI1UgL6FCxWT0e9M8dbAXeOfMA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UCeuiimh; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UCeuiimh
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8384E405F4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:59:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE80C60D82;
 Tue, 20 Oct 2026 06:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B3B1F01808;
 Tue, 20 Oct 2026 06:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792479569;
 bh=HjNQOKTa7/o0E+d+gj3w7S25jbHSnzDajJrBidz02oc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UCeuiimh//lYl9rjZ9TpN8OyH5D1bJavQvpXlWOIZTDm9552Tp9hGl53gPJVcCLFE
 3Kxd/cxkDAhh+HcY8NBG7fNeR0FrYnD6wbtVzq78crNct7FMGtVl7/oiNLxcSYHfiC
 ebfKBNWudO5kyiMc7B66iqOqCwqFaqZbFcWJruCHs5fxygBS+yIoTWXJG54kM0XjA9
 QBcRCiqNTeYSX1OxUq+JOQd5ip6PCE1CjzNm3dCf2nAYVwB3+TXaV+wjQgza90UX95
 4MmWUiAysBBhlvbAVphXImLL60bhm+EjxG8pvuFJVa6++k6tjicn+EWmaX6l44ICdj
 UOBhZpmIzHz2w==
Message-ID: <sashiko-outbox-178446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
 ndo_setup_tc
To: "Petr Oros" <poros@redhat.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261019065301.3983537-4-poros@redhat.com>
References: <20261019065301.3983537-1-poros@redhat.com>
 <20261019065301.3983537-4-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 06:59:28 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] ice: TOCTOU race on cdev->adev in ice_setup_tc() causing NULL dere=
ference
- [High] ice: dropped AFTER_TC_CHANGE event and rate tree teardown in ice_p=
f_dcb_cfg()
- [High] ice: lock inversion between adev_mutex and tc_mutex in ice_setup_t=
c()
- [Medium] ice: ice_setup_tc() aborts non-failable mqprio offload teardown =
on trylock
--

commit bc1b4cca10360a37e77b845d47a02beb259d8055
Author: Petr Oros <poros@redhat.com>

ice: do not block on the aux device lock in ndo_setup_tc

This commit replaces device_lock() with device_trylock() on the RDMA
auxiliary device in the TC_SETUP_QDISC_MQPRIO path of ice_setup_tc(),
returning -EBUSY when the lock is contended to avoid deadlocking with
the RDMA auxiliary driver probe under the RTNL lock.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 595a2099c9564..4ed62f1498f1f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9556,7 +9556,11 @@ ice_setup_tc(struct net_device *netdev, enum tc_se=
tup_type type,
>  		cdev =3D pf->cdev_info;
>  		if (cdev && cdev->adev) {
>  			mutex_lock(&pf->adev_mutex);
> -			device_lock(&cdev->adev->dev);
> +			if (!device_trylock(&cdev->adev->dev)) {
> +				mutex_unlock(&pf->adev_mutex);
> +				netdev_dbg(netdev, "RDMA auxiliary device is busy, try again\n");
> +				return -EBUSY;
> +			}

[Severity: High]
Can cdev->adev become NULL before mutex_lock(&pf->adev_mutex) is
acquired, causing device_trylock(&cdev->adev->dev) to dereference a NULL
pointer?

In drivers/net/ethernet/intel/ice/ice_idc.c, ice_unplug_aux_dev() clears
pf->cdev_info->adev under pf->adev_mutex:

drivers/net/ethernet/intel/ice/ice_idc.c:ice_unplug_aux_dev() {
	...
	mutex_lock(&pf->adev_mutex);
	adev =3D pf->cdev_info->adev;
	pf->cdev_info->adev =3D NULL;
	mutex_unlock(&pf->adev_mutex);

	auxiliary_device_delete(adev);
	auxiliary_device_uninit(adev);
}

ice_unplug_aux_dev() and ice_plug_aux_dev() can run without rtnl_lock(),
for example from ice_service_task() in
drivers/net/ethernet/intel/ice/ice_main.c when ICE_FLAG_UNPLUG_AUX_DEV or
ICE_FLAG_PLUG_AUX_DEV is processed, from ice_prepare_for_reset(), or from
the devlink RoCE/iWARP parameter callbacks.

If ice_unplug_aux_dev() clears cdev->adev between the unlocked
if (cdev && cdev->adev) check and mutex_lock(&pf->adev_mutex) in
ice_setup_tc() (or in ice_set_channels() in
drivers/net/ethernet/intel/ice/ice_ethtool.c from the preceding patch in
this series), cdev->adev will be NULL when device_trylock(&cdev->adev->dev)
is called. Conversely, if ice_plug_aux_dev() assigns cdev->adev just after
the unlocked check, ice_setup_tc() skips pf->adev_mutex and reconfigures
queues concurrently with auxiliary device registration. Should
pf->adev_mutex be acquired before checking cdev->adev, matching
ice_send_event_to_aux()?

[Severity: Medium]
What happens if device_trylock(&cdev->adev->dev) fails when ice_setup_tc()
is called to tear down an existing MQPRIO offload (when
mqprio_qopt->qopt.hw =3D=3D 0)?

When an offloaded MQPRIO qdisc is deleted or replaced (on a PF where
cdev->adev is registered and no RDMA driver is bound),
mqprio_destroy() -> mqprio_disable_offload() in net/sched/sch_mqprio.c
invokes ndo_setup_tc() and ignores the return value:

net/sched/sch_mqprio.c:mqprio_disable_offload() {
	...
	case TC_MQPRIO_MODE_DCB:
	case TC_MQPRIO_MODE_CHANNEL:
		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
					      &mqprio);
		break;
}

If another thread transiently holds device_lock(&cdev->adev->dev) (such as
a sysfs attribute read or bus probe/rescan), returning -EBUSY here skips
ice_setup_tc_mqprio_qdisc():

drivers/net/ethernet/intel/ice/ice_main.c:ice_setup_tc_mqprio_qdisc() {
	...
	if (!hw) {
		clear_bit(ICE_FLAG_TC_MQPRIO, pf->flags);
		vsi->ch_rss_size =3D 0;
		memcpy(&vsi->mqprio_qopt, mqprio_qopt, sizeof(*mqprio_qopt));
		goto config_tcf;
	}
}

Because the qdisc destruction still completes in the core while
ice_setup_tc_mqprio_qdisc() is skipped, won't this leave
ICE_FLAG_TC_MQPRIO set, leak the ADQ channel VSIs on vsi->ch_list by
skipping ice_remove_q_channels(), and leave netdev TC state and queue
counts out of sync with no way for userspace to retry the teardown?

>  			locked =3D true;
>  			if (cdev->adev->dev.driver) {
>  				netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");

[Severity: High]
Does holding pf->adev_mutex and cdev->adev->dev.mutex across
mutex_lock(&pf->tc_mutex) in ice_setup_tc() invert the lock order against
the DCB paths?

In ice_setup_tc() in drivers/net/ethernet/intel/ice/ice_main.c, when
cdev->adev->dev.driver is NULL, the lock acquisition order is:

  rtnl_lock -> pf->adev_mutex -> cdev->adev->dev.mutex -> pf->tc_mutex

However, the DCB netlink handlers in
drivers/net/ethernet/intel/ice/ice_dcb_nl.c (such as ice_dcbnl_setets(),
ice_dcbnl_setpfc(), ice_dcbnl_setapp(), ice_dcbnl_delapp(), and
ice_dcbnl_cee_set_all()) acquire pf->tc_mutex before calling
ice_pf_dcb_cfg() -> ice_send_event_to_aux(), which acquires
pf->adev_mutex:

drivers/net/ethernet/intel/ice/ice_dcb_nl.c:ice_dcbnl_setets() {
	...
	mutex_lock(&pf->tc_mutex);
	...
	err =3D ice_pf_dcb_cfg(pf, new_cfg, true);
	...
}

And in drivers/net/ethernet/intel/ice/ice_dcb_lib.c,
ice_dcb_process_lldp_set_mib_change() and ice_dcb_rebuild() run from
ice_service_task() without rtnl_lock() and acquire pf->tc_mutex before
both rtnl_lock() and pf->adev_mutex:

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:ice_dcb_process_lldp_set_mib_c=
hange() {
	...
	mutex_lock(&pf->tc_mutex);
	...
	rtnl_lock();
	...
	ice_pf_dcb_recfg(pf, false);
		-> ice_send_event_to_aux()
			-> mutex_lock(&pf->adev_mutex);
}

Could this trigger a lockdep circular locking dependency warning or an
ABBA deadlock if ice_dcb_process_lldp_set_mib_change() or
ice_dcb_rebuild() holds pf->tc_mutex while waiting for rtnl_lock() or
pf->adev_mutex, at the same time ice_setup_tc() holds rtnl_lock() and
pf->adev_mutex while waiting for pf->tc_mutex?

[Severity: High]
Also related to the series change in ice_send_event_to_aux() in
drivers/net/ethernet/intel/ice/ice_idc.c: when ice_send_event_to_aux() uses
device_trylock(&cdev->adev->dev), can DCB reconfiguration leave the
devlink rate tree torn down or leave RDMA QPs permanently suspended?

First, in ice_pf_dcb_cfg() in
drivers/net/ethernet/intel/ice/ice_dcb_lib.c,
ice_tear_down_devlink_rate_tree(pf) is called before sending
IIDC_RDMA_EVENT_BEFORE_TC_CHANGE:

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:ice_pf_dcb_cfg() {
	...
	if (ice_dcb_get_num_tc(new_cfg) > 1) {
		...
		ice_tear_down_devlink_rate_tree(pf);

		set_bit(ICE_FLAG_DCB_ENA, pf->flags);
	}
	...
	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
	if (!ice_send_event_to_aux(pf, event)) {
		assign_bit(ICE_FLAG_DCB_ENA, pf->flags, dcb_ena);
		kfree(event);
		ret =3D -EBUSY;
		goto free_cfg;
	}
}

If ice_send_event_to_aux() fails its trylock and returns false,
ICE_FLAG_DCB_ENA is restored, but the devlink rate tree has already been
torn down.

Second, when IIDC_RDMA_EVENT_BEFORE_TC_CHANGE is delivered,
icrdma_iidc_event_handler() -> icrdma_prep_tc_change() in
drivers/infiniband/hw/irdma/icrdma_if.c sets
iwdev->vsi.tc_change_pending =3D true and suspends RDMA QPs, and
ice_send_event_to_aux() immediately releases cdev->adev->dev.mutex. Later,
ice_pf_dcb_recfg() sends IIDC_RDMA_EVENT_AFTER_TC_CHANGE via a separate
ice_send_event_to_aux() call and ignores the return value:

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:ice_pf_dcb_recfg() {
	...
	set_bit(IIDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
	ice_send_event_to_aux(pf, event);
	kfree(event);
}

If &cdev->adev->dev is contended when IIDC_RDMA_EVENT_AFTER_TC_CHANGE is
sent, ice_send_event_to_aux() drops the event, so the RDMA driver never
receives AFTER_TC_CHANGE to clear tc_change_pending and resume its QPs.

[ ... ]

>
> --=20
> 2.51.2
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065301.3983=
537-1-poros@redhat.com?part=3D3
