Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158060A2600
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3WyGEF7P;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAkLS0HN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44A4D60A8D;
	Wed, 18 Nov 2026 16:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HY5B5_M1QDQ4; Wed, 18 Nov 2026 16:29:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 506FB60A9C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019371;
	b=GbxncwaWqLnh4y3sIDcwz4QyUSH4XXO9+3cbXgEjShwSPrSLvBgtC1yzabhtKHpVLwGd
	 bRoEBYflYqvWJqoTu5izLjgf1u46yne2Hcio0Tzyc9Hy4/Y18DCDyrFPUhc2qbrSUjBAM
	 tfxrECdJc9zqseVTO5oT+kurS508gzUsOA2muUTl3sELQ3NdM9HE6LjD2Gt2bomLcvxBt
	 Ba23n0/Os4L8fUmgyIN2nuxJrLhXPBNYtUL/eNZ3QVEGMfvkoTK3FqVemBbjbfRNizp5Z
	 J7iWUMY4zqj/SvfphSlfdEblEnvqq1b0VZFj3jXjah9LI8CzZBKOZYMWd1JFrGwq5Rg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019371;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=LvA9kx5fDtw5Oxiqn88QYS4l8i5lo4hvjTDg8/iPJYQ=;
	b=I97/Nsc61bkDX/zGFhQZhRPLun8Td2NAgnZvj+j371CoHhOXg6HPwPfC67uLXQrbSO1y
	 iC4J+OyOaG1lyy2+351KjRYOy3nmnHwvCAxqiyOLBscxZthZZVrIQXxHifNFqTwUEcKb0
	 VbrwmU8TqYvrGllsrBn0hk0Cs/NWvnlHWjJb/MMbbiZ0G6VygTpml7XuOWKkbZmGpig3u
	 NzAXd/ssFZpAV/7QzNilrlW0WN+UDVJbNFnr3TJjMa+E2d4idRspCMWjgRFpwPG420ZS6
	 CFI5s3KwtsX8lWLPPVqoOCMOcXHv+G4SUViaVPmeL2e4tGha+ofqJdGsJcyWfzbhI7A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795019371;
	bh=LvA9kx5fDtw5Oxiqn88QYS4l8i5lo4hvjTDg8/iPJYQ=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=3WyGEF7Pr6FYjenddmN7XuuyuXxsR2GoLXkF5xiqPopOke3wmFWOmbya6jtkrD7QW
	 P3VgMuGnM4KHF38T61ke11wQea9/B0/ixorGzYkXv2ZsWrbdL70m86D+5GaTqIRbIQ
	 JdNHgCNck970f5qf/UBJJzj5S0YXoPGvJKG7K4lT39AM9KmiJnr3omV73ogQUzvIVD
	 gSYFgJ0cmsliMDPQORqMNrxBlXGslXtN/FoKwCujkLteln5PfcmEhCcyWq5L/AabWU
	 Wkb6dh/lqcpR6rUCuFS+V67p1UnYNz8LPO+QBfWHHeLI8llK+k6La7h+GsCb6yW8NU
	 fpV3lIXGm0lTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 506FB60A9C;
	Wed, 18 Nov 2026 16:29:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8150F977
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72AB540926
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X7LKyi7JR_A8 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 16:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8423E4050E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CAkLS0HN
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8423E4050E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81B3A43599;
 Wed, 18 Nov 2026 16:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478421F000C4;
 Wed, 18 Nov 2026 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795019367;
 bh=LvA9kx5fDtw5Oxiqn88QYS4l8i5lo4hvjTDg8/iPJYQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=CAkLS0HNHsCV5k4gRWgr0g1o352J38RdrBOh4m3w/uCujuo1hD49l2rc5sEV0aUap
 2+wRxDpX4JnEo9xdcDlxU21muEQSJCnGvbV80T9hFlRbugWYazY/AIQHm8GUuO6AUL
 Ll1kSVF2OmVrfgmGhGHSEYVY4IVNaISPJPE8moeByA060KtLGYP38IGCyJY6ch+oFY
 +xVBF2yeAz1V1hmNWM+quT0pbQwMZyXjtxmmqSa31gMPbppHi90O4qISJ7E7KKn0Ta
 hTUFVa8S67EPdhe9Psn46wm0p/W4osY4Kr1Z1a9888729pAGaRzAjy7omDEGX4mkcN
 ppbtj5NzKmPNw==
Message-ID: <sashiko-outbox-221490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 12/15] idpf: psp: add support for psp tx key
 deletion
