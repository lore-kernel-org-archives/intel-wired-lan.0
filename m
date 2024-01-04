Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058E0C47073
	for <intel-wired-lan@archiver.kernel.org>; Thu,  4 Jan 2024 11:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89D9960A93;
	Thu,  4 Jan 2024 11:17:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89D9960A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1704367072;
	bh=DwfgeqZ9YPLuMF/X0D637QqVrVRdtDpAwmKQkNvMJ8o=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=CKgbSSc8xkVi9q7OAPVoR6HXCLEB7otcDaaGftnudUrJHWYuALMQb9t0vXV29MiPq
	 R56puTFgepIKeqHlh5xnvx0ctbM7YcO5wDDhmXkqa/Q3EUN/vv1SXfYZ0vyxN4XtZf
	 raRENwyYpVnmT7cmidwil87E7e29KmJ5CriCjpHrvGoXxyV1p8ghYzAmXSYLM+55aG
	 PY7T0Xa367O01yj0nCzkLC3y2mxswAk+qwI8/xAs1QrxJFH70jeTtqYI/afKjrckxH
	 pqq/D4ad901slOm7eWe1oWkYHjYRURKJDtabzQioztF36uypXfYTnVxk3EobZaxp6S
	 SXVcBkmM4SeEw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yR2OugcL9j1n; Thu,  4 Jan 2024 11:17:52 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF16C60B0B;
	Thu,  4 Jan 2024 11:17:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF16C60B0B
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8CA811BF3C9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 11:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64AE9400A9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 11:17:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64AE9400A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lziObkuX8-OZ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  4 Jan 2024 11:17:49 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA6BF41B42
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 11:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA6BF41B42
Received: from [192.168.44.15] (unknown [185.238.219.61])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A852461E5FE05;
 Thu,  4 Jan 2024 12:16:10 +0100 (CET)
Message-ID: <a27c1c87-4668-4166-9e0e-1005b2244f7a@molgen.mpg.de>
Date: Thu, 4 Jan 2024 12:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240104101904.18267-1-przemyslaw.kitszel@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240104101904.18267-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Intel-wired-lan] [linux-firmware] ice: update ice DDP package
 to 1.3.36.0
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
Cc: Shekhar Deb <shekhar.deb@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Priya Limaye <priya.limaye@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Przemek,


Thank you for your patch.

Am 04.01.24 um 11:18 schrieb Przemek Kitszel:
> Change log since 1.3.35.0:
> - add support for E825C device family support

The last *support* sounds strange. Maybe just:

Support E825C device family

or

Add support for E825C device family

> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>   WHENCE                                        |   4 ++--
>   .../{ice-1.3.35.0.pkg => ice-1.3.36.0.pkg}    | Bin 692776 -> 692776 bytes
>   2 files changed, 2 insertions(+), 2 deletions(-)
>   rename intel/ice/ddp/{ice-1.3.35.0.pkg => ice-1.3.36.0.pkg} (98%)
> 
> diff --git a/WHENCE b/WHENCE
> index 06fb7a45aa33..43f3916638b9 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -6138,8 +6138,8 @@ Licence: Redistributable. See LICENSE.amlogic_vdec for details.
>   
>   Driver: ice - Intel(R) Ethernet Connection E800 Series
>   
> -File: intel/ice/ddp/ice-1.3.35.0.pkg
> -Link: intel/ice/ddp/ice.pkg -> ice-1.3.35.0.pkg
> +File: intel/ice/ddp/ice-1.3.36.0.pkg
> +Link: intel/ice/ddp/ice.pkg -> ice-1.3.36.0.pkg
>   File: intel/ice/ddp-lag/ice_lag-1.3.1.0.pkg

Should the old version be removed?

[…]


Kind regards,

Paul
