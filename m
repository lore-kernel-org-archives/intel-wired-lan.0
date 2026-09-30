Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3623CA5FC7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 16:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4567881101;
	Wed, 30 Sep 2026 16:07:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NkwbiVdV8lMI; Wed, 30 Sep 2026 16:07:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A127C810C3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790784424;
	b=hGv745cWwv0En08FkZ6PNZJQrYr1DoC9wxLIfixVGRjvMB/GT4EC9inRhcLPQ3xTdtie
	 Jxzu1XmGqficGizipM3enUCQ7FbYfM9XaHqpgfY1W4IgKwKKwvc41t/TjEi3TXL2OoG50
	 L1ryFlHXO8IDZ0tBs4+AdPbovay8wgPPzfpsd7ktATd7olRYkPrOIDitvH4xvq0Y0Cwrn
	 M3OvpkcehGQVjXcNxQwvkF0/dLP+RtLVIb0BdU2+99Fy7fVUd7LDB+W/k+N2OlwkV3uC0
	 QrMBmC0SfPWsqHzEpUjJDjyttP2MZtTftP3pRDN28NlrxjHDWNLR6GR6pkscKMSS32g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790784424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
	b=LnpCFz+YDvJ8Vl7BopSfXiX2Ra8PZc6HUNl5V552jv1hBXCxXqv2LranUFOvZCCYZgVF
	 lDM6v9lO8TcRvhCHfT9Vd4OQqfTULiN26ORLaM1HFgi2/C6snY1AVdk9e54RCGifAScIz
	 kdKlxGYIEHNFtgqYkKxzOb/YTndWrL5SBYrLdmHXCYSnKkf0m7ijPNNnjVyD5XUpczKvk
	 5Z2hHdYXJSba0RBK6aX9a2dpoLZSpfO3L4aFK2ZpOOI3YvsL5KQSktGqCKY6C7ilGwqPO
	 XGzqcraaZGpsEZBrzxW837ucZ0yF9hGbP8ZAF+xCxfBbA5hs1pxTYwEbJoW0C7bI2vw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790784424;
	bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wo2l/2bFZ9phrCHFSYC2HfLW+dlN/TYbwt0eQIu3zjmcofkeWrRMCXL0mzN03UN+9
	 8hn8G4xS16sSWgI3BuIhqkrV2S5ji5fBTuqig2cuOSBHuW9gNl4qyqm/JhNpe+akrH
	 ipVf4Mfe0lJCByQhbo3epyQxkZKYYz22JMFcjESEopG7lSqFCZhKdnVoMjhyc3SQLP
	 O8Y5ybexdbZte62IIo3m//lWn93WmJ/2OdTNC8V1C+wO7EEhxrHjNQDLac71StXNI1
	 GbL4KiVkWGp7gYiZ4szUYcJ9tBfMf6jXKdoZe+CKTKaZF1xbQbxfSykZWyTO6Pu8LO
	 uNKrC6imu0jWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A127C810C3;
	Wed, 30 Sep 2026 16:07:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A3CC3380
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 16:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 954DB608E7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 16:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ymhEVFs0jxp for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 16:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8E8F0607D4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:38::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790784423;
 b=JYHRGLz7PtRVVFrNhRpRIRq4U1koJXuNg6+wjwXkI6YdNhyN95HlJX6YabqrfxogaIKL
 2Xd9gOGYFeBIoOms+ddA/2gBU4QmjePCiJ0DZlgnCfrlsWl36jg77PoLqiG3xV0eYESd6
 /y9mZjaG55IOOajB1q32UPo8x/HuU09MpeFNM59zLYM6jyWsXqHwtVnCwFDKIRC8PqW+w
 4A8WMa/p4W5vIejg0CSiOmXUSGTCRcIgxcrwKBlCyKjU6LZ/SE0YBQ7SoM3NvtKzJ+MCS
 h+tIO9BeES2AagZjQgOuykRmMwxgq6cwkT5mP1+k//nsqCG7oGMpzgrPwYfpc6HcMbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790784423;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
 b=dxQi3+0zWM/BDG7/ByqT9igDkvEwOtKotLC+y345B/6zLQgd0B80A9P1t4f491GKhN0o
 nHgY/89YjLE10fsIc38K+Hm4s1cGn8QMnCrHarbctNSQvSOhpcPc5/aeXmaOQo2GUazJ4
 gciHjjq07y1uErU1kFlZtEBUkcyYuSX0Bj7xT9GetxulylOyX++WRvOF+XlOFgk/Qxl8F
 G0gJa7/bstvQ+DXc5zaEf1acbaefpN6SDUp25pzDJth+nDH+Ej4QMsLoVoHrIvkW+foSh
 fIz5T0juOTNnMO0ocEKzXODbSpBr4cj/qW1Nn408FTktdV4H7KeSsQ3y3peWwKWFeCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WNkDyRoj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:38::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:38::e;
 helo=mail-lr2-x0e.google.com; envelope-from=oss.patchbox@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WNkDyRoj
