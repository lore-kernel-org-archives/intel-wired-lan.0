Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BE606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=arF+N/Ov;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8D0aIxX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1B9C812DC;
	Fri, 27 Nov 2026 20:35:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHF27kAnBMf9; Fri, 27 Nov 2026 20:35:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C58DC812E0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795811715;
	b=g5r5P09KDlDARzVsrAvCrvxkRy8MH9Or7rvilSkboiA3wRJYs2peysFxrVCF+4pFT2Tg
	 CESIci6GD72Ua3ts+us66XjjMYPyv1SsxRGdgDESKKoatEAA/E8H7ME3Ta7/A5UK6XSLP
	 vHij4AN0t42RgnKfc7HSylc7rejjila2SNIV9U5KqcPQZniuHD5HEUj55GU56LroPIsjo
	 yJU2NtWJEHdzYPCKh2n1hhGu6fIXKzZXtnjcXrKTGpnSMk+FzLObd+wu/QqpN4bb7ktIo
	 4a65Rr/Pkvi3CYVknjVz9r+IxA30UyiEm6MB0IOm4txNUXep4vhiRDfgquFTa+H/9Rg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795811715;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=qPzHYYnhDwNTrcpYeaML0/aaPEbZY+qdl+qwdcsBjME=;
	b=Wv5EiikYXYrXmfLhuNw0IQmB3aaqFEcovxqQbzSc2ABl485xUsyqed48JS8sGI9EkUIU
	 CI52tGVYgk+MP1tir+9ls229NTVoHT+UySH1d/Q5SmeyrFGWXZKEF3/Mb8dt0q+SDhYhK
	 n5E+ZI8GkrHC3i0Z7v8u90T+jiQ/c1UmzXDRaNcTHrAl9qE8VREO9cV1r09qoqqx6kMs3
	 pZ5/5IBV0JP527m/Cqy6dLWLoprdjXagN6GuNRdPFsyM+JRT/GHM3KrxxHfzGjn6vC79E
	 BqlafqsZU8a9SN76NQHOSOhKewPen4moGvl9YEOJmumxSTevf26JcmkuJAaKPq6AXVQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795811715;
	bh=qPzHYYnhDwNTrcpYeaML0/aaPEbZY+qdl+qwdcsBjME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=arF+N/Ov/2h7ngVGUK/XKXiFgQ/1pLoKf3B8DRrN/vAgtCmJIEKvwdVB+G4/5k9Tv
	 N/fHG2HueP84IxHETPDCWQeGiN8YYuUF8OOg/EgTCwlmxD0ICmIkkwZJi6gfK4H2Wg
	 PI1icjquf3CZBsShGw4yFpSOXLliJrC16wjSZq0MgUga5tpC1HunsJKUfF5E9L6vK0
	 eujDVVL93hkn6/qCZNQnynQBkn3vSAlRW5wBQu80NYWckhTLidZdYRO3+dS+ptLIoW
	 4YaZu7VNuGOZs2Qb0zWamAV1zp99DAOcqnbPIyyjeTK9sHkvgLDZkKcnurT2T7ZIla
	 wRGT5qv5hmzPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C58DC812E0;
	Fri, 27 Nov 2026 20:35:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 117CF2BD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 20:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC6E040249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 20:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utipbvilK6Y0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 20:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DD3C1400BC
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=W8D0aIxX
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD3C1400BC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 20:35:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A83F940AD8;
 Fri, 27 Nov 2026 20:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E591F00897;
 Fri, 27 Nov 2026 20:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795811711;
 bh=qPzHYYnhDwNTrcpYeaML0/aaPEbZY+qdl+qwdcsBjME=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W8D0aIxXk4PJYEpeMOfP06vHwcq2UtPIyIzL7a7dRGZGmTeEEs9VT1O44Ok1wnprJ
 TS7KLU6dwYVEVurDNXACsaHOQWPl2+daKs/xwy+OjIUhR4Th57TVomgUv6yIF5Eiqb
 p9WOFSYpMN08Bc3LUqS1Qqrfznc7ib5mv6Gs2xQY6FU8WkjVmQ3/7drCWKfoEEernI
 vGJa/OZJuhf06tg9LvNZ3ClTdywt6duajAP5zuE6U7IAcLphBxgDFLCSo9lRyTcXdy
 Ytntlq9IG/r2EJcs+k/DpYTKgy1GMOElYcHnX3N44vu08TcFmuuIoH9sWrIl0TBKp2
 LjM5Hc2pT7+6Q==
Message-ID: <sashiko-outbox-238256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 14/19] ice: dpll: route the E825 recovered
 clock through the mux devices
To: "Ivan Vecera" <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261126203231.934632-15-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
 <20261126203231.934632-15-ivecera@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 20:35:11 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] ice: dpll: stale cached p->state check in
  ice_dpll_rclk_state_on_dpll_set()
- [Medium] ice: dpll: unvalidated pin state in
  ice_dpll_rclk_state_on_dpll_set()
- [Low] ice: dpll: mux notification on error exit in
  ice_dpll_rclk_state_on_dpll_set()
--

commit a3dbcf00efb856319244590da2964b162e852fdf
Author: Ivan Vecera <ivecera@redhat.com>

ice: dpll: route the E825 recovered clock through the mux devices

