Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E274C624DB
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 18:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 054BC605E4;
	Sat,  5 Sep 2026 18:32:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hqk-pNx63V6j; Sat,  5 Sep 2026 18:32:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5FF29605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788633172;
	b=GkOGBFpE2sr3KPIzc8Hdgv/F6OOR6lN35AmosQ4w1HMkfARGr4VfeaFkPLqp5VtXeeS3
	 AA3Jq/0tm46M92sNR4DqGE4D9YrOZ2oDnKdcxVaxDzjuD3FBUHROcAxcP4S2wGSKOnvNZ
	 RCj8XOUfBnU4lwc0B8TeejKY3GuF5vqWcoft1XfvI0NbrFSZFNpkb5Eyww8cfLT+O0PO8
	 bg8Ig1INgF698U1TF2pluBk/v5eqCsFLhLtR4GA+4hW0J1s8ISFJdSqsAgIR3CdNR2H3a
	 QlYWQFjXum7o6sp5Uad4TRJL9Z6dB5WHlaF5xG0k7e1djz/Va3A2KB+FkyAtlGHR77w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788633172;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CRbRvK6UjtwLjpKRLYyhoyHibVjGq4RyyAA88+58iEM=;
	b=X3egVUnN40jOEaO2KeWxyqb1QthIcT4/uzYzj3mk0SJe1d4nZ3nxcfAJl7IVq/bqVfe2
	 ADR+M6mvivMCB561dMSEVyoAF7ajWBpMtGRQNl8y2eNbBIF5LRgbV8J1D2pqLT4RVkW3P
	 Zu0F0RNKHtauv6HAm6pWgGQeAflKjiR+My3wrz2U3QgRs97S5EtxKYxo/3DD508y9Egn1
	 9cjkZmXSmyLD5hp9II9tZE4GF4xfyv8VFlMPoDKSlXKzn1p/Tv8D/dvvAqlBAiAppWjt2
	 xX71fYe1cXvdMnN2d4yg6r0u6dMdgdzsXF28NLHmWWHltqxJBOEabm6GjQhcd18zjgQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ml/3Fl19";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788633172;
	bh=CRbRvK6UjtwLjpKRLYyhoyHibVjGq4RyyAA88+58iEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nvJ3x6gE31PJmecfbIZJHE9Yp/j79sdZtFx1jGL6WeTtgpGxPznAVAeYdZ29cJ208
	 JV6xxmlXMJ6RyOEGf5LDBA6+qo33BRTuhWbCo92Mp0OSU3egjQU9HIHFXYuMQ1geMe
	 U3zoCqBUQHkuMOxT0+2uQtydR9DQEFM9w+cUzBoj9C/nqE+FXu1UbpdojS6Ut3vg8g
	 36fOs63tmjewwyqKYzO8TkK6iUKCjnmP1vgjx5Ud4BZAyBwmwHrG4Abg53lNGSn4PY
	 AaSX65POJnqZRnQ+Hd/qaOWZBghfuLGCUWXH49gS+525GCpA+k4bnP6wba9h8kEeuY
	 P4GqiEELURpbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FF29605EF;
	Sat,  5 Sep 2026 18:32:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 07FFC279
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 18:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDD09605EF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 18:32:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnssScR2UuDD for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 18:32:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 31F25605E4
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788633170;
 b=rAkvyhFaai1LeMz698X/2SG31RGqPE03x7TZOT0e+lC0M7uzqQNrlgDImboeVqt9bZ/h
 px1FZmITHq2gU1ftL036Zc2L5PG8a6yjXst4JQbK/IncHgd+dTkcwRSxJkABy5fASGYqQ
 fCexUvQgKoeTrTLJZE+sJKfakt1GgcbTc4zpLg6pCaES0xU7ty2ui/vHDxy2GviuXcLQq
 vriIW11JRPog4GjMgUkiyMIVS1ahqtCM5FBeu7xrV4K/9aCJnIxwmC+F18TxdA/7ZSHlK
 24X/qdb+Hsn+epo2lha9mJJtH9b7rzKcQHPEXDyZU+1Dd38jQS2CwRHSAd1Wut1lSOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788633170;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=CRbRvK6UjtwLjpKRLYyhoyHibVjGq4RyyAA88+58iEM=;
 b=D9o4vyQcyOnnrhl3CNw7qg2sVy+MrUH9SfZlZjH7S3GzyBlTXAyuqFL974jrJnkyF50O
 VOs6hbpJ2CpC303UGe7evAeHYiI2UDyWm1cdrNV2YCoryoTOh/wRvNbhWROMXRZgrk7/4
 BC5hviErDXH0uMP/8OMIsXPQlMvcdal/DqCkVw4O+Oj4yK07xlQYC9+jigtMuVElfO4Vf
 dkzfOGJoYgiGCqqMlPup+RWQvQ4jeUlbE8fhYzP7yDZu+xHWKt+KA8UVNCJCPxQKa4ZqY
 t3sDxQxl4jABtLVU9xQNzSnVFGWQ32MBFKW1sLD4RJyGtV3IMuy5+VUMpHquLvrm6Jg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="ml/3Fl19"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ml/3Fl19
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31F25605E4
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 18:32:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9ABE14177D;
 Sat,  5 Sep 2026 18:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D6B1F00A3A;
 Sat,  5 Sep 2026 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788633169;
 bh=CRbRvK6UjtwLjpKRLYyhoyHibVjGq4RyyAA88+58iEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ml/3Fl19d0QsBNvy/AL8dMr3K9xF5JAUNzOBLWScXa4qlLIWoigw8ieHz6cP8Mf3a
 eM7YVxzy0qP1CUHWm+Xv1reHtCv/EjAdDTEv8V2j7TJL+vWQqlhApO1+0dUvkhFnGO
 j5mz2BxuhH7IZYJAcNxtjblbpmm2/TxhsDBaOucSG+pk08z0nbT9Bp0GFT+Tl47cuT
 pmlflB5Dd0p6u9NTwVzAx3b/2eMPtvi+swCr4KhNJNMTWldnNXX5GtGZhfbw2M4wrV
 BVZmDfcInLYQi/MR43+MACzy7tt1xKdmOqG0SKGEgVv2vTmbSEW8LDzJZKwF7evFQd
 Dr76A/hi6FSCw==
Date: Sat, 5 Sep 2026 19:32:45 +0100
From: Simon Horman <horms@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Message-ID: <20260905183245.GD40544@horms.kernel.org>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903132037.81346-3-ynorov@nvidia.com>
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

On Thu, Sep 03, 2026 at 09:20:36AM -0400, Yury Norov wrote:
> The function has 3 callers, all except one explicitly require
> pf != NULL. Add the corresponding check to the remaining caller,
> and remove it from the ice_pf_state_is_nominal(). It makse the
> fun function a one-liner.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 73996e3022ef..6d5b8acc4764 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
>   */
>  bool ice_pf_state_is_nominal(struct ice_pf *pf)
>  {
> -	if (!pf)
> -		return false;
> -
>  	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
>  }
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..168d85f9477f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
>  
>  	pf = pci_get_drvdata(pdev);
>  
> -	if (!ice_pf_state_is_nominal(pf)) {
> +	if (!pf || !ice_pf_state_is_nominal(pf)) {
>  		dev_err(dev, "Device is not ready, no need to suspend it\n");
>  		return -EBUSY;
>  	}

Is the new condition necessary in ice_suspend?
