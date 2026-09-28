Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220B1CA5FA9
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD88880DE4;
	Mon, 28 Sep 2026 15:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lTZ8OcIRbVFD; Mon, 28 Sep 2026 15:13:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3B07E80EE6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608422;
	b=IbmOy/7i5EVsT6eNralbX8XCt2iUJ6rLy8r4beoGDA1RAdWmxoeH5v99YBM8OjdypvlE
	 DIQcPqH9Y821KYjEVqJbXK9Mcb1Y4MF3M+Epg0VaAfFv2HFvZrCJQ1CnOj3QIa3NWuASw
	 uZD/YOgPbhgxHHMtlrtHmhxQSCt8mZkOU7pcwN2xSOBYRVPFQWfTHCa3wDoPh4cITT4T/
	 zeuaQlSZoT1BhgXvi+p/yU9Re2bwGc23jOtLdRO0npf/aphGNkyxK2dkgtRefbLuXuwXt
	 qRk0CorETCLgGX4C2PC/kp2F243w+tPzXMramaMfpFXmbRa+EQQwfUatdfmKwupL3pQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=Rc1xwc1oSVmY1SZcZHAPwADFvdwyaal7OnS5A6Fk+jxCpfC6wWDXZoGFZ5hR60I8uIMc
	 XXidDIqCuOv6npA4AwOGUEcV5RDX/rmTHYqECvotjZslIPS23Goo7D9pSq8LkaprKq/+X
	 V3RWCtTIFlxuW6DoK5RgwE2/EoJC+xvKFC7JEHYWSFbi3Tv5jOk0CDhHOwbvzSho9RTTv
	 h8qw+9mC0b4CXslAZBVtCnnLbdCjucP2BdfEjU8F0kC5A1mEXhZK7Zu08l6mFm0Fg/tsy
	 4KenxkE5AUJ5YmHvQW3PbtIgHbu83/dsrNxec3+xSYN2sQ2oQSAmVx7D5No+No5Uqig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608422;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=96k+D7CrCfESvF6yYhHfOvwP00xiVXqiVMunCm7voJw9x8Ni6DbF5VqwlxnAo3GgB
	 miLdE8bnznvyC5zVHxEZBsRmq3p2nJFlPHexDon5MyapVdnIvN0sOo0gCGJCB6pMEF
	 Yzkx8LyuAAsZdUGBZbsaHq5Rt2Mjs7vNhUh5rA8anWa8Jdu9GXIL4bw6KoB2SIj/Gw
	 dIrnrYwYkduDeeI7aDpUHuGqM9xIhzIb8gErGTpgpbMgw5J15tSjbWPRHqGWtPyPmP
	 PtKv68JwlMVd/YBcds6KOqgLJVuPZ5N1H57R7w3yZ8lARXOFZKBC99VBWqqAmivcPc
	 ufntH0dcV/AKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B07E80EE6;
	Mon, 28 Sep 2026 15:13:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C50B2335
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 06:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B724B405BA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 06:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z_k6eJvwy5uO for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 06:59:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 122C34061D
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790578755;
 b=NkPxmH+LH7fIKXJ7GDnY0TucIfQKFc7xct4BkjvEf5rz2oyf6K3/6XxfEtr5zf2Suhi7
 xUegradePPV4iT2iPCeRbKUJNnMe6L25DWYcdE4IQG9WoNZYIM1vHInUitjLq1nvERReE
 ocKfQ+6fQqvSFnUFnaNIq2cEWPZRfXb+S1C04c2sYnsK4qTqo0mc//plk7q9K/Ae6x30n
 Q4bWmu53WJ8DeUQwCZd7oOrlrM95ttR0U7OJAkmziFHl9dej3l2HxBbTyCrYvFkaWLnrg
 8BKHdm2JTq9roqb9QmBJhznelDqi7KY7WqLC16EmZuVEFZYivdRDhU8p587y9I3Lpvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790578755;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=TsQqmonoOLfHsijiJMKr1So41WRqZpkIHkR6C9NqO8O6TRTuR7hicV6g0acoObNg4kZi
 LL/E6gmAGX7ie0c6BbTnF+ngb83RIxnAC6SgvaAvmSnld1Bl5KHSjGY6UQY66SzMwLCMl
 BUNNri6f1mmwh8mzhTLzlLMSMDlE4lp8A2eHXSYTI2dqBuqU/sB+3w8xrz6n3dc2Z7vER
 sQRGmStLoSON6ttHj9ImZ0OWid2CY3tnR1xOqOg5BhyodN7nTaP+f8Wj/Wbr3Lk/2gL45
 AuQBqQTTQmcRcOfG361KO97fcBAKtWHNS/6tSAknyZ2Wyrj3mljYkRVI/pNdyDEPMwg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=P5vc5nYb; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=P5vc5nYb
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 122C34061D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 06:59:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EDED40580;
 Mon, 28 Sep 2026 06:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A73D1F000FF;
 Mon, 28 Sep 2026 06:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790578754;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P5vc5nYbCEgWsuLZkLDYObVRIIxR9jbxKbVVx6pC9mfWcbZXoOD6zIgzzrqL4FAwG
 rwGeU0n1H4Mm6zZxF25WraR49swLaofxA1Cx+hRgiu6Ktpl6SDx94kyVVMsT6d6yrq
 EnxLYeLh2BY3JKJGl1TzCDS/WWr1ToKlOFJtbYwXSqObPvewOK2VcEl/trPBQLq7JR
 1UZ4hOGF5LNqEfMVgg7LRX6uTWEAPxq9bJ9JLt+maNMFQbO9ACRYAr6Iii7OWdMTdU
 GPmgWj8i3g3igldQ5v5QmEEysh8S9roY07vWxRPfuB+1CrziiiL+Hay/6y4ufWKMx9
 e5DGen2KQyZkA==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
Date: Mon, 28 Sep 2026 06:59:12 +0000
Message-ID: <179057875290.31693.7249107578001642813@kernel.org>
In-Reply-To: <20260928065306.1514795-1-xiaolinkui@126.com>
References: <20260928065306.1514795-1-xiaolinkui@126.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 28 Sep 2026 15:13:41 +0000
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
