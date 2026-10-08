Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101E4CA6011
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 17:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A98B08134F;
	Thu,  8 Oct 2026 17:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0zvRi3AHcBc9; Thu,  8 Oct 2026 17:39:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BF778134C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791481169;
	b=ZtOQQmkD1+d8mvhZ1kZ7uNJTYxpfNLb4yyjIRsmLfUZzySIk4vlFrIAYGeLiHQrH0Lhr
	 um7HMJpw5Lx6J4AE0DUQW1sOQGUtGZT7C2uSJ84Q0TI2vYonLYn4SO/LP2Uoli3fLJSQ7
	 tnsnSA+pv8d72dr8efcOh571lXZI7AQ6N053dEDdWbp4rp9cXcdGZ0BzmSiRy55VCnu96
	 HOk/ChwwDRBznoK6C+DOQjVQD4cvC9yv1+g3lcR22ROKqjHhnNSpywo+d1ME0Dd+Cv6d/
	 QAsuj6qufS+VSRHodGDnI6Yih3LJ4OEvKB41zNMcAodIkwoKffDsYuZrOPKG4NfSlvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791481169;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=WTu7pxq6YIya02DCb6fa0iAW7Xs09TlijheiRFlgIMMYIGAYKK+ERMPa2mwifxJPLQe6
	 bz1mqQbgfiG4q7u7gl3YRypOQRocRtCcVWb3YxxWJDBHBHO9/xb1IERaikEoQSeSSdSXB
	 UNFJ2+IRCGBNt/dpXw01yCLl6JR3Xi/aHuinbfZog2yj0h82nQhQidcKvJIy3AetFclsy
	 rk/sFAtZofgoB07c1MLamctgknZDcyBY3xQ3w31sh2Admu7JdaRen1dzbDqqwwGsIMOQO
	 +qIUFFN3CmruNJBm4F5e+NVe/9V1PQodQmbUEKycJOmGmMdN8rWkOQj57S+/UALmhNw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791481169;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oxBI/s0c+0fT0DZ2no+9MbVVKYdnOd7dpE9y7eabxysDF8vu3VnH1URty7IG0UTxK
	 Qz00XfpJEvC3Prp/wuw4lhG9+ig2/hzAVEVqQFpc0s0CL5KA1spxJjT9WqUMfivj26
	 FNKGwhDCiJvd/Y1D1Chc+/cmN6pBSy/9LfT2K2/FKWyA1krgHNBRipwMCdtCFJ+Fjf
	 2tgE783rTirFF6ZKRgVcXJNGy3bq6Q2hliBNfaMc9UBEXzE9S6Cmh3zkT8cf2oxjhz
	 caUmF6srMYmeKZnnqieJHef8N8zlpIqdsu6OUebF4RiHqsCCL8WfI7Rf7lTjtAVGBx
	 AO/z6vzfpswjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BF778134C;
	Thu,  8 Oct 2026 17:39:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BAE6F1A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0CAC40889
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nExhXrko10MV for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 17:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0057E40888
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791481168;
 b=iLcdi5bD005nfLAUbPQM9x4LvBNK1hbDfEXwbGdVAozK5hkVrkEbL+zFVBRsIbG4U0Ow
 sPR1Mt2X6b+m9isuwYgTBvfRGXNUB5Hh1CE6FwcQyq8ruGjlfB57AXbsU53vVGNQXq9Nn
 aD6qRSZF42Ry9a4atojTerQwSdCluWyC5gd0GqSz981I/HUx/aDtJ6FSMdVO85H11c9Ku
 Q4qrRp6Klg4JKvrY6th3t3TF4RZ4OrNVrD50ozp4dQYu5LmG4JzBtnxO1WbE17FS5h2tV
 U+/vwiIsYIN3H8PICMtvWQD0Da8AdhSbKSK/HnO74/2MOSlWHTM6xvVfmxqBnoR+xMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791481168;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 b=oh0pgfNGEKjO3l+7HKsrUs/2YFVOnuLQVV/H9iisv/wEE4WCYV/Ty0jMkcYg2xWUnSck
 pz0YVI0Kfhw15goxVaTYxGKHRzLL3nZH382KPo6OBBZ602aZXteEBkBRke6gdZH9G+NO8
 tdiJIcv6aV/8SZHH7WOh9OtT36gF0/sIOF5TlO7x2YNNi73fG/V+pjHYkburMGrdfK/AP
 TFWz7oeoq0X7gSX177jhXYHVWCsz9e4+zL2vnnO7+gIZuZ0PImpeYpuVBVVIRrU0NQByc
 180B8/pQilgD4ROXWmU08CJfwvF/oCovKsb01q6XSzyrn8AnmwLYi/4TrmcBBCoWcDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=X5iLpbw6; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=X5iLpbw6
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0057E40888
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:39:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8266F601FD;
 Thu,  8 Oct 2026 17:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136D81F000FF;
 Thu,  8 Oct 2026 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791481165;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X5iLpbw6ZvPsVQcm1i9uR0IUH4lHs47JRJ+ZzUoEowb+hsrwsUKYAm5at+xwt0PWh
 HsA8ibxrjSglGQRjC4UwaQLl675aRl50XrFx371LXCsBE2X7ppx1TNvfAt6iG5h75p
 nalcZ2u835mwk7/muFfEaGpuCKbKnzptU9J10/Xf5qn+H7Hv/vbcqlQABjxKL822K8
 kZNeiRziAltZGDBIxCbmdfbZqSATLBllsJGbIc5rKkAOyGWrcCcCfAH9mwkzZ86kPE
 Z28ZgS71Lw86I2EDlnvi+QyaD3AVtj28M2t8nsPRVm3pa/DgSUbr2Q3KcHKJ6AKQVG
 j4uR4MmFu0qqA==
From: netdev-bot+sinfo@kernel.org
To: Brian Vazquez <brianvv@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>,
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Li Li <boolli@google.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
Date: Thu, 08 Oct 2026 17:39:23 +0000
Message-ID: <179148116354.2527009.2591065698849960120@kernel.org>
In-Reply-To: <20261008173334.2881475-1-brianvv@google.com>
References: <20261008173334.2881475-1-brianvv@google.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
