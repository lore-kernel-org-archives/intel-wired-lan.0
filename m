Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D68FDEE25
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Apr 2026 16:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6884683C61;
	Thu, 23 Apr 2026 16:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jRip8PdqSoVn; Thu, 23 Apr 2026 16:39:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A2A283C66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776962345;
	bh=u494m2QsmyvCeAFzlRqosZ36tvsY2a+RrGFCd8+VKWk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I4mBnGGDvqjPOP2RCCyuAu/2psSGiEnETEhfImHSzOHYqOHz7tn28uSfq3+mr3LGM
	 Z+uc7rLiuTpbgvj91Jsd0PmE6y/y6Bu1BIudVAHAzr0/U/S+qzdftrf8B5khIYBgGX
	 /Qgb3GzNTyM0rWa/TPhxsAnwEcm/wAZf1Sro0j7gjGJbfuX4RgmncRIyMcLO3uGUeF
	 COct1C1Fwk9pE/pRaS1jeK+DRgQKnyNgV65R7umgRq6fWThWk5Hx3vyjjKs0LCNoS8
	 xh6wDvpr7PX9UTYhITML04ijn15z9BxdxIJDl3LblDqVwROcmrYJ21n5j7x7pPp1WG
	 X+evfFR6CT/kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A2A283C66;
	Thu, 23 Apr 2026 16:39:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7ADC24D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Apr 2026 16:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DB9583C62
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Apr 2026 16:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vIIoIzPHu_lc for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Apr 2026 16:39:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B1DAC83C61
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1DAC83C61
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1DAC83C61
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Apr 2026 16:39:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D00E60139;
 Thu, 23 Apr 2026 16:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A192CC2BCAF;
 Thu, 23 Apr 2026 16:38:57 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: boolli@google.com
Cc: 'Simon Horman' <horms@kernel.org>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, decot@google.com,
 anjali.singhai@intel.com, sridhar.samudrala@intel.com, brianvv@google.com,
 emil.s.tantilov@intel.com, stable@vger.kernel.org
Date: Thu, 23 Apr 2026 17:33:09 +0100
Message-ID: <20260423163307.989421-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421051641.370436-1-boolli@google.com>
References: <20260421051641.370436-1-boolli@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776962341;
 bh=kX7pLScbuR1BMQ6cyntXkY/4oiaKg/6C0QQKGD8dxYU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GwO+A49bwE2MsJ7xV6/BsjCM3Wxnx8UYUgghMEM9eyxNa8NKgfiWD2+u8waB24W4c
 3sReF8vwvRm2JeGL5g9msoCkyHvJ+jJm1SfbxQ/H9DDSXxBMHe1lGce++QHmhqquc/
 mbpw/dlDCSTlJgWH3ksGHSDRKjN1x1umaLumAJYnOm1Urv5LbFTtOlBSY0kDk1ad7/
 O6MOuVEXHwtL9qmUVP+cmL0p2E1IdgPghQpzvc413XYcyapByymwcHu0La6UnDkBv1
 0Tg0lEy0znq11eYibfW2KPyZENNTwVG+hz2lgulkjUmEb2RtfKRFwYoZo+vtU7wL2A
 fNSHjQ3A++Qtg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GwO+A49b
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: do not perform flow
 ops when netdev is detached
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

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
idpf: do not perform flow ops when netdev is detached

This commit adds checks to prevent crashes when out-of-tree modules bypass
ethtool core locks and call flow operations on detached netdevs during a
hardware reset. It introduces netdev and netif_device_present checks in
idpf_get_rxnfc and idpf_set_rxnfc.

> Even though commit 2e281e1155fc ("idpf: detach and close netdevs while
> handling a reset") prevents ethtool -N/-n operations to operate on
> detached netdevs, we found that out-of-tree workflows like OpenOnload
> can bypass ethtool core locks and call idpf_set_rxnfc directly during
> an idpf HW reset.

Is it acceptable to add defensive checks upstream solely to accommodate
out-of-tree modules that bypass core kernel locking?

The core ethtool infrastructure manages locks like rtnl_lock for in-tree
callers to guarantee safety. Modifying the upstream driver to paper over
locking violations in out-of-tree modules might contradict upstream policies.

Simon says: If this is to address OOT module behaviour then I am concerned.
            And I would suggest that the correct approach is to fix
	    the OOT kernel module.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index bb99d9e7c65d5..8368a7e6a7544 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -43,6 +43,9 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>  	unsigned int cnt = 0;
>  	int err = 0;
>  
> +	if (!netdev || !netif_device_present(netdev))
> +		return -ENODEV;
> +

Could this result in undefined behavior if netdev is NULL? Before this check,
np is initialized using netdev_priv(netdev), which does pointer arithmetic.
If netdev can genuinely be NULL from out-of-tree callers, should the
initialization of np be moved after the validation?

Simon says: I think the actual problem here is that netdev is never NULL.
            And thus the !netdev check should not be added.

	    Likewise for idpf_set_rxnfc()

Also, is there a time-of-check to time-of-use race here?

The netif_device_present() check is performed outside the vport_ctrl_lock
critical section.

If a concurrent hardware reset detaches the device and clears the present bit
before acquiring the vport_ctrl_lock to set np->vport = NULL, this thread
might pass the present check, block on idpf_vport_ctrl_lock(netdev), and
then dereference the newly set NULL vport once the lock is acquired.

Should the device presence check be moved inside the vport_ctrl_lock
critical section to prevent the NULL pointer dereference?

Simon says: This seems to be a legitimate concern.
            Which seems to further suggest that the problem
	    should be addressed by the caller.

>  	idpf_vport_ctrl_lock(netdev);

[ ... ]

> @@ -349,6 +352,9 @@ static int idpf_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
>  {
>  	int ret = -EOPNOTSUPP;
>  
> +	if (!netdev || !netif_device_present(netdev))
> +		return -ENODEV;
> +
>  	idpf_vport_ctrl_lock(netdev);

Would this be vulnerable to the same time-of-check to time-of-use race
mentioned above, since the present check is outside the lock?
