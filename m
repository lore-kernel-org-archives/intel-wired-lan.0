Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9502C636D6
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Feb 2023 14:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3170641032;
	Wed, 22 Feb 2023 14:22:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3170641032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677075764;
	bh=R/4uNiqMX40AJ8MtDz7Nq2Oj9VtNI+L7mRmvvcHnki4=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jtV+RrvcDfzHvfwIpCHMvdxdPC36DilIdogomWQgCch3CG/xgA0G/bM1rudx0bQFf
	 hgkXEWlDamE7WTky5t4XB2ESBTpCV+NQsY08Qzkb5RYqQCUlIW1JKq6ge/aYChlFJV
	 4xwDu+vpZpcUvQxayF04GDgVoSzNbwr8PvhtpjUDtl+ghHVwN9EJvjDmjiJ1oIXKmD
	 BNkLTD9aXoTy7VxNM2/NgncXxf1CKrrQ0lf12OoiK9k+WTqDJmMf1jI9Ujr3G/grFM
	 p/iDGpSpi5SMANp7ScduizTe8tBO/a00yTvONfbRSXX7yDhJSUvT+eA3UXSPQsPL5C
	 Is3HK2+s6sjZQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l-a59al0IjEw; Wed, 22 Feb 2023 14:22:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3523141039;
	Wed, 22 Feb 2023 14:22:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3523141039
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id E7AFD1BF589
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Feb 2023 14:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCF4A8144B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Feb 2023 14:22:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCF4A8144B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HLjsxKKUwrSy for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Feb 2023 14:22:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 091F681448
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 091F681448
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Feb 2023 14:22:39 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id CA89261CC457B;
 Wed, 22 Feb 2023 15:22:36 +0100 (CET)
Message-ID: <20c52c7c-c3c6-ff3c-469f-ed3cfea88e1d@molgen.mpg.de>
Date: Wed, 22 Feb 2023 15:22:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Mateusz Palczewski <mateusz.palczewski@intel.com>
References: <20230222140741.35550-1-mateusz.palczewski@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230222140741.35550-1-mateusz.palczewski@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net v3] e1000e: Disable TSO on i219-LM
 card to increase speed
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
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 intel-wired-lan@lists.osuosl.org,
 Sebastian Basierski <sebastianx.basierski@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

[Cc: +Kai-Heng]


Dear Mateusz, dear Sebastian,


Thank you for the patch.

Am 22.02.23 um 15:07 schrieb Mateusz Palczewski:
> From: Sebastian Basierski <sebastianx.basierski@intel.com>
> 
> While using i219-LM card currently it was only possible to achieve
> about 60% of maximum speed due to regression introduced in Linux 5.8-rc1.
> This was caused by TSO not being disabled by default despite commit
> f29801030ac6 ("e1000e: Disable TSO for buffer overrun workaround")
> implementation. Fix that by disabling TSO during driver probe.

Can the code added by the referenced commit then be removed?

Also the questions from the discussion of v2(?) was not answered, why 
the conditions in the if statement of the code added by commit 
f29801030ac6 where not true.

     /* disable TSO for pcie and 10/100 speeds, to avoid
      * some hardware issues
      */
     if (!(adapter->flags & FLAG_TSO_FORCE)) {

Missing Fixes: tag below.

> Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>   v3: Changed the patch to disable TSO during the probe
>   v2: Fixed commit message and comment inside the code
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 04acd1a992fa..863796acf8d7 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -7529,6 +7529,14 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   			    NETIF_F_RXCSUM |
>   			    NETIF_F_HW_CSUM);
>   
> +	 /* Disable TSO for i219 to avoid transfer speed
> +	  * being capped at 60%.
> +	  */
> +	if (hw->mac.type == e1000_pch_spt) {
> +		netdev->features &= ~NETIF_F_TSO;
> +		netdev->features &= ~NETIF_F_TSO6;
> +	}
> +
>   	/* Set user-changeable features (subset of all device features) */
>   	netdev->hw_features = netdev->features;
>   	netdev->hw_features |= NETIF_F_RXFCS;


Kind regards,

Paul
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
