Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E000C3DA49
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jul 2024 08:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAA0D810EA;
	Tue, 23 Jul 2024 08:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3CnL-IVmj2Xv; Tue, 23 Jul 2024 08:27:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1814810B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1721723235;
	bh=M8oot5yLF5sFfwOhcYmVL7lhOnl7mwaITw/QHpWL3yY=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=shRuCuz4uH/rjYWnp8Jrk84DUx7+RKZLU1NpAN02V9Za+B1tiINdpDSzGvMx++708
	 RwgdGRbMjjre+wuze5v5dfMfQ+Idq5g41Z+yfUTf/iP/s5vMcEDiVYilMiVyeerK02
	 WNP/UE4C5PnivsKMgWnxSKk8zX9P9fGzyi0Xj6gWjSseoIRgvgqy7Ys30kzlfpen+3
	 JfeRU1ck2NyOCDzeZRluIsPNumIEQ9ukKFD5WC8kCyKEUG1QPW+DIPzFf1NHpjeCNw
	 ywk6rld+9t/e3xtx5iQ+Ma89mB1RLjVjlHPZbXpvUPVnaNaRMcEQ9ggBNGl++uMUQe
	 I1nU9OyhyJQbQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1814810B7;
	Tue, 23 Jul 2024 08:27:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 486E21BF29D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jul 2024 08:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3516B810B7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jul 2024 08:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oxvs7JhAJ6-T for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jul 2024 08:27:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 69D2A810B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69D2A810B0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69D2A810B0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jul 2024 08:27:13 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Va_sY8mzNrWm2L0azf6zGw-1; Tue, 23 Jul 2024 04:27:11 -0400
X-MC-Unique: Va_sY8mzNrWm2L0azf6zGw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4266a5c50fcso3171735e9.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jul 2024 01:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721723230; x=1722328030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8oot5yLF5sFfwOhcYmVL7lhOnl7mwaITw/QHpWL3yY=;
 b=Eyr0j4uz4RwmyMiK2hvKLGZAg4UHejbUyhZAQedUtAZdg2xFxexBkYgOyVFOKExVEP
 kr6+1f1+EfnElyHmEXLtVjyyzlAFyUaclJqLkfFwjYIWlP9sEz6k1gT3CIo5PquK0YfV
 mzvChqM4HfnU3D7XRxO8pbT3m+vZ48rSZv337XUrHJsP8D9fwLhDTBd4TgkxemCfd/1a
 xQyWUwWprEQuiWbaNZdVM8N3ARQPeonusr/swy8F334QsSoesP1PC/rpCxZInSk4wpMB
 Y6W9u7QOSVj+F4IXSPsW7AQ9RhYcsy/6qM6uIa54r4Sy0PTAAnhtpKvmiG7TPA3qiZry
 Y4Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyoGse/adDqf7BjoTQLf/eWDm75hYwDwqG9+a4LpHOZugW3xRAOaK00f8KyZs8TmYmE8RuNquOTX3G4yJC78g=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyMvL4aC6bG7UGoEFRwMgPqh4+3F6XEQFV13Oytl2TrxQ4jji5Z
 IsL1GtrCFCxepda4TJnmkZYPViF3Ct5MP+vhPUwd6EUWjuptHNjC0vG5dYnlt9t2qOmOCylUTya
 a3dW/WTYwbOmiqKMw+jbF4IagR5WNAZ8IcpgQvbKCKwVAXGX53pZZ6PccZ2DExo7twVM=
X-Received: by 2002:a05:600c:310b:b0:426:6ecc:e5c4 with SMTP id
 5b1f17b1804b1-427daa713abmr42159475e9.4.1721723229850; 
 Tue, 23 Jul 2024 01:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyB35vHUyy7xn9TnmLleBJi8gLs2mzDoXRcT5qHjLuUf9xNuul01VsC7irrgvs/KrKyAUdGg==
X-Received: by 2002:a05:600c:310b:b0:426:6ecc:e5c4 with SMTP id
 5b1f17b1804b1-427daa713abmr42159325e9.4.1721723229417; 
 Tue, 23 Jul 2024 01:27:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a63b70sm188462035e9.19.2024.07.23.01.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:27:08 -0700 (PDT)
Message-ID: <afdb7011-5098-47dd-89af-5ed0096294d8@redhat.com>
Date: Tue, 23 Jul 2024 10:27:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Corinna Vinschen <vinschen@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20240718085633.1285322-1-vinschen@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718085633.1285322-1-vinschen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1721723232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8oot5yLF5sFfwOhcYmVL7lhOnl7mwaITw/QHpWL3yY=;
 b=Sgvw9gayo1vZSbBw4VQ/Z25wswtNDKlYLcUrxAsk9VMTtDGRE116JWHlBeULZsg2TIDlEF
 9hmDuUKTIj9vH+B5scHYKN7EPDDC+FTC543MM05QhPwxZcrUOsPBrZb4f9MHoo8L3dvDhI
 WUMcRTs8lLBcbZRX1N6Li23a9n4A+20=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sgvw9gay
Subject: Re: [Intel-wired-lan] [PATCH net v3] igb: cope with large
 MAX_SKB_FRAGS.
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
Cc: Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org,
 Nikolay Aleksandrov <razor@blackwall.org>, linux-kernel@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 7/18/24 10:56, Corinna Vinschen wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
> 
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.
> 
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
> 
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.
> 
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

@Tony: would you like to take this one in your tree first, or we can 
merge it directly?

Thanks!

Paolo

