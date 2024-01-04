Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FE7C47073
	for <intel-wired-lan@archiver.kernel.org>; Thu,  4 Jan 2024 20:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8490B832C7;
	Thu,  4 Jan 2024 20:35:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8490B832C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1704400536;
	bh=9R8ThRisw9OUxOwIjb9o1kLKQhewqB8sHa4xsIf3OPQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=aL7M9BjYCiH7HucSFL/54IexfNoNt+CAxbAaymoQYvhiSOqXJYwksHXbAGzUSgaiO
	 ZoLnOwrfhiZtq1UQRh957S/Ju90j2HKFBShxFIr2MMMgbiQW2gltAehIDDyuOhu0mu
	 XOjrqvdqL4Cit6k9C0S1phwEOi7y3QmchbkGTx0t9pCGhHc3Z/niVJlklYsaxRt/8o
	 SKEURXfeVyG4HWutak2QjEJCDpKuiZEe5ger2BVq+8PQNYvS1eN5HAI1MtxXVPmpDX
	 7s/JL3hQvk0HgokMKO9BWMMrXhdzjvcYuM/f50UrsRux1RxJDLD252IDFmTOABSBIQ
	 u/924r12E8vPA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XcjQumKtABPp; Thu,  4 Jan 2024 20:35:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0BB0832EB;
	Thu,  4 Jan 2024 20:35:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0BB0832EB
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 0BD111BF853
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 20:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D52134360D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 20:35:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D52134360D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rXbzJoz_Ha2G for <intel-wired-lan@lists.osuosl.org>;
 Thu,  4 Jan 2024 20:35:33 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1003B4360A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 20:35:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1003B4360A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AA47E61805;
 Thu,  4 Jan 2024 20:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56D1C433C8;
 Thu,  4 Jan 2024 20:35:29 +0000 (UTC)
Date: Thu, 4 Jan 2024 20:35:27 +0000
From: Simon Horman <horms@kernel.org>
To: Jan Sokolowski <jan.sokolowski@intel.com>
Message-ID: <20240104203527.GM31813@kernel.org>
References: <20240103141115.9509-1-jan.sokolowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103141115.9509-1-jan.sokolowski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1704400531;
 bh=Lx3dFp23qsqlF6j+qme3KDLOLqwXoHkGRSPiJLEEph4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z26dCf67Gxllq7qbzGE45rXaQxZsqa59e8l371rT/8TOmPRNUokhKWvrTGrtuUvDE
 /F5/bVd/GXEO5Wj/xPJTxSwC11O3hazw+YUttJz+vPnm0qsJf0rxITUtXWzYRqvjb8
 GcA9r/77cPsdhYeTh4uZ9cK3ykN4cMKYsL/wf8cJM9+wbNPZzcWmudDDCrdqF7/DE2
 eNvlGlUHta/vpyTDYaoamFcrDfbJoho/quKlM2o6dj9C0twSiEWvNWEY2/8G5ZxZeu
 gXi3coLosWIEi9cvVvYdGolhnTfEJBK5Yx0zN+OzOazyqEh/DCnX5XEOWnDTvkYoxp
 JSPHypJ3hdtnQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Z26dCf67
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: Add a new counter
 for Rx EIPE errors
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jan Glaza <jan.glaza@intel.com>, Aniruddha Paul <aniruddha.paul@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jan 03, 2024 at 03:11:15PM +0100, Jan Sokolowski wrote:
> From: Aniruddha Paul <aniruddha.paul@intel.com>
> 
> HW incorrectly reports EIPE errors on encapsulated packets
> with L2 padding inside inner packet. HW shows outer UDP/IPV4
> packet checksum errors as part of the EIPE flags of the
> Rx descriptor. These are reported only if checksum offload
> is enabled and L3/L4 parsed flag is valid in Rx descriptor.
> 
> When that error is reported by HW, we don't act on it
> instead of incrementing main Rx errors statistic as it
> would normally happen.
> 
> Add a new statistic to count these errors since we still want
> to print them.
> 
> Signed-off-by: Aniruddha Paul <aniruddha.paul@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

