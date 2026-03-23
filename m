Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0CDF483DB
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Mar 2026 23:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D57C40E6D;
	Mon, 23 Mar 2026 23:21:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id shCpOtAvWN3M; Mon, 23 Mar 2026 23:20:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F46840E66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774308059;
	bh=D1S4gGmCNPiL9NGJc8DtftKY75/Gx8B8V070zdg+NIY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ysOAQ/k8vP29T8AcUvOADZ6fdmHBImcnZG0B0xbAsz2OeKyBprrW10S+SEZsX7vdD
	 FoxIPMfuJZFd8fwA01kQ26D9/Wj64N+VFkxKw22zHSv7al8NnNwndIe2caKh+xKRWM
	 1AmlKp/lQmjBpr7lwxOYQhMooN+tOHFDCg50oBP/c3ldTrBetCTMQhyz8goUvLxFs/
	 qd5gJLXWEGyueCSWMCf+iD8U/6WkJDqmJ7cXqB9u+O6zY3EQfOfhHkSHjrjPyvEnY0
	 OiqPojy8O9oX0nOQ8Ony/2DremOrskSp/OviGVaD5QPVtQa+tK4cMUHvXQb9W9SKkw
	 iSxkeEP27wQ6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F46840E66;
	Mon, 23 Mar 2026 23:20:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AAC3353
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 23:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E47CA82660
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 23:20:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DeQOLKjCnlkL for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Mar 2026 23:20:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 041758264C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 041758264C
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 041758264C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 23:20:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F2294371B;
 Mon, 23 Mar 2026 23:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CADCC4CEF7;
 Mon, 23 Mar 2026 23:20:54 +0000 (UTC)
Date: Mon, 23 Mar 2026 16:20:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com, johannes@sipsolutions.net,
 sd@queasysnail.net, jianbol@nvidia.com, dtatulea@nvidia.com,
 mohsin.bashr@gmail.com, jacob.e.keller@intel.com, willemb@google.com,
 skhawaja@google.com, bestswngs@gmail.com, aleksandr.loktionov@intel.com,
 kees@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
Message-ID: <20260323162053.62a148c2@kernel.org>
In-Reply-To: <20260320012501.2033548-2-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-2-sdf@fomichev.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774308056;
 bh=CXejRXkyFv8rzwbuR+qRhnfSeAcHAubW4BagLISel5c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZdlTOt1MVA50vXHQJe1+nFkk5CqbYNEGEHbm1Jh/Zbvbs8K08YUviCmu7EibRkZV6
 bb94ryBxk95AElS9QWgt1wWP4P56O+KGnzsw82Xa+o01uMWuZO5JoppSrVCl/Q5HL0
 gt/Ey6dGjRO74d3MSJTkpnGBtzNnC/+5id2o7yo5y4zVDEAb20PmUtL3Z49BWLoggk
 NgHoF07Tg5iV8d0qblBTT7euugeW2kFY7bWgWqqb/uo/TqF2b9N37m0QwIfpnqi0ac
 N8psFvp2TG+lYLONfU0ghuKdwV/PRZc4greILDVF7Hq42eLVp7jZf/ZjtnXodPzF4L
 o08Gjtn9Br5Ng==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ZdlTOt1M
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 01/13] net: add address
 list snapshot and reconciliation infrastructure
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

On Thu, 19 Mar 2026 18:24:49 -0700 Stanislav Fomichev wrote:
> +EXPORT_SYMBOL(__hw_addr_list_snapshot);
> +EXPORT_SYMBOL(__hw_addr_list_reconcile);

Why?  For the kunit tests?
