Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8039C5B567
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 18:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B61BF80C3D;
	Mon, 10 Aug 2026 18:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 00ZWyhJGIFtH; Mon, 10 Aug 2026 18:52:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2612980BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786387929;
	bh=l3aQ3yKkswTs7S/iYzRYJHZ1Z5dQCtJeegu/4/CsFd8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1iBz0AknwyuoL9xfFZfUJNpS2NFmoWKwzj7tto88BHzThVHc6fSeCzW6idmzXUz/S
	 mZNqfutXuhsHlhdFpuS3f22eZBGbTdFkSaTZqXx1zOj/FHUu9Ty5Y9waOCCs0VdJO5
	 BwOgzLgzsL9iri6He30lne6zi8gZBHqLJWteYnGuJ6h+7Ihji15jLHhbcBpPHIGXFk
	 WO1bP9+AOUsGVOtljlMg/H/k/cxnLgZ6/hGdCcoEGZWHJqi8jSXkqsygZVzrBSI5K+
	 irDEUs03O5wMTKzdHpBq0lb1CPN6HUxIsuxupBGkZc4x89KtYEqucgM5Lyz3Ajlv9G
	 iEvWceVZ9prGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2612980BA9;
	Mon, 10 Aug 2026 18:52:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 687F8218
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E8CB60612
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9dpt5zzV4Hny for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 18:52:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::1;
 helo=mail-pz2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 641F560640
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 641F560640
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 641F560640
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:52:06 +0000 (UTC)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-cbb818e57c9so1313280a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 11:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786387926; x=1786992726;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l3aQ3yKkswTs7S/iYzRYJHZ1Z5dQCtJeegu/4/CsFd8=;
 b=FosTsIQWatiF+jfmRriQWJCZ66/WBvPORZGDLMnhuhG7QZqiWCluL6268lKitK8Dle
 Otj3l6YeLkJY/Q5/d4MGd5aMs2J7TO5gSmkZDiF2fklKxbCGqIiFROFcVlkGUHWEBfM/
 PGYOw0vI+AgO4JNsgd330ofPx3+YZIjWIUETc4fsQQl0V+Y7P5QjRrUUl/DAVgO+68BM
 NqAr5l+nDefjTqGj8lY9IXz9hzIqFbmP4Pp+I0E0JjAVl4JEK077yW4HLzjDCCCKSHb1
 Hm+d2iWoivmz8BLRKO7ur3nkcCSEo13j+4YG35YaD3ADIfLYEHwTY6lhcOMerVlmlwpL
 QNkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmPNeNrF/NoUjKsxoWv6HQtoF653M1UsH31uvFlzklPVXzQ50FNbBAQiFBAhZF/9Nl+Mm/buS9u8MwglsBpcs=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzAkLQf9/zXrDrhB0u8nPop/Eb/Q//70bMSZUGU6kzzfomgvo4B
 qV/+v+E1e+dTfEIK18LcGUt+992xxIaPrv+1xG1Jnf3su5TSLKuhB3yH
X-Gm-Gg: AR+sD10Ua3CyQJUCPeiNArjXFW+u5z9sNCJyPvE9h/57zQvyEzMYgkgj1KSo56BVehc
 2LyiSiweAY8g2x9s0L1ZOX9+laauNzeFerGBsQCgyTgkyVu4ncdK9du4dOBlcxid/Nua02hRJXf
 9N6fP3G2qHvu91NTZUGlLexIxb8YLtTzdaZlQaaaXfv7ZXB/aoAc/H64BVGlzy5PhT36BQ65Pz6
 5MNHTIvBmCMbwLlghsEzhnlgY3Ra9lU7b+8WQ1quhB6o3ukEiqscsG56IoVnukHpHTF0AjrPX61
 Jv6DsHncInK+TxLVuLUOCmM2bkvnpI4+/6Sjdl0qJl8PtXo9EB2ehq3WON1W+UwwNoiddnTWXbO
 VEC7SKbhWse3f0nKlQLaDNDOz66HQy0JFIAMhq+f3Z/mmbzmKT+r6busydvkpBXFJbX87Bm8pSP
 p4p1hiqDPzkWbbgH/LTBOsGXm3F3425hyqw9zGQPhnq7Yknb8I5RlJHw==
X-Received: by 2002:a05:6a00:12ca:b0:84e:2722:5d9e with SMTP id
 d2e1a72fcca58-84f9c8da5a1mr3553132b3a.1.1786387925682; 
 Mon, 10 Aug 2026 11:52:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:52::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a58e6c4sm4386298b3a.59.2026.08.10.11.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:52:05 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:52:01 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, 
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, 
 hawk@kernel.org, john.fastabend@gmail.com, alice.kernel@fastmail.im, 
 dtatulea@nvidia.com, witu@nvidia.com, martin.lau@kernel.org, 
 yoong.siang.song@intel.com, rohan.g.thomas@intel.com,
 intel-wired-lan@lists.osuosl.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org, leon@kernel.org
Message-ID: <anodof8GsDZHZb-S@devvm7509.cco0.facebook.com>
References: <20260810184753.135756-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810184753.135756-1-sdf@fomichev.me>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786387926; x=1786992726; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l3aQ3yKkswTs7S/iYzRYJHZ1Z5dQCtJeegu/4/CsFd8=;
 b=rhSKXjHIy2fCfqQgOufYYxX19qYy4UrAo1GGA911E6OX6VNSnDZtdH0zH9qFy7Cz92
 6286cH+YmBWyO93MuYMaFjSUOpcUT0RyzuBAh1UgWa1iQoupvNOBfIzqW27TxJqb2yzF
 iSfqt6nGJ+rMqs+f4DvOxppGZdOaPM9c8HMrJusWLhrWcrKCmxmcboZqxKK1DnB1zJ6I
 meZWb83tbhNPUBQ1+zr6sSsN/eGI2VZNvEw4uncVaNnKRXbO47GS5x90aQn+XSaeSPx2
 GiZMBTA6b7KYrPFoXo+8Dk0/K3cpspBJtsWPhB2GhKzr4F48k4yhVTENbLO1tLA8F4hh
 2YSw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rhSKXjHI
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] xsk: pre-existing AF_XDP
 TX metadata fixes from Sashiko
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

On 08/10, Stanislav Fomichev wrote:
> A few fixes to address pre-existing issues from Sashiko review.
> 
> Stanislav Fomichev (3):
>   xsk: align TX metadata layout across ABIs
>   xsk: honor XDP_TX_METADATA in zero-copy path
>   net: stmmac: skip queueMaxSDU check for AF_XDP

Ooops, this should've been targeted to net tree. Will resend in a few
days in case there is any review feedback.

---
pw-bot: cr
