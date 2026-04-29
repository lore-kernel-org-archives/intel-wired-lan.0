Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B01FF8867
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Apr 2026 11:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56AF842333;
	Wed, 29 Apr 2026 11:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CqSHxEpCbujK; Wed, 29 Apr 2026 11:02:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3356142337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777460555;
	bh=6Cb+eOeKh2/iAF5cyO9+yDud9QZ6LA5aCftMTKzKcBU=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=siooR0kFFA64fuvXqYKWE/PmJp1FPT7a9o3WP7epMQYBbh/E+iVtpPSqGovrPc4Qt
	 87Rn75r4WAnp3aT9N++sHfMbro0fpk6xi7ULB0GhlyH72z9tAwNm99K6JvVo/lv4Em
	 ed/NgaGlbKe7/BsXArA3NpJKYvhsw+PRrGImGLdNWDrS9JI8W9xOLNmkXQplGe7cnr
	 kajgrbjxCbbY1HUpRt9ArjxxX0qY/TOVnfrX0anRMCqTGkTfh78zVS8llbVbf3n3ND
	 D4LH+mlyTm9AUfFLYd5kYamihywjIp+9Km8663QeReFeVoJUFvRFY8SKEkh6O+hT0L
	 NpvNzFLSgCJnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3356142337;
	Wed, 29 Apr 2026 11:02:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D0BE423D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 11:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C25564044C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 11:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nN8XDHzg9yXe for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Apr 2026 11:02:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 094114208C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 094114208C
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 094114208C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 11:02:27 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 048184C4431148;
 Wed, 29 Apr 2026 13:02:01 +0200 (CEST)
Message-ID: <558971b7-caea-471a-8fe2-73ba6cc0790a@molgen.mpg.de>
Date: Wed, 29 Apr 2026 13:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260428181450.2622899-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260428181450.2622899-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH] i40e: Fix i40e_debug() to use struct
 i40e_hw argument
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

Dear Mohamed,


Thank you for your patch.

Am 28.04.26 um 20:14 schrieb Mohamed Khalfella:
> i40e_debug() macro takes struct i40e_hw *h as first argument. But the
> macro body uses hw instead of h. This has been working so far because hw
> happen to be the name of the variable in the context where the marco is

marco → ma*cr*o

> expanded. Fix the macro to use the passed argument.

I’d add a Fixes: tag, but the maintainers might have more input.

> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_debug.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h b/drivers/net/ethernet/intel/i40e/i40e_debug.h
> index e9871dfb32bd..01fd70db9086 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debug.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
> @@ -42,7 +42,7 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw);
>   #define i40e_debug(h, m, s, ...)				\
>   do {								\
>   	if (((m) & (h)->debug_mask))				\
> -		dev_info(i40e_hw_to_dev(hw), s, ##__VA_ARGS__);	\
> +		dev_info(i40e_hw_to_dev(h), s, ##__VA_ARGS__);	\
>   } while (0)
>   
>   #endif /* _I40E_DEBUG_H_ */

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: gemini/gemini-3.1-pro-preview embargoed it’s review until the 
evening [1].


[1]: 
https://sashiko.dev/#/patchset/20260428181450.2622899-1-mkhalfella%40purestorage.com
