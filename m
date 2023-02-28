Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A9BC64EC7
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Feb 2023 10:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3177610E2;
	Tue, 28 Feb 2023 10:01:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3177610E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677578472;
	bh=0Sz+54l9sUfopk+9pMCwrt3kKAhZBHy3hFBfdSWclVw=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jAhmhOZNc1Gib1dW9PfXPm+0cn0hqNJvJ5juHmscNXxrYMLSvJ08enB35HJ0yNCV8
	 6GR0aEmp6Foi83Eu+zfrCR9U7QSBIeHI6hS1tE4Kz8GL5A0jm3crbfenbgu+Pfr84a
	 Vcv9uBl3t9gyYR5urdLBDnq9ea35IbZdUqqBGFCHNHFrSvbvTGhfjzucsHmRY3jPM2
	 qkAKLG3UJ3LgVAg7ulMelNXygU1GMGn9/E+VGWQYj4XNnFOf1LwOJrQnjuBCyUYT6L
	 upJRIsWwjqPBxV5rB6TE1o0ac3fpbCpU9O2YEiNoWPs0XChRjMPMlhFKQhp3fg4TkK
	 SeupsopyISUPQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oeA5QTotJ1Ik; Tue, 28 Feb 2023 10:01:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 588F96112E;
	Tue, 28 Feb 2023 10:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 588F96112E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 173671BF21A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Feb 2023 10:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D613C6115D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Feb 2023 10:01:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D613C6115D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nbdkl0XtHrQP for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Feb 2023 10:01:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 285536059E
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 285536059E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Feb 2023 10:01:03 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id DF73F6244DF88;
 Tue, 28 Feb 2023 11:01:00 +0100 (CET)
Message-ID: <7d2b1ae3-2bec-1456-3df9-7fb04105c681@molgen.mpg.de>
Date: Tue, 28 Feb 2023 11:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Kalyan Kodamagula <kalyan.kodamagula@intel.com>
References: <20230228084915.2866564-1-kalyan.kodamagula@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230228084915.2866564-1-kalyan.kodamagula@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Fix implicit cast u32
 to u16
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
Cc: intel-wired-lan@lists.osuosl.org, Marcin Szycik <marcin.szycik@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Kalyan, dear Marcin,


Am 28.02.23 um 09:49 schrieb Kalyan Kodamagula:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> Fix implicit cast by changing argument types of two functions to correct
> types.
> 
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Kalyan Kodamagula <kalyan.kodamagula@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ddp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index d71ed210f9c4..830fa53b5e0a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -701,14 +701,14 @@ struct ice_buf_build *ice_pkg_buf_alloc(struct ice_hw *hw)
>   	return bld;
>   }
>   
> -static bool ice_is_gtp_u_profile(u16 prof_idx)
> +static bool ice_is_gtp_u_profile(u32 prof_idx)
>   {
>   	return (prof_idx >= ICE_PROFID_IPV6_GTPU_TEID &&
>   		prof_idx <= ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER) ||
>   	       prof_idx == ICE_PROFID_IPV4_GTPU_TEID;
>   }
>   
> -static bool ice_is_gtp_c_profile(u16 prof_idx)
> +static bool ice_is_gtp_c_profile(u32 prof_idx)
>   {
>   	switch (prof_idx) {
>   	case ICE_PROFID_IPV4_GTPC_TEID:

Is there a reason to limit the length or could `unsigned int` be used?


Kind regards,

Paul
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
