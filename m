Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ABCD58E7D
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Mar 2026 09:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33DCB4096B;
	Mon,  2 Mar 2026 09:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_R3ZCyt7rsI; Mon,  2 Mar 2026 09:11:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 934FD4048D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772442704;
	bh=/aiRNcnNLuoKFFd/yX9ZoZ79e6l8JYskh3au9FA6zTk=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gFdjieIpUxSviCcsAr9cZn3gkDiraEzzIfYdQDQcmuP41TxHukfpotvbT/TwGRKQg
	 Lw7J1SPuQBNs33D0I1phWUO5d46oINNGv8kR2J/2NRCTiqissaxBlRC3aQZXlGGchx
	 oZknUmUYKio0guQVWM6FsyqTOXt3Tg7zN0oWAYzpmykTYw9aRFl9WAjwDJpUFUTZuO
	 M45JUa7w0Vg2bmQJYVP/psdYPObfyq2Q/v0uQifIGk7JtycOTCZKk5r6NW7WCXVAJn
	 ZoR8xu9KsOf7aetbmlOFJTG4EuCv2SI2mfYzQm1Iih097U6qm+zVGnDbSD5ZbIk6Ha
	 vy5MPF3++EdRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 934FD4048D;
	Mon,  2 Mar 2026 09:11:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96ED4231
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9408960688
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7sP_2FSVKBdd for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Mar 2026 09:11:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CA2FD60F56
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA2FD60F56
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA2FD60F56
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:11:38 +0000 (UTC)
Received: from [192.168.2.221] (p5b13a7da.dip0.t-ipconnect.de [91.19.167.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 125914C2C37D60;
 Mon, 02 Mar 2026 10:10:54 +0100 (CET)
Message-ID: <a58053f0-9780-4226-87ea-d4cf9bf32383@molgen.mpg.de>
Date: Mon, 2 Mar 2026 10:10:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
 header
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

Dear Andy,


Thank you for the patch. In the summary/title I’d add the header name. 
Should you resend, maybe:

i40e: Include missing wordpart.h header

Am 02.03.26 um 10:03 schrieb Andy Shevchenko:
> When cleaning up another header I have met this build error:
> 
> drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
>    105 |         val1 = (u32)(upper_32_bits(pa));                                \
> 
> This is due to missing header, add it to fix the possible issue.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_hmc.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> index 480e3a883cc7..967711405919 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> @@ -4,6 +4,8 @@
>   #ifndef _I40E_HMC_H_
>   #define _I40E_HMC_H_
>   
> +#include <linux/wordpart.h>
> +
>   #include "i40e_alloc.h"
>   #include "i40e_io.h"
>   #include "i40e_register.h"

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
