Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A7CF4485A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 13:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CF104108D;
	Fri, 10 Apr 2026 13:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-zaNFP2X9Rh; Fri, 10 Apr 2026 13:33:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E873A4107C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775828001;
	bh=w9ptXFUnqBxR5wM3W6ZPrMIKUF90WLA3+tjo6ShyRiw=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6Mm0cWdu0AUteRYk/hdbNMRXhHCzLqSup98T0G6GpT5vms2Nn1OpX2O5W3n661ITE
	 xduByH+d738QZI8Y7GuaF3BvwSbMCS6CuDcG1it67HVQ8zhri6tGX6s/D/f8WHfTeW
	 KYxuVn88hSGypvTJP2Oh/3tr7xj27RcC08+8r7lITkd5UdEwD3y/wlV+rbvUxhsUOW
	 Gew6nAs1pwsxCmDphub6fhHn+V5aRDD8uOjqqRJrv+IBc/Fk/7rcW/VcdTci7vyUsX
	 2i90K9RGFiD24rIh71zGD+yn0E5ClJ2hc8wGfRq42OSui3RVO7bF19rnuEJKjLJ+Ja
	 biWNBBtp7QKAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E873A4107C;
	Fri, 10 Apr 2026 13:33:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8427B237
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 13:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A18C40090
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 13:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oUWFU5-DiQPv for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 13:33:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5D5DD4005B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D5DD4005B
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D5DD4005B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 13:33:16 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id ADF1D4C2C37D58;
 Fri, 10 Apr 2026 15:32:37 +0200 (CEST)
Message-ID: <0941aca7-66b9-4bd4-aa9f-c8e020e32bb1@molgen.mpg.de>
Date: Fri, 10 Apr 2026 15:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Piotr Raczynski <piotr.raczynski@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, stable@kernel.org
References: <2026040919-junior-glue-10d0@gregkh>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2026040919-junior-glue-10d0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix double free in
 ice_sf_eth_activate() error path
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

Dear Greg,


Thank you for the patch.

Am 09.04.26 um 17:11 schrieb Greg Kroah-Hartman:
> When auxiliary_device_add() fails, the aux_dev_uninit label calls
> auxiliary_device_uninit() and falls through to sf_dev_free and xa_erase.
> The uninit invokes ice_sf_dev_release(), which already frees sf_dev via
> kfree() and erases the entry from ice_sf_aux_id.  The fall-through then
> double-frees sf_dev and double-erases the id.
> 
> This is reachable from userspace via the devlink port function state-set
> netlink command.
> 
> Fix this by returning right after uninit because the release callback
> handles all cleanup correctly.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Piotr Raczynski <piotr.raczynski@intel.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Fixes: 177ef7f1e2a0 ("ice: base subfunction aux driver")
> Cc: stable <stable@kernel.org>
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/net/ethernet/intel/ice/ice_sf_eth.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> index 2cf04bc6edce..6bc8aa896762 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> @@ -304,7 +304,9 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
>   	return 0;
>   
>   aux_dev_uninit:
> +	/* ice_sf_dev_release() frees sf_dev and erases the xa entry */
>   	auxiliary_device_uninit(&sf_dev->adev);
> +	return err;
>   sf_dev_free:
>   	kfree(sf_dev);
>   xa_erase:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
