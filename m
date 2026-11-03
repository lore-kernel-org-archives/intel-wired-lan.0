Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20016082BF8
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UZiEXOMn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNWRjEuD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF53E405CD;
	Tue,  3 Nov 2026 10:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhFtcgNcTY06; Tue,  3 Nov 2026 10:09:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 174574055A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700585;
	b=JHAyD737JluP17UL7rre/yf2V+JbZv18kXj7nlV3piLeQgf7A30TAlw3dXDMUSc6VJKZ
	 8ZNjpoukisNVQ0NBlFKanAZB+BD8fT/LF0c4xpogWMKbLNFmMhyVZpcyPCi0uWfgRLrKO
	 i0Fo7Di3eXGLaIVbfNct5QEoKRirDxjlvGgy62FlFLhpMIlOU5boUAZvJFKgy0DCpFblv
	 e2pRzHg0rDF09M7XPttidgz9ZUQcVIvkyXn+Ec65Thhl1yjAyl8aTdPVDQs9UBc1UPCgj
	 kMsT4B5grS5JCEW7ZuSMnHP98ghim8p2pl31nWeYAh4ttoMp/xwxiozMly/CE75ch7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=BYmHt9aA0RvfCKoy2BAC62aALU/22OuXFxI6D5z67LfA1dis08aQm1p0eXp1IqvaMSkg
	 TJQnmej2WqlZiWwkw9TB8Ja0VqtUZy/nf1ngUMBpD2SbFJQNUYI5WcrqIY6DO2EYCuRO0
	 epZCNBuEo0qauz0RI2TOykRus56byElp3Vwt0hxZOgvLS91p6vA3g+/IAACgx4jZWnx+D
	 ovKlN/BgFSdlY41VhoYjt6Hwcse+FVO4iGzWOMYtT5Us9MZRqV0/LueC+4V5CbNvD9wLT
	 cLTLmQAdu/falNFcmMPRc1ACS4BLqvkCgSasF7EOLmJ5NpJniTmSUIzUYStYLYriZZg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793700585;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZiEXOMnGn7rVXaA0lru7haC2JgCxYA6ArT6IBy+Iar3e8dUgmnAij2tf/LbdclU0
	 k9ksBcrnniuMGW51EykzK582g0MiPBbbic5eyyUFhF7xn9yNLQ555DV+RyeShwB/8E
	 MnYW8c1ij/KnHaJyboQIMXNx4wKAiLSbSXpV0jjkrHjMKdDxbXTezhaPDUdi8opqmW
	 /xn97gEZ3p6UOoQzuw1hbktDlBkI/eukkMOLOE8Wp9uYhGHVKiJ1XWNUGxPUqRejbE
	 rsUS5R9yX2JcLRYGf0ep/coHtgOTZICPCFBgeLE7x6FjRupFPsk439o+P8Z2RlsCWf
	 TA7Ttuija1zBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 174574055A;
	Tue,  3 Nov 2026 10:09:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 803E9356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6680340080
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFZKVamiWJ4x for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:09:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 87DC94005E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700582;
 b=PwG6fjTR4Yz53SyaDktU0DqoDeBtphI9fLtXkZ9l/p7QJtnMuwJdWS8x9o7ZrnhxuQjQ
 mmGM45ooRYKknv+nkInic/kWTdUx4t94GPqRrjqlJ1wOAA1yY4TqazN5djjpJ+WdzwZAY
 +6pOgxLZ/mLbpF3S53m+p3aiGpoHiA5CdkIUHrjgZLDFHMuCmq4J3rJl9rk5JHzX2A4SW
 9Ub/ma049dvp95l4XKn1L4iXKEkY2iQsZj10gUpI4c5Y4iS0Ua+I+KKIZOxE2ewtNUNmN
 knzc2o5KedO6uWPjGBq/7bJuFSEl8V44oL/6V49ShRh5WzY608+R0Q3Be1hH4NRYn1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700582;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=ILtLmi3Y1qcLEPnd7dvN6iDFnbVQzWzVqO754QDHPdd4+pY3nMOCLYZ80FM1w7N2VQds
 t/9nZiTMubczvdUYcCjywdYqOmPLwMuFhOwAMpqOkVkmtFwDOe1DDz4Ck9/TLszVHXAg5
 f9Su79C/oLl1L+S2hF2Nh6hXnZ45q0MPMaIrsDxAUxcyPLZtge5T58uTzVR7oiPhcs1Wh
 0zcIy7GvcBQkScX6igpmNNqBphu27W58SM/85USwk8NUiPHOq8GkNUa29u5MsTY2pgk1X
 VfCq6Eeh+X1ZhlKGmqSl2/5yJdJKNDdv7WaVHccL+PXvWwappykdOdrSY0lQxLbjz8w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QNWRjEuD; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QNWRjEuD
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87DC94005E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:09:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09979605CE;
 Tue,  3 Nov 2026 10:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147B21F00A02;
 Tue,  3 Nov 2026 10:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793700579;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QNWRjEuD5sptp7JkoDwFqra3mErx4Ycq7rBK2w266qBK+EJ2t+pZDJpoUGGVCe5kb
 +JmnYwzVGG81Rap37VKkNj3kPZzDitLZyihv9tupnygzyQ4Svu3XCvIOk9O58Z+wgr
 nbBYhftIg6SpZ0zDry++0CBsTK3weFmOrGacOBOm7+wAzHUpSlzVqf5UYr6OVbsb7c
 fW0wbtnwFDq4WXCruYBC4RGVTAHCa5YIEt9GpmJ2dKehZ3pAmMmn0lNVxE2iGv+03N
 QNg3rCd/qCGpfq0zMOXrzPB10IdFOsEsgperLO8XB8ISTi+/HYpxrHMZrSry1BGJbJ
 elkOag/EPsWew==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Date: Tue, 03 Nov 2026 10:09:38 +0000
Message-ID: <179370057861.488859.14762779860331668203@kernel.org>
In-Reply-To: <20261103100534.1310039-1-vulab@iscas.ac.cn>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
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