This commit registers each E825 PF's recovered clock pin directly as an
input of the two recovered clock mux DPLL devices instead of as a child of
firmware-described parent pins, and removes the DPLL notifier and fwnode
lookup paths.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethe=
rnet/intel/ice/ice_dpll.c
> index a608c5ea4d5cc..42579cc3fb9e0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
[ ... ]
> @@ -2856,6 +2840,108 @@ static int ice_dpll_rclk_mux_mode_get(const struc=
t dpll_device *dpll,
>  	return 0;
>  }
> =20
> +/**
> + * ice_dpll_rclk_state_on_dpll_set - set a state of rclk pin on a mux
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: registered dpll pointer
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @state: state to be set on pin
> + * @extack: error reporting
> + *
> + * Dpll subsystem callback. Route the recovered clock of the port to the
> + * output of a recovered clock mux, or stop routing it.
> + *
> + * Context: Acquires pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - failure
> + */
> +static int
> +ice_dpll_rclk_state_on_dpll_set(const struct dpll_pin *pin, void *pin_pr=
iv,
> +				const struct dpll_device *dpll,
> +				void *dpll_priv, enum dpll_pin_state state,
> +				struct netlink_ext_ack *extack)
> +{
> +	bool enable =3D state =3D=3D DPLL_PIN_STATE_CONNECTED;
> +	struct ice_dpll_rclk_mux *mux =3D dpll_priv;
> +	struct ice_dpll_pin *p =3D pin_priv;
> +	struct ice_pf *pf =3D p->pf;
> +	struct dpll_pin *prev;
> +	int ret =3D -EINVAL;

[Severity: Medium]
Should ice_dpll_rclk_state_on_dpll_set() reject states other than
DPLL_PIN_STATE_CONNECTED and DPLL_PIN_STATE_DISCONNECTED, like
ice_dpll_txclk_state_on_dpll_set() and ice_dpll_tspll_state_on_dpll_set()
do?

The recovered clock mux operates in DPLL_MODE_MANUAL, but dpll_pin_state_se=
t()
allows userspace to pass DPLL_PIN_STATE_SELECTABLE.  Here,
DPLL_PIN_STATE_SELECTABLE evaluates enable as false and disconnects a
connected port instead of returning -EINVAL.

> +
> +	if (ice_dpll_is_reset(pf, extack))
> +		return -EBUSY;
> +
> +	/* Read again with the write of the mux, under cgu_synce_lock */
> +	prev =3D READ_ONCE(mux->src);
> +	mutex_lock(&pf->dplls.lock);
> +	if ((enable && p->state[mux->idx] =3D=3D DPLL_PIN_STATE_CONNECTED) ||
> +	    (!enable && p->state[mux->idx] =3D=3D DPLL_PIN_STATE_DISCONNECTED))=
 {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "pin:%u state:%u on dpll:%u already set",
> +				   p->idx, state, mux->idx);
> +		goto unlock;
> +	}
> +
> +	ret =3D ice_dpll_synce_update_e825c(&pf->hw, enable,
> +					  pf->ptp.port.port_num, mux->idx,
> +					  &prev);

[Severity: Medium]
Can p->state[mux->idx] be stale here when another PF takes over the shared
mux?

On E825, p->state[mux->idx] is only refreshed inside
ice_dpll_rclk_state_on_dpll_get().  When PF1 connects itself to a mux that
was routing PF0, PF0's cached p->state[mux->idx] is updated only as a side
effect of __dpll_pin_change_ntf(prev) -> dpll_pin_event_send() ->
dpll_cmd_pin_get_one() calling ice_dpll_rclk_state_on_dpll_get() on PF0.
If PF0 is undergoing a reset at that moment, ice_dpll_rclk_state_on_dpll_ge=
t()
returns -EBUSY before calling ice_dpll_pin_state_update(), leaving PF0's
p->state[mux->idx] at DPLL_PIN_STATE_CONNECTED.

A subsequent request on PF0 to connect will then be rejected as "already
set", while a request to disconnect PF0 will pass this check and call
ice_dpll_synce_update_e825c(&pf->hw, false, ...), which disables the shared
hardware mux in ice_tspll_cfg_bypass_mux_e825c() and cuts off PF1's
recovered clock.

> +	if (ret)
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "err:%d %s failed to set pin state:%u for pin:%u on dpll:%u",
> +				   ret,
> +				   libie_aq_str(pf->hw.adminq.sq_last_status),
> +				   state, p->idx, mux->idx);
> +unlock:
> +	mutex_unlock(&pf->dplls.lock);
> +	/* The core notifies this pin on success */
> +	__ice_dpll_rclk_mux_ntf(mux, prev, ret ? NULL : p->pin);
> +
> +	return ret;
> +}

[Severity: Low]
Does the "already set" goto unlock path need to skip
__ice_dpll_rclk_mux_ntf()?

Before this patch, ice_dpll_rclk_state_on_pin_set() left mux as NULL until
after the "already set" check, so jumping to unlock skipped the notificatio=
n.
Now prev is sampled from mux->src without adapter->cgu_synce_lock before the
check, and __ice_dpll_rclk_mux_ntf() runs unconditionally on the early error
exit.  If another PF updates mux->src concurrently in
ice_dpll_rclk_src_init() or ice_dpll_rclk_src_fini(), the failed no-op call
sees mux->src !=3D prev and emits spurious change notifications.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126203231.9346=
32-1-ivecera@redhat.com?part=3D14