To: "Stan Iliev" <stani@google.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261117145522.1910636-13-stani@google.com>
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-13-stani@google.com>
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] idpf: psp: race on keys_lost in idpf_psp_recv_late_reply() on
  timeout
--

commit 4b0d48dccce789bdff76728f6f4499fe7e727901
Author: Stan Iliev <stani@google.com>

idpf: psp: add support for psp tx key deletion

This commit adds virtchnl definitions and driver support for queueing and
sending VIRTCHNL2_OP_PSP_DELETE_KEYS requests to delete PSP TX keys from
the SADB, including retry and late-reply accounting.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/driver=
s/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
> index d36f46a46cfd7..42a7d74db2328 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
> @@ -402,24 +402,197 @@ int idpf_send_get_psp_global_stats(struct idpf_ada=
pter *adapter,
>  	return err;
>  }
> =20
> +/**
> + * idpf_psp_delete_done - Release the TX keys of a deletion request
> + * @adapter: Driver specific private structure
> + * @batch: TX keys of the request
> + * @removed: number of SA indexes the CP deleted
> + * @lost: number of SA indexes that couldn't be deleted
> + */
> +static void idpf_psp_delete_done(struct idpf_adapter *adapter,
> +				 struct list_head *batch, u32 removed,
> +				 u32 lost)
> +{
> +	struct idpf_psp_tx_key *key, *tmp;
> +
> +	atomic_add(removed, &adapter->psp.keys_removed);
> +	if (lost) {
> +		atomic_add(lost, &adapter->psp.keys_lost);
> +		net_warn_ratelimited("%s: %u SA indexes couldn't be deleted\n",
> +				     __func__, lost);
> +	}

[ ... ]

> +	case -ETIMEDOUT:
> +		break;
> +	default:
> +		goto requeue;
> +	}
> +
> +	/* The request timed out, or failed again on its own */
> +	idpf_psp_delete_done(adapter, &batch, 0, num_keys);
> +
> +	return more;

[ ... ]

>  void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
>  			      const struct libie_ctlq_msg *ctlq_msg)
>  {
>  	const struct kvec *buff =3D &ctlq_msg->recv_mem;
> +	const struct virtchnl2_psp_delete_keys_response *del_resp;
> +	u32 deleted;
> =20
>  	switch (ctlq_msg->chnl_opcode) {
>  	case VIRTCHNL2_OP_PSP_ALLOCATE_KEYS:
>  		if (buff->iov_base)
>  			memzero_explicit(buff->iov_base, buff->iov_len);
>  		break;
> +	case VIRTCHNL2_OP_PSP_DELETE_KEYS:
> +		del_resp =3D buff->iov_base;
> +		if (!idpf_is_psp_ena(adapter) || ctlq_msg->chnl_retval ||
> +		    !del_resp || buff->iov_len < sizeof(*del_resp))
> +			break;
> +
> +		/* Only the SA indexes counted as lost since the last core
> +		 * init, the counters were reset by a reset meanwhile
> +		 */
> +		deleted =3D min_t(u32, le32_to_cpu(del_resp->num_sa_indexes_deleted),
> +				max(atomic_read(&adapter->psp.keys_lost), 0));
> +		atomic_sub(deleted, &adapter->psp.keys_lost);
> +		atomic_add(deleted, &adapter->psp.keys_removed);
> +		break;

[Severity: Medium]
Can idpf_psp_recv_late_reply() read adapter->psp.keys_lost before
idpf_send_delete_psp_keys() adds the timed-out request's keys to it?

When wait_for_completion_timeout() expires in libie_ctlq_xn_send(), it marks
the transaction LIBIE_CTLQ_XN_IDLE and drops xn->xn_lock before returning
-ETIMEDOUT to idpf_send_delete_psp_keys():

CPU0                                  CPU1 (adapter->mbx_wq)
idpf_send_delete_psp_keys()
  idpf_send_mb_msg_kfree()
    ...
      libie_ctlq_xn_send()
        spin_lock(&xn->xn_lock)
        xn->state =3D LIBIE_CTLQ_XN_IDLE
        spin_unlock(&xn->xn_lock)
                                      idpf_mbx_task()
                                        ...
                                          idpf_psp_recv_late_reply()
                                            atomic_read(&psp->keys_lost)
                                              --> 0, clamps deleted to 0
  idpf_psp_delete_done()
    atomic_add(lost, &psp->keys_lost)

Because idpf_psp_recv_late_reply() clamps deleted to keys_lost before
idpf_psp_delete_done() adds num_keys, the deleted SA indexes are ignored by
the late reply and remain permanently counted in keys_lost instead of
keys_removed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117145522.1910=
636-1-stani@google.com?part=3D12
