Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E11606A31B
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Vw/7MX1J;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/F0XP2O
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86B48810E3;
	Sat, 24 Oct 2026 07:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0_tQArhOEZHy; Sat, 24 Oct 2026 07:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFB0C80EBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825440;
	b=Anf+RUsXJ5OKwv09X5L3MAdljHNEYoaYBFdPKnbIlsbd0WhETjc+urCAqCkpaFZpJyPM
	 QN0gotsBju4HTPDnIr2imuOBUk3yIp8kvD/0k+07jiyeTW+ztqkMLeNIltUG1bZZbo6ND
	 3D3g8yX1p0RARsfNk3VEwFxCH9ImSHypFsMftcX+xW0hZwgTXp+8btNgEYSMtxq3aMzX4
	 q0A8ZerUFaqi3f3CKHWsP4fGIczEmWxJenlq4ujeRBmspb4GYyfx3P9DyIh7GCXVPSTJe
	 WyP9hj8OEGSaQonLwcvlOaX5PckUOURnviv6atrIlchevbxkh1yJpz04OTeyoNJbGSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792825440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=2FdeqYZg0t+ii5NnwM8v7ZVFrQHVdVZTti3YtFSfjtk=;
	b=PJcVsy7961WHCKmFqe/0e/iUI9Sw+dgtBczEZY3KSTKLnj7KOE0skNLmbpj5/559HdCc
	 0eudRqSl3WZsJMJN8eWpNlwqiYIesLrt4VYvjKFBMp9oA9Jg+iZ2qq6QkneS5OtKOrLsa
	 lK92HvkriknqUgUffI6kCEP+9vTl8VuZz1KGPVkD67JojtXsSSeqL70D/zvQQp5VPN4IM
	 msVf78bIMorN36WnMTn3OwJ3P+ZZSDEETEL+e32lqYFfwP2LiBzj6n4jxo0FbUWYPNPxr
	 B2M79Mqqq1lQqPqylAaEWqryMiIW5ZoZXzdDKXBcQED5fGFxsrPxpftyMAAHcDLKqrA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792825440;
	bh=2FdeqYZg0t+ii5NnwM8v7ZVFrQHVdVZTti3YtFSfjtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Vw/7MX1JU3b2uad5dMKAyrMi6EM9L3V18YAJERsumEK98Ph5goacvXvW/5OI/DEvp
	 Kcmccbs2eUi3vMSRtwKJ1vY3VgCYHH4e8eE8zZ3nwVo35QmuH8N2MlHibmuAFA5LGM
	 nvMJUugdqf4lwydlyHfma+WnDIFwS06xMebdwPU1JRym//6nhMnSkJt9s5SkG50qb5
	 BXwYF8+jPFPl+ZaYwby7kruFpE+VU1rMXxgD8QwlnR8d5CXUcmLsQiJMvyuCdBz+Ee
	 pXOByhksXsaTObu5cipCCoY/j1UGCqNticiv4DyMoHMtTEuu6ALaJjODtvmg8Dxcue
	 1BpBgPgqsuZtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFB0C80EBA;
	Sat, 24 Oct 2026 07:04:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 202274D1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 07:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1174C6063E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 07:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WHTpeojpVYZl for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 07:03:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 174B760639
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792825438;
 b=Q6E4ViOJPxpeYeJ/6+e1kd3n6++SESv7k1vRT5Yw14m3aNJ2qpVFNqph6dfeQAxt+k9k
 pJ1E89UEhIgtC51vYAemFQdaIP5ufDXwfs5B2ny1KcUbNVoA0HyZOrFFlnSyt016qO4O4
 F8u5weNlerf3/GDBXs9HWLUK4Czx5EEzaFihrGfUJNIokzg3H/Vtnqakf7SbYOwwWz3mi
 71nXJPeOE8aTZs641MXGEFJcNVcXNPmoDRLB1/WNZhSg+NAswJKwbmps0i/aFb0PgA2sb
 0ieVmwjt0/7FK2yb/KrXkZbDqKx6miSlqEQ1wZiHW8UFR/zvzsc+cWobs/EIambIrMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825438;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=2FdeqYZg0t+ii5NnwM8v7ZVFrQHVdVZTti3YtFSfjtk=;
 b=M8zBa8SMDUKUCoQUtcvmVWeBFTdXm04t8LABgL6/aZ0AwdRP73xVj3vnUMTfo96Wbsuv
 bjdeZg3iLvJCzjoekAbp5tFDLg9arv7QbpvViHI2RxtGTFxa+gEbk+m7ybfJO0ouHu5Oe
 BScB3N+X6adBmVcTHMpmUJCwb8Cfl0fAtEApuBYhadXJXEfezAp86CD+eLwH5XEP7Rgkn
 Dx2aPWnKVrfLYFD/9G7zjrvMZPe/m5JX3Z/EQDScXXKxg6Sbzx6RM1pjLZ0/ghUny4McM
 UBJY+GgfkGCViyUZKbNrtF0bmklvbDatGB9YKtqpksPPSnV7HTIRPsxdWTNblZOCE4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="O/F0XP2O"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O/F0XP2O
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 174B760639
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 07:03:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC25943DBE;
 Sat, 24 Oct 2026 07:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F721F01828;
 Sat, 24 Oct 2026 07:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792825436;
 bh=2FdeqYZg0t+ii5NnwM8v7ZVFrQHVdVZTti3YtFSfjtk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O/F0XP2OBz8PlHx4SnKE8Fle2Ln5XX4kiHYoqARouBvRnRM+OuKBUEc1a8rjrF+dt
 irb2gsI/FFu6eylkgB0iIWe6UsDHlPZ3N52/FqS1f+TANdEbnTVFZIpJKsmaI2XAS9
 GvFginHrMCqXt3km2uSnJTf4jpgACer1BLxA/+kM9HPYkf85kPhl7uR39NbXBuodDI
 jiL+hw5v5pQWXzzQQGXHtM1x8do5cs9ACQMXfAicGIkfD7mRkoMU3xkCQXviSuiDzX
 VNNSZxFd6fx76ClMP/Le4e/rgrO90f+j4JkdxF9uTd/yF81kKyPZU5gPr5EHiL8fBE
 VNq3Ni7fW0/Sg==
