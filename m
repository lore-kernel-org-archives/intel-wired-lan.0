Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96C606A338
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Z3U/oVkc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OdgDGsGP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ABE460699;
	Thu, 19 Nov 2026 15:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kEThvgEIS6qN; Thu, 19 Nov 2026 15:54:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 42C2560AD2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103699;
	b=U4W3BRnV8B41Lgns89RNQXh4+SVoN+QuUAoiBdKzb4io9Xo9dS9eObdp1ccMdrjMKlSE
	 m2mCj8cyMb0OEttUryjV1JSD48Ywiqa3V8+P4JSUaowacIbUUTzl8TchBvfB0OF76UPGU
	 1t16pM5PBOjyo9dEq38E5kNxVS3iSx+bnju4iy4f/h21aKbna7QTltw8SWWlVC/4/p3iq
	 r6kISeUj+chTqkBIdyc3lyaCf0JIeDD3EL8NXnBjUK8DpKMDpwrfjKOOopg5/rnUg2cf3
	 LthV/zJoWrtp2EWQ/xFuAEMzw4SYRGQz8qiRl4Y/KFsCRQE3GZwfv+zEKx1cyhf9T3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CAt5s3aLIP+AN5sLMxCB1vGQToOFJdCC66NOcTwLvUg=;
	b=KNnCKSlUCsfhWpVkgo+DcBBRo1qltZkujdytAnv5pgSSW7LTL8unfz6Pl2MFvw8JBaea
	 apXZh61zVhjlGB6x8Ze9UO5TE8XPoDSSB/KrVAwnLUMbiNVS3BucRer3DA+XVHaObOgKk
	 L/Orx/EHCd63PCK0UidOqcwImUDN9lC48lx4giuWHGF6eFCzowRD7CJ7Xzt5sRM/ouDKv
	 kMlsyNRca2fAsVZSXlQLQiyBiUnNv+hlGPMbYMIrisgBbziE40eOdNKlOsCZquA48HeS8
	 4heW9r2q27M+XCWBU1Swlcel62Yl03JNMTbNndf1qYGcBgkAIQX86rQAnIStULOgu4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795103699;
	bh=CAt5s3aLIP+AN5sLMxCB1vGQToOFJdCC66NOcTwLvUg=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Z3U/oVkcWff1xxvfiUOOziVHsiCTgOZZQqThJkuftxT5DVYebe3YrcvpfAHq89z1y
	 AfoB+tIzFVwvEnRuT2fUOBhZbV+f/cr8MtTZVChZPSmQS2e8SH1n/eHoLRE3PEWmaT
	 oxTvSm5aZA+NUFqMWDW0nRBUQKwP/xXm316qtzFDpes3mWuDXZ3q9nz5yPWbrcB+J9
	 nAM2L0dkwpi8nCmwUU6iOwX+Bzr2/OY87g0rWD/sGaZ9F+UNdfcFfx3m35gATnXJO7
	 t9YOIY9JWrCJxkIqc1Ky7C8qWockIquxiKj0o02Ke6LanV5Uu656erj06OC6NVechx
	 Xa8iQV2AMj6Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42C2560AD2;
	Thu, 19 Nov 2026 15:54:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3BE83A8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E59FF405CD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:54:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o038tOVPCN9d for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 15:54:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DAD7C4059C
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OdgDGsGP
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAD7C4059C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:54:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CD08458F9;
 Thu, 19 Nov 2026 15:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388B51F000C4;
 Thu, 19 Nov 2026 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795103694;
 bh=CAt5s3aLIP+AN5sLMxCB1vGQToOFJdCC66NOcTwLvUg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=OdgDGsGPwykyUEQFf0ij7cqxasDS4uXXkVFCSlgv7ZZbcs/tykSzGqdItCC7QzWG2
 FDFWjnLJOmNtMGYOhDHKREckaPEP6oKeovaZlI9E60Zi4/fXlbO3VBIGxVpf5k+IiW
 K4EQ37v6aiVhG8A5deRRkw3Mb+CXrIQDd1wda+UqBRPCsDrIlsNbcI35NJZmGmSm6N
 t18TcYFnWI4YHm2LFxcWWRpjRQocUa4J/7FqG2YzwJj+VfEMyxa3Uk9Bgg1wR7HUiH
 BWL3tS0it28Y0ymHX6tgdZ2DuEydQi8ZirUlJG3FadZ+YJyHRkVZnETxs6zebQqtMf
 X7MlVzWRP48+Q==
Message-ID: <sashiko-outbox-223440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v3 4/4] ice: cancel FDIR program timer on VF exit
To: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261119152438.3577165-5-aleksandr.loktionov@intel.com>
References: <20261013144435.1406126-1-aleksandr.loktionov@intel.com>
 <c858f6d0-2adb-4bd6-9889-19e14b0e30eb@intel.com>
 <20261119152438.3577165-1-aleksandr.loktionov@intel.com>
 <20261119152438.3577165-5-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 15:54:53 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ice: live lock and timer re-init in ice_vf_fdir_init() during
  VF reset
- [Medium] ice: race with ctrl_vsi IRQ and timer in ice_vf_fdir_exit()
--

commit eec70f4e323b99b19bb5e3e82ec01ada929fa7eb
Author: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

ice: cancel FDIR program timer on VF exit

This commit moves the setup of the VF FDIR timer to ice_vf_fdir_init()
and cancels it with timer_delete_sync() in ice_vf_fdir_exit() before
clearing ICE_VF_FDIR_CTX_VALID.

> diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/eth=
ernet/intel/ice/virt/fdir.c
> index 244da64722713..64824b10a47a4 100644
> --- a/drivers/net/ethernet/intel/ice/virt/fdir.c
> +++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
[ ... ]
> @@ -2454,6 +2453,7 @@ void ice_vf_fdir_init(struct ice_vf *vf)
>  	INIT_LIST_HEAD(&fdir->fdir_rule_list);
> =20
>  	spin_lock_init(&fdir->ctx_lock);
> +	timer_setup(&fdir->ctx_irq.rx_tmr, ice_vf_fdir_timer, 0);
>  	fdir->ctx_irq.flags =3D 0;
>  	fdir->ctx_done.flags =3D 0;
>  	ice_vc_fdir_reset_cnt_all(fdir);

[Severity: Medium]
Can calling timer_setup() and spin_lock_init() in ice_vf_fdir_init()
re-initialize a live timer and spinlock during a VF reset?

In ice_reset_vf() and ice_reset_all_vfs(), ice_vf_fdir_exit() and
ice_vf_fdir_init() run before ice_vf_ctrl_vsi_release() stops the VF
control VSI and frees its interrupt:

drivers/net/ethernet/intel/ice/ice_vf_lib.c:ice_reset_vf() {
    ...
	ice_vf_fdir_exit(vf);
	ice_vf_fdir_init(vf);
	/* clean VF control VSI when resetting VF since it should be setup
	 * only when VF creates its first FDIR rule.
	 */
	if (vf->ctrl_vsi_idx !=3D ICE_NO_VSI)
		ice_vf_ctrl_vsi_release(vf);
    ...
}

If a VF reset occurs while an FDIR programming completion interrupt is in
flight on ctrl_vsi, or while ice_flush_fdir_ctx() is running on another
CPU, those paths can access fdir->ctx_lock and fdir->ctx_irq.rx_tmr at
the same time as ice_vf_fdir_init() resets them:

CPU0                              CPU1 (<hardirq>)
ice_reset_vf()
  ice_vf_fdir_exit()
  ice_vf_fdir_init()
    spin_lock_init(&fdir->ctx_lock)
    timer_setup(&fdir->ctx_irq.rx_tmr, ...)
                                  ice_vc_fdir_irq_handler()
                                    spin_lock_irqsave(&fdir->ctx_lock, ...)
                                    ...
                                    timer_delete(&ctx_irq->rx_tmr)
                                      <-- concurrent timer_setup() / lock i=
nit
  ice_vf_ctrl_vsi_release()

This can corrupt spinlock, timer_list, or debugobjects state and trigger
lockdep splats.

> @@ -2465,6 +2465,14 @@ void ice_vf_fdir_init(struct ice_vf *vf)
>   */
>  void ice_vf_fdir_exit(struct ice_vf *vf)
>  {
> +	unsigned long flags;
> +
> +	timer_delete_sync(&vf->fdir.ctx_irq.rx_tmr);
> +
> +	spin_lock_irqsave(&vf->fdir.ctx_lock, flags);
> +	vf->fdir.ctx_irq.flags &=3D ~ICE_VF_FDIR_CTX_VALID;
> +	spin_unlock_irqrestore(&vf->fdir.ctx_lock, flags);
> +
>  	ice_vc_fdir_flush_entry(vf);
>  	idr_destroy(&vf->fdir.fdir_rule_idr);
>  	ice_vc_fdir_rem_prof_all(vf);

[Severity: Medium]
Can an in-flight ctrl_vsi completion interrupt race with
ice_vf_fdir_exit() when a VF is reset or freed while an FDIR request is
pending?

All callers of ice_vf_fdir_exit() (ice_reset_vf(), ice_reset_all_vfs(),
and ice_free_vf_res()) release ctrl_vsi only after ice_vf_fdir_exit()
returns, so ice_vc_fdir_irq_handler() remains active throughout this
function:

CPU0                              CPU1 (<hardirq>)
ice_vf_fdir_exit()
  timer_delete_sync(&rx_tmr)
  spin_lock_irqsave(&ctx_lock)
  ctx_irq.flags &=3D ~ICE_VF_FDIR_CTX_VALID
  spin_unlock_irqrestore(&ctx_lock)
                                  ice_vc_fdir_irq_handler()
                                    spin_lock_irqsave(&ctx_lock)
                                    if (!(ctx_irq->flags &
                                          ICE_VF_FDIR_CTX_VALID))
                                      WARN_ON_ONCE(1);  <-- triggers warning
  ice_vc_fdir_flush_entry()
  ...
ice_vf_ctrl_vsi_release()

In addition, if ice_vc_fdir_irq_handler() fires after timer_delete_sync()
deactivates rx_tmr and before ctx_lock is taken to clear
ICE_VF_FDIR_CTX_VALID, timer_delete(&ctx_irq->rx_tmr) returns 0 and logs
"Unexpected inactive timer!".  And if either ice_vc_fdir_irq_handler() or
an already-running ice_vf_fdir_timer() callback waited on by
timer_delete_sync() promotes ctx_irq.conf into ctx_done.conf with
ICE_VF_FDIR_CTX_VALID set, ice_vf_fdir_exit() does not clear
ctx_done.flags before ice_vc_fdir_flush_entry() frees conf, leaving a
dangling ctx_done.conf pointer that a concurrent ice_flush_fdir_ctx() can
observe during ice_reset_vf().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119152438.3577=
165-1-aleksandr.loktionov@intel.com?part=3D4
