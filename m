Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD51EB64DC
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Jul 2023 17:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C10F460D94;
	Mon, 17 Jul 2023 17:32:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C10F460D94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689615146;
	bh=RYpwZSe23zLZSNra79wZL632W8rQKpdR6a6MurZxpnY=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=0Fza/uqeocuh1JPKxvpMYb+qikRc2GYSf+9hi8Scd8toMCy0CjA8+qqYFWwndNVVJ
	 FpMr08FcRygYt5DIIUCbZZhCTKoiDt70/xjEtrFF8GW/wV1ZbTEE63rmaiB7AkZp91
	 tX+UjD+EF48NYBJ3sLYD2CIuD5u2ISO6X//QgY4B6ximVtDsigPo0QcgfX6JP+VePv
	 iGoK308hOlHSXhoaT+7g3+tBgExBmVsKCIvUcDynvz0S9unkcOUO4Qi8/TGkdmt08U
	 FvSgunZ/5x6JmT+ZC/jbtPapIvCoHbL5oy61ynSJxf8g62xhg0hV80FCBkGWkR0Hvw
	 otIFEFAhxQH2A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pc0aun_Wrp1Y; Mon, 17 Jul 2023 17:32:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 349E260DE5;
	Mon, 17 Jul 2023 17:32:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 349E260DE5
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 550901BF337
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 17:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CE2740472
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 17:32:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CE2740472
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxl7mIy8oEy5 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Jul 2023 17:32:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B33694010C
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B33694010C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 17:32:22 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae98e.dynamic.kabel-deutschland.de
 [95.90.233.142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 159A561E5FE01;
 Mon, 17 Jul 2023 19:32:04 +0200 (CEST)
Message-ID: <80bfadb3-5af3-0100-30bb-c5008660d5a5@molgen.mpg.de>
Date: Mon, 17 Jul 2023 19:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Sasha Neftin <sasha.neftin@intel.com>
References: <20230717171927.78516-1-sasha.neftin@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230717171927.78516-1-sasha.neftin@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Correct the short
 interval between PTM requests.
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
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

[Cc: +linux-pci@vger.kernel.org]

Dear Sasha,


Thank you for your patch.

Maybe be more specific in the commit message summary. Maybe:

igc: Decrease PTM short interval from 10 us to 1 us

Am 17.07.23 um 19:19 schrieb Sasha Neftin:
> With the 10us interval, we were seeing PTM transactions taking around 12us.
> With the 1us interval, PTM dialogs took around 2us. Checked with the PCIe
> sniffer.

On what board, and with what device and what firmware versions?

> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 44a507029946..c3722f524ea7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -549,7 +549,7 @@
>   #define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x2f) << 2)
>   #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
>   
> -#define IGC_PTM_SHORT_CYC_DEFAULT	10  /* Default Short/interrupted cycle interval */
> +#define IGC_PTM_SHORT_CYC_DEFAULT	1   /* Default short cycle interval */

Why is the comment updated?

>   #define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
>   #define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */


Kind regards,

Paul
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
