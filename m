Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862860A2609
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qn1GHwbI;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JxJkfNFa;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JxJkfNFa;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JxJkfNFa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B95CF8115D;
	Tue, 10 Nov 2026 12:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bwbK66VtS87K; Tue, 10 Nov 2026 12:24:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6DE381184
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313495;
	b=kNk7xtGVc7CLQVJoYwgktY27EbhiGTu325873y+SejgZ12oCjDv6xiCSzg2n3Bfift1O
	 gWz2G4vr3BoChp900A02HuaGGLFzdGlxiyWVOmYKNj06xC0LRnnsRJJXu1PZDvqKHlRge
	 QFfly5yNk+2ndjw+Wnlozrb10sXSNUvwxpYl7PpBxHXqhczifmOwFlEcXQPoHjI82urX7
	 KuAAYj99G2HxuEqn6RXoeS8epx81zBGsbpIaD9/xvBtbDRdA5fIWh3zXdyvD6FGuAkW7j
	 sSDnCu40vuTYWouO8l8VwElvCKOcDa8lnelhEQ4jkkqfK/xWFusCYMzATWjWna99pZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
	b=ofkU8vBD25MB+9vVzx6bzRjz+Dfrbv5ZQt2svwB0f+G9Ofxp3vPkcZmh0CJCQ+x3xTIo
	 xmL3NckAehFHtp1Zwb6iaWeMjwz+sD4nvkYa1qFrFdzQ5RBaRfLDlOMJS1/9xGcQFcAKu
	 chTLl3676Pxugi+7bN72Bmp42oWlqSHrzjakk01BehR6kDs+GwnLdvA4X1sieKZhAjNSM
	 FXUmC5RmvrscbM/Lo1O1zrgEtkgt/VL1w5z+EKex8htOqLuCGlf3VO8UexAxAhtzk3fNJ
	 I06q7XSaeXiIPu2hPIyDp/aeHcg/Ds/lzSFA559tygWu34CYYxRjJgaQvN1/BqzXk1w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JxJkfNFa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JxJkfNFa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JxJkfNFa;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794313495;
	bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qn1GHwbIYDq4sPpla37FfKrmE/bNTDtVEpA4FSJPQji8Sbf6yj66uQEsD8V3YTCq4
	 Sf0faUDO/9CHEBO8E/XcAFozNzcWiqmSaC2PbPnWAAAGlYvrvlqS4obuuNgL6tMAa5
	 EKHLuc6YcOnWmq1a8rXL9ftR0dVxl7Ae/xTV4uzMCUcyPZ0Fl4Fpu8Z8cRrrZlo8mu
	 s/rkYn3HWmRzk52KXoxhNSxqce9e/+zV7QWRO/pJUPK1LUAdxoNzpwSMk82npLZMDL
	 TGJAuJssD1ShgRYac9RbRIOKd1n+1iraitPabpVLW/0bnDUWIN10eNuH3+s5UPDj/+
	 ztkA7jc7Untmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6DE381184;
	Tue, 10 Nov 2026 12:24:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FE541A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D0068115D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGH5a4-jIASx for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 12:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F5B7811FC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JxJkfNFa; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JxJkfNFa; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JxJkfNFa
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F5B7811FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
 b=JxJkfNFamqi7DRwudwOlShH2OceLp3OiPFwUrzzr9rNtmrrpSaL1HfjlMXDRJclXze7663
 GSJhYgIuXfi5v2p1AG4DuiZKrZCqG9W9B1zfCxmY/Vs5ZeEEebswvjfukAoMBTpelui6IE
 c4cNUZiYq8/ri9kfxsudNIeWsZ60vTo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
 b=JxJkfNFamqi7DRwudwOlShH2OceLp3OiPFwUrzzr9rNtmrrpSaL1HfjlMXDRJclXze7663
 GSJhYgIuXfi5v2p1AG4DuiZKrZCqG9W9B1zfCxmY/Vs5ZeEEebswvjfukAoMBTpelui6IE
 c4cNUZiYq8/ri9kfxsudNIeWsZ60vTo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
 b=JxJkfNFamqi7DRwudwOlShH2OceLp3OiPFwUrzzr9rNtmrrpSaL1HfjlMXDRJclXze7663
 GSJhYgIuXfi5v2p1AG4DuiZKrZCqG9W9B1zfCxmY/Vs5ZeEEebswvjfukAoMBTpelui6IE
 c4cNUZiYq8/ri9kfxsudNIeWsZ60vTo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-sM7W4kN8NuGyoyAJtTF14g-1; Tue, 10 Nov 2026 07:24:48 -0500
