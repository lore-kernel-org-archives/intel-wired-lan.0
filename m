Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB24C5AD2B
	for <intel-wired-lan@archiver.kernel.org>; Fri,  7 Aug 2026 23:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0336081159;
	Fri,  7 Aug 2026 23:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TXMTDjZo8IHk; Fri,  7 Aug 2026 23:47:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF96281150
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786146439;
	bh=6U8b/xxr7W7JidExED8zlCpMLvLV8fhTwg1OshGKUyU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZIo4UCVNaWbvvZNq/d6YDsGcTMfA8i6617LN6BDWvuM5mFIPMsb6BJBfksN8dN4Wz
	 YFQlj4rLTtB0BkOJWzKhqyAQVafz50ahAYQF9C2QANHI0UQms+cL8G4yGfX8yDyleZ
	 6+n4/dlvMeek2ysBNp4dKE7b/KzuVCRh9bTuY0J+9k6t1+hn3oogfkSk9bkx6gDFBo
	 8f+UtsvN7w4Y0Si/pAxYfqdvV6SyDOqgDkL9qYJ+bGgOdtPaxdG0/JTVXq1H8adm3e
	 oqcV6pX67aDThF8hdy2kQzzP7rXwk75rGrYMIC96DHaLZE3ztwhXsE94AbdwAxv23k
	 ikxevHNMiUxGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF96281150;
	Fri,  7 Aug 2026 23:47:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E301282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 23:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4001F4020B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 23:47:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HnlfO_4NgXqo for <intel-wired-lan@lists.osuosl.org>;
 Fri,  7 Aug 2026 23:47:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 60B97400FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60B97400FD
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60B97400FD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 23:47:17 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-82113c53aeaso746207b3.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 07 Aug 2026 16:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786146436; x=1786751236;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6U8b/xxr7W7JidExED8zlCpMLvLV8fhTwg1OshGKUyU=;
 b=GMjyYFQWz5kRLiCxi/FEuN5VPj0CagwmAavLpCfZjZpg7jFrIlnOcgm2xzJ49d/n4p
 zRhYgVveMngT3tCq/BUmcdqB20tHf69WQGmOCaD3mX42EVM742MShaLgyCCUkKXeFVAN
 JnR6dTj4p4gWrdiGiRAe+429/rWB9FMx/FadhkG3x1+koIuDBnFmC4bFE6/k3e6U1Hkf
 n6hExF6ReDvvu7XgmX/j/9qxoAUbmWg8QW/Rlzmv4TtLi/HM+jJqCIdmbXwmlFk26LFy
 jA4xQue7uvYF9QFMABswg+QORhuG3D387Am5Q3XsRpR8AggymuyaS0Yav4KruZ1WEFwS
 GqdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCiCgTmML8wDcwFatbtfFZIkTEypIXDODiWudD4DYgKI+yZ54i8RTbyedCiKsXs0tT5sX68q893/drq3p7Pok=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzBYgJX6k4bS//SPfSnmePiECI9xhtgqkNQ8ecVA85VDOAtnUoa
 bVpnLVcxCDt7AoCVsNamalbzRp0OeUrjEaHzEVDJQ7xz9oEWbCn/JcDP
X-Gm-Gg: AR+sD126JITy5pekOIkv3toLKME8KGbVZ1U67I7DVT1vUOHOXl0TmDAm5ZTg7rYOd0W
 tRTPa6x8lGDdcVv+VVnxMZryOKNaZP+3a7qdsJoUMFVlrImFIXjZHPdtw4Z2bHz/HtL+aTbqOz2
 GQEDTeur4K7Sty8BFP68tYaVlicUjyyRZnovAqIggoRf0gLLDu9voyd237cUgNhqiTYMv8LFATA
 E9fwEmUevolB3Gw9ZPWCG/tH5H3emsDrL485u/yo0o73DJbxYgrzm3lzskMCXdEOqGjvKkyfcTi
 KbX6lrJD4DMb/QzKQgxb4s/azPBoqOL4hUPkrxkg9JWqys8UWvmjCchay7f/bODlkdIVWRcmcUe
 ws+x55Cr36ve2stgV2x7Q7FQg/2FNchANPYcs8vgHuLolC62ikGHcjEV83ddw0+F0pBzjHcAu7V
 CfvMAdZNlFMV/Uq4xVVpL1Y8WcMIxkFAHxosDHqeAKkSHpy1zcxuZdTlRNJ0rNCQi6qr0SOKwtP
 htH69fL/A/fvFwNjl1HuMMoEqsRgXwCYXvrTZfQLTj9OqE=
X-Received: by 2002:a05:690c:6802:b0:81e:ad1:8e5b with SMTP id
 00721157ae682-820224f293amr156718137b3.33.1786146435971; 
 Fri, 07 Aug 2026 16:47:15 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-823f03c85fdsm19233987b3.11.2026.08.07.16.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 16:47:15 -0700 (PDT)
Date: Fri, 07 Aug 2026 19:47:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, joshua.a.hay@intel.com, 
 przemyslaw.kitszel@intel.com, Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.342b45ed25289@gmail.com>
In-Reply-To: <20260807153933.7b8b01d4@kernel.org>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
 <willemdebruijn.kernel.c36ea46d8e97@gmail.com>
 <20260807153933.7b8b01d4@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786146436; x=1786751236; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6U8b/xxr7W7JidExED8zlCpMLvLV8fhTwg1OshGKUyU=;
 b=otyhdAnsXhBSBiV3KZE7Tdt6gxsFBqsXfYL8dxri5tSSCF2rhuhbWfo/xoCQBTe2So
 8tYIuQRokboM9eeZsOcgpsOtJASzTzLthkyRVg48ZNCInhBLiP1/krTdiV4fJLCsgNEX
 itcbarFTaJe1W66OuDUKGQCOKSp20K/dFXNC22Bk75bqJ/qKoGJM3kvIJtQ9ZYiqY0Uy
 RYtuOmEyYtJrA2QmMRx/5lnVUWAeeDFqJCEL2vShvbbwxg03I3NmOPP3cbmyBCYwWvwe
 0OtLFyvBnbbz33BEOItjtKLVJqanXgXXhf8qbtLMkSBJKMRPfEE5l02A7L6pTSsO1331
 J6hw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=otyhdAns
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/6] hardware pacing
 offload
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

Jakub Kicinski wrote:
> On Thu, 06 Aug 2026 21:18:37 -0400 Willem de Bruijn wrote:
> > This was intended to have a wider audience list. Will address in v5.
> 
> LGTM FWIW

Good to know thanks!

I will fix up a kdoc warning that patchwork pointed out.
