Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8F1CD4F3D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 20 May 2026 18:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E16F41298;
	Wed, 20 May 2026 18:39:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vrGSkTeF1lUs; Wed, 20 May 2026 18:39:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E739B41291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779302375;
	bh=z/6d4XDsP8kzqaS2wZT45uE1TsRr5QPcLiTvEq5CEp4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uPg9/2n1ozbdksFnfftk5VopESh2L27cCb/VlSVIrSu+MLvBUZBKQAgpdXpYCHvDB
	 pW+HmxrklP4Ydb1mzPodZECnAaGWMKGSTzLGaOQ0nZaBN7KkpUYLOH7HK8kAzM+aRW
	 JLXjjXeQDIbObxPRI/pBIUZnA0DK/FPlxXwNQzWOy2vSgZJX6q8q5TJyQlsG+xuOn2
	 4cPIIs2CWsYF3mrGPedKXbIx2/vMrJ+KiN7R5RELONh5iPo2GAijtddf4aHAKRD3tn
	 2le5j3Uy/uMcj47BcCHbnc06U07jPLIE3f5HW9LR0bOLxsdvKeUi9hMatRHeyXFSKS
	 zi/v+aJHy8Etg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E739B41291;
	Wed, 20 May 2026 18:39:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94F9A265
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 May 2026 18:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 867D341291
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 May 2026 18:39:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u2CLbksevyL0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 20 May 2026 18:39:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 480B04087E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 480B04087E
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 480B04087E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 May 2026 18:39:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0CB043770;
 Wed, 20 May 2026 18:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD1E1F000E9;
 Wed, 20 May 2026 18:39:31 +0000 (UTC)
Date: Wed, 20 May 2026 19:39:28 +0100
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com
Message-ID: <20260520183928.GF988238@horms.kernel.org>
References: <20260520115213.10864-2-przemyslaw.korba@intel.com>
 <20260520183801.GE988238@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520183801.GE988238@horms.kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1779302372;
 bh=z/6d4XDsP8kzqaS2wZT45uE1TsRr5QPcLiTvEq5CEp4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YxN/XarZZPxmKvMiwPj489ukmgHFMGOrsVkFyl/ynf53vG7zGHp8ViqspWjlnRwOT
 qoZdVQJz8txRV0T774UZaKnd5hwRT7vU0vqdmrz14YL9vA8jd6AaB1bGjxyP02Ldp3
 reCYb+KUZC1vQwHD9lNqMSiW0OXxJDCmRRhN+elpD/K7mQg6OWyQRA612on5CptqmB
 Bmxtl9XkF7bz+b6VQw8FbabVhCgmnDq9y/vGLPY4SNanC7lPwS8NYGyzP8Al8A8+T1
 /BDmie27y2nPmVCftGN7zoyQyvio1+JS+pnu+cq4tL9xHAYLPVBNE/xo/30uUIT5Ka
 2+Hlp3yw4HC1w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YxN/XarZ
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: suppress DPLL errors
 during reset recovery
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, May 20, 2026 at 07:38:05PM +0100, Simon Horman wrote:
> On Wed, May 20, 2026 at 01:50:06PM +0200, Przemyslaw Korba wrote:
> > During reset recovery, the admin queue returns EBUSY which is expected
> > behavior. However, the DPLL subsystem was logging these as errors and
> > incrementing the error counter, potentially leading to unnecessary
> > warnings and even disabling the DPLL periodic worker if the threshold
> > was reached.
> > 
> > Suppress error logging and error counter increments when the admin
> > queue returns EBUSY, as this is expected during reset recovery and
> > not a real failure condition.
> > 
> > test case:
> > - ethtool --reset eth3 irq-shared dma-shared filter-shared offload-shared
> > mac-shared phy-shared ram-shared
> > - observe if dmesg EBUSY errors are gone
> > 
> > Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> > Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> > ---
> > v2:
> > add missing EBUSY check in ice_dpll_pps_update_phase_offsets()
> > v1:
> > https://lore.kernel.org/intel-wired-lan/20260520105311.5336-1-przemyslaw.korba@intel.com/T/#u
> 
> Thanks for the update.

Sorry, hit send too soon.
I meant to also include:

Reviewed-by: Simon Horman <horms@kernel.org>

