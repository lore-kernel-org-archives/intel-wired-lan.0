Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E6606A337
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=u3Iv4XH6;
	dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=mODEyCM+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41D2860A67;
	Wed, 18 Nov 2026 16:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nMw6StDOvfc; Wed, 18 Nov 2026 16:23:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E3AE60A8C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795018989;
	b=eKGDv5r8/G8YMWxbrFxUbsKrBPMHuRfh/ge1ZykiqTDHHbtoOrIArflVbr4M94Jf5R+x
	 2VCMPcVpDawr4X3B9l97vBPUC8U9OU/tBbLlpvR3QAGPvKoHG0Ar+Al7pUFsb/vBU3yMF
	 6TLv06Yva1y13hQSlRVbuM9j72znyMDscJno6qot7a6sM0KnUNe2u3nMsj0fZIGxccsza
	 gjKwgYUcZCcVs/BVuPobtoJWeq2EuTTgVl1zeqdmJyT9H3B6CpWUYNeGRwf9gqeUEepSk
	 WCFSFaL8zXmO8o062Y3IT5YEIDL0kN+ds+0RoOC/MZbNJoNrqV4/20uKXMkXMrPvQUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795018989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=H65MlX7VDMs/QZf1f9eG5SUm6SNdstMBTp7c2Y28djo=;
	b=qZPc87I18AB+CpSgVMFPF3L2wb83j+wkt/BGrbMQPe5cbQ984BdSN1T29whZI4WSZr2w
	 UjnX2GVZmYnZ4YCt4+ONqAZZUMcwHKt7/uzcrTB+CxRLuq7LY+z3Ry43YqgvgZ/PkFbaf
	 51zA0dikVyQYGAUTLNQ/+umA1+40aTCJc9pRXQ3k3KjBZwOTV9ZSU+i9IOQtUbn8okU9o
	 zxabOutOMSKWKzPIeptxIHgVOPJ9aAMYzuc8NfYn0CLkLgW8inAcYyW85v5UN4WG9y1N4
	 mCpxEsRTnTUgK5Mr0d61+iiVxAOKaCTTLp5X/Lwin93BHrLE5nHHt/ekV4/CAvV/Q1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795018989;
	bh=H65MlX7VDMs/QZf1f9eG5SUm6SNdstMBTp7c2Y28djo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u3Iv4XH6ZjozsvcUPX7t/7F7KL8zZ3jGax2rQBOIyYUdqyfBY4FBQ8ExF1beq8Zn5
	 CW0e+wFxTOZW7WIw9TfdoeKBoMZ0EOnNIpX6/yHFVVIoTx2GXfXvj75a3AvXZQstNt
	 9uxJjKWsFDgdkem7WWs4evQan6bZeMjEHAsAPrFtGqnMUGH+toJHhPbjBa1MKQJG36
	 i4emhkOIHd4dDxLBdtiaeFdM4ntR/6z11hYv1KpxCxwVHXexJ/yuhl0Rx3IQxFWzt5
	 S1mpfrdYLeoB3o/5WyyIqMb1/jxD7jeDsWaQmXGY9XtlFCflPCzGlAtmbL3j9I9Voa
	 eMK51VePYdHHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E3AE60A8C;
	Wed, 18 Nov 2026 16:23:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 316391E7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 08:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17ADF401E2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 08:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNnC3RC9mRTO for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 08:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 77311400A7
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=51.250.56.165
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.250.56.165;
 helo=smtp.ideco.ru; envelope-from=a.kazinsky@ideco.ru; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ideco.ru
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256
 header.s=ics header.b=mODEyCM+
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77311400A7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 08:00:43 +0000 (UTC)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 0B8B026BC1;
 Wed, 18 Nov 2026 13:00:41 +0500 (+05)
Received: from [192.168.1.75] (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id ED0E426BC0;
 Wed, 18 Nov 2026 13:00:38 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru ED0E426BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794988840; bh=H65MlX7VDMs/QZf1f9eG5SUm6SNdstMBTp7c2Y28djo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mODEyCM+RnWfkQD3D0L7RPiVM9y17X1jl+AEmaew/5qkbmQPln7heB3W1I9zluFOn
 OuQqrZ4nNyJ8dLBHHkOQTqZMy4jfQ8HNLgQv7CMCbS7pz3mYcKh7Uhp9f/YJEZ4KBp
 djCk2Dkt5MsDG7xsVGV/ni8IG8DLTItnx/yHy4wq3ES7VP+Fro9H3Irfx7hKPnQBS+
 XRZom0Ap2YHRkbdYwIdYROJ5HbBCneb2WWhyJFvGhc9zhzc50QQFmqYMw3u9mgsUiV
 Rq1pA8q9jJDoAxs3QfPxkBMNbbgkqLvDlfOTd1H+kJoK2w6Ic0MEoJLqxY8UKDVz2I
 vdP/70pwXmsPQ==
Message-ID: <a77f7b69-89a3-4fe4-8ac7-4f5ac86ba2d4@ideco.ru>
Date: Wed, 18 Nov 2026 12:00:38 +0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: Avoid tracing bridge ports after initialization
 failure
To: netdev-bot+sinfo@kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
References: <20261118074324.1583964-1-a.kazinsky@ideco.ru>
 <179498811103.3291.4517029211414094145@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JrQsNC30LjQvdGB0LrQuNC5?=
 <a.kazinsky@ideco.ru>
In-Reply-To: <179498811103.3291.4517029211414094145@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 16:23:08 +0000
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

18.11.2026 11:48, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
> 
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.

Hi!
This change was not tested on real hardware.


