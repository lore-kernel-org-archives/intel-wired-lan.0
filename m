Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6531C27C6E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Jun 2024 10:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 810D481DFE;
	Fri, 14 Jun 2024 10:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l6qP3kwAxaBz; Fri, 14 Jun 2024 10:55:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0F88843B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718362537;
	bh=LWgevmAmr4kMowmaa1oQGuTgsS/cCNV7zOeW7tsp1RE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=6+VDxDEukcUDHYGn5ijjAxflNo9dX/poxbqntoDLTqGcPq+fd2k1M2XnkWYVoxplh
	 UNhySAocLJRR1HAmlUgib/jdQjtl5cuYChsPfAtsBQe+qJ0xR2OMCkcbmCdFS8sdv9
	 lsHBasm33OxRS0b0JBoTRn4obhLIuS9M2JC1Tlitz8KbGZ5fOuYLdcMq9NGxqoZx9t
	 lkeDuwGFJbIeCYE+qOZaFFD2Wcacbw90U8e1PzXJqeqtISokAwcky/6vLgz/zd/ofL
	 +UaRy7ounhq8v9smGQkn4P9MdTDvsGxuhENm75kO31zXTr9ouaE509VX+iAq4tVFgj
	 hFIFGy5PSU2Bg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0F88843B9;
	Fri, 14 Jun 2024 10:55:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 408301BF33E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DE2C606E8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qkVb3on6n2zx for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Jun 2024 10:55:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0696F606B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0696F606B3
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0696F606B3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:55:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 365B0CE290E;
 Fri, 14 Jun 2024 10:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB95DC2BD10;
 Fri, 14 Jun 2024 10:55:28 +0000 (UTC)
Date: Fri, 14 Jun 2024 11:55:26 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240614105526.GG8447@kernel.org>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-6-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606112503.1939759-6-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718362531;
 bh=7FM7sSOKz8V1VtpSRlj3q7t8Kf/IRAcBNLO7c5iedAQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BPhEUErWELJa1iPREq/SpA4Gp88USVffHJwe2LPJgamfUzonP6DfcfhuVU86aiIaS
 gARYBpu2LlNpFePtuEQMKI0nVcX7Z6NaTZBmFT5jZqAa/tEgeke9dbAnpGQzT80kAG
 /64ZAvBzQgvHih2LYGwfi3400JOtDXa2LIrYDC9Xu47PehXaRXUihvJooYq+j6j9or
 Xt7M3OHhPsY7pBbptoE6KQloaLAzPn8yzdBqWSFvNrrUygkFgLEhNWtss3Oo0kO/w3
 xFH6OhLAn/PDp+tpRE6Q7xyDnVAfknB8ag9Ipq/ajaDCqnqZv+cYoMpjIkL2QuY6Eu
 Vq84pBiQjQNhQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=BPhEUErW
Subject: Re: [Intel-wired-lan] [iwl-next v5 05/15] ice: allocate devlink for
 subfunction
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

On Thu, Jun 06, 2024 at 01:24:53PM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Make devlink allocation function generic to use it for PF and for SF.
> 
> Add function for SF devlink port creation. It will be used in next
> patch.
> 
> Create header file for subfunction device. Define subfunction device
> structure there as it is needed for devlink allocation and port
> creation.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks Piotr,

I believe this addresses Jiri's review of v4.
And the minor nit below not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c

...

> @@ -1422,6 +1425,7 @@ static void ice_devlink_free(void *devlink_ptr)
>   * Allocate a devlink instance for this device and return the private area as
>   * the PF structure. The devlink memory is kept track of through devres by
>   * adding an action to remove it when unwinding.
> + *
>   */
>  struct ice_pf *ice_allocate_pf(struct device *dev)
>  {

nit: this hunk seems unrelated to the rest of the patch.

...
