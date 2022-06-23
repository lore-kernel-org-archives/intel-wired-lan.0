Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1879CCA479
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jun 2022 00:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F79883F12;
	Thu, 23 Jun 2022 00:35:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F79883F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1655944523;
	bh=y18XZP4Yky+ge2Ny5o0JFE9tWzhClVkhrK161sD7HyM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XK8PKrZXGT6x4sCRSq6BFV3Z3VTBrJKIa3u/GbH+93w3le+5sCnVxxf80XgIA1g6e
	 5GnjH+gCwpZwVJrRV8EOxjVbjnok03MOBoVvllfl2SKHI5z2HcrhEb4KNp9Ex+tfvz
	 /fElXzbYuaW5FjOwLJx1hLEq/PUz0ZnmawruI3GmeP9nOga99mBo6yxAzaPGFA4O66
	 jKpBZwZqwE1UNYf7KnC3UgPfXUk6tXWFXd0uj4N0AqtNS5pJF9icwNp+wEhzHVmkZF
	 mEvjuJQEE4UbnyBVDsBLGDoK/i0zNeNS2sHw97fDDIQxFc8BBhCtBtPAKPoBnMfekQ
	 4jaJUswRxlczA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H45_PLVuVK0C; Thu, 23 Jun 2022 00:35:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70F7683F19;
	Thu, 23 Jun 2022 00:35:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70F7683F19
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 5DF951C115D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jun 2022 00:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C21141BDE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jun 2022 00:35:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C21141BDE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zU7udZsDkqRQ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jun 2022 00:35:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DA084174B
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DA084174B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jun 2022 00:35:20 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EAC5F61B53;
 Thu, 23 Jun 2022 00:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B09C34114;
 Thu, 23 Jun 2022 00:35:17 +0000 (UTC)
Date: Wed, 22 Jun 2022 17:35:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ciara Loftus <ciara.loftus@intel.com>
Message-ID: <20220622173516.2c38e035@kernel.org>
In-Reply-To: <20220622091447.243101-1-ciara.loftus@intel.com>
References: <20220622091447.243101-1-ciara.loftus@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1655944518;
 bh=ltJF/bFJ8MSQB0vrtLVAFKs9mVw7O+vpttDAcGGCCEs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=n8iUpMZeTqXg6WU0FNs20DPVnxVSWGQUolUlQFpSaEBcF2gvLBjokCakKLWuJd9ZB
 yoyTOKMWNfD8jRF211bhNjtqjeUPPtgPsNEc5g3n6NqACzlPRA4a0rbIEmhjLT/Bbu
 PY1AAr4G+xq26T5Y8X6Dnfwpfy6910oH5lindRugo8L+fdYCSmhL8yeRWM29cLhVRD
 r+NebPoF278C8zy3CTyRp59U4aAchvKCjjMG2ObbP0AGiZ5LJokHLY7tFdyVc1W7U2
 0VW67QvamW06pGVvfsJxdT9H+VIzSHcUNyG/8a2UJR55k6ccB9nUyrqrS+HwfPqNNs
 1qtMUCH7rr3aA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=n8iUpMZe
Subject: Re: [Intel-wired-lan] [PATCH net-next] i40e: xsk: read the XDP
 program once per NAPI
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 22 Jun 2022 09:14:47 +0000 Ciara Loftus wrote:
> Similar to how it's done in the ice driver since 'eb087cd82864 ("ice:
> propagate xdp_ring onto rx_ring")', read the XDP program once per NAPI
> instead of once per descriptor cleaned. I measured an improvement in
> throughput of 2% for the AF_XDP xdpsock l2fwd benchmark in busy polling
> mode on my platform.

drivers/net/ethernet/intel/i40e/i40e_xsk.c:151: warning: Function parameter or member 'xdp_prog' not described in 'i40e_run_xdp_zc'
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