Received: from mail-lr2-x0e.google.com (mail-lr2-x0e.google.com
 [IPv6:2a00:1450:4864:38::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E8F0607D4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 16:07:02 +0000 (UTC)
Received: by mail-lr2-x0e.google.com with SMTP id
 38308e7fff4ca-3a652b710a5so53856201fa.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 09:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790784420; cv=none;
 d=google.com; s=arc-20260327;
 b=NEIQWmNV/T/ehw7SFHWPB/3yDanUG90OW6j5IR8hpwaK8qZhijnv+KtBUl9NCrEZ/b
 mkxQsXTgK2ZYKlVn3HIeE8MLm5m85SG1ltPt1dmCPXIfRIL5nk/PRx/SZA2pIuJK8hMh
 d7rHdf3ciFcdjcVEyFsyJ6rLdzY4zMuvvZy/CWw5eAE4s4NSPuamsaTHD/ty4zUeXwGD
 WIR4USxFbok5Mok4bOgmx3P04KBQCMpvRKdIskLSixT7WIsLYZqHTxQ9uTwqUNeO2Thm
 jiHjnZRLZUmPwwo3EAZJclsfIjdnsFPqi0Oh9Xx3V4EEWBXckpoBKaPTg7zE38ntMP30
 642Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
 fh=qgqIbn+M3bZop5DdoZLBf+xLxWqqLpXdW5qJOwKSLCo=;
 b=bnWbzGPXuIXqqxXy6ZmEg9OIw66pzJD8bjenqPjLnKDjCNGPJ4oRmYtIvqaxCoq99R
 B7Q8f43ovFYWFd6Tu6OVB4T/bL3jotCYwf/EWMKvCJW6HJmvnHmWMOuElM20dDWAumKU
 BiOa32MJ6Lyj1Qqz8jkkcVqkmk7wsM3DpUyrOdcUY0e4DAG4TgzBuyfxXUYVq6BtVRA4
 mT3BG1Cb5ANiNlp+85/YJhFSjoYn/llbwP1XzLh/5gZE8AFYuLyAF42XDglETggV+Kno
 3xZrlwUGqnM/tJHTNgusSJu/lKrvDR7dliDWkeXrxEHwT0C1FqGY2m8vnBDntWBtXnHq
 tUJw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790784420; x=1791389220; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
 b=WNkDyRojtsz1IJth0Lq1ZZpBo45twYVpei3tgtT6wOglvbpD3zO4yNVSylmN0sXwKg
 IiGu5RXykjvYFuGynb9OLM/G0CXQReJTcfYsm4YjKblRnPhvhpdLI9P0MsU8i/F/WV1U
 ngUJCadnJmuZbbuTTf0pQKcMsEXmTPbbk8SiAYDUGGNHFvz/6O1QqdtRiRdHgZtGcuN3
 WmyQCrkgis2i97rpepU8Y7lgxyeM0FlRZTXZb6QQHod7N7LZmaPE+XjkQt9cvHiqV3ny
 4AQTmGqFe2cqgq69m/FWeXG0PXycMiMbqgMQOu0/25PR9NvsdWacW3Ym1JE6BibZnSsu
 Z4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784420; x=1791389220;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
 b=rPtOPscRAPPbIziw6NR/0ikWtDY9LU5IjmdK7XUo1+jDVUObFZtFTwmGY6nLlmbKQ4
 yYpT8T0mobuvC8BCUIX1URXI9Z3XknQvh4UKqaQV2bH82Ktg3TU9a7sdzPPItdePCB/J
 z1zcKZcBA2upZBK5FIfbcuO8dSkeKkYdj3CeHcKCtnUj6gmFHWsWnfCYSh7W7NCzkCmJ
 pcukIcOaiKbI6vuB+YJ2vhyprXXRgdcX7lUi2AOKtQRmsrHmyREP4uoO0QJMCuvwFTuX
 WxRBlrhEvX7WeABk9VjSXjDTuEP1g9IzXuGquSIZzHFdPkIrewU2sgF9rr8Q3tlgQctS
 klPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLiSFC0ReRcU+qhn0pvlBS31coflR+i+4lznHyB3wRO8UZNv5C/G2h5kS2hhRIhPJ0JO6iN52EAuT+dejF+cw=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJw0qj/9bXg5UyodfONRAeh+uVroj9ddFP9mo81JCYXuSXf/tLL
 qwSGG6T32wtZQDRAAxkEiaIueZXZr25oi+xZBxrCz+TPRfqg5pbDKueG1hoQbl/aZ/AXIbzdi7K
 kG3fujd3ju+frzB2v4je/4c56t8X3Dl4=
X-Gm-Gg: AYBFou20icLI9kNW+q+i2UbcUUdJJ01cOCa9VMODlNtX7A/+3w6L0oztpKghRoSOWFx
 5DyWzAAgYRofy7YFB0sn3hgcYDK5Ut61JYwikQIaBcE+57MhKn5oio5L2eR2HOSi2SAWK+drMqO
 z/aDfGiRZ+I/unCRRUxwtZSyHRTzpfyB/M93AQ0OTMASEE8Uv5i28eGv+oGhJcWuzyME5vZ0Qjb
 dDwzuWPLXJehEoFGRiy+eQqfeBV1C2Ts7tqaoYO/EnL9w00IwD8z6sK+xgj/yIkMB5JxUZErJdH
 bX+Lk3f4Hq/OGnplkutWZylsfreBAvUcS0OZixsE5a6vcnFr1YPl5CxQOw==
X-Received: by 2002:a2e:ae07:0:b0:3a7:6d4a:1c9e with SMTP id
 38308e7fff4ca-3a77920702bmr5335761fa.11.1790784419801; Wed, 30 Sep 2026
 09:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260923234819.702327-1-oss.patchbox@gmail.com>
 <20260928091551.GK13925@horms.kernel.org>
In-Reply-To: <20260928091551.GK13925@horms.kernel.org>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Wed, 30 Sep 2026 12:06:48 -0400
X-Gm-Features: AclHuK_HJEwr8rDcX7-6pNmp93VhndPAHBA6EzKYzl5-IOAv0A5_y9agapxl7BU
Message-ID: <CAGG=RgBNpQLy3s7Zqf1=TpN_grUOha8Cu_UVmjou=qPe0RBqiw@mail.gmail.com>
Subject: Re: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

I appreciate your time to review this.

On Mon, 28 Sept 2026 at 05:15, Simon Horman <horms@kernel.org> wrote:
>
> > Fixes: bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big %NR_CPUS")
>
> I don't believe that commit introduced this problem.

Thanks for catching this. I'll fix this tag.

> name is allocated by kasprintf() which is a wrapper around kvasprintf_const().
> And kvasprintf_const() documents that it's return value should be freed
> using kfree_const(). I don't think it will make any run-time difference
> here, but perhaps it would be best to follow that convention.

kasprintf() uses kvasprintf(), not kvasprintf_const(), so the name is
always kmalloc'ed and kfree() matches the kfree(free_irq()) used on the
normal path. Please correct me if I'm wrong.

> Also, for completeness, shouldn't there be error handling for the case
> where the allocation of name fails?
>

Agreed, I'll add it in v2
