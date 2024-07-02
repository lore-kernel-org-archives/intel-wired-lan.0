Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF702C3064D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  2 Jul 2024 10:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8518941651;
	Tue,  2 Jul 2024 10:56:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8DmmmwHQ8kb9; Tue,  2 Jul 2024 10:56:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94F7B40444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719917782;
	bh=qHUSuRw6fNn9vB/jKudvwhtqnVxCikbuQxyYcmGdnvE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8aR1Og+Ww7gz43L3tLMHCZ6Hklwx59QY577RtekADuyZdUVTpE520xQnFLSBIsv0m
	 2ZxBwtUdxVvTjaUZUr00IAEm0RQghCpd3TOOdEBhJLr/DxBbFXt97aE/YBJX0peoEw
	 onmAioIGx6nqlrUbRkDruYcO9QCibWETpsiFZDeHeXWPkjsfvWHrpBoeCUVs5/ZoMy
	 0v3v33JFt2mtm+oShofyKsntD81MLoY3XEUmPGEEBuNiU5oscLYZsDutLdCru53fb4
	 GlLkJrKzoYOOWNjUolNoKiFOui5W+guTB2hrSU+mUVis8d8Xek7FS2Czs2dY3TdulX
	 CRLxZBYoUhr8g==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94F7B40444;
	Tue,  2 Jul 2024 10:56:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 190BA1BF3A9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jul 2024 10:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04EEB81453
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jul 2024 10:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id inwJR0c-qSQN for <intel-wired-lan@lists.osuosl.org>;
 Tue,  2 Jul 2024 10:56:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2860581433
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2860581433
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2860581433
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jul 2024 10:56:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0A2D861C06;
 Tue,  2 Jul 2024 10:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D97C4AF0D;
 Tue,  2 Jul 2024 10:56:17 +0000 (UTC)
Date: Tue, 2 Jul 2024 11:56:15 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20240702105615.GG598357@kernel.org>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
 <20240627151127.284884-16-karol.kolacinski@intel.com>
 <20240701132744.GD17134@kernel.org>
 <815f7f5c-6d98-4be2-8fc7-09851fe281d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815f7f5c-6d98-4be2-8fc7-09851fe281d0@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1719917778;
 bh=3HWPW4vPXtwFBCCKdoVdqDwSDXV+HUOoD02Bw61tsic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=spfFKAtCzZyVpghMCJY9Cl0L9En1tN9pGF8EjJ174fGu+no1d4gZazdxc7MqSvSNT
 srghKK5oELxV+wF2u5xluplckmrzYTp9Cu+UsIcVlYdkv7rZCZdVRKyapkXGQV7fB8
 HK9ZrD7nzLOgLqbinf90PJJkSD50D+1cEr5ixvSNpVaNxyJ6Uf6KCAurNSpAUZhAzW
 oEYQTbJ2YUv2QU4ou8RKa2ibMFlf1MzPkyH13LxxWWpJ++8Y89XvUyT94/pw655OzM
 vwjpsU9ulBVJWTRymW6zwFcMN8c6faHiNWkzv/Zh0RhFNS0UfQLxNKIrXeHx9NBdAy
 /aXvk8YuTULaQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=spfFKAtC
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 7/7] ice: Enable 1PPS out
 from CGU for E825C products
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Sergey Temerkhanov <sergey.temerkhanov@intel.com>, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jul 01, 2024 at 05:08:09PM +0200, Przemek Kitszel wrote:
> On 7/1/24 15:27, Simon Horman wrote:
> > On Thu, Jun 27, 2024 at 05:09:31PM +0200, Karol Kolacinski wrote:
> > > From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> > > 
> > > Implement 1PPS signal enabling/disabling in CGU. The amplitude is
> > > always the maximum in this implementation
> > > 
> > > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > > Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> > > Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > > index 07ecf2a86742..fa7cf8453b88 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > > @@ -661,6 +661,27 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
> > >   	return 0;
> > >   }
> > > +#define ICE_ONE_PPS_OUT_AMP_MAX 3
> > > +
> > > +/**
> > > + * ice_cgu_ena_pps_out - Enable/disable 1PPS output
> > > + * @hw: pointer to the HW struct
> > > + * @ena: Enable/disable 1PPS output
> > 
> > Please include a "Returns: " or "Return: " section in the kernel doc
> > for functions that have a return value.
> 
> last time I have checked only the singular "Return:" was supported (aka
> non-complained) by kdoc checker on W=2 builds

Yes, agreed.

My point was that the kernel document should have a (correct :)
section to document the return value.

> 
> > 
> > NIPA has recently got more picky about this.
> > Flagged by kernel-doc -none --Warn
> > 
> > > + */
> > > +int ice_cgu_ena_pps_out(struct ice_hw *hw, bool ena)
> > > +{
> > > +	union nac_cgu_dword9 dw9;
> > > +	int err;
> > > +
> > > +	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD9, &dw9.val);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	dw9.one_pps_out_en = ena;
> > > +	dw9.one_pps_out_amp = ena * ICE_ONE_PPS_OUT_AMP_MAX;
> > > +	return ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD9, dw9.val);
> > > +}
> > > +
> > >   /**
> > >    * ice_cfg_cgu_pll_dis_sticky_bits_e82x - disable TS PLL sticky bits
> > >    * @hw: pointer to the HW struct
> > 
> > ...
> > 
> 
