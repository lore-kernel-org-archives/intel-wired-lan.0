Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64780CA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 12:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00102405A9;
	Mon,  5 Oct 2026 12:07:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YNjph8Ex7df; Mon,  5 Oct 2026 12:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3EED2405AD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791202029;
	b=kv4fBjP+SfDuoaBJlimv3hPE/12ZrC1UFSgU0s99hPsIkeAaJIB18m+W2Fp/VL0aR1MC
	 t1Kf9IMKcxyj58wXsWYITgvLXrHEDJnAskyhbTXlgN8yoD0aC7+c99oQ4b6AplUAHEine
	 n/5lE5svI6iSELaWmq/79MOXkMl8//CDrgZIf4YBkxTbncgEnVnaY7kG2x/up1ovpOv4H
	 5rAzCVkQ+MILdO49Ue4QgBSQUkAOg8JXjgP9uGFM80J8bK0u2kYT/iIMNuOU49RoUSI4W
	 ep33ZIv8C3j5fxeUu8GZSQ4KlwD6fqJbQ1VhfEsx6dxtWVuGzA6spmTzJVMgeadYO4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791202029;
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
	bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
	b=U2CygiydESnGayJdgal/PPZy8MR7s+YiS7rq2Dva9rXT33daFd4NNq396wNslOU9SAOa
	 hziyJflqPp+nEAPl1xH0/VIor/RA4g+VYz2YmjNo6NmJGlR3EGWEcLTDKX0e+coy56blj
	 RprLc6Dutf1Cj2gJnhbHrZbpKSr7fkmGJin2giglPWQ6nmV1BmYjJumzuIe9kKYVq7qSU
	 jkt8r7gOVW92B4oYuKru3AomFfKu2awW/HE3J4dLxuK59dR0ufR9UyS4aOgWRG1I8cx2u
	 8DXEGDHV0B+8iu2D63bg0Di7IAp1WsAQF+3FjhbL3s16QayDMR9ROCAmtvm4Gok0hIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="FlfqY/SK";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="FlfqY/SK";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="FlfqY/SK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791202029;
	bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DRtko5tV95kotEDxoE4Kwu2TyjbFf0luhLSTp709KTvZwRhR+AX6r1ZIZ3FaI3Hqz
	 Xp6p0HZ7C1rulG+sO3SMzOqATUx69cAO1B8abz67e0TpIWyayfH/s5/pBuxAiAkMKq
	 eIN9bqiLGxWdXQJJVTdY9Oh6SDnoP4gFbUdM/n4fTFxyZ9673MN7e64eK39wIXVRdc
	 l6q40L5x4WBwbisp5/L4dUBtgcoT5szl4bNVx4g1jW933dzU2SihQm1qOBrRMfvAV1
	 t0omSqtAJizjxVFHjM/qa/hwbU75gN6CoyMOAS0Z4DSUG7CocRbkAl6GJHi/h2fY8U
	 OsCnVBCtM7TZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EED2405AD;
	Mon,  5 Oct 2026 12:07:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 131D31A6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 12:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ECCC1405A9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 12:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4QooS4eX6L4c for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 12:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0EF3D405A5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791201846;
 b=cQ4IrDRmzV09qfby9dQMarpNY/zfAMf3Gi7nIzjStrWZA0EBnYxpbzbhE5mvV0Yt/TLw
 B6/2pYUOtZ8iI/sLBaA/HjsqBSBwCN9qWaUV8w71EKteOjYoDy6lYO0lYHxNHmuELfQfv
 Sdz/jRpP8qk4DKM1nD21kTgQrydwPjImUm7V06t5aa6+JxK1R9inqy5VpEdjobFnyQsb9
 2AAoS0EGDq99AkRa1zDRv+ZPLiU+9WZ6/U+3CoPxvp7kxNEIj6mt6f5jhoCxrqPJiSCSd
 UBbwso+1u3S8zh8gnFjoj2X4U1gSc2f3BoqQsnOHEx8eygAXUCiDlj0TiZ9AnupMzrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791201846;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
 X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
 Content-Type:Content-Transfer-Encoding;
 bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
 b=qsmZmb6ySBWLXJxFjm+754kFYVTizY/hvNteifPN+NIUcU9YEEpm4mT7p5IfUG9u4//X
 3vlFNm8GnkVDn+NT6oIuTECMUYlrAYIaM6SgQawHjtWQpS9+tFJH/65xhmFETDTgbKZUB
 K0u7OKJ2PmJwkaQTxD1khbnIsExo07ENZFnyDb07RxE8gSBB4sKOD4e+2ToSI7kttGq2d
 wj8pZAPvPcodR4RfWcjeaa6xZDqWfo4wS2+wcHmc23vhTOACtwWVeduwh08zuDVvjFtHT
 Moyx+2dV8612wuIwRJcKjXtTbElRwKHfduZBhkQc8OChoDSEROv6oN8/E7cc178Hsiw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="FlfqY/SK"; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="FlfqY/SK"; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="FlfqY/SK"; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlfqY/SK; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlfqY/SK; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlfqY/SK
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0EF3D405A5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791201843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
 b=FlfqY/SKdtJVrkhANBi4UXlojkp8gTj81iF5bZGnOPT3DwH3h+ebN43w2pdFXeFGl0esE6
 G3At9sfBxBGUHvn7CGNbnso7tVX3ZVgu6zMZdZ/0XNr17xvPZ4yJOvCogkjjijofAVuTru
 /qL76AybzRPhU/K0aVWms8MrKoBvHjo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791201843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
 b=FlfqY/SKdtJVrkhANBi4UXlojkp8gTj81iF5bZGnOPT3DwH3h+ebN43w2pdFXeFGl0esE6
 G3At9sfBxBGUHvn7CGNbnso7tVX3ZVgu6zMZdZ/0XNr17xvPZ4yJOvCogkjjijofAVuTru
 /qL76AybzRPhU/K0aVWms8MrKoBvHjo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791201843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
 b=FlfqY/SKdtJVrkhANBi4UXlojkp8gTj81iF5bZGnOPT3DwH3h+ebN43w2pdFXeFGl0esE6
 G3At9sfBxBGUHvn7CGNbnso7tVX3ZVgu6zMZdZ/0XNr17xvPZ4yJOvCogkjjijofAVuTru
 /qL76AybzRPhU/K0aVWms8MrKoBvHjo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-s3vqS0AxM3Sc89xUpoGRlA-1; Mon, 05 Oct 2026 08:04:02 -0400
