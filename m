Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1636C25B7C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 May 2024 18:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EC4E40336;
	Fri, 31 May 2024 18:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LGyCzi8-xZ0s; Fri, 31 May 2024 18:18:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7D4340382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717179531;
	bh=BU6nFDTsc8iAK/liBlb+POIJTadTdp/jmnMA5OvEeW8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nUntsI+9yhBhMiBoEnU/ylQ6+ZWUgXMQv/piZvIdvG7Sl+slUeliPKgVR5gpBHq9A
	 5WU446BzQgXx0DmcWbSyA2X/biiD0i8EH63TD+1ii8zmDCEZqeocvtbHDAEst1ct6y
	 zBvI8zO+3o2pjm7ZOR9UTUO+1CuSbL9mT//ytLojfOsEoLu8oUmVkuA3HxWO5dgtNK
	 j9ignrnR13AmbZNZrEqHT/8t4KRI2wWW4BNKgJB1pl2HTfUFuQ3dGHkGByaRpfqgZR
	 4ABOr+tVKY2LukpTmq5IyyD4yD0cGPQeOhK9YNUoKW55CI7/qghyoKHk7JqNNbTC13
	 tQV24ziy/cLKA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7D4340382;
	Fri, 31 May 2024 18:18:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 85EFB1BF36D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 718F740336
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:18:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0i7cQCRzKNGZ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 May 2024 18:18:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9AE42402D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AE42402D8
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AE42402D8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:18:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D52F462DC3;
 Fri, 31 May 2024 18:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA081C116B1;
 Fri, 31 May 2024 18:18:45 +0000 (UTC)
Date: Fri, 31 May 2024 19:18:43 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240531181843.GQ491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-16-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-16-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717179528;
 bh=yTCk9ONn+AOISS6mJp230I9j1L/ri//w8UIENOBzFPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QfidlvOlpLSKaHgutW+r451uKcLN6lLcvKxKUgLDI+e6GzUMd/qAyhAMhYR1WH+Ui
 Y1JbX/Wo6EurlcaVbQsR/0xzjQYc7RKuhsvtAU8IMvjlFxsfSXa541VsLuL6bRsKun
 n1tOeaAhYLMWtxt0iR2rDmLxI4YHsmgPJcK7skkk0obt25PfIdWcuh1Sjb7J+mx1H9
 QuSW08O/aPeQOdFq6FH3sM7HPkzg3KyI/JBVz0dLNUaIFESAd5jdGQLNnAWf+LAnlD
 l9EgT08L/ct085jsdG2OElixxFQV7LRl4RjMWc4IgPHRycfMIH+KsUdoy+FPni9TgY
 PqaOdGM9+40ug==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=QfidlvOl
Subject: Re: [Intel-wired-lan] [iwl-next v3 15/15] ice: allow to activate
 and deactivate subfunction
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

On Tue, May 28, 2024 at 06:38:13AM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Use previously implemented SF aux driver. It is probe during SF
> activation and remove after deactivation.
> 
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

