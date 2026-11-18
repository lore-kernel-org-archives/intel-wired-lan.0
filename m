Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2D606A338
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vlg5nRVJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJxJI+GG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C57860A8B;
	Wed, 18 Nov 2026 16:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ag2nVztRaB3W; Wed, 18 Nov 2026 16:29:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7404460A94
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019370;
	b=IGgDnrbPbS7ijS3A2iIwkyUmEwD+gOtdtS39Pvm3WLoywyesOTdzUX3MhBASqzzGzGpU
	 zTv415gAQleq9ybHuEUK9hruX9cNpnmtgZZ8/fKsGXGFXSO7cyImv3A4CKc6/g+eKVIRn
	 KKxDeU8Ueoce6tUnPzKlXSrDLqA+xji1JzAU/Hl+yrTBir1Dv03JM4S2QmwyMtEBGgOC2
	 oMIhgNLhJoVxFXMhheJek6N20yCySGolorDpjPB9BTDoq2ghtskKV7jgNmy670nLODryk
	 CdE5DkdjtkFu9mT+H1nHRJmvrxKg/66khwE8t6IU8lZsVQDlGa40JxCLcZRwK4joQcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=mcMmb9jI3Qb6UhIVuI2mSDctASk2fSJupG23cdaaLvk=;
	b=FV64LR7aZKoBEWY91oy3wq/gwaK03u/cD6Y0iNfHF+D2e7AsSDwVCZodoM2iHXbVKwx7
	 vqXhCb+sC54TrSM/rnRyDhV+TArXZAI8N8zV5bX/wbOIuJ4pWUuaWFmVN07j5IpbagSyW
	 E7S13tWi81kAhDFX2QF1J1EiS3R7ynFAHHrixi+jVzFbipAGF5s2tJJAXfCEbeOOxQFpY
	 gw37nzkS51jA5/VIwOxEBUyjWliyqrc1IwaoOLk6DyhnwKAJlYVYOobATP6KwRFSbMNL9
	 9IKzLgD+kwH8Os+I0r57iZok+VZxU9Ury6eMJPGSeFvhCqWMrg715DWZ3n69tAhXvtA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795019370;
	bh=mcMmb9jI3Qb6UhIVuI2mSDctASk2fSJupG23cdaaLvk=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=vlg5nRVJgxJjRFy7sfhA+EED9HlXZtM3HAdwBtLG9WjoHqohGCyuMv2IA5k/6YgUx
	 H3LRVCMhlm35hFp/g3vy1MtmuQmZr91fuyocuwxgnsAOP5l1ikX+C+0wVb4A+WhtaA
	 7wS0EMWJTt7WRmrvQDuoQdDjCQi7KhsChviYtDHjjXoMunjY2iZIfMHbZbL/xA4flH
	 l0L/oockMmsFbeHuIm1PqCQ2d4DlF/xqV5zs7ID3nVCqkKRhhdLnskMAWKNHq40WjK
	 UexDkbY+QORV5MN2fhzZfbbpltjV4gV4pDAzTv6olThew4r6zzGa4fhYPxZyX9KAu1
	 5IlYHl1cgBo1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7404460A94;
	Wed, 18 Nov 2026 16:29:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3138C9F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 177D2404B9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IkSqEoABQC_I for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 16:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 07CBA404AE
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SJxJI+GG
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07CBA404AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0E6445AAC;
 Wed, 18 Nov 2026 16:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62CE1F000C4;
 Wed, 18 Nov 2026 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795019366;
 bh=mcMmb9jI3Qb6UhIVuI2mSDctASk2fSJupG23cdaaLvk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=SJxJI+GGlq5uCYVbAWgDgfJ+MWWRqjACtornyGAQFhlQs2d7LeUhWM4zIm+a7ynG5
 HvTg/7snkS+vc7siQkONajoHf6ev1YIbdl8W9OzndwdhEzDQR/udon4y08Ckg41wCX
 EczHYVhkR94FvuQD9QT1vMew6TPZ6VlUBxM3kHmfsjOqCEiOZlcUPqWS0vZE95onel
 2d8dePrMjMZhnJzHKnwTgL3hkexFluUlBL3MHPXsmi7sYyDp+a7HYkGdYmc3Ip//7C
 a0uywJ2V42DgyT/lOhMG9UQa5U2pXw0QhNWPYXvvWSzavnhgmCJkuu89GrXLLgMECI
 aIkQbljtjIboQ==
