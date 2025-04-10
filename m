Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB71C3601E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Apr 2025 08:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6772E605EE;
	Thu, 10 Apr 2025 08:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11UsYGd8uXM2; Thu, 10 Apr 2025 08:21:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDDEB607C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1744273308;
	bh=/qlb9+voO+UQVmST3Zj9tARBjM7ZkXwmy1me9FAsA9E=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IfZFp95593m1G4qQXD5aEvyIVuMazp2fHicmU2LytdcBSBKkhV981V6mfJIrKw1Uj
	 Y/14Oz78xQDnKC6u/GJgBEXSDsraTPQBbrNgM1+6Ip3lZ0wd4tXvQ9yccGhlhhT8BW
	 OB3fWDjPWbKKIUfWYqqH4R5HUXEHQwBgq/RJeuA8t6gAWr2r5IrmgmZ+w/BwKy8rpd
	 jj8WSdw6KWy3Fwb63QxAR2GUWxGJ81JDtCfhhtbZqUnxB6cmlmvGOLRWgBnXanz00D
	 OkSpPjgQR5Ce1/gBoE6+/T5ayNIU6wCNz5n64jke3PEjmJeScLKXFWvJ2SwglhDZZt
	 SiqSjwlAv2xFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDDEB607C7;
	Thu, 10 Apr 2025 08:21:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C128201
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Apr 2025 08:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81FDF80F7D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Apr 2025 08:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ESUulnWNpAA4 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Apr 2025 08:21:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=leon@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DACD483F35
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DACD483F35
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DACD483F35
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Apr 2025 08:21:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 275906843D;
 Thu, 10 Apr 2025 08:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E49C4CEDD;
 Thu, 10 Apr 2025 08:21:43 +0000 (UTC)
Date: Thu, 10 Apr 2025 11:21:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Mustafa Ismail <mustafa.ismail@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Lee Trager <lee@trager.us>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Wenjun Wu <wenjun1.wu@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>, Josh Hay <joshua.a.hay@intel.com>,
 Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
 "Singhai, Anjali" <anjali.singhai@intel.com>,
 Phani R Burra <phani.r.burra@intel.com>
Message-ID: <20250410082137.GO199604@unreal>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-6-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408124816.11584-6-larysa.zaremba@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1744273304;
 bh=T6cKF1AH6u5sSEkewMIOmHQeFJzUhjmBmmaZtyPLzhM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cx/C44HZl16jH12vNnkP451QQg5FzAk7RvBGhK7Tfe3tdRcND7YkpVLx7eVQXIS03
 fRsb0Id09N2YUjJxtfvW9ymhqshFCLl/+nkASkq2fBPKj+gNBgAuI+tv35pl4ka26w
 UDc00QsDlSCwiJeCFKTFC+JrRpph7hQ+KVmgoVHGerHDsUUk1f0pnwrEUI2ls3IChR
 c6dX6lWqSvyAQZ07QtHllKqzulecA6fl3BdFpRwdaC2wxv9FzxYG5OFmFVFIbVXbV9
 uBpnLJYoUJVPme7KZqHnZhvqBcvSGHCzrsZLrAZiS6APigrLrMhaepwlfrHxmVTuxJ
 Ejz3aooy8rCeg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cx/C44HZ
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 05/14] libeth: add control
 queue support
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

On Tue, Apr 08, 2025 at 02:47:51PM +0200, Larysa Zaremba wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> Libeth will now support control queue setup and configuration APIs.
> These are mainly used for mailbox communication between drivers and
> control plane.
> 
> Make use of the page pool support for managing controlq buffers.

<...>

>  libeth-y			:= rx.o
>  
> +obj-$(CONFIG_LIBETH_CP)		+= libeth_cp.o
> +
> +libeth_cp-y			:= controlq.o

So why did you create separate module for it?
Now you have pci -> libeth -> libeth_cp -> ixd, with the potential races between ixd and libeth, am I right?

Thanks
