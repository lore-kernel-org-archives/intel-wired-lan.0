Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E085DD59F56
	for <intel-wired-lan@archiver.kernel.org>; Wed,  6 Nov 2024 17:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 937A260A81;
	Wed,  6 Nov 2024 17:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MFFonCCq_K-c; Wed,  6 Nov 2024 17:45:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B47BF60A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1730915127;
	bh=UxOA/rfjI1KE6q3W8gj1BUxMxZg7BxDAt4RAStM8cQA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FTqbmBC1Nnhf3h1uyJm/eazMKdU6q6iaEroAvodCDn35hq6GEgk3S58RyI13d/bNI
	 wz3JgmDLM9GLtF5RvGP1N/UlD+zeXs6Ola4Ekh4TRWfTUGSVRf6x7Usw1fWafVHh06
	 CIGEWgqzkTINeNhXDYwZBLR9pPryA29PwDKdPrwfTfgGHHQNl8Oq18HMnwrXwtSVor
	 zHjXL96+9zAPkwKQhFs0IXVghT7wy6yLvCkfyvlPmsGaUMRBHUjV2OK/6ut3T/aNFk
	 59aVEiVi8ffTn38ZM3ow0TpQpGPxQ6n41a32I6WI+DKKaANhl8tYj0hHnnB+7kCDnT
	 oHYBoBXw30jiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B47BF60A99;
	Wed,  6 Nov 2024 17:45:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7FC9B8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Nov 2024 17:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B400E40896
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Nov 2024 17:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxvUq3g5k-KL for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 Nov 2024 17:45:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 33C3240895
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33C3240895
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33C3240895
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Nov 2024 17:45:22 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1t8k5m-00CMZo-Fe; Wed, 06 Nov 2024 18:45:18 +0100
Date: Wed, 6 Nov 2024 18:45:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <d20d8265-4263-4408-8448-4338a268d537@lunn.ch>
References: <20241106010756.1588973-1-arkadiusz.kubalewski@intel.com>
 <20241106010756.1588973-2-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106010756.1588973-2-arkadiusz.kubalewski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=UxOA/rfjI1KE6q3W8gj1BUxMxZg7BxDAt4RAStM8cQA=; b=bckz7RTNCff3o2N0qC4BrW5JJU
 t/NSlxrsd+A4IZiqBPho+pn1msHV/R9j4murPChVT9pvz2n/KWHwQPw9bbpmOHohQVi4yWa4W48Nx
 Z+sC2x4pxCgPMEbO9uSl0nDw3qEeV+BB5OSFFMDDDOnoLm5P0txnjkLVwplDdMhfGPY4=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=bckz7RTN
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/2] ptp: add control over
 HW timestamp latch point
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

On Wed, Nov 06, 2024 at 02:07:55AM +0100, Arkadiusz Kubalewski wrote:
> Currently HW support of ptp/timesync solutions in network PHY chips can be
> implemented with two different approaches, the timestamp maybe latched
> either at the beginning or after the Start of Frame Delimiter (SFD) [1].
> 
> Allow ptp device drivers to provide user with control over the HW
> timestamp latch point with ptp sysfs ABI. Provide a new file under sysfs
> ptp device (/sys/class/ptp/ptp<N>/ts_point). The file is available for the
> user, if the device driver implements at least one of newly provided
> callbacks. If the file is not provided the user shall find a PHY timestamp
> latch point within the HW vendor specification.
> 
> The file is designed for root user/group access only, as the read for
> regular user could impact performance of the ptp device.
> 
> Usage, examples:
> 
> ** Obtain current state:
> $ cat /sys/class/ptp/ptp<N>/ts_point
> Command returns enum/integer:
> * 1 - timestamp latched by PHY at the beginning of SFD,
> * 2 - timestamp latched by PHY after the SFD,
> * None - callback returns error to the user.

-EOPNOTSUPP would be more conventional, not None.

> 
> ** Configure timestamp latch point at the beginning of SFD:
> $ echo 1 > /sys/class/ptp/ptp<N>/ts_point
> 
> ** Configure timestamp latch point after the SFD:
> $ echo 2 > /sys/class/ptp/ptp<N>/ts_point

and i assume these also return -EOPNOTSUPP if it is not supported.

And a dumb question, why should i care where the latch point is? Why
would i want to change it? Richard always says that you cannot trust
the kernel to have the same latency from kernel to kernel version
because driver developers like to tweak the latency, invalidating all
measurements the user has done when setting up their ptp4l
daemon. This just seems like yet another way to break my ptp4l
configuration.

	Andrew