X-MC-Unique: sM7W4kN8NuGyoyAJtTF14g-1
X-Mimecast-MFC-AGG-ID: sM7W4kN8NuGyoyAJtTF14g_1794313487
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a4654add56so14524795e9.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313487; x=1794918287;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
 b=ywJjAOoAu2SLMGZSyD5YWtRs+yXZknM7tAJncp2eAGtQKkD42P1/hVzmZu5vv+PA15
 5azYRKS9v2kbF1I31kFqg0558wYnKuZDIAuyFRzD4PkqJs6wuemOcz98ckvL3/8uKRPP
 0JGTQVW/Fvz2LPq4WTEXial6dyhRi+0OEXmZSPCdhJz/a82Hz7iYLrPrF+Jssb8hzJOs
 /NW35IOrR7j/+KtvDjuM7wp9+3ghXxu+oCk4UglFxmPAEKaV+Z5+vgdWL9Mo6qzmpkU4
 Wnx8gvL5vBSr3reczhLiCgQCkFziJXmuuYwwNk4aAKZQTAt/vL/TspR6+e69V9sNTQaN
 ULUA==
X-Forwarded-Encrypted: i=1;
 AL+hErH3+DGpc6PCKN8QG/Hy0xvFbzX+maKtf3mI4ko+gQ7DcBaHYyTRHq5YbGo1omskHGyK+bwFSTbISm+NsAQKtAI=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9d99v3NczQspvi3GRZcJs8kJuKxKGvU5PEWh+w0BRGjURGpQFI
 s+UXD+3QrLGXVIXNzRdQRKHzip07gM/BILbJ8ZFOtpMJZ0ErZ5i0VY2uTLEQMJcNsjjWMK3wvQr
 03WptliQTPUZ8r1yXKYQvUoxI4/a5jHZ1pEgW/zh6/IulD0eKKJcSVIhlbmoS+Tk8ma+FHo8=
X-Gm-Gg: AYBFou2XVKj/3rwjBHG2devSBvSLl4cK1qCNgF3fPSuxBB0MDLyEbETLKz9IAm9WGSm
 dM5ll+Y5RwC3Dsq4bDbHhEZR/wqaRsHJdElcHaJw0JwY8p9kWzbWQkhn3XV3DhZ5vR8FedLKcSu
 cxwRw9EkAmfF7aMFF7G627OK3HNLLLOSabulQD1MQyXa6GGFBCQHJcBv/CFgXJsEUMxK63g65vn
 A8EeRElchr5uVQcGEhVmcITLV6g0i27LNMmpSGnsBPQMrJgUcoCx23r9MExvtc83vJwXTKMkVGS
 ZNbSsRaQHzBlYBA9TO1SA4fJrqXK0HLmDDKS5yYM/J31rkC3CpPlMZiyoWcF/7nAg4Wt59ISz2u
 GQWos1V7D+fDhA+cK1IbpiQva8P8CY0AhZeY=
X-Received: by 2002:a05:600c:4e55:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4ba023052a8mr41188515e9.2.1794313487139; 
 Tue, 10 Nov 2026 04:24:47 -0800 (PST)
X-Received: by 2002:a05:600c:4e55:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4ba023052a8mr41187875e9.2.1794313486647; 
 Tue, 10 Nov 2026 04:24:46 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0223c41csm62198205e9.14.2026.11.10.04.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 04:24:45 -0800 (PST)
