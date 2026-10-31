Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E902606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=w74Y3sex;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iEJN3S+k
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0041180CED;
	Mon,  2 Nov 2026 22:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPWYSosibeRl; Mon,  2 Nov 2026 22:32:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 26A3380D0B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658774;
	b=mtoEPN03NcgLDDoJlWQJBP4l5/kCGPNI0iRkW+gqQ3jzSGNne6NJ6bdxvf8/wIxfCXyU
	 V2TlfX13/RymmZhrhw0bMoLHTvRlhi1Ap6N1qAF/N2oXKB9xoAAC4vTsylfUxLC1Q/eCM
	 pf6PvGhVKKNoryv6x6SU9Rk8GxFPt+7jZf0cGcvTuaLRK2Vr/8j4zhGJd/oDaw+czKBuW
	 uQVMcKP41F2UfQbHfo8tOUowjeeAw5qIlJ5U9xK20q3oD41LBklsOGON9QysON+O+eQUa
	 Fu17j/ZCp2hTfirAB48ZMdkV+OzN0mZFwE6Ifc2S+FfAwMO4WiD/eayDqaQZVRE+nXQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658774;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
	b=NwaxVdGg3eELx6lLQfS72v1eGwH+Kxw7oxLhfBMJDLIn5rACULDHqhYYrlLu5AR+gwao
	 UXl3BoYuZ7TPkCxOOXAppdcp0aspKMtDc7fYG2vz3kgLrjf04aRPfvfZU2Fnls+3GFtKF
	 AqTNeEoTaOW4fj7x4UEQirvI/y/sQ4KnHU/Y3nKG9s+r6T131Eq8lw/EJIKKKII8R4R0q
	 E5RQarFSxZq7ie1vWZUG6nqzRJSCU3mDkcH9riSg4J7xe12hPiV5sHbGq3AX4oudfHAtz
	 bzTMIThX5duL/V//F4m+WVIY1S+zWXkif5sUOSPK+Lgf8cJC3m4ZbnWei7Ci94zoFHw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658774;
	bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w74Y3sexto61j9QjYNF9ViVR+A2H+X3u6WLoC7HU6tTx2YsMdTSYVKivtpphSHaMV
	 qaKvFi3peaYUItDaFwt9W7PexKIafOoLVBbjifyWjm961Afcyc+CLm7LkM6pI2tkrW
	 nsllQW3+vMmDvaqpdn8J5dyc/arK7r29jbX8/LpvJGQ9QBw2locFI6xwlgQJCscnra
	 Tw7+xMMNNrKfi/pon1Ppmui7ivfq3lmGVS9Ivo9z3hcarMeMwB57VjB5C/hCWVZxLV
	 sAi1p5nhQ6YnoA4a85oeLgk1ViKF+R1b5ZGcAupmrbbIonAZHptGwF3CFw39XIUKs1
	 7NqSN6MeseyGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26A3380D0B;
	Mon,  2 Nov 2026 22:32:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 02578380
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Oct 2026 16:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8A55400EF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Oct 2026 16:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PHzhLRS-c3hB for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Oct 2026 16:53:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B3EDF40049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793465621;
 b=hZwVbNXg7e2OmRFQ2YFu740VjxPNt2jW1YdhH/N9Vb0fWrX0cUBQNyoMs6Bp1dYILLhz
 HCOHDcqOHWcrF2H4VVJzFm8tpkXlR8kUQGeZeINCLRqAGs8WdB+P7zuyKz0tOStAV+Axn
 HrdkN1p9bhbYmqtDlHDQWvIpTuLUCV7WT3D/lUpvcxLqZ95YHbDC7wqKPZAQ+z8K1n0bY
 Chmt83MRcAHvJ6oDI42zB/y44o5VIDitGtk2n/mmpzYpP7pRJ47bCr1UTdyY1D58/E5BL
 Sbq/5INxCL7Z/cotohAXpUcxg7milvLZhWbPIBKRFi2yYAEj7zigvor/QNTj987Cphg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793465621;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
 b=h9it0u7v/PC5oslme0C2KnBGi0Hd3xP6SsTDgNY0+UJxNar3UVV5fQxZ9y1ep4NIlnQ3
 OHNsbSD0eaLNPa6JosfgZGDm5EGPmtqGcJk27jOvDEowwNQE1zKsXitk0/jdXUuGjl2W6
 N3K+SD/hvb9cGfSYqK7YPlp2sgIcppwIsl6cHQQQaLVCR+Bm41LqXm3sadaR9reilVcMd
 TrWylps+z7QgLA9FqzH1Q8Pv8vJ9PJa9S8/XZKXDX56zI/fro0GvAEAkjzcEizpmteOgj
 JlsI15jEXlkpSQsn9Osig2pl3ESdzgjXH9g58glC4VxLd4Z5JhiQ3nC45MNHqS7WUkA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=iEJN3S+k; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=iEJN3S+k
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3EDF40049
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Oct 2026 16:53:40 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1800557f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Oct 2026 09:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793465618; cv=none;
 d=google.com; s=arc-20260327;
 b=ZlabKA6EhQlKZWfBYTgt65FWQZPt40epFkCvtN90W2cwuX6Yvzxl4z+4YPKNoucVl2
 /VQw/aLNsLOBhtxaaEA56jX3Te/5tFSI13KthC/V7tYMQqoRCF4JXUMPVRbknA+FrH+g
 bohbfh3/WB1nnhXC4EqheOsUbeBOA77Bppvqq2SZnfbzfGclQ8NgD1d3Dy6u+5DAVPQP
 PNRD/0d3mlRLwEf63IqR06MaeX+vHZrfkiCmBmM+5liuL1hIh7s7MEB0LnQ+/UqbSjEQ
 N/srgGFn5U4jcwe9yetkBWRgsgOtCKMf22JRCC8nAFtx9WS0fzDIXqX47sPBvjhsq8Jm
 9ENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
 fh=CQPwpG3DzXKRlNfMsrUW62mfB15zNMlN9JfRXliDAb4=;
 b=QOSrf0cSQb/fTZA/sPGdO7rdYWukNkY7KIKwOX1nFqwZy/+oHlDtIJECqCKz4Ta8Hg
 j/BHYo/4YxoZ06pqTP2P6tkATrjVaVf7phQiCMjvqoO+vRd1RoFB6KuWOr4W0EdMgdlj
 eyppa/Kz4vTNr6O9DtjYPYIFgmXW+Luc1jVlw+lknsNBrEuze/IYLr9HLGulg2ycT5uJ
 Np43nG18W0mEU0Weq0TB4dJ6HpCH78cDiRyJMWeoIPXJS2UgOWNKqDT3kvkS3DrmIK1F
 FXMoZgR8K0hcCDaJW26moj7QA8HuvdUwQo9h5tMmA08OECInicXmpjGwdjDua7qTJC+C
 enhw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793465618; x=1794070418; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
 b=iEJN3S+klEfuIjnv4ktamZiW04nc8l6UpPlI15JrchgHaBlCUlYazUIw769ta1lpZD
 wo2+y3mwUf+cAkDcx/TEopY/c4dJMRCsZ3Bd1I7XxiDGayLnUxe3al2a/Rm8V/Z7ohgW
 yiUo6Z0tBrEz3BE6WGIVgh77a6mOKIymCCFt1xXiBq1BnN0sQ3+7zwyGjCeRzqnqrc5u
 EG9bBK+8eXKzfoesrR8MqcAkqdR3XDA7quC4UDrIMu4fPDRec1vdXtKidYrs0yWDJ866
 v2IVgCP7Lg+BlXDvIvFWIqTMRRds6lxf9Y08x+uR6WbiSZ1Icw4SJwq6fRieWLqnDlFz
 3xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793465618; x=1794070418;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
 b=eKWZMOtzjeFdYPLNbGBUYlL0blevffS1aE/tY5BiXIsKoyL3tdtjaLgjS0x+sw1BWm
 qcyVuBZmQp+zvrLU5eL13+Lq3ehULOd3/oOla0rgHsxQSydlXb6SJOWpg3frvfCHj8WB
 2JF6kEGW5Lct0fvvggFffRcF+cIepcYIY1MNVtOcjE+kzA5npTs0Sfs+tFdN/1vREIyW
 auTLr3afsEdzkF/o3/4B1K0qiUHB5f5Oh8iZmz7eUpaxiaJhH/iZLny/nJl+QqM7mM61
 WaSfAIA4B3BbfYSWm+1O5AmcFn8ljVHXRnOqjqHhBkz/7FWT0N+sMRO5fo/toSc8KEpw
 LNtw==
