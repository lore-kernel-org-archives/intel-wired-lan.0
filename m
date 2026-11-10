Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8659606A33C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HkHlOsHN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUmQjUpo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83C8940A0E;
	Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7p2vH4U8J0Ek; Tue, 10 Nov 2026 17:53:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A69F140A03
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794333207;
	b=EwDpjTdgBhvFNxB/sl/0rDqRW3r8iG28626aDSJkotxlwv4JP7QS4nYLaK0SQ8UfTr3R
	 pUvUtQ3BjAz5bCh6V7IS57NaH0kl3RJwePwohO4sPFRhogYbSA3ffpcZTre7RlaCmz8fr
	 dYETui8uTsOaTemBEzeutP4F1UcmT+xSY8N0z2akKrI9s4jhH7PltDnl3Eo0luxGk4M2e
	 atFCR1Pdy+/cNSnJmNNahjt1w7J+issE5d/h1xZFDg5WOU2TxlRW7WK19We02oD8PxG+1
	 ETO33+vBGwq2XlN6/LjPb+GaUAJQMToBrMwUmKZQw3GYnNhe9aZsOrfk4Is7QN1tJSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794333207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vewQ1rC3gNo47kqP/Hx51b9scv8rhIYW439HT73ccWY=;
	b=oxE8pDeXko8RUHOeIaWjQD+5UWv9sGvHoaHmQpx2bSzLeFdNWMbon2fNZjtzrdnT7IaO
	 WFnkvwJni8FMWY3pgZz8AZGWfD+dtngXrsZighQkWkL262kBKLXLiOEUlDxLje96hMHkg
	 N5BKv+xI5acpGedGKioZohFUU85pieZOTn03jqtluDZQm7v3fje7tgbvUmGQZE0DQt5Pf
	 NXr0t+iBHhpO3kdmwyj6hcN7FxF9YzXjoMV4glTnYa9iiQ/7uZlfQ8S7tH+UzOsFwDZDU
	 gll4pz+FdFIId7/+RpBDctyFth7LC/SoO7m84FdK2bHPbsYtCkxTqSTC4GaCATaHNFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794333207;
	bh=vewQ1rC3gNo47kqP/Hx51b9scv8rhIYW439HT73ccWY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HkHlOsHNlotKkgzaRdfgQy1D/+cxBd85I0blGJwch1udLAxrEUGuzpO7gbXgvzifB
	 uRb/Y4SEVcPWadfbcXT/OJ7aCA3FB7mphFW66wdjSjm84a1wLFkGWE80YX4/pBE5vF
	 J0NHLk7+dCir/kbN/5ImZxLq1TIQfZ8BYkU17Nhn1z9ViJBjT/2DPx2DbjJC6BaTep
	 jMGvGv65eJ4itYrK/dk3nQKBWNejbDrocwrZBnYUm5IAoQjxbSW7X5yLi+E1nBKLM8
	 RCiOdina40aohY+4N7BvenK9ivvn0MICJYGnSuhyGLmlWvpQkgYDpa73K4lZ2tP2+l
	 pi+mShURsOpmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A69F140A03;
	Tue, 10 Nov 2026 17:53:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D20728C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13492812FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gqHgZfI699J for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 17:53:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D1B980D8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PUmQjUpo
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D1B980D8D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 04B44612A0;
 Tue, 10 Nov 2026 17:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D721F008A2;
 Tue, 10 Nov 2026 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794333202;
 bh=vewQ1rC3gNo47kqP/Hx51b9scv8rhIYW439HT73ccWY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=PUmQjUpoKeuGYcTvVsLI8aIfuaSttlsA2XHp/0wiEgY9Ld5vXFlAH8p5lkEA5+VOi
 UMFR3NMc19579X5GFYdkY2qwikGztNB/TNKkas/T8GnDCdqfiMieQzAyeQI+/j0zOm
 9bwRsDAkE8cIxyNJejyh+NeSmlhTi+mPOmYbJJdbQbvNV7xlMsrpcg8n2R5qpoF+q4
 ia4UAI6T+n+/wxf6fhbtSfjnEAN8TX9iKByUh4qjj70BYdvoMJimAmU0aXlPp7mAwB
 QJlzaR2YToBw6UBNA8x0wNacddFsIuuY8szdqTh1LGmL/q0vzr1JpAy6tHrklI+s//
 eRco5r4T4R1jw==
Subject: Re: [PATCH net-next 02/10] ice: dpll: serialize changes of the SyncE
 CGU registers
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
Date: Tue, 10 Nov 2026 17:53:21 +0000
Message-ID: <179433320107.994134.16333323653199953270@kernel.org>
In-Reply-To: <20261106121005.1327603-3-ivecera@redhat.com>
References: <20261106121005.1327603-3-ivecera@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a race that already exists in the tree, but it
  has no Fixes: tag and no stable Cc.

--

ice: dpll: serialize changes of the SyncE CGU registers

This patch adds a cgu_synce_lock mutex to struct ice_adapter, which all
E825C PFs share. It holds that lock around the CGU R10/R11
read-modify-write sequences in ice_dpll_synce_update_e825c(), and around
the ice_tspll_cfg_synce_ethdiv_e825c() call in ice_ptp_link_change().

> ice_ptp_link_change() does not hold dpll_lock, so it can already overwrite
> an update of another PF. RCLK callbacks are serialized by dpll_lock, but
> the DPLL core is going to serialize callbacks per (module, clock_id), and
> each complex has its own DSN and so its own clock_id. With that change, a
> test toggling RCLK pins of both complexes lost an update.

[ ... ]

> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

[Severity: Low]
Should this patch have a Fixes: tag?

The commit message says this race already exists in the tree. Before
this patch, ice_ptp_link_change() on one PF calls
ice_tspll_cfg_synce_ethdiv_e825c(). That function reads ICE_CGU_R10 once
and writes the whole register back twice.

At the same time, on another PF, the path
ice_dpll_rclk_state_on_pin_set()->ice_dpll_synce_update_e825c() does a
read-modify-write of R10 and R11. Each of these paths holds only its own
PF's pf->dplls.lock.

Both paths reach the same CGU. All E825C PFs share one ice_adapter, and
the secondary complex reaches the primary CGU through
ice_sbq_dev_cgu_peer. So a link flap on one port can write back a stale
R10. That undoes a mux or divider change that another PF just made
(S_REF_CLK, ETHCLKO_SEL, CLKO_SEL, *_DIV_M1).

Both racing sequences seem to come from commit ad1df4f2d591 ("ice: dpll:
Support E825-C SyncE and dynamic pin discovery"). A related fix,
bf6dbadb72b9 ("ice: fix PTP timestamping broken by SyncE code on
E825C"), already has a Fixes: tag for that commit.

Without the tag, stable kernels that carry ad1df4f2d591 would probably
not get the fix for this race. Could you add the following tag?

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")

Another option is to split this patch out of the series and send it to
net.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
