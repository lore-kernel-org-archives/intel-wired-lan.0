Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13D606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=zVl3GIw+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMvK6Now
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03BEC40B00;
	Thu, 19 Nov 2026 15:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I6WIJWqm5s25; Thu, 19 Nov 2026 15:02:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1805B40B4F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795100552;
	b=W9EAuX4WcVvN9HjyVch3S1xCcY1Z0OZrmFj5d88/3+LZyE6SRi+QWPXoWNBi/3Eiyyq1
	 eKfluk2O5Ho6PG29XEKb7arkLpKSlR4Tz7OP6Tju2eCdPjRCxq7mUtiRMKVP5Yois3rwV
	 Ofu9vIj31xAtmHwewA1XvkZMqJPYrvBHDDf4g3xKWYvvF3OQxOZzo5/Qe7FBJ1hqDQO4l
	 olIe87jpv/6RkdLtBB4C4inojXU3kPogM+G0wvl8J+sqgWo2thuqvo9Rm23vgjU+rOf8n
	 GLNBDlNn+nOed3Q61MG4yuLfPzm6d45zt85X6XEC+i8pO1Ik4IzpiyjvhF3KmlXMUTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795100552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=hKz7iFaE4C/T643pbVVhQByMQhwCw4zpWkqmcou8lUo=;
	b=RD/YudAfnTMrnHne+oBH1XamPPJJ+ILnQlorMqtwfZXzoiCwm999Lj90E7AvW+lrnCdB
	 oEDZPfPARJ4OMD9RafoHviZdb/5r3GAXSgrpALy9UEPQRUMp+hVze7Ls1AD29/bfmVjQc
	 +NkzSGLD0eCfu3b1fMBGUd/32VOQv1o/G/AnU8K/druaGQFhHm56aEXZnRNaVBzxLXr5c
	 o/iju/bq/EGQW/N3XT3oTDcXAQHhKgamCwTj7eh+/1R48ghbkSwjwsnB3jvVc63wXx6ui
	 8VMUWAE3m2F5xJF+dzNKx6PbW7rc9Sj5IET1Fdx6LpL1eoZPd9f8ecPv0H9fKdPh4kg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795100552;
	bh=hKz7iFaE4C/T643pbVVhQByMQhwCw4zpWkqmcou8lUo=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zVl3GIw+XeKtgIxrbdacyDU53P6knJHTbp9d+9xnLRZXHW0nfjKG7IxMijtw4MKoO
	 RRInwKw+5QeI5Bvz6LJyN0iEyTAduWxgNm7wjW/VPl841igzufo4bqfzB+XG2hxFwk
	 9DN8WAfwIxSm7osGRCSFabJHT34XTUn4Wux86HN21wNMQUOeBOl86+uef6of935kft
	 cuFw4c0UiTI524x5q+MGWhZ6+xBGbryiH4dCDZFaNrJA4UIq4cCs3ODvCTDoEvTr8e
	 dtuYdgm0NwZYAvLfGi1PccMmxkiJb2X2tmlpGCT80n1gdTm8XAOPQwH6heEteWt+WH
	 xTIg8JEwk0OWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1805B40B4F;
	Thu, 19 Nov 2026 15:02:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 783B91C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69DE581371
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9U64wuIJIaA for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 15:02:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4570A81366
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JMvK6Now
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4570A81366
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:02:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B669D4567A;
 Thu, 19 Nov 2026 15:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF231F000C4;
 Thu, 19 Nov 2026 15:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795100548;
 bh=hKz7iFaE4C/T643pbVVhQByMQhwCw4zpWkqmcou8lUo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=JMvK6NowcUJfq02jHkmd/mG5EWNhp/T5fGOohmUjCI8J3J5xPKVfPiXHDvOOJ0Iw7
 AxGPjNEO87ntz+Fvm59WgRrQBZ5UuzEv+nyFNIOtdFOMEZ2Ko6uPiCuECzsfNz8Iqt
 pvwfCVOI45vnpr7ia/JrTbwsLGkwLGomyfcAlJfDa5zEoVlqwevdKY2MusdIhpvkne
 Mm6S/OWCfCw5ZXNgdi8+eqbQ+hzJVaziGMFq3RudhcbsM2NMoUr/yr+Lh3TqmdMtz3
 GHH1uXHXIEORrUQD9ghdLl36aTwS/GKJbq7a314tnKVMV9JjmL/c8vdqFrUlT7knw2
 3/ZPv3Ug20CeQ==
Message-ID: <sashiko-outbox-223336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v3 3/3] idpf: add flow-based XDP fallback for
 FWs without Tx FIFO support
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261119140938.1363722-4-aleksander.lobakin@intel.com>
References: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
 <20261119140938.1363722-4-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 15:02:28 +0000
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] idpf: unchecked cpu_to_mem() for i >=3D nr_cpu_ids in
  idpf_xdpsqs_get()
- [Medium] idpf: premature CQE poll exit on out-of-order CQEs in
  idpf_xdpsq_poll_fb()
--

commit 6119bbbc742528036710b0619a594398135c70b2
Author: Alexander Lobakin <aleksander.lobakin@intel.com>

idpf: add flow-based XDP fallback for FWs without Tx FIFO support

