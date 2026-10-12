Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D62CA9EC5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 07:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77F47605FD;
	Mon, 12 Oct 2026 07:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5zYudZB0dUX2; Mon, 12 Oct 2026 07:34:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01D1660619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791790461;
	b=BZ5dORnuo50IbyB6quxkJoQCgkOEGLOSBrwIn+KjdMql8Zd4Bih9zlPyEdZsVuCwT9v+
	 PEDY3zxytEb08fpqLitWiXGvIaK63xYYKuZypaaS5DTUG1ZQhKOs6ocZnSvVYkSV+MSX/
	 Aos4BdJjI4SiSz6WoyUq42N4HksH4vqMmXjhe+G3wFNaHEqxGmUu3hC8shB+Mz/UB5N/C
	 me79ZXPb4QJTt6im1AE2TAvrlMLSxC883b8gQ98/9oFsQYjhMOyHdSya4ogBZJx2ret5/
	 k3IpFuv2KfY90EXMuil4l287vDyWJPHCspeNjlm+j6PKOzPjK6yzNGpaMpHmvfvyzaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791790461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=ju3MBhWc89od4rtbyMSAsexnNSnwYca5/DUVzrKwNLPzUeGYTNxLA9mM74AhKSlteBVa
	 +RMnfOuPN9QvQcQvOgiqe7M6X5uF/6paXXE4NPFUr5pqKJyjJ9tpQKh+00obmzUmLvntB
	 B7AYy1laeyrtqZt1HUUZmQ+2VMHtabX1tsPEn8ruuWcDcmKCaHp9gvzDkLVWWhc7Raac0
	 4BfIgG79yWrLoBbXnmJmgndZOnXO4ZWwGLKIaBM3mWClKpVduB9P1SNaqIpDyzpxb9ySw
	 wP4NqkhQXHybhMCmX1T1Ldvmk21jhNfR8JeRv4pdsWEqlR2aU/QZlYuuNwWrBZSju5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYRwkamt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791790461;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VEkz0U1EJIKZh32+tfPpR2V0g3kG/yxfQ+a/0t9dqLkwqjkTwdV2/MdpPVSxKwboQ
	 h51bZtgx8r5bKBfoZmSi69emVviBj5ZSgN3OnXpvyJamMoUt7gobywD2alhl2/motU
	 GVJWRbm5lVuI2NmMtq/bFrqswXvE0fcWRDcZCTiRejzX6rURe6urc2vk+yjUKkOJax
	 GlWotpWCALI9uxLHHMS/VVfDO8MkJOzsrIwsgv0Mdehc0Sn//Z/buCcz9CbV7wEMEo
	 16jVpa+x83OtDK2ym9ckRIcGWfvEdw0cN8cFFzpEIkJzc+SdjfEXJr102HmQSoRkfX
	 6M62WjEuZ6XbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01D1660619;
	Mon, 12 Oct 2026 07:34:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E4BAD5E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 07:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 000C4605FD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 07:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gk_7cX6sytso for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 07:34:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6107360619
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791790458;
 b=ZBGmY1k9ud7egZUIOQ/FJ+FkZ4cHM136vnm6iilkti2/I7JJssQmxe2s3tux6suiZr+R
 zS1YOS4F6wtJDurGrFPYIvdROvnBFanT+bi20THBSotQbCoQ7nY1e2cd6AI0RuKtjeJyC
 oam9tb5kUV+2PwPiwL4hsAAfqBYuRzMz+bFuNKBOLcHyNqiaO1h5vvAYtPDcl1qda4vj+
 pIUi/NioBtNnbx6GG1yxGShlLxpXYRn7B21uFYt2R+BnQ8TS3AaPSM3MZPgDYK3Q4dXlR
 kRLsyFRym2ucgCkbHcoCFt/9qxEV5jXyO+oe3a6EUb5apTKNaaPax81+xPZ5B6ykfGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791790458;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 b=ZgsvPUF8mNbkuv3xNC6Ku9FMmXJrj6KsabdBNYkXUCJf1I0tXwZPxlSIh37RaYOW/XMb
 5DD3CcJuPOH92vp0p+hlFGKfom+JIdxlWQykU85uU3caCoMT3mdchntNCQlstFwRVTnn5
 4kKPCvxNTwETLS4Pm0tYXIejBg4ZHLx6RvT176SUtuRNkJUSQmI3oOzqwycyoTVL+LVm2
 KvnlCgzBk9Kh57tFaVA7QVEUUNQ6+aq362JzLVMs5CHtxRO1dTYzH9OYUddEWovOef4xf
 HVy8JzTk7O2y3IGDjHq+3aQZrLlCtH4daf/tj3zh+R3DU8KgWv05E4IZEz9cjTaisvg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gYRwkamt; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gYRwkamt
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6107360619
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 07:34:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70FFC43A4F;
 Mon, 12 Oct 2026 07:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6831F0089B;
 Mon, 12 Oct 2026 07:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791790457;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gYRwkamtdaCFrqHTk1qrlaxClF7xQ8/EK6Qu3+UNdZ95gYl5ISpBw0Plcvw+oFhG1
 NoQoBykp1kiH+R0qXH9mzQ3a0ttCgkQPH33tjy6SZYwcYnnul3qnM4bGf6IxEn/iXK
 ehs9rnxOvA/wMqouHWrgAYDWmFx8el8E4o7MUFPPeY8+ygNlWHRAnqKemnUzjHQPvP
 nsK9+/IIlf5Va/9596bj9dDNDTWwJ5pt1qLPgiWCYw3QYzIAOqXriWk/GMkikizw6g
 fUgwgMnLphykSD69N2RkBu/QKdKiHNpY5DN77TxuQUOB/icr+gKjUKR6x0z7ZRsDqA
 4EkytS4wJub/Q==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: wait for in-flight Rx polls before freeing a
 representor
Date: Mon, 12 Oct 2026 07:34:16 +0000
Message-ID: <179179045626.2527009.2374745016618209052@kernel.org>
In-Reply-To: <20261012072959.254206-1-xiaolinkui@126.com>
References: <20261012072959.254206-1-xiaolinkui@126.com>
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
