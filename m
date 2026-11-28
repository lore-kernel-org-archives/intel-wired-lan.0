Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066E606A321
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3r/O+q2s;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzDD4JzS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD7C86063A;
	Sat, 28 Nov 2026 14:22:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8pleLYtxKmWU; Sat, 28 Nov 2026 14:22:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4AEE86063E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795875748;
	b=Oe7wQdXylyqXfC4PSbeNXfKb6WFRQfHa5t+w/7BN+AtQl7n2vDkgLKXMujxLdSa8vH0U
	 9UB/wjRqs2UnaVZh/Jujrc49NbzVf9/g0UC2v1mjaoaO9lIewpmL2Lt8/63DiTtPXwN81
	 gAmHLH4jRXbBhYm19+i26pSoP2bfjF1xc9BZE9x52vAS72dBkvJhX1sjdGP/bRVuSqiiY
	 yz3gsOSVq5Bfec7N1hGOYvC1P2Xk0cMrbn3ZnmmfHVv6McJAcjmi0KHu0Us/4a17fQ7ua
	 7TqNUHD3wu5viM2rzpQ082tze/8XCmnR1BLsGjiMSah1+C1dqgqui5E83bAJgRjEsTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795875748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1r1H6M37iP/8WlMADt1LPhEo4UjmwFDXYoCxwT75NPE=;
	b=Rkwyv5fv3hcM7/JxIUiUz6D/w3H7RC7tB32mYPIN6HyhyIWxq/BQKytOTcGYfbc1Sues
	 mZv12dlaR3+hgp9SEho9SQdfOzPwOtoy/ZrCkfcXTD39Dr4Y6gQSKUVbfT4kvLaxIks6i
	 TrtLjSjyJQfmdT/rRZXsVYddhQRUm3NkUxAITrPTLT3jifRwNWvxCtG+wY2FQ81vLPZw4
	 8GJlTKq64EsK52Mj/I6s1GcmM2RXhCuYEDXDAqGamDcdRQHQdXWIiOM3TZ7QQv0RyZdk/
	 m2u5+X8hnF9zCCBk48uxAc6U/s+cyv8hKLBQM9YaC/9eCuyK8I4Z0XnZCEsoaYeyYjw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795875748;
	bh=1r1H6M37iP/8WlMADt1LPhEo4UjmwFDXYoCxwT75NPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3r/O+q2sVgqdZAnGQB2bahaHp1uv4tu2+2vx93nNvr/0HN0/eGLmVGyj3JmBqggTr
	 6BT0tvDB6MzaKVjhU5AteaIOLLkguCDfxI92rTDMCTDx3SMy2DvN7e5mZFAI4uScLd
	 fIlxCjxZMmYLB4ZTDmvARGk/ZtTEUtjuSYfHuIoO91iH+lwZo3nLu9lnyJqH3zdHdn
	 dPxxKnveOUqVr7BU5JgOwuL0GFdsKzpDsi962stznorY1LIYXfBUweD0jBZtKAZdHy
	 CenqMuiw8Z5lsTdk4SJTDRl9a6hHcyfY5vFu0LGKEclxfh1WooVnxPHX0pyYhv43tS
	 Ber4FQxhSbjCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AEE86063E;
	Sat, 28 Nov 2026 14:22:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 41839266
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 14:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3367E4067A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 14:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UVAposSHGmXz for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 14:22:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D50540651
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RzDD4JzS
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D50540651
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 14:22:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B8AC60E41;
 Sat, 28 Nov 2026 14:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4601F00897;
 Sat, 28 Nov 2026 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795875742;
 bh=1r1H6M37iP/8WlMADt1LPhEo4UjmwFDXYoCxwT75NPE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RzDD4JzSEK0Ldb2MiQDHl6nbu3ccf1RUHv9BbNKq6JaHzWYnaIjEdwc6Me/UXJcup
 /wTn+GS6ImF88sJiEP7ClvsrewrFcp0IQfq+tBXAI6s+7L5+uc51TNe+3sulh7rEHd
 gurnXZKZlFUBaGMKPbSqit3NlXAJGnWYeYJe4F+2vjxF9uPxfTMLlAeDBUKhO+I1JQ
 PAsKMpbAASP2Rowjx+W3xos1q2WvdEH0WV+arRZr1yiJ7XCrBR57ONbrUK0uOb7Evg
 XyS/jm5kXHzB5AC/BvbEjR+mN9OcpX2A5GjFbhzbGVmB6pjid8o9q/BB8mgiiIo2Bz
 /taMwyF2cVung==
Date: Sat, 28 Nov 2026 14:22:17 +0000
From: Simon Horman <horms@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Elkin Cruz <elkin@google.com>
Subject: Re: [PATCH iwl-net] i40e: ensure owner VSI is found before
 dereferencing in i40e_veb_release()
Message-ID: <20261128142217.GG31322@horms.kernel.org>
References: <20261119170741.1525395-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119170741.1525395-1-irogers@google.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 09:07:41AM -0800, Ian Rogers wrote:
> i40e_veb_release() counts all VSIs attached to veb->seid in 'n', but only
> assigns 'vsi' when I40E_VSI_FLAG_VEB_OWNER is set. If a non-floating VEB
> has a single remaining VSI without I40E_VSI_FLAG_VEB_OWNER (for example
> if the owner VSI was moved or cleared via debugfs switch operations),
> n == 1 passes the 'n != 1' check while 'vsi' remains uninitialized on the
> stack and is immediately dereferenced.
> 
> Initialize 'vsi' to NULL and refuse to release a non-floating VEB unless
> both n == 1 and vsi != NULL.
> 
> Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
> -Wconditional-uninitialized enabled; fix and changelog drafted with an AI
> coding assistant. Build-tested under LLVM=1 W=1 (-Werror) and
> -Wconditional-uninitialized; not tested on Intel XL710/X722 hardware.
> 
> Fixes: 08cdde310e22 ("i40e: Fix broken support for floating VEBs")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

