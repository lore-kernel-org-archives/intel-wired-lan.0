Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A706606A32C
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jEWWYPaG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faB6FTxT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38482606DE;
	Wed,  4 Nov 2026 14:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k5sE4V8_glC0; Wed,  4 Nov 2026 14:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 421C6606CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793803234;
	b=Fx8eN/m0kCmSVLsAcZRQx5XZwyx4U7iyu2YrWUIoxuPEPoUvVTlx4pbz4YkP44PZnZ65
	 7J0dBQsExt574in3gMJJJ1K2vVjYmLcYkt0bRCcW2BhTExUYQVYgb3CSU6EDb7RQ5XhZT
	 qkRpbB307z38loSMiJfi80pGZxwBsLxAsCakdupGbMJ7rVGKHss/SrbOYJNCXDnMlDGya
	 7RGcD+cWlpCMVeW+qwASflVOgLgEVIdJKVnq0qkY6Tdo0W0zIBO5ZzPdshEqirehTeq0s
	 7o+2RbrQVpnOGxlbVrJLsd+JvY6tvZzFs1yIjcb9H++PlPR60hFuA22fmi5+DqWB9Og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793803234;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=0uo8OZ4GCc7zOVdcS+7fHTLobKfAJ3FDI9J6Uc9TXbo=;
	b=KGADgz9RBhnfKuJEcoZ0Cy/BvU2ImFKPhmaC3P5SCiGvkdSXNdAWuhGOf2X/LtwkzLyC
	 oQKUj3hm5Uqsfaubu3N/BI/R/9Es/bhbIkjdtok7PmKuUeevqD+c81BOuPTD7ZiBING/s
	 E8XOIDpBaFbZ3grbIVcYQcbqKJoDgXT1I149A4Tr6vsA14fBxkR9T6y4QPDZf9Pus4Q7V
	 6bA48LA+UMYED6PXmNpvccNZlTqLEEwaLbR7lfGY4YQs8y4a323oYB6oe7AoglEU0eGib
	 mzQUgUg6Ybf/wb+/zYYJ/cV5wSF9+OwTWqxzPK6q0mUld424bszNernwQN7vyBuINxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793803234;
	bh=0uo8OZ4GCc7zOVdcS+7fHTLobKfAJ3FDI9J6Uc9TXbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=jEWWYPaGV/125Y3XIYEnB3mW/7rFNiU3B/+d+x7lpcSnEHS17HrehOeVT6hKRFU9d
	 V7DFKshwGaWm7jFS2JJSZ0tNIS4EAnQWXbXiJ4qp0lPe8AKdfidoVkzlGOkhhNocg+
	 Vo81WupUraQ1FITxm3P4GkiLUhEbtOrU/ZxndQJREKpAthTKRQX2WdIE1xOj8tLYZY
	 E3+YOr5cWdqCyKzNcDZo7AIx8qZZxZ6pl2GAXWL318ndI2oCEQJuiXg7Zu8SQZjHdJ
	 wwJ3CJxB5bz6CnU5WvKC7z3k68nn2YTdT/aoijmfTSNSwHaJoM4QuRP8JEq4zbjSDD
	 /bLsn3mEyLXDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 421C6606CB;
	Wed,  4 Nov 2026 14:40:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92DE632A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78B2540243
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y8_RBoMbVvqN for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 14:40:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 790D340062
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793803230;
 b=V2gQvOgwogj8UAGq2oC+03wzdvYXuEWBl+g62ZNDX/kI3erHdYVM10ZxziozHOj8npzV
 +oxArFhuzKniecjh6IItrb/gAmTlDhSpHt6r3VDfsyGjxvnH2YgbbjEXnb+sLQwZi2NYT
 TBYpxkgwlGisWsbdnfLxBhHCjSic3ud3wlxNF1P8CvIFz1g5ivF44y99j2GgPDpqBg0bu
 LqRsPL8ACbYZMEvH3iCyXopNTm/jXkY6uiXLh8c6P3jCryulCmhnRZlW3pAWPhxhpDaAc
 K6TcRXOZUuXkE7xTU98D/25rbzFqHfD5iSScjOMkdbkgpzXMR4i7ijtgyyN8L1lftwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793803230;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=0uo8OZ4GCc7zOVdcS+7fHTLobKfAJ3FDI9J6Uc9TXbo=;
 b=qiohQeSiVQj6BA9Bh2RfDD79QRuZIkMPOLWN/nolDkwymfUw3KHpEmlKV/7OsRvPEQvh
 HulLv49aJFsmDsFNFI8VWs9ksqzBgWBCSb8uwMB+Wu/mhULfrVgaAF2Hf59gLFLLJha++
 8Z/YR/NA63k2QZ6efg4ZMzCL8XxvpUngl5Xn1ilOEY+bsakIXetQw7dOX6N0WSG2JVteb
 KI2JElD98PmmgQF+eoUvXqnSue9ItWh1UFdU735Pi/dKIVwaAr9Eqo2YQiPt+2D8dLP4x
 2/d/Kx6mwJ0BgLV4joOjs5Lk6WliTxPPsawQBe3Dq7zmzwcA9hFnN13uQQSd6ZBTOFw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=faB6FTxT; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=faB6FTxT
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 790D340062
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 426BB60A58;
 Wed,  4 Nov 2026 14:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E061F000C1;
 Wed,  4 Nov 2026 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793803228;
 bh=0uo8OZ4GCc7zOVdcS+7fHTLobKfAJ3FDI9J6Uc9TXbo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=faB6FTxTma4cuZJUuMCx62pZPZX+E0K24rqMMj6vk1ulASj5OEI99REeR7TfA7ulU
 9IJjMWfuC2/1F4Z3Z95vAX1CxweXuuCIYrUihDNWRxa6NJzORbgIdc9Kr7Aj75wzXo
 i6t2wmvf+SzrEydKdDyfVE+tKV2DmIMwAmrjOlw6cnnyqGZjrzOaOGgWEYIcCfiVjO
 NIsHC743cwoy3+cM2CDeLyYtpPdaKlN3ucU6mTFavW5hruJDmjUQ1XMKQLFitdBEo1
 a42bN18pSOLB2Tys7jA0bVYt87oyS3v4Ex3pMCFJqqmRunaUN992V42MrrVwnbIavl
 OdPXm6JKQ+alA==
