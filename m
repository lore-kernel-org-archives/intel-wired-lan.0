Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5C3C54E67
	for <intel-wired-lan@archiver.kernel.org>; Sun, 17 Mar 2024 15:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B439812AC;
	Sun, 17 Mar 2024 15:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AjYS-2EsnJeO; Sun, 17 Mar 2024 15:40:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BDF1812B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1710690043;
	bh=BN5rfpbSOuj0X70e90AskrGd/D348RRJczaiDg2murw=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=wNpjEuVUAPculJMvAz2zvip/CjtkJA1z460I3DiabvQzc2nhOoKOP4nxq1bVd08oN
	 VsSd1giuwV72Js5AkKwcWmfzuY0CsE+vqnMKWpjaVJoYi5vMEgQGn2tdhf+JXQPSHA
	 LTglS7C6ZrKQ7ChXb9QSIzKWQ8+AMlhk8Jk94j35pq6lYiX3edJlGG5dz/XYsuKFFp
	 T9DiM/fsveIjz7NCpF2N1o2suI+LUEKhuFICr89sj3mtgqUQpP4oGhrA4HFo+H1eLX
	 Cj3p/NQSlAB3fWqNm2Ov/eR02vTT6ys4e7Clpn2MgsyU2rzrDzjH5EPVh9zOBBgZy+
	 D499z3b+q8x4A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BDF1812B5;
	Sun, 17 Mar 2024 15:40:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id AE2121BF408
 for <intel-wired-lan@lists.osuosl.org>; Sun, 17 Mar 2024 15:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99869812B5
 for <intel-wired-lan@lists.osuosl.org>; Sun, 17 Mar 2024 15:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P1zbE9JgAkwj for <intel-wired-lan@lists.osuosl.org>;
 Sun, 17 Mar 2024 15:40:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BC1C4812AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC1C4812AC
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC1C4812AC
 for <intel-wired-lan@lists.osuosl.org>; Sun, 17 Mar 2024 15:40:40 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6bee809b8so3382023b3a.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 17 Mar 2024 08:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710690040; x=1711294840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BN5rfpbSOuj0X70e90AskrGd/D348RRJczaiDg2murw=;
 b=dD5jTDVXpZmofgawZRDKJXgPaPy+2waH4WGJ/U1CUzeuTVdDONUD1zW0asUSrjmvDK
 9JcCTUJWG2ds0YXU4mXJ9vS5IXRFYeUC4JB+xxsnkwV45is11vqAWs9F5zechIGuJOam
 Mp6iRJ1j9YkxwmmYUZuTckoHJhsAVyKDkybv8yecM7nxg3Ahu6hrGIxJpxCFdctJj4d7
 yyijekg0ETFX4XQuVx0BFM13A98AypoZEaiGvHVrQPYKu8cnVr68IF+h6cu+QVgkO01U
 aaVHMVReuXB9MadfpEupPh9rfxs3wm2fV/Ewk9355GYAF3RL1OIT9Wvhr4wx+DJ35AyQ
 5G8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuqso/FfkKdkxw4HoC+iH1HVNT+v/jYJs4kbTkrp2VbS/IdKBr+ZS6joXUxV6iGvsD9zOld2CjtTKbXyMMToO2SkjH6JHhhyy3z0o/PAnn+w==
X-Gm-Message-State: AOJu0Yy1ZPBtbnzwwtNy6fDjMu1c9UGCpUbbaZzLrBnu8dGiD35FhCJV
 8gHsrViiBAev0NV3mH8LNvYcJlfMgHhS6ky3Rf69yoo92T4ba4hEcr2kP2nZCZk=
X-Google-Smtp-Source: AGHT+IG7Xk93BgxDOAwncq6Cbr79dZt/KkPrl6SVBbkXEepBnFuLP09OA7aiplz3FMObC/Wmp0dixg==
X-Received: by 2002:a05:6a20:2588:b0:1a3:6725:4406 with SMTP id
 k8-20020a056a20258800b001a367254406mr383278pzd.14.1710690040021; 
 Sun, 17 Mar 2024 08:40:40 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
 by smtp.gmail.com with ESMTPSA id
 le15-20020a056a004fcf00b006e71bfa5504sm1203644pfb.119.2024.03.17.08.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 08:40:39 -0700 (PDT)
Date: Sun, 17 Mar 2024 08:40:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Message-ID: <20240317084037.4ae8806e@hermes.local>
In-Reply-To: <20240317152756.1666-2-thorsten.blum@toblux.com>
References: <20240317152756.1666-2-thorsten.blum@toblux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710690040;
 x=1711294840; darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BN5rfpbSOuj0X70e90AskrGd/D348RRJczaiDg2murw=;
 b=jDztuH1g45sozHyZualA1MHOgMkBYKa+KniKfu2erd8YkFfycEIiL5NlWkbUlLm9EX
 Bo/nBq2LA8oGXF4eQOC4GD4+/ntWXZnGGgQ+RZvnRRNWMSa+d/xxiF8AcQ3P6Q3Z9wmH
 g8ykGNdAN3yDHtH+D6I7uFuKoidzsqWL6rqvYePIZ56zQ3IoWCWiYyyLBn0m6DQjXoxC
 IhL5jIryGEiNK66rNejjIUBd0CrFrUJnY5rMb75a5U5A9A5wZqooXrmDjzRccdmAu032
 Oj+Pzw9P7D5VTeWQcDXgfiGVXiqjr7MvCrdjAVJNczkWKyHITugHdCD7xLRnV3JnAX8Y
 2QyA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=networkplumber.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=networkplumber-org.20230601.gappssmtp.com
 header.i=@networkplumber-org.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=jDztuH1g
Subject: Re: [Intel-wired-lan] [PATCH] ice: Remove newlines in
 NL_SET_ERR_MSG_MOD
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
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, 17 Mar 2024 16:27:57 +0100
Thorsten Blum <thorsten.blum@toblux.com> wrote:

> Fixes Coccinelle/coccicheck warnings reported by newline_in_nl_msg.cocci.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>


Acked-by: Stephen Hemminger <stephen@networkplumber.org>