X-Gm-Message-State: AFq9FYKeKP03OqxNSdrxt7RDBJRObWY4ESVAd2fZqJbdzC76Ip59pIKs
 H4AXfWlFUQXwHF13NyfIfw/s5gSKXetA0bV7QGSQ2PYCNd/QK2IkcYw6OhGq9W3to90LNFgzQ9w
 8E0HjtBvevLHqaIzi/g2EP69ZdZamJsk=
X-Gm-Gg: AYBFou17kDUMSkI4swLO6UHAKYlw48PtbO51jazrx6ya2yfVndvnRZGixoIdsXHI9c/
 8lgrmhhTP6PuEnIPTkcJT3ys9tVWlvqyVwg7Erk82WUZWHvRsCJotbLOcfK+tAH+GG4HIgYlgKq
 A9A0xxIoCg0sycRmNFc8LB5DScunUsXsKmxDn6OjS+/+LOaAWP7IC180UGO2o9AOEGUuYeOIrwE
 x9NRj9qFtWbJ9LNh1hJiu/8xfa9NrT6QesgesQyq7fia3TaDSItftz/UrxlY6fXdw8yLOls1ZcF
 HKFbQ8kXLKmdN0EgSCmzSIea/FOtf7rAkIWIB95Oy9GTtmGofxSPmfLy9/kxKOcrhA8xTGmi/wl
 2o04Sh5rQd8/fOx8JUta7gxtQda76ygpjUn8ECxQl8TQsYFTK1jPmhLxgv6g0q3SoCcfhHqg3S6
 Iqy1Z0y5lhU99faO42pKCACWKwo0gokD95D/lXEIPJpWzpkv/Kc74PfQ==
