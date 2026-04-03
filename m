Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C02D730B2
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 12:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79B9281BF5;
	Fri,  3 Apr 2026 12:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MmkO-BCw1hlv; Fri,  3 Apr 2026 12:31:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB51581517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775219518;
	bh=Q/M48icekeh8xOht5oEcveKjZ0/Ewrz148HB005xr4U=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=A1Qt3EEwxOO9+oqvVGjfnY/oIi1pul9MS7ViZU8ck8NRqBoG1ELIh5LurWX3k5VG3
	 y/BgEkwiyUrOZDW7RarZIcA5lOtpbnUPMXVFsXKoHOt8O4sfjDIS0WIHESrKzbJRtT
	 eZ+5jdq+BthKALhe4vLFs+OuUHF4TZzAk7YHkAJ+UBFyWIMdjmgqN94IOmniDwfV36
	 L1qs/2TLMLuKxcRv5yrtRq+0icHTJmoTmbEIXgjJUbAC6S3ERyi3Qa9ckJX0Ojizhj
	 +IUIglMuJUuwwt1Qpd0C7qPly2NHBU7XJQY7LPYDfVdNsxw4hkH2bg+c6GR2J/Wct5
	 cQ81gAHn+UQPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB51581517;
	Fri,  3 Apr 2026 12:31:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2ABD21F3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 104F060A59
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AppnCUJS8Vmo for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 12:31:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7779D6090C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7779D6090C
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7779D6090C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:31:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E30A944093;
 Fri,  3 Apr 2026 12:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0018C4CEF7;
 Fri,  3 Apr 2026 12:31:54 +0000 (UTC)
Date: Fri, 3 Apr 2026 13:31:52 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260403123152.GA89018@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-4-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-4-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775219515;
 bh=C14Dn6CJWe28rasT0KhU5z40Y19aGc+j9gzla04hLYo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s2K6KcHABx4bA638WrXtQBf/nDjyqvYOB/ggWc3LF1r3dQJdfXnZgI/dTwL1yOHOU
 i+DBbxj7o8chwjW0hK1EZICNOYQxYUN/q5tvARBSRfK1N32D47zi3DBV/zHuVrvrN0
 +hblTTKe0QS9kaOF10sPL1VRQN/YjjYz6PLKxD/iJGsI+x4uwxkYB8iTdNiHyxId98
 p+LCPag0dt/BxeKSkmdvoPuviHdWLIh6BX7hRagaA4QDsUGsVMqgBCefKc0NX0Nj4r
 n3xScGWD4tsAgQWx3o5WPe9RAAmloz6+o1X++Tr6Y/3WwSmssoNTMJWL4Z/BJu2B5h
 GCHHfrbUeGUcw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=s2K6KcHA
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix PTP hang for E825C
 devices
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
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Mar 27, 2026 at 08:23:27AM +0100, Aleksandr Loktionov wrote:
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
> 
> Change the order of PTP reconfiguration when port goes down or up
> (ice_down and ice_up calls) to be more graceful and consistent from
> timestamp interrupts processing perspective.
> 
> For both calls (ice_up and ice_down), accompanying ice_ptp_link_change
> is called which starts/stops PTP timer. This patch changes the order:
> - while link goes down: disable net device Tx first (netif_carrier_off,
>   netif_tx_disable), then call ice_ptp_link_change
> - while link goes up: ice_ptp_link_change called first, then re-enable
>   net device Tx (netif_tx_start_all_queues)
> 
> Otherwise, there is a narrow window in which PTP timestamp request has
> been triggered and timestamp processing occurs when PTP timer is not
> enabled yet (up case) or already disabled (down case). This may lead to
> undefined behavior and receiving invalid timestamps. This case was
> observed on E825C devices only.
> 
> Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
> Cc: stable@vger.kernel.org
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

