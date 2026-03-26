Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60AD10AB82A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Mar 2026 21:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CE8140FCF;
	Thu, 26 Mar 2026 21:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z9_yHnVpjlAv; Thu, 26 Mar 2026 21:38:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9DEF40E95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774561092;
	bh=+Zvg/ouTTX5hfkCZKmKPm0sfVNDHyK4iYrrSKx2SXCg=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=CrqZLOJh9X8t5E4dvG+L+6YISm6IDwq9aXgS3aduCE5USZ2ev5dpwIViMdbrSc87h
	 KRjMJcvhLXvIaf9cRC2bHxENbtowpLM+m6XYRlDuszBBAGldlc+iCUaeGwLkDSpWQB
	 FGoBQFWfkYlxwAKo+1KAhneZB4kdAL/SBvC+wxYIYYPu1wmo5M0vwjhMl+aCHFjeBQ
	 9a1BbEFTzPnbw3W9BG7qImyOz8y+IuLaM9wvYOMQHDfOgCYMVdG8wT7Sz7WX/PQ2xh
	 f31H56omrs3GWEqr/hlRjJAeQXSqAtpD3K5z8GV9ugMIZTXxflqmvOKoJ/omjq95nS
	 yzovXMn7SAjwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9DEF40E95;
	Thu, 26 Mar 2026 21:38:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 38C42249
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Mar 2026 21:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B0C740E95
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Mar 2026 21:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bvOEhY1hX9L2 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Mar 2026 21:38:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 850FF40FAB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 850FF40FAB
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 850FF40FAB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Mar 2026 21:38:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EAA8840C33;
 Thu, 26 Mar 2026 21:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F649C116C6;
 Thu, 26 Mar 2026 21:38:09 +0000 (UTC)
Date: Thu, 26 Mar 2026 14:38:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20260326143808.1fd69825@kernel.org>
In-Reply-To: <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
 <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774561089;
 bh=AKkd3ppFc84ObBdwBC0HhQtk41jJEhFN8N8H316ksdk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SxUuXfQ76qYfBkJJ9Y9lfUH3N5eSzipqbgOJ7ENaF5deO8NoA2r68B/lPWt3deX21
 O7ioay7Qs6A5Yk63Rhzx/y2BOJd6NcmTyPP4jzENgsu9cl7eqGfQP2X8kvee7fui2l
 EMZrXlQXqPKhY8/sDRe1sFfpW03SNrPj39lMQkNlqxevn6REFYh4ihHLQwoB8mGrIU
 X7RLR60SPriBcXfdU6QZCYoG8lBlN3rGYECTRqnlqlJJZBarq0iLe7fbI4gB2h/SUU
 m+68KmCwcmeZ7bfhG40d1qcS1OrqG5zynoLRubvHTpyYv6ILSa+nASkZV63Wt275ZA
 nxZznDuKHL5Pg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SxUuXfQ7
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] devlink: unify
 devlink_shd_get_priv() into devlink_priv()
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
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, edumazet@google.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 25 Mar 2026 07:26:52 +0100 Przemek Kitszel wrote:
> Current API makes it possible to access shared devlink instance's priv
> data:
> 
> 	void *devlink_shd_get_priv(struct devlink *devlink);
> 
> but it is easy to forget (especially during rebase from "before shared
> devlinks" era) and call:
> 
> 	void *devlink_priv(struct devlink *devlink);
> 
> which even has the same signature, so it's hard to catch the error.

The implicit conversion may make things hard to reason about.
Are you sure you actually mean that it's "easy to forget" or
it's easier for OOT transition?

If we are worried about misuse we should instead add an accessor
for "individual" (better name welcome) instance and WARN_ON()
when devlink_priv() is used in the shared setup.

Or add a third argument to devlink_priv() which will pass the size 
of the LHS ptr, and warn on attempts to access priv of the wrong
size?
