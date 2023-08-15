Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F23FC001E0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 18:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 05B40404FE;
	Tue, 15 Aug 2023 18:29:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05B40404FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692124143;
	bh=Nae2uJk5TlwYnItaRJeEIn07xGLbQlI6XAD4Mt3y0ls=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BDAAyr/2mBELVoFGjiNX+I3MffZTFpTauVS9I7p8+zF9MgnHFVcBbIfqKeKb/DFuy
	 ICzuxUfwtDVTjgB9K1mjypPo2Cq/cph6iSNDs3rqwIUUz+GQqC7O2/iDALujvwsHMB
	 tPbK+asnV8wduWAypDGKpdpGfFaUsAYD6NnWSYjx5h+bex+PXR38yoSYGCFabAMubC
	 spLaA7LivcYJKT3FcTnLNkDSQFTVFYqQe59F7bYYv8Y5pdKP932/12GrsGlhHM218d
	 VCQ/VvkZG1VQQ0Aydc9rJ2vcyKuDqs5/fzLhOk7vJDU2AdPb9w97YdFJ5JEzMIn7em
	 cq1WQV8xJngmA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WOcs_SCUprb8; Tue, 15 Aug 2023 18:29:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D2B0405B2;
	Tue, 15 Aug 2023 18:29:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D2B0405B2
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 094AF1BF422
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 18:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4AB0405B2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 18:28:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4AB0405B2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4xRB7A5kleLm for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 18:28:59 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4FBFF404FE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 18:28:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FBFF404FE
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7F62864C1E;
 Tue, 15 Aug 2023 18:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F4BC433C8;
 Tue, 15 Aug 2023 18:28:57 +0000 (UTC)
Date: Tue, 15 Aug 2023 11:28:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <20230815112856.1f1bd3ac@kernel.org>
In-Reply-To: <ef2eca98-4fcc-b448-fecb-38695238f87b@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-4-vadim.fedorenko@linux.dev>
 <20230814201709.655a24e2@kernel.org>
 <ef2eca98-4fcc-b448-fecb-38695238f87b@linux.dev>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692124137;
 bh=/qruM4K34GEGf+StPBYxRoP0CWoc0pHOT9PCxjD218c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OkWhtJDu7Is84Ym19H+u7zVakV0q6ehat1w8njTrbVRyuNIBSGUKya1FsZKQ2/3eW
 DCMU89Q5QfAXBmYOgL9v3lr5TIwMqLnG2VP6pt8CK1cbEp5uSEHRqclEBczftWsLyi
 /BsBBVdWN1g7Evw3haiLSPPXDRuBAlBcpnw8bM+kQFpQwpkQ/SV+zy1cQGHpG6sOqb
 4x7vKW0Q5ks7AriJBw3TXWEnENJyMLsXNM7EJHp6uBee46HUdEmkOqS3ak1P2TaxAl
 KAOeuT3+D2I6zWH5b8nCogW6hTDDU1SzzSEIyGkV3wJ+pmFrPiSFqCT0Udm15rDwGj
 XYnTmjxADj/XA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=OkWhtJDu
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 3/9] dpll: core: Add DPLL
 framework base functions
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
Cc: Jiri Pirko <jiri@resnulli.us>, Bart Van Assche <bvanassche@acm.org>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 15 Aug 2023 19:20:31 +0100 Vadim Fedorenko wrote:
> >> +	ret = xa_alloc(&dpll_device_xa, &dpll->id, dpll, xa_limit_16b,
> >> +		       GFP_KERNEL);  
> > 
> > Why only 16b and why not _cyclic?
> 
> I cannot image systems with more than 65k of DPLL devices. We don't
> store any id's of last used DPLL device, so there is no easy way to
> restart the search from the last point. And it's not a hot path to
> optimize it.

I think this gets used under the xa_lock() so you can just add a static
variable inside the function to remember previous allocation.

I don't expect >64k devices either, obviously, but what are we saving
by not allowing the full u32 range?
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
