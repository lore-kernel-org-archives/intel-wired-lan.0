Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729E606A326
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=rppnY+bO;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=vnVxoAp8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC68B6076B;
	Tue, 24 Nov 2026 23:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0qyyJKth43NC; Tue, 24 Nov 2026 23:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 260F9606F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795564574;
	b=oHan6FkbkSr2arORD7+f18cJ2Y8BKwUVqaZA5k7BQOfbAccXHRtjLv+4N7lUcZ593Z9y
	 yCZZa/VnT+zNDp3TifYOCQLXgcvGqRVf+n7Mr7HtL8X4/Kqk/9JR48yoeGGk4TQZ/WuFR
	 7FNYVTx4Cc8PBtE2+SAPXlncwP2oICg3/2djVrdiVg8NBk3eY7G09ZciSYZMsSvxp1D16
	 bGLFoLSMWzJKwb+Ig26sEt3YXZGIS3YgiqpvDiw7AYxia0MCTIJpxFQrTeCsgBq97xlMy
	 4s5hysbZDw/URwqDkb7xz6d3TPlaSSYt+7u+Z5C8PYSny6J9TXtxN2KqLQ5FJDbQs3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795564574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f7qkQ+T8kTFhbMBMr1htmxGo+zFUKR6gX0ZGbilJ+so=;
	b=g8H0jk0A2uQldq2wHL6uEGYUwvInT0K/FkNVruiqW0LPgJcj1kKttj+HPuJU6HM6JUC8
	 2LKHkGzoCjNoXoHSptmWb0CHV40jEwlFS7j7HG4pFOFvhcE1FMz1DOzIO9JEuC7mLkUhD
	 jghbT4AQnl2EnEg21FXdzYvnSy7UpyM0hWZN4nCr32uYOjs7ZPvC/SlB2pbPz0DY/E1uQ
	 w2Bi/LtKD+f7JU+mdVaUaLORS1yQcv4Jcnqa7yke1ZxbHjVrOg1HkL/YvkPkZySgymVvY
	 zpMC0I3OxTAHp/5zIF2ZWuwn7vlibZinJTaYe2xM0H8wf4hJ8M//mMPvnuYwxntPzAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795564574;
	bh=f7qkQ+T8kTFhbMBMr1htmxGo+zFUKR6gX0ZGbilJ+so=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rppnY+bO79C9iVz+dN8BO6ksCQYi8H/+QDeiyTe56gkqGd0Blcq5jA5HuM6PqzHNy
	 aZVAQSrQyTCKNTW/PXa5x8321qp2HpbO3iH9wqFFSrXT4qDdLE/WtRaxMXD0Yj6HDg
	 Q54Th3kzOUsbO+sGguhAlFyYQKumTlYGJUuylDa8ymlxd7Crq4y7IPI8+lTXF3U5ZR
	 UKDWqfR1FzjKgcjcNk3cRkmDaBk/7vQ/3iKwVmIteR9yA0Y0kbyHDG50vAIpGLNI9c
	 D4BgmT+b2YKNCn/QJZ60MakcYWWkXpBl/XC/4+4ALWOoCaMqROveaPmRqz7VDrWR9D
	 MZOvmqtlEk70g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 260F9606F6;
	Tue, 24 Nov 2026 23:56:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4011B26D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25AED80D02
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 257y8pvrD2xm for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 23:56:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 43A6F80CDF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::105"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::105; helo=mout-b-105.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=vnVxoAp8
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org
 [IPv6:2001:67c:2050:102:465::105])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43A6F80CDF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:56:09 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jZ07n3SVwz9tsZ;
 Wed, 25 Nov 2026 00:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795564565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f7qkQ+T8kTFhbMBMr1htmxGo+zFUKR6gX0ZGbilJ+so=;
 b=vnVxoAp8hmESv5VQ6obmwalRuoWDM6Xt/gryYkIWU1zCA2bliAZFS1XaYGh+1H0E0zDsuO
 8qtGK5T7THYi/qFiL5OSdzjdVxpwfjeXLTx1nXb4xtMMGx7eQlzkmhZFG9D9KYpTqAf56B
 KPNicU/1qqwOxT85D/L8L+6faz+00drGID6D7wqD0NY7Kp1tpj0G7C0EACCjFb0jAOv+R0
 8r9JzZEuZH0FwDpIA13ThM5ThPVlo4TjyfkVBl7UMQoHiIviZFscXdnacFdHlaNijEtKWQ
 FVLzjnNJtz071GAA8W+T228Hcdh/cEIqCjVnPl4TRTzlLrjCC6oXc1aEDyik6Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
Message-ID: <61cf5263-6d8e-4981-95a2-7e6e00afe159@mandelbit.com>
Date: Wed, 25 Nov 2026 00:56:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/4] igb: don't touch rings that don't exist when
 disabling an XSK pool
To: netdev-bot+sashiko@kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261120210134.133238-2-antonio@mandelbit.com>
 <179555632368.3135.16785834510606239982@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179555632368.3135.16785834510606239982@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ07n3SVwz9tsZ
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 24/11/2026 22:38, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new `qid < adapter->num_rx_queues` guard in
>    igb_xsk_pool_disable() (and `qid < adapter->num_tx_queues` in…
> 

The race with a runtime resume is real, though it predates this patch:
v5 adds a patch that resumes the device for the duration of igb_xdp(),
which also covers the same race in igb_xdp_setup().


> Pre-existing issues:
> - [High] igb_txrx_ring_disable() and igb_txrx_ring_enable() in
>    drivers/net/ethernet/intel/igb/igb_xsk.c only stop and restart…
> - [High] On error, igb_xsk_pool_disable() returns early with the queue
>    half torn down.
> 

The two pre-existing issues are real too (the Tx NAPI isn't stopped
when Rx and Tx don't share a vector, and a failed buffer reallocation
leaves the queue half torn down). They're independent from this series,
so I'll fix them separately. The zero-copy tests ran without queue
pairs and didn't hit the first one


Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

