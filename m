Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E7F606A88C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=7iFP/duR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOJotKJN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BA9F61010;
	Fri, 13 Nov 2026 11:03:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMUOX-1bJwhs; Fri, 13 Nov 2026 11:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C7F960FE7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794567812;
	b=Ygcy7bThel99pHOHD5pyl+Bq6rvvJDveGVmH74U16hZsHC92Q5M/pnXfH2ePHiG+GoK3
	 zB7/W3yvFKPxmC/HdnPxXuXff+eeplEwKM5DFdsss94mZu9rDB6q6+B2E0CO7dacBkwkD
	 KazphC4RV5Nhd5aEqL3GTOJV+Z48z0tKGCN93Hy2/Vo5xs6a69DllVL/pwYpQHjkld7Ly
	 zvd+7c+z5NcWkQtryotzq+qcZPjUKtLFSKO3wbFZNCrMXqoVV/bgw5PH4Qyn62MgGjvfx
	 hDs35+2O6g6xGSS8AanegYttgN1ScZbb0Cj/WjF2cle3PZL3wVBEIXTXF+jvmxnd4nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794567812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=PBYaMcKLcoxXHGyNjIpnr3laC3fwXexFcztE+WqHpTqfVFdKQ85rcBgObB5/+O7x/LP6
	 ++y9qwjPF7YN9Y4pXgw/nzCXLNm8E0KjJmn2Zg4uxN8M5xxENJJZZgXdk6ZZeEebYQGFO
	 SRsQuSJXzNHCl0Tk420wS/Iel+7/uWIuZhTEGJdMEGxhFLSh8/kKOSIqBDubOMzjGULnQ
	 vmgEtPIN9iKMAM1HCS5QLfn956449rN41XD86SB/HIY2th6BJGlRkysokk6A2W7XWZ0Jf
	 V6zHlvVZxwCZwV/FYVFevmp+PmBx5IptSAE/yZtejIGxGq4GdwiVvfDn859Aesqwjlw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794567812;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7iFP/duRkd7qKUKceYJ/Va33aR3df/dkZgZxfQxTny4427uwOgzpTWz14K+ZzI1jd
	 eWSC2mdVk4ZqS5PlrtQ6D1PHHFSGRTaDNl0fh9FaDVi5gYsX3tQUotUADwho3+EoZX
	 BYlcy6Wm9y8kSCsi8RlOsdB4I1K9syH13cnWPlxaaeaWBG54JaDdiQy0uf0Q/z4XgP
	 SeYIoMVUEJRBdKWhc5bXFudi+sqlDIGa2FcN4dW4tvJI62CCC2ItAUgcMrJUhlAUmy
	 jlJehiGi3USq6sfsgLyceyhuVt2YrB7Fr+uAK2tgcvdO8lyOn2vWBByjxI2d2iHVfC
	 XcnVjPeGYmYAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C7F960FE7;
	Fri, 13 Nov 2026 11:03:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73EAF2FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5968840D9C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYv57MyOGPPC for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 11:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ACD9C40D8F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SOJotKJN
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACD9C40D8F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:03:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AD3E43A8F;
 Fri, 13 Nov 2026 11:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B87A1F000CA;
 Fri, 13 Nov 2026 11:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794567809;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SOJotKJNM0NKD61qcP3wy6h4ZFy3nfecxTTzqxrrvpo8JEhjT+9xJELRreKFj5g+n
 Jar6SBPZknEnYlVxXfpeQshnwky1vfwycx3I4XPf3CN6G9+8c0YSk+G5q/bp39eHrE
 FCcafHeVdHdrZHKNUGfaXnjI4A73RNJ4YbFDRUmbvAV64j/r+xOg2VrZI1i5RqxJP1
 13W7Kr4v7hanyZI7YLaxXJ27ssK5r75A4Mh77roFf9ppcijqjfWYdEyUk+l05DsEUt
 maIxAB/geMsRV+AiKbVj3qg6+QS4XnO5NKsu5Dd6gIsJ1rjwbITXgwgj1iWI3D45Go
 +QqO6RfU1KTwQ==
From: netdev-bot+sinfo@kernel.org
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
Date: Fri, 13 Nov 2026 11:03:28 +0000
Message-ID: <179456780803.2168702.14752754098228150172@kernel.org>
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
References: <20261113105835.3821433-1-antonio@mandelbit.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
