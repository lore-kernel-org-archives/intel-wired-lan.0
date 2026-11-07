Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F827606A33F
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iXcMGzdr;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=NXyTKsjU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5108260725;
	Mon,  9 Nov 2026 17:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWJUYvDjtfUx; Mon,  9 Nov 2026 17:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 35B31607DC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244746;
	b=UBsmKxb9lnbX28EIOnXe4oKd5a/AwCVdwXavdMVh2o0RIeYmPT9y3c+BK7r9ZePu6gT9
	 JaUSWg45N9dqcJT+UCcimav+uf7U7OznE6+/qpXjd9vGcFiI2BLrkbPzqicxh+KVFdOWJ
	 ufJrX4DSi/nXF5FbmTAH1Uy01Q71bi+0fYUx42wS6ycgogxL+UFIiMFJnytNYqJpUjpIW
	 RECRw4gbs4dVZLuGFCbqicgF77JHn2IbVURLAoNhOQCItHTbdR0KnwPvmApRxy8V9pvdc
	 DXIxRGLrTykXXwPTxO/awY+44fLKSRFr8MF5Vuez5omTFtFjFtze7DbR9Wo0kJPj1Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244746;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
	b=e580K4o2T5/p4TbWWjV+yo5tOSvWi6yb4XEzuecivZwThScyCDRhnZHZdoQX8Q4co220
	 z8NFDBRchBcFHBY+w28rnlOuNP4mMhdRtIAmsOhtQ4wsGR8UnZHV3Au+wcx4sv1Ienifb
	 1sypdFHLov8XJNj3B61L/+Jza//ax6vtu1eTukrgTP6Pg4KHGpTGhwxe11q/7IpWQkHCj
	 qaTVzYpr/1dQaU4CCDttH8wr8vCooEzoVeyAhZcMaUIxiIZBXaOfkIQfAbEdxqK47/+fQ
	 2b+SvXJgOs8pAN5PkrzH04cV3fSRbQzBLmpzZp60+i6rJFfO3KID5avp2651nDO7/5w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244746;
	bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iXcMGzdrjFH9VaFu5YAHsWgLrw551+6ENju4xPFvSTaOma6RPt/5AIbdR1hI4PY6z
	 85cUBs5nvwTK3jooNCi2wP+SJO0S2bu7ZpiSSlCKn4ur7O3oyRWmCFX/A+qIAGdW10
	 SMMyM6dTRyeei9GYhz4Qokdsr3nbZHKszwG2+V3rAu+jLcMgCxIx12QsLM5Enk5RlD
	 4WBdmsHy+dBP+e3uH1rCQMQ/etTLiHHHYoOFel4V+Ohh+rRv+3UeL6eVPbb8Or7AZp
	 XfrC55ot1uD2CS5JtkKyl9zzEHqQ9rrRL57u54DAZYaOaYn6+2FWYCY2U+/TMquE6F
	 h9aEgchGkxREA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35B31607DC;
	Mon,  9 Nov 2026 17:19:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 49232422
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46EDF406FE
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZPgHLWCgH_9 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 18:45:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DF1F406F0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=omar@blockcast.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=blockcast.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net
 header.a=rsa-sha256 header.s=google header.b=NXyTKsjU
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DF1F406F0
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:45:03 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so2964967c88.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 07 Nov 2026 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockcast.net; s=google; t=1794077102; x=1794681902; darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
 b=NXyTKsjUsZ2B1+hZbZXA05XJl9107HFdN0yeWpModfA4/0iHGt7TJL2X/fA1N2vsFr
 BsY+35Oy1+FHUvGxu47Jy24j3u3QZT0t7tvhepGZmGFantj9n7bqCjZ/F10XQ4vTTrSJ
 QnKYI9qODJYeRjVqq4PnP/wZSat6COUgf9oRQD/Hdc7BybMD06b3zoNgsE1EWdvopIjz
 2yFH+J1OrFgEe9A6QJf+kAKRzXfvnH81JQLLiAe7z0wA8NOllsfc69l62m7TDCuckCpS
 JepOm7ZZDQt6iWK8P9Brkr00NvydFk0u8I/HtUWA+K25Xj3CyC+Xpneq9ucXrHe6pNrY
 7Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077102; x=1794681902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
 b=MPL2FFRCOxU/893qvdeKyu6ZrmrkXohrFrrbTzWS0sbL9MvcK1W29c3CBb9mwzud+k
 MAjnt6hLw/rjztZ73DOgj2JqOB9mbiEin+5pl/HAfTbr3uCnT8ZBNnD6P1pxKcKaXQMO
 MSe69lUmklSv0Vql+QmUvlQyyLggHKZbpGCit2rK1sNVmT6YpW1X5oYh7U0KyyqidW+y
 9C+wOBRdINwq0xz9RhSLqPlFZsEdAsLgbsiWqFrIfvKzpHN/mkfanci0o/rlSZRodPkA
 54K9b+EeR3GQ9Hj2trlyZhiAdKHqtK3NhQKeIFM1qhcrx7SQDdKxhar6F9DWyjU5/IBi
 lRtA==