X-Received: by 2002:a05:6000:26c8:b0:48d:f14a:9183 with SMTP id
 ffacd0b85a97d-48e6e303b1dmr12982373f8f.15.1793465617789; Sat, 31 Oct 2026
 09:53:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028170239.28606-1-tactii@gmail.com>
 <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
 <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
In-Reply-To: <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 31 Oct 2026 09:53:01 -0700
X-Gm-Features: AclHuK9MF4xp-jNiLvDP__4wEuJYr4Vy9lxz0MfHVWn33kHTzL4Vfxqnin2Erm4
Message-ID: <CAKgT0UfcR12X-+O5XvzqCV4Hh5rHs5dPZSps5t=1rPC5SU88eQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Andre Brait <andrebrait@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 02 Nov 2026 22:32:41 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 12:00=E2=80=AFPM Matt Vollrath <tactii@gmail.com> w=
rote:
>
> On 10/29/26 12:47, Alexander H Duyck wrote:
> > On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
> >> When an skb arrives at the driver and the header length exceeds the u8
> >> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
> >> are sent to the card. If TSO is enabled, some header lengths will caus=
e
> >> the card to hang.
> >>
> >> This was reproduced on an I218-V with an unprivileged Python script.
> >
> > Can you elaborate on what the script did to trigger this? I am
> > wondering if it can even get there with a valid frame supported by the
> > interface since most of these e1000e parts don't support tunnels and
> > such.
>
> I will send you the script OOB. To be clear, this is a security fix,
> not a correctness fix for rarely used paths. The rules say I have to
> post the fix publicly because an LLM found it in a
> function-by-function scan.

I got the script, will try to take a look at it over this weekend.

