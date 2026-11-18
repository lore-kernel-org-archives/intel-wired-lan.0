Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DC60A2608
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wbFXcjQ6;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L/Grl6NZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0B8D4099E;
	Wed, 18 Nov 2026 16:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omWsSBNdZ5Dl; Wed, 18 Nov 2026 16:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1D7AF40807
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795018990;
	b=Fh8k3OPEo+AzPMUsnC0jwOXmvJ0Um4uttu7u2t09SiE65qKKsUdDUsutjmoFqN46vGlR
	 QtWO9MGJKZBX/l1siuQkeP5sk2zaeRuHaZbZw/jtAVjx7G8dbEZ6pWln5e5Ml99/4zo+j
	 4Ll7AtAgVbNjCCQaCDuZCeEtoDKiKD1fV7cYCJFoaxcJBC6oJPeR0grxuyqf5z3yFpP3p
	 H52fGjKI4/QXX3LJksRCKq3On06OW7R0KWM4aVFD9246DAVbjTRnnDdwF6iEdZrwOQKEe
	 dOENaGrStH34tTaQ+pcieoJcMVWRlzJcpIqIt/dwfYpaKrtj+k8rk4xTHQazP+tZUBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795018990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p7Dcs8rqFWgV7vy5jckJd9/OMxXaRSwC9PD3XcVQ8ik=;
	b=C2t5X928+mEHjDLGBw+hpHg1oAkjRo7PEbDeKX5Ys8jkJGkFCtWCRwpVc6D3ABbBYgGI
	 wpl/qMVZ4vboGTVZ/Rnt5taDCsfV+QJ/ZAOQD8HK6uTkrnqAlGEmEzc9WDHqalp6Sf/f6
	 nQr5v7aNhKN0He3WArWwSjo+QZPoTBVos4uPmTW0t+V2Cgq6DLEt7BSKXab7afdnQv2mD
	 gQ8mzvgo+NUwkpcbqI7dV1tIslYRdRvn8k7GZiCfCHkDM0oP4S1Z+IeoX2dvTfcKjpdi/
	 Ni63pSwCk0611nJVVUqttvNVKBewJ9GlfdA6dOaaoVc8tGHFgcWlas3jUXri0Y8tyjg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795018990;
	bh=p7Dcs8rqFWgV7vy5jckJd9/OMxXaRSwC9PD3XcVQ8ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wbFXcjQ6QfH+CYrBGkQ9tiXoTnRBKsSaeyGi4UpsNt3zhTWuD/TZh7LukJ+dP2v2v
	 LMdmndNrZkpxLsOZMND+MTuBHmtixVg9fu1d9lLcbkelIwWzVw/9Bk54IysDj4h2ma
	 DtQEqcCbYUdCIE4V7psHV9TdQipYj5swz2QxObdQHL5pLIpv+2kB5VEzvKz+/NVwDv
	 WBl9L1wWf5U8jpDbPyJ7T0Y3oE6U0MuLLDtzl5JNclW3WdbW7XWl79//vadFbJgFqc
	 Br5jpk2s+1b6ruwd+5XlDOIEgyzwL5960bxniXrDicB5XuKdGSs0Js2abhbkBFHlqj
	 4qlmaA9Vhb+Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D7AF40807;
	Wed, 18 Nov 2026 16:23:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52C1BA0E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38BFC811D7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r7x0jG7kd23a for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 13:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4F759811BC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=janislacis06@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=L/Grl6NZ
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F759811BC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:21:54 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so6898885e9.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 05:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795008113; x=1795612913; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p7Dcs8rqFWgV7vy5jckJd9/OMxXaRSwC9PD3XcVQ8ik=;
 b=L/Grl6NZp/6uRSzyQRqPbZSb4YI+iLrgM2NzwBsL56t/3u6APAKBLdX+I9dHcdhcHh
 ROY79NbmFcTmihce2Uq1ebhou08pQWmsBzRB0XiiteqFsdntyfSuvR+2DzRndaN6JmsU
 BR/PfWuSayeMQN3jbcV98ihXDBLGvdpcU25SdaYuwAuozutGLceSgjkZ+lZV2kkQVpnw
 wTeojvtU3EGJeHBTlNl0bpU90Rx+rW545H6FBj00nITmjCjaoH0uB6TfF9avWqx71BNJ
 +8Mpw5/LV8Jkp/8qF1ZrYfxOqVr1K/YuUGUU5TENVwANxuQsyIxoCMBdV6cdgYJEXnhP
 dDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795008113; x=1795612913;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p7Dcs8rqFWgV7vy5jckJd9/OMxXaRSwC9PD3XcVQ8ik=;
 b=qKE5j6aBJzCv1ygl9KOepjr8MX2I/J/EwwYx7xf/lrcvQD4SKlH4/NVoW/zRpjnsLR
 xUMAtF+fKWnTM12RZiT43Yulm8RyZnIIcb3QAQ3v/ToPERGYURv5bZdIERhyP5S9TB39
 AN79E8pUnQUtG2hX7zKe2C8/sf6Ypz6O5JCR8WspUyF0Sp1mGEdU91TIgMiIHXNtLbTm
 RM6b4oWR74zsKnj2XlvLF5OPvA7y1l9T8ZiAWbl0/gQo2BOJcZkZwxAhARIK9KGDcadi
 2SjAoO+rOCsxMbswOgcz4CczQkzRuHcDXXWEWY25yfhJQpo3z/n05XTPAnKOfCneDWYi
 cFxw==
