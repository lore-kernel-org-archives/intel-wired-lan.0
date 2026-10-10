Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5ACCA6004
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 12:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA8E440961;
	Sat, 10 Oct 2026 12:16:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yk-ysCoDGNpT; Sat, 10 Oct 2026 12:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C9A4B4094B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634571;
	b=ELw/m1iKXJm0R9OpKAD7GjXKN24GbxOiUmfNiXoVXxQEWy8PHnbAUOkFOFZmoTl04iyI
	 OMHkC6wxyUQTsj8fDVXPbgex/5UKYBiWsCIHNZBgdvXv1tr/omzzm8OmHSyO0K2JKcJKV
	 uHKeQUMGSgDfjyyEwRyTgD1eTfFJvocrmgkiUT3niKkpnNv02KaMYsqxwUhDGlYB0U+WL
	 Y5DgmuTnkqp89M0mvyoxItMng39JygK/LvHxYg4rqP7+1NJaaydeB6gY0RztnhqyJ2The
	 s61VJcUQaiR6vmtMuKGEDoG/DvIT1lIT5IQum52/xY+fxXv5W/PvoaJoRkoAdNzgZqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=bBxZWR35Q0rpE/skTTmU83/LOnq8avc2U3LHbppXbOI=;
	b=fTkdJLoZzFz/sxzzIRLBuLkD+DKkQSZ5jrKFuAK9eTWVW3sjW4erDoZoolX19lbzZZ0X
	 8tVOb00XfZFI8HMVXXE/jw/E0yagkKu/QAGR+mSEwK7GNG64qFeuI1HQO/KjAfjq/wZsE
	 lc+Wa6LzrdOMdIEE+JsKU+0gxTRJSup9IKmjb2DBRlVZoGGpPgYCPtunzYlig+cgE0fUB
	 oWnPR/10OaXP+QDlgkH0bVpdWZ7GjWbqmAlkIIacznydUwMvE2/tcNmO/uAogEwA0vVxb
	 j4GY9+kTiFXPvqTRStAdmImfjf+ak95bncsb74BrcVWip5UOUPNmIm8fjXlp3R3JVWg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791634571;
	bh=bBxZWR35Q0rpE/skTTmU83/LOnq8avc2U3LHbppXbOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=5NvoQwDsT21jHHhILwVE2Szx6jAGA7r9yBIbZPAapYIjBEG2sP5t6cn9N2xmE7fOr
	 /JXAEMnisoYrqWzUEeLVmDq6MvZ8dnSsAP2kxEgpVXcNiNv8Dh198OMn8qvTTLRGcJ
	 5QU4b0VPzYfx9bG1BeJO1he7rhZhSlqFAsxJXn4Kj61xFIUCDyHxegt7G+wROAtwmW
	 Ef59QZOfxPV3R42OxmSGGYdpUgLLdkKbs29e1x8RnJAOwI8jJTlEGuF1L3nUzkMb9H
	 O2DPhF//U21tFyf8H7QSe3eZfj+/qNKuSepecmF7O7omndTr4WB62Xp5l7zs+Ce5E/
	 E6KWAiPPc7JxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9A4B4094B;
	Sat, 10 Oct 2026 12:16:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6615822B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CAF54017B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W9QpSpPhUvdz for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 30D594010A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634569;
 b=KztMfUtjh5pMcXCwCocoWaH1W2Hp+P/FvMe+DEY1/DxpIacSXaUz+Ue/bSYTuWgjXZnn
 S2/LRssP2lS8oPT9M3lyc7e/0PoqXkfWryCvNqyaSMk95MTxltwqBgab+grkn+VpXZiiT
 KGTN/Z+cT3czBDq+I6Qke9NKHQrZjcUhAD72SVR/Bw0cZ5sW4qE4t9PdzzfcfRIUQ9O5s
 yNxkuVffch6M7gY9bhOl2YEd3E50oFKpAcq8JDiRUHs7Ygn792u93KA3JcuDbr0E5NyZe
 ewkPN4bhTMNgF5JMakJLyXnlxnVuII+lUH4YYNzi5oar/8gldo13mFGGSwNAWv4wYdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634569;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=bBxZWR35Q0rpE/skTTmU83/LOnq8avc2U3LHbppXbOI=;
 b=Y/DYqVrz4gi86BT+bIJu6sdwxXdEy4KAYhiroE2Fy3GxFtfewQ3U5GEYWBmC9bxyxyKq
 sUQFJ5YoliGzlTBcTrKz9R3a7X1Fb1jfz8TwMNA06g4WQ0ghLGXJ3WwRhi1bB2eGUmhfm
 7xSKPbLCBly5mMJp1OY0bgwW45/ptNMAy6X/n2M095UGP6SY0/0KU6Kz5TcMooWxn/59D
 c6tpd35Rvd48B9MC50sqB7zfpxFZINDPLOp1lKL/vjyWEBUPb6V7ulioJgF+4SfHvsBSQ
 biEo14C1bZjBjSTNB23b+rffIXALbhOxX3mUAinsjaCsvdFsqv4behBqX91QUjCIb2Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gyre7NVg; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gyre7NVg
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30D594010A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B286A401C2;
 Sat, 10 Oct 2026 12:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5CB1F000FF;
 Sat, 10 Oct 2026 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791634568;
 bh=bBxZWR35Q0rpE/skTTmU83/LOnq8avc2U3LHbppXbOI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gyre7NVgUzMmaV0jPrfwi6BSkdZAOqQ3qft2DS0YERFFf95AVN9BkqFuScpK4yHE+
 B89yJyDjOjCZzfVJztQrKRd0O6n7Q2MUxYDAH92G7rek+YbvfsMbPYfcw21JLBMq05
 ObbCnOCq6gNAKke6TFEk6Hixe4ZcDBzsku0Z6atBtoclC54iFcXoXxtuIlQrhexUMy
 AejvjWpDZsU1OI8Z08CIJxEPgCZuUykTWfasyrc94c0yVq+LggMwuDA9OaBcXBZfN1
 hO6SVa0wEjhfwtkGUlKo8dELLODh5uTJXUmuBiTkVJBo3StzAnyxoAl8HsBGBEq6Px
 3p1g5cIPrvANg==
