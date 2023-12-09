Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468BBC4167B
	for <intel-wired-lan@archiver.kernel.org>; Sat,  9 Dec 2023 01:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D503B817F5;
	Sat,  9 Dec 2023 01:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D503B817F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702084551;
	bh=AonpHCwSkbLlqkTcffkkznCg+WXPDJtzxyGxx+dqTdk=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ag/2W3wxQdaWiVgDewiQ8sk8YRFtIxLCkBRANpMtgG2TlA0Zh7ZFTDHd+n0oHS8qo
	 m37OW+N3NS+j67VMn5aCFoP2UhoOJIjp+xkwQXLU0scpnYqO6uFcvvlJtHW28e5ith
	 c60+s/MpPh64mkAPyKDQHRiysxy/9ZVSLDzTc/SoYGv+y18Ifv2PGe6uZEW84eNhQC
	 AvSrWe/o+kGqeoDtHHiXCXl8X5etvvbvkFXCXe2NxXE1k6V8EgmKiDJfWDwUbrF2fk
	 Yxp21AdluCswNFX7rbEOkxqIsNRahaLYPxD+m0D2DBnD9kibXiuqmdGZmtUP4nXF+N
	 vXSaOvQTbMgtA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXNgbVxgbahp; Sat,  9 Dec 2023 01:15:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E03218176D;
	Sat,  9 Dec 2023 01:15:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E03218176D
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E25071BF99A
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Dec 2023 01:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9D594287C
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Dec 2023 01:15:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9D594287C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8TD62VNrptzK for <intel-wired-lan@lists.osuosl.org>;
 Sat,  9 Dec 2023 01:15:47 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C1B44287B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Dec 2023 01:15:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C1B44287B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 990ABB8312C;
 Sat,  9 Dec 2023 01:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B66CC433C9;
 Sat,  9 Dec 2023 01:15:43 +0000 (UTC)
Date: Fri, 8 Dec 2023 17:15:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20231208171542.30699419@kernel.org>
In-Reply-To: <20231207172010.1441468-5-aleksander.lobakin@intel.com>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
 <20231207172010.1441468-5-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702084544;
 bh=pS7MlfNbwl/Fhu3GrSIjw0yO1cc0pZZG21Lsn10Aahk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YnBjlmg9axdBsBOudX3MhpFZxt5NM0IClStBSJBRD1fkcfmkwot7ga0Gkqx+C3ZF/
 +uv8zET9hz0fLr/b9Hw4jhhbroBrEqtj9HDlqZhdhmUkfRWsbEDPbMM0IwcfcbdC5m
 TnKEH6fG931dw8l+RlujMQsKF8uIw2vhHT7iJQVWN/69YDEIn44sWIE3nx9r9ZZ0dK
 ZyrZaYVL0mSXCCRxwzGHW9fbaS/paBfpvjvfYkNCoisXBqMPKBZznWJb4yIyHUW+0s
 o3NrD3DhFYj7Inn/cozQb1eKNStRTLvu3JlwfD44OK4ZppHbYev42RVMDaemcYfbx2
 e/iw5EnKCT+aw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=YnBjlmg9
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 04/12] iavf: kill
 "legacy-rx" for good
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yunsheng Lin <linyunsheng@huawei.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Michal Kubiak <michal.kubiak@intel.com>,
 intel-wired-lan@lists.osuosl.org, David Christensen <drc@linux.vnet.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu,  7 Dec 2023 18:20:02 +0100 Alexander Lobakin wrote:
> Ever since build_skb() became stable, the old way with allocating an skb
> for storing the headers separately, which will be then copied manually,
> was slower, less flexible, and thus obsolete.

This one has a conflict on net-next :(
-- 
pw-bot: cr
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
