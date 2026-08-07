Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E10AC5AD2B
	for <intel-wired-lan@archiver.kernel.org>; Fri,  7 Aug 2026 22:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1A7D6082C;
	Fri,  7 Aug 2026 22:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DheW51dqMCfR; Fri,  7 Aug 2026 22:39:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FF0C60829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786142379;
	bh=kRyivWgA43w7tmjOxnbZ/lgEvwpHO2HTUENIiHU8fAY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ifAME6EhaILyTHngy7N3BvnTqPrVT0OUVFV2w0BhduM84Lkyp47bw0H6SaQSdXDQp
	 qVebgylIFE+COGxlGqnH2dcNoAUkVAjj9jGKjr1041GQ2gjI/iqGOnU4Cxxa0KZNKQ
	 /SqZPrTW7VN87J0p1NiaNJVFp8jnvzs/CQAxS0rFiJra8tcr+7pw7sr6PzKSblMpIf
	 O8r02WxCcZygLyI2EtOU9aG6L13Pw1zX57mqYJUlXbS6nKeRGwFOjroo1GgFLfCYom
	 NuY9Hk1G6ZZPxS1N0Q1mPPMP480wroJLg3KKWMrM02KiIig0YQUvqfTeteX0gg2i7X
	 infRbh/o9vmKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FF0C60829;
	Fri,  7 Aug 2026 22:39:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 53E293A9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 22:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C2CC40226
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 22:39:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-HDssQg_LF8 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  7 Aug 2026 22:39:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 933FF4020B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 933FF4020B
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 933FF4020B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 22:39:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08E8B6001A;
 Fri,  7 Aug 2026 22:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA2B1F000E9;
 Fri,  7 Aug 2026 22:39:34 +0000 (UTC)
Date: Fri, 7 Aug 2026 15:39:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, joshua.a.hay@intel.com,
 przemyslaw.kitszel@intel.com, Willem de Bruijn <willemb@google.com>
Message-ID: <20260807153933.7b8b01d4@kernel.org>
In-Reply-To: <willemdebruijn.kernel.c36ea46d8e97@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
 <willemdebruijn.kernel.c36ea46d8e97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786142374;
 bh=kRyivWgA43w7tmjOxnbZ/lgEvwpHO2HTUENIiHU8fAY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=hlsaBDkKXlh+0zQQ/NWUMbfhPlhHJ/gLmUfeHkHMIHnmf2a8OyK7IUeVKD1/55PIn
 qBlFaIH19IAuXEiPvB0IIxsDT6QYdybqvOsOb5xEmWIU7XZp3WJqxnKO1BS66Yv2f9
 ssXFjKukSusHkvvIT029xdr9Y7rm8E/RhbVK+22RPR449jHp73DDcsP7l6wNU16AzV
 ckpsgXiRkssl1fC9Gi17RYxl5EysLTLKNWcuAe/FGq4jnyqYC4kDnZA69YXk1rFdA7
 sIPJZFbH77kAgm9y905wOr+TThZmdiUnxp2IWBZ+zVV0AeyWSH1/bnodgsuRj3k5YX
 DUHoil5F1M13Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=hlsaBDkK
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/6] hardware pacing
 offload
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

On Thu, 06 Aug 2026 21:18:37 -0400 Willem de Bruijn wrote:
> This was intended to have a wider audience list. Will address in v5.

LGTM FWIW
