Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E87C48285
	for <intel-wired-lan@archiver.kernel.org>; Wed, 31 Jan 2024 10:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3A2183BBD;
	Wed, 31 Jan 2024 10:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3A2183BBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706697841;
	bh=E6ejbGClvBv398K1WdkQP4IM2cZhM5gcu/lc2gKYjn4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9i7+6FnqpQNXrYOa8T5L6+rV/LsKAROyZFXZcuDw1wiulE7hhGjjizJcDAaWHp29g
	 Q9b9PEiRz9GIMwc58iBHaGFWBZUdJEv/kw27QSGELTfIAqPSScsP8gk8f8C/vpheMN
	 RcBdeB21xLjusqPj0SxIjyqpeCDPVGx8xoLtNVSHh084lSR+nmzhUjqYLx8tlzmFYD
	 OavyEQ4bVD0vdrodMkssm20sHSk4YpQ4WJD8F4FdMXJs+06jamo12WYYgoYAl3IbNW
	 gmLQfZMbisC6C7wnKWy91vmS9i+UvlKdR5fTyYkJfFLU+FhDLjfLPTnGwI8HMQkPCq
	 JiABEXRQdLQBw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yXWE_OuWe18L; Wed, 31 Jan 2024 10:44:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A95A83B64;
	Wed, 31 Jan 2024 10:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A95A83B64
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 3FBDD1BF3E1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jan 2024 10:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2346841F72
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jan 2024 10:43:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2346841F72
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PUm-AkcZWrzC for <intel-wired-lan@lists.osuosl.org>;
 Wed, 31 Jan 2024 10:43:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D47D41C51
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jan 2024 10:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D47D41C51
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10316964"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="10316964"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 02:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4121359"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 02:43:53 -0800
Date: Wed, 31 Jan 2024 11:43:44 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: karthiksundaravel <ksundara@redhat.com>
Message-ID: <ZbokUx7myZ1bVWLL@mev-dev>
References: <20240131080847.30614-1-ksundara@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131080847.30614-1-ksundara@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706697838; x=1738233838;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GMHh/yDFgs8E7du6dshuQUH8e/3SPnyzYtKxUfHT/jQ=;
 b=CGxcxs21kjGJMge3XEYFPZlzY/h8pavUMSY3SRx9RDBbQ7WYqxX6t/Cp
 03RI9OEp+LGjhYjA0w3YLT4BWNe536UPDMXKVn3cbEAe8ipXqRj691bE0
 BibcHLxxfQb9Apf2q0YWMnx7bSbLoKcANhK4G3madlbzrgI/QHaBAsRKJ
 1ZqD9extJaUxO+R6fAi4sI971upU3PP5AnMBFbB63PIadtjRBykoI6c7n
 oZ5CEPrpZFAN6mhlpWMsfv9fBJOu+f9M9OOJ25+WehL4ufa6lwWIO3+UB
 W4P61LWsRcgdhtBjnmLqbXLM8VzevnBx5bh/v/V56qxkIjc+d59Cg1R1Q
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CGxcxs21
Subject: Re: [Intel-wired-lan] [PATCH] ice: Add get/set hw address for VF
 representor ports
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
Cc: vchundur@redhat.com, aharivel@redhat.com, cfontain@redhat.com,
 intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, kuba@kernel.org, rjarry@redhat.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jan 31, 2024 at 01:38:47PM +0530, karthiksundaravel wrote:
> Changing the mac address of the VF representor ports are not
> available via devlink. Add the function handlers to set and get
> the HW address for the VF representor ports.
> 
> Signed-off-by: karthiksundaravel <ksundara@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 134 ++++++++++++++++++-
>  1 file changed, 132 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index 80dc5445b50d..56d81836c469 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -9,6 +9,8 @@

As Jiri already wrote, you are not changing MAC of VF in your code. Try
to look at ice_set_vf_mac in ice_sriov.c. In current implementation you
nedd to set new MAC value for VF and reset it. You shouldn't use PF VSI.

Pointer to VF you can get from representor struct (through parent VSI).

You shouldn't manage the rules during MAC changing, as in switchdev
slow-path there shouldn't be VF MAC rules. It can be problematic as user
already can have MAC + sth rule (which also needs to be change). I will
leave it to user (most probably the MAC change happens before adding any
rules).

In few days we will send patchset for subfunction support where the
subfunction MAC chaning is implementing from devlink API. I will add you
to the CC.

Thanks for working on it, it is a gap in our solution.

Thanks,
Michal
