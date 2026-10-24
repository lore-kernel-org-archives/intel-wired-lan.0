Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE89D606A322
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=g2XYNmyz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYPBnpI7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A92E64082D;
	Sat, 24 Oct 2026 07:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gn4LDuP4jK9i; Sat, 24 Oct 2026 07:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9754140844
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825441;
	b=WcF6dmqzakq/IZAAGSz1IsPNTbgxp62N6cFFNnziLVwJWfbJU/ef237hfFC8jOlCR/+6
	 wr8LVtaFKd4ApTlJ2NFz3j3PKGprQjt79UnDSZmWM3aorb8ITw4i+T1apiAZ3OiqKYe6a
	 e+T7MTdHFOs86YWjPz/Qwz+aut8Fh9gQxlEjFnxhmS+rTyYssbdVE4aSNRq2e3NbyXORJ
	 nKo8DxRhXySr74YJFpazgmWd94VNLGdbNl89h1l4CRikCXVJDvwXa5e6ACjx0W0Qs2rxw
	 ufFBLFVoN0oO2cYWlGx4JU0heVNCU1VH7fPXzRZVmx0sJtp4d2c9tLAfFUuRLpNqP9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792825441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=yrjT2zKROfzZYFkQjkjZVkcJKooPMH1EarRQ32hBJzc=;
	b=TDZa+dp1qkWKzmFMpYfG0hbwkeeZAHSY+wQEy5w7fdkahL0PvGufXktq79ajatMovIUZ
	 Vgza/ZpAzPmW67hzkj9MsE5SZZQMMbi2lHeiPwAk7fXAmo+M32Sy7nZ8OJJl6pw2g3MVK
	 KyzZ6NAgfP2g9xzepQWbT8/vI0baDKED5Ebh9kEqZfUYaFlPj29CYvLCTNT4WotHmeoQx
	 FW1FCPYH3E8NxXvr/1EpEe3sge78Ie2KZ0DbWwt6PyCpoTv/HctHBNX+tgKOIUWVeZd9S
	 9/FDkUYerHwADoxRZFcMU/+7Ufk2De+vZTPBHtwZ4/GWc51JACvLpyyT/cOSSeOzuUQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792825441;
	bh=yrjT2zKROfzZYFkQjkjZVkcJKooPMH1EarRQ32hBJzc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=g2XYNmyz95vzFRsUsY18DHsolxnLwFPiFQNTmk+7T9Gg1i7zC2uiQ71qvlydv6E5y
	 j8N1u8XMoHeeRgr0HUCmhSMct4TWSlMNj3wcWSYNej8Bw80CoQGkLHnFtGF5pjDmwu
	 +afQ/KLguRvY/mq5JT9RCY/oOrmThpAwWekwzxWMcIkak9CrjjZG/Xb2PKxOu9zlae
	 TY+VVvu2gQ4lxI1sKWr4ACI7SUTIzrlE6J9Xev4BmnNkTxRyL5R9IB61rYyk7rp2eZ
	 OZgLiPC7bpqMJ2pZf3B8fKQnyalTec6fPD5Mant689IPd2R2esLf8KNtRdx48QZG9H
	 dvYiRWMsBr6mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9754140844;
	Sat, 24 Oct 2026 07:04:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7229765
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 07:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99279400E0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 07:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TNBrBoXHFTA9 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 07:03:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 255FF400AF
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792825438;
 b=o8DhJaBiNSqUilmbi+c5ELNIgydV8x+UCEt8ckV453/L57l31s9V1ti33SKRsMHJ2FQk
 VL3d5sW5DkaLWVqc75gDVeJ5fn/4YTvVSX0Obv4d+ZacQe3DjmKM/6hfOUwjyrQibrLk2
 ZMbfpvT6tCiMFB8eyMDZ6JhbyaqH9EAE5gknX4GLf1zwRzMmBEkQyJZtHIzP77wkMjQsf
 ctiu9wC++JB9dHg88OwYa93udojO+p7PeH9BKjAGkFBgAX+9MmacMOle5+MGTfhEYXwAt
 hcseEtCFzO7vWtV5lDk3D9CJtZzZFc9JafdAUhGiAT47nx0KOgc6FqMuCiZqo6rVpwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825438;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=yrjT2zKROfzZYFkQjkjZVkcJKooPMH1EarRQ32hBJzc=;
 b=P1hwrKT7Kf275yWc2XnEHOd4UgrUAtvJnA6NXNBZ5RFPlK/Plxd0QQ2CvX6QjbA2JCtF
 j5VNAAcyQQvnf1/5mMhavb6+lOVd7LqqQ0ZxzA3t+9LKiinoKymffzzJwtEJIq6OQgWKb
 yD7ia/TOTlFrWjBOgGKX6lcvJ3qCvDht3J6dUSnlW/u2bFuYk6DdOMff1HlMf2Cd/gt1d
 eHLm0E5fN2J8OfgBcRAaD1j6vHROm/ZhPT/t1iWpv20iBHlHxEz0OEl5atQKDlzQ6C4zG
 KcWdvUZeCEieVY0iQdfxeXXVrb5FpOFgozXAC2JapcGCMyRnFuGgKkOJYFnKocFz3UA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GYPBnpI7; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GYPBnpI7
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 255FF400AF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 07:03:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4967A60A6B;
 Sat, 24 Oct 2026 07:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A3E1F01825;
 Sat, 24 Oct 2026 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792825436;
 bh=yrjT2zKROfzZYFkQjkjZVkcJKooPMH1EarRQ32hBJzc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GYPBnpI7ySDWyq4vygWt6gr/6ttk+KjlZ4qG/+84OqhGIYvikRKmKTQawOR+zP2yd
 Ch9LIk90YrG2Z2sjdEETh/e5yqeJqQ4ZkiMWH5Vi6a7HeFDiwSK+i0Z/ag26KQT5/d
 0+fqfKJBKjjUI5wuXiUcHFRyN/0JZseMPXpOQbfwjmWuFRjiVlkEKxFieAGg9lqsSO
 GwpidlmJNE3ufrMQTjSzdkHA4UH2bM4T4ysE+dnt0GTbTMnO52Al+XnIYEPzj/NoKA
 5iYVA/v/bK8S26uZibiEK/hEp13rzbhy9ZPhoOCt7iAmx1Ok1AeuyuM4fyoRHVVm9O
 fWA0vcby+5NrA==