Message-ID: <eea7b4ef-a514-4c2e-81c4-690cdeeb40c2@redhat.com>
Date: Tue, 10 Nov 2026 13:24:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/10] dpll: reject measured_freq_get for foreign
 and on-pin registrations
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-8-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-8-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qnk_3xIUYhVscEBAE9pkb9zYWVq-9RR06Wr2u_Dfye8_1794313487
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> A message about a pin with .measured_freq_get calls .freq_monitor_get of
> a dpll of the pin. For a pin of another domain, this device callback
> would run outside the domain of the dpll, so dpll_pin_register() now
> rejects such ops.
> 
> dpll_pin_on_pin_register() checks nothing about them. The message would
> call .freq_monitor_get with no NULL check, on a dpll of the parent pin
> that can belong to another driver, so reject them there as well.
> 
> No in-tree driver passes such ops. Add KUnit tests: the ops work on a dpll
> of the domain of the pin, and are rejected on a dpll of another domain and
> under a parent pin.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c       |   6 +-
>   drivers/dpll/dpll_core_kunit.c | 112 +++++++++++++++++++++++++++++++--
>   2 files changed, 111 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 8eb74682343156..84377f8ba16036 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -958,7 +958,8 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>   
>   	dev_ops = dpll_device_ops(dpll);
>   	if (WARN_ON(ops->measured_freq_get &&
> -		    (!dev_ops || !dev_ops->freq_monitor_get ||
> +		    (pin->domain != dpll->domain || !dev_ops ||
> +		     !dev_ops->freq_monitor_get ||
>   		     !dev_ops->freq_monitor_set))) {
>   		ret = -EINVAL;
>   		goto out_unlock;
> @@ -1065,7 +1066,8 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
>   
>   	if (WARN_ON(!ops) ||
>   	    WARN_ON(!ops->state_on_pin_get) ||
> -	    WARN_ON(!ops->direction_get))
> +	    WARN_ON(!ops->direction_get) ||
> +	    WARN_ON(ops->measured_freq_get))
>   		return -EINVAL;
>   
>   	down_write(&dpll_lock);
> diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kunit.c
> index a58800eda5ff51..84c405f855d8cb 100644
> --- a/drivers/dpll/dpll_core_kunit.c
> +++ b/drivers/dpll/dpll_core_kunit.c
> @@ -87,6 +87,7 @@ struct dt_reg {
>   	struct dt_dev *dev;
>   	struct dt_pin *parent;
>   	struct dt_pin *notify;
> +	const struct dpll_pin_ops *ops;
>   	struct dpll_domain *forbid;
>   	enum dpll_pin_state state;
>   	enum dpll_pin_direction direction;
> @@ -276,11 +277,33 @@ static int dt_lock_status_get(const struct dpll_device *dpll, void *priv,
>   	return 0;
>   }
>   
> +static int dt_freq_monitor_set(const struct dpll_device *dpll, void *priv,
> +			       enum dpll_feature_state state,
> +			       struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}
> +
> +static int dt_freq_monitor_get(const struct dpll_device *dpll, void *priv,
> +			       enum dpll_feature_state *state,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct dt_dev *dev = priv;
> +
> +	dt_dev_enter(dev, dpll);
> +	*state = DPLL_FEATURE_STATE_ENABLE;
> +	dt_leave(dev->dom);
> +
> +	return 0;
> +}
> +
>   static const struct dpll_device_ops dt_dev_ops = {
>   	.mode_get = dt_mode_get,
>   	.mode_set = dt_mode_set,
>   	.supported_modes_get = dt_supported_modes_get,
>   	.lock_status_get = dt_lock_status_get,
> +	.freq_monitor_set = dt_freq_monitor_set,
> +	.freq_monitor_get = dt_freq_monitor_get,
>   };
>   
>   static int dt_frequency_get(const struct dpll_pin *pin, void *pin_priv,
> @@ -433,6 +456,21 @@ static int dt_ref_sync_get(const struct dpll_pin *pin, void *pin_priv,
>   	return 0;
>   }
>   
> +static int dt_measured_freq_get(const struct dpll_pin *pin, void *pin_priv,
> +				const struct dpll_device *dpll, void *dpll_priv,
> +				u64 *measured_freq,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct dt_reg *reg = pin_priv;
> +
> +	dt_pin_enter(reg, pin);
> +	atomic_inc(&reg->freq_gets);
> +	*measured_freq = 1;
> +	dt_leave(reg->dom);
> +
> +	return 0;
> +}
> +
>   static const struct dpll_pin_ops dt_pin_ops = {
>   	.frequency_get = dt_frequency_get,
>   	.state_on_dpll_get = dt_state_on_dpll_get,
> @@ -446,6 +484,13 @@ static const struct dpll_pin_ops dt_pin_ops = {
>   	.ref_sync_get = dt_ref_sync_get,
>   };
>   
> +static const struct dpll_pin_ops dt_pin_ops_measured = {
> +	.measured_freq_get = dt_measured_freq_get,
> +	.state_on_dpll_get = dt_state_on_dpll_get,
> +	.state_on_pin_get = dt_state_on_pin_get,
> +	.direction_get = dt_direction_get,
> +};
> +
>   static const struct dpll_pin_properties dt_prop = {
>   	.type = DPLL_PIN_TYPE_EXT,
>   	.capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE |
> @@ -570,9 +615,9 @@ static void dt_reg_release(void *data)
>   
>   	if (reg->parent)
>   		dpll_pin_on_pin_unregister(reg->parent->pin, reg->pin->pin,
> -					   &dt_pin_ops, reg);
> +					   reg->ops, reg);
>   	else
> -		dpll_pin_unregister(reg->dev->dpll, reg->pin->pin, &dt_pin_ops,
> +		dpll_pin_unregister(reg->dev->dpll, reg->pin->pin, reg->ops,
>   				    reg);
>   }
>   
> @@ -588,12 +633,14 @@ static void dt_reg_add(struct kunit *test, struct dt_reg *reg,
>   	reg->parent = parent;
>   	reg->state = DPLL_PIN_STATE_SELECTABLE;
>   	reg->direction = DPLL_PIN_DIRECTION_INPUT;
> +	if (!reg->ops)
> +		reg->ops = &dt_pin_ops;
>   
>   	if (parent)
> -		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
> -					       &dt_pin_ops, reg);
> +		ret = dpll_pin_on_pin_register(parent->pin, pin->pin, reg->ops,
> +					       reg);
>   	else
> -		ret = dpll_pin_register(dev->dpll, pin->pin, &dt_pin_ops, reg);
> +		ret = dpll_pin_register(dev->dpll, pin->pin, reg->ops, reg);
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_reg_release,
>   							reg), 0);
> @@ -1432,6 +1479,59 @@ static void dt_test_ref_sync_pair(struct kunit *test)
>   	dt_expect_events(test, (void *[]){ ctx->p.pin }, 1);
>   }
>   
> +/* A pin with a measured frequency must be in the domain of its dpll */
> +static void dt_test_measured_freq_foreign(struct kunit *test)
> +{
> +	struct kunit_suppressed_warning *w;
> +	struct dt_ctx *ctx = test->priv;
> +	struct dt_reg *reg;
> +	int ret;
> +
> +	dt_dev_add(test, &ctx->e0, &ctx->dom_e, DT_CLOCK_ID_E, 0,
> +		   DPLL_TYPE_PPS);
> +	dt_dev_add(test, &ctx->f0, &ctx->dom_f, DT_CLOCK_ID_F, 0,
> +		   DPLL_TYPE_PPS);
> +	dt_fwnode_pin_add(test, &ctx->x, DT_CLOCK_ID_E, DT_PIN_IDX_X);
> +
> +	reg = &ctx->reg_x_e0;
> +	reg->ops = &dt_pin_ops_measured;
> +	dt_reg_add(test, reg, &ctx->dom_e, &ctx->x, &ctx->e0, NULL);
> +	atomic_set(&reg->freq_gets, 0);
> +	KUNIT_EXPECT_EQ(test, dt_run(test, dt_pin_ntf, &ctx->x), 0);
> +	KUNIT_EXPECT_GT(test, atomic_read(&reg->freq_gets), 0);
> +
> +	w = kunit_start_suppress_warning(test);
> +	ret = dpll_pin_register(ctx->f0.dpll, ctx->x.pin, reg->ops, reg);
> +	kunit_end_suppress_warning(test, w);
> +
> +	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
> +	if (!ret)
> +		dpll_pin_unregister(ctx->f0.dpll, ctx->x.pin, reg->ops, reg);
> +}
> +
> +/* A pin under a parent pin cannot have a measured frequency */
> +static void dt_test_measured_freq_on_pin(struct kunit *test)
> +{
> +	struct kunit_suppressed_warning *w;
> +	struct dt_ctx *ctx = test->priv;
> +	struct dt_reg *reg;
> +	int ret;
> +
> +	dt_on_pin_add(test);
> +	dt_pin_add(test, &ctx->y, DT_CLOCK_ID_G, DT_PIN_IDX_Y, &dt_prop);
> +	reg = &ctx->reg_c_m;
> +
> +	w = kunit_start_suppress_warning(test);
> +	ret = dpll_pin_on_pin_register(ctx->m.pin, ctx->y.pin,
> +				       &dt_pin_ops_measured, reg);
> +	kunit_end_suppress_warning(test, w);
> +
> +	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
> +	if (!ret)
> +		dpll_pin_on_pin_unregister(ctx->m.pin, ctx->y.pin,
> +					   &dt_pin_ops_measured, reg);
> +}
> +
>   static struct kunit_case dt_cases[] = {
>   	KUNIT_CASE(dt_test_domain_sharing),
>   	KUNIT_CASE(dt_test_domain_per_module),
> @@ -1456,6 +1556,8 @@ static struct kunit_case dt_cases[] = {
>   	KUNIT_CASE(dt_test_set_on_pin),
>   	KUNIT_CASE(dt_test_device_set_ntf),
>   	KUNIT_CASE(dt_test_ref_sync_pair),
> +	KUNIT_CASE(dt_test_measured_freq_foreign),
> +	KUNIT_CASE(dt_test_measured_freq_on_pin),
>   	{}
>   };
>   
Reviewed-by: Petr Oros <poros@redhat.com>

