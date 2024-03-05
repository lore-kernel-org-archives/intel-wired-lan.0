Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BE3C54E41
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Mar 2024 12:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C243A4160F;
	Tue,  5 Mar 2024 12:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WURdo-Q8GQGj; Tue,  5 Mar 2024 12:28:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1CB241612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709641690;
	bh=ACK/m5+wsh1JNWwZEAlMsxBK5EEGxcPK1vxzZi7bNRs=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QrTU4SXxBH5yBRJfrQcxnSZtkgr0XpvQJxZOn8P/8PsB+F5mFuckfsBW98vstMm/D
	 kBbqbVgXz2n0sPx0Uo6M2QRmBfcxsntKTlcOpWu951WvKR0W4pyYoXV117WYxktyLY
	 Sqxl9xedeABzMQf54TUOiFB0WwnYFWk5DSVMz5bnUJjZQXII88up8Cx6wPIL0Ctqlr
	 7BFrpcxpmNzam+JdAMdWMjfcd3Sz5pEqfWP9pPQMXM4Hvmt6YiKlzUyzr4/ZXABnea
	 e3EWl+tfewOiISALCYi4tn1VFg10mS5O6idH/Rhc7HUVWoOadyrsZ4FG4lFhTBvon+
	 5n3dvBppRoiow==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1CB241612;
	Tue,  5 Mar 2024 12:28:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2A2161BF3D4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Mar 2024 12:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15DC1415D0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Mar 2024 12:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vIHOwaqX44i7 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Mar 2024 12:28:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B3A634168C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3A634168C
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3A634168C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Mar 2024 12:28:05 +0000 (UTC)
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A250C61E5FE38;
 Tue,  5 Mar 2024 13:27:25 +0100 (CET)
Message-ID: <9394bbe0-66bf-433a-8aa0-4051907389b3@molgen.mpg.de>
Date: Tue, 5 Mar 2024 13:27:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240305003707.55507-1-jesse.brandeburg@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240305003707.55507-1-jesse.brandeburg@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix typo in assignment
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
Cc: Paolo Abeni <pabeni@redhat.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Jesse,


Thank you for your patch.

Am 05.03.24 um 01:37 schrieb Jesse Brandeburg:
> Fix an obviously incorrect assignment, created with a typo or cut-n-paste
> error.

It’s probably just me, but with these one letter typos I still have to 
search the diff two or three times to spot the typo. Maybe even use 
(next time) as commit message summary:

ice: Assign tx ring stats value to tx stats and not rx ones

> Fixes: 5995ef88e3a8 ("ice: realloc VSI stats arrays")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 097bf8fd6bf0..fc23dbe302b4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3192,7 +3192,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>   		}
>   	}
>   
> -	tx_ring_stats = vsi_stat->rx_ring_stats;
> +	tx_ring_stats = vsi_stat->tx_ring_stats;
>   	vsi_stat->tx_ring_stats =
>   		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
>   			       sizeof(*vsi_stat->tx_ring_stats),
> 
> base-commit: 948abb59ebd3892c425165efd8fb2f5954db8de7

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
