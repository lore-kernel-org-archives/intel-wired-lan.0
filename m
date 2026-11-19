Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B831606A32C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ownZjL89;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wt+hI8Eu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B50360E82;
	Fri, 20 Nov 2026 16:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vv9r61-jUmPC; Fri, 20 Nov 2026 16:33:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8035460740
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795192386;
	b=exs2EhuTQ3JH7CdL7LNzuZasiUZuuBW2ZE4gs8x4ckky/CeAKjI7Q7Ia+nBm/lxKgnjN
	 PsL2PDb1/sSJ5iSle9DL3n/+DqfMkvKJtEtYWVmW4UANCgzR5cGJAWP4I+z4aoCu/twAX
	 hic0QHVXHCEOByNKE7I01wrGZopHJRM4SaOAHhMWuNy1gUSs84AaIkDkHTjLdetzZ+LVd
	 0FU3XVunpes57l/8ZU2FlQLXw0LWvAdtLvhhVIXEAtt/HAgYU0L2PXVBEj0Sly00ZLdMb
	 qfiDdaWbaXsLFHpCgYoAQQ9q4u1RMZwHjSUWERfv2wrpUqz7Rqq9C6Wjbb2H0F8a+0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2c/CMF807UVrQ1AK631l/bk5YzH/qPyRcaggbCxLlzY=;
	b=p6zuP9W+Yss76H7UNhuS7P2m8vNVLEBrrVFTMoA0cvuylWd/C5lyXzlVFEdYW/5WHKMh
	 ywLfHkwj48RWcnp1d49xk0VEvMjuHmzB4+ywGoJj82RFN7usTP9fqSWoz61CEiQmbnFil
	 92jVoCwqzRguXbc5s3GCGRVKvdfaG97Ccl/PXS+IiTrrD+Z1GfvZLLW5tCr31oAvLdaJt
	 Hr3F5mIvZ+L/IMi7koFu55vwcF+b7QSYyWCQstyr0Tmivmuz0fAsUSpysx1WG6boDxiHl
	 ik4OOxTXnpmFI6AGf0vd3QlWotEBs5GNeeRsn37v6MbOXqrOlVmDywI3VE7AqQ+ATCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795192386;
	bh=2c/CMF807UVrQ1AK631l/bk5YzH/qPyRcaggbCxLlzY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ownZjL89AKpZ1IhN2pS3mQv87Ml+HmEZl0xzafHqzjqDmDgVoSeDGpfH3//qWPsrl
	 OTCyuRlxytcxy0PBGZsI4L6ERidZCbHR/U/aQTMT2wz6ZHDQ7CPEveH6zkUsocJfYM
	 B3uxBHn71yKHRVCnvDOz9uretAjLL4cyS7/eJBjR3IqJzA6UIBqCWCQt5PupD0o3Pq
	 a/SWdrq6/BxrDTfgbRNrhwxhT6DedHTPR2zuB9UMFFsHWv7+hScNr0BFugt2JopxnX
	 nBzWz8GHbbfB2SeaknCo4HMrJcGAx30W8bQVL9GJINynZquswAJGwf21JsG8W/DVRw
	 6Dws6wipUVXbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8035460740;
	Fri, 20 Nov 2026 16:33:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 645EC3A8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 19:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55F528150C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 19:32:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_JEgWd3J_AV for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 19:32:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 033F08150B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com;
 envelope-from=ahmadexp@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Wt+hI8Eu
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 033F08150B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 19:32:43 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5c1465bbbdaso9269e87.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 11:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795116761; x=1795721561; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2c/CMF807UVrQ1AK631l/bk5YzH/qPyRcaggbCxLlzY=;
 b=Wt+hI8EuJaRtTEiWg1KLlCkmMh58+2o6bjGXXgJVzQ4ocfZqecY+TEHFjAQ4gfYQpR
 ZOmWGkmaQoPyV2yyCdaaaIVo7rrG3n5Dj/7bZd2deg3OcOuLFL55qBEH8l3/e0i9RtRT
 t4wuZnGmg4dN86xXBjyye8eNXCAPi7GByJrZKOsYQeRWj2CgUxVguTvbCLFKPfYaW6/C
 6I9FA2cSOEqDDerDy/I/ALFiaz+7xIxQ7Ukcb7hBKLJ9NbFhgJ8SbTYRwCTXnQBYdYbp
 aKPDz5AhReDOcgtdhn3E3NIUknv6J5n+btrnly0mk41wpSPkW6XdeLV6CLU12gb/Sc4X
 exAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795116761; x=1795721561;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2c/CMF807UVrQ1AK631l/bk5YzH/qPyRcaggbCxLlzY=;
 b=mxg0woa0+wW3BeGfbWgb0MrddRe+EFMeQuDsyhyBdEGMeapGDZ9ZwwMS1DljoIYgu9
 GS9mwP8FhI8k7ZvLYFNcTgZ6ag9IYhm/7+pl2gMS27ivEBh+PRByOrHhp1KA6335twuJ
 qiI1OqbTFcf7UDOefxKJSs9aPLhXvHz/x9kK1QEeiy4WdURLnWBBonvlz6oDUxJHQBlg
 p5/qetYsJloZ+2WutJJhO6Q1nLos0vfp1FkD/3L9DC6r2NHtB40yjklayiA9ZZCx1CCX
 xVA4t/OlM25Zrgac5PeymPuM28A4WNQ8dl38ZAcExhvd93kJ+2Oi81LtOiTBgWvchJ6N
 EayA==
