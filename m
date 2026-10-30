Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A91606A31E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xCs4ogLO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecAWO65x
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA40E40A74;
	Fri, 30 Oct 2026 04:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jF3cOKGTzaST; Fri, 30 Oct 2026 04:54:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A40DE40AA1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336050;
	b=OEt3PGyeWihZ69Ef0qiqUHYf8cRtqapYhXt8Wfp5GuZIm/2uLfPBEuCA4nUH0KIHg7b+
	 fug2LW964IJ6n3hbXPLKjuEgX90OZkpOFBrilGMcX7SQChMo/S5xsSII6vJF8g/uwO4MQ
	 ab/qHc7QORRxe9MeR1oEsG/SrsFhk6haajlfl3LAzRSYiI5VnMt32QbwbaH/OXmCoxXLM
	 7g8VIMpf22YleSwDwJAdo7B62Q5BBv2Kn4Z7Ti9grF0XcJiGbKIC4pH/jKS5Ws4eCQq1+
	 p2/vQmJ1rDh8sNpb6fogK5Ua/g59Yy60SKuX7/SfCo0VoBqOGtnEZCDQH8Z+80a3O3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=WZUqRIwrWV03ww6mCmoTaLg7G36LVvV1oA7ZJfK8ASY=;
	b=WOqN5W61efSXEnReZIm3Imt3dbT+/a1H8AWs6k9k/No81SeaO2iAJsURv/GcY0KqO07B
	 ilmqmkhvRpW85sHeo2A1cIy1oP+jYOpnb00chflcPc5toJZsKdExnqoJxOdyCk3J50vTC
	 8XaJqRg0YTXu2n505WBOmda+S7IqhtZutaL1/kSPxTfHWjSEB88BMszJ3f3+CYJL2U+n8
	 Z5YHicw36nZ/PFtc6D5lHbVpZCZysussZbU0PslMG7jN/4CQsY78YG7TlvRTgSInXvBG6
	 PHzCb2er0K1v4Q0iTBvz6Qy5be6nNnERiXAsVtmeJq/u4LakGRk7fidKqP1lqGI0ZnA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336050;
	bh=WZUqRIwrWV03ww6mCmoTaLg7G36LVvV1oA7ZJfK8ASY=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xCs4ogLOy+RJVV/3dwotdyOUryxNKZa3N6dV9xQdnjlAVC8Adz6XpaCEm9bVhQ51I
	 YyxENubIp6vQhLz8FW9K2AjezRyN0vxeYHZRwgb85iGFLBPiz0NuavKNH1vG93jwB2
	 uKUpVdVwWIRDIaBXLo4+LoCcQ5e/QHroggolHwmAIoEhyupICnIrcCbjf5ES8SQb7J
	 Kagj1rgM2ksPZ+EN5GXLjaQoEwxtjGlOP060kofVnahYX1gqECMOb7EKuKS8ODWMAA
	 BRtrijbBqBjeT7dd2So845AdFaqNK7iw1Pj8DGe9PyDWyiDjrtT1QLzq6h8rdpGXdQ
	 bkX9zYSPEwNmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A40DE40AA1;
	Fri, 30 Oct 2026 04:54:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41E7AD38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F395810A8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XpREfl8aOzl4 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:54:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20F2A810B8
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336046;
 b=bP5rH//VRi0dj3j+f3KjIUFelsSACmHmFRcokW1lsB08VrzXYpOscvN0O1Phpvakf+oQ
 U4jk5nh0SiG7A8IO4nxvb+m3KzJ6D3UnbY73ZhFpBb7CvW38kQpkkBaXaciU3CZ0L1USD
 PCdOBNVO4y73evz04SKYj5ooDxgEskvHNvtzp9qpYjukqFZv61TZXNQJ6KO3oc18WSfMG
 sWSs5+Ev3I0e6Ejg01yTGVU7zs4n9ltTDa2iKAuWKCWuvYwOrIKE3f5LbWWLFQrCn5/w1
 eoFpBkT3qloamY2oyyLDDvio27Rhj5E/D2Z+h8PUMIiQOEbutqR97mkcaz9v6EYk3SQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336046;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=WZUqRIwrWV03ww6mCmoTaLg7G36LVvV1oA7ZJfK8ASY=;
 b=l2aVqV8PDAAhW7SuGhc6F1mM7ZuNXYgDw1xoLzxiux4MwX+A5jWN/Gi8A34w43V0ROFz
 BQVPv2s84EkHnhfb4EhIzeEp4z3/Aj2tNYhCelERoyYhfgc7vu9Ys0GP9PqrY9CTGgXwf
 LOo6RQwMJ1cXW5eEUdDFObM1Lk+AxYR9hWEWHiA8IrrM6Rvy8IJcg4L8PsBcI4wScvbhM
 Bnx+JOqn6CLVbfooCg8SHuXmIEbnksrdFYh8nfy0d9gyTSK+z+4FKerkD4ZyZMTo0vMBO
 SoaEzp14nwbbwByCmBVFAIqQyIYf1/TRHwYVX/n9Y2qORrd0LdsAr5KJFm44n4BoZjg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ecAWO65x; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ecAWO65x
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20F2A810B8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D830A60267;
 Fri, 30 Oct 2026 04:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6619E1F0093A;
 Fri, 30 Oct 2026 04:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336044;
 bh=WZUqRIwrWV03ww6mCmoTaLg7G36LVvV1oA7ZJfK8ASY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ecAWO65xSqaOmUOJm7wwdpmUdEj/wCwxMGf3L1PFyzc2VjXjPmJ85w7j3NNmZzkvg
 AWJKUoqPf/dbNTHWapNNCLL/3lum2pQegsxVRRs1Fr1b6kmrJ8WDcvsi6EtGy6vtuk
 uMaUhSJt1Dz1KGgMxuKgpKN/TCoOqsPS/AAEFDaxpKm3rQrhphLfSMraZbxmSPa8bc
 zHQQp3Mi2DdFBOaj5rwL6nesAxxbapJ6M+5V9pF60LIH6Fn5FfxfeiLRIPh8CRNQtl
 2smIT/U4jLMYbgYjtE7rsH9mL91HmDnAElmeSOiHMf1Xi3pfmN1ao24MAIYgkWsUqj
 vTLCrs9STSZYQ==
