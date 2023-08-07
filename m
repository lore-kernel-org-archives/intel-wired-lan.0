Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD78C001B0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Aug 2023 07:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01BFA80BBC;
	Mon,  7 Aug 2023 07:57:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01BFA80BBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691395059;
	bh=JvQ+ta63n7KPc2QF0Chd1WLmmqboO38QU8K8Bre6jFU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3h8+ss/qgKT7mqMD8aQxigaLJNTpVAbMC9liBW5ydcLMBTOhNnUH/7pQGyNWuQWZw
	 xgyRbOGBDFGH7Vdmla4vqWmx1FRuM6+AqztOyp2k5A/wdJf1/LQNZ+bgOeDB7iwOD6
	 a0A92+OBEufcNRcJbHLkrn7ddtmud3ijXsy9j1L2DU1xnbN5eVqJ24v0MaEgf/2n3M
	 sP/907F6djAIsED8tvsYwgdXDNFuxtmuJXuO+ZtCZTkyU4Eh1jDfEc0JWh9dijcn0E
	 xxXxYF8snTSXj0c3nznm5YGN22dsasZuxLm4PXkjvEvibVRF6yuSu1WA0Pk4gxLMLW
	 gVOtQc/UMOvHg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id arxXjBqcypEC; Mon,  7 Aug 2023 07:57:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1347D80C12;
	Mon,  7 Aug 2023 07:57:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1347D80C12
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 72DD41BF357
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 07:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7442E80C12
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 07:56:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7442E80C12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3dGkNPaZNMre for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Aug 2023 07:56:54 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D71380BE9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 07:56:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D71380BE9
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fe655796faso1710244e87.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Aug 2023 00:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691395011; x=1691999811;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9X5bdW2tg9UJAuSkealMvYLVvu+VYHMvYfm0lzMKtlc=;
 b=FNzRoBVImABX09rMeOaDguy0gP4FQ57CC0F9x0W4uSYEGJz7U26dWxqHySwXda2aHe
 qgcO6pZwNI5EMN7kHYfLn8KzUKrDz5GITRoyXJYQKMm+HFLSH0i1faAO+UJGebDwUnRL
 VfFmg0A7JlCjPka1qhXP+ZYFfxXSnlFYM6Df2y9Q9a6iPx3r2ovAiUxWkjslG6mkpoBu
 X6aI8xnjRSABRE7Xs3lyCDjG7U7l2qNLXMqOm27AkDvxDSl5cDQuuMdQH8dZjbT0/gqu
 hDk7YwvHGMZRaDSrDb1IYXI4XcyWDgWgsHyTG4Jif3cOBXnbw49gPOo2m5p+LE0BScBd
 B4MQ==
X-Gm-Message-State: AOJu0YwmVjE+oMpDaaZUBDuJ3AeeUBBYJeG60djWFXJt3ngWn32Eiyg1
 qL4BtN7k/PM9cO5A8/+al30gFQ==
X-Google-Smtp-Source: AGHT+IHq37YjmUYw/gjf949OCDtsNW8K+MdHewkK97EovTahgtapHBI9OvPKVkhkmLSnNYg0vxfjow==
X-Received: by 2002:a2e:9316:0:b0:2b9:bcac:7ba6 with SMTP id
 e22-20020a2e9316000000b002b9bcac7ba6mr5601319ljh.46.1691395010925; 
 Mon, 07 Aug 2023 00:56:50 -0700 (PDT)
Received: from localhost ([212.23.236.67]) by smtp.gmail.com with ESMTPSA id
 q1-20020a05600c040100b003fe29dc0ff2sm9862961wmb.21.2023.08.07.00.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 00:56:50 -0700 (PDT)
Date: Mon, 7 Aug 2023 09:56:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <ZNCjwfn8MBnx4k6a@nanopsycho>
References: <20230804190454.394062-1-vadim.fedorenko@linux.dev>
 <20230804190454.394062-3-vadim.fedorenko@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230804190454.394062-3-vadim.fedorenko@linux.dev>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691395011; x=1691999811; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9X5bdW2tg9UJAuSkealMvYLVvu+VYHMvYfm0lzMKtlc=;
 b=CUrzVyahwtYzhrnnRp2UBmh3Oqh+6E1KSIDCSyA0abNRU23EsUGEsfPGj1muqqRPhZ
 UkrKgbcfaRJS23eXs756pTkgl0e2XeWKqqMhdBiULbarxSzBWD5rsPOwIZ7KQAlkzu+d
 QHfLsoa55LLYBl0MoV+rIvwloG6l4ZjdL92uCWey0CNcwjENDuxc5QiKADKW8DOd2ZC/
 sbZerpqaie90RkiICyZjwp5qmQrs4nNiOTrWdz0OZP8DoXOm1uPjMfszKLA1GEc01X3j
 0xpu0Z353qZA4Sk5EtIHrrXdYg9M6y7jU0lfwwmgwCQaPUpP/ne/Aheu0zS98UUXbDIk
 tHjw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20221208.gappssmtp.com
 header.i=@resnulli-us.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=CUrzVyah
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 2/9] dpll: spec: Add
 Netlink spec in YAML
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
Cc: Bart Van Assche <bvanassche@acm.org>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org,
 Milena Olech <milena.olech@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fri, Aug 04, 2023 at 09:04:47PM CEST, vadim.fedorenko@linux.dev wrote:
>Add a protocol spec for DPLL.
>Add code generated from the spec.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---

Hmm, running tools/net/ynl/ynl-regen.sh generates following diff:
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index ff3f55f0ca94..638e21a9a06d 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -17,7 +17,6 @@ const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_STATE + 1] =
 	[DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
 };
-
 const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1] = {
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index f659fabb1041..18d4fda484e8 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -163,7 +163,6 @@ enum dpll_a {
 	DPLL_A_PIN_PARENT_DEVICE,
 	DPLL_A_PIN_PARENT_PIN,
 
-	/* private: */
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
 };
@@ -182,7 +181,6 @@ enum dpll_cmd {
 	DPLL_CMD_PIN_DELETE_NTF,
 	DPLL_CMD_PIN_CHANGE_NTF,
 
-	/* private: */
 	__DPLL_CMD_MAX,
 	DPLL_CMD_MAX = (__DPLL_CMD_MAX - 1)
 };

Do you base this patchset on top of recent net-next? If not, please do
rebase.


Other than this, looks fine to me.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