Message-ID: <sashiko-outbox-183581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v2 5/5] ice: do not block on the aux device lock
 in ndo_setup_tc
To: "Petr Oros" <poros@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261023070258.730168-6-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
 <20261023070258.730168-6-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 07:03:56 +0000
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ice: orphaned channel VSIs and memory leak when ice_setup_tc() fai=
ls teardown
--

commit 58934f25b30092ac8064d34365ba48edb6a32a06
Author: Petr Oros <poros@redhat.com>

ice: do not block on the aux device lock in ndo_setup_tc

This commit replaces device_lock() with device_trylock() on the RDMA
auxiliary device in the TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() to
avoid a lock dependency cycle with the RTNL lock, returning -EBUSY when
the lock is contended.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 9de375f5c4deb..7eb653a7ebacd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9451,7 +9451,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_se=
tup_type type,
>  			mutex_lock(&pf->adev_mutex);
>  			adev =3D cdev->adev;
>  			if (adev) {
> -				device_lock(&adev->dev);
> +				if (!device_trylock(&adev->dev)) {
> +					mutex_unlock(&pf->adev_mutex);
> +					netdev_warn(netdev, "RDMA auxiliary device is busy, qdisc not chang=
ed\n");
> +					err =3D -EBUSY;
> +					goto tc_unlock;
> +				}

[Severity: High]
Can failing with -EBUSY during qdisc removal permanently leak the
struct ice_channel entries on vsi->ch_list and leave channel VSI state
orphaned?

The commit message notes that when the qdisc is deleted,
mqprio_disable_offload() ignores the return value so the hardware traffic
classes and channel VSIs stay in place until a later qdisc teardown gets
through.

However, in net/sched/sch_mqprio.c, mqprio_destroy() calls
mqprio_disable_offload() once while destroying the Qdisc:

net/sched/sch_mqprio.c:mqprio_destroy() {
	...
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

Once mqprio_destroy() finishes, the Qdisc object is freed and no mqprio
Qdisc remains attached to the net_device, so no subsequent teardown call
will happen for it (including on unregister_netdev()).

During driver unload (ice_remove() -> ice_unload() -> ice_deinit() ->
ice_vsi_release_all()), ice_deinit_pf_sw() releases the main VSI without
calling ice_remove_q_channels(), and ice_vsi_release_all() skips
ICE_VSI_CHNL VSIs:

drivers/net/ethernet/intel/ice/ice_main.c:ice_vsi_release_all() {
	...
		if (pf->vsi[i]->type =3D=3D ICE_VSI_CHNL)
			continue;

		err =3D ice_vsi_release(pf->vsi[i]);
	...
}

Moreover, if a user later adds a new offloaded mqprio qdisc (hw !=3D 0) to
attempt another teardown, ice_setup_tc_mqprio_qdisc() only removes existing
channels when disabling offload:

drivers/net/ethernet/intel/ice/ice_main.c:ice_setup_tc_mqprio_qdisc() {
	...
	if (!hw && !test_bit(ICE_FLAG_TC_MQPRIO, pf->flags))
		ice_remove_q_channels(vsi, true);
	...
	if (hw) {
		...
		ret =3D ice_create_q_channels(vsi);
		...
	}
}

Wouldn't adding a new offloaded mqprio qdisc leave the old struct
ice_channel entries on vsi->ch_list, rebuild the main VSI rings, and append
duplicate channels via ice_create_q_channels(), potentially indexing past
vsi->tx_rings[] and vsi->rx_rings[] in ice_remove_q_channels() if the new
qdisc configures fewer queues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023070258.7301=
68-1-poros@redhat.com?part=3D5