Message-ID: <sashiko-outbox-190399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 net-next 5/9] octeontx2-af: npc: cn20k: add subbank
 search order control
To: "Ratheesh Kannoth" <rkannoth@marvell.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org
In-Reply-To: <20260508034912.4082520-6-rkannoth@marvell.com>
References: <20260508034912.4082520-6-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:04 +0000
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing xa_erase() during search order update causes stale duplica=
te entries in tracking xarrays.
- [High] Missing error rollback in npc_cn20k_search_order_set() leaves inte=
rnal allocator structures in a permanently corrupted state.
- [Low] Format string mismatch in rvu_af_dl_npc_srch_order_validate() cause=
s potentially garbled logs.
--

commit 360483b7660f8774a4adf83ec93cc5565c7337b4
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2-af: npc: cn20k: add subbank search order control

This commit adds a runtime parameter srch_order to control the search
order of MCAM subbanks during allocation in the octeontx2 driver. It
allows configuring the priority of the 32 subbanks for the CN20K NPC.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index e9aad0ad3fa68..6f8f42234b068 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
[ ... ]
> @@ -3906,6 +3906,56 @@ static void npc_unlock_all_subbank(void)
>  		mutex_unlock(&npc_priv.sb[i].lock);
>  }
> =20
> +int npc_cn20k_search_order_set(struct rvu *rvu,
> +			       u64 narr[MAX_NUM_SUB_BANKS], int cnt)
> +{
> +	struct npc_mcam *mcam =3D &rvu->hw->mcam;
> +	struct npc_subbank *sb;
> +	struct xarray *xa;
> +	int sb_idx, rc;
> +
> +	if (cnt !=3D npc_priv.num_subbanks) {
> +		dev_err(rvu->dev, "Number of entries(%u) !=3D %u\n",
> +			cnt, npc_priv.num_subbanks);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&mcam->lock);
> +	npc_lock_all_subbank();
> +	restrict_valid =3D false;
> +
> +	for (sb_idx =3D 0; sb_idx < cnt; sb_idx++) {
> +		sb =3D &npc_priv.sb[sb_idx];
> +
> +		xa =3D &npc_priv.xa_sb_free;
> +		if (sb->flags & NPC_SUBBANK_FLAG_USED)
> +			xa =3D &npc_priv.xa_sb_used;
> +
> +		sb->arr_idx =3D narr[sb_idx];
> +
> +		rc =3D xa_err(xa_store(xa, sb->arr_idx,
> +				     xa_mk_value(sb_idx), GFP_KERNEL));

If the new index assignment swaps indices between a free subbank and a used
subbank, is the old index in the original xarray ever overwritten?

Since xa_erase() is not called on the old arr_idx, this might leave the
subbank mapped at both its old and new arr_idx if they don't overwrite each
other.

Can this result in stale duplicate entries?

> +		if (rc)
> +			goto fail;

If xa_store() fails (for example, due to -ENOMEM from GFP_KERNEL) and retur=
ns
an error, the code jumps to the fail label. Are the successful modifications
made to previously processed subbanks rolled back?

If not, could this leave the system in a torn state where restrict_valid is
false, and some subbanks have updated indices while others keep their old
ones?

> +	}
> +
> +	for (int i =3D 0; i < cnt; i++)
> +		subbank_srch_order[i] =3D (u32)narr[i];
> +
> +fail:
> +	npc_unlock_all_subbank();
> +	mutex_unlock(&mcam->lock);
> +
> +	return rc;
> +}
[ ... ]
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/dr=
ivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> index a42404e6db7cc..aa3ecab5ebd88 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
[ ... ]
> @@ -1619,12 +1620,83 @@ static int rvu_devlink_eswitch_mode_set(struct de=
vlink *devlink, u16 mode,
[ ... ]
> +static int rvu_af_dl_npc_srch_order_validate(struct devlink *devlink, u3=
2 id,
> +					     union devlink_param_value *val,
> +					     struct netlink_ext_ack *extack)
> +{
> +	struct rvu_devlink *rvu_dl =3D devlink_priv(devlink);
> +	struct rvu *rvu =3D rvu_dl->rvu;
> +	bool restricted_order;
> +	unsigned long w =3D 0;
> +	u64 *arr;
> +	u32 sz;
> +
> +	npc_cn20k_search_order_get(&restricted_order, &sz);
> +	if (sz !=3D val->u64arr.size) {
> +		dev_err(rvu->dev,
> +			"Wrong size %llu, should be %u\n",
> +			val->u64arr.size, sz);

The size field in devlink array values is a 32-bit unsigned integer (u32),
but the error message uses the %llu format specifier.

On some architectures, could this cause printk to consume 8 bytes from the
arguments and read garbage from adjacent memory?

> +		return -EINVAL;
> +	}
> +
> +	arr =3D val->u64arr.val;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508034912.4082=
520-1-rkannoth@marvell.com?part=3D5
