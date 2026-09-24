Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293E4C98310
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 07:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABC4E81AF5;
	Thu, 24 Sep 2026 07:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GLnARGEfHVDZ; Thu, 24 Sep 2026 07:41:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 618AC81A5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790235719;
	b=dSm7X5dhbdtqQbexcYayCxbvvrwd2XHvIC4IlnhLjjDb7lsHIHB2tIkIIXgWye3O9Pvk
	 hupkdHCfMMFvpie/SqIX6RtgmBqlljtlgRsIyGaJV2rfIQqVu6RM6IcqjsMXgkRAWIPPn
	 hLhKp6CU1gpcLkf+cY9bIJJ6WV1Mcy9IEGsV3wgSuHVOdZ6woN9ykpFP6WtpWiX6VGAbb
	 udJ5bb/MpZEhTXaJIkVqJnF7ZhpcXCLqoLpMiJFF6eZG0f6ZkSUWM4B4dniVFXvKvPAJL
	 y1Yt+NwuTAh84nawpTf7Pvvr0mYqce5v8uxoKLxnulC695OvogtaYZKtBkpj22NRKcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790235719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Received:Received:Received-SPF:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-PPP-Message-ID:X-NC-CID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vuk9EBybQLp3oWORS/2fZ6Bg8tAYtLSMmM3G36lY2a0=;
	b=pzNLzJ7UyfsQbIWSR313Jchah+wnvQyBoErpAYjKzOnNH1ph1U+/NASvhYIQU1+8Zk5W
	 uyu6lZ7ApqvmpnyQNDdZ4690Lx4zuKfm4AhJwF/oO+AgwPbi2tSblveEwE1WEJPgvG0jg
	 JVBvigVAK/SuHMHnoWVG63w3lpTXkB7VCWz6vx7kbLLiwm/3n8pCb16IBWnnAorQ6gizb
	 MWujl8CRjUKJ11MZWBgKFB3htBRboPAM0x2rqmEwcl/31CL0LqiPOvTufAhH/4ADjS9UD
	 igl9KuHt2J0KGDxiTWnw7oeGEm4eg5rZEcMwElfe7eOiYyPerIoAWl+GAi5WXrzG1fw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790235719;
	bh=vuk9EBybQLp3oWORS/2fZ6Bg8tAYtLSMmM3G36lY2a0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NCXpBudGQx7omFOs233j6WY4vrA0l8dHF1/0bZOFQiCvCLEA7Cd7ctjN14uONwGuy
	 W1ukZvCe4yzsPmukxhxdtV5Oub6Ize05mXPVaBMC9v8RSLCd3XcyBxsi1X15tt1Fqc
	 h9Tseg4K6SFX08QW5r0iOnZVm7znCjM9tSFIkwBj3vvk8dOHzofEqRn09WdDpqQJAN
	 d5pWsaqtNIVrR62AN2ioOKWxw63eWEEPqlt9ffUdUreTn9bEWnDi+qQSvaGo71KZEO
	 jfQQsTy8MESuc10VSVe1co2Iw96X/SBSYA42Vl/l6YMoiPwSambhLWExvlj9v8dSuy
	 awvwWnWMUIlCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 618AC81A5C;
	Thu, 24 Sep 2026 07:41:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 180512F5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 07:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0921B60B31
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 07:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LxzQhx5rp7U5 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 07:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 16CF460A4C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=194.59.206.189
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790235715;
 b=OjU/d81ybKKAcnyjGlnGCDEl2C5FNE+pCGIHkKp95zeD/sTTRxZedygfpHFA3an2XPzq
 O1a4PpIARoZByXz4h9zGgX2yhS2zoSL7OG8xZf99oGGmW1gpOr9r3BNLWEGqQn73Svzkt
 FjUW6o9MiXZh4IAtaeY6FsA5OlxfSOK3VjYC9dDQwW92UctWISriuKM8/ox6JBkfWH8xC
 3z0Q1zLr/5RdrOwpJcn1PgIYcToXM20MBvFI6Fc2jUBN6XOH3FQ2wng7KO3hmu4FaOeJI
 zi0+2OzCaO1My2/Qv9OaZe3v8oMFJ/n0tu33XOBmdyKeFIcaQ5Gl6UyiXQRS8ciP2Uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790235715;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:Received:
 Received:Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:
 To:Cc:References:From:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
 bh=vuk9EBybQLp3oWORS/2fZ6Bg8tAYtLSMmM3G36lY2a0=;
 b=fU/DJyQgOK2wssB7bwS4xHL0HUNbo0A0JyT6k4euCuSapbd+q9SYidZ5GyLeCXt5Hl2n
 /zaaGapxAOTGqsU51/Be9jaeAqAEfGWLPC8A2nWCReug04jIAkdl1kTZR4/5ZgU3En6OI
 Q9LUNcQta2I/pkoM6SU3DqS3Drr5678dWwPQu0SQrf+ZAXm1QRPvHrm2exRRKuM9cTpZX
 Yf36JuXCSZpBKM5c3RnKIRH2y3h6XeO6FtUb+9l3AOLuW90e3CsOX0yInZreAQZPN0Wme
 fhHMWXiwX6CO35ZSEtRsB+aX/MPHrwVrfO0OtjmXzGC00/4i7cSYV6+YeezxDeII9hA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=leemhuis.info; 
 dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256
 header.s=key2 header.b=LuS1KZ33; 
 arc=none smtp.remote-ip=194.59.206.189
