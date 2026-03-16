Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847B0F53D95
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Mar 2026 20:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31F5E4108B;
	Mon, 16 Mar 2026 20:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tiQK6oMYAc2o; Mon, 16 Mar 2026 20:31:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58E2641088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773693064;
	bh=5Aq2t06k0matK9VyhYiMLJTsRWMtBr1+4nFJqnHvNvI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4DUfjisB2boDNZqCpbblyf16jHTT7/ig5wDnF3BfBVlp5c7a7FGTvzmNw+fyqC9RB
	 ZBTsJAoSTQS6Z2ch+wQQUA51yuk5oRNvfb9AdhDerDABLespN8ol9jRSeexbJrYmZ4
	 hMHU51i285VULUhHiVKt39jGqxbGHzpn8ifLnJrsUeThl6XEjp8XN/+QjRQ+ceruuY
	 mX7sg0SiABkt3xlgs7D3piykXOdkb+xhVkDxJgdC0NqvmY64Dh5YnGVx3bkCnp9ooL
	 HtrAA+4D1WYN/m6kqADxg2XpGDDcGjyqAwK7XdiD5yTEEyCYl3k1DoQ5RT48bP3IEE
	 PbbLQq6QFf07Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58E2641088;
	Mon, 16 Mar 2026 20:31:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A17C3BE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 20:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B93181521
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 20:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kD6bWQnA-509 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Mar 2026 20:31:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A6B65814A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6B65814A0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A6B65814A0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 20:31:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 24264409DE;
 Mon, 16 Mar 2026 20:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB840C19421;
 Mon, 16 Mar 2026 20:31:01 +0000 (UTC)
Date: Mon, 16 Mar 2026 13:31:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>,
 <michal.swiatkowski@linux.intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>
Message-ID: <20260316133100.6054a11f@kernel.org>
In-Reply-To: <48fc11c9-b346-4828-aedb-f97debf2c459@intel.com>
References: <20260315125451.3741843c@kernel.org>
 <20260315130150.12829f88@kernel.org>
 <20260315132245.1a7efb20@kernel.org>
 <f770c976-8688-4192-910f-5996e1850deb@intel.com>
 <20260316115915.19a6cd6a@kernel.org>
 <48fc11c9-b346-4828-aedb-f97debf2c459@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773693062;
 bh=OzVIH8EzgD7dfS/nH8gCxHC8W7jMrj8hSjOKErO/1n8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jcy1PZjYdb6T0dRk5JPfM5NSd96yV/0O/WGu9Y2wifdM/ZTwmMUQyShjPOEG7Ivtc
 ZLb3oOiU/uVmUaR5PJFmwqqCShQ/KXRPCt1zO72AJnbr095fwXJS2BQfhDhUGFAgVy
 ibxDTzJ3GjdtcflMDP1R5Jh6/7V4fnZbDbQFF8iUpVGKS1+4AzTsECo8kmTjaeC1KG
 1IaWCtB830t86dIvT0T6DJao5sIqBsJKhsJ/CeWDil8d9hQiXQ67837iRje0cF2B2w
 63bE7I9KBua+YNbSBFhFkDIK/yniXwvY/WVpbH8llaTxuqPoxw+UGxfbGoLRpFyMu+
 UUHQQTouhr8Og==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=jcy1PZjY
Subject: Re: [Intel-wired-lan] ice crashes when not enough IRQs
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

On Mon, 16 Mar 2026 12:57:37 -0700 Tony Nguyen wrote:
> >> Thanks for letting us know. I think we have the fix for this in the
> >> pipeline [1]. I'll try to get it tested and out to you ASAP.  
> > 
> > Thanks, do you also have any locking fixes for i40e ?  
> 
> No, no pending locking fixes for i40e :(

Correction, looking closer at the output I think the lock is a second
order effect. The problem is that napi_set_threaded() is waiting forever
on some napi stage change. SOL logs here:

https://netdev-ctrl.bots.linux.dev/logs/hwksft/X710-dbg/results/560801/sol-machine-2
