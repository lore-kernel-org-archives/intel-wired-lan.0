Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25602C44501
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 12:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B37F1606DE;
	Wed, 15 Jul 2026 12:29:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Yv4qIZYXiJn; Wed, 15 Jul 2026 12:29:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 836506069D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784118558;
	bh=vCwQnp8htPs9Eh/MP3qfpJZkYwRAjQYwif3i4a2+SwI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wcIYwdMRnySq32EcPSPmeL8/IO6X4zqj0gCl0MZhRuASN+qSzHSTkoofKDXSIrv6+
	 vqIkjA4V3rhNrYH+1Hd7z4fvGxtj81jIS6spaRvgLG26r85RrJs7LQVhTN2pee7LOK
	 Nwb+erYNh59zGNMHO4UizuMqg0X73NGsSnOZtP17J9lu+vsmzl342pvRT36pRy6hPl
	 8dlw30mV1JRUVR8z0pItNel34/RN1eny3r5xGLgkcsANgftDFl2BlAvyb8C0TuD04u
	 2dIxubltTcUTAYzWrqHY/6uPb6aA65cYT/dYv9bxh0rJHgQ75yvcxiMCv9Q3q/axx/
	 S8veKqm4VZWAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 836506069D;
	Wed, 15 Jul 2026 12:29:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B85CF150
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 12:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B61AA40675
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 12:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AhVwt0l4o8mw for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 12:29:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1734C406A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1734C406A2
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1734C406A2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 12:29:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 88378403EA;
 Wed, 15 Jul 2026 12:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DAD1F000E9;
 Wed, 15 Jul 2026 12:29:14 +0000 (UTC)
Date: Wed, 15 Jul 2026 13:29:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, pmenzel@molgen.mpg.de,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260715122912.GA1922694@horms.kernel.org>
References: <20260708100609.331976-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708100609.331976-1-jedrzej.jagielski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784118556;
 bh=vCwQnp8htPs9Eh/MP3qfpJZkYwRAjQYwif3i4a2+SwI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ibWP1me+C9M2e4B3J9HI6qQ9QDBKE7obHJnMhklhtLq72Ybk1GX2dMAkKHnTV/kyS
 Zql0VyMkW1z9lIrcUmfWXZOJwU6G4dbEC1icKFEseTjUuiTNbxTKVEs9VKB5B8TzTM
 DRRvws0FniLRxa1ei0fHlgkUALm7H6DFlhX7WAynb09XbzRschrKbUXD09fR9aW9eo
 0yX5DQxrde8Vq1F72MH7goOubyyWPIBiTRB6VDU3RNRI6AjsQ3Lz8lsKSPglC+o8va
 UfHQFV6VoM7NemgeICebjEfJYxqImB4BuDshnQ7qIPWjQjGyPjKrKlueNT7HVEyy5j
 G9qlIuT/wmEyg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ibWP1me+
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: E610: force phy
 link to get down when interface is down
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

On Wed, Jul 08, 2026 at 12:06:09PM +0200, Jedrzej Jagielski wrote:
> For the E610 family, similarly to the E8xx adapters, the default behavior
> is for the PHY link to remain up even when the corresponding OS interface
> is down.
> 
> Add function setting down the PHY config IXGBE_ACI_PHY_ENA_LINK bit
> what leads to disabling PHY link.
> 
> Now ixgbe_close() needs to share some of the ixgbe_watchdog_link_is_down
> code so move the common part into the separate function.
> 
> Align functionality with the implementation of the ice driver.
> 
> Let user to configure link-down-on-close enablement through ethtool.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: apply Paul's notes
> v3: use e_err

Reviewed-by: Simon Horman <horms@kernel.org>

