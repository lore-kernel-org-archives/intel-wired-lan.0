Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B76606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Ur6jyc6z;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=haQtiyoH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFF0D40A29;
	Fri, 27 Nov 2026 12:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zf2NNznaB0A5; Fri, 27 Nov 2026 12:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4D9AF40A10
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795782749;
	b=iTtAhZPpqZovBGOY3MBRy47Xrh4omf0pAk/Ax7aoX8JaQWKaqIgJhCQTSUYDgpxXQN4+
	 Y6Wd244tz5TnJ834kxXxUNRZ4jUTioBTNMx9/kJ1HnSEE791oBQtVDV8maRO/mGk8SdT3
	 zlnsmybXFATTGhAlB6bl8lxwnnb130DDTh00JYv5NFkdU2+1U26+2FPEJctMf2s9S/zzI
	 Hbxt98CS8czhNDyIEqPws2L/oQwpOHaChVK+IqJT6/1s9KN3brWZsvYB6LO0ltlS9d8wG
	 UKu+TP6HnJGKStb8belw+nBOa8zKN4tRurtsxsu8tssWVDVvB+WH3rqwrekIyzR8cDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795782749;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=B58tpezfLLuYC1Bi0mrPoaepYpGgbP60ge/4Mxcllxc=;
	b=prByKUtR6AWuWtfnEM1fZo7GoMW7o1XUkqwnTiTd0rryCHdAk6VmQ43O8S0hzYDcpSpC
	 910O7EDTFOJxWuvTxIm4t4WgBJ+B02vna/KPbYYHYBmH11zw3iOFPzRrv64nFZIY2RoOh
	 gXpRuDoad/lygo/5TtjLbfsGNeKSki9NorV+20L3AKViDplj2qyK+gRxTPVBSGXx9Fvcq
	 Dw1wU/o8KHvI+uMTzJ/cJFXGCIDf15v4ngmEGk3PTjNl4HjVBHAsndZZlDSZkiNqq7SUC
	 X4sA0ZAq7pPwStDzq1AK0ac3UCJdj355PKlx6aivt4wThZOb/ZU4cXoJca+48KeU9fw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795782749;
	bh=B58tpezfLLuYC1Bi0mrPoaepYpGgbP60ge/4Mxcllxc=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Ur6jyc6zHbExlUgIUkM3nhTQRjpyFejPsdA6KI8kYTgK9tMrqLPMyReb4Pu5IdcQQ
	 E6/JFuQShp4Y6Hq/2UdhqcV7eUTPsrcGSCAWU0L9y6NXS3ds85EQXrpjm4z//amF7G
	 lcPIOYPMseWnOuP23eHvOlHe9WP+TkVQvPNzMfwFF6u0eIFwVeAT89y1XGdEBH1kBb
	 UBuQS+i2NEYMnmW2Y2J64znnvj4O2j3GU2DgM9WGljSFgpw5RB1y/ifLzapQP2Uhuw
	 M7lwjQcB4BxUmLrqWsf/sl87C7AFkTsbPW6bGnwAVs7LKg43ABvgsWyuKAf2KlRgJ+
	 dbQXIpVh/8xyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D9AF40A10;
	Fri, 27 Nov 2026 12:32:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D139D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 12:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ED0A4004D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 12:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PxzJHTdEDOCt for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 12:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5E0D9401D2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=haQtiyoH
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E0D9401D2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 12:32:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D9164528D;
 Fri, 27 Nov 2026 12:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5EF1F000C1;
 Fri, 27 Nov 2026 12:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795782744;
 bh=B58tpezfLLuYC1Bi0mrPoaepYpGgbP60ge/4Mxcllxc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=haQtiyoHgvgwM72gUTn69Ufx9I8gwts3lnqTlEZ/xhGqH1U9BNJY0rAZKP2fbF5Wc
 nDS4Ek1pTzvfTYjCaXZ3aTJ9lT5nnozrhlvNNMOAgdcnMli9ZAmUherV+5kVMOOYNY
 uEE9BchVZG7Xrs8VRoUB0zUVjV3/sJ/OkREsxf0bfcMrQ29su7kdxrRxMD6zIjPYVF
 4BnY6451DPDpuxtV1YY2UJFWOyEK1n+7nVlUzMjZy1C1F8S5CI3KoapIElpJ26aLmI
 2aB3xLNVOkBcKsbvO0hsYWSiXf3xhrhQUW0Qqn1PqloL/nFYF11+DobQ3gMdcNtrRb
 4dFae+d2X2XOA==
