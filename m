Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC72C25B7C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 May 2024 18:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F38F64241B;
	Fri, 31 May 2024 18:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3zO7xTTaRZQq; Fri, 31 May 2024 18:15:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6366942419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717179314;
	bh=Oeb/LTpK8e0H/NVM2Bqv4Rm1hniUkaxcmsV1sYJeNiM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=1e/J24zaESuUY5kcVVV8V9Fu8h2W82viY2bk/EMhn/3YN8sb5Wy/uvZcRGfjewhj0
	 HdOe9T7fKsyA2Eo7CmvbYJYd0kBH1x8pLKPfa5AVGBLTMDOIsAVXWaStB3F7kEbzW9
	 OCA7UK5v4WbdHJ/LFxqd92vOtjZMZQ873LfN2niyQQxKBzJlBabvo6LbllzcQw6f64
	 byDYcLos2Aw43FFXmxOj1y6djoLCrDbV8yzaBVzdv7jvLF4N7+bHE7M0fhWsGlZVQj
	 HeB1l9ou/kmHe5QBTyrGP2WUbeTa8P//YS2vuxuZBW0+a1nECH2VdAMw/Ne27qRX6k
	 CeBGf4LFt3BRA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6366942419;
	Fri, 31 May 2024 18:15:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 8B2B81BF36D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84FD3606CB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:15:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9rXfWYyvWgt for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 May 2024 18:15:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B208F606AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B208F606AA
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B208F606AA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:15:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 55418CE1C02;
 Fri, 31 May 2024 18:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DDBC116B1;
 Fri, 31 May 2024 18:15:04 +0000 (UTC)
Date: Fri, 31 May 2024 19:15:02 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240531181502.GG491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-4-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-4-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717179307;
 bh=8A5AiCOfaCmfwQ8xPFJjOIOjqBcwPjrYEDrU5qXdxpk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b/i5CsIVOSt+67w1kCX0TjL69N2ang5LKzLtVcdo8ybBx+5vG4CpO5M29nwiKqZeY
 lTSdtKOeiG85q72Jp4eZeUEUmp/GVdnzgTJZnpGhIuJDH1pXL5XeM5UGcCsLkFQQZ4
 Z/oKj9p6pjxtRdryh3/l2TCY7ZwOWnHzhd8qAQ8aaB7ulUzQKOdKuBPGw8Bz0jA6Nl
 /XHfzIoYuLupATYjQQgQdF+rQhbwk2nMC4lD/+ftrs/gmH8+q9jPUivZZ228PgqUge
 h4vLXHoH55tEgdnXxi2B3vgZW0VAinoNJJVMPDi5s82rRQ6aYA5KGKd0KO3sxnA2/r
 /qJ2dcWakFH/A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=b/i5CsIV
Subject: Re: [Intel-wired-lan] [iwl-next v3 03/15] ice: add basic devlink
 subfunctions support
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
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com,
 mateusz.polchlopek@intel.com, netdev@vger.kernel.org, jiri@nvidia.com,
 kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
 intel-wired-lan@lists.osuosl.org, pio.raczynski@gmail.com,
 sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, May 28, 2024 at 06:38:01AM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Implement devlink port handlers responsible for ethernet type devlink
> subfunctions. Create subfunction devlink port and setup all resources
> needed for a subfunction netdev to operate. Configure new VSI for each
> new subfunction, initialize and configure interrupts and Tx/Rx resources.
> Set correct MAC filters and create new netdev.
> 
> For now, subfunction is limited to only one Tx/Rx queue pair.
> 
> Only allocate new subfunction VSI with devlink port new command.
> Allocate and free subfunction MSIX interrupt vectors using new API
> calls with pci_msix_alloc_irq_at and pci_msix_free_irq.
> 
> Support both automatic and manual subfunction numbers. If no subfunction
> number is provided, use xa_alloc to pick a number automatically. This
> will find the first free index and use that as the number. This reduces
> burden on users in the simple case where a specific number is not
> required. It may also be slightly faster to check that a number exists
> since xarray lookup should be faster than a linear scan of the dyn_ports
> xarray.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

