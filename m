Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D827C54FD2
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 02:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02F5880ED2;
	Thu, 30 Jul 2026 02:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rlnq94-hn3I; Thu, 30 Jul 2026 02:40:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 398CC80ED0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785379236;
	bh=l2tpOYZ6orCxJ6zmScpv0PHA7e1WBAy5OLINtq8eY30=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfsbZ1nInnuyo71p0U/eNEci86z4CqZpxLM08GH617IBJQdPLpFyIAHYVLfhoO1c1
	 ddnrqyqRNxvf94qMuIXSInPpdMj2VZdYKEoK/ixKeEyav6/hIql5zkQPUPBSrsx9lK
	 saWLKkKsq1IRWSj6m8sxGac1+MK6z3AhZ+A2zEeiROGsOB3ZYaoB6FJvHsEx3VO1l8
	 dAVwQBhWy+Ms70NZ2p76xL95hjskKLyeMNe8bGeSXjXlmd2QcYzKt0jkMG6vmSydOw
	 jtP5oYzj7ArfgZbGjqPrz1AAinNtR0SDmTqp942OZZlQU075GBwoZ3TDlvokp/tu6G
	 67lloCkDO08DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 398CC80ED0;
	Thu, 30 Jul 2026 02:40:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F1FEC197
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 02:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7E426071D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 02:40:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pp9jSKL7AObE for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 02:40:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4742A60604
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4742A60604
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4742A60604
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 02:40:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 906AB43EFC;
 Thu, 30 Jul 2026 02:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33FC1F000E9;
 Thu, 30 Jul 2026 02:40:30 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 jacob.e.keller@intel.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>, Wang Haoran <haoranwangsec@gmail.com>,
 Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>,
 Rinitha S <sx.rinitha@intel.com>, Jay Wang <wanjay@amazon.com>
Date: Wed, 29 Jul 2026 22:39:59 -0400
Message-ID: <20260729223316.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728210715.10700-1-wanjay@amazon.com>
References: <20260728210715.10700-1-wanjay@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785379232;
 bh=l2tpOYZ6orCxJ6zmScpv0PHA7e1WBAy5OLINtq8eY30=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H3BKT9pXrsbDWC4ykyBG2rlDmHEtboPjGyAbTI1aM83qT28beoJ2CTGFLPWjcB+rH
 bN4V1rbMjkMkXJwiu2VigZZBrTLRLzvmJJ8xHt46N5Pw5upgy8sbnHWUdK70+hgEYl
 WjQ9IKGg7zSIrRwBMOLcqXEtRXd2i+0Pg8BcenrjP/oCxSOAF+taDAhJOWsYScHwNr
 MYOWshruL4YE1yjsNCCYlWTOCojE8U+2Xx4tJTN/80jOYC6P5eemjz91jRywukUeEv
 pNgHfd3IQRrwLLl8ygjqTBToYKoNnZx5zjxwgmBwMbqPGTt4a3kXacYj2adp8p1b/X
 LK1FSBJmah8NA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=H3BKT9pX
Subject: Re: [Intel-wired-lan] [PATCH 6.6.y] i40e: remove read access to
 debugfs files
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

> [PATCH 6.6.y] i40e: remove read access to debugfs files

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