Message-ID: <sashiko-outbox-237409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 2/3] ice: share default RSS hash profiles
 between PFs
To: "Jakub Ramaseuski" <jramaseu@redhat.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261126123114.893916-3-jramaseu@redhat.com>
References: <20261126123114.893916-1-jramaseu@redhat.com>
 <20261126123114.893916-3-jramaseu@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 12:32:24 +0000
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
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] ice: use-after-free in ice_vc_fdir_rem_prof() during PF reset
  [1]
--

commit 48401f6c29b813715dc1bcf787d7992e20c344db
Author: Jakub Ramaseuski <jramaseu@redhat.com>

ice: share default RSS hash profiles between PFs

This commit tracks shared RSS hash profile IDs in struct ice_adapter so
that multiple PFs on the same device can reuse firmware profile IDs for
default RSS configurations without exhausting the device-wide pool.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 7a56f1367b01c..e59c02e50429c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -604,6 +604,9 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_res=
et_req reset_type)
>  		ice_fdir_clear_flow_handles(hw);
>  	/* clear SW filtering DB */
>  	ice_clear_hw_tbls(hw);
> +	/* a CORER, GLOBR or EMPR also clears the profile IDs of the other PFs =
*/
> +	if (reset_type !=3D ICE_RESET_PFR)
> +		ice_flush_shared_profs(hw);
>  	/* disable the VSIs and their queues that are not already DOWN */
>  	set_bit(ICE_VSI_REBUILD_PENDING, ice_get_main_vsi(pf)->state);
>  	ice_pf_dis_all_vsi(pf, false);

[Severity: High]
This problem wasn't introduced by this patch, but can ice_clear_hw_tbls()
here trigger a use-after-free and double free of struct ice_flow_entry in
ice_vc_fdir_rem_prof() during a PF reset [1]?

ice_fdir_clear_flow_handles() clears the PF's cached flow entry handles
before ice_clear_hw_tbls() -> ice_free_flow_profs() frees every profile
and entry in hw->fl_profs[ICE_BLK_FD], but nothing clears the handles
cached by VFs in vf_prof->entry_h:

drivers/net/ethernet/intel/ice/virt/fdir.c:ice_vc_fdir_rem_prof() {
	...
	for (i =3D 0; i < fdir->prof_entry_cnt[flow][tun]; i++)
		if (vf_prof->entry_h[i][tun]) {
			u16 vsi_num =3D ice_get_hw_vsi_num(hw, vf_prof->vsi_h[i]);

			ice_rem_prof_id_flow(hw, ICE_BLK_FD, vsi_num, prof_id);
			ice_flow_rem_entry(hw, ICE_BLK_FD,
					   vf_prof->entry_h[i][tun]);
			vf_prof->entry_h[i][tun] =3D 0;
		}
	...
}

When the reset later runs ice_reset_all_vfs() -> ice_vf_fdir_exit() ->
ice_vc_fdir_rem_prof_all() -> ice_vc_fdir_rem_prof(), those dangling
vf_prof->entry_h pointers are passed to ice_flow_rem_entry(), which
dereferences and frees the struct ice_flow_entry a second time, and the
stale vf_prof->prof_id is passed to ice_flow_rem_prof(), which can remove
a flow profile reallocated during ice_rebuild().

[1] https://sashiko.dev/#/bug/linux-bf11eccc-e91f-476d-9247-5b7368b4b35b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126123114.8939=
16-1-jramaseu@redhat.com?part=3D2
