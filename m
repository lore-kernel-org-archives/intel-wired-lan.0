Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445DAC88E5C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 08:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E807D607DC;
	Wed, 16 Sep 2026 08:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id heeVMBn14_VH; Wed, 16 Sep 2026 08:28:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 40F3C607C7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789547314;
	b=iXeygug/8+n5Bq9PVcEN0ASYBDcNb+Gv6rasVG1ZAcNcGYY9uBtTdnd9JzgoPARPiir/
	 6b8cb2/KOKJVsFkGVi9Q+YTEFFQmEXeowbAUi4jhsVRpdv9Dl8yfU2Tgprvqmx7ecLlKD
	 uIfisKz+BV6H1LhHUAHhCkkv6vNwtS1tOzy/NxQkBokatEd6gOncMz1XFtf0jg80FFPAv
	 ju6pHZ8DaxE5x5qkQVuMiOUAMAgmrIHHaf1Stitd2J133UJGJcyVdnr2J4ny14tRNbcKa
	 sZ7vz2LrDtLRukQPc2S8PZC3LKIQma92utzuNyLwVXfd26jT/rQUxi77hmLEadFP/lg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789547314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MArIcxEq1DF3tM6gYQ8CgYvDf8FqlVp7SuT0GyZ8Xuo=;
	b=sFyVq5hKYEG73juASoNmwsAxT50O4CRkZhxHzD4c8X6g616+EEB1AiFG7yJhkvM0sg+M
	 Z4DAhkueV7BapOZpUdv9SD4fF0XTPQsE9d+PgyKMYXrmyjYMvvFpOrLf1hpdQSvVH0ls0
	 Xf4qWDA9lQICU6SWl6dBH+5hA0W575OWekXoniWqq0L9EmCPLHY+OqY2nyfj7wVveIanz
	 824fOwq4iS4iUJFrWbDI6ZlqFJ0F+bTuASOL4t6EP4J0GoWVn0NOhH6dG4/Otor0rWD0R
	 bR2nggP8tyuPzUFhalVWlqHP9iRyvB4JSMgTY7RLCGhwO/30EBeiDIpIW+pQ8ZlNyLQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jnsBGtgV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789547314;
	bh=MArIcxEq1DF3tM6gYQ8CgYvDf8FqlVp7SuT0GyZ8Xuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NT82gy18B4bkflTpDzrP7Ct4zX96IylXrOVwKCb1kjhwcpwOcoZUVLbzcDsJpVOQ2
	 NoA2/EklK1MJKuguE/DH/Obb/uLwlrEcHOe5ZXerP+3QtobXriJ3P5gB3W1F9xHc2p
	 W1vCarR3lO9roklkI4DKv9ee6H2ty5WFSAWhWRwli6/5Zqc88pOvLVAXEYNOPoWMYL
	 gLcidaA2QcnO1NI51ufa/RJyfSSoZQl9beeib+NaQCV+HKLbZcNeP34UBS+XD3RPBS
	 jdUQpvt3+djzsF44Qn4T8o+Beop6AY3tlpbvYwRk9tD8Fglb9U6/ls1jvBLrKAl5ax
	 Il9vJmv+MIExw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40F3C607C7;
	Wed, 16 Sep 2026 08:28:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F31629B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 08:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40D48607C7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 08:28:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9JboBNMFuBM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 08:28:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 504F760705
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:39::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789547312;
 b=SIFy/unIB2x1t/Ds6e6HsJsFxTe+VTBMMYiAe2IzVyBuyw1Y0MzNBDMjS9zZAs6//q8J
 B+mW18Zb2uQTsjivVCGsac34toHvCJX9fzn57WOeD85sYg6gUbqcMP6DpKPKkEKyMMkqz
 RWhKXkGQ5L7LKSKC3eJmIWqD0gzAn0H+AbOeZWtmSqUX8cbugm2VxUtjYItf125a2OgQ5
 Dkw8GkJ5mAvQFW67SJmbwcEDpl3oocFa2yOiBvq4lUM2cnBLQW9aw3KbEYTJdocwVB/jl
 iQIpfZ0aNkb9fNnTXmHhEHhyDPlWTXb65kaOZ0woYZSYlgJpd+xqPmL2t0GIIsleGxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789547312;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=MArIcxEq1DF3tM6gYQ8CgYvDf8FqlVp7SuT0GyZ8Xuo=;
 b=ozXgotM0IDyHzqq87JWpLHgG+egZkeQV1HonXO7AktAQVnDy7iApEUniRffhFitTvj0K
 TMm5ow2ZMciFXhqeZ3LaOsuU60rYW9l2vAqXootE63G91zQBlHrLBPwEYRjcSTbOGG8sS
 27JpY9qNs4ocKs8VLUJxiu78+FdsngUxg1WOnxCqdGU3q6ZucqCDXDtE21cJ2rJCYpgoS
 NbEQ/KY5DiEji1vrDwoE3TqhE1hFyuolR+dXcjcrVwf1l4NEV75KxLsNbzqpQCf2PYhuM
 ZQWzuAx9pjZeh1JCqX/ld3IPWdBsZ9/li/NOtLDKsm294Muy8cbwLVcmZSmQz8CK4Vg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=jnsBGtgV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:39::10; helo=mail-ua2-x10.google.com;
 envelope-from=morbo@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=jnsBGtgV
