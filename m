Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF535606A32C
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=NcZ9lRr5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUOA7nYt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8C8F60697;
	Wed,  4 Nov 2026 14:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wyicsla0hWnl; Wed,  4 Nov 2026 14:40:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC5446069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793803232;
	b=UCNoBPqS518hW18GR0roFOq929A2WAPAs0ZcIhXIccTLWcZ8uTzaAy0Fr52KmBgQhJft
	 daNCr65mcK4/iUF7sk7XDtDpN2zxZWPhh4daQ4PPSkhCD/r+E+7gC23hr/FJOgzLFV97x
	 EDmjPHQsL5AjyqQPk83yhYg4f8dp9QJjRTfmhWENfva9tupd7x42scG98Qb5X7NHv+i4B
	 c+idjJpHaq8zBaoVDKCO8DaWjHrwi3m9EbJfxIBcpcoVklgQfe4iCQ/HiyzHPp4Hu9rDJ
	 0N/oxrjxzF+6it2K4msvhIyWHnnLC5yc12Izloo74OAJ0RZj1p83IYysCnBZplACF1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793803232;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=PDVcs8urVBIXmjVwb+u+ltPuuTH8/cKgebFYiht+0Pw=;
	b=VLX+T75GCV65V36H7RSXkjlqtoxqYNaqZBpepAHMBbQlgpvgFEqpleY5OAkqCyRnzm+O
	 u7eYl6coFJ+0FSAuODQiJuQJ4dKwSn35lfu1qGvQS7oAMYBODhUek7l9CAaIQ6PA5PX38
	 kWTU6snDmdp4dz9r1zgBPoMwLDMVpOWRZqkJNF0U1RyZXW+PaCiF4ZL3ox0q4EbPDVUZX
	 FRrNaYJNjrzW8+IXqOlxmyT5zgl4vYOmMoMTHq/cOXz64CV3MU79bzBkpWjuaLLbomv85
	 tjv8PZ55TJDf/OiypPld7lBBRe+AS2xBAJ1FNkGqRGtlBbBxw0YJAfcGaDOfrIhxVEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793803232;
	bh=PDVcs8urVBIXmjVwb+u+ltPuuTH8/cKgebFYiht+0Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NcZ9lRr5E+QXeLsKqIVwDIR1eyVJ4HZEZR9EHBYi5J4Ev6zyz3xZCUlyoh66gimkA
	 EWNG/OxbcmOD8n/9Vkz+/5f0Iz3Y5YRv2aqBoWbLtRBiRqIg2Ld0ncZxUiz3E2k1oj
	 JHR/lhCdx2jdEBDdGexguRgZvhASuYjy5hT6HV1E21hq0ElPEPgmGO99VqImL6f4/5
	 9QNtOHf+n2m824PxxMlW4hG6cdLa4ZZxZxTZyMXDw2EgrA345P/YLyzMsR4Wiy9paS
	 P4p4W6uY2S8jq9GJtg2oqHVt9TOqqgyrz+ygT+vYzhCTDKgRztBpbSz0A+rB341Bjq
	 0zkBD8g+Rd8fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC5446069A;
	Wed,  4 Nov 2026 14:40:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3DFF32A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5B0740243
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HD5jEjL_qUTU for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 14:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EF73140068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793803229;
 b=qIEaO7XUc6Zct26URrLNkAaSONydyP6E8s/H2ip47BSEe3tNhtZWUZ/vELf2yN/6Gpsb
 xXp4+Ia85v/snjRepyIExpiuzmM5sL1HetnGNIU61G7v6wXXRBJsyP37a86Xa6uXwNOV/
 q6kyuZvBKvmP3TFlZxOyt0XcMVPNMcp3Z2njU5f2aqN12wMtebyqai4c6wF7EeIo8EbqB
 Myc1jCcotFv+JT/nt7m1n5/qLzsb7cPdcZAl6PtViacI+ZkIMYepuFeIPCgdahoQ26OX0
 ykmo9lALMiS2SD/iFu4W1znSMKKB3VzbQv9VKa6/YHV0qmRdMKH/rgMQ7I3R5Eqlb8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793803229;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=PDVcs8urVBIXmjVwb+u+ltPuuTH8/cKgebFYiht+0Pw=;
 b=OA+rPZWSoilg8TKu3a/2d4+3j+XzA2qc/Jp1sdLhsueLXScqhFAr07O+wVLzzF2/uWWX
 GBQVvfcMJgYbR0wuYQBI560k/SB5ItaUwpZki+iTAg/6M9RijGgdg2VyI3QrJPAh8tgsF
 ngFyfn6cPskHdoFwErTIf9dTVIWNGL8NkXlUxm5fywVNZqbkB7DkQtkVAvFH8x8myrDoo
 lxGSB5GpmehIGypQHw4cDyPwiKaUa08HeE1uGYOVT3LeU/20oolF5DG11Y1/J8KA926PF
 8lsg7bSDvIW86Qfhpcgxg78ON/ia7jNaeK445ejeUcepA3kOp8zU5IzeLfSWBUzCAxA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iUOA7nYt; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=iUOA7nYt
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF73140068
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C17F443778;
 Wed,  4 Nov 2026 14:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2851F000C1;
 Wed,  4 Nov 2026 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793803226;
 bh=PDVcs8urVBIXmjVwb+u+ltPuuTH8/cKgebFYiht+0Pw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iUOA7nYtrT+m6InyCqW8thtvSac7barSybZH4qexSuqEUO+hj1eibJ48wtfCgcsiR
 7uTGbGy6kDNDR+IbETVhrItK5Pn9XkXxQvgfDz30M5qaVXSfHbCYds8WccGMcguSGP
 W57WB7px3rTeHjd97fPDEjyTxb3v4ayBcQn8HkZzZ01jkOGG+EBGxs2iVsuu6IpFGd
 SjdZ7FeRnkTOOyhOC+kvAh6s6Vj5I0+c+5XSjBKcPHyGkIcyzWj0UxiNuYf/bRh7U7
 T1g8J8bCYKEy08+vxHNsaIE0dC/EPTlCvTe20pn+WvZHlkAaI7Zm8BpJdF/PKvAKzt
 CUwiq7hNjWqLA==
