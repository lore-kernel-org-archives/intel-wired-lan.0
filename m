Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4BAE7717F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Dec 2024 19:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 287BD80EFC;
	Tue, 10 Dec 2024 19:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzGjzj4bYa9H; Tue, 10 Dec 2024 19:57:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E177810E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1733860677;
	bh=lnZE1dOWpl9EX2OVEJeaZEwlAEsYcjlUnXot6Nbygj0=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=prvKt4SNf8XjW+BLUI4gm0MOCIwSAYNOlyGhf7VIA/42he/SIDnvh/h1FJlNDRwXa
	 Ge2hW76nkeYQep7wDCk+sbL79knsKe12fpwg2kfJDBet+rLAUgJDboT4YwAVToPU9m
	 2r6KF/7Mt5r0bC4aIZw+ZoZbFtCrxojKZXMHPg9Y3MYWqCvzm+Mucq+YHjpwtzDiCr
	 DNOF+S9PdvhwzleQuDJfA5d1ykWU7gSgHygg5NE0tEmjP9K8mG1dqaQC3AD8fEq9Jo
	 AP/eJAC2/6EPX51m0HS65hshZFZ4IhOLZM0xdc8PGJTouL3l7CcP+lFd39IU58Xy4R
	 fuGHN2tDQzsDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E177810E8;
	Tue, 10 Dec 2024 19:57:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5DB96F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Dec 2024 19:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 869B7608A5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Dec 2024 19:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYhiAsDWhXlf for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Dec 2024 19:57:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=81.19.149.114;
 helo=mx04lb.world4you.com; envelope-from=gerhard@engleder-embedded.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A26506058B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A26506058B
Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A26506058B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Dec 2024 19:57:55 +0000 (UTC)
Received: from [88.117.62.55] (helo=[10.0.0.160])
 by mx04lb.world4you.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.97.1)
 (envelope-from <gerhard@engleder-embedded.com>)
 id 1tL6Mg-000000008LO-1pXC; Tue, 10 Dec 2024 20:57:51 +0100
Message-ID: <71bdcb46-83c3-496e-861f-cc0841fb26e3@engleder-embedded.com>
Date: Tue, 10 Dec 2024 20:57:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Gerhard Engleder <eg@keba.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>
References: <20241210152708.GA3241347@bhelgaas>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20241210152708.GA3241347@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lnZE1dOWpl9EX2OVEJeaZEwlAEsYcjlUnXot6Nbygj0=; b=gueOzaKYPSxZbXKPTtt9JJN0zl
 MHmwoEA5Jv1iIqfTmH3NXKOgq7y/SNA/KpjHPQA4QqRFr9i1lWxJ9/JZIRXZnaZZxskwkKQzPcSAy
 e2TYKkGv8FX50pf8P7EkowtkgOyx7r4j2pyzdpj8RgQ4XDJ7eXsg8KjoqHEKH63lxmCw=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=engleder-embedded.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=engleder-embedded.com header.i=@engleder-embedded.com
 header.a=rsa-sha256 header.s=dkim11 header.b=gueOzaKY
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] e1000e: Fix real-time
 violations on link up
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

On 10.12.24 16:27, Bjorn Helgaas wrote:
> On Sun, Dec 08, 2024 at 07:49:50PM +0100, Gerhard Engleder wrote:
>> Link down and up triggers update of MTA table. This update executes many
>> PCIe writes and a final flush. Thus, PCIe will be blocked until all writes
>> are flushed. As a result, DMA transfers of other targets suffer from delay
>> in the range of 50us. This results in timing violations on real-time
>> systems during link down and up of e1000e.
> 
> These look like PCIe memory writes (not config or I/O writes), which
> are posted and do not require Completions.  Generally devices should
> not delay acceptance of posted requests for more than 10us (PCIe r6.0,
> sec 2.3.1).
> 
> Since you mention DMA to/from other targets, maybe there's some kind
> of fairness issue in the interconnect, which would suggest a
> platform-specific issue that could happen with devices other than
> e1000e.
> 
> I think it would be useful to get to the root cause of this, or at
> least mention the interconnect design where you saw the problem in
> case somebody trips over this issue with other devices.

Getting the root cause would be interesting, but this problem happens on
a rather ancient platform: an Intel i3-2310E Ivy Bridge CPU launched in
2011 (which still does its job as robot controller). Intel support does
not answer questions for such old platforms. Even for other timing
issues on the interconnect the Intel support was limited. I will mention
the CPU more explicitly as the platform with this issue.

> The PCIe spec does have an implementation note that says drivers might
> need to restrict the programming model as you do here for designs that
> can't process posted requests fast enough.  If that's the case for
> e1000e, I would ask Intel whether other related devices might also be
> affected.

Even for newer CPUs the Intel support has already ended and this CPU is
not sold by Intel anymore. So I won't get an answer. But our experience
is that limiting the number of posted writes always make sense at least
for real-time. Even for our own FPGA based PCIe target, which is able to
consume posted writes at full speed, we limit the number of posted
writes to reduce negative effects on real-time. This experience was made
with multiple Intel platforms.

Gerhard
