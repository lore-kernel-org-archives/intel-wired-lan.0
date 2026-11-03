Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783060A2625
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pJT4XXLd;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZUIArnY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2559580DC2;
	Tue,  3 Nov 2026 10:10:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uivpa42FO9r2; Tue,  3 Nov 2026 10:10:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D1CE80AC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700620;
	b=hpMkk0zZotwgHqD4gU24Wh6HQd1BqAYnGNzYrTBcpOraAwwf12p8DTyIe3yHilKcEkmQ
	 5I1F+IPe7mng0/RWOZIDxOSOGgNNbYAITDAtrhOhqsUp35XzPl5+H3im/+L7MCBjwrogx
	 bY0Yyn2TmsA02QaKIVgzhXDIKRpZC8NKnBULcLZGcZpFFKf3hZDwAfwT/3CL6XMG/DHYY
	 t23t8E283nW447AEON1qIAHvqb63HyOvt5jcUweycOfHvQVASCSXliX1Am2gRMg2Ycwoa
	 KU1nhUrwUUQYROdJZpu2KHVQa1UG1c7WISO8uijaid2cKB/lKzOCWi/mvFgjanYHrGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=bLCdZIhMpuceGvqKarkZaUNSPUOPuFjvt9Bv+meZVXIDXSUuXT2ZAMBQs5a6KBo20EPz
	 E5KJLtqpaDzDiExDnwp2aJ9YSgx0h54F5uzMKL0kt3Ry5HEDqCfm17/ZfRXJAtm141Inh
	 P9WoW1xri7ly73dZKYXnbNrRyVKRuz0CXNez1uTxSYU41MIHoQzf2WvGqi7+N0Kt7FYNA
	 rFMA2zAN/Qd0tSLBcF6It6Xwr0lpQYZgc1lf4jY9pI8ZUqxKdqxV7uPe2hmvYx/PlqzOO
	 cO+PQw9gzLo9EZgKR6XYoc7YRYv5YpEnxCsiIbEPGs8vFE2KH5F9BF4C3CAzD4hqaAw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793700620;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pJT4XXLdgvdcuCSfLJlLJlBTRgw1fl8So0ufc4wJ9VWMg7AXf3nV5JurymMGpG1LL
	 +5saHpOfDZW0ZlCtOF8hoNM81TY80e76Q9B/5NRq6JiRIKR0GU+jvXQZRZVMQBTuTW
	 VV5DbEnXjeg5yY1tJKigqO3vdVp4xK7wEmXECQbxzNevG1xaFFKM9uYkQvFFVHfwB3
	 SpyMCE1M+h6lOgdSLdvx+MZrwNenlvR2jm4y4ulHIfP5o9v+gUfG2StzPii7YnVNKB
	 zDTdAnVcwXpUSlDfQmvWgM6NZNnTb6bC7WXELiFz+VvCseT5K3WEQIODS3wej93hDl
	 /N3/63oqh6BFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D1CE80AC5;
	Tue,  3 Nov 2026 10:10:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92AD6A15
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77E5E40080
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a5vY4iBhAvYF for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:10:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D57184005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700618;
 b=m9yx/Cz6PpW77L1UJ8hB3s1HPm/sAvyjOJ2q4rEbS6in7S8NUw1ob2UHHSyjvZi6rAVT
 47oMYdBhT0mAzJF0HKjxzGZnv/mht2I8PuiDqhnpc3ALvzLcnYBqpBZWO6LnkJneqDDcx
 TT/qzb0fdGSTNqfB4URpr/AnzuBSCBIX7HaEv8Pf4Cb+o/Z6NtsoM76W3uPlQBP3uBjgk
 nwvr4SzGRttujnVFgIpCfm0XqWyQuIMAMNZ2BeLPQZE62ce9v1XaBFu9R7B1Evnvmk88i
 q8m/huXbGwKkRwD06atYa/p8OIYNIWrWyl68l2h1hGFZvLcY5fPRUEhOBzOmCN/+GMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700618;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=khCMTypGVWuAC2nt5ECalC+qWjiqvF1U/b3SKIcpbH+RJSSf4L1pJpcp+IBqBrHaZeZj
 WB5mQ4KcbSrC5QR6EHe4KEda6+RmsJ7S1cEVg3P1ShmcyWuNqe9CvbGWERSnyUiD/xMe9
 l28f70fpOjLmKKoUG2rAqoBf87SGNKkvdmDTzPtdZRmvjClQshTZSDISTGu5l7RTcYhZg
 UFIMgd3cQ67qGUYZwq0/NzHwmuwuCVoKfURWPxmd+5OR0PqVqaUgKxdKg/7comRc3Ne+C
 q16K2Y6mmSRkkbCIJRfiVWuPT/4pYgqMEk3etaXXsVAMBRgrDMpKt1SU+i++eci6uGA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QZUIArnY; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=QZUIArnY
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D57184005E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 18A8B417F3;
 Tue,  3 Nov 2026 10:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491371F00A1B;
 Tue,  3 Nov 2026 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793700617;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QZUIArnY5+hUTUWcnXtLxF8u0oA+xiayejYX5MIG0WfCavOhWOs9kITZFHKvqYxHq
 mWYZEvditWgCZMizICpen7ipc5+tYwTC8g1g7K9Pt6MrB8RA6qZzPAcborUGJBHZ+w
 SgYzPxFeST8sYgu2WMww9lwxhrgU3QKQ304k+tbHDGNSVKFEbWBQDUtvO+sfyQWLGu
 9XmvlJigcxVnGIZ8J/jKFLKecy+kDQBR4nT4/wmx0ZibGtPpVcUnjWAmHMqPP9ypiY
 6swSTDEAVMK1nmogPLAj9V7eE6Z6RBYkuf4Ny44L+9PoEAxtA6QSNJM96wiMuS9wLz
 fs93If4Qw+H0Q==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ice: release the VF reference in the switchdev trust path
Date: Tue, 03 Nov 2026 10:10:15 +0000
Message-ID: <179370061582.488859.13591313498954037306@kernel.org>
In-Reply-To: <20261103100530.1309907-1-vulab@iscas.ac.cn>
References: <20261103100530.1309907-1-vulab@iscas.ac.cn>
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