Message-ID: <sashiko-outbox-166508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 13/14] ice: represent RSS LUTs as devlink
 resources
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009121433.30347-14-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-14-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:16:07 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] ice: Out-of-bounds array access on fixed-size devlink resource=
 tracking arrays
- [High] ice: Multi-NAC E825C device probe failure due to shared devlink re=
source collision
- [High] ice: Build error due to undefined macro/function `kzalloc_obj()`
- [High] ice: Data race and potential use-after-free in `ice_vsi_decfg` due=
 to unlocked VSI RSS state modification
- [Medium] ice: VSI rebuilds silently revert Devlink Global LUT configurati=
on to defaults
- [Low] ice: Missing fallback return statements after `scoped_guard` blocks=
 cause -Wreturn-type build errors
--

commit 1692bc7b621e54d0bc3517380fe13e034d0d404f
Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: ice: represent RSS LUTs as devlink resources

This commit introduces VSI, GLOBAL, and PF RSS LUTs for the E800 family,
exposing them as devlink resources. It enables the PF to switch between PF
LUT and GLOBAL LUT and allows configuration sizing through devlink.

> diff --git a/drivers/net/ethernet/intel/ice/devlink/resource.c b/drivers/=
net/ethernet/intel/ice/devlink/resource.c
> new file mode 100644
> index 0000000000000..09672da3ad393
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/devlink/resource.c
> @@ -0,0 +1,527 @@

[ ... ]