X-Gm-Message-State: APuU4Z9P/fXfC5jtJ7MzJd4UVQ4h8yffzfEId/z1XorR97hnq8wWv9mK
 tDKAEacM1HpHby71euHDH5Gu3qcSAm6YZJ1pguNB0a1aSD4sKUtNtlJ7
X-Gm-Gg: AYBFou3iqooIMi+98HJxeTi0Edo2uVuog6TQoCRPYcm+df4ErKTN9d1cFIF+mxGKaBZ
 /CC7+DBW4jmmuJTwlJ6HPOKxenM1Su+8bu2Dz/pS4jfAqyNI+7Cq9PbzdFW9uA4QPpRhqMFTNYW
 Da0ErlZsqrHY8Dl70li7zEm6fb7pFKr98LOlqhpRIKaaHpN27gGt76+zbUT4omcW71keaSaih+w
 yzpH19mqfcIvHUCGG9hwLKtYB3VueWqoct12A+S9QVpqCScimC0oxjfWosbEBjIezKpy45Izu4e
 J8RSZdvaa+LLFiAlQypboENY5k7vJOXJuYN7GaAx8UtQ54bH6YWPXQeidp1xV+drUq8zYrHZINX
 3amB1okje2Sn2RaxZYmX8RbxlFfsJ3DZBfxFvHnYNreDv3fPDpd4taaWu6pzuuh24rt1toFJSEg
 TgiSLaX0EAiCBgyKlmgdNTISD3rFS4mJVoU7FvaBekUiSsZVdK5iaqgUp/3qj+iWxy3RA/BxHHQ
 OXnhefhxS2k+JLlY6qP+SqsjJN6SN0Rn8uU3xpNLP/XrzW6v4LAmFh+zO8hpOMJJLLKKFYPnt1q
 /D/ovjhA0KIg4B+2jUWgTPl6C+PqhaEBP97yAMfwJNdFowxec93V4fB2XPRkhmy3GFY7LzqkUiK
 WoWUjvp1W5cy+DNTjH0cOsE6s9FnK0wungtA=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:7033:c92f with SMTP id
 5b1f17b1804b1-4bb7da0f671mr58393325e9.11.1795008112703; 
 Wed, 18 Nov 2026 05:21:52 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65541f3b3sm4899303f8f.23.2026.11.18.05.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:21:52 -0800 (PST)
Date: Wed, 18 Nov 2026 15:21:49 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
Message-ID: <rab7ustlezklu43vnjkby5mqh33bgqoztlz6bv5wxkjqfvbtfd@imjngi6j72nz>
References: <20261116153041.3002666-1-antonio@mandelbit.com>
 <20261116153041.3002666-2-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261116153041.3002666-2-antonio@mandelbit.com>
X-Mailman-Approved-At: Wed, 18 Nov 2026 16:23:08 +0000
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16 Nov 16:30, Antonio Quartulli wrote:
>Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
>RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
>but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
>require it. An asynchronous runtime resume (e.g. after the link comes
>back) then triggers "RTNL: assertion failed".
>
>Skip them when resuming. The counts are set again on every regular open,
>which happens under RTNL; the only case left out is a fallback from
>MSI-X to MSI during a resume, which leaves the stack with more queues
>than the device uses until the next open.

RTNL is not held only on runtime resume, it is held on a normal resume.
__igb_open() skips netif_set_real_num_{tx,rx}_queues() for both resume
types. Maybe it makes sense to skip them only on runtime resume when the
RTNL is not held?

May I ask why is it okay to leave out the fallback case, can't it lead
to trouble if the counts are not updated but a fallback happens?

Best regards,
Janis
