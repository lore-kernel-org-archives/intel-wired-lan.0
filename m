Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520460A5BE2
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LCbCK1RR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMiLt4CH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EDEC806E1;
	Mon,  2 Nov 2026 11:28:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3b1ICfIzlX2; Mon,  2 Nov 2026 11:28:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92787807A1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793618912;
	b=NVSxSQlW0vPew8x9P9YHyr2ILujidKQEW59pGKHWw+drscS7LpmmRhf1BF8XaE4d02jI
	 oisS0DmyrfzxVVYedmEDN5NP7flydgyx8a4uyQlBothVDDV5ky973Ji8710O/AJKbEatO
	 qWPFCAuqdaDf4pBsPfokLr+nNRr3DaFJbMLkC2auvZIHdunGMgkXIkssipk3NFRZ2nSQj
	 iLCDMBhPitks9GgA7h1xvau8mgKsUG/FsRqODGsKCyUw7qwQy0jv69gJXDWo2HewSnAWF
	 fc/rDS4/bQDhfVFDW+aVUdD34YWbpBQwUsWEdo/ZRLBBFyaGIyFyYMO+dvuqJdIgI4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793618912;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=kq4MNn/y/HblCrUWzjNGZzijsPn2ipH3YFETdsu+vH8=;
	b=TwQLVpN3TqBWE1HZxW6oey+lGV6l7hH+yOPwaj23bkFCecXKPyGu10cZ8TExIOou70wh
	 Zlo+MHpQPcFcPuANvknZ75KAnqnooenIfIztKrAQ2XrHyPN0oHCi1fKgg51OR5rgvx1C1
	 AQoIspCAqwAECLaDvz2F3CuesV/1tk+9m/NaPAkKn8ElN77E7RbRxfOXvFWupt89vUw6R
	 0So1qVMYEUC3r7VKKksIbA1mz76P/5vNBM3/4euQRYv93ERSsZP5DXRczCOOfmwQeTDHo
	 BP/BpFnk6ZNfJZsAXqIfEXAQZpQz4pw3hoasN91ymLUlcSOUzIC5KbP/tOdzsOFNm2Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793618912;
	bh=kq4MNn/y/HblCrUWzjNGZzijsPn2ipH3YFETdsu+vH8=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=LCbCK1RR+4Ny3u39ZjAb4YxDO/zFFSC03+z7YkzLJdBc4XcXzZTLB0jsq2irFUPeL
	 x9Gv6j13q9R7QlEZLnT4BYcEdShUoAZDQ7qbvVuHPMbkDZLyKfERmYeeVU7AgoxJ7/
	 KPRPrgUgQ2U2HLWih1cObA3UD4SnoVq5Gvzm0xMqluTC6whPyjIJgNBcWuBQkBFqdl
	 0pwXmh/trlaSE2jV2YXP+Q+iSr79W8yP/0Zy7zLPOKPXGoUp6wjlh3GgeyE5k9c/Wg
	 qC3rBjJeYZVCoDSnda3QJfgiTnYaljG4cWN0YHT31c/nSCyAZec04oK1DLRcrwyGUI
	 qYYaqeGqd4Mnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92787807A1;
	Mon,  2 Nov 2026 11:28:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE620362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFCD240730
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:28:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2k9ELwqh5_2 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 11:28:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40A8D406CE
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793618909;
 b=B5y4hVEW8jJ72wsQVS7FqfMy7ZnMqqtmNsibpuy4bIpteUQcEHSfNz6K14CmPq01OtJ/
 INFFX+/w0XGDBQlA+Uqdr7tmulLJ8YG2vtmd9oNxV1qCFPZQegZG0jj+aWrvmntozRHYs
 X2mdEbCf0Kpmei7N+jBPqFyvJrO4ORW9bllA+T01+dC2Q+PPmCnG/VUPxCNgFMdab69H4
 fHgIPMwIfok9FqVUIRQs811JIF2zLgpaB7DltsitcCEAHLPeT61gylqWrxK7h1XEHKHLR
 UZjRBmZd1QF5VAiD6Q0G01V89LYPh2hMWNeigpwJ1vM1gIPo3xt/BuP7Bz5JK5ZdNNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793618909;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=kq4MNn/y/HblCrUWzjNGZzijsPn2ipH3YFETdsu+vH8=;
 b=o5xbY6hfwOpBrAt3QLvqUojqCO20/vMvaRrSwE9hFr1moUf8NtTtSNXZrpYn826vEukq
 3x0WQteH3PVYEuvxXTTL9bYD0UboMG9BZtTrQry0wJ5a142+muNTjI3U4l/wwhvsIVwYx
 B69ZSLJNhyndn5nwmdgwA88VFSRcgN9T4u7je+vutu2KGL4owaoaJfhhviPdi0Js4qdNS
 bfjo9+C6exLAFHR1i8zlXfmT+k9Q4dPhL2ACvCACBbPE7Jwh2YMdzq61NCmRwEOtOYjHq
 gwrvjxzmo1HXGE0IIwt+1570l761DBNCusBPPd9aePKW+1a6LVkMyVa0TRUqLOvShKQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cMiLt4CH; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cMiLt4CH
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40A8D406CE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:28:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E94060F4A;
 Mon,  2 Nov 2026 11:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF081F00A21;
 Mon,  2 Nov 2026 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793618907;
 bh=kq4MNn/y/HblCrUWzjNGZzijsPn2ipH3YFETdsu+vH8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=cMiLt4CHnxWBtzxg6y6cAli2hWC/krDXHM4Pa83CxO8A+0YzX+O3zpENMOwG4APiO
 RoKmsV3j/nQqgXq/vzD3k84ZY6LDtqOB1HlmM7JbQ7+ixdx1GW0UWRRTioMu52RRZ2
 9y4aaCEHQqk96+UPyspk/WITSaLFwJHYphEnkKgCSJf+dLCcy86LQGZ2P6fC39GqnL
 L6f9H1TFvcPTyMzOCADkBkqTLOoGWe6CFw/KQOo34dMGl4e7Mu742sFu1ouqJwEV1b
 AoilmoYd6oSnQ6ldNgbKpX5AatJI+FxnPFK1ToXDq+DpFTj6jY2o1nholNZXxTOlXM
 mv1ZH9jrj5Uaw==
