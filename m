Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376DAC52D7C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Aug 2024 16:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03B6D812D1;
	Mon, 12 Aug 2024 16:06:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uO6H791ZqCne; Mon, 12 Aug 2024 16:06:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB552812C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1723478781;
	bh=y29fwayNNSEepX0RDmkQk4UPfgjCE/Bfyi87cLWGUlI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ymxhbxTrWvk8Jq5txheetJPC2VfBjddhGpnbteUg6Vc7QtkcnrE8Pgj6IE86HiB4J
	 W/w4jmWPB/9RYYN3bpKUXIq6v8aY6kMi/z4lbytH8Xc/BnzhST8DHzlLnU+uRYNLdC
	 wIhmbH3rRkbOdhZUJByNJmBL6cZwWxH1e8FxlweTizq9j3VAmw+YSFqymzg+lfP0bK
	 kylcd43d5UGNfqH6Ca6baby/NWNXTr/viSCS/Q2APefRr1dP1Rx48dTQ9cbDZ8LEQA
	 ieMSgPZagDa8GwX4wkLWiJtlJ15tgsbReUPJlcDy8sLbSyUYxCeZcRDIS4KrZgnxez
	 +LuBOuYUo+e9w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB552812C5;
	Mon, 12 Aug 2024 16:06:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id AF4C91BF5DB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Aug 2024 16:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A85B760678
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Aug 2024 16:06:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OQ0dYytTBufg for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Aug 2024 16:06:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5F67F60627
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F67F60627
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F67F60627
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Aug 2024 16:06:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 23DCC6132D;
 Mon, 12 Aug 2024 16:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397B0C32782;
 Mon, 12 Aug 2024 16:06:16 +0000 (UTC)
Date: Mon, 12 Aug 2024 17:06:13 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20240812160613.GB44433@kernel.org>
References: <20240808112217.3560733-1-aleksandr.loktionov@intel.com>
 <20240809152549.GB1951@kernel.org>
 <4e3602d2-6c6e-4311-b4fc-b3f8e2ce4da5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e3602d2-6c6e-4311-b4fc-b3f8e2ce4da5@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1723478777;
 bh=/Ab350HoHqgE9u8nO0zLL/PFFUJ4QZlZBC4befB8k9M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rVLIzELRRH5Sgmyn0keMTDa1tZkv5FwNDz+gQfcBoosbIINjG7PnVmLvG9BWbHkdK
 I0sArapfmkeaSFBM+BSw0h/IWGgw++SwC4swP2C3UA3O3gM2f4BOJEgNIxL7HpiCNw
 Mpn+994d7diLxR7+mhPkx3c0ciNzpLel5odzHjL84NG5zNTg8qxgkCXpPtmh1OH7PC
 eQvG5q5d5x4LWfxMSwQ1je9K/XQ13N/EUT3FVT7qtRBrcDEgvfWqeX4+qcsahx/j6G
 42Qf3dvpgLhptS+APJyfnvwP4FdUlt8hZTxxFa5pWD7W0N+Gl9a0rpdAaKgdKaTtVj
 wwgQ/MVhUVJVA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rVLIzELR
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] i40e: Add Energy
 Efficient Ethernet ability for X710 Base-T/KR/KX cards
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
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 anthony.l.nguyen@intel.com,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Aug 12, 2024 at 10:09:37AM +0200, Przemek Kitszel wrote:
> On 8/9/24 17:25, Simon Horman wrote:
> > On Thu, Aug 08, 2024 at 01:22:17PM +0200, Aleksandr Loktionov wrote:
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > > index 1d0d2e5..cd7509f 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > > @@ -5641,50 +5641,77 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
> > >   	return 0;
> > >   }
> > > +static void i40e_eee_capability_to_kedata_supported(__le16  eee_capability_,
> > > +						    unsigned long *supported)
> > > +{
> > > +	const int eee_capability = le16_to_cpu(eee_capability_);
> > 
> > Hi Aleksandr,
> > 
> > Maybe u16 would be an appropriate type for eee_capability.
> > Also, using const seems excessive here.
> > 
> > > +	static const int lut[] = {
> > > +		ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> > > +		ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
> > > +	};
> > > +
> > > +	linkmode_zero(supported);
> > > +	for (unsigned int i = ARRAY_SIZE(lut); i--; )
> > > +		if (eee_capability & (1 << (i + 1)))
> > 
> > Perhaps:
> > 
> > 		if (eee_capability & BIT(i + 1))
> 
> I would avoid any operations with @i other than using it as index:
> lut[i]. We have link mode bits in the table, why to compute that again?
> 
> > 
> > > +			linkmode_set_bit(lut[i], supported);
> > > +}
> > > +
> > >   static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
> > >   {
> > >   	struct i40e_netdev_priv *np = netdev_priv(netdev);
> > >   	struct i40e_aq_get_phy_abilities_resp phy_cfg;
> > >   	struct i40e_vsi *vsi = np->vsi;
> > >   	struct i40e_pf *pf = vsi->back;
> > >   	struct i40e_hw *hw = &pf->hw;
> > > -	int status = 0;
> > > +	int status;
> > 
> > This change seems unrelated to the subject of this patch.
> > If so, please remove.
> 
> Hmm, it's remotely related, trivial, and makes code better;
> I intentionally said nothing about this during our internal review ;)

Ok, I would vote for it being a separate patch.
But I won't push this one any further.