This commit introduces a flow-based Tx scheduling fallback for XDP and
AF_XDP on firmware that lacks queue-based (FIFO) Tx scheduling support,
using a per-queue bitmap to serialize out-of-order per-packet completion
tags into contiguous descriptor ranges.

> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet=
/intel/idpf/xdp.c
> index 48320ea004dfb..0b4ead7fbcaf6 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c

[ ... ]

> @@ -169,13 +173,42 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
>  			for (int j =3D i - 1; j >=3D 0; j--)
>  				kfree(timers[j]);
> =20
> -			return -ENOMEM;
> +			goto err_timers;
>  		}
>  	}
> =20
>  	dev =3D vport->netdev;
>  	sqs =3D vport->dflt_qv_rsrc.xdp_txq_offset;
> =20
> +	fb =3D !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
> +			      VIRTCHNL2_CAP_SPLITQ_QSCHED);
> +	if (!fb)
> +		goto setup;
> +
> +	masks =3D kvzalloc_objs(*masks, vport->num_xdp_txq);
> +	if (!masks)
> +		goto err_masks;
> +
> +	for (u32 i =3D 0; i < vport->num_xdp_txq; i++) {
> +		masks[i] =3D bitmap_zalloc_node(vport->txqs[sqs + i]->desc_count,
> +					      GFP_KERNEL, cpu_to_mem(i));

[Severity: High]
Can cpu_to_mem(i) index past nr_cpu_ids when vport->num_xdp_txq exceeds
the number of CPUs?

idpf_vport_calc_total_qs() sizes num_xdp_txq via libeth_xdpsq_num(),
which returns min(max(nr_cpu_ids, rxq), max - txq).  When an
administrator configures more Rx queues than nr_cpu_ids via ethtool -L,
i reaches >=3D nr_cpu_ids (as it also does in the pre-existing timers[i]
loop above), indexing an uninitialized or out-of-bounds
__per_cpu_offset[i] entry on NUMA kernels.  idpf_q_vector_to_mem() guards
this with:

  cpu < nr_cpu_ids ? cpu_to_mem(cpu) : NUMA_NO_NODE

[ ... ]

> @@ -255,6 +319,65 @@ static int idpf_xdp_parse_cqe(const struct idpf_spli=
tq_4b_tx_compl_desc *desc,
>  #endif
>  }
> =20
> +static u32 idpf_xdpsq_poll_fb(struct idpf_tx_queue *xdpsq, u32 budget)
> +{
> +	struct idpf_compl_queue *cq =3D xdpsq->complq;
> +	unsigned long *mask =3D xdpsq->pending_mask;
> +	u32 done_frames, tx_cnt, new_ntc;
> +	u32 ntc =3D cq->next_to_clean;
> +	u32 cnt =3D cq->desc_count;
> +	bool gen;
> +
> +	gen =3D idpf_queue_has(GEN_CHK, cq);
> +
> +	for (done_frames =3D 0; done_frames < budget; ) {
> +		int ret;
> +
> +		ret =3D idpf_xdp_parse_cqe(&cq->comp[ntc].common, gen);
> +		if (ret >=3D 0) {
> +			__clear_bit(ret, mask);
> +			done_frames++;
> +
> +			goto next;
> +		}
> +
> +		switch (ret) {
> +		case -ENODATA:
> +			goto out;
> +		case -EINVAL:
> +			break;
> +		}
> +
> +next:
> +		if (unlikely(++ntc =3D=3D cnt)) {
> +			ntc =3D 0;
> +			gen =3D !gen;
> +			idpf_queue_change(GEN_CHK, cq);
> +		}
> +	}
> +
> +out:
> +	cq->next_to_clean =3D ntc;
> +
> +	if (unlikely(!done_frames))
> +		return 0;
> +
> +	tx_cnt =3D xdpsq->desc_count;
> +
> +	/* Don't go past next_to_use */
> +	__set_bit(xdpsq->next_to_use, mask);
> +
> +	new_ntc =3D find_next_bit(mask, tx_cnt, xdpsq->next_to_clean);
> +	done_frames =3D new_ntc - xdpsq->next_to_clean;
> +
> +	if (new_ntc =3D=3D tx_cnt)
> +		done_frames +=3D find_first_bit(mask, tx_cnt);
> +
> +	__clear_bit(xdpsq->next_to_use, mask);
> +
> +	return done_frames;
> +}

[Severity: Medium]
Can idpf_xdpsq_poll_fb() return 0 after consuming out-of-order CQEs if
the descriptor at xdpsq->next_to_clean has not completed yet?

The loop stops after reading budget raw CQEs, but the return value is
overwritten with the contiguous run of cleared bits starting at
xdpsq->next_to_clean.  If budget younger packets complete ahead of
xdpsq->next_to_clean, idpf_xdp_tx_prep() (which passes budget =3D
xdpsq->thresh) gets 0 reclaimed descriptors and drops frames when the
ring is full even if the CQE for xdpsq->next_to_clean is already waiting
next in cq.  In addition, if the delayed cleanup timer runs
libeth_xdpsq_run_timer() and consumes out-of-order CQEs while
xdpsq->next_to_clean is still in flight in hardware, poll() returns 0 and
libeth_xdpsq_run_timer() stops re-arming the timer with pending frames
still on the queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119140938.1363=
722-1-aleksander.lobakin@intel.com?part=3D3
