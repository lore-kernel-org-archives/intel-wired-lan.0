Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37A5C4167B
	for <intel-wired-lan@archiver.kernel.org>; Fri,  1 Dec 2023 09:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 675D5847BC;
	Fri,  1 Dec 2023 09:59:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 675D5847BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701424741;
	bh=pk/kEKFwi3j0G3f+qFlP4PoiQyf+zY1TF/gw9Mq5NDs=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=E2/KMzKmIGNyEjUK4Wx3GafRfTQK6YwaugCSv2U2n4mnUJzrJva0mqvtwME+Viy81
	 ND+wszdfE7hpXP4aWcRVJVELAiN/2YTtRdFjffzWNkrL+tysIXcfd8nYk8zzowiejd
	 9+B8tBAQgiDaIRfo6heDP9dq8B3wZhTVCfFHIBxuE4rgQlUyTSRYLPaqxrtTnAOf+i
	 UqfCOy+5S9LQ15JHi54kV1mqv8x/48EWlFcmlEHMyf9zxulCT5jHIdnGgGJn/tUOHy
	 zdaTAw6g6nzvb/+K7tpYTascIn7OK3hTHkYYB/qNr2H0lNBhrR2x7JQzUIJrN4Yo9v
	 nrwdD8BN9OfTA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 414yuSKaH3Jm; Fri,  1 Dec 2023 09:59:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85F26847B9;
	Fri,  1 Dec 2023 09:59:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85F26847B9
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id B534D1BF345
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Dec 2023 09:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CD2760B68
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Dec 2023 09:58:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CD2760B68
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k9sCzlvywYcF for <intel-wired-lan@lists.osuosl.org>;
 Fri,  1 Dec 2023 09:58:58 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC2C160AEF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Dec 2023 09:58:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC2C160AEF
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 0EC1BB84776;
 Fri,  1 Dec 2023 09:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0CBC433C9;
 Fri,  1 Dec 2023 09:58:52 +0000 (UTC)
Date: Fri, 1 Dec 2023 09:58:48 +0000
From: Simon Horman <horms@kernel.org>
To: Jan Glaza <jan.glaza@intel.com>
Message-ID: <20231201095848.GT32077@kernel.org>
References: <20231129073611.8816-1-jan.glaza@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231129073611.8816-1-jan.glaza@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701424734;
 bh=MyorjKQYbtVSpbBJboZrJOBowqJDICf5+G93U5kPraI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=POVNK/b8fBIwpTZKLT1FLBnnQTMvkV3Or4wWeZmfpB9NTZNZju7zAy6/NhB1b8AN3
 WEJAp6lHgj1VFZbe+MptFZHuQpmGC94byOaNr27CwRWhV2IbxOsdjQNOXJIzDeLqZN
 epNLsucZxb12CUzwI5a+G7gZAJdVf8HZ1PjlmgAiaQA82/VAncBYjl/tID9Fzh/XiE
 Zgg0jwIpEh2MG97PXRMVLC8kjoXIA524beqMX1sUINGYzDGD8Jsc+A87UVLKIKhOu7
 JrjCw7mAw1JPT1Kfi/Fe1nHhzzc7QeHYik+wLZpUIkzSBWVdfDcp6XGnhA+MGRkHuW
 aoKQmkXQhpKVw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=POVNK/b8
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: ice_base.c: Add const
 modifier to params and vars
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
 Sachin Bahadur <sachin.bahadur@intel.com>,
 Andrii Staikov <andrii.staikov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Nov 29, 2023 at 02:36:11AM -0500, Jan Glaza wrote:
> Add const modifier to function parameters and variables where appropriate
> in ice_base.c and corresponding declarations in ice_base.h.
> 
> The reason for starting the change is that read-only pointers should be
> marked as const when possible to allow for smoother and more optimal code
> generation and optimization as well as allowing the compiler to warn the
> developer about potentially unwanted modifications, while not carrying
> noticable negative impact.

Hi Jan,

it's probably not worth respinning for this, but: noticeable

> 
> Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
> Reviewed-by: Sachin Bahadur <sachin.bahadur@intel.com>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> ---
> This change is done in one file to get comment feedback and, if positive,
> will be rolled out across the entire ice driver code.

The nit above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