X-MC-Unique: s3vqS0AxM3Sc89xUpoGRlA-1
X-Mimecast-MFC-AGG-ID: s3vqS0AxM3Sc89xUpoGRlA_1791201841
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso14389135e9.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 05 Oct 2026 05:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791201841; x=1791806641;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
 b=kKYxjGW2VBMw5/0pctVo9qF9Obfdk2r3wHLIMuJD3mookxWrPEwrwCfZ4+/cA9lpqK
 3as4Yd2yQUAAafMY1h9/gCgGl53/BAehRdycAC0BQTsOt98Xx23ThX9TNdX4XE5Xqq1g
 eDw2K+d3tk1Fz58Nu1pRbotYZj8QBrz9w7dz6Eblw8M2BvpIM6qP4Jc7msGJUHamR6tJ
 kEiQUHQyeH8myTsT+LkTjdWZPW1nvVrpAshoIDR6SM7GyGYC6QKEwxkZxz9MW/1XTtXS
 wiKcSC/MppYko67hOkmEujIzmWQUZ+NZE0KVSIalA9SdEgTUA/ZiakLal2P6oiDcOvht
 J3mw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxdXRNo6KZyYoZMPijlS1FrFvB9EprDNIJNHIsHhOTuY0XbwtURXblOUTa/P4OdChufMYcp4GfdqKeKFZem7Q=@lists.osuosl.org
X-Gm-Message-State: AFuF++k0LLQHH2kFmYbACfcmwwr3EiAP8d3B0RAKdlNew7JJeYA8+kfA
 AbI+E3otsuMyTYlQ6W52hc4hqVpm/4fmJ5ifyhLQ2td/Hcy4C9NelnBObPOw3sieDg8QO1QVtVP
 NU+7oHXDwOxMrkKYcVzuvJOsIkkc5/Cg+hQVKtYSSHKwxqEnNwXPTik9WJpAXZ01VnqhLTM8=
