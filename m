Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D1CC4167B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Dec 2023 20:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFD23613E7;
	Tue,  5 Dec 2023 20:46:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFD23613E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701809203;
	bh=gfYz/xTsOWuc9o1u78hImotKvZ765R8geXQPtatNgsE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=h+/LGKLQMW2P2YC1VxVnLjMxo+/olc77c6Vke5xliBKuyINYhI+q7Aon4L3VRBJv5
	 njd5ivJguOFFRfybtBkegkikXuAoy1JCQ+uaL4DiBYpuiSXR/NPLredkFJGE0x2Kxy
	 TQQiN8lfbei0qcUD+c4MY1ULpw7nhjjPFvw0NvvKzC4RjmPR19ZouvRFjUnSNFqboK
	 HVLu2i9TOPDn1mttcPxu9dcAH7qwmdKtzDTDgTF0ygyXhqtvSwmwpq18yCRPEE5Mo0
	 B5dAsnGvRSACD9B7ykQKRRmSbeDG+bjfh0vPJrOlm+6uecli2wFacn3vwH1nXN0pS7
	 LXyY9qkXXtYHg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8T_k5p7uCRMI; Tue,  5 Dec 2023 20:46:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38F6460EED;
	Tue,  5 Dec 2023 20:46:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38F6460EED
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 4828B1BF593
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 20:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DF80435AB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 20:46:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DF80435AB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qSowdVHTG3yc for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Dec 2023 20:46:37 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8875D4016B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 20:46:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8875D4016B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5B8B7CE185A;
 Tue,  5 Dec 2023 20:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DA5C433C8;
 Tue,  5 Dec 2023 20:46:30 +0000 (UTC)
Date: Tue, 5 Dec 2023 20:46:28 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20231205204628.GX50400@kernel.org>
References: <20231130165806.135668-1-mschmidt@redhat.com>
 <f78a8937-0811-03e8-464d-47f404a3718b@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f78a8937-0811-03e8-464d-47f404a3718b@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701809192;
 bh=EcxrluR7rHeirw8m6JBZ9mBIrJoWhLdESfw1gflpKTM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iZpQK+Jm3hMwnnABUGccgKc27HvKxV5HlQpiX/Y5Prx2ANrbVk7G8l0fQo/ogL848
 y/dwAy19hoJAVfdXFlKzNkHnqgQyyUFFajTt6ai8H0TXqhEthLsrZwG4fv7rMLC4PN
 6/+rFsUYzSGuHX/xFr+KdRX14cisAdJvSGvEI7SFTtd4cXFLCg1JyR4rZRzfXv+XnV
 RUJmD9vCAuN81nfFRzbb59OJJeGhJj+QpR/Qr7c9ps9EG3pKfCmUQdzrpF9TXP1Wk1
 n7JYlorlxx0OKRWILXc+D4J2jwr03Uvz+F3yUIMi/6oyUGItzjrAK4THiFcXQlqGNm
 FQeEtlPeA5TxA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=iZpQK+Jm
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix theoretical
 out-of-bounds access in ethtool link modes
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
Cc: Paul Greenwalt <paul.greenwalt@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Dec 01, 2023 at 08:33:36AM +0100, Przemek Kitszel wrote:
> On 11/30/23 17:58, Michal Schmidt wrote:
> > To map phy types reported by the hardware to ethtool link mode bits,
> > ice uses two lookup tables (phy_type_low_lkup, phy_type_high_lkup).
> > The "low" table has 64 elements to cover every possible bit the hardware
> > may report, but the "high" table has only 13. If the hardware reports a
> > higher bit in phy_types_high, the driver would access memory beyond the
> > lookup table's end.
> > 
> > Instead of iterating through all 64 bits of phy_types_{low,high}, use
> > the sizes of the respective lookup tables.
> > 
> > Fixes: 9136e1f1e5c3 ("ice: refactor PHY type to ethtool link mode")
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > index a34083567e6f..bde9bc74f928 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -1850,14 +1850,14 @@ ice_phy_type_to_ethtool(struct net_device *netdev,
> >   	linkmode_zero(ks->link_modes.supported);
> >   	linkmode_zero(ks->link_modes.advertising);
> > -	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
> > +	for (i = 0; i < ARRAY_SIZE(phy_type_low_lkup); i++) {
> >   		if (phy_types_low & BIT_ULL(i))
> >   			ice_linkmode_set_bit(&phy_type_low_lkup[i], ks,
> >   					     req_speeds, advert_phy_type_lo,
> >   					     i);
> >   	}
> > -	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
> > +	for (i = 0; i < ARRAY_SIZE(phy_type_high_lkup); i++) {
> >   		if (phy_types_high & BIT_ULL(i))
> >   			ice_linkmode_set_bit(&phy_type_high_lkup[i], ks,
> >   					     req_speeds, advert_phy_type_hi,
> 
> I guess that that "HW reported" number really goes through the FW in
> some way, so one could indeed spoil that in some way,
> what makes sense to target it at -net.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
