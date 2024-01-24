Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95479C46CD2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Jan 2024 10:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 449F1851C3;
	Wed, 24 Jan 2024 10:09:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 449F1851C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706090995;
	bh=ULNLN8RrijfDv6ZNdG3S38hj3KiGJomkVzFwW3Oyi6Q=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=yh2nZr/glRXIKQ0B0eBvlAiPQcTesdU3ZFchjN0ApYH+tFG+Sc6T94CHhIrRTT6NO
	 VUkg3LpryZCIrTay7Dohs8BW8RvGJnHeI2K/XIgWAJZ1JIsUXES3U0/hfHX8TRZsHC
	 LMUrX4d071Fah4lzcAlcY9H80SvGFMHkUe6mz0OpCIA1hbORz9Als7XPyd3I7FfIHO
	 3nRQr/MFqBh+PUWJIg2gltmlbnWKEauhdl0lxYaj2CeW7xyWnY9UTydPAXeqpolVV6
	 iQ81mXg0oQfcBBZwuf5WxYS/ovrz5J/NNXP09xnGKqA128qVYOk9cXjF0YQa7j75md
	 Aco8vzfWHPung==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tij_MeRDw17Z; Wed, 24 Jan 2024 10:09:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82C42851C7;
	Wed, 24 Jan 2024 10:09:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82C42851C7
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id AE1A61BF391
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 10:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86C2C851B4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 10:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86C2C851B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xMZs0w2C3CD0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Jan 2024 10:09:53 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4CBF851B1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 10:09:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4CBF851B1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 83A1DCE30F1;
 Wed, 24 Jan 2024 10:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B83C433C7;
 Wed, 24 Jan 2024 10:09:44 +0000 (UTC)
Date: Wed, 24 Jan 2024 10:09:42 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Message-ID: <20240124100942.GT254773@kernel.org>
References: <20240123115846.559559-1-maciej.fijalkowski@intel.com>
 <20240123115846.559559-3-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123115846.559559-3-maciej.fijalkowski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706090985;
 bh=zaUBIOlL0lgA7E78oSNpzzMB7BJcp/PnNOWf3yezQOw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cRsVuLTeuCCKAPI8m4eqcinXQDn/mqSjYMU1JEP0coe/yTF9FzdJLGKutgAZQEs7H
 5Gbd4kFRg8RIos1M3RggintU4qXeO923MRdPFnpVBgoQCtQWwtyj5nfbTymvxzM9L1
 PdDpdgJkvQWW8nw1Zyv3X6Qhs4fL4N8Va22KoBdWa7nk5b5cGNopWrZTU4BETPYeC/
 dcm3JL442Q1mitWSe9SetPN4EvMwE42+SX3Ls/C/bJ6ER9EFAqgCt6Tvk3WK6xh09K
 +KGhO6vXiep2LEtnF+XZuCnrMm84GFXtZoMVQQZGKevGFLkA9lrlU0UNsc3CJhESSe
 nZIg+ej7kFUXg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=cRsVuLTe
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/2] ice: make
 ice_vsi_cfg_txq() static
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, magnus.karlsson@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jan 23, 2024 at 12:58:46PM +0100, Maciej Fijalkowski wrote:
> Currently, XSK control path in ice driver calls directly
> ice_vsi_cfg_txq() whereas we have ice_vsi_cfg_single_txq() for that
> purpose. Use the latter from XSK side and make ice_vsi_cfg_txq() static.
> 
> ice_vsi_cfg_txq() resides in ice_base.c and is rather big, so to reduce
> the code churn let us move the callers of it from ice_lib.c to
> ice_base.c.
> 
> This change puts ice_qp_ena() on nice diet due to the checks and
> operations that ice_vsi_cfg_single_{r,t}xq() do internally.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-182 (-182)
> Function                                     old     new   delta
> ice_xsk_pool_setup                          2165    1983    -182
> Total: Before=472597, After=472415, chg -0.04%
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

