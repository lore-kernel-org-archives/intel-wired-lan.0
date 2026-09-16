Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4C8C982C1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 21:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 619258097B;
	Wed, 16 Sep 2026 21:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SMcRHZlY86Xf; Wed, 16 Sep 2026 21:57:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DC0D080806
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789595834;
	b=ID3xRNytipAfYRa0b4oSnhJ+bJpOvm9nHqlbVFi8aQH9h/Vnfd+U2nDZWbA2kmixMgm9
	 FG3pYL9/cUqHKBu9heE7oseqPjPaGyZWTsc+k449AF5SUMFEfb1G8egqsBfiIpgfiUm5H
	 3UvwvR313gi6mHNMHf7chiwdu821cOfb0biNl37PWpuznV/jJI/W012+GPGFjX9A9/qi5
	 YWI2tEyoh7xrJ+6QZjCEGha15jXOU/KYjXA+VaaufEjgUQ3x46qFNGaqsOqKoWJ7aLfSz
	 FAnpVF2eVAagR2dgCaNIzpctpNDeVP3ERy04dDD6SM/Qtc0kBplSzd04jotAZJUSdfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789595834;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Mpm+rXQ1nRbGhGlarYrHhDYEJtHCvYuH4SNSCHxwBYg=;
	b=fnPTLEvGnJHJs/AZKiXuBDQxUtybwjCUHw6SQ7b5OUGWZnYtm/+i6dlPdmHpt35ogUQN
	 2ku9tFVrYMS2rbZQEysSF0s6vAzHIPWtqCMTjygzhvjQkgbjxldY7ikOuZW9YH8IJbUv6
	 T1OtMCC16E8T5INP/5V+nPyCEPM9mBmN0kj16/6tcMsOY0mXMtIrfgaN95mN2hm9tvwTx
	 4EERfaUH4qc4DzTSD5am/IKU0bVJyphq+LA240lnSsKsxdTmR9GxMINP6aDPn9rLv8URs
	 HCvGG7w0LYa1LU6gIrqtIvZ0UAAU+HdAYZ8LDxOiDfX5XnNKZM3MsvU6JH/d2Badejg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kguY5wMd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789595833;
	bh=Mpm+rXQ1nRbGhGlarYrHhDYEJtHCvYuH4SNSCHxwBYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oBHA4FoOtkJxa/N9PBFM36KcyOszwqsYK3W++SVJfQE1SAnXxT5bcocQV4nY5Dv4M
	 0ZJu3LES++PnyCS3lYi9gSKCuRaENUclh+YZc96ymM3G1KGouzbVG7i4v6nlkYbZUi
	 53Xuqu02GvTueV/NgenRxYlIAwn3m76Wsaqw2c71dRKbkMThF1laIjQpDGXT0uUaxa
	 wClvwq7bimIlMJkBIskzNgbB2fX/5uKrq5nD6vlCYLVXtRidYlPAkTt1Lfg4oNME15
	 bZDLD6v1BnLVC21hu7lPURjQszf8RFBw1qtpwX/W75xR2HSRA0dTD1jgK0FQEPtd40
	 bXXJ8zjJs3tFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC0D080806;
	Wed, 16 Sep 2026 21:57:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 239F02EB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 095D9806FA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UT7h_zTJYuH5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 21:57:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3C79680E57
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789595831;
 b=EwtL5gdTOoVQUbn0YXe0eb+fvarz/9NOWz0ruJ3SUOkgT7sD7lolKoOybPWq8DxX1rXj
 jb2NmOzeIysJ2iL17AEY4RxP0IjHL6+dNX8fCAe3yRvlq6aCJ7PPBVQMwE5Of8D70yu/v
 hDneMAULrcg096kkkzOV5lWw/kXAfUqW+Dk0qpd44zTFYXh2a0xnMrRwFu8/OkosmOlmg
 44RKZjU67H1A8C7b1V11WJZ8CDev/7fIEKgu1j55ns4+3w1/QsM7WOhdvHT617AhEtU/5
 /nEHQlFRLRkpSkmBD2UeRgbb5jMcR3Lr1ZKGMjB0lsopqZjAyl/bJiUw0t9KPtsG1Jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789595831;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Mpm+rXQ1nRbGhGlarYrHhDYEJtHCvYuH4SNSCHxwBYg=;
 b=UL3StH47lyMGzZhJ6I3f7o4Q5uCZ1iBVSafJLQWw1zK16uLZoY4o5NPkjMzcbv7i7r9W
 FaeumD6oXO/uXivWhk3lkcj0LDy6Jj9oKiP1W3OCMw2b+fiqIJ6oKLBQxP+jlt4EaRkIn
 2zwJE5+GUn8ih4U7/6xkxYUiylVBKC/kdO6hEu62TAqbyrVbXcJR19WwZv7lXIZaR2gOr
 nCMWI7FwDzA8J4BZ4X4kcEf5JgWvn51upzXuw0qG/abmRaewuYbPGjpV+xJDnbzUF8VrC
 lquYiT7zg+CvSgMfbFsOL7phJNWLbK1yFtXqB8VpalFToa+pkGSDxAFn8b6DDDRDzXg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kguY5wMd; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=emmaonana18@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kguY5wMd
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C79680E57
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:57:10 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49fbca514f8so451505e9.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789595829; x=1790200629; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mpm+rXQ1nRbGhGlarYrHhDYEJtHCvYuH4SNSCHxwBYg=;
 b=kguY5wMdamuEghGClLcFg5SZl69/HqXTSjHGxvMYBrPIb4xf3edUiNj/SRFfXp90ZC
 YuOOAtVtWZV5XU25ICZIvK+uk9ts2DTosXMKAnVw9PNo92cmc330ykM+f1/8VzrUBgS3
 oG9h09L35aHi3g/D+HotH6KAfu3SrlbE6/tooZn4f/TPnlKPE++89JOG2pg3x5dm00fU
 j5nbI1K3zmzPqOBwNZmmwYqab0P8WZEnSPsOJ9GNn5IVsVpL5Hy5JWPMc7suULA0+3RJ
 zYRGVvG1gKSsSOWJFWpBQb8IBlBzXZ0DHULUYVnGPKxbfY8+jcbDJlesCKjhDMYruFAc
 uBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789595829; x=1790200629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mpm+rXQ1nRbGhGlarYrHhDYEJtHCvYuH4SNSCHxwBYg=;
 b=K8r8duo+eJhOUhzkg2pA1y4wKbT1wqNyuZehAbTa6CyvhE54cYKwtVoUSPzUPxFDT0
 atbvYGpVKcomtnVtQRsCFKrA2mL2eZMwPk22EJJCECrQ28uGJygud4Uw3OBTqi6IRKsL
 cmu1hyOB5Fj1gLh7YfWERjYBWElEHkTChVxcGv2USZYboZQZVyKitlrc/2z0GqZPOj3h
 o/9ixNspJsPcqsCEF5fsNcyPlu+r7ZteNJXmObn+arFLvxkV5TXsZlDsyqazU1Xyea1l
 SwxAJl3RFNRQYBqbuqlkkdnyZLgCdiPl2vfipCwwM08zX/hFF7o2dPmpsagwl2zKSg+S
 RtpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByzHkoXuEwZirPCegijhdszd43Q5HTNclQHBHkBZcwMQkH4zk6Io+nK+5Xh7pfAdWWsb4qjz57Hq9//m+egkQs=@lists.osuosl.org
