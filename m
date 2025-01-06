Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB805E77198
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Jan 2025 10:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96CB5404D2;
	Mon,  6 Jan 2025 10:24:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GDTOJJ4twioC; Mon,  6 Jan 2025 10:24:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B66A404CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1736159082;
	bh=QVM6UQK4zxDAnM5eQGWFi8Dex3X/KDH1nzdjaC9KxyA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yvUqY+pzmMcyZMYh8kVLKUSC8crp1R5tnDRFlnVNrBH2L8702WzzlDFcTxFj4TZtw
	 IY2UEcS8kIW52uBiufli5kWIktFF6TZ8Hc6yh6XRR+UZpCXND1Zew3smDQ41mkNDLk
	 x48HjssXiiPgKfNoIaJ0aizm6yiBRTuL//I7ecNSxNvCnH/RGGyXfqzFVJkzVgvdgh
	 SceHwBAiWRlsd8yRBtHADwO3t52dul6YSJ6qJhhtuQUswcJ9cg3Ykt/b9P450urR7t
	 9w1cHmHdDmuuiFPWm254k1ceCl3q8FO9zLedpBvqBa09Uufu4OiAhpsnZWQTtprirz
	 a29Zk8dwueu0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B66A404CA;
	Mon,  6 Jan 2025 10:24:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B96766B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jan 2025 10:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97C5C404C5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jan 2025 10:24:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0LCHHOXYxuA for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Jan 2025 10:24:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7C0CD404C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C0CD404C0
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C0CD404C0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jan 2025 10:24:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1A44BA40EBA;
 Mon,  6 Jan 2025 10:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33677C4CED2;
 Mon,  6 Jan 2025 10:24:37 +0000 (UTC)
Date: Mon, 6 Jan 2025 10:23:34 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
Message-ID: <20250106102334.GA4068@kernel.org>
References: <20241219115516.11708-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219115516.11708-1-przemyslaw.kitszel@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1736159078;
 bh=DtpVoJYlWiG9wZI+v93lDURF31tn9TWO89RSuMfJ2iY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kVID/dzuuisC0G8XHubGgG++O29S9oMg28h4hIJ04s3AXdLtBYAG3b16AThO37AFH
 Wp+weT/OVg08EHL8UhxtsfACetB381OvY6ZNnc/GWZQ/kp4lgoBDQEhR5rLOyGlTG0
 5y1d2MzBHR2Lam6JQ3PUlfM8VNGedDXnlTXUC+dLuPFWUEjTqkGmXga3cJjS88RY8J
 ftJ2j+pWbAI20cScB0u0RH9epV1/hLWiEkwn1yOLw95bE6gQ45UYdGachRxwMoZgyf
 TpQZYaAe7UvnfXcblwTp9+P0hYHHZLzxpugGBssi72R0uqe30RDgQIB5ErlzFkj9Mw
 KmJ8kqT3FxoeQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kVID/dzu
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] ice: fix
 ice_parser_rt::bst_key array size
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

On Thu, Dec 19, 2024 at 12:55:16PM +0100, Przemek Kitszel wrote:
> Fix &ice_parser_rt::bst_key size. It was wrongly set to 10 instead of 20
> in the initial impl commit (see Fixes tag). All usage code assumed it was
> of size 20. That was also the initial size present up to v2 of the intro
> series [2], but halved by v3 [3] refactor described as "Replace magic
> hardcoded values with macros." The introducing series was so big that
> some ugliness was unnoticed, same for bugs :/
> 
> ICE_BST_KEY_TCAM_SIZE and ICE_BST_TCAM_KEY_SIZE were differing by one.
> There was tmp variable @j in the scope of edited function, but was not
> used in all places. This ugliness is now gone.
> I'm moving ice_parser_rt::pg_prio a few positions up, to fill up one of
> the holes in order to compensate for the added 10 bytes to the ::bst_key,
> resulting in the same size of the whole as prior to the fix, and miminal
> changes in the offsets of the fields.
> 
> Extend also the debug dump print of the key to cover all bytes. To not
> have string with 20 "%02x" and 20 params, switch to
> ice_debug_array_w_prefix().
> 
> This fix obsoletes Ahmed's attempt at [1].
> 
> [1] https://lore.kernel.org/intel-wired-lan/20240823230847.172295-1-ahmed.zaki@intel.com
> [2] https://lore.kernel.org/intel-wired-lan/20230605054641.2865142-13-junfeng.guo@intel.com
> [3] https://lore.kernel.org/intel-wired-lan/20230817093442.2576997-13-junfeng.guo@intel.com
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/intel-wired-lan/b1fb6ff9-b69e-4026-9988-3c783d86c2e0@stanley.mountain
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> CC: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v3: mention printing change in commit msg, separate prefix from the debug log (Simon)
> 
> v2: same as v3, but lacks code change :(
> 
> v1: https://lore.kernel.org/intel-wired-lan/20241216170548.GI780307@kernel.org/T/#mbf984a0faa12a5bdb53460b150201fdd7cc1826a

Thanks for the updates, much appreciated.

Reviewed-by: Simon Horman <horms@kernel.org>

