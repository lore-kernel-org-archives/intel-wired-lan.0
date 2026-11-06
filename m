Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD603606A326
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=G9tezGBa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxOkhfiZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DB49812CB;
	Fri,  6 Nov 2026 20:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xpeIi5R3O--s; Fri,  6 Nov 2026 20:53:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B0F3812CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793998436;
	b=jkMHAijxrU2TtfmbDZNNyHK748IZSY0AEUsSq2oUAjXBWcThJHnx7X5fOtLzGsxgWPCM
	 VddX3fdWBCetc38MT+1k/whk1mLtuU5w1VOE8Ix5OcG01JVkmqLGjcSot7mEaCxp0OC4l
	 Lzi37uVS8TcW/91968naYlW15StQWkOkuvtyyOq9JoOxUjHauZcQE9JrX5LmpfDonRD3S
	 EB9V0QOpktFmcgGXfRT8zYeoha5vaUbUjDznizBrbrYEsQ1CW6ZE11h4Lf5a3d95sv8KM
	 Eea/N8S36VWbDPUMdrIQM8F4io7Ih0USQf23ZrtA3y4DVJH6NT5JPWvesxTArhc5Mlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793998436;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=wQATwTVtMocXdW6kCyhDIN9aoxU6AoFUXZw6XVltzVI=;
	b=bGLBuEe+t0xpb/+oEQ1P+HtMoPWCRnTa3JFmQTA91AsPGLV0u1CR9shoixPzPrnda8b0
	 dmXV/EtungEX+URchGdMgJDgoxGzM9apfYaIiZs5RF8J5VRjVkTJqRHJWTFy9uO7/O0xj
	 2y1Ft8SOrTdD1O/1Hdp4EYqq6PfzBytcTq+zWhv6kri5BmA/3xOCK6m8kgtjaWFwiJc5A
	 MLJMXYAJ0sDfB6AoGmr9HGZDr/2cS7QJd1EUpgueP9dRjDFlchYzqasjTJjvYWcrZ7NRi
	 u0IWefHtamwO9yb8RO8tmngcfiMJm9/1s/WQqgdc/qrjYJ3wSZFpARu583wcAxywjqQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxOkhfiZ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793998436;
	bh=wQATwTVtMocXdW6kCyhDIN9aoxU6AoFUXZw6XVltzVI=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=G9tezGBaly/mi7MWoi8/UUDsrUnj+x8V1lM7W/fZU+TGH5DtoYbUteRELqsLtxpkO
	 Jj8DoKAaVKYlyQB1WWmQ/I42YJBLzX3U+IuwEjKijIjUND0Supmq1VRsvIwhuixN1I
	 AsRS81VC/hrhaNd0tSrkoQM3dEn11a+6DI71xOVYTljvQjBVexwkrSY8lDCF9HRUoW
	 9ZiZUL+0WjDrPY3eErmCWpQFMW3d03Xa0D4pEJbMEGaGqHH8W6DYVu/+ReIQ7Nj1vX
	 RX+2a95Qz7IuEV4HCkOPz/ANHfCkpi2/I1byZH9ip3p2qERlKpa8ZEmqMKlnOTJvU8
	 QH0pC9cfKtYkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B0F3812CE;
	Fri,  6 Nov 2026 20:53:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC13331F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 20:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACDDA812CE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 20:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKf-PoHLURMv for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 20:53:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CC04812CB
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=HxOkhfiZ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CC04812CB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 20:53:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 684B360215;
 Fri,  6 Nov 2026 20:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE05A1F0089F;
 Fri,  6 Nov 2026 20:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793998432;
 bh=wQATwTVtMocXdW6kCyhDIN9aoxU6AoFUXZw6XVltzVI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=HxOkhfiZkSDbborlEnp3veiYpqr+Y/oqWg9XYL4gVczz2sVitdhXoFow+HG/rzlTk
 KLlxRNb37d1TIIaCyfzf6ADclnMt88eewr62JFU4lumIIHkGp6xkCt5Zyf1zjNTAIY
 Z8YKoWcA/BaCM4pk0RofJH2/fm7mQMI1asiJksQJ8cyMXdPLPtaHV8vORpRMwfaKYM
 HuAN9BAmX36TrjgkWW+tCzF4cepEMCfVaq54Q0RmsGX6jMB9dWWrzyG0GTs+4iEX6T
 LxNN4LX3Pzg6DoCeYyqbsEA00S23dREsILi71q7/WHakkjfYWWLclitDqfrLIX3OK8
 iaS8D/hrUovrw==
