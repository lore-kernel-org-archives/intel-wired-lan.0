Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063C606A31E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=I8zYNHMT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=poAvuHyK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14BCB40709;
	Tue, 27 Oct 2026 19:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K64i8Ax5wfAi; Tue, 27 Oct 2026 19:57:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78AA240722
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793131053;
	b=TJJ1BEtEWI+O7jnEALE3uycmPAddmjxXecvAXvzteUqKMk9K1ZAWWGcRKKAUzI4OQ6Is
	 AByQjVgrI8m298Sg1swGcEwsetrWxKoPRNvNDzddgpGRNx7cxmk4xhR6gLFYDL3j/eE6i
	 eD6WAs+Dx2HuS7zYm75Wf0QOrx0afa8BVGuhE+2eDqIx7IR8m7ND6l0ckYjRHbp6FlU+s
	 IsB79QXTuKXj9OiDGSZ7XEsdsTCHYnglRbTHptSQLF14WCrLVdqPjfpAcqstYxcPUh4ID
	 4/kzV9sxoBKrXL7NjajQntpb0Kh/uqv6cZSmvhjOWoVDqb713cF92xnEYhQbluTzL9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793131053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CyuTVqrEGPeDy0Z7+MBAQ6iLsoLVTf0+QXG1mFBmti0=;
	b=M0jr2JNaV6kS5nrTEDSQPnkK/eHII59tDDTMLzFlW1REC0l0Qo9nG6yx9qgmDcW6fHfo
	 MGHSclw2T3mky153Rsn/r30lRHkfaXUwyyzxBvkub0B3yo1TaPa83wH+QWmDgrumkuBMT
	 /fjclwcVZqZLzj63iTifizOaRl2/tPBA6fW1AH3MjDyxOjTKCSXghIs9mHTznAj+tJUSr
	 lPev91wGu1HmFQ5tNgHC12oS4Xh8LhX+taghPlnd/+sY90sxlzy1GSVarj/Qcp0Q4nMus
	 fh6QoWnkA0xA4aZAKBXkUF/OTSJrGVZVoTL3dwmQflm6SG/9yUUr+/0vCoGiAj7qKqA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793131053;
	bh=CyuTVqrEGPeDy0Z7+MBAQ6iLsoLVTf0+QXG1mFBmti0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I8zYNHMTO0LG26RWCWHjwDNOuXk5Wkem3ODcYuSHh9nqvWyOOXbbmm0gktN7TPKXL
	 lgU1zllf34Pu82EuLUfmmQmtLIy1W96dLXf2gEE5CmTv4YLYWkNiRMiyJrkmUzvTNB
	 H2w3zSl89qVi8jNCZxAqWG0aQKiessoDH2b1xCt40shsmZYzwd7gW8sHhwrMyrHOrY
	 0PnNZNMuKFg2IXtRxblmN9EGeYpx/1jZ9j1jWCIzUIeMTyue13dYseEEWcQhMeKYhI
	 yJKmXZ05g6MuanA+T+BD22mDR7J7smMoF2lKnQPFkcnJ9dQwf6Ib5ilF6+F+HVdVR9
	 95QCPVbWkZUuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78AA240722;
	Tue, 27 Oct 2026 19:57:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D25D4356
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 12:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B819740062
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 12:21:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VJ5TA-Snbxy8 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 12:21:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0513D40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793017268;
 b=KZtSgJs7p3A6KyF1rbsGDva4kaOBVmQN0AqO2M3lHpsnRzICQN/rWwgoSCFhapjDSRK8
 rLFHbcYeXGwR7IETXUoyX4r7nMG1htwC+7Fi1DHE+ydXYrBCXbjXWV5labB06JFacJwRz
 H+UXFMn/Z5gUYZiF0eO6pQSGW5cbnpRh+4if/Bb0wD2X/e5/OaXyfSLMYnYYMTqRSCK32
 7cxCQ0pcl3IIp0YOga/6zKmXV+vpJBbMxDyZzmJj4HERZ7U0D6sO4zs5dMSp5tVqLi6yJ
 DaXgRcOfvv8r26NlMhfeLYWnib3I6NIHiQ/wSJ1PvFkFBvhAaLRoSHwrWWJK0R02UFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793017268;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=CyuTVqrEGPeDy0Z7+MBAQ6iLsoLVTf0+QXG1mFBmti0=;
 b=UoEjPNx0T2aj2b0AgDOq+4XWNcX9eXBbLFFKofw/7mZ4+xx1tkimCyrdt43+Jl/HHiiL
 mxHCs0FBnBU/g1qXBmLrzzZxA9ClJH/PRRZDOc9am+jTX+rsbS4q9e7tIoKJnSHXFlLlR
 8/UJhHBKmqlWyd5hnmpVpdvfSPNe2niE1B4GdEKCiDJBIAfB0xnFl1g5c86fa+JqeWie+
 wZHfKjP8QrdLVtookrMXxSNl+I7qZEwTYAq761GUZEBjl5aWoEXbjWz+TRcHfvUxLIijR
 z1pJt8O2Zf7WwkGN3VFaoRk3T6HS+rbQnlrhyiMh1dQcGVsaWkMfDYk1+lhs/lcn/PQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=poAvuHyK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92b; helo=mail-ua1-x92b.google.com;
 envelope-from=joasantonio108@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=poAvuHyK
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0513D40060
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 12:21:06 +0000 (UTC)
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-98ff53fb739so1813208241.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793017265; x=1793622065; darn=lists.osuosl.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CyuTVqrEGPeDy0Z7+MBAQ6iLsoLVTf0+QXG1mFBmti0=;
 b=poAvuHyK6yMXQi3y3+kubrMuYh3RfApEcZvmnxHXY6R7VtIqmtpe4AG9IGd4Tts31S
 HiA3fzbr/NMDux/yqg3fg8pUTsBEqulsxz5FyaP/LnQfMz94E8JwqxiRbCCAYf1iunpu
 lUmWEwBYKXW9sUHkAZeCRLGPPYia7JxunEKqJTSo98OAg/dHm3oyxIJ208hCEtiVkkc1
 s3L5xbotLv5hBcW3L2+BFiRNZ+wZOIEw5vZwznfMrngnPm43gLo52Y0GrYYrasSRy8jR
 FJD94m0mafQr17+DKBS+4apBP7jSGQfUedxJAJTXCi2QSQXG+L+BcKHkk8d7Yg8keqi5
 6Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793017265; x=1793622065;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CyuTVqrEGPeDy0Z7+MBAQ6iLsoLVTf0+QXG1mFBmti0=;
 b=dOIgezHSzDvFEOPZIZIr1FzGXkUp9X5pzyAPTZWOviOhUK6YgZI3kM0bDV+LUqAogW
 v9AonP+issfsnwcs6+9y0Hi1WzeulNBmLuPNDUnoKyf0/pu2jI6Ysx2ZK7XA1jI5gUGz
 Oo2A6VOHB9995Mxxr2IlfTpMGw76QHzNIBmOAEy1+xb0beBUQsNyh/wdy5gXLEZiG7i+
 a2VKXx5xa/uHBgMC3ivAsM2bY3gigLVXyfnO5CuKhktet7gwOKBasngap+PVHwSWD9nR
 g5D6A4Va6zNT2WRv+Z+cakMJZ42Wq+lFQN/XrpnSI949lp9e4VeVMY19FuozY2TITsfJ
 DhOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqnh20+5qyzFw8A/DGw18JGABYdAP82OaXA9comQzv9As9Gk1H0rzGk+VGHMEOOeH9ZfW10VlQ8yiL+pptMXo=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKIWuNn5n02qnCWzFhMQdyaeO89jA1USVb3U3rUK4IbfhSw3EMh
 aij1dUcI8WAwwK6PGkAj6tpDrsl1jpVy5qDNAWuyDxCmq+9XoFSAJeZZ