Message-ID: <sashiko-outbox-197457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v4 11/15] ice: introduce handling of virtchnl
 LARGE VF opcodes
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261103141646.303620-12-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
 <20261103141646.303620-12-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:40:27 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ice: u8 overflow of num_ring_rx and num_ring_tx in ice_vc_map_q_=
vector_msg()
--

commit cafaf07076ec22c624fc3bc56c70b0e708de5ea9
Author: Brett Creeley <brett.creeley@intel.com>

ice: introduce handling of virtchnl LARGE VF opcodes

This commit adds virtchnl message handlers for VIRTCHNL_OP_ENABLE_QUEUES_V2,
VIRTCHNL_OP_DISABLE_QUEUES_V2, and VIRTCHNL_OP_MAP_QUEUE_VECTOR to support =
VFs
with more than 16 queue pairs, and allowlists the VIRTCHNL_VF_LARGE_NUM_QPA=
IRS
opcodes.

> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/e=
thernet/intel/ice/virt/queues.c
> index 7f2b459dbc836..f87ccf5d370bb 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> @@ -1046,3 +1046,342 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *=
msg)

[ ... ]

> +int ice_vc_map_q_vector_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
> +{
> +	enum virtchnl_status_code v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
> +	struct virtchnl_queue_vector_maps *qv_maps;
> +	struct ice_vsi *vsi;
> +
> +	qv_maps =3D (struct virtchnl_queue_vector_maps *)msg;
> +
> +	if (!ice_vc_validate_qv_maps(vf, qv_maps, msglen))
> +		goto error_param;
> +
> +	vsi =3D ice_get_vf_vsi(vf);
> +	if (!vsi)
> +		goto error_param;
> +
> +	for (int i =3D 0; i < qv_maps->num_qv_maps; i++) {
> +		struct virtchnl_queue_vector *qv_map =3D &qv_maps->qv_maps[i];
> +		struct ice_q_vector *q_vector;
> +		u16 vector_id;
> +		int vsi_q_id;
> +
> +		vsi_q_id =3D qv_map->queue_id;
> +		vector_id =3D qv_map->vector_id;
> +
> +		q_vector =3D vf->vf_ops->get_q_vector(vsi, vector_id);
> +		if (!q_vector)
> +			goto error_param;
> +
> +		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
> +			goto error_param;
> +
> +		/* keep SW state in sync with HW, as ice_cfg_interrupt() does */
> +		if (qv_map->queue_type =3D=3D VIRTCHNL_QUEUE_TYPE_RX) {
> +			struct ice_rx_ring *ring =3D vsi->rx_rings[vsi_q_id];
> +
> +			if (ring->q_vector && ring->q_vector->num_ring_rx)
> +				ring->q_vector->num_ring_rx--;
> +			ring->q_vector =3D q_vector;
> +			q_vector->num_ring_rx++;
> +			q_vector->rx.itr_idx =3D qv_map->itr_idx;
> +			ice_cfg_rxq_interrupt(vsi, vsi_q_id,
> +					      q_vector->vf_reg_idx,
> +					      qv_map->itr_idx);
> +		} else if (qv_map->queue_type =3D=3D VIRTCHNL_QUEUE_TYPE_TX) {
> +			struct ice_tx_ring *ring =3D vsi->tx_rings[vsi_q_id];
> +
> +			if (ring->q_vector && ring->q_vector->num_ring_tx)
> +				ring->q_vector->num_ring_tx--;
> +			ring->q_vector =3D q_vector;
> +			q_vector->num_ring_tx++;

[Severity: Medium]
Can q_vector->num_ring_rx and q_vector->num_ring_tx overflow in
ice_vc_map_q_vector_msg() in drivers/net/ethernet/intel/ice/virt/queues.c?

In drivers/net/ethernet/intel/ice/ice.h, num_ring_rx and num_ring_tx are
defined as u8 (max 255):

struct ice_q_vector {
	...
	u8 num_ring_rx;			/* total number of Rx rings in vector */
	u8 num_ring_tx;			/* total number of Tx rings in vector */

With VIRTCHNL_VF_LARGE_NUM_QPAIRS enabled, a VF can be configured with up to
ICE_MAX_QS_PER_VF (256) queue pairs. If the VF sends a
VIRTCHNL_OP_MAP_QUEUE_VECTOR message mapping all 256 Rx or Tx queues to the
same interrupt vector, incrementing q_vector->num_ring_rx or
q_vector->num_ring_tx 256 times wraps the u8 counter from 255 to 0.

If any of those queues are later remapped to another vector, the check:

	if (ring->q_vector && ring->q_vector->num_ring_rx)
		ring->q_vector->num_ring_rx--;

will see 0 and skip the decrement, leaving the per-vector ring accounting o=
ut
of sync. Should num_ring_rx and num_ring_tx in struct ice_q_vector be widen=
ed
to u16?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103141646.3036=
20-1-przemyslaw.kitszel@intel.com?part=3D11
