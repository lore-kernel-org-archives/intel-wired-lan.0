Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667E5C25B74
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 May 2024 14:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 059DE82F8B;
	Thu, 16 May 2024 14:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ecAmYi-SvhCd; Thu, 16 May 2024 14:56:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62C2F82314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715871400;
	bh=hNwPUyQjZvET7OmyaBDgHpM/Hk6AuC0PtC9EuI6NIqE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=OscpH+Aql6YKEu9EhiX3GVmKkcX5T7S3c1OiOkVfln1qNwCA52LB4HZbnDvNcKWwE
	 2sGPya5GQLESI7AuJHMcZTqjWhuQkZjcvjD/ACNJdf3BRLccgRN31xWR4GZxcvFaw7
	 C+9VAF7e//hih8Dry4zy63am7AsEVOo/x/sPezNWYwSqVAdQyaPAy/x96TbgwEJ+UE
	 +7xNb/p88Yu0ZHbBBaLQv6TRaE2JXSdNJaaeKJcOdsSdVFlePW+ULNliYyUFwxExDa
	 NgHjuNFJLhXVbRdODC+O+WKCUZxBh2OgWYzJ4Eu83EW3Kq6jsrPmnGN+efqFPoPlcj
	 eVVANIIb2/PjQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62C2F82314;
	Thu, 16 May 2024 14:56:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 718751BF315
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 May 2024 14:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CDBB60BBC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 May 2024 14:56:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tyvS9njJcjjw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 May 2024 14:56:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9028760847
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9028760847
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9028760847
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 May 2024 14:56:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E5473CE1849;
 Thu, 16 May 2024 14:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D32C113CC;
 Thu, 16 May 2024 14:56:29 +0000 (UTC)
Date: Thu, 16 May 2024 15:56:27 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Message-ID: <20240516145627.GB443576@kernel.org>
References: <20240516140426.60439-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516140426.60439-1-wojciech.drewek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1715871390;
 bh=hNwPUyQjZvET7OmyaBDgHpM/Hk6AuC0PtC9EuI6NIqE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qcki+jjoXb63ksOxKa2KPdWb0Uw1ciEZUAktEEIDYASxGH2mfiLBtDvWxAwLjzhlK
 hy1vYhUJabSbBjbBygwHj/gxu2V+H1cLE82dytBLenbAfapjZylsRjHC6FOQNLT2mB
 XMNC+qxrpeMQZ4lxuIDn8dB3dicQxTYKfBwKlmbw6u5wXbhglREUY/SoLLNo5MncBn
 scg7zkYCes2hbaubcxE1NiSudiG6tQIlBMPUpFQBB8A1iXsyYBZnTAmlOXgMCftMJj
 Jzs3IWDZgf9XagVaB5oUsHnfWjm68wNUv3q26IMO3pi9b9LZ0Ucy3TiVtxeNlrxJAr
 X/Oi3CojtbqmA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Qcki+jjo
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: implement AQ download
 pkg retry
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, May 16, 2024 at 04:04:26PM +0200, Wojciech Drewek wrote:
> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
> to FW issue. Fix this by retrying five times before moving to
> Safe Mode.

Hi Wojciech,

As this is for iwl-net, and therefore net, please consider supplying a
Fixes tag.

Otherwise this looks good to me.

> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

...
