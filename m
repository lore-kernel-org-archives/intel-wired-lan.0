Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5F9CA0EC8
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Aug 2024 23:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 840E1405FD;
	Thu, 29 Aug 2024 23:28:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7zTy5xnPf-tX; Thu, 29 Aug 2024 23:28:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A317540604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1724974128;
	bh=pGV02rK11Rh7gKA0t/8GFtQCbjqjylbW8r+zqkTCMy4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hCgmWLVbGQBaFqBrKtW2/7P3mEDpZydUFcx+fwHRpZontBctgYPwkCxjj3Gv5E9KJ
	 jssQgR+FeK2LEpu+vME5H9eXVcI8KJ6hi57dgnDWtA3JqRs8XxjbL4AU6UOKmA5n8q
	 uC+fQPus8B0tQ+wUkPbglcgsiDLO3750QAI+KJiZsiHOse1uiratiz+3M02403v2zK
	 YbPkjVSTfQmOyrHxwoxpxG1uWdWHU8XeuH9PnIcbLNJStPyMjf0dOGTTdspR7eT3xC
	 JVWXraDcFsZZf+rwWiY2syODLqWzfO+BVEjjA9cMRywPcYcHgbLTy+fxuaP6bjn+q0
	 PKUnYoc2ysYyQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id A317540604;
	Thu, 29 Aug 2024 23:28:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 14E8A1BF847
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Aug 2024 23:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F41A58408A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Aug 2024 23:28:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oL6X9LpeWIOZ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Aug 2024 23:28:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 258E581EB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 258E581EB1
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 258E581EB1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Aug 2024 23:28:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C585ACE1CD4;
 Thu, 29 Aug 2024 23:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A84BC4CEC1;
 Thu, 29 Aug 2024 23:28:39 +0000 (UTC)
Date: Thu, 29 Aug 2024 16:28:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240829162838.17444e57@kernel.org>
In-Reply-To: <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
 <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1724974120;
 bh=MPUQcmEZ+62dUDUHfQl9jb8uQTyQwWdBgr9Bxmjdj4o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BLsA9Gl3JbGxRyto6QIrtcJZ8BlBuFQZGb0OBUDd23qIIIpLY2WdH+nswz85i1l5M
 Z370/7R2nWTEO7Nk3qmqWjaMFlig8vTG+NRTsfzZof1tuegec943qZ9JDi3cRGOaTH
 w26EuFf9TJi0QER5ENj23EobMYdUJK5TzK9W7tkCuya9SR9MXoQu0Dme8gHcf6/iTq
 0PxDLjnfNcshnZqhwg2m7cMQ68QjzQ9MPYUBzmXoKGmChjys0L8y60S+jvus3BH6Zp
 pIc2dojadSUmaY41vzKITebK7tXxBRkggGCRcnhkld3clTT9Gp2ZfgxuRJG7688VOt
 uEe//uqOsZGlA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BLsA9Gl3
Subject: Re: [Intel-wired-lan] [PATCH v5 net-next 02/12] net-shapers:
 implement NL get operation
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
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 edumazet@google.com, Madhu Chittim <madhu.chittim@intel.com>,
 anthony.l.nguyen@intel.com, Simon Horman <horms@kernel.org>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Donald Hunter <donald.hunter@gmail.com>, intel-wired-lan@lists.osuosl.org,
 przemyslaw.kitszel@intel.com, Sunil Kovvuri Goutham <sgoutham@marvell.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 29 Aug 2024 17:16:55 +0200 Paolo Abeni wrote:
> +	xa_for_each_range(&data->shapers, index, shaper, ctx->start_index,
> +			  U32_MAX) {
> +		net_shaper_index_to_handle(index, &handle);
> +		ret = net_shaper_fill_one(skb, binding, &handle, shaper, info);
> +		if (ret)
> +			return ret;
> +
> +		ctx->start_index = index;

75% sure this should say index + 1, or the xa_for_each.. should use
start_index + 1. start position is inclusive.

XA iterators are hard to get right in netlink, I'd suggest using the
same form of iteration as for_each_netdev_dump()..