X-Forwarded-Encrypted: i=1;
 AL+hErFkSnUWHkK9O1Y1r5UwIpoHxhbvNsPn9Rbogh74J4JgjoQ3s9tnTMMV6z+9GBz9lQELuKdnLEsqNVjgNXhM2CE=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/sS91WTUCo2C+HmZWoKMnW6PsGsTSNnzXWXgfY4X055X4Jucae
 9WeCxm6nLD4wbQzLFSJ0yhJAnA3Er8ZohwtVaNcvAKK7YYYOSImckJVvf9cu59NW7LU=
X-Gm-Gg: AYBFou3o+xy3z5v/TV1u3oEEkL/KWedM/acQ4EcNMuBpdY+E618JkaNwtzmuWr8kuMc
 E3gi975jNGRFjWuXA9Yego5gkBcmUXtYaU7dU72pqMHEFGLAAjrQQr8kuBolmxIwy1XmFUfbtP2
 PKAZP1oQWiiuC/18wvUcTdj4Wk6aEITuxnAll+igZG5lgGjzf1syi6CAX8Ke2scgjNMfnWFSSrI
 0w5PzjmHYKYOPs+ZDHq3lEoAnBYO3WB12n6yrgTfEkVFV91E0zpx2sNIVMQ92f+bB/0vy+7HwQ/
 0yz8IYe8FgGxVuQ/W3U9GXiRfcjrBl0I842yXAQiMSRPrQN6cLA7RvKKsSA/0t6PxFNJbiOmNOG
 j18tFlcGzUFqt5cg5Rpc810UEFq+XIfkrcLJiwW+Z7Glm0f1PWNMFS33OoTDOzqx2F3BdcY3Jdg
 qgFvKMjaezb3EPKkWKgNX6cqef0/j1PnoP1RKdwij28vVccti+7FfK0emOQ7IN+qRn2l/vbxfTg
 0Ft+DxWchE1rAueg0Yw4Co/Ha3azKIxtHYEQvxgW/mctOnonLdpUCGB1Y9SlvPfx49N08gdGseG
 kQouAZIu4mBX27Np5rFhglZBl21rbewMhS51hUYvCiSF6oharGZ/e/vci6iyJXw9Ib2xF20=
X-Received: by 2002:a05:7301:1601:b0:36e:dd5:fb08 with SMTP id
 5a478bee46e88-36f773f7c7fmr8246456eec.40.1794077102206; 
 Sat, 07 Nov 2026 10:45:02 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:45:01 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 brett.creeley@amd.com, sgoutham@marvell.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 Ido Schimmel <idosch@nvidia.com>, Satish Kharat <satishkh@cisco.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [RFC PATCH net-next 9/9] MAINTAINERS: amt: cover the offload header
 and netdevsim provider
Date: Sat,  7 Nov 2026 18:44:37 +0000
Message-ID: <20261107184437.2783174-10-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107184437.2783174-1-omar@blockcast.net>
References: <20261107184437.2783174-1-omar@blockcast.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 17:18:54 +0000
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AMT entry does not list include/net/amt_offload.h or the netdevsim
reference provider drivers/net/netdevsim/amt.c, so get_maintainer.pl
does not find the AMT maintainer for changes to either. Add both.
tools/testing/selftests/net/amt_offload.sh is covered by the entry's
amt*.sh pattern, which the IPv6 outer transport series adds.

drivers/net/netdevsim/amt.c stays under the NETDEVSIM entry as well,
through its existing drivers/net/netdevsim/* pattern, so the netdevsim
maintainer is still found for it.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b01fdeee6..f6d5b471f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1404,6 +1404,8 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 F:	drivers/net/amt.c
+F:	drivers/net/netdevsim/amt.c
+F:	include/net/amt_offload.h
 F:	tools/testing/selftests/net/amt*.sh
 
 ANALOG DEVICES INC AD3530R DRIVER
-- 
2.43.0