Message-ID: <sashiko-outbox-197452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v4 06/15] ice: bump to 256qs for VF
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261103141646.303620-7-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
 <20261103141646.303620-7-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:40:26 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ice: u8 truncation of 256 VF queues in ice_aq_cfg_lan_txq()
--

commit 371721d1a3832397e9b3c3a095be6c11dcfbdd2d
Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>

ice: bump to 256qs for VF

This commit adjusts bitmaps, arrays, and struct ice_vf::num_req_qs in ice
to accept up to 256 VF queues while keeping the 16-queue limit for legacy
virtchnl opcodes. It also raises the default VF queue count limit and the
VIRTCHNL_OP_REQUEST_QUEUES limit to 256, switching struct ice_lag
allocations to kvzalloc().

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/et=
hernet/intel/ice/ice_vf_lib.h
> index 4959ecee0c21c..a9e95c85bc989 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
> @@ -21,6 +21,7 @@
>  /* VF resource constraints */
>  /* for "old" virtchnl opcodes that accept up to 16 queues */
>  #define ICE_MAX_QS_PER_VF_VCV1	16
> +#define ICE_MAX_QS_PER_VF	256

[Severity: High]
When a VF is allocated 256 queues via ice_set_per_vf_res() or
ice_vc_request_qs_msg(), ice_vsi_cfg_tc_lan() -> ice_cfg_vsi_lan() ->
ice_sched_cfg_vsi() -> ice_alloc_lan_q_ctx() sets
ctx->num_lan_q_entries[0] to 256.

During SR-IOV Active-Backup LAG operations in
drivers/net/ethernet/intel/ice/ice_lag.c, ice_lag_reclaim_vf_tc() and
ice_lag_move_vf_nodes_tc_sync() pass numq =3D ctx->num_lan_q_entries[tc]
(which is 256 whenever the VF is allocated 256 queues and has at least one
valid queue) to ice_aq_cfg_lan_txq(), and ice_lag_move_vf_node_tc() passes
valq (256 when all 256 VF queues are configured) to ice_aq_cfg_lan_txq():

drivers/net/ethernet/intel/ice/ice_lag.c:ice_lag_reclaim_vf_tc() {
	...
	valq =3D ice_lag_qbuf_recfg(hw, qbuf, vsi_num, numq, tc);
	if (!valq) {
		dev_dbg(dev, "No valid queues found for LAG reclaim\n");
		goto reclaim_none;
	}

	if (ice_aq_cfg_lan_txq(hw, qbuf, qbuf_size, numq,
			       src_hw->port_info->lport, hw->port_info->lport,
			       ICE_AQC_Q_CFG_TC_CHNG, NULL)) {
	...
}

However, in drivers/net/ethernet/intel/ice/ice_adminq_cmd.h, the AdminQ
0x0C32 command descriptor struct ice_aqc_cfg_txqs defines num_qs as u8, and
ice_aq_cfg_lan_txq() assigns the u16 num_qs parameter directly to it:

drivers/net/ethernet/intel/ice/ice_common.c:ice_aq_cfg_lan_txq() {
	...
	cmd->cmd_type =3D mode;
	cmd->num_qs =3D num_qs;
	...
}

Doesn't this truncate num_qs from 256 to 0 in cmd->num_qs, causing firmware
queue reconfiguration to fail or misconfigure queues during LAG failover,
reclaim, or reset rebuild?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103141646.3036=
20-1-przemyslaw.kitszel@intel.com?part=3D6
