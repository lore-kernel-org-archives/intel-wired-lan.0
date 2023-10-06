Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786CBE81DE9
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Oct 2023 12:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F77960F76;
	Fri,  6 Oct 2023 12:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F77960F76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696594432;
	bh=W1llVqT2YD0WJdz+VwErLNo654yLDIeYQ8bd6FhFnJA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pO0ERWFk8aAZKK30EBeEl36dyc1gHMgxV1afIC6a4eqJfe4xxLKg7W5gnn3q43LC3
	 rAfAWVrYTpB3P7lebf9NKs3ql7nXDuh6hWiP/PW1SmJJcdTmLykwUx+mAl/f+oTBj3
	 NgkFI/sbkrpT3YcqAQgV7d8v9oHWt5nuOCwAuwAz7loe0Wd27Sg98X9LOgODW6aY6f
	 P5BTCR9OJw2iJXRVrdfxefefijkuzrxJGOsBerAbvApc1RBvxvrMFqSt55Ebzy0QhQ
	 QWhXtlwBPcy8/fXSkYqM0Iii0pc4M3iv/q0ZfUH8MznVZIOnQViQJR//Aoi504aBTI
	 Gvybeghh4yyEA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m88j2CQk6hjq; Fri,  6 Oct 2023 12:13:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFE5F60FFE;
	Fri,  6 Oct 2023 12:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFE5F60FFE
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 8D5EA1BF380
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 12:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 659D260FFE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 12:13:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 659D260FFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yDNfUJq_RO7J for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Oct 2023 12:13:46 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 705DA60F76
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 12:13:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 705DA60F76
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A73B861CDF;
 Fri,  6 Oct 2023 12:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F328DC433C7;
 Fri,  6 Oct 2023 12:13:43 +0000 (UTC)
Date: Fri, 6 Oct 2023 14:13:41 +0200
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Message-ID: <ZR/59YSFavmHAHC7@kernel.org>
References: <20231006111139.1560132-1-mschmidt@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231006111139.1560132-1-mschmidt@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1696594425;
 bh=lCCWh4f6IaqpQgRiJ2QFH4TRyVDyZ0dvh7l68dHWWQ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sswhgY8LCLD8W8konCq+UQpIaZcPSc+0bUD6ivQ2AMhfgWYTVf0Z/MZLQVVTSVE9V
 4751BqhCmd16f1RnyVR0NTbkxD1fdO5RHj1LUMX9ZBzqUCjsi0reSJOkloGfUOJoEi
 /78cbndpmgZpEAutOQQKJwAgMw9IPCkAczOyBfM17d+yIXlx/qFdoJkytSQCRTfTkg
 Z7wWpfac0LRsTdU6UJD9Hc7/uGWi1XB5v/kaoN+xOD94+mKHOJPhFed1gEgjYsfmZF
 9bJoDFgWLvTbw/5epeJfdZqgTQ5sYGzijSihZMRFUno03u1jFnJ0zjLonnFWMHmbEi
 Nqi20yrad0nKg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=sswhgY8L
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: prevent crash on probe if
 hw registers have invalid values
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>, intel-wired-lan@lists.osuosl.org,
 Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Oct 06, 2023 at 01:11:39PM +0200, Michal Schmidt wrote:
> The hardware provides the indexes of the first and the last available
> queue and VF. From the indexes, the driver calculates the numbers of
> queues and VFs. In theory, a faulty device might say the last index is
> smaller than the first index. In that case, the driver's calculation
> would underflow, it would attempt to write to non-existent registers
> outside of the ioremapped range and crash.
> 
> I ran into this not by having a faulty device, but by an operator error.
> I accidentally ran a QE test meant for i40e devices on an ice device.
> The test used 'echo i40e > /sys/...ice PCI device.../driver_override',
> bound the driver to the device and crashed in one of the wr32 calls in
> i40e_clear_hw.
> 
> Add checks to prevent underflows in the calculations of num_queues and
> num_vfs. With this fix, the wrong device probing reports errors and
> returns a failure without crashing.
> 
> Fixes: 838d41d92a90 ("i40e: clear all queues and interrupts")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
