Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E71606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uXcoyIc/;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=FKA0CLkf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43B91606B6;
	Mon, 23 Nov 2026 20:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMsI14uUwW-T; Mon, 23 Nov 2026 20:29:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DAD5260600
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795465739;
	b=P1dQfaDKgiD+jNb0xIDnubqOzxBU37HEgpSdYkZGZ1Ho0HEhejDJwI6joOsqvcO5Jijn
	 7v25ZoPc0EYXZLGQMtMGGszRTmFLjTE6b7MMovvfJuuroKH7oJgdbRcpWxo8FMfAENfN0
	 R5rWGrwQHYM2Y7izjcxbYiKqGNGKxBl4eoH3vd6mLnp0prxbeyY9DKVzqfdld/VS/vUZT
	 Y5HPouvj/YBDv6YW45MAjWuau1XJq1ZhVI7xbapvBMMzUXbI81WkNsyIx3ojg/rwtGt27
	 NgPYIkjHdA8txIZy9A8JzFZ1ituB0D1OirouUo8xAdYmlg8e6J3UQ9GRw7sU0BLTpNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XE7qcYgylreJp0JifMPhFDkqe26p/1tmu93DZNaIw5M=;
	b=fNzgjMH03sx6oGgflFreJuAnsIKlplmG5sak7j7Kqf3Vt/0wNqqlF/nd4LKLyrhOdP18
	 KA6DuuxrSaUGs6YY4LgTfCRZFu5QNarcyLTin4/gWi8tOT0BprrxZa9VVwLDqtMRl5ZSL
	 INr0OrWJ75vMX8aS4/GmQ0h9ejB3vCn/c8NB2YPXY397b3+V0vmzzF2zHQj8OzUjc+K30
	 QuldsgJMDzMpAHuXqboHXy44foPH7I7W+MrQ2ike47NtRHjUa0inT4PbMVqGNMGlZF8Ob
	 2Fcvzx+XxCyjoBz6/Gynw3wh/IOq/O5eE/0Jw2Xs87R5voR8fsf3z82Xg4ZbeDWuoIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795465739;
	bh=XE7qcYgylreJp0JifMPhFDkqe26p/1tmu93DZNaIw5M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uXcoyIc/58repDH4Cr99+7iuE1pUjy/ZVKZe0avvF4WMYPWY7/FCpMdLVXqFHC7PK
	 L+BkB0WkE9cNge3NBn8Il785+ax9r4TGaWQxxViqPublG6DCiAXVN/NdX2ydg+6VvV
	 Uk2W83ZROuwKJC9J9rl8R5IriV77ziGEbmu96gRaVCYuyGYMuTbiZHPUWAwU/yIgP0
	 wmojE0rKvwKfura/3hC/Mrnm3ABAvt73ZW8SwraAcGzzj3Q1kGdEPKJXyguk44D6GM
	 lFQLvbzjSlF/8w2+rtfmudKUJIYrcUDT3GUW6dcBkJIBb1R/lAi+WbK2YDouqXHp5U
	 nRIiByaoF972Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAD5260600;
	Mon, 23 Nov 2026 20:28:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EBB122B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F41480BD7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:28:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3T5DlqA94ACn for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 20:28:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0934680BD6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=195.10.208.42
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.42;
 helo=mout-b-112.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=FKA0CLkf
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0934680BD6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:28:54 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jYHb705X0z5vQ7;
 Mon, 23 Nov 2026 21:28:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795465731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XE7qcYgylreJp0JifMPhFDkqe26p/1tmu93DZNaIw5M=;
 b=FKA0CLkfyWAcxUq1oWz9e0gq1cOVbJ9lfQ/Gioeu6GSlMfc1GEm+LmsBniqVZaIzwp/sCl
 1SipGsLM4pPbvE2iJxAWrCVc5kiEafYwA0LxsJZa/KkAUMNf6svm5E7qmecY5I1IhmgTn6
 zthoe8ZvvqICZi9+l9yGb5Ls6Tux5Sahr7NCAzkc8PmNgDiP03onhJsImaxDBEd98Zfk9G
 dWASAhlejk/mpxZzCi17ObjmqylKZM9HXFAFqvfxHiDxho44PyUB8n2FnQc2USOLo3QAS8
 l4Wm+iOolVvpdsaY1bl63sPHW9zNGnGLkDWT8IPZdTNe+zgNjNflp6sYPFOuXg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
Message-ID: <5b8c4005-ed10-4be5-b79b-8f59089d6fbf@mandelbit.com>
Date: Mon, 23 Nov 2026 21:28:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/4] igb: don't touch rings that don't exist when
 disabling an XSK pool
To: Janis Edvarts Lacis <janislacis06@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20261120210134.133238-1-antonio@mandelbit.com>
 <20261120210134.133238-2-antonio@mandelbit.com>
 <xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jYHb705X0z5vQ7
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 21/11/2026 00:17, Janis Edvarts Lacis wrote:
> On 20 Nov 22:01, Antonio Quartulli wrote:
>> xsk_get_pool_from_qid() checks the queue id against the stack's real
>> queue counts, which can be higher than the number of rings the device
>> has: on 82576, enabling VFs leaves a single Tx queue while keeping two
>> Rx queues, and igb can fall back from MSI-X to MSI with a single queue
>> on resume. Disabling the pool of such a queue, e.g. one bound to queue 1
>> before enabling VFs, then passes a NULL Tx ring to
>> igb_txrx_ring_disable().
>>
>> Only disable and re-enable the rings the device has: skip the queue if
>> it has no Rx ring, and only the Tx part if it has no Tx ring, so that
>> an Rx ring using the pool still stops using it.
>>
> 
> What happens if a pool is bound to, say, queue 1 and the socket stays 
> open across a runtime resume that falls back from MSI-X to MSI (queue 1 
> becomes invalid)?
> 
> If the socket is closed after igb_rtnl_resume_task() has reduced both
> real queue counts to one, xsk_get_pool_from_qid() will return NULL for
> queue 1. As I read it, igb_xsk_pool_disable() then returns -EINVAL
> before doing the cleanup and resources get leaked.
> 
> I may be mistaken here, if so, please let me know :)

Hi Janis,

actually you're not mistaken, thanks for spotting it.
Once the real Rx queue count is lowered below a queue with a bound XSK 
pool, xsk_get_pool_from_qid() no longer finds the pool, the disable 
fails ("Failed to disable zero-copy!") and the pool's DMA mappings are 
never unmapped.

igb already does this today (it lowers the counts on runtime resume, 
just without RTNL), and so does any shrink done by the driver itself 
(e.g. SR-IOV reinit), so it's worth fixing here.

In v5 igb I will follow what ethtool does for channel changes: when the
driver lowers its queue counts, it keeps the real Rx count up to the
highest queue that still has an XSK pool, so the pool can still be
disabled and unmapped (the rings are skipped as they don't exist). The
Tx count follows the device, and the Rx count is lowered at the next
open.

This said, I will first wait for Sashiko to report any other potential 
issue and then I'll work on v5.

Best regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

