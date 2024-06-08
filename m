Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD7EC25B76
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Jun 2024 12:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D40968218F;
	Sat,  8 Jun 2024 12:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWBeS5z-v8HU; Sat,  8 Jun 2024 12:58:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F82F82101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717851526;
	bh=jNShOBjMbhVtAoTaAKJUeTI6hmIllCwWfoQjeNjpFn0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Z7lHCgpC4SlXQFjl9G7XrZADn93S79QlqYQIyRJcJJNc7oeTlyO0Ej5t6EYCXNitw
	 I+5nrOjJA4wXy/ayqispmPu67d3wTQQK+SqoyMgyWkOMJl8TBQ8y3h7/E4rcs7WdiB
	 3ZQAmHgvRLnL1s/E8rQJUU8fLKaoozuR9A/t/dTzzfyiLB6KtdIGQxTeoyZcpeL9dd
	 4OsfwhsDtTf/QMakS1DjSAxqpRQL0PJRnuhOtNGtpmVNhpCE+pDnLbSN5O3q+ftYVI
	 mUVcA41HrhivQQM/q7/SC58X4bsd3JhdQAO6J9b66Ir33KDJrnoebzQfZuA2xpJmrs
	 cv/Tm+joYQaiA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F82F82101;
	Sat,  8 Jun 2024 12:58:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 5B68A1BF47E
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4561440538
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4NGG-HKX8OuM for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Jun 2024 12:58:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 77AB7404C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77AB7404C6
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77AB7404C6
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:58:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BF9AF61243;
 Sat,  8 Jun 2024 12:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4F6C2BD11;
 Sat,  8 Jun 2024 12:58:41 +0000 (UTC)
Date: Sat, 8 Jun 2024 13:58:39 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20240608125839.GY27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-7-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-7-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717851523;
 bh=8h7iVKPU4zLmsDfT69C7Raz8WD0w2TDfKWzcdLn9Pq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c4LzFsPpACQdCLgYrKa/nQLxExi29Xw9BKOrw/kBHsU4tqXKRcbLw21z9hxdZXypg
 FURcNTxtkGtj/pQ1Bynrv9zk5VXIrhxuNewDbmq6VcLfhxC9NykqQlIe3N464/HXCC
 dnCnp8Fny7xqg8undiagjsssgUSaJPtTIXPs/JYlOXM2dTCi8Z2V4p2lWQlQuUyJ6X
 b1ubb15dr/LxJUrK2PeubsEWDiDcbk2JaBHrDnJ8ajlvUR+f7LyJMfW8776Ae1ksal
 /mOl5Dw8LDBx4TOJ0tvEBu9OCidsF+w12izpWBRArrbadrfETTuFj9ud2KzVyH/Yxd
 /3EiYuveFmSEQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=c4LzFsPp
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 06/12] iavf: add initial
 framework for registering PTP clock
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 Ahmed Zaki <ahmed.zaki@intel.com>, Sai Krishna <saikrishnag@marvell.com>,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jun 04, 2024 at 09:13:54AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add the iavf_ptp.c file and fill it in with a skeleton framework to
> allow registering the PTP clock device.
> Add implementation of helper functions to check if a PTP capability
> is supported and handle change in PTP capabilities.
> Enabling virtual clock would be possible, though it would probably
> perform poorly due to the lack of direct time access.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

