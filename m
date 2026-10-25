Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09176606A32A
	for <intel-wired-lan@archiver.kernel.org>; Sun, 25 Oct 2026 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sorqWXJh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUuObwtx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4CD780E8C;
	Sun, 25 Oct 2026 06:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nBDzTYSb8ge; Sun, 25 Oct 2026 06:55:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F5BB80E58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792911302;
	b=cfugrSb/O2wVPb70gvvQGWqolB1K300irdQTbORVxZ8XVEGI5qrS/762T5XuQ/uHj/3/
	 8jVNxTCfz9UhDYE/qILhYGgfKFOOo4e1C6llt4ssDNoVQ8oCVmspjcct4/FQvgsQlaxt9
	 fAglld/qXz6NyRqXpGCpq7GPNGliRHG5nbg0n0DDErjhKLz3sdjUJUXHkctKofLl92uEQ
	 dc6nnnRJfb/UpV77tv8piLpcDBzKInIzTjLf1l9F4GFGKCLZedYA5dJfuoLpzkLELpSUB
	 9kd+9YegBurdj256XtyqNO0VjY6WPZgsGkMwfsqz5WgXU9pRQaS9zvHAKoUrZxvol0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792911302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=MvCCKn+HWcfbHnmfIqixwzrsvhiY9lcnw9+Yx2wUyZAxZkrct/EiDe4hILCWIp59LYQq
	 gRHhBwv9mEgTADhhA7yPW/WVc8/MTy6jdcrn51CcKeBVPje45FzoZtxcV/XE/P8H/lCgU
	 bvg7vnpjZgCXdJsWJ0ZRDn704ZOyMZlXFuOu2hFBV487sGZfga4JhOHAs7Nct0+9MCBzf
	 +LqWlvuHsJ3Xbpy1yZ+Uj6duquqHS2qFsHpDQfvkuJeSnQQf8DI9gkmonNpaXPG15H0uc
	 aD0Y9M4LdwjLnUc6lVL9CFZwSIxkfqiYSAS7m1yDG4syLoobopd0E5M03TNpii8de9Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792911302;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sorqWXJhevoj6TXeifMYB4hwmEF3AxeqFSOVP0JoHAj0TfhTAp2oYY+3w9w4mE3bX
	 ohBGAwr2Ug6YWDg2aHwifU+daF6GZAk82YuZR9glELhTJBZBtJCsKQyJCcAtoqA/Mq
	 9UQVnPVsqoLBqg+7HXAQhVqE76DNjatrcNUaMc44DR0tE4i3f1Ni49yH1ZPN7+dMsl
	 pwCQbNiTNlZ9s3WzcBf1yugifrnBG+XhCaoqflzAPSXzIoCH9C1q//mDneEqYK2Lc6
	 sPFTaNYo5yl5/gBt6r4n+sBHAREFiThYg/js2t2oEDkEVI3gCX6sS2tQmM2vBcum6d
	 kPK4YTzOVjjvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F5BB80E58;
	Sun, 25 Oct 2026 06:55:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C9123D9
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 06:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62A9440653
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 06:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkzTTvW0jPD2 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 25 Oct 2026 06:54:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B108640648
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792911299;
 b=GjNZgrYGxVzFoOgP0N+RIt3EV1oYNOOGxEksqAlOVK8uqzY2GIMqwpp7JYccYf3RJgtO
 NJe3DMoFHtxBlxYbS5lFfiqnZS6mqMZAOIMC70Tni1VSFpmD/Kxfzn+vT6w1kW4P5qcBb
 wXfLtZibslG4vj0NP6mdgz1wC3NKdv/Az35CL4HpIERLqvicfNEAJ8XXG2IEzHuwYye0L
 0j7yDZP1UQuOOBewSdz4VWg0hwFGYE7+HPmOUZ6FxL380FmL5TzubD2DAtLUaR3AGrYXv
 TmCaKI4GH4+9s/Q/N9UHgbmfcsP6Vclp5Sm6xCgUr1V6TuvmjIUUpallFLEjTraKqyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792911299;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=g6EaeLbde7XJY5sDVklXxscru95wNe9WW4vpCLAsV8xCwtdFrd8I+A8TIW5fUxWVHWwd
 p5Rn0i+4knzR7dStDJjPjeT2JPEZKoxkl0ayTWk7xxazUBZyORJruUCU1nHqGpWYSIC+1
 ygi/TzzVthyyfuAN2hYhv7HVohRhfs3o3vn/RqfpdFe7LbYqzNmfTvatJzlYBYxVlWPAG
 EQOsWUD2bhMQbVwsasmjPveIGUa1mvqUx8GdB6K/2Dnkj0BvLkbhAI74rGXaqXL0+NXVl
 YDUEJeu2HeZOCweErmb5YgyQhuRLYcm9mGf384oprQTAGaTOM+3XNfy1dkdsqlXLtSA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eUuObwtx; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eUuObwtx
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B108640648
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 06:54:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95A13600D4;
 Sun, 25 Oct 2026 06:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC381F01825;
 Sun, 25 Oct 2026 06:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792911297;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eUuObwtxlCS5ixSyxR/x30C7Nq5o4ZSft39jpn9B6wt6S21EsmPwPqoZZpk0ftxSR
 vH3dXWkRzP08YTm/2ZBS/VXU+RcJBjYVV3ExXw4AarQJ2FN4gAhrsikGBTiKF0ajpX
 gMe9eW9gPMv68NkempL4taQIZdhI10ynO0Dmt5CUoD3ry6Bn3FKMvc0dF1N79zC+Oq
 dznpag+W7uzKpEM+h6z4rKmSgGAgh7VPz6du/9qarE9BiE/aERNzHXdUdZwJSroQIu
 3yVtomi9E5QS2x4B1SYGobZ2JtkAjwATAKlPjx622L5SWSpdWx8Upqb7tW1R8tQzCx
 a79BtE+4LLpSQ==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maciej.fijalkowski@intel.com, vedang.patel@intel.com, jithu.joseph@intel.com, 
 andre.guedes@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Date: Sun, 25 Oct 2026 06:54:55 +0000
Message-ID: <179291129544.3327.5095110589717245850@kernel.org>
In-Reply-To: <20261025065154.2037149-1-p@1g4.org>
References: <20261025065154.2037149-1-p@1g4.org>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
