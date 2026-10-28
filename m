Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641F606A325
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3bENMJRU;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jm+JVDtO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 795E780ADE;
	Wed, 28 Oct 2026 09:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id barjywSCFtDO; Wed, 28 Oct 2026 09:35:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 940D080D18
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793180117;
	b=kiC/TuG1VKpVqOfEfP5kLRXawjlg2TqInI95MtpXBsB8TZkBExW6CCH1obzP58CR3Mcq
	 UwYJi7BGdQtFzikPtGvY04ISCpOHOeWvI8TX3pPUJztayixPndyvi9sOciK97gV42rceX
	 Gdih680D185DJOC+7ejiLo51kpSpGa42XN0Ny2zSxPx5Y2sgf7FQk6O3Xchk0glgIE9Pt
	 ydNAcv0HysE39mJkbeqiksgL+Bubam3OE6oxlIPWOWkXktGajvpXFq25PflRqLudX/rxz
	 RxxDxJY5q9X9OIrzPNMNBHK/h3I6tdsw+1v1LMe7bjfZ7i5zLqrk//9ndiAkc++jWEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793180117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=eJhlEEsH1IcZOwswlOpc9VHcZwwyaxrOfhUPqrvKdMHaKzqhE1ivA+DtuTbctYmchZuK
	 szqdL3alH6BQaoPAhEpRtMOJG+lUMjqLJagIbsKkf5qyg4C5rHLXuHk5DMGTiK4BqWiza
	 VgURZ8mHwdyAw2ab7jwsCQFvwFoD8Tu9CHdNHpkddl18WIrJkQ9PpejKUs/fIiNSz72hh
	 qu9PlaD+Pu70o6w6Er+pZx74WpQbn0ghV8O2U/1HJWyHM9hjAyzRELJRjNHYoev6Ebs0f
	 DodxUQ3wKV+JA7tXXbO977fXpiWhuuWH4mhvGjnuNAKQrM63YS9zjTGG8I3/ZN0Ur6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793180117;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3bENMJRUES6vAS1T6cXWag0Qp+/bKHNccYpSzfDYjQzd0c12q1i/SbkIpntEBQGMD
	 0TtJEJAIdVyugEoh/BLhVFa1p75v4yCMYoEmQ3YJMyKekwaFz6X2+JrmsPc0282Hob
	 5LyqotGYFS49hpJsyVliOUXtZvUUT0f8P55a0J7EEqdjU95DcVmEzdHIofwTcuYp2U
	 XPNl4KOe/XlNr+qVZAPDsChoC/nPDuIBwLGXRWdZq6+YtJ6V7pqh+Am3cnzmVGugwO
	 9hIVp6KJXkKW4LMPDjeG7DtGLKQ20uCQ7zInrWKgNHA8VGg5ZiwPSCU0uZsT5ixPyE
	 wLS8DClf7Y33A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 940D080D18;
	Wed, 28 Oct 2026 09:35:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33550235
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 09:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 250E24009D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 09:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sq7n6D90SUCF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 09:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 650EF4004A
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793180114;
 b=gSaGhuCw7/Gronvqtqter7Vp+7qqkHxFxSttz/vZ9jP8LMYdesdnDBVtgel7JY6DRG2C
 4s/wvuiYjWkBnl6SK+eM3a4zcOQUmrjSwHP+tKAeqKnAk9VwmPiSgEekccnwNXCPH4Nnt
 VxF89MHmofElKjWl2bF1s+3rqpNs/GLA7WdpMAIP97OchMcMy0W2ZK/Z10GeRYf/hIZAu
 iox31eYcmwOkONlPSzRhZV2THj8BuVxs8QtBwzZ5uBYcT14HZVkiOT8/rKL1YyvZwXp4B
 Iv2YVo11Cr/3zPpnGNA3zLbG9WlqtGcWpJbE62K7FMDxJn4dn8dA1ncVQDi8ECRIoFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793180114;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=gls38apY/+W2FsadiKQKzMysiZ2Qnl0fPNIYSoxSf9JaGpWSJB7vk/owbq/noxT/9Zgx
 JmrD/T7nwc28EdNij7AoH7BFoB3QSfqH1VV+LHPy3hf6hC2vTWyzCuXGx1UVBMemjKJi9
 JJDW36vnsMxhwPsrXTqn36OoWEGSc/7sdeFBic6LdZ97fC/Bq+hjxek4TokrwBxmDJLrY
 b8Qm7IyozNY6ja1gcDPfrmc4iGHRAK+DlZ3cR+zmTUx63pBapIDY4rlUSzuiuE+FgA+dM
 J3zUAYsPQWYrwmAxH5P9EShUWdf3p1M3SloaDQflw62Dhe3a2mjYXQWBqMG0TyjNcsA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Jm+JVDtO; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Jm+JVDtO
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 650EF4004A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 09:35:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7390140640;
 Wed, 28 Oct 2026 09:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17091F031E1;
 Wed, 28 Oct 2026 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793180113;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Jm+JVDtOzL08QE94VDIdTbBTxhISjHMjZYYx5bAEmWItmStYqEAKrV3wRjEmf62mz
 gFLuPEnlP4/juApeHr/V3NPuliSgRr4fv76OzlrqFyeQHuDp/tJqKVB17+Om5bmXRZ
 EOBBk0uxGCW6pOrm6gkFbfPV9S+enFkBGluQhGpa/V1cQTehh07QdIQjjRuWM/5V44
 hrKoMv7XeXF7hbkkSwQjQafc0vmXhoKIoZsFIlI7zFxGZb89XA7gisd6ZLzGJVOAXQ
 SwkwqBhlCPQTjop53gfZdXKPP2Mc3EN19FR34SLHNLlWFy5J3Cg5tI/ohE4a2fnOu3
 C21DyAb0W/P+w==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net] e1000e: close and reattach the netdev when
 e1000e_pm_thaw() fails
Date: Wed, 28 Oct 2026 09:35:12 +0000
Message-ID: <179318011223.3327.3243826211150431182@kernel.org>
In-Reply-To: <20261028093117.2313438-1-xiaolinkui@126.com>
References: <20261028093117.2313438-1-xiaolinkui@126.com>
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
