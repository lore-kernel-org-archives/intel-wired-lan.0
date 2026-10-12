Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E62CA9ED1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 08:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFDD860626;
	Mon, 12 Oct 2026 08:34:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 39okD1CepcpK; Mon, 12 Oct 2026 08:34:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6798E60619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791794066;
	b=Fv8xPC/8CTcDwVfM7vxwLrUd605KHFyBO0nLf8HfeAxTTblEqENZvB70rtxxyKolDDOj
	 ZBxHa7r1jQflvUnENeau1isF6Zl27SVVVkvd3JoRQfQhYzMwNj3xe5FyA668p3Cy6C3di
	 qDsbqZ3/E1AzzWGp3K5DEqqGmG+IO+ZGCsdLXZtb7tlW+2oWpdeY1OSw4TYQ2c/emNK3O
	 PoOuRv1egUL+y16r/YiCjSKPFsyBHlYlf94mtqBHpscN9hDWIaOyjSG3x8kDUBziN1uoh
	 odZpe9VCBMLjgaqtVb6pCOjSuVJKu2CcqxZx3rTGHEZj/6Vb/KQpwKjNGIuNb6GUWYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791794066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=M2OV9CT53ByPQsycWe82BOg36b5JLphJckde5rq4D0DvmpQDrlyA7syHOunVf0e7pokx
	 fc+61hkuNsSe4ZoM+0RWJJN5ZHzg4/W40wNR8tCfq9VanwN2CjWTCq5js3SQyWu0Cmr+j
	 Z4m1hxPuiU3z36mKGsmIMQiBV3itDjZgsdbwTy/lmNzCJ1CexgPvoB01eUow3NBAUxNW+
	 jOM6GpUVez1lwHnN12J+kSMGbWahZ4vpcRfQKepQJvxrVR/hvDIKlayA9jA5l+0MYmJor
	 GK1H56V6CwPoxcGyGuuMvqHe4INhVdJMtZQNVKROGYaz1wKI9aljcooCXuuFQdBWo/w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791794066;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UG9SvRmdua7A2hne6nRknV5vqnwUSZNE6sc09oj00S7ABt0uFOxLI7I1yF6x3tTCt
	 KNjRHXwTHtYWhct5p/pgcV/KMc7aOm1a1/p9zq/Y9LWeSxUHORHQpNuNwKh2girds7
	 1Q378lmWP1CWHOMkjXviiEF+zAJSitcH/2Nft8T+VHbCMaWudMFM7HneP5CLWlvFxg
	 2xmg5CsnARvrkFz4ueGVz7tTIC9/CPcnr3YNBQNxXNyxRiEIaKMDf4s0fPAQALWmnk
	 F+zUKuqeXEA3kuILCiFtatVN6gSyZUz1AW1aqFSVG7qt1Asla3poOJowJy/xKuHX8R
	 QiliA/0byXuzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6798E60619;
	Mon, 12 Oct 2026 08:34:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D08D99CF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B174F80C86
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqW2N1sP87AW for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 08:34:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A31B780C7E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791794062;
 b=XyEI6njngzJVS9DXHQNoyTUT8KmPUvmAqVUGe3lKBQTP6vsxZsQLfBbNoEQjpfnZhI/S
 tbkCRfZ+gHOHUnPVThPQ8yMmGTWO3pcrR7MGWM1bVLIREyO7CjlK8rJ1+wdOTq00T2tU/
 TVliEOXtjNziaBp/Lb8n9FZY1qEc6+vk5QQaaLWPh44AbnyyTHXQuGB3JyQ2AeB9+sHOG
 WFgURrQzdpFYqFCWS7x36hTTiSOUhUIysDKitTbGdPkoqfc7dKRYEz8Coqn9xmpMQJ2AJ
 Ik9Nz8BnstDrl/gjYX5h0gq/Mo/r5993hPexvINN56ws0+rfLmopTnDuuxh09gpHNgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791794062;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 b=k5SnvA8MBlkyLD2Cd5fSamCl8yvFOxduwaFeID05D7VsmvvQCnw0LUTV+jlXoU6a4kHo
 7YwM9nx7KGwAi6VLC98/4uJAVj2vchS01WqEPGYDjQ8G2/458Z0onwQMtMAKrGzfgwWUF
 XM0c1/ncSrcKSY7u2igxqftzzFu6zt6ZVKlJNTC/b7CnOLC2WvNDC3IyzUB6XaKRfZH+z
 SvMDlE8VyUpZXSFxZbxzFLX4y8Yre4RiUog0+yqk0IOrxlvoHVxzklzkmsvDkqKcRIMt7
 7rf+Fr8GANogqdWOLvtJeJxWC42Ipoax2l5OBhej2PueXdF6mew+s7Cr7TiqNOOKk0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TU1O25BR; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TU1O25BR
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A31B780C7E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:34:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5416D60DAC;
 Mon, 12 Oct 2026 08:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EF11F0089B;
 Mon, 12 Oct 2026 08:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791794059;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TU1O25BR+UKhvp7Ujpo7e//H0M2tFSdFcAV6Jo9wfl6vZXBnsSR6BJyQCVERDHjQj
 va32iT6qEPovrNp7FS0mYz19BBe5b45aLHfJvtgrUiIUBSfMu738c2laZNx02zitQ/
 BuLjzDth6Bg0CYa6DyE/3ZNJUt6nr27alYFQhPkEO5VZZ7c76NxqFd16MctRMA1msB
 BITZ+pC2zFd22Kv+c8AFbXpcWzFyFrMw2zyEH+DhUasZvqJS4sBcInbWm53pkwJLW+
 AftFaA/il5oXFArG8lZXxZe4kWyfFSCrz689wpW9EsWqKV3b2uvMKfoQEhLDuIVdis
 xJflm8ePbruNQ==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH iwl-net] ice: do not report success for a VF setting that
 was not applied
Date: Mon, 12 Oct 2026 08:34:18 +0000
Message-ID: <179179405801.2527009.14010952920802573492@kernel.org>
In-Reply-To: <20261012082910.283229-1-xiaolinkui@126.com>
References: <20261012082910.283229-1-xiaolinkui@126.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

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