> +static int ice_devl_res_take(struct ice_pf *pf,
> +			     enum ice_devl_resource_id res_id, int slot,
> +			     void *owner)
> +{
> +	struct ice_devl_resource *res =3D &pf->adapter->resources[res_id];
> +	int beg, end, new_id =3D ICE_ANY_SLOT;
> +	u16 lut_id;
> +
> +	if (res_id =3D=3D ICE_RSS_LUT_GLOBAL) {

[ ... ]

> +	end =3D slot =3D=3D ICE_ANY_SLOT ? res->max_size : slot + 1;
> +	beg =3D slot =3D=3D ICE_ANY_SLOT ? 0 : slot;
> +	for (int id =3D beg; id < end; id++) {
> +		if (!res->owner[id]) {
> +			new_id =3D id;
> +			break;
> +		}
> +	}
> +	if (new_id =3D=3D ICE_ANY_SLOT) {
> +		if (WARN_ON(res_id =3D=3D ICE_RSS_LUT_GLOBAL))
> +			ice_free_rss_global_lut(&pf->hw, lut_id);
> +
> +		return -ENOSPC;
> +	}
> +
> +	res->owner[new_id] =3D owner;
> +	res->pf_id[new_id] =3D pf->hw.logical_pf_id;

[Severity: Critical]
Could this lead to an out-of-bounds access? The res->owner and res->pf_id
arrays are sized ICE_MAX_DEVL_RESOURCE_UNITS (16 elements). If the firmware
provides a lut_id >=3D 16, or an adapter has more than 16 physical function=
s,
it seems we might read and write outside the array boundaries.

> +	return new_id;
> +}

[ ... ]

> +static u64 ice_rss_lut_pf_occ_get_global(void *priv)
> +{
> +	struct ice_adapter *adapter;
> +	struct ice_pf *pf =3D priv;
> +
> +	adapter =3D pf->adapter;
> +	scoped_guard(ice_adapter_devl, adapter)
> +		return ice_is_devl_res_owned_by(adapter, ICE_RSS_LUT_GLOBAL, pf);
> +}

[Severity: Low]
Is there a missing return statement here? The scoped_guard() block is
implemented as a loop, and compilers (like older GCCs) may not statically
prove it executes exactly once. This might cause a -Werror=3Dreturn-type
warning.

[ ... ]

> +int ice_take_rss_lut_pf(struct ice_pf *pf)
> +{
> +	int ret, pf_id =3D pf->hw.logical_pf_id;
> +
> +	scoped_guard(ice_adapter_devl, pf->adapter) {
> +		ret =3D ice_devl_res_take(pf, ICE_RSS_LUT_PF, pf_id, pf);
> +		if (ret >=3D 0)
> +			return 0;
> +
> +		return ret;
> +	}
> +}

[Severity: High]
Could this cause a collision on multi-NAC devices like the E825C? These
devices share a single ice_adapter and devlink instance. Since
logical_pf_id resets per NAC (e.g. the first PF of the second NAC also has
logical_pf_id =3D=3D 0), ice_devl_res_take() might find res->owner[0] alrea=
dy
taken by the first NAC and return -ENOSPC.

[Severity: Low]
Additionally, is there a missing return statement after the scoped_guard()
block here as well, similar to the warning in ice_rss_lut_pf_occ_get_global?

[ ... ]

> +void ice_devl_whole_dev_resources_register(const struct ice_hw *hw,
> +					   struct ice_adapter *adapter)
> +{
> +	struct devlink *devlink =3D adapter->devlink;
> +	int pf_lut_cnt =3D hw->dev_caps.num_funcs;
> +
> +	devl_assert_locked(devlink);
> +
> +	adapter->resources[ICE_RSS_LUT_GLOBAL] =3D (struct ice_devl_resource) {
> +		.name =3D "lut_512",
> +		.parent_id =3D ICE_RSS_LUT_BOTH,
> +		.max_size =3D ICE_NUM_GLOBAL_LUTS,
> +		.get =3D ice_rss_lut_whole_dev_occ_get_global,
> +		.set =3D ice_devl_resource_deny_occ_set,
> +	};
> +	adapter->resources[ICE_RSS_LUT_PF] =3D (struct ice_devl_resource) {
> +		.name =3D "lut_2048",
> +		.parent_id =3D ICE_RSS_LUT_BOTH,
> +		.max_size =3D pf_lut_cnt,

[Severity: High]
Since pf_lut_cnt is based on the first initializing NAC's function count,
does this fail to account for the total PFs across the entire adapter for
multi-NAC devices?

> +		.get =3D ice_rss_lut_whole_dev_occ_get_pf,
> +		.set =3D ice_devl_resource_deny_occ_set,
> +	};

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ether=
net/intel/ice/ice_lib.c
> index f81b310a98c3e..ad43d52ea83cb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c

[ ... ]

> @@ -1306,6 +1311,32 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx=
 *ctxt, struct ice_vsi *vsi)
>  		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hash_type);
>  }
> =20
> +int ice_vsi_update_rss_lut(struct ice_vsi *vsi, enum ice_lut_type lut_ty=
pe,
> +			   u8 global_lut_id)
> +{
> +	struct ice_vsi_ctx *ctx;
> +	int err;
> +
> +	ctx =3D kzalloc_obj(*ctx);

[Severity: High]
Is kzalloc_obj() defined? It looks like this might cause a compilation
failure because it's not a standard kernel macro or declared in this series.

> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->info.valid_sections =3D cpu_to_le16(ICE_AQ_VSI_PROP_Q_OPT_VALID);

[ ... ]

> @@ -2427,6 +2464,18 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
> =20
>  	vsi->vsw =3D pf->first_sw;
> =20
> +	if (vsi->flags & ICE_VSI_FLAG_INIT) {
> +		scoped_guard(mutex, &pf->rss_lut_lock) {
> +			u16 lut_size =3D vsi->rss_table_size;
> +
> +			ice_vsi_set_dflt_rss_params(vsi);

[Severity: Medium]
Will this unconditionally hardcode the PF LUT type and silently discard the
user's active devlink Global LUT configuration during VSI rebuilds?

> +			if (vsi->rss_table_size !=3D lut_size) {
> +				devm_kfree(dev, vsi->rss_lut_user);
> +				vsi->rss_lut_user =3D NULL;
> +			}
> +		}
> +	}

[ ... ]

> @@ -2634,15 +2694,16 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
>  	ice_vsi_put_qs(vsi);
>  	ice_vsi_free_arrays(vsi);
> =20
> -	/* SR-IOV determines needed MSIX resources all at once instead of per
> -	 * VSI since when VFs are spawned we know how many VFs there are and how
> -	 * many interrupts each VF needs. SR-IOV MSIX resources are also
> -	 * cleared in the same manner.
> -	 */
> -
> -	if (vsi->type =3D=3D ICE_VSI_VF &&
> -	    vsi->agg_node && vsi->agg_node->valid)
> -		vsi->agg_node->num_vsis--;
> +	if (vsi->flags & ICE_VSI_FLAG_INIT) {
> +		if (vsi->type =3D=3D ICE_VSI_PF) {
> +			ice_free_rss_lut_flr(pf);
> +			/* reset restores PF LUT, user LUT has wrong size */
> +			if (vsi->rss_lut_type !=3D ICE_LUT_PF) {
> +				devm_kfree(ice_pf_to_dev(pf), vsi->rss_lut_user);

[Severity: High]
Could this be a data race or use-after-free? We are modifying
vsi->rss_lut_type and freeing vsi->rss_lut_user outside of the
pf->rss_lut_lock mutex. If this runs asynchronously during VSI rebuilds, it
might free vsi->rss_lut_user while another thread (like in
ice_maybe_change_rss_lut() or ice_set_rxfh()) expects the pointer to be
valid.

> +				vsi->rss_lut_user =3D NULL;
> +			}
> +		}
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009121433.3034=
7-1-przemyslaw.kitszel@intel.com?part=3D13
