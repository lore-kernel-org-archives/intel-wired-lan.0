Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5C6072BCD
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gSGoIc+t;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZObSSxO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A75440507;
	Tue,  3 Nov 2026 10:34:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yCUoBxgGN0Bt; Tue,  3 Nov 2026 10:34:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B0D340359
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702054;
	b=JjR5OYByvBhOBgtOA+6LFybQ9FW4fPxNQZf73dDXZgweS8RN12lf101VM4zrpxgg3lt8
	 d1ODo1YxxW+xvcc0fvHJn320XMWMnM4tlZgzIOg0UdhJs/oTHWsDB5L2pqBGVprze/USs
	 8JvqE/2bNMudTvH9gvY7q3FZzjFXEHA8FHbYUgQ1DvfJ4++SnvVkVuGXIpwc0Awl56K+T
	 2aG++vu12QzhwQFIKoLTCetcYhDSwpE06d+bY07dzacik11gXf7Ay+KxCpRFay/fSJ2YT
	 u0g3rqLxVDY9OWDFjMJzx5duXX6vBprbSn8OuD+GAc+6xAy5qDaoTjmXk0Z+YF/gj6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793702054;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=ZWuSlESthQWiBkhJ1rHB4yAGgWVWZ9epfi++ZvHraxZ4s3XinoDJy5Mk4iiUne1DLVCq
	 dObTbkSOj4NOojdpM4IC3F1InGXmGMf7pOS4zbF4IGbggSvXafrJxmyLRwC+eGsFQen5T
	 svOf+WuTqQykdgD75G6RcAmh71jLm8WPvIHZMRVdgChSfdDOHkbeHJkOqcRFAJlzRMOCs
	 bQeasw3QZ7A5RjItoTk/Dr/1+xVYhOKDa/uqXfX59dDXRcuujVkOBPicSx45P7QXSEjxs
	 dpGgEmi2P7oaRMwHJo9kUFAre3DwWMWJwBYB9iT3nuqcFKfzNrrKs1tA6Fde88qbGVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZObSSxO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793702054;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gSGoIc+tb+0ayLyE1etlg2f1jkrf+HwZNZpRwm6HpZhhu2GuLCJoLbidmIbdiTRS8
	 OKJtklOv+Gvdy9986iHIbgM6T82OwbObZKdQu7h1kO3s5pBeHRabRt96d2Ou9bqRj6
	 yuQbmcWUIHKNGx4RWoIrdde1bbLayeP2wtM96Iy1dAGARTksxXcXiMqN9sW9SPOQu+
	 NooJMmbWt2H8MAdDNR7X+R+9ue0dEdsPPlcue4+eu94cdZEG9Puan8ksBj1ArqV5/q
	 apnr2VGXH6F6wz+/zD0w4VZXewmeIoSrwwYKebz+J2asTznuFlQK1TPGZUT5SWAQpx
	 Wg0takfRqRL+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B0D340359;
	Tue,  3 Nov 2026 10:34:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5114CA15
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AD1340359
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:34:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhCdQjBncB2o for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:34:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D3F840302
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793702051;
 b=SB8Ozr0i+cS/IQxnevUxRtJkQlGEVCviNfVsfskWqoQVUokBzjw4Hmgs52lfnVvjFUab
 ceDIX3txap/kNVNCBD1hPcOVWgG3TCTmjLP7MnS2tyDZMemiIjP5SUvvv1n+Ncm2KMhZJ
 G7QbKcFzX/hjoGsQO+19PoNkPaBpoYCHsvDoHLiw6dNPqM86pxKadLuYsJ7gOIRIW/0q5
 1F1n+LQGZifyQQ94BcMz7yxG3qfIFBo8tZD2QW5bSwRAUuaL6rdSCG2K4UfuqDxuow0wa
 q50a+lKl0MYT8b/gb9bABnZP6I2fCUgpWw7Iro0/yns5jXlO9NesVqBc3EwWnH35ZWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702051;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=fe7YdOz68kwAzAs7e7fR6V3DdjKMAMiL64wEJaTWAWCKGNzF7lyIJn93IahuJVv67yf6
 OlfWFm3IBzQU7tyMpOrx7rlsjpVkIbqRA6XyRRDIzPL3Mpv83icUGXXQW/E4AM6df+voK
 MvRPR68Pav+P7q2cmxA/q4RA+7CNlj2u+rJKK9/E0Bhhdpr3uGBZ2qgCYVH8YhLafY7xf
 X7zdVfQVNWrOyzsMEAYEshVWz8fTSr+jHmvfAHJjZ7obmRriShqMlEWlKuPHGUqqlyLNY
 hLneXtHKMbw4ngwGi/SlLjlX7Q/Nd6oEj2FLGGBm02fwKadco/buhPvsWFFWL/atrag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cZObSSxO; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cZObSSxO
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D3F840302
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:34:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9ECA8416EE;
 Tue,  3 Nov 2026 10:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F5B1F000C1;
 Tue,  3 Nov 2026 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793702050;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cZObSSxOSZQWmBulA5loTfX+tXhZMEE3HncvIzlvUELgjg69OvaLJOT7AoP1OItI8
 Mq0pPNt8NXUQiGF1X4dloCUIfVDBRpM0yJPv3TrpsrGTyNlRrfM3DmYMwxbuhUVk+I
 sg1CyNHXpRMlMw1I1hasm+pJwRtyWEbK9yPVJ9VqjQoW+nqtc67v5eyEPYVrikuZEn
 y2NhwrRWrrsH49yz2geNCfw/FkrmRehaYs5lKFAkDGyhT31OLs85hy2eNC516B+pYp
 oKIm0Z0ueZGsFBUBxdc+ToPRBaNZHNPKoNzIPWAQbhy3inLRkcIwPHjVi+BmAsr8yN
 Zaih7I7HPPjUA==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] igb: disable the PCI device when resume fails
Date: Tue, 03 Nov 2026 10:34:09 +0000
Message-ID: <179370204942.488859.12490720807858636370@kernel.org>
In-Reply-To: <20261103102849.1340413-1-vulab@iscas.ac.cn>
References: <20261103102849.1340413-1-vulab@iscas.ac.cn>
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
