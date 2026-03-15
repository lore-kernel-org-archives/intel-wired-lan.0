Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F44F53D69
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Mar 2026 15:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B42940EB0;
	Mon, 16 Mar 2026 15:28:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mCWWBpPjNCXQ; Mon, 16 Mar 2026 15:28:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1B2D40C95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773674930;
	bh=z4rhJ0MAlLXWIwBE/DLS0hy7130Yo8vaGFjA4dZQEqk=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hzulznaz3+iU1EgdbuqOoKKbwqz7Vna3gq0hMH1smxDcun1sZW8aVDNoP/oKsO6MA
	 oJKLO8SnuanpeeC1IsAFhsi79XGpOxFFAV+Ag7to6RZYOc3bXFR0K9heFf/Zerm4DT
	 5V6cJSd83zuECzQrftiD0o3psZROCD9Vc82Pr7XEgYeotv+/pFlb9xx6Ke6US0odX5
	 XKBVvoF5eL2M0Bjt+FVWBBSLS3NPXskWLQQewOWDjyKrlD/8zMhkT00PtxN2Cq0JLi
	 AtAbT5ooIiRsJQiXD0sv18OPXdsjmJrekXZJypCCtKSB/S7C5ojFSQy9EFEXX2l+7a
	 7OkTXiVGs4PXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1B2D40C95;
	Mon, 16 Mar 2026 15:28:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 073F7201
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Mar 2026 12:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECCB860AEF
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Mar 2026 12:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WHku3xc-GmCS for <intel-wired-lan@lists.osuosl.org>;
 Sun, 15 Mar 2026 12:30:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=bjorn@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 52FF960AEE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52FF960AEE
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52FF960AEE
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Mar 2026 12:30:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9017C42E16;
 Sun, 15 Mar 2026 12:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EF1C19421;
 Sun, 15 Mar 2026 12:30:35 +0000 (UTC)
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Shuah Khan <shuah@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 intel-wired-lan@lists.osuosl.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
In-Reply-To: <20260314093518.43b820b7@kernel.org>
References: <20260313071322.3489243-1-bjorn@kernel.org>
 <20260314093518.43b820b7@kernel.org>
Date: Sun, 15 Mar 2026 13:30:33 +0100
Message-ID: <87a4w9p95i.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 16 Mar 2026 15:28:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773577836;
 bh=z4rhJ0MAlLXWIwBE/DLS0hy7130Yo8vaGFjA4dZQEqk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=X+keosLemfsI7BVZBzyUQqSVb/q5V/tjHHwClIWYUE6+g2YtxoPRqPk2g6jvAgmnp
 eIveEsYMRa9hpiR75Q4J31ZLqbO8zpmehsoTJoWr7tlKZ8/GSpbuC0KYFOhppILwVZ
 dkxs3evpw0DBHNzqc0jA0IVXiiu7QHPr+0X/fZjUZQk6UbjVg+Wd+Ht0RiVd5vLPIl
 tXrhY+e0R8l9y3SW4lA6vfXJhNW8eyqTYjsOjk7cD4aU95Cp0bFJXO9iuaxHTbjzLe
 8KmpEZPk5rcB83PcVNWy7SuAG9qKj6UUtfAJmC0FePTEo3lrUMe9hWEL/7jbbehL+S
 Sc27UiLZ6QPbQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=X+keosLe
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/3] ethtool: Dynamic RSS
 context indirection table resizing
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 13 Mar 2026 08:13:12 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>> Some NICs (e.g. bnxt) change their RSS indirection table size based on
>> the queue count, because the hardware table is a shared resource. The
>> ethtool core locks ctx->indir_size at context creation, so drivers
>> have to reject channel changes when RSS contexts exist.
>>=20
>> This series adds resize helpers and wires them up in bnxt.
>
> Sorry Bjorn, I was typing the explanation below and I realized that=20
> we may be violating user intent. We should already record the user_size
> from rss_set_prep_indir() as part of the context (and presumably some
> netdev state for the main context?) and don't allow shrinking the
> context below that mark..

Don't be sorry! Good catch, and glad you caught it now rather than after
it landed.

I'll respin with user_size tracked in the context (and netdev state for
context 0) as a lower bound, so resize never folds below the size the
user explicitly configured.

WDYT?


Bj=C3=B6rn