Message-ID: <sashiko-outbox-221486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 08/15] idpf: psp: add support for psp rx key
 allocation
To: "Stan Iliev" <stani@google.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261117145522.1910636-9-stani@google.com>
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-9-stani@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:29:26 +0000
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
- [High] idpf: psp: race with hard reset in idpf_psp_rx_spi_alloc()
- [Low] idpf: psp: wrong reset type in vport_id kernel-doc comment
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] idpf: memory leak of tx_tstamp_caps on RSS error paths in
  idpf_vport_alloc() [1]
--

commit 579b4b79a623f0ec9c780b3ed4bd922d42ad422e
Author: Stan Iliev <stani@google.com>

idpf: psp: add support for psp rx key allocation

This commit adds virtchnl definitions and driver support for allocating
PSP V0 RX keys on demand via the rx_spi_alloc PSP device operation.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index 1385209519b25..062753a62f593 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1144,6 +1144,9 @@ static struct idpf_vport *idpf_vport_alloc(struct i=
dpf_adapter *adapter,
>  	/* fill vport slot in the adapter struct */
>  	adapter->vports[idx] =3D vport;
>  	adapter->vport_ids[idx] =3D idpf_get_vport_id(vport);
> +	/* Copy for the PSP requests that can run while the vports are freed */
> +	if (IS_ENABLED(CONFIG_INET_PSP) && !idx)
> +		WRITE_ONCE(adapter->psp.vport_id, adapter->vport_ids[idx]);

[Severity: Medium]
This problem wasn't introduced by this patch, but does idpf_vport_alloc()
leak vport->tx_tstamp_caps [1] if RSS initialization fails before
adapter->vports[idx] is assigned?

Earlier in idpf_vport_alloc(), idpf_vport_init() calls
idpf_ptp_get_vport_tstamps_caps(), which allocates vport->tx_tstamp_caps
and populates its latches_free list.  If allocating rss_data->rss_key or
idpf_init_rss_lut() then fails, the error path jumps to
deinit_vport_queues or free_rss_key and frees vport without releasing
vport->tx_tstamp_caps, and the caller's cleanup via idpf_ptp_release()
also misses it because adapter->vports[idx] is still NULL:

drivers/net/ethernet/intel/idpf/idpf_lib.c:idpf_vport_alloc() {
    ...
	err =3D idpf_vport_init(vport, max_q);
	if (err)
		goto free_vport;
    ...
	rss_data->rss_key =3D kzalloc(rss_data->rss_key_size, GFP_KERNEL);
	if (!rss_data->rss_key)
		goto deinit_vport_queues;
    ...
	err =3D idpf_init_rss_lut(vport, rss_data);
	if (err)
		goto free_rss_key;

	/* fill vport slot in the adapter struct */
	adapter->vports[idx] =3D vport;
    ...
free_rss_key:
	kfree(rss_data->rss_key);
	rss_data->rss_key =3D NULL;
deinit_vport_queues:
	idpf_vport_deinit_queue_reg_chunks(adapter->vport_config[idx]);
free_vport:
	kfree(vport);
}

Calling idpf_ptp_release_vport_tstamp(vport) on the deinit_vport_queues
error path would avoid leaking the timestamp capability structure and its
latch entries.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/eth=
ernet/intel/idpf/idpf_psp.c
> index 67f1f1d7508cf..8ce390bcd6178 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c

[ ... ]

> @@ -136,9 +139,49 @@ static int idpf_psp_set_config(struct psp_dev *psd, =
struct psp_dev_config *conf,
>  	return 0;
>  }
> =20
> +/**
> + * idpf_psp_rx_spi_alloc - Allocate a PSP RX SPI and key
> + * @psd: PSP device
> + * @version: PSP version
> + * @key: filled with the allocated SPI and key
> + * @extack: netlink extended ack for error reporting
> + *
> + * Allocate one RX key with a synchronous VIRTCHNL2_OP_PSP_ALLOCATE_KEYS
> + * request.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int idpf_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
> +				 struct psp_key_parsed *key,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct idpf_adapter *adapter =3D idpf_netdev_to_adapter(psd->main_netde=
v);
> +	struct idpf_psp_rx_key rx_key;
> +	int err;
> +
> +	/* Only version 0 keys are allocated, see idpf_psp_register() */
> +	if (psp_key_size(version) !=3D sizeof(rx_key.key)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unsupported PSP version");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err =3D idpf_send_allocate_psp_key(adapter, &rx_key);

[Severity: High]
Can idpf_psp_rx_spi_alloc() race with a hard reset and trigger a
use-after-free or NULL pointer dereference on the default mailbox queues?

idpf_psp_rx_spi_alloc() holds psd->lock, but does not acquire
adapter->vport_ctrl_lock or check idpf_is_reset_in_prog().  When a hard
reset runs, idpf_deinit_dflt_mbx() calls libie_ctlq_xn_deinit(), which
frees adapter->xnm, adapter->asq and adapter->arq before setting those
pointers to NULL:

CPU0                                  CPU1
idpf_init_hard_reset()                psp_nl_rx_assoc_doit()
  idpf_vport_ctrl_lock(adapter)         idpf_psp_rx_spi_alloc()
  idpf_vc_core_deinit(adapter)            idpf_send_allocate_psp_key()
  idpf_deinit_dflt_mbx(adapter)             idpf_send_mb_msg()
    libie_ctlq_xn_deinit(...)                 idpf_is_reset_detected()
      kfree(adapter->arq)                       readl(adapter->arq->...)
                                                  <-- use-after-free
    adapter->arq =3D NULL

If idpf_send_mb_msg() passes idpf_is_reset_detected() just before
idpf_deinit_dflt_mbx(), or during idpf_init_dflt_mbx() after adapter->arq
is assigned but before adapter->xnm is set, idpf_mb_clean() and
libie_ctlq_xn_send() can also dereference a freed or NULL adapter->asq or
adapter->xnm.

In addition, neither idpf_psp_rx_spi_alloc() nor
idpf_send_allocate_psp_key() checks idpf_is_psp_ena(adapter), so once
idpf_init_dflt_mbx() finishes during a reset, VIRTCHNL2_OP_PSP_ALLOCATE_KEYS
can be sent with a stale vport_id before vport recreation, or after
idpf_psp_init() has disabled PSP offload.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net=
/ethernet/intel/idpf/idpf_psp_def.h
> index 0829d0bbd92b2..f21bd7de5ae8c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
> @@ -19,6 +32,10 @@
>   * @saidx_width: SA index width granted by VIRTCHNL2_OP_CRYPTO_GET_CAPS
>   * @psp_caps: PSP capabilities granted by VIRTCHNL2_OP_PSP_GET_CAPS, see
>   *	      enum virtchnl2_psp_caps
> + * @vport_id: ID of adapter->vports[0] for the PSP requests. A copy, as =
the
> + *	      PSP device stays registered while the vports are freed and
> + *	      allocated again during a soft reset. Set in idpf_vport_alloc().

[Severity: Low]
This isn't a bug, but vports are freed and reallocated via
idpf_vport_alloc() during a hard reset rather than a soft reset
(idpf_initiate_soft_reset() only reallocates queue resources on the
existing vport).

[1] https://sashiko.dev/#/bug/linux-9b904fce-205d-411e-be8c-4b18ed5978ec

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117145522.1910=
636-1-stani@google.com?part=3D8