X-Gm-Message-State: APuU4Z9iTIGd3wYngjVgovu8hqco/Ff2cVRkqMwOEKQIVubcDnHeHfMX
 bDpxVJRBSPlMnozYDZDk9hQhphE8H/iNvFLFeHG5pCLneAcrC2mkGQyBJdfe5DcGierf9lpUJKo
 q2FL9SYQlsavoQo6C+S1sud1v5zt5oVHRkqedCek=
X-Gm-Gg: AYBFou1QEwgqFOb5trw0vAS974ziWTalJVZU2T+NcKcxY9T7IUCNkClp1GQSEWG8/tD
 Ee5GcxCgDngyQDXYCqkySt+DnID7KcAmJ0Jv7VxoehXqsXVJKcGgVyg0QKUWPENljPcmqcV/Dl7
 +LTB7z2QiO/Ihqg3eNX6vW7+IR2z1Q6Za/nzvYz5ccw4GRTYV+ZpZ3uhztpJDoDuU5wk9gL1siJ
 3WmczNwbyvBWTbyoHEGzA4qVmYcEAqWIxiEtWCetSbajot34qAGNRai7nmpcYWpVhujpSB7freB
 +sc01V5e87+9LF2QfRwnSGYvWOl7m6lc2qdcSjInOwFNlojDGP8ypuFQdnW2yZ+2KdrhVTpgnW/
 ShXLiCaFxBQ3gAq750d/U7ah2/uUyTIOYEz6A0WJFfaI4wsbBqMpNIs4hMUk67xWv0JFat1p9/D
 6xcHhAiQCZj3gCAvDxSp8=
X-Received: by 2002:a05:6512:3b21:b0:5c1:4c4b:6b2d with SMTP id
 2adb3069b0e04-5c1bc8f0665mr180691e87.58.1795116761108; Thu, 19 Nov 2026
 11:32:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Thu, 19 Nov 2026 11:32:29 -0800
X-Gm-Features: Aa3M54oofjjNnNH9tTc-QtW1TB2fkTZKj5AQD815z4ZiiX_4dzQU-6GhVDld0gY
Message-ID: <CAOQiBWOrLLR_hDAxGQeDT0ogrR0zDDvo4vrk6_viqurAHh33uQ@mail.gmail.com>
Subject: [RFC] igc: TimeHAT I226 PPS input filtering and output mode
To: intel-wired-lan@lists.osuosl.org
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
 "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>, 
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:33:05 +0000
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
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

I would like to upstream a proper solution for the PPS behavior addressed by
the TimeHAT igc driver modifications:

https://github.com/Time-Appliances-Project/TimeHAT

There are two independent changes in those packages.

The EXTTS change accepts single-edge requests and filters events using the
current SDP level in the interrupt handler. The recent packages wait 20 us
before reading the level, with configurable delay and inversion. They also
force every enabled request to rising-only, including both-edge requests.
That behavior needs to be corrected before it could be proposed upstream.

An independent user reported improvement with the patched input path here:
https://github.com/geerlingguy/time-pi/issues/28

This is a user report, not a controlled current-mainline validation. LinuxPTP's
both-edge mode with the correct physical pulse width should be included in
the baseline. Sampling GPIO after an interrupt also cannot reliably identify
the timestamped edge if another transition has already occurred.

Is there a documented I225/I226 edge selector, latched edge indication, or
supported workaround that would allow reliable single-edge EXTTS while
preserving both-edge behavior? If there is no such mechanism, I would like
to establish the supported approach for this hardware with LinuxPTP.

The independent PEROUT change removes the 500000000 ns half-period from the
frequency-mode condition, so a one-second output uses the target-time path.
The project README reports that this resolves its PPS output behavior.

However, both the packaged driver and current upstream already contain
5e91c72e560c ("igc: Fix PPS delta between two synchronized end-points") and
84a192e46106 ("igc: Handle PPS start time programming for past time values").
The current source also programs a future target time in frequency mode.
I do not yet have a controlled comparison isolating a residual output failure
despite these fixes, or an erratum establishing the need to switch modes.

The proposed comparison is stock current igc against the same source with
only the one-line mode change. It will measure phase against an independent
reference, pulse width and polarity, and behavior under PHC adjustments,
CPU/network load, and repeated enable/disable on both channels.

Are there known I226 revisions or operating conditions where frequency-mode
1PPS remains incorrect with ST0/ST1 set? Would a target-time workaround be
appropriate if that comparison reproduces the failure?

The goal is small, independently justified changes against the Intel trees,
with the correct API semantics and hardware evidence. The packaged driver
should not be merged wholesale.

Thank you,
Ahmad Byagowi