X-Gm-Gg: AYBFou3yHzAfo6XsV3R5gRe0VtezC+X0m21ieWOngY9rXyi0bgZ5SgHm1UbL3OJvd21
 vjlZ96kX0uWTvDDdOmF5HBsflKfZfda4oBGnVgTW/4LnB+EHj4rU+m44q+o8PvFSRJEH4+og+FT
 2CaXWz8kFTCvU9ss+B+WuUGmMk5q4XCWFt9gkoB6Xr7Nps+dXqH/GFBoK5Dz5lzc8yJY85FIpWZ
 nFws+HyoxVsP0VIRVr9zItfFp7RX/50eX9Ltu42LZdpDN4XeGApDf7RHayHv06Myc4KVEdG36fh
 e5YA7Ysid3Ap636l+PxsbE3EYrCAXbCrv0YN03XDbGCbF31NLLD1itlpaK40feOYAkhP8/LD6w=
 =
X-Received: by 2002:a05:600c:2192:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4a027569390mr123921095e9.16.1791201841009; 
 Mon, 05 Oct 2026 05:04:01 -0700 (PDT)
X-Received: by 2002:a05:600c:2192:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4a027569390mr123920585e9.16.1791201840418; 
 Mon, 05 Oct 2026 05:04:00 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a16bcb9a21sm310240445e9.10.2026.10.05.05.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 05:03:55 -0700 (PDT)
Message-ID: <d6c9d9f1-e693-427f-8151-d7a771c63ab2@redhat.com>
Date: Mon, 5 Oct 2026 14:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when
 ice_vsi_open() fails
To: Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@osuosl.org,
 netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
 <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-4-poros@redhat.com>
 <1465AD22-8132-4286-A2AF-ED94E64E12C8@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <1465AD22-8132-4286-A2AF-ED94E64E12C8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yAv3FPHCcS448fI0IbrsGI8fi8MqbP2rlHZS_As-QYw_1791201841
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 10/3/26 11:54, Ivan Vecera wrote:
> On October 2, 2026 3:07:45 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote:
>> ice_vsi_cfg_lan() adds the LAN (and XDP) Tx queues to the scheduler and
>> enables them in hardware. If anything after it fails in ice_vsi_open(),
>> for example requesting the MSI-X vectors, the error path only frees the
>> ring memory and leaves the queues configured. Every following open then
>> fails to add the same queues again and the netdev can not be brought up
>> until the driver is reloaded:
>>
>>   ice 0000:04:00.2: Failed to set LAN Tx queue context, error: -5
>>   ice 0000:04:00.2 enp4s0f2np2: Failed to open VSI 0x0010 on switch 0x0002
>>
>> Stop the Tx queues on the error paths that run after ice_vsi_cfg_lan().
>> The ice_up_complete() failure path already does it through ice_down(),
>> so let it skip the new step.
>>
>> There is no i40e counterpart of this fix, i40e does not add its Tx
>> queues through the admin queue. It was found while verifying the
>> previous patch. With the IRQ unwind fixed the warnings were gone, but
>> the netdev still could not be opened again after the forced
>> request_irq failure.
>>
>> Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
>> Assisted-by: LLM
> Which one?
It was Claude Code with Claude Fable 5.1

Thanks for the review.

Petr
>
> Otherwise...
>
> Reviewed-by: Ivan Vecera <ivecera@redhat.com>
>
>
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>> drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index d246cde36ae726..e62a8f544345a3 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -7561,13 +7561,13 @@ int ice_vsi_open(struct ice_vsi *vsi)
>>
>> 	err = ice_vsi_cfg_lan(vsi);
>> 	if (err)
>> -		goto err_setup_rx;
>> +		goto err_stop_tx;
>>
>> 	snprintf(int_name, sizeof(int_name) - 1, "%s-%s",
>> 		 dev_driver_string(ice_pf_to_dev(pf)), vsi->netdev->name);
>> 	err = ice_vsi_req_irq_msix(vsi, int_name);
>> 	if (err)
>> -		goto err_setup_rx;
>> +		goto err_stop_tx;
>>
>> 	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
>> 		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
>> @@ -7593,8 +7593,14 @@ int ice_vsi_open(struct ice_vsi *vsi)
>>
>> err_up_complete:
>> 	ice_down(vsi);
>> +	ice_vsi_free_irq(vsi);
>> +	goto err_setup_rx;
>> err_set_qs:
>> 	ice_vsi_free_irq(vsi);
>> +err_stop_tx:
>> +	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
>> +	if (vsi->xdp_rings)
>> +		ice_vsi_stop_xdp_tx_rings(vsi);
>> err_setup_rx:
>> 	ice_vsi_free_rx_rings(vsi);
>> err_setup_tx:

