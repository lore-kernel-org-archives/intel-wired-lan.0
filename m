Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A046E95A63
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Oct 2023 15:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9519A41C53;
	Sat,  7 Oct 2023 15:36:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9519A41C53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696692969;
	bh=p8yHJOBLNEvNUS+sYk19n6kVGwZCLjpq4jyysfkpjwo=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mzAY18ixBy1QuWaH9psJ4crSFpKybCDWChP5R3AZPUMTBded2C4fUyga3ibc39Wyh
	 bJEQVGkFaegPRPD1Zd81YpGbnhyEB18UDZpFSuJ43868oIZav+abTm3PymA7GZVaIp
	 ngEGAxCnrBl0+EtrbRG4Ut4ljOn02kMBYx+HfxyGlaGJfjSLhZJgUyoPIssj5heDr0
	 uL77ErzkNnOvJM/FK7FS9uPly0BnAqBrtsilp7dykroRGIvAq8DtPDF/8uq5plTl4v
	 KxVZa8xZVda34foe7sIsEW0MnTBHh2pOWH3uQleSJ+vXO/kuGvW2Wd7l6Yp4RYHz/2
	 2pGVhFqw9nFcw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qOJvqFzflWMv; Sat,  7 Oct 2023 15:36:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id C824341C54;
	Sat,  7 Oct 2023 15:36:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C824341C54
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 305501BF33B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Oct 2023 15:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02D3582477
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Oct 2023 15:36:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02D3582477
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nM-ZAkPl_Sbu for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Oct 2023 15:36:03 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED88582384
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Oct 2023 15:36:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED88582384
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C3D5560A5A;
 Sat,  7 Oct 2023 15:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56166C433C7;
 Sat,  7 Oct 2023 15:36:00 +0000 (UTC)
Date: Sat, 7 Oct 2023 17:35:58 +0200
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20231007153558.GE831234@kernel.org>
References: <20231006110212.96305-1-mateusz.polchlopek@intel.com>
 <20231006110212.96305-6-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231006110212.96305-6-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1696692961;
 bh=dI7Vf6iCe6cdUXeiNYo7FnhV2+HASKHA1tQ/ju+n2k4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ns0WE/H3SkV0Os6XJJhmHQGR8gJ6yW6St0imuJFbj0o4xuxoxQL6eB8qg5MRWh4Hm
 el/0Vli43OQdRwLu6eoTx2feayCbvfxJq5fyXMUwZ6tUARVSwGaohd3WhWypHfBwSV
 1HV1WC83cjq/K2fhIPjMlBEWZmkYuYHcsRGF9dZp8ysdrfKP6iVx1MqjAtJS0N3XZr
 HF5E0uX0mvD47wQWBe9UuA7/w4t8ilHDflQ8eL1I9+GN09gKd4J2DFQc8lJnM5Re8Z
 VtlNk9EQ6GgkPfJnz7+HowfiW4OXGsmOnbFse9Og00zHC/3j7FQxZ8U5ricVRSJ9gR
 LVUpS33yUsgXg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Ns0WE/H3
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 5/5] ice: Document
 tx_scheduling_layers parameter
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Michal Wilczynski <michal.wilczynski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Oct 06, 2023 at 07:02:12AM -0400, Mateusz Polchlopek wrote:
> From: Michal Wilczynski <michal.wilczynski@intel.com>
> 
> New driver specific parameter 'tx_scheduling_layers' was introduced.
> Describe parameter in the documentation.
> 
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Hi,

I'm not expert here,
but this seems to cause a splat when building documentation.

.../ice.rst:70: WARNING: Unexpected indentation.
.../ice.rst:25: WARNING: Error parsing content block for the "list-table" directive: uniform two-level bullet list expected, but row 2 does not contain the same number of items as row 1 (3 vs 4).

.. list-table:: Driver-specific parameters implemented
   :widths: 5 5 5 85

   * - Name
     - Type
     - Mode
     - Description
   * - ``tx_scheduling_layers``
     - u8
     - permanent
       The ice hardware uses hierarchical scheduling for Tx with a fixed
       number of layers in the scheduling tree. Root node is representing a
       port, while all the leaves represents the queues. This way of
       configuring Tx scheduler allows features like DCB or devlink-rate
       (documented below) for fine-grained configuration how much BW is given
       to any given queue or group of queues, as scheduling parameters can be
       configured at any given layer of the tree. By default 9-layer tree
       topology was deemed best for most workloads, as it gives optimal
       performance to configurability ratio. However for some specific cases,
       this might not be the case. A great example would be sending traffic to
       queues that is not a multiple of 8. Since in 9-layer topology maximum
       number of children is limited to 8, the 9th queue has a different parent
       than the rest, and it's given more BW credits. This causes a problem
       when the system is sending traffic to 9 queues:

       | tx_queue_0_packets: 24163396
       | tx_queue_1_packets: 24164623
       | tx_queue_2_packets: 24163188
       | tx_queue_3_packets: 24163701
       | tx_queue_4_packets: 24163683
       | tx_queue_5_packets: 24164668
       | tx_queue_6_packets: 23327200
       | tx_queue_7_packets: 24163853
       | tx_queue_8_packets: 91101417 < Too much traffic is sent to 9th

       Sometimes this might be a big concern, so the idea is to empower the
       user to switch to 5-layer topology, enabling performance gains but
       sacrificing configurability for features like DCB and devlink-rate.

       This parameter gives user flexibility to choose the 5-layer transmit
       scheduler topology. After switching parameter reboot is required for
       the feature to start working.

       User could choose 9 (the default) or 5 as a value of parameter, e.g.:
       $ devlink dev param set pci/0000:16:00.0 name tx_scheduling_layers
         value 5 cmode permanent

       And verify that value has been set:
       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
