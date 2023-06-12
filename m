Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D280C88CB2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Jun 2023 15:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C34082253;
	Mon, 12 Jun 2023 15:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C34082253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686583900;
	bh=OupCqlmm5M9kqH8fz3qa095/OOuF4IKJDApi7xWMioU=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hyfdSzZ0Celri/aIe7IgHXPvwLJbi+fzX+X2UNZkzTAAQzAhf++YmSd1c8X0p6G46
	 qX+p4P8rxCk6rinGgxSYntdI5b/LX3iT5KecbY/q31HWsnRUZTXK/hcd9vvrRsq4vQ
	 9zXcN4cA5ChdEnTDIfAEvrsKWO4sYf9VQPY8GIhPjg6/QA5Oqyf/D+uSdzIfF3rKf1
	 Lc7/N+hir0fNYJE8nbnYaClnSBuCcwLZT6cxB7dq4NMJ024ZUfrgMBJYLfdWWgVkFr
	 cR72tHazsJo6fXbRvXqZtf99l1bplEd0IZjAK97LrvRjuXH7/jNta3KY+Ty4HxhFUq
	 AzcqOB6IRsu1A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ILPqgtDLzC5m; Mon, 12 Jun 2023 15:31:39 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CD8C8443E;
	Mon, 12 Jun 2023 15:31:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CD8C8443E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 463EF1BF398
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 15:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F23060C23
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 15:30:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F23060C23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UjMuDcii3iAJ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Jun 2023 15:30:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 883D460C09
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 883D460C09
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 15:30:07 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-653fcd58880so3490757b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 08:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686583807; x=1689175807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qt1TPwchcj2VuqrNTLbU1dI0zylo16OsUsxj0udlo1g=;
 b=aoH/AiVmb1jjgjFkvH2idNQ5SISevfqlo1IYpTMblxqRw0ydon/Z3dj02cwVVLgV5G
 nmOqdyf4llRFoV6s6ZA4jFIrTfeQxuJyIMOxWuIHFXDPN9gNKyu3dOXgiidkQE3RY7HZ
 2f07uliUMmmRRxY+l5oj32OYn8hJBxhSv77Bn73x0FfL7Jw5YiCL9OhDuWZoVslkR03E
 mBClXpMzB47hxRUqectIGHoIjFY60o0L3ZAI3BJ+4Aflae99g35+S9UK7hBzVYjRdBAX
 B03xvW5yUgq06Hj4D1OiBezslm61oqdtoLSpQi5CS1ZTfbmKu21KahlXO1gT8aM/qwV3
 vJVQ==
X-Gm-Message-State: AC+VfDwXtHBZUNKI50peoD/qOb+ksW0b/V8rtVqT+3RVRKJKzXcBDk/g
 VkR+7DjTKQstGtbN0dxSBTg=
X-Google-Smtp-Source: ACHHUZ56brA+YWWAEz8TU4PAVsV02R+SWgJ96a3WKlbirAIjvLSNbBO5cimblvEo6LG/ezoxWr2djQ==
X-Received: by 2002:a17:903:2347:b0:1b1:99c9:8ce1 with SMTP id
 c7-20020a170903234700b001b199c98ce1mr7581876plh.51.1686583806811; 
 Mon, 12 Jun 2023 08:30:06 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
 by smtp.gmail.com with ESMTPSA id
 jl1-20020a170903134100b001a245b49731sm6989724plb.128.2023.06.12.08.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 08:30:06 -0700 (PDT)
Message-ID: <de920a42-0d72-c5ec-1af9-8bfa4b954cfd@acm.org>
Date: Mon, 12 Jun 2023 08:30:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, kuba@kernel.org,
 jiri@resnulli.us, vadfed@meta.com, jonathan.lemon@gmail.com,
 pabeni@redhat.com
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-2-arkadiusz.kubalewski@intel.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230609121853.3607724-2-arkadiusz.kubalewski@intel.com>
X-Mailman-Approved-At: Mon, 12 Jun 2023 15:31:38 +0000
Subject: Re: [Intel-wired-lan] [RFC PATCH v8 01/10] dpll: documentation on
 DPLL subsystem interface
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
Cc: geert+renesas@glider.be, mst@redhat.com, razor@blackwall.org, phil@nwl.cc,
 javierm@redhat.com, edumazet@google.com, benjamin.tissoires@redhat.com,
 anthony.l.nguyen@intel.com, linux-clk@vger.kernel.org, lucien.xin@gmail.com,
 leon@kernel.org, corbet@lwn.net, linux-rdma@vger.kernel.org,
 masahiroy@kernel.org, linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 intel-wired-lan@lists.osuosl.org, airlied@redhat.com, vadfed@fb.com,
 ricardo.canuelo@collabora.com, arnd@arndb.de, idosch@nvidia.com,
 richardcochran@gmail.com, claudiajkang@gmail.com, kuniyu@amazon.com,
 jacek.lawrynowicz@linux.intel.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, linux-arm-kernel@lists.infradead.org,
 axboe@kernel.dk, sj@kernel.org, vadim.fedorenko@linux.dev, linux@zary.sk,
 gregkh@linuxfoundation.org, ogabbay@kernel.org, nipun.gupta@amd.com,
 linux-kernel@vger.kernel.org, andy.ren@getcruise.com, tzimmermann@suse.de,
 netdev@vger.kernel.org, saeedm@nvidia.com, davem@davemloft.net,
 milena.olech@intel.com, hkallweit1@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 6/9/23 05:18, Arkadiusz Kubalewski wrote:
> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
> new file mode 100644
> index 000000000000..8caa4af022ad
> --- /dev/null
> +++ b/Documentation/driver-api/dpll.rst
> @@ -0,0 +1,458 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================
> +The Linux kernel dpll subsystem
> +===============================
> +
> +The main purpose of dpll subsystem is to provide general interface
> +to configure devices that use any kind of Digital PLL and could use
> +different sources of signal to synchronize to as well as different
> +types of outputs.
> +The main interface is NETLINK_GENERIC based protocol with an event
> +monitoring multicast group defined.

A section that explains what "DPLL" stands for is missing. Please add 
such a section.

Thanks,

Bart.

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