Message-ID: <sashiko-outbox-183579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v2 3/5] ice: avoid RTNL deadlock when notifying
 the RDMA auxiliary driver
To: "Petr Oros" <poros@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261023070258.730168-4-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
 <20261023070258.730168-4-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 07:03:55 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] ice: premature AFTER_TC_CHANGE and unlock before ice_dcb_noncontig=
_cfg()
- [High] ice: inconsistent QoS and DCB state on error path in ice_pf_dcb_cf=
g()
- [Medium] ice: unrolled state mutations when ice_pf_dcb_cfg() fails with -=
EBUSY
--

commit 0b49c36f284346b01578d0498826a110d7c3a315
Author: Petr Oros <poros@redhat.com>

ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver

This commit avoids an ABBA deadlock between rtnl_lock and the RDMA
auxiliary device lock by acquiring the auxiliary device lock with
device_trylock() via ice_aux_dev_trylock() around RDMA event delivery.
In ice_pf_dcb_cfg(), the locks are held across the DCB reconfiguration
from IIDC_RDMA_EVENT_BEFORE_TC_CHANGE through
IIDC_RDMA_EVENT_AFTER_TC_CHANGE, and the non-contiguous traffic class
fallback is deferred until after the locks are released.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/e=
thernet/intel/ice/ice_dcb_lib.c
> index 0bc6dd3756879..9916bd408071c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> @@ -5,6 +5,9 @@
>  #include "ice_dcb_nl.h"
>  #include "devlink/devlink.h"
> =20
> +static bool ice_dcb_tc_contig(u8 *prio_table);
> +static int ice_dcb_noncontig_cfg(struct ice_pf *pf);
> +
>  /**
>   * ice_dcb_get_ena_tc - return bitmap of enabled TCs
>   * @dcbcfg: DCB config to evaluate for enabled TCs
> @@ -352,11 +355,16 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dc=
bx_cfg *new_cfg, bool locked)
>  	struct ice_aqc_port_ets_elem buf =3D { 0 };
>  	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
>  	struct device *dev =3D ice_pf_to_dev(pf);
> +	struct iidc_rdma_priv_dev_info *privd;
> +	struct iidc_rdma_core_dev_info *cdev;
>  	struct iidc_rdma_event *event;
>  	int ret =3D ICE_DCB_NO_HW_CHG;
>  	struct ice_vsi *pf_vsi;
> +	bool noncontig =3D false;
> +	bool dcb_ena;
> =20
>  	curr_cfg =3D &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
> +	dcb_ena =3D test_bit(ICE_FLAG_DCB_ENA, pf->flags);

[ ... ]

> @@ -405,16 +413,21 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dc=
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
> +	if (!ice_aux_dev_trylock(pf)) {
> +		assign_bit(ICE_FLAG_DCB_ENA, pf->flags, dcb_ena);
> +		ret =3D -EBUSY;
> +		goto unlock_rtnl;
> +	}

[Severity: Medium]
When ice_aux_dev_trylock(pf) fails here and returns -EBUSY, what happens to
the state mutations that already took place earlier in ice_pf_dcb_cfg() and
its callers?

Earlier in ice_pf_dcb_cfg(), when ice_dcb_get_num_tc(new_cfg) > 1,
ice_tear_down_devlink_rate_tree(pf) has already run before
ice_aux_dev_trylock(pf):

    if (ice_dcb_get_num_tc(new_cfg) > 1) {
        if (pf->hw.port_info->is_custom_tx_enabled) {
            ...
            return -EBUSY;
        }
        ice_tear_down_devlink_rate_tree(pf);

        set_bit(ICE_FLAG_DCB_ENA, pf->flags);
    }

Unlike the is_custom_tx_enabled check, failing at ice_aux_dev_trylock(pf)
reverts ICE_FLAG_DCB_ENA while leaving the devlink rate tree torn down.

In addition, callers that configure 1 TC (where is_custom_tx_enabled could
never trigger), such as ice_dcb_sw_dflt_cfg() and ice_dcb_init_cfg(), zero
pi->qos_cfg.local_dcbx_cfg with memset() before calling ice_pf_dcb_cfg():

    memset(&pi->qos_cfg.local_dcbx_cfg, 0, sizeof(*dcbcfg));
    ...
    ret =3D ice_pf_dcb_cfg(pf, dcbcfg, locked);

If ice_aux_dev_trylock(pf) returns -EBUSY before curr_cfg is populated,
does local_dcbx_cfg remain completely zeroed out? Similarly, in
ice_dcbnl_setapp(), a negative return from ice_pf_dcb_cfg() is converted to
ICE_DCB_NO_HW_CHG without rolling back dcb_ieee_setapp(), dscp_mapped,
desired_dcbx_cfg, or ice_aq_set_pfc_mode().

> +
> +	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
> +	ice_send_event_to_aux(pf, event);
> +
>  	/* disable VSIs affected by DCB changes */
>  	ice_dcb_ena_dis_vsi(pf, false, true);
> =20
> @@ -441,13 +454,28 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dc=
bx_cfg *new_cfg, bool locked)
>  		goto out;
>  	}
> =20
> -	ice_pf_dcb_recfg(pf, false);
> +	ice_pf_dcb_recfg(pf, true);
> +	noncontig =3D !ice_dcb_tc_contig(curr_cfg->etscfg.prio_table);
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

[Severity: High]
Can jumping to out on error leave curr_cfg, ICE_FLAG_DCB_ENA, and
privd->qos_info inconsistent with the actual VSI configuration and cause
active RDMA queue pairs to transition to the error state?

In ice_pf_dcb_cfg(), if ice_set_dcb_cfg() succeeds (updating firmware and
PRTDCB_TUP2TC) but ice_query_port_ets() fails and jumps to out:

1. curr_cfg still contains new_cfg (unlike the ice_set_dcb_cfg() failure
   path, which restores old_cfg), and neither error path restores
   ICE_FLAG_DCB_ENA to dcb_ena.

2. Because ice_pf_dcb_recfg(pf, true) was skipped, vsi->tc_cfg.ena_tc still
   only has the old traffic classes enabled.

3. At out, ice_setup_dcb_qos_info(pf, &privd->qos_info) populates
   privd->qos_info from the new curr_cfg and PRTDCB_TUP2TC register, and
   ice_send_event_to_aux() delivers IIDC_RDMA_EVENT_AFTER_TC_CHANGE.

When irdma handles IIDC_RDMA_EVENT_AFTER_TC_CHANGE via
icrdma_iidc_event_handler() -> irdma_change_l2params() ->
irdma_sc_suspend_resume_qps(), it attempts to resume QPs on the new TCs in
qos_info->up2tc[] via irdma_ws_add() -> icrdma_lan_register_qset() ->
ice_add_rdma_qset(). Since vsi->tc_cfg.ena_tc was never updated for those
new TCs, ice_ena_vsi_rdma_qset() fails with -EINVAL, causing
irdma_sc_suspend_resume_qps() to call irdma_modify_qp_to_err() on the QPs.