X-Gm-Message-State: AFuF++k2R9Cr4iit2TEP0pjxuviQvuv782jEb/iothg/diQDssvHVuRY
 +MR40rpMrf4u0L1dvOPztCO5ms0Yi3Z32L9tvxZl1sKXqdPm1UlfFnN7
X-Gm-Gg: AYBFou3PmBw7CpuDjSE3dH96FYNOsv0dQIsk+v8LYivFUPQHl7FAPD1DvuvIPlmb6Po
 pfKi4gNOHrl8EGUYVX8X4z4sjToobtUPCLtaud4Z/eXjX9qrh+djnbdlqEFWkYLnQn820shRh60
 QmFAiNTfqhO8zcGYnm2TNlnt3mqzVllyz1qziurzYlbWiBI8w0dbbn74ZGpLmNVuLbITBWgta5D
 tNsBJu4FYeFsoZKnjMC5ZGw/ayxB+TRZPfyOpV3FZ3DvUo6DAWhTBbRkezHs+Id8w3Sr799IHr8
 UjMghaqc04wASVmezcpOD+wAzRi61ysXChBpgCcwxQm3BqSNornSsV4k6Miwe+Ums3L6BsY/Krx
 wGY7SXOifOsgY8KCJtNiyWxNJgVaNpd+QYsLTNDq7IdofRGTdSJxPYyKWYegFBgaxWqVyVwhbx9
 oIfqVevS4Lhdhv6KuE1z9t/yeaMhbZqjRAuw0YkuXdDwbgyXISSu7IP9ozfCT1FMSXFCYJqsgy6
 ablbLXbXsxNvlBOJkU=
X-Received: by 2002:a05:600c:3492:b0:49e:7c8b:fdef with SMTP id
 5b1f17b1804b1-49eb7329b2emr42924465e9.2.1789595828416; 
 Wed, 16 Sep 2026 14:57:08 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.73.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd247809sm35546005e9.11.2026.09.16.14.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:57:07 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: rdunlap@infradead.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, corbet@lwn.net,
 skhan@linuxfoundation.org, mchehab@kernel.org,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 tudor.ambarus@linaro.org, bvanassche@acm.org, emmaonana18@gmail.com
Subject: Re: [PATCH v2] docs: kdoc: fix struct_group_tagged() parsing
 regression
Date: Wed, 16 Sep 2026 22:56:46 +0100
Message-ID: <20260916215646.23185-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f0591ce9-2e8f-4777-90ab-b9159b7d8f20@infradead.org>
References: <f0591ce9-2e8f-4777-90ab-b9159b7d8f20@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Randy,

Yes, that was a mistake. 

I have now sent a corrected v2.

Thanks,
Onana
