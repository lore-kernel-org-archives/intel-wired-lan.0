Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29CDC4345F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 Apr 2024 18:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81E85820D0;
	Thu, 18 Apr 2024 18:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6v9w3r0yKM89; Thu, 18 Apr 2024 18:16:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B539D82086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1713464182;
	bh=x5IfOf9eAFHiXPzs7zM4smtMewWINclDU8WZnfECaGY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LLlkw6MPj/bycrKSH9ruSjA22EgSqb9j00poW0o3b+eM7KXhBtHKWnkw1DxukgKNW
	 oPe+fY5AIPuz7o8ly8cuo0SGzcIi3hlNUS5XE0+Vdjl+3LrI94JGQo+QHWaW064LtJ
	 Q8O+ygqXINZcrwk3Yy+U0iRv0+D+V+8eO1DSolco00Tv+tpVhNgT9NAySePzsVZ59N
	 MB9p5yNQtMoAIeRGsi9KpzwcwG9JXT2NUYyi6u+VUUiwBiN9vfGdhrZD7Wf61uBKW8
	 2oksYQXWldA5SUULMxDOKOfi9qkcVcHfhTmbhwmP5U4ABGVqM9iGtwCXf3L/z0uXEX
	 YoucO0iN9krOQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B539D82086;
	Thu, 18 Apr 2024 18:16:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 53F351BF8A8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Apr 2024 18:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F7446087D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Apr 2024 18:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T5_zKqtC0NZP for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 Apr 2024 18:16:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6C97F60688
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C97F60688
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C97F60688
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Apr 2024 18:16:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 31612CE18E0;
 Thu, 18 Apr 2024 18:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63084C3277B;
 Thu, 18 Apr 2024 18:16:13 +0000 (UTC)
Date: Thu, 18 Apr 2024 19:16:09 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Message-ID: <20240418181609.GK3975545@kernel.org>
References: <20240416144320.15300-1-ast@fiberby.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416144320.15300-1-ast@fiberby.net>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1713464175;
 bh=U//bNMwj46u+pNDDm3f3gXeA3lT286CbaTYsp6xkRkg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=inJZhHmwRj45vDADU2vkaxHZlX8+mG3kpjPu1SA39silVJUfsozbVmbauqEQlT0L/
 dxswf7SFXOVBQlks8DmEmBHKJ80XjA0u9a9449zVgkqdTETe4YxHVy2luQegT6tlDb
 g7y50H7hog/r8B7qlthQmq+/rxwTiXFfzQ+cxaQqu9TaMVo50YGmUh0fNYcwBlPfqo
 u9HxwEi4uViZ2ki42s+q3e3tqxMGdWfLGjSSSdVzav8X0ueWwQnNSeDr2XAwzP8mA7
 HYzH3mlApRa9jnhpnbSQTr8feNvlnEBkaYF6LVpMg3bmjJas+NkHvWHYhYOKfG0jG6
 28YFWbxmkBtow==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=inJZhHmw
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: flower: validate
 control flags
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Apr 16, 2024 at 02:43:19PM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>