X-Gm-Gg: AYBFou2JDocxCHDJtWFtJ/5qUf6AXDZvDhjO0GKVUVvSExkpxhu7/25YQa/FIJiqOCJ
 DCXMSJC32RA9KNqzLtTZbvnqcYxScH23TPzxas37eg3+KFoGDnuo0AkNQvqU+/T12PDWVqzBRxz
 cj0vDb24ZcWPfA4XL8ljYD8AR23KQM+Y1fQJRSEuFwyKnIFwGYyppZRe5A50Ut8gsYAwzrcdkV0
 BL9+304o54a74IAi5KULW3tCxDvXkolsN7CgrTAoMhPdMpC5s45uaWGC+0uB7ve2AVStMmPMH8f
 s27y8sbhBs5qiEyfSbNPcYzFUuFoxn/6I69Ztp3f0NsYpN0YwxHEY13kruqqBZ53z3lkt5qnoTy
 kfGSpk3VMKBvK6/ir3WHpMCROuctorOlm4XbVtr7B80HuSiGXs2OeluHjGWu7kZVORPTjPOriCl
 wu4cmZdKlLVW9gYhmP0eifTdDgu9HwbNKPWdK3uQ+GYhhSv6R+eRtIp3DnHgUXqbd9DWexsHuHB
 IdrtaKcIxrC9rItMrC/elItdDbs5PRH8h+JTPzh9MukkPdFbwMFiZ6ciEMIa0d7RzfGP/HLiB3H
 MUrJ9bT9KGsBUY7GQOTnaHy0gGQ1zVqoTaGrnBOydcfXJVGDvRQ28C3rWYTumxMuZ5lD3UyZU1Y
 9CWvUDPmm5X4r6xg7C/c8goNYKylLw9iIpI4a0gpexQ==
X-Received: by 2002:a05:6102:38ce:b0:7b4:879c:bb8d with SMTP id
 ada2fe7eead31-7ce5cec4393mr1848330137.37.1793017265352; 
 Mon, 26 Oct 2026 05:21:05 -0700 (PDT)
Received: from
 c.1.0.f.7.a.5.f.d.4.6.5.7.e.5.4.d.7.3.9.0.c.2.a.3.b.1.0.4.0.8.2.ip6.arpa
 ([2804:1b3:a2c0:937d:e94c:8101:376c:4b55])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5e16eab4sm7408804137.4.2026.10.26.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:21:04 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dcb: initialize PFC value before calling
 getpfccfg
Date: Mon, 26 Oct 2026 09:21:00 -0300
Message-ID: <179301726001.91878.13970924707743684105@gmail.com>
In-Reply-To: <20261026073235.3huvz6o5h6psyv76@DEN-DL-M70577>
References: <179289284460.50470.572724041164324949@gmail.com>
 <20261026073235.3huvz6o5h6psyv76@DEN-DL-M70577>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 27 Oct 2026 19:57:25 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 07:32, Daniel Machon wrote:
> I am not entirely sure, but should this patch add a fixes tag for a driver, when
> the change is only in the API?

Fair point. The uninitialized u8 is in dcbnl, the drivers only make it
visible, so the driver commits are not the right Fixes. I'll drop them.

> Also, if this dates back to the introduction of DCBNL then I guess its not a
> regression and maybe a fix for net-next?

Agreed. I'll send v2 for net-next once it reopens.

> Why noy initialize this at the declaration, like getall is?

That works. In both functions the PFC loop is the first user of value,
so initializing it at the declaration is enough. I'll do that in v2.

Thanks for the review,
Joas