X-Greylist: delayed 450 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 24 Sep 2026 07:41:53 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=leemhuis.info
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=leemhuis.info header.i=@leemhuis.info
 header.a=rsa-sha256 header.s=key2 header.b=LuS1KZ33
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.59.206.189;
 helo=relay.yourmailgateway.de; envelope-from=regressions@leemhuis.info;
 receiver=<UNKNOWN> 
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [194.59.206.189])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16CF460A4C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 07:41:52 +0000 (UTC)
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hr5F70Rh2z4NB0;
 Thu, 24 Sep 2026 09:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1790235259;
 bh=MygDLt77CAWexrvXWHNdRVysOGikwZW7aGyxat4mspo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LuS1KZ33CklYBOlwsAqs9/QrxI9dSGf8IeCa8Vx/JpgwBH7xzIy8OyQW1wwQYgKw+
 4orq/C+jHH+X4bgwZoi8dxvn+8b99Bayalo5pK03K5MOzromw/9OZ1548Rc5eMcwUh
 3iHSMZtrBqAp6KozHPLKJEq/wWIW+RpDdhpfgYyg9ZJr2k7Y8C1TOuCexXP3y89Up1
 XZBseHFEmdxEYTsZIy8UlwBs1l+g52VYBlyVaJcV2Y5oVz0Jl26gl+ZS0puowDEp8s
 etPQpFXc3Kg3FZ4Z7OeSQfLGp6ZH7T0DgvrUwC4B5i0VaY04HsIFhENXgaqJ2RbmHO
 QbTqhmFh5hI2A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hr5F66rPXz7xFf;
 Thu, 24 Sep 2026 09:34:18 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hr5F55zj7z8svW;
 Thu, 24 Sep 2026 09:34:17 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id BFD145FA13;
 Thu, 24 Sep 2026 09:34:16 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4f37f217-fb94-4d4b-a2aa-9df8069c62bb@leemhuis.info>
Date: Thu, 24 Sep 2026 09:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] e1000e: heavy packet loss on Lenovo ThinkPad P14s
 Gen 5 (I219-LM, Meteor Lake) after K1 re-enable; fixed by disable-k1
To: dima.ruinskiy@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Cc: Javier Herrera <javier.herrera@afronta.com>, vitaly.lifshits@intel.com,
 netdev@vger.kernel.org, regressions@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org
References: <CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=exMjsknXMN5Yh9A@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=exMjsknXMN5Yh9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179023525718.4133067.16941654907970362532@mxe9fb.netcup.net>
X-NC-CID: cGcaaXxBdAKNLYFFv6hi9U+IhSapvlba8V2FM/uAY+tvOOFUJOE=
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

On 9/15/26 10:57, Javier Herrera wrote:
> 
> Since commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and
> re-enable K1 on Meteor Lake") the integrated I219-LM in a Lenovo ThinkPad
> P14s Gen 5 (Intel variant, Core Ultra 9 185H) shows constant packet loss
> and erratic latency on the wired link. Wi-Fi and a USB-C RTL8152 adapter on
> the same cable, switch and router are fine, so the network itself is not
> the problem.
> 
> Setting the private flag "disable-k1" fixes it immediately, so this looks
> like another system where the PLL clock gate reconfiguration is not enough
> and the DMI quirk table introduced by that commit should be extended.
> [...]

Dima or e1000e maintainers, could you please submit and upstream a quirk
entry to resolve this regression? Ideally with a stable tag? Javier
afaics provided everything needed for this. Reminder, Linus rule of
thumb wrt to regressions is "generally fix them within a week,
preferably before the next rc.":
https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed

Or is there some reason why the quirk entry is a bad idea here?

Sending this as things looked stalled from here; or was there some
progress to resolve this already which I missed?

Ciao, Thorsten
