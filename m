Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21EBE7D0A1
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Sep 2023 23:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 484FB400F8;
	Thu, 21 Sep 2023 23:58:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 484FB400F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695340698;
	bh=GJ6D8XILK0Tt2p5XA/FkIdERsGCUcLsWrz7573cmUBU=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ZUILRHYiESRELeky9tATf0K7FWFDg0pp79CPvlIm6E4fuQTXBNB7JltU3YJZ7VNFv
	 /MUF3NCRmsWT1wq/UcsUYw8fyzNF8m09HJ23ldNvavVwtMht4Af8oxlv84dtz4qMc9
	 BhcDtG/0x+TSVyhXxYI/2jnxVHenHpEM4cXaV/YbYSj0BKfesUWmJD0nqzLB+nhzPB
	 ALq5ZHld3gCY53jB/Lg7xQBVpDuAtL2jqVrLKuE08gShbNAcRqiRq1NTfIYQIVDUQP
	 JEoF4eYMm3vYMdQ0KEU72tB+GaQzDp4v2EdQepVw0fvCvokCKQ5UtysBkHGrHKifdu
	 C3woRmh3uMm5g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wC7RJ2P61Qe; Thu, 21 Sep 2023 23:58:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13750400FB;
	Thu, 21 Sep 2023 23:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13750400FB
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 421381BF21A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Sep 2023 23:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD592400F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Sep 2023 23:58:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD592400F6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NMAN7Wq-pFAU for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Sep 2023 23:58:13 +0000 (UTC)
Received: from out-216.mta0.migadu.com (out-216.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::d8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C28C0400D5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Sep 2023 23:58:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C28C0400D5
Message-ID: <e5022460-fc45-5571-1f5b-2b81f7811a7d@linux.dev>
Date: Fri, 22 Sep 2023 00:58:04 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <20230920180745.1607563-3-aleksander.lobakin@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230920180745.1607563-3-aleksander.lobakin@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1695340689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUJHN3YfhHAwoXl+1sbrTgWZ/YrCi9D1KruOjj1djMM=;
 b=hz6nVQjKD0rPC1gxSGbf9AaBCRYE5ubk4LvtwRm0zjPsMz2vq/WYMTr5od3zFykk6d+1/6
 uzX2glTAi41cOAgZi4PWHKelE5jD+s8uUQrPiBdLtGF82daQfAXhVUs0MH8MRJCYgIrqr/
 JNLU2uUx1IJtzZ+RKW9lit3RmXVObtE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=hz6nVQjK
Subject: Re: [Intel-wired-lan] [PATCH net-next 2/3] ice: fix undefined
 references from DPLL code when !CONFIG_PTP_1588_CLOCK
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
Cc: Michal Michalik <michal.michalik@intel.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Milena Olech <milena.olech@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 20/09/2023 19:07, Alexander Lobakin wrote:
> DPLL code in ice unconditionally calls several PTP functions which are
> only built when CONFIG_PTP_1588_CLOCK is set. This throws a good bunch
> of link errors:
> 
> ERROR: modpost: "ice_cgu_get_pin_name"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_get_cgu_state"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> OR: modpost: "ice_is_cgu_present"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_get_cgu_rclk_pin_info"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_cgu_get_pin_type"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_cgu_get_pin_freq_supp"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> 
> ice_dpll_{,de}init() can be only called at runtime when the
> corresponding feature flags are set, which is not the case when PTP
> support is not compiled. However, the linker has no clue about this.
> Compile DPLL code only when CONFIG_PTP_1588_CLOCK is enabled and guard
> the mentioned init/deinit function calls, so that ice_dpll.o is only
> referred when it gets compiled.
> 
> Note that ideally ice_is_feature_supported() needs to check for
> compile-time flags first to be able to handle this without any
> additional call guards, and we may want to do that in the future.
> 

There is another fix under review [1], which came from Jacob.
It converts the code a bit more, and will create conflicts.
I would suggest to drop this patch until another series is fully
reviewed.

[1] 
https://lore.kernel.org/netdev/20230921000633.1238097-1-jacob.e.keller@intel.com/
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