Received: from mail-ua2-x10.google.com (mail-ua2-x10.google.com
 [IPv6:2a00:1450:4864:39::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 504F760705
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 08:28:31 +0000 (UTC)
Received: by mail-ua2-x10.google.com with SMTP id
 a1e0cc1a2514c-982e8fa91d3so124403241.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 01:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789547310; cv=none;
 d=google.com; s=arc-20260327;
 b=jckMbloULZZVSgaSLaSZ5dDmuLZwELSp1MWh5LO66ETZb732NaLiTjorJbXB50WVPa
 qeRMUh8wnaq9hueSQdOapM51hWAYY52rxus+fZcyKHNoCCsqaCV4yHvLKB/8wWcD5PN/
 wWMVYyymiGG6n46BtnOjKhOkYn910MXaBthS15cwO6kWKxYyebyh3Gczk7h+du21v1lR
 28pq/Y6+q5yBOHjWFOnXNuIM9cyDb2FaK8cVFP0dg7Yq+Pn98m6+N4LpHPirBV3egbRa
 hikMbntc2YP2mkO10x7TcCqKBFFrprWAnYn+N7AebtI8QtgP9oyfVzaeuuJRsVU+UrcV
 4BKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MArIcxEq1DF3tM6gYQ8CgYvDf8FqlVp7SuT0GyZ8Xuo=;
 fh=bl6pAW5U+rWwKOhYNEIZqNA+FSMkjfT4w9BTKlAsZds=;
 b=OScU6yGp7nOUdKWjAy5vSpcLPwOjnvFlQRbOtnbHPGllKYzFiZ0AB9zKozsUsCS5hl
 vyAccx5ARLaemGYkfW/hwggFtt/a3izmY7NvgtRN6UuhvnW0mr6LppHHwiiMG7ouzXe7
 tUuHdAAG45W1T4dMUU+m7AxvixWNPs5oMzgzUN33NdytVhfWu/rkaXwb49Abtmgbrqy4
 ixfn0RbIJSz7CWfj/dUfKtSHgekElsjs1nNT3FUbY7mIxfNXyAo/yPGuepYj28gIOq98
 zAisW10fQa6zE5WZk9Z+FIV66XraBYCUzVHIq6X67bp3lzqmbYJ5yC8TLKnXvTP2gUuU
 X6bg==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789547310; x=1790152110; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MArIcxEq1DF3tM6gYQ8CgYvDf8FqlVp7SuT0GyZ8Xuo=;
 b=jnsBGtgVLWlBI8u305IZGiJS/vqwPeQR5qYSnRwOScDnsYvrUAPOaUCD+6uNKOfTrY
 bU07vziLzRtGm7XmqBlG3UMzII5+ikPlSY9CtiQzOCkpbz0+K+Vcd5MNQ4jWEx74eE9t
 n6YzCI1tnstDWeMcIAJuN2BfXCrPNNbR+PKAiA6pWVB7/onRrffEjlR0BjVAoUXffcif
 a7mHm+znBMsBknUA8hKVHYYfyYsM+h1TJaIk3y+pKPsdD6Hg1LUOfDt4Rt29cVqt9fi0
 03rokjuLbneXyySzgkk/ueYMjuDOmsyZ0pyZWOL0gXXvDKWfqUTWWcQolvYy8QsAMXnm
 1VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789547310; x=1790152110;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MArIcxEq1DF3tM6gYQ8CgYvDf8FqlVp7SuT0GyZ8Xuo=;
 b=s3q17xHXSGY+jPpZKV6qVb43Zom3L3joLUuv0CW75/Qsi3KA2PAtmcLKB+7d/v23LH
 w6hXAHFPYFNHd6Ab32uVNtMzQG7hLypmnKGuPSfOaaScEdaKQzLp0xgHVEj/U482ig4Y
 95Ob2KIb4Pe9mtego1P0JLJa+h95xCBniidAnDgT38ZDAmSiWuJa9udSmBhgOiLn3e8B
 QYriES9amgY3NGKnzqK22SQ5cc7Mofylscw7dS+lNHlg5qTPpAjJlMGhZ5ahdSPcIvJ/
 ANhK6q0NM38dzuWO5uLhLhbI3onkeNT9rbtQGlvUHF9eMv1pHAJsxbDhPausc8enwZI8
 qLyw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJhpIb9Jk6mbGiDI0Y2UL5WCwggiB3OB4ecPInAtUI2DOxYaSmYAJiD0ph+U50SZsTn1R2KfF2lExjty8OVkk=@lists.osuosl.org
X-Gm-Message-State: AFuF++n3tQq8TQZlMuRMRUTq7CzJQlJcbM6L8azWWfL9CBOJw6tHLGZb
 DF/Sbos3WKrGfe1K9x9HR2L9VFd3yBXo9aao9NY7QAEb/lOlrIepjaRgGzi9mQyKrga1EaZuQPN
 QyycV69a5r6vlju5SAtEgL6rGK/QjVK/czUsfmis=
X-Gm-Gg: AYBFou2YO3HC7OYSpoqvOH/aSjMTptXV47PFjrDJOcm7+UpD3ILbPNZ65JeCI1Ckv5S
 1tK50B2iyfncabIEhv4y1xNr0eIkq1w3Hb/VrI1uCkYfpq+lkq4m/bk1SgejD02SiFANVVGzsuS
 stoTDDT5eJCGSyDdKFPAVwZl544BgP/wOoBSlhwIh/8O0E9ksj8GGFFGt8+FoUWDCewaMoS+fsQ
 sXUSq1yyDZUJuETOiAJ3Bm95oM7+Q/B4Cw2GVtVWNMQNNNxh8puTKJuL/ukEiKroXK0z0dPtPjq
 lvVGP0+KDHjrOlw1l4v7uOZHpeMVnTe6UBfsa/dQo26/RFgJexTiCclWRHxpN3ze9XpIrRrHKms
 K1awVI6TLaQWHRx8Hllrz
X-Received: by 2002:a05:6102:3712:b0:786:a11e:484d with SMTP id
 ada2fe7eead31-7a0522a8290mr540435137.6.1789547309631; Wed, 16 Sep 2026
 01:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-4-morbo@google.com>
 <202609151155.CC22827@keescook>
In-Reply-To: <202609151155.CC22827@keescook>
From: Bill Wendling <morbo@google.com>
Date: Wed, 16 Sep 2026 01:28:13 -0700
X-Gm-Features: AcwNN1W06HBvxyPAyDNMWJbd-pZRzg8rOuNuZoGljznF0BEtCKl9YZ-3dIsOV-o
Message-ID: <CAGG=3QU2LxKLdqTOHse4U9AZ3sGAUe-C_wbDnBq4W1ncdsPVwg@mail.gmail.com>
Subject: Re: [PATCH 03/28] ARM: atags: Replace strlcat() with snprintf() for
 cmdline extend
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, codemender-patching+linux@google.com, 
 Russell King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Tony Luck <tony.luck@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Matthias Schwarzott <zzam@gentoo.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>, 
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "Martin K. Petersen" <mkp@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Simon Horman <horms@kernel.org>, Chuck Lever <cel@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Kanglong Wang <wangkanglong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Qiang Ma <maqianga@uniontech.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Ard Biesheuvel <ardb@kernel.org>,
 Breno Leitao <leitao@debian.org>, Thorsten Blum <blum@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lyude Paul <lyude@redhat.com>,
 Ashutosh Desai <ashutoshdesai993@gmail.com>, Imre Deak <imre.deak@intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Johan Hovold <johan@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>,
 Jiaming Zhang <r772577952@gmail.com>, 
 Will Porter <mrwillporter@gmail.com>, Cen Zhang <zzzccc427@gmail.com>, 
 =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 Rong Zhang <i@rong.moe>, Arun Raghavan <arunr@valvesoftware.com>, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-edac@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-input@vger.kernel.org, 
 linux-media@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
 linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 15, 2026 at 12:00=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Tue, Sep 15, 2026 at 08:18:20AM +0000, Bill Wendling wrote:
> > --- a/arch/arm/kernel/atags_parse.c
> > +++ b/arch/arm/kernel/atags_parse.c
> > @@ -121,9 +121,10 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
> >  static int __init parse_tag_cmdline(const struct tag *tag)
> >  {
> >  #if defined(CONFIG_CMDLINE_EXTEND)
> > -     strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
> > -     strlcat(default_command_line, tag->u.cmdline.cmdline,
> > -             COMMAND_LINE_SIZE);
> > +     size_t len =3D strlen(default_command_line);
> > +
> > +     snprintf(default_command_line + len, COMMAND_LINE_SIZE - len,
> > +              " %s", tag->u.cmdline.cmdline);
> >  #elif defined(CONFIG_CMDLINE_FORCE)
> >       pr_warn("Ignoring tag cmdline (using the default kernel command l=
ine)\n");
> >  #else
>
> It's pretty clear we have a pattern of "simple append" that is needed,
> and while strlcat() does that, it's horrible. I feel like we need an
> appending scnprintf(), and it needs to return like strscpy() does (i.e.
> -E2BIG on truncation).
>
> My goal would be:
>
> - don't open-code string length math
> - never leave the destination unterminated
> - allow for format strings
> - yes/no return indication for "did this truncate?"
>
> Initializing a whole seq_buf struct for these small cases is too much
> overhead...
>
> For both cases (small without seq_buf, large with seq_buf), it is also
> frequently needed to know the resulting strlen. seq_buf doesn't do this
> right today, and a strscpy-style return value also doesn't tell us. :(
>
Something like "llvm::Twine" would work well for this.

-bw