> > Also did it have separate cases for the CSUM vs the GSO? I would
> > suspect this is more a CSUM issue than a GSO issue.
>
> I have only reproduced hardware hang when TSO is enabled on the nic.
> Otherwise it likely just mangles the packet, but I have not confirmed
> that.
>
> >> Fix it by disabling GSO and checksum offload when the header length (a=
nd
> >> checksum offset) would exceed the field widths. Compensate for a
> >> software-inserted VLAN tag.
> >>
> >> Because of a quirk in the ordering of ndo_features_check, the skb's
> >> transport_header field may be stale. If the skb carries
> >> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there'=
s
> >> no reliable interface, so don't offload it.
> >>
> >> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currentl=
y for ICH9 devices only)")
> >
> > I am pretty sure this Fixes tag is bogus. This is the introduction of
> > the e1000e driver which was in 2007. The ndo_features_check didn't
> > exist until 2014 sometime after that if I am not mistaken.
>
> My understanding is the Fixes tag should point at the commit where the
> bug was introduced. A comment on the Cc: stable tag indicates how far
> back the fix can backport. I didn't bother because this patch should
> apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.

I get that, but at the same time the fixes tag is pointing at the
driver when what more likely happened is that the stack evolved past
what the driver can handle as evidenced by the fact that the fix would
never be able to backport that far as the function it was adding was
introduced sometime after the additional stack complexity was added.

> > Much of the complexity that enabled frames to build up massive headers
> > wasn't until much later when the network tunnels and OVS started being
> > added.
>
> The repro script should work back to 4.10.

Okay. However, that still only goes back as far as 2017 if I am not
mistaken. The diff you are blaming is from 2007. I suspect we should
be looking at blaming whatever introduced the ability to push the
headers this far as the driver itself isn't likely the root cause for
the issue, but instead a header change was.

> >> Cc: stable@vger.kernel.org
> >> Assisted-by: LLM
> >> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> >> ---
> >>   drivers/net/ethernet/intel/e1000e/netdev.c | 34 ++++++++++++++++++++=
+-
> >>   1 file changed, 33 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/=
ethernet/intel/e1000e/netdev.c
> >> index 6f85dab5c55c5..370776657d100 100644
> >> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> >> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> >> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device=
 *netdev,
> >>      return 1;
> >>   }
> >>
> >> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> >> +                                          struct net_device *netdev,
> >> +                                          netdev_features_t features)
> >> +{
> >> +    /* Do not offload packets whose header lengths exceed the u8 fiel=
ds
> >> +     * in the descriptor.
> >> +     */
> >> +    unsigned int hdr_len =3D 0;
> >> +
> >> +    if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> >> +            const struct tcphdr *th =3D (const void *)skb_checksum_st=
art(skb);
> >> +
> >> +            hdr_len =3D skb_checksum_start_offset(skb);
> >> +            if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
> >> +                    hdr_len +=3D __tcp_hdrlen(th);
> >> +            else
> >> +                    hdr_len +=3D skb->csum_offset;
> >> +    } else if (skb_is_gso(skb)) {
> >> +            /* Work around untrustworthy header offsets in this case.=
 */
> >> +            return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK)=
;
> >> +    }
> >
> > Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
> > the frame must not be TCP/UDP GSO since for those normally the checksum
> > and offsets should be populated. Have you identified cases where we are
> > seeing TCP/UDP GSO w/o the checksum being set up?
>
> It looks like this particular case is never reached by normal traffic.
> It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
> hostile or niche setup.
>
> When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields are
> used for csum instead, or left zeroed.
>
> The transport_header field is unreliable when a packet is being routed,
> so you would need to parse the packet from the top to find where the
> transport header ends.
>
> Rather than walk all the headers for hdr_len, it seemed prudent to just
> categorically deny offload for these exceptional cases. I could be
> convinced otherwise.

The point I was trying to get at is that the stack shouldn't be
allowing those sort of frames through in the first place. Basically if
checksum partial isn't set the stack should be rejecting the frame for
UDP/TCP GSO, not the drivers.

> >  From what I can tell it looks like the only valid cases for it not to
> > be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
> > FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
> > anyway.
>
> FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e

This is part of the problem. It pushed through the ability for
CHECKSUM_UNECESSARY to be valid in an outgoing TCP frame, and then was
reverted back to using CHECKSUM_PARTIAL. That is what is partially
what is allowing the non-partial checksum through for GSO frames.

I will probably look at submitting a diff for this next week to look
at limiting this as there are a number of drivers that already expect
all TSO/USO frames to have CHECKSUM_PARTIAL always set before they
start processing the frames.
