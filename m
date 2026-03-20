Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1D91099B38
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 19:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F04961BE1;
	Fri, 20 Mar 2026 19:20:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6TZhhx_asoqm; Fri, 20 Mar 2026 19:20:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3A6860B75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774034436;
	bh=YTMrRPQOylo3Zjnk+dXmlKhaGMxma+GmsmmgaaQD8gg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J7PI6jb8ndksTZeclFeAW1DzoFaJwoxSiDsp7hs+Ak0w7Uh5WMHUzWz5JU3fXwu2t
	 Zc8FwwgKDz3w4IzfImSNvsRblxa9ljbKFhJkRZ3ZxubXVf0/I7Biv/E7xrJte9CuqA
	 tL9w1r71VqeZXbgzU2EJPGP+VBBTQYMFalorCAe9SS1ygkK3czlhOeHADt9DnGYSMQ
	 7QRyCt6+Hx/khdH0TkqzxxLTVCF5m0hSrxcenaXxbMiH0oMDdgm3w8vMigi6xmF1nw
	 vNehjWktOSlfeMimEnW13K9HfGWFnk0BSHw6DTklfODAehfPHudVvCCpxpyheG9Y+0
	 pMwQwCUUD8Igg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3A6860B75;
	Fri, 20 Mar 2026 19:20:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 322B125C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23A3861BE0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0ky5NRbtNca for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 19:20:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 41D6060AEF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41D6060AEF
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41D6060AEF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:20:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C9C6160126;
 Fri, 20 Mar 2026 19:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313B4C4CEF7;
 Fri, 20 Mar 2026 19:20:31 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 paul.greenwalt@intel.com, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com
Date: Fri, 20 Mar 2026 19:19:04 +0000
Message-ID: <20260320191903.161126-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320050552.422715-1-aleksandr.loktionov@intel.com>
References: <20260320050552.422715-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774034432;
 bh=OhEVl68IJXW23s3giI06+FZaV7LwoTDtzK/9RZFAhsE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ti0NtSVDUyLBzfZ+62YK5zqAfPsUiJgWDPmFm6Bh3YGi4F55eWMokv+C4kcoIGY87
 M3GCy5VgEVaGwYwScNb0F0N4Sx6H0GQJ44aCfgwAo/aWbjYGkgq32z4gjm+f6/DG4+
 cP7gykXyWr7VPiKXyBor0vCrUBsgGEPsCNsnqsQnn89xIoUhsRAy+AUAB8pb+uzCNd
 JuXSV81Kevn5NnyWgH434bbVgNllO0OwT8oyZUi6pgpbVF+uuAOK0Fov60PRmvHY/D
 /M3iRZaryh3FIYmVD4IJvpV+grZoYyK+U5d5LShNB7soT9cjlkQhVXURLOqEramwgZ
 1oQGfRpISOkzQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Ti0NtSVD
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: update
 ice_link_mode_str_high() with 200G
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: update ice_link_mode_str_high() with 200G

This patch adds string entries to ice_link_mode_str_high[] for 200G and
400GBASE-FR8 PHY types to fix ice_dump_phy_type() debug output for E825C
hardware.

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index ce11fea122d0..7cdd6a043d86 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -84,6 +84,17 @@ static const char * const ice_link_mode_str_high[] = {
>  	[2] = "100G_CAUI2",
>  	[3] = "100G_AUI2_AOC_ACC",
>  	[4] = "100G_AUI2",
> +	[5] = "200G_CR4_PAM4",
> +	[6] = "200G_SR4",
> +	[7] = "200G_FR4",
> +	[8] = "200G_LR4",
> +	[9] = "200G_DR4",
> +	[10] = "200G_KR4_PAM4",
> +	[11] = "200G_AUI4_AOC_ACC",
> +	[12] = "200G_AUI4",
> +	[13] = "200G_AUI8_AOC_ACC",
> +	[14] = "200G_AUI8",
> +	[15] = "400GBASE_FR8",
>  };
>
>  /**

Are entries [13], [14], and [15] missing their corresponding hardware
definitions?

The patch adds strings for indices 13-15, but ICE_PHY_TYPE_HIGH_MAX_INDEX
remains defined as 12 in ice_adminq_cmd.h (line 1047), and no
ICE_PHY_TYPE_HIGH_* bit definitions exist for these three types.

Other driver code uses MAX_INDEX as a bound:

drivers/net/ethernet/intel/ice/ice_common.c:ice_get_phy_type_high() {
    for (index = 0; index <= ICE_PHY_TYPE_HIGH_MAX_INDEX; index++)
        ...
}

This creates an inconsistency where ice_dump_phy_type() can print these
strings via debug output, but code checking PHY types based on MAX_INDEX
will not recognize indices 13-15.

If E825C hardware truly supports these PHY types, should this patch also
include the hardware definitions (ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC =
BIT_ULL(13), etc.) and update MAX_INDEX to 15?
