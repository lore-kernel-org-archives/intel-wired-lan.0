Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028BC606A328
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=whMTA8Bo;
	dkim=pass (2048-bit key, unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=FM+vyVKz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4C7F6067D;
	Thu,  5 Nov 2026 17:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOucdQoYjZ15; Thu,  5 Nov 2026 17:09:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D48560697
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793898548;
	b=HG8H0iESIkvzdTM2VtssLmbKjsZxRtmnFaD4UuFijI6qTWh0pCaWcPKINcreh5bCkhzT
	 2CnNw2s6HDTwnMnEQ3CuWhTkefKmaCP4SkJhMOHtsRiBGQokCiE/pnDMZkd/uLA5aLftq
	 drCxSUoTDuH6SiInNLHFjiexKYks21987vanwU7doQ6oTI7sNmcES54eQSlITpjCnf+Fv
	 V2X3F8sJHkICKnHSdI+udXBh4PDAbweunk4L6Xlu93U+gxUGGfI1BqFGgwkXkecjkqXK8
	 /EezTD+XLyKr+W2z2LuLLDquy3Gt7Wk1IK7iymeuyQF/tGlDf3b/0JXTeYbTwrIA19w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793898548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fV8V1MxjeSoH0zVbQhUORe0/iwvgNHG47iPLCj2trrI=;
	b=lQtfwjlaGXt+hqn959mzghD+AMcirN8RqS4UHbt2x6TcHL/vjivvyPaYDoPGeVJbKWLy
	 0TXEhozWJGSXRVJ9mkbBzlUC9BcD6rxAvkpRswT6n3l8wFNEX4nFjEz0RhCTye25rLUHi
	 F2VhARzTyRf70aitHaaL/7jn0ftU+9b7fDaYzN6MgrRn3aFzOSf9zk2SPS5ZyfP6uqbB2
	 SqVrCcJ9k7VPchp0u5iZSUObCQXwInE0/9Ye/pnUWburzPyr3+vYv0EFjPpxxyjLVAO1J
	 OlTECUIP05cWfNDHCcfCDcWnzQ3+kU8c1nAECCRg1Iod+anIrZuCuAY16zYbWMzTKXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=none header.from=x6u.co;
	dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=FM+vyVKz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793898548;
	bh=fV8V1MxjeSoH0zVbQhUORe0/iwvgNHG47iPLCj2trrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=whMTA8BonT/VV3legi0rBCVnpUsFQCIw5ZgCLgBRBfRWiBzYXUeqUy7Ps1g+gZB+9
	 O48dGNHknNLlZO59G7Aa8F0eKhb+lsdzdDTYC4nhSTZhguytY2XRSjJK7wLO7g2WYI
	 aBiRG5+dQHg8k4JaFgV37C1Ze60vQ81NmAdrmxmHXoK10M76zdWfNHu0XWVcvshiOz
	 X2qPQGdKoMLzY3NP9mLghUheSrp8VA6QWVLgJFKWL7+v3yQcaVbtzdX+K8aUNajFx8
	 wQaLBVqgHtk/4IjtQKTwFRyyrMmai/aO0vj3PYcoI4CNFQcbyhz6KOwZYzoKTcSl9N
	 peVJLa5pG3jTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D48560697;
	Thu,  5 Nov 2026 17:09:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BCE2BA10
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 17:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A199460642
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 17:23:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nefDykcFpr1c for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 17:23:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF1FA605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=dhu@x6u.co; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256
 header.s=google header.b=FM+vyVKz
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF1FA605F7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 17:23:46 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-36a18fc7a38so2095975eec.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 04 Nov 2026 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1793813025; x=1794417825; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fV8V1MxjeSoH0zVbQhUORe0/iwvgNHG47iPLCj2trrI=;
 b=FM+vyVKzilSJweqBsL5fjlJ3cEYDYOWKbEoMimOFZlDfZNuwq/r0o0lFN8Tup3htLL
 YKu2rGYd0R8315IK6df/7AArFI+/05h2E82bycWuiltLrcuElGPOeD9BbrK/KufeCtnY
 c5bUPm3R2gJ5imhrEbadozpHtZ5BZfyxPA7q+K2WITe+93X3Zamw/QVWAW+pTB9gIgQ1
 pvsCd9sbQTLYl+ngNXOaIxHi0kau/pBPxBYtQPWbkQfA1rw0Jfbndkyctxs/2y6d4eoY
 M6b0Akjz88SxwaCeB5YUT4bCxNBAO4xfb5dFqHs/mSbcvjv0JFKkuMGx11exA6Na7w2L
 /5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793813025; x=1794417825;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fV8V1MxjeSoH0zVbQhUORe0/iwvgNHG47iPLCj2trrI=;
 b=F6j+PiFhIFCKDGaS27NNj+fFP5T2Chf/GKOzKTcf9DqUHr9yZ1leSu1P0Xi07T63Vp
 KzjmcyhQu4y+xWQ5UPx5F/QBxodBFVLZ3uDKK6FH9LB7Ztkd9DYVBMUq/b183Q8So6BO
 1W2/lbvql52Zjlwxn/SCQ/Rjy+WLioRFdIGYScCxXeA+JzocuZOPazlDNYTvKZs9il71
 BExqav0f80UBzgEFp7qMwknSm5BLxxGKSr+J0OxKHdyLoL+aFrDaDQvviCs3RjSlysQs
 8TXmwEkLby3K+k25TuPGcuDX1X9NmPxcUy23y//Y18PWKCBveMmKAlmXENBv3ukMrnYV
 zdQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxE7SEx1zQeqyJKeq4ywUU3civQvERvQkD2h2goIr3SsBnXHcSQlIfEjgHMhFFoafLoSSeYWjuzCuPSHKZ4oMA=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+wobZMwpdE8huUvnX6MDA3dVWyr1Lgz1gKCp8BaffkIlggm3sM
 j4/t295wyhJf3oz2PhYK/5hJ35uqsxQ35NriPWDWSIqp/ORgrhk+76PAVrCV7XGLvVP34HBwAab
 jJa3Xoz0EUSTd+fygExUkI9dcVQrU7HFEzPHMq8TLM2g=
X-Gm-Gg: AYBFou2QLvpd9q+2uNG/ntBgFOPXI/VAK5ZBdWyR2ma3XnCYFMfhPVAy7Qq4Q5+ciFM
 6gcdo43iYAeIhiJOANasXa5jYoK2265CNW3CSB4Uv9w9318KeL0Tgv3iwFcgOeuAqARHqyCywp+
 OPugTtLTFfeslyrVqfHuaCKdaQbf8NpLDWjQSUPzSE/5V+SsCaUPBt/0uMQ8DGzZssR7enm4fQW
 uWvwrC4mMnRw8R3vYmL4wXM8lAcpBIygDzzdziafi4yueFXh60K/ih7XafTSZ7aZq4gX9YtZTNg
 9vFOp/MVYTLT5Oczi9881hovBSY7mq4/eVdlC4KGbyrfHjNqC5y6egKkm9PmcW3s81xQtXo4vsV
 If9xTOQiXABfjD631oLsi1Oadpx8Wp37kpbVH1cfvToCwIJ8HTpQB66nDn186RmsZvsV5SU7RrX
 MQjS+n3z71LksuqmAgc4X7bwk=
X-Received: by 2002:a05:693c:409c:b0:36a:30b:5dce with SMTP id
 5a478bee46e88-36a423a3232mr29173437eec.19.1793813025403; Wed, 04 Nov 2026
 09:23:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030181512.2056056-1-dhu@x6u.co>
 <20261104075055.GL264423@unreal>
In-Reply-To: <20261104075055.GL264423@unreal>
From: David Hu <dhu@x6u.co>
Date: Wed, 4 Nov 2026 12:23:33 -0500
X-Gm-Features: AclHuK83olO4raQSHoJpMQkVWHs8sTlJrNh8bRH_U14zxtqke8g6eqmj0i5zA-c
Message-ID: <CABdL-LS6u9im=DsjnEJPGS3-3r1CFnoqL_c1gEM4qhTECWagoA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v4 0/6] RDMA/irdma: Add support for ioctl
To: Leon Romanovsky <leon@kernel.org>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jacob Moroni <jmoroni@google.com>,
 intel-wired-lan@lists.osuosl.org, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hu <xuehaohu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 05 Nov 2026 17:09:07 +0000
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 2:51=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Fri, Oct 30, 2026 at 06:15:06PM +0000, David Hu wrote:
> > From: David Hu <xuehaohu@google.com>
...
>
> I applied the series, but I have a concern: the commit messages are
> not useful.
>

Hi Leon,  Thanks for applying the series and sharing the feedback!

Noted. I'll prioritize clearer context and rationale in future.

Best regards,
David
