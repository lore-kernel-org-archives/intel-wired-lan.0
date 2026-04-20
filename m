Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D3CF588C3
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Apr 2026 13:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D9C761114;
	Mon, 20 Apr 2026 13:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4IHhdmIFS7h; Mon, 20 Apr 2026 13:21:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FAAC61111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776691296;
	bh=8IuLowldQlM5vyWZuim0L4vboYvqDtLOcLj9YZir9p0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BXU0frIOv8YtZIsIGujfsVqF7OxJCrYCPlUuqNkUrDlirtjBsw1Tjd0eu1hf0jJpQ
	 P7IDdpQ1+jnRyFqSiFk6KfKed82LckGnyffcA2UhOL8qPLYLXIsfT5pcc1bphxlRYv
	 jwPzuBna41BnQ/1ZXK+Tyau3zxXJCkG0QM14YcNl6wH93SADDeUsbxPkkOUnVd8YRm
	 FCYbFxro3xCISmumScjCDkB2VWurMAm1KTAM903IEIteSsRKgZEmzMj7ZKLlZcukJ6
	 ybjQePCfn7OeNO7p/JSHTnxIRiRw10qQQWdZqH21gr+8QSBX+gcsoVpI58hFX7Q4AJ
	 qoxARuIafAnww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FAAC61111;
	Mon, 20 Apr 2026 13:21:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36EE4259
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 13:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22D1461111
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 13:21:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXvnYDKbUCr2 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Apr 2026 13:21:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashal@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3833961110
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3833961110
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3833961110
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 13:21:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E0F3D440C1;
 Mon, 20 Apr 2026 13:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1ECC2BCB8;
 Mon, 20 Apr 2026 13:21:33 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 20 Apr 2026 09:21:15 -0400
Message-ID: <20260420-stable-reply-ice-ringparam-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417091753.4175-1-681739313@139.com>
References: <20260417091753.4175-1-681739313@139.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776691293;
 bh=8IuLowldQlM5vyWZuim0L4vboYvqDtLOcLj9YZir9p0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aDY+ARWH1AAOTewzlMTOCw8oR3nNf6Y0BU8tpzfAckxv8UXMXT51gJf9cOJ4baJEW
 VIIGei11nEIKd9hQNiom5ePem7feNRd3nyuUcqcq9zx5CEAv+w2ahWmKkf/s/1Os7R
 afs/BS9PHcOHzMNwKKByNVvhCTdaDL+4W+AvccM4v4c/N9qFrd7yuhxcX/DZ3/7f96
 eN8UCjh7J7UGnmRQA3vL9ctid3bZ7mKqH/CT23hWzNtGKVYQ3wX5VnmlQif9HheocF
 ASclRseiBg391luF4YQ/8NftLJ/C09Q3DgavDBeQW8hBFYykgYIZrivn8R70ZClD9E
 esxo73A+u4zcQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aDY+ARWH
Subject: Re: [Intel-wired-lan] [PATCH 6.6.y] ice: Fix memory leak in
 ice_set_ringparam()
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

On Fri, Apr 17, 2026, Rajani Kantha wrote:
> Backport of fe868b499d16 ("ice: Fix memory leak in
> ice_set_ringparam()") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha
