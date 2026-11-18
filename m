Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0B606A33F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LgSSVTsq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crILie7Y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2FAA60AA4;
	Wed, 18 Nov 2026 16:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9zHvBeWycio; Wed, 18 Nov 2026 16:29:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF87060A9F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019372;
	b=RKx8gZcWv6hY6NqLMWYVabzU8lwMpxfxgmHH/GgFaEmWagJmiZK5Zra2Q7cMv3ALYr4q
	 iN9O2MOSd/EiLDtBRduIhsjF7RzBJZuL9BcgNs+jjgQlsywQwT2Tfc5phVZKpKAdW1ZHR
	 79Y4q1wVNgGlnuip8kxOb5U0EZdIBNNntB89TQxqdZJLZK8HnaXaH0d94yw2wjFKOXwRk
	 ee3cLitRCL+j3Z1btLJDMdgRq7jirprxUPxRTG/eOS4wdvcjYJ2XD7B7NaO0mlOu7II1c
	 UXeDenRmXtN7czXD7snPGKRqRuOSb608G31QAG+beHx0z+vulqduWRb9OzfS1Z/z1YA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=wXPnSBPIom1rAed5LyO74MtdEIxScgIyuTf9f2EZgZI=;
	b=WHiZmSYXPJcfXzgO81fRfAjPJf6GMBo1jVhCgv11JPwRog9Gr1aE0NekHDEJ6iRSmmsp
	 0aQx1Fhfg7ifBsZldJxvwOdliw3cqcLHzwPwx3mzhpcOHCAi99N8PbfqUCV+OR66AMLVN
	 c3HJnEWqeykKiOtYdrcPb0PN0vYpvA46hCIlvF1FTM1PjGVrtDJaIxuLxBC41qNSfY+UL
	 8PWAllNSBbY145YDOKLZxQCLH+k+WYMJ5uzs7rj7ozaxzpQM4IHFQAHpMZe4v9F+x24VV
	 oJKTVKL9m3N7elS0TjNXW/jFQTyhjg9V7CVLv+4rzbywAFBr5ldwZKDCkfPgZVhlksg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795019372;
	bh=wXPnSBPIom1rAed5LyO74MtdEIxScgIyuTf9f2EZgZI=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=LgSSVTsqoX+Chc93h39L+Xp2W08tOLSzWxFQeuUWWjK1QRqeW1LxItGAjgpg9sxf1
	 e4wt8iMUSQl9T8a/6KyrAmQwGNpA98tE/2pZr2qrztfD0WRLQz/vR8OO/OFlWv85Ut
	 XwO/N8AB7egE0V8RAu5IwafgukimYHN6khGa0iX6io1X4zOxVMDh89mT1Va/1FG/ln
	 WYU30xfzLNi4hdnglGBMs8+tw2Qbn+EFg6xy/EfUKnKDRznw3SSE76M2ckThfom9p2
	 zChngdOgWP5d++P0nYbvlTtyCeOurn5VYlWWvFVZWu18UsJw1NipTnXUqlPV3hKjEj
	 8oTa9LrNAeh9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF87060A9F;
	Wed, 18 Nov 2026 16:29:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C84F69F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AEC2540926
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gVGIBiB1KG_c for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 16:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC7574079D
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=crILie7Y
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC7574079D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F2D945B91;
 Wed, 18 Nov 2026 16:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA25B1F000C4;
 Wed, 18 Nov 2026 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795019368;
 bh=wXPnSBPIom1rAed5LyO74MtdEIxScgIyuTf9f2EZgZI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=crILie7YXEuTD+r/J+HfZvROliTNXDG92a7+h99qNSIh7eObysvOvsHd1YXdqD6mZ
 sZPZJhpzXdLwNjkA/t/NEQbQKCcx0NrsKEcANMaZTwjvAvUDBMs7W6Q5N97iz2G7ny
 oOyzVXH/iyx9Y0zgTFIvmCkOwv8svLEcdkmcWNL3LtSejyb+68NkblfmgorUbQAWqq
 2bkpTBNYk5Pm49aQfRSkKQXX1+vUJDTB6uZlx556nHTVj0TwMTSmTCy5rDYJhgzyR7
 pNzqm27Tp9ogwWWraM/lsedQNUEbAbZeW4R2/R3WSI2v9YLFKOo4/ghgZ/8VexeBtZ
 XFmdNzL5Q1SFw==
Message-ID: <sashiko-outbox-221491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 13/15] idpf: psp: add psp work and tx key
 insertion completion
To: "Stan Iliev" <stani@google.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261117145522.1910636-14-stani@google.com>
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-14-stani@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:29:27 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 2 related pre-existing issues it does not
introduce:
- [Critical] idpf: double free of vport->txqs in
  idpf_initiate_soft_reset() [1]
- [Critical] idpf: use-after-free in
  idpf_ptp_get_txq_tstamp_capability() [2]
--

commit 1bdbc7bd2b7486c90a1b74658932d35032195933
Author: Stan Iliev <stani@google.com>

idpf: psp: add psp work and tx key insertion completion

This commit adds delayed work to send queued PSP key deletion requests and
implements completion handling, timeout recovery, and quiescing for
asynchronous TX key insertion requests.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index 062753a62f593..18d484c1a2cad 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
[ ... ]
> @@ -1882,6 +1888,11 @@ int idpf_initiate_soft_reset(struct idpf_vport *vp=
ort,
>  	if (!new_vport)
>  		return -ENOMEM;
> =20
> +	/* No PSP packet is sent while the queues are reallocated, the PSP
> +	 * work is queued again below
> +	 */
> +	idpf_cancel_psp_work(adapter);
> +
>  	/* This purposely avoids copying the end of the struct because it
>  	 * contains wait_queues and mutexes and other stuff we don't want to
>  	 * mess with. Nothing below should use those variables from new_vport
> @@ -1970,6 +1981,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vpo=
rt,
> =20
>  free_vport:
>  	kfree(new_vport);
> +	idpf_queue_psp_work(adapter);
> =20
>  	if (reset_cause =3D=3D IDPF_SR_MTU_CHANGE)
>  		idpf_idc_vdev_mtu_event(vport->vdev_info,

[Severity: Critical]
This problem wasn't introduced by this patch, but can
idpf_initiate_soft_reset() cause a double free of vport->txqs [1]?

After copying vport into new_vport, idpf_vport_stop() calls
idpf_vport_queues_rel(), which frees vport->txqs and sets it to NULL, while
only new_rsrc->rxq_grps is cleared in the clone:

drivers/net/ethernet/intel/idpf/idpf_lib.c:idpf_initiate_soft_reset() {
	...
	memcpy(new_vport, vport, offsetof(struct idpf_vport, link_up));
	...
	} else {
		set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
		idpf_vport_stop(vport, false);

		/* Drop the stale pointer in the clone, as rxq_grps was freed
		 * by idpf_vport_stop().
		 */
		new_rsrc->rxq_grps =3D NULL;
	}
	...
	memcpy(vport, new_vport, offsetof(struct idpf_vport, link_up));
	...
}

The second memcpy() writes the freed vport->txqs pointer from new_vport
back into vport.  If idpf_set_real_num_queues() or idpf_vport_open() fails
before reallocating the queues, the dangling vport->txqs pointer remains in
vport and is freed a second time when idpf_vport_queues_alloc() later fails
into idpf_vport_queues_rel().

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 90fe5212095df..bff3b0f46113e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3281,6 +3281,9 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapt=
er)
>  	if (remove_in_prog)
>  		libie_ctlq_xn_shutdown(adapter->xnm);
> =20
> +	/* The mailbox transactions were shut down in both cases */
> +	idpf_psp_quiesce(adapter);
> +
>  	cancel_delayed_work_sync(&adapter->serv_task);
>  	cancel_delayed_work_sync(&adapter->mbx_task);

[Severity: Critical]
This problem wasn't introduced by this patch, but can
idpf_ptp_get_txq_tstamp_capability() trigger a use-after-free on
txq->cached_tstamp_caps during teardown [2]?

In idpf_vc_core_deinit(), idpf_ptp_release() frees vport->tx_tstamp_caps
before idpf_deinit_task() stops the vports and netdevs, while
txq->cached_tstamp_caps on active TX queues still points to it:

CPU0                                  CPU1
idpf_vc_core_deinit()
  idpf_ptp_release()
    idpf_ptp_release_vport_tstamp()
      kfree(vport->tx_tstamp_caps)
                                      idpf_tx_start()
                                        ...
                                          idpf_ptp_get_txq_tstamp_capabilit=
y()
                                            txq->cached_tstamp_caps->access
                                              <-- use-after-free
  idpf_deinit_task()

[1] https://sashiko.dev/#/bug/linux-2cb96bfd-fe1d-4dd4-ba7f-97cce6b47ab6
[2] https://sashiko.dev/#/bug/linux-6f8f8f90-94e3-4193-85dc-3ce7d6f00653

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117145522.1910=
636-1-stani@google.com?part=3D13
