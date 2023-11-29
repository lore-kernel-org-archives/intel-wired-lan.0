Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB70C4167B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Nov 2023 16:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 659C5821AB;
	Wed, 29 Nov 2023 16:46:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 659C5821AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701276363;
	bh=sSixjPm10MhafrJoNvgE8t+gP/rytQuMJ/K3zuuC0Pc=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=IgCxVadOTxOHvvTD30zzYQ6kMTn0izYay4fvFWmqN465Pfk56sHmbu7ixchCac3rT
	 j5/FdM5v/coIxiEvK5TA+TIIlWRTH8eSVD58s5t7K9NFT69xx9Xi/pZy38Zln416TS
	 ccRWj3sEu7ViFuMJuNiyv8h9qJApYs1/8H6WfqvT4pnLjZ22KQ6HXfL0G6wAtarVIy
	 f9vCZml5xQidE/mYhHUhcf53Mg//e5VjiJyxJyo865FblhMQFF2tf8aJRzx2Eq7r1c
	 9p9A8GwVizId9+VZBLOP7OcZObY1mcPPZrWwVX2x50pwb2TxcJxQgpIOKMqhIzhXOZ
	 IbP/lIfVWmpsw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0_a2bOp1HeVF; Wed, 29 Nov 2023 16:46:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74FC0821C8;
	Wed, 29 Nov 2023 16:46:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74FC0821C8
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 18A841BF2FE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Nov 2023 16:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3EBC41829
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Nov 2023 16:45:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3EBC41829
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7b48VGyiqG3k for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Nov 2023 16:45:58 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F2A241823
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Nov 2023 16:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F2A241823
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 073F6CE1E53;
 Wed, 29 Nov 2023 16:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E246DC433C7;
 Wed, 29 Nov 2023 16:45:53 +0000 (UTC)
Date: Wed, 29 Nov 2023 16:45:51 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <20231129164551.GE43811@kernel.org>
References: <20231124114555.253412-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231124114555.253412-1-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701276355;
 bh=xyGkzJOwryPI3xou4Wa2vHE+sW4/4uqtG68QNchN5LY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D9VeoTMN7TnMhvL6wfalm6GNQThPs3Snm3mnXssmcl0J1HauRPKtxlU9A7wr+ptQn
 LuOCmmHpGvxXVtVVmb2ClkCsJ86oHQ9w18MNXtd6n5wQblx4SOVe3gZGJXh1XQZ3xd
 OzD6VXd59rUJhFpJikhdC3KaIH3nZ90z2Ng5ZsUzSJQ6Fink4Hiv57fnYQGAC03qau
 RfxfMxu4Qs5ddGtGuzSa3YXEOpT9un53ZJgnbPvtEeeHZwfDh42cHvh8UOcD31F/lA
 PFWjYWryfH68HVxuQRcwh+hLfCb6RlxIvsmOr1u3Miab6Po18foGpb1+4O8NT190U9
 J63vW+f18BY9w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=D9VeoTMN
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Rename E822 to E82X
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Nov 24, 2023 at 12:45:55PM +0100, Karol Kolacinski wrote:
> When code is applicable for both E822 and E823 devices, rename it from
> E822 to E82X.
> ICE_PHY_PER_NAC_E822 was unused, so just remove it.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Hi Karol,

while I think this naming scheme may have some shortcomings
if other E82[0-9] chips come along with different overlap
in function re-use, I also do see that it is a convenient
shorthand. And moreover that it matches what is already in-tree
as of at least:

88c360e49f51 ("ice: Support cross-timestamping for E823 devices")

So, FWIIW, beyond my mumblings here I am happy with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
