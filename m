Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54019EE6B70
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Feb 2026 03:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2021540786;
	Sat,  7 Feb 2026 03:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F6Pu1IcxGKeV; Sat,  7 Feb 2026 03:01:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61D7E4070D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770433295;
	bh=U5urfrHJm1a/Qv3SPJE/Wac1K7BrGxv35FZnEF/PNjQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OAxFfQ6Vt2VnPmEpSSWktlyZZrEpZGLOtw22kcGTnhIjcqo+maY0IlqGxK47dQZ9f
	 qOUbAQqWFKvlRl5d71MfHc0HfQ2FjSrMvaeiTzC+GQ5CjtcoNWz2D3S+w4pJz/hVmt
	 xSVRgjMjCj3qAb6bbDs7JD2GvW5PvsGXcKTu3UyZn5NlF39+ad0nqfgTDLOHy4EheU
	 ajW903IJUt663JZVjJrGkdReWVi0+NbclZlTNwyBns0zdxijvazY1ZGnvGjZE6QjEj
	 PwmiVWWqIghcQaMRv84Gkbynb7mNEe6aDKZI2zMJQJ6JuZMB7GvJzIhaoyfCtdAuzz
	 zqqQ2uazhoS2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61D7E4070D;
	Sat,  7 Feb 2026 03:01:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 41749173
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Feb 2026 03:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3265340056
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Feb 2026 03:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6cS0fHoitx8V for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Feb 2026 03:01:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8D9D54002D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D9D54002D
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D9D54002D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Feb 2026 03:01:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 984E06001A;
 Sat,  7 Feb 2026 03:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82555C116C6;
 Sat,  7 Feb 2026 03:01:30 +0000 (UTC)
Date: Fri, 6 Feb 2026 19:01:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: jacob.e.keller@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Stanislav
 Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20260206190129.062cd792@kernel.org>
In-Reply-To: <20260206100426.106082-1-poros@redhat.com>
References: <d60cc9fd-70af-40ea-9023-78bbbf91766f@intel.com>
 <20260206100426.106082-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770433291;
 bh=gG61rk2O0dRYFDUOE2SQNbQ8F0SYd+0v0B67KEqFrL8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Fle9I33Q3PwKzZRZ9RJueZu6sYRgp7841WaK/FsCN/nSG1CmmpwhEg7VMf9tSisWi
 HYAyqris5zvmZvIXgDkwgUEfAIX1m32Mxn0AxHXV7L77YT11IYfWVZMtNgCL3QPPfV
 0hvhxb2DDsRPv3jFws/tKvfUGCzf+07kK0SbnAt2TeOE52FXmxv8xNOshlUvJy3tTL
 oUzjNSULridPpLnejkN4U4ogU88m+if4gWKAUc9RZqbP9tQ1ImqPaShV1kwmSKXnCo
 bpIgnt1JTKTaFini4H0BeCfcThYRWAOw0TIdSXEqTe1hLyVifjUhIMu+/v1cu3nL5X
 vvj5mqG5KdDcg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Fle9I33Q
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: fix deadlock in reset
 handling
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

On Fri,  6 Feb 2026 11:04:26 +0100 Petr Oros wrote:
> Fixes: 120f28a6f314 ("iavf: get rid of the crit lock")

This is so much better =F0=9F=91=8D=EF=B8=8F