> +	ice_aux_dev_unlock(pf);
> +
>  	/* enable previously downed VSIs */
>  	ice_dcb_ena_dis_vsi(pf, true, true);
> +	if (noncontig)
> +		ice_dcb_noncontig_cfg(pf);

[Severity: High]
When a DCB configuration has non-contiguous traffic classes in
curr_cfg->etscfg.prio_table, does deferring ice_dcb_noncontig_cfg(pf) until
after IIDC_RDMA_EVENT_AFTER_TC_CHANGE and ice_aux_dev_unlock(pf) break RDMA
QP resume?

Previously, ice_pf_dcb_cfg() called ice_pf_dcb_recfg(pf, false), which saw
!ice_dcb_tc_contig(dcbcfg->etscfg.prio_table) and immediately ran
ice_dcb_noncontig_cfg(pf) to reset local_dcbx_cfg and hardware PRTDCB_TUP2TC
back to the default TC0 configuration before populating privd->qos_info,
sending IIDC_RDMA_EVENT_AFTER_TC_CHANGE, or re-enabling the VSIs.

With this change:

1. ice_set_dcb_cfg() programs the non-contiguous prio_table into hardware
   PRTDCB_TUP2TC.

2. ice_pf_dcb_recfg(pf, true) configures the PF VSI with
   tc_map =3D ICE_DFLT_TRAFFIC_CLASS (only TC0 enabled in vsi->tc_cfg.ena_t=
c)
   and skips ice_dcb_noncontig_cfg(pf) because locked is true.

3. Before ice_dcb_noncontig_cfg(pf) runs, ice_setup_dcb_qos_info() reads
   PRTDCB_TUP2TC from hardware:

    dcbx_cfg =3D &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
    up2tc =3D rd32(&pf->hw, PRTDCB_TUP2TC);

    qos_info->num_tc =3D ice_dcb_get_num_tc(dcbx_cfg);

    for (i =3D 0; i < IIDC_MAX_USER_PRIORITY; i++)
        qos_info->up2tc[i] =3D (up2tc >> (i * 3)) & 0x7;

   This populates qos_info->up2tc[] with the un-reset non-contiguous TCs
   (> 0) while vsi->tc_cfg.ena_tc only has BIT(0) set.

4. ice_send_event_to_aux() then sends IIDC_RDMA_EVENT_AFTER_TC_CHANGE. When
   irdma resumes QPs via irdma_sc_suspend_resume_qps(), irdma_ws_add() ->
   ice_add_rdma_qset() -> ice_ena_vsi_rdma_qset() fails with -EINVAL for
   any TC > 0, and irdma_modify_qp_to_err() transitions the QPs to the
   error state.

5. Finally, ice_aux_dev_unlock(pf) drops the locks and
   ice_dcb_ena_dis_vsi(pf, true, true) re-enables the VSIs before
   ice_dcb_noncontig_cfg(pf) resets the configuration, and if the second
   ice_aux_dev_trylock(pf) inside ice_dcb_noncontig_cfg() ->
   ice_dcb_sw_dflt_cfg() -> ice_pf_dcb_cfg() fails with -EBUSY, the fallback
   aborts with local_dcbx_cfg zeroed out.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023070258.7301=
68-1-poros@redhat.com?part=3D3
