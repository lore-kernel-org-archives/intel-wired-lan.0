Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE987C4167B
	for <intel-wired-lan@archiver.kernel.org>; Sat,  2 Dec 2023 16:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 642404052D;
	Sat,  2 Dec 2023 16:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 642404052D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701535715;
	bh=1xo/BDgoaYsllWGuAyeC0P2jMUnOch9r00aVgTQ1H9k=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=0TDo3EJck/w6skxp1CquaAalLPpIREE/reL9NGVLiRmRumKRNQnKk0JGX4RuX06Qm
	 4b38M9i8GftNPkHxpJPVwioga22Xxn63ZXNZKvirtfK877zirdV0pvt/qLdRqRU65O
	 LeC7dBY61lnzEfgEBLpdZ4IHepiFt828OluJc/LYWIh4OT0Jufwv0wetpNHEkEGx2A
	 N9HiqitCeesvHsEaleMPPV7radrfuIm/DASd5s6JbXS2XcDD1KXSiog4j2HABijDEb
	 L2x4f/D+9coOdgFlm9HWo1b1cNRhtGaSwaby0IPckfMnSe22SIBlN8LtMHgre7yGuz
	 lMJfl0KjELD8g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09s9a-lXa8xb; Sat,  2 Dec 2023 16:48:34 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E7D140530;
	Sat,  2 Dec 2023 16:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E7D140530
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1C7E71BF5A5
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 Dec 2023 16:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E264740530
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 Dec 2023 16:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E264740530
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PNNLTMyvdaQ6 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  2 Dec 2023 16:48:30 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B754D4052D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 Dec 2023 16:48:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B754D4052D
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9DA9D60B93;
 Sat,  2 Dec 2023 16:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD44C433C9;
 Sat,  2 Dec 2023 16:48:26 +0000 (UTC)
Date: Sat, 2 Dec 2023 16:48:24 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Message-ID: <20231202164824.GA50400@kernel.org>
References: <20231129161711.771729-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231129161711.771729-1-ivecera@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701535709;
 bh=DnZEzNXP9hV68Bv4xg8L4T2Cgy7MhrlHkGJzKWd0Rog=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SZoOTDXNOwfGy+XbS4lGBQnlNtfStPpSe6XOuqQbxnbXDAUBoZaxsBOXb2D0e9dmu
 C7p8JBEBYJRi0f0bK+IiWqwRZivi4i7Yep2WYel8lRjn8pg/WNx16abD/9vaSwAyAR
 k4GatGF7Xw7DiyvOAZMGPkwt6A+K+y//RaCLR9ncjQMGdaNL+aqaolGYgZJKoIem/6
 fMHcyTIbpba7xUZLqzio6tpm7HN3f4iXQsM8BLAQs6HGWp7wxz0PXN6ghbQEEtNMDe
 NZa3CQKerGMXmPiMF4YfSgJAGp7mYigBA8NEINbq3X72XTGMZRY5/a/Q6TV9VTNUxc
 NDJVm2GW1LVYQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=SZoOTDXN
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix ST code value for
 Clause 45
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Nov 29, 2023 at 05:17:10PM +0100, Ivan Vecera wrote:
> ST code value for clause 45 that has been changed by
> commit 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
> is currently wrong.
> 
> The mentioned commit refactored ..MDIO_CLAUSE??_STCODE_MASK so
> their value is the same for both clauses. The value is correct
> for clause 22 but not for clause 45.
> 
> Fix the issue by adding a parameter to I40E_GLGEN_MSCA_STCODE_MASK
> macro that specifies required value.
> 
> Fixes: 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks Ivan,

I agree with your analysis and this fix looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
