Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5058CCAC587
	for <intel-wired-lan@archiver.kernel.org>; Sat, 13 Sep 2025 08:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 034B4412B6;
	Sat, 13 Sep 2025 08:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABg_zSon4XNe; Sat, 13 Sep 2025 08:51:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C26F541225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1757753503;
	bh=e70Pub+7lQNfU1hbiyc/17keNixDJUk4Sgdh9DyqFYc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NJsYb76mYqKYfPiDZbIu49blPN2SbEpwx0A2Vd5m31Srchun77ie0Y1mxJt52bEq7
	 O3cj4pW8S/dPVNjPTVAADStouihu8AChZz0AVWwE7vqIwU59x5X6BowSeN7jd1lOlm
	 bHHCtj6541rYfnOgv4Wx7Ub+CZl3/MIlHqN0P5pzbMGXTJ+d5SkgBmBQGf88qM0Frf
	 qzmoSpnZ17hKiG4JbaCGd2bOuhkeZ6BLiT2BY7Wi9Z/S4LduDYEOtUrqxjOHLg95YA
	 /3zw8nZM87a2Ub3MVEOvdc6DrbYyy3CVSHNTTRdyYpFY6UmO1tJ3sRBsgUJwVBxH2h
	 uEm633xwsHbdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C26F541225;
	Sat, 13 Sep 2025 08:51:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E80A512D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Sep 2025 08:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9EBB411B8
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Sep 2025 08:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAbhojRIn-Ta for <intel-wired-lan@lists.osuosl.org>;
 Sat, 13 Sep 2025 08:51:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4529B411B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4529B411B6
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4529B411B6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Sep 2025 08:51:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 95E436021A;
 Sat, 13 Sep 2025 08:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253D0C4CEEB;
 Sat, 13 Sep 2025 08:51:37 +0000 (UTC)
Date: Sat, 13 Sep 2025 09:51:35 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20250913085135.GH224143@horms.kernel.org>
References: <20250912080208.1048019-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912080208.1048019-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1757753499;
 bh=2e3UV13BBEWqEXcntHUCbZiuIVL35wadRBGo5j7gG5E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JaupoKaJNLEWC7ucUrTFuPboQoZMIV2QKo9hMKcOh9Zi0wDDCmYfEFRd7vabnZ224
 ICi1NCwC9cbmY19ypmAi7r+x8GZYILCV8GaZTo8LKrUYU0Jiys5y6zu4IiQDkxMTxs
 72eew2uTONqI5cUESHKi7QkF7TznthTheAwuhEsiNjWGFRdK3BTGYIEJW4v9DhJDll
 Ep8HGqluBodsCxyqh0As8BOn3TIgO2yGSY0lT1AMjYWCWmdjlRbLrue7fhezniC4fE
 gYY3mxJjrFIhHSnOHkEJyxcYVLkEMa+IOw6sOYFOYrj1/bgqncS3a7CHPceoq5fyAa
 vxh+4TrvSx0tA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=JaupoKaJ
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] iavf: fix proper type for
 error code in iavf_resume()
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

On Fri, Sep 12, 2025 at 08:02:08AM +0000, Aleksandr Loktionov wrote:
> The variable 'err' in iavf_resume() is used to store the return value
> of different functions, which return an int. Currently, 'err' is
> declared as u32, which is semantically incorrect and misleading.
> 
> In the Linux kernel, u32 is typically reserved for fixed-width data
> used in hardware interfaces or protocol structures. Using it for a
> generic error code may confuse reviewers or developers into thinking
> the value is hardware-related or size-constrained.
> 
> Replace u32 with int to reflect the actual usage and improve code
> clarity and semantic correctness.
> 
> No functional change.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

