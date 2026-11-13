Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B8606A886
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZvTewp5F;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gszlNEhi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 177A381D2D;
	Fri, 13 Nov 2026 14:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sGcfawOissUk; Fri, 13 Nov 2026 14:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C99F081CE7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794579822;
	b=SH1UZEmUeYmIAyUH0vaskwfQ9LJ2DWLKThoBhJ9LCGdkloo52gkgZZns3webx2pkmA2k
	 kPGf/Z83fP43mfn0yEGQe/MLW6RKoPMxb8q6b2HjFU9Fl6tRf/wlYKRBBZFupcdYVn4dJ
	 L1CVu3JTC5RXokcpLvqafhu1zzAQ3WxW7NZ3ZSe1yJv5z5fR4xySCzMXCKVa6D3bNIkjr
	 WfxEPAR16QCeTkmrC2viIjr4PteEcL84tipHzsuSHx29hyBwA76KKxQbRjtKPeIYIu7tp
	 NGFNsy7PC5q7ldyAOdhUNhos+rfNu86TO60G4wm44wNdVJ5Sg0mGdp0jmwwQOwrZAVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794579822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=f6k7jT/M8roKmDuvciLeq1BRPdQ6cwD8WpGUtosrzxFeccVJoTxI4xDv7DTagzpSy93u
	 19MRMPh6lH2vN3Z+AHWcLHUaZzF94se4CTv5EZ9pWPnvesYhrvg1wXaQcuAfcYievRg5a
	 KYvuxFFnnAXmuyHLLnkKJ3fIRXy35OKaiOKCamvHvdB0/WRycoLrbjebR5TSGOuirLWmL
	 k7heBaFWw5d7hUV9S9uAPD64bp+hw7PJMeMlZUFqRfRyJRGZMnPBLgB5p5boADygjNG4O
	 8In5uSuFrvafDZauke77dFPRDxEokkwNEhnxuuGHNNA2CJUKk+bgQBMitSZIBCRAvTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794579822;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZvTewp5F/ujsIQHkB8/hyluyKYPakFxT/VCgqTfhI4CCNS54viy7iJrJHUrgLMacd
	 Yfq1QqmsJiqjLdmSQD6SctSi0a3U+Ip51Ux0/Cbd3OHJVT/REKM/xwFGAHaQlrxVXC
	 qU+spSjzFSDJMERMBKkFuVfjKEHptBQMQ4qiAYIgWJM4GO4sohcA6pdllLaHXX6LYs
	 X8Keww5lBNwnn19PV/aAh9KpjQHlGbVMBr4HaC2R2eEFDPRIGPdnFjAitaklVuYTk5
	 3uLKaxTiV9aCm8AX3sX4QuHcDWYXx9KrNkmvA+zlWoyHHpSBlYYpaKQ7dKl/rUyqQ3
	 oTIjPt0j2nFIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C99F081CE7;
	Fri, 13 Nov 2026 14:23:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E59852FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 14:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D752860B0C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 14:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hqQC7jpZzNfP for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 14:23:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2FBF0607F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gszlNEhi
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2FBF0607F7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 14:23:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3165943F16;
 Fri, 13 Nov 2026 14:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABCC1F000C7;
 Fri, 13 Nov 2026 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794579818;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gszlNEhiMt2NPwzkdU1jTofTIZ9uH6MUZbI1QzUo3aECX40MMJdZWnqUbBj6nI4Qk
 J/9wPSdAXaIfdzzEP6KSWs+6JB8DPirIFHiCTbnG9855UEVQ42PO/YYYcWLXe0OmT/
 VfmEaVzZUjaNiVY7ireIXPM0au0K7aYwBw7tOq/h4b/ceKwXLIIGfR03csxqTHoF8K
 +l2n2nMT799fM6deSaNkKDe9o1nV0vQ1f5p87gEHAf9/xSMfokjsKpZKaP3ND7BsvB
 O+3rwfCUJdYTgWU4zXsSHymjbbaNmTJ2GiDmv4XhebnKVX9Uy1e27x1Lz/EecCvprj
 YlYJDb1axqttw==
From: netdev-bot+sinfo@kernel.org
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] iavf: Fix potential QoS capabilities leak on removal
Date: Fri, 13 Nov 2026 14:23:36 +0000
Message-ID: <179457981690.2168702.12614327056128514312@kernel.org>
In-Reply-To: <20261113-4e14e563a1-net-iavf@mail.sdu.edu.cn>
References: <20261113-4e14e563a1-net-iavf@mail.sdu.edu.cn>
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