Message-ID: <sashiko-outbox-202258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net] igb: Retry the D0 write of the i210 PLL workaround
To: "Anthony Pighin" <anthony.pighin@nokia.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261105205325.2624892-1-anthony.pighin@nokia.com>
References: <20261105205325.2624892-1-anthony.pighin@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:53:51 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] igb: MMIO access while in D3hot after igb_set_d0_i210() fails
- [Low] igb: __bitwise pci_power_t type mismatch in igb_set_d0_i210()
--

commit f07d2c21ba2a41d9be32c940436c29816e2eedd2
Author: Anthony Pighin <anthony.pighin@nokia.com>

igb: Retry the D0 write of the i210 PLL workaround

This commit adds igb_set_d0_i210() to retry transitioning the device from
D3hot back to D0 during the i210 PLL errata workaround if the config write =
is
rejected while the root port reports link training.

> diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/et=
hernet/intel/igb/e1000_i210.c
> index 784f9a7bcbed0..fad7cdfea197f 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_i210.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
[ ... ]
> @@ -812,6 +814,33 @@ s32 igb_init_nvm_params_i210(struct e1000_hw *hw)
>  	return 0;
>  }
> =20
> +static bool igb_set_d0_i210(struct e1000_hw *hw, u16 pci_word)
> +{
> +	struct igb_adapter *adapter =3D hw->back;
> +	u16 pmcsr;
> +	int i;
> +
> +	pci_word &=3D ~PCI_PM_CTRL_STATE_MASK;
> +	pci_word |=3D PCI_D0;
> +
> +	/* Some host controller drivers refuse config accesses while the root
> +	 * port reports link training. The root port can report link training
> +	 * while the device is in D3hot, so the write that requests D0 can be
> +	 * refused.
> +	 */
> +	for (i =3D 0; i < 1000; i++) {
> +		igb_write_pci_cfg(hw, E1000_PCI_PMCSR, &pci_word);
> +		igb_read_pci_cfg(hw, E1000_PCI_PMCSR, &pmcsr);
> +		if (!PCI_POSSIBLE_ERROR(pmcsr) &&
> +		    (pmcsr & PCI_PM_CTRL_STATE_MASK) =3D=3D PCI_D0)
> +			return true;

[Severity: Low]
Does mixing PCI_D0 with u16 pci_word and (pmcsr & PCI_PM_CTRL_STATE_MASK)
trigger Sparse warnings?  PCI_D0 is a restricted __bitwise pci_power_t token
rather than a raw PMCSR register value, so both the bitwise OR and the
comparison degrade pci_power_t to an integer under Sparse.

[ ... ]

> @@ -866,8 +895,8 @@ s32 igb_pll_workaround_i210(struct e1000_hw *hw)
>  		pci_word |=3D E1000_PCI_PMCSR_D3;
>  		igb_write_pci_cfg(hw, E1000_PCI_PMCSR, &pci_word);
>  		usleep_range(1000, 2000);
> -		pci_word &=3D ~E1000_PCI_PMCSR_D3;
> -		igb_write_pci_cfg(hw, E1000_PCI_PMCSR, &pci_word);
> +		if (!igb_set_d0_i210(hw, pci_word))
> +			break;

[Severity: Medium]
If igb_set_d0_i210() fails, does breaking out of the loop still perform MMIO
accesses while the device is stuck in D3hot?

After the loop, igb_pll_workaround_i210() runs:

drivers/net/ethernet/intel/igb/e1000_i210.c:igb_pll_workaround_i210() {
    ...
	igb_write_phy_reg_82580(hw, I347AT4_PAGE_SELECT, 0);
	/* restore MDICNFG setting */
	wr32(E1000_MDICNFG, mdicnfg);
	return ret_val;
}

igb_write_phy_reg_82580() acquires the PHY semaphore and reads E1000_SWSM v=
ia
igb_rd32(), and igb_reset() also continues issuing MMIO accesses after
init_hw() fails.  Because the device is still in D3hot, readl() returns
0xffffffff, causing igb_rd32() to clear hw->hw_addr, report "PCIe link lost=
",
and trigger a WARN().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105205325.2624=
892-1-anthony.pighin@nokia.com?part=3D1