Message-ID: <sashiko-outbox-193331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 1/2] idpf: add direct access to discipline the
 main timer
To: "Przemyslaw Korba" <przemyslaw.korba@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261102110717.77800-2-przemyslaw.korba@intel.com>
References: <20261102110717.77800-1-przemyslaw.korba@intel.com>
 <20261102110717.77800-2-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:28:26 +0000
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
- [High] idpf: NULL cmd_sync dereference from overwrite in idpf_ptp_get_cap=
s()
--

commit 89cc323cd92189e1e3d08fc89975837933f93c9d
Author: Przemyslaw Korba <przemyslaw.korba@intel.com>

idpf: add direct access to discipline the main timer

This commit adds support for direct PCI BAR register access to set and adju=
st
the PTP device clock, alongside validating mapped register offsets and
reconciling dependent PTP feature access modes.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/driver=
s/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> index 1422b30d09a31..427b15281ad0d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
[ ... ]
> @@ -90,6 +117,19 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
>  	ptp->dev_clk_regs.cmd_sync =3D
>  		libie_pci_get_mmio_addr(mmio, temp_offset);
> =20
> +	/* Direct access is only usable when every register was mapped. */
> +	void __iomem * const clk_regs[] =3D {
> +		ptp->dev_clk_regs.dev_clk_ns_l,
> +		ptp->dev_clk_regs.dev_clk_ns_h,
> +		ptp->dev_clk_regs.phy_clk_ns_l,
> +		ptp->dev_clk_regs.phy_clk_ns_h,
> +		ptp->dev_clk_regs.cmd_sync,
> +	};
> +
> +	ptp->get_dev_clk_time_access =3D
> +		idpf_ptp_regs_access(ptp, clk_regs, ARRAY_SIZE(clk_regs),
> +				     VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB);
> +
>  cross_tstamp:
>  	access_type =3D ptp->get_cross_tstamp_access;
>  	if (access_type !=3D IDPF_PTP_DIRECT)
> @@ -107,10 +147,23 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
>  	ptp->dev_clk_regs.cmd_sync =3D
>  		libie_pci_get_mmio_addr(mmio, temp_offset);
> =20
> +	/* Cross timestamping also samples the device clock registers. */
> +	void __iomem * const cross_regs[] =3D {
> +		ptp->dev_clk_regs.dev_clk_ns_l,
> +		ptp->dev_clk_regs.dev_clk_ns_h,
> +		ptp->dev_clk_regs.sys_time_ns_l,
> +		ptp->dev_clk_regs.sys_time_ns_h,
> +		ptp->dev_clk_regs.cmd_sync,
> +	};
> +
> +	ptp->get_cross_tstamp_access =3D
> +		idpf_ptp_regs_access(ptp, cross_regs, ARRAY_SIZE(cross_regs),
> +				     VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB);
> +
>  discipline_clock:
>  	access_type =3D ptp->adj_dev_clk_time_access;
>  	if (access_type !=3D IDPF_PTP_DIRECT)
> -		goto free_resp;
> +		goto check_features_access;
> =20
>  	clk_adj_offsets =3D recv_ptp_caps_msg->clk_adj_offsets;
> =20
> @@ -143,13 +196,35 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
>  	ptp->dev_clk_regs.phy_shadj_h =3D
>  		libie_pci_get_mmio_addr(mmio, temp_offset);
> =20
> +	/* Both the main and the PHY timer are disciplined together. */
> +	void __iomem * const adj_regs[] =3D {
> +		ptp->dev_clk_regs.cmd,
> +		ptp->dev_clk_regs.incval_l,
> +		ptp->dev_clk_regs.incval_h,
> +		ptp->dev_clk_regs.shadj_l,
> +		ptp->dev_clk_regs.shadj_h,
> +		ptp->dev_clk_regs.phy_cmd,
> +		ptp->dev_clk_regs.phy_incval_l,
> +		ptp->dev_clk_regs.phy_incval_h,
> +		ptp->dev_clk_regs.phy_shadj_l,
> +		ptp->dev_clk_regs.phy_shadj_h,
> +	};
> +
> +	ptp->adj_dev_clk_time_access =3D
> +		idpf_ptp_regs_access(ptp, adj_regs, ARRAY_SIZE(adj_regs),
> +				     VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB);
> +
> +	/* Reconcile dependencies after address validation changed access modes=
. */
> +check_features_access:
> +	idpf_ptp_check_features_access(adapter);

