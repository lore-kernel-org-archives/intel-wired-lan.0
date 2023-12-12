Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AA1C4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Dec 2023 20:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDFA640316;
	Tue, 12 Dec 2023 20:32:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDFA640316
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702413120;
	bh=E2tZ/HEHMS0KqhbYgXMNg+BAoklpq3K5C9mvuUqefJE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=OlAiT05A9fW4wK/uNxecv1mEZFgkEZnRfceuEev5hbEjXe5IuC3dNpWu0l5udkU0i
	 jxzB/0BSzFFiSYIQZiJcwYuZWjysXx1CoSTt3huuK3zJPtXHb+yzrz9XT3NXhloi5s
	 6UUR3HSkDHCBdimVBaq9LYyB0+ykeeylsZdpXgKAbVywNI2MHwjO2j2tIqhkuCJOV9
	 OvPAwiIgdeO28La32sW5KO8XG2RToU/Z9+s1R9da1j1lZchv0zFeZUto3F/hrRVJMw
	 iTPJ3MLALzqlX4hPmOOp6QNb2JIv2VUcto1AyBZPCQUIc5kWpRKpmIOO0ixY1lx/Uw
	 uTxNoZvAIjjuw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TK_vGtzBzkri; Tue, 12 Dec 2023 20:32:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id C995C414BF;
	Tue, 12 Dec 2023 20:31:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C995C414BF
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id F077E1BF5E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 20:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C500E60A82
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 20:31:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C500E60A82
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jDZg66deU9nw for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Dec 2023 20:31:57 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12CAD60A5D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 20:31:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12CAD60A5D
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id D9F73B818D0;
 Tue, 12 Dec 2023 20:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744AAC433C7;
 Tue, 12 Dec 2023 20:31:51 +0000 (UTC)
Date: Tue, 12 Dec 2023 20:31:48 +0000
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <20231212203148.GG5817@kernel.org>
References: <20231209092051.43875-1-kerneljasonxing@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231209092051.43875-1-kerneljasonxing@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702413114;
 bh=9tSF4VzYJt2cB8c5D/JCneS7y1HL4A5N0+ouVo24dco=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nkyz2XXBEpkZXkePAITHXeS2DaM/wWdoNvwSkI4wH9og70ySzmeF37L/TC1LJJCo+
 XMplQPTPUcQdpfJZgFXE4okpncV46w8Z1/OPpkZSS4SPg94cKzWutHZR+BOZ/jkDEQ
 XQhthqZrrACfFHLkxw23UxikIOmDGg6Yx2hCWP6J0IfxInVqZEVR8awovYL8/zaSBs
 /1LovrSeT6P9tX2Nq//WAkwCA1xYu/7w+TRrHZsWHXNhxUUsXFauDlqsHzXx0mRWA1
 iacvAleOQ1/GJmFeHHhrHYWKN+Pb8hHOYR+032mWoR2qGbjnrY5eXFGiFB/WZB06F+
 3q7fNdCGTC1VA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Nkyz2XXB
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] i40e: remove fake support
 of rx-frames-irq
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
Cc: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 edumazet@google.com, anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, Dec 09, 2023 at 05:20:51PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since we never support this feature for I40E driver, we don't have to
> display the value when using 'ethtool -c eth0'.
> 
> Before this patch applied, the rx-frames-irq is 256 which is consistent
> with tx-frames-irq. Apparently it could mislead users.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2: use the correct params in i40e_ethtool.c file as suggested by Jakub.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