[Severity: High]
Could this leave ptp->dev_clk_regs.cmd_sync as NULL while
ptp->get_dev_clk_time_access, ptp->adj_dev_clk_time_access, and
ptp->set_dev_clk_time_access remain set to IDPF_PTP_DIRECT?

In idpf_ptp_get_caps(), when direct access is negotiated for reading the
device clock, cross-timestamping, and adjusting the clock:

1. ptp->dev_clk_regs.cmd_sync is mapped from clock_offsets.cmd_sync_trigger
   and validated in clk_regs[], leaving ptp->get_dev_clk_time_access as
   IDPF_PTP_DIRECT.

2. Under cross_tstamp, ptp->dev_clk_regs.cmd_sync is unconditionally
   overwritten using cross_tstamp_offsets.cmd_sync_trigger:

	temp_offset =3D le32_to_cpu(cross_tstamp_offsets.cmd_sync_trigger);
	ptp->dev_clk_regs.cmd_sync =3D
		libie_pci_get_mmio_addr(mmio, temp_offset);

   If libie_pci_get_mmio_addr() returns NULL for
   cross_tstamp_offsets.cmd_sync_trigger, the previously validated
   ptp->dev_clk_regs.cmd_sync pointer is clobbered with NULL.

3. idpf_ptp_regs_access(ptp, cross_regs, ...) only downgrades
   ptp->get_cross_tstamp_access, while ptp->get_dev_clk_time_access stays
   IDPF_PTP_DIRECT.

4. Under discipline_clock, adj_regs[] does not check
   ptp->dev_clk_regs.cmd_sync, and idpf_ptp_check_features_access() sees
   ptp->get_dev_clk_time_access =3D=3D IDPF_PTP_DIRECT and
   ptp->adj_dev_clk_time_access =3D=3D IDPF_PTP_DIRECT.

When idpf_ptp_init() or a PTP clock callback subsequently invokes
idpf_ptp_adj_dev_clk_fine_direct(), idpf_ptp_set_dev_clk_time_direct(),
idpf_ptp_adj_dev_clk_time_direct(), or idpf_ptp_read_src_clk_reg_direct(),
idpf_ptp_tmr_cmd() and idpf_ptp_enable_shtime() will call writel() on a NULL
ptp->dev_clk_regs.cmd_sync pointer.

Also, if clk_regs[] validation downgrades ptp->get_dev_clk_time_access from
IDPF_PTP_DIRECT, should idpf_ptp_get_caps() skip mapping cross_tstamp and
discipline_clock registers instead of mapping them before
check_features_access downgrades those dependent features?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102110717.7780=
0-1-przemyslaw.korba@intel.com?part=3D1
