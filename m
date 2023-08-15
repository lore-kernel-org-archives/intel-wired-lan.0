Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044E8C001DB
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 02:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F64660F12;
	Tue, 15 Aug 2023 02:52:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F64660F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692067933;
	bh=r0iXzDW2DduGsNBPRDivh+GaxdWcUB1bfiJ+ElxpumY=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=xBdPxdrfLQb1YT4M+RMKlBnrY9qAj9kW6qcD7ph4UVMkX1shqjyg+lb3Z/51cLs0t
	 Kk7YayXdoI1aISegsdN4JpXs3oWJbCMrj3c9wr6MPfXg3Il1HaTYXnaO+Tfl6ZRyQS
	 xluiFX0cDe/su08Momjxm3pluZS8jq5S4Iz4AQbr8UqSt+fKQKjdOQ3NEio+t+pG1J
	 haHH8f7NKDq0dr69oHweJBDJMO2SGrjIYq6VRJa02ACnpO0ZGDxyIqFVQCAS9n+Buq
	 p00Goztq7FVwyv2JbhzlbX6UM2hgiliX8zSCrDaP9L7zeC/XOz97VOhTrc+8H0a76O
	 i6uneFGGvRmtg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Trazhcif1AS; Tue, 15 Aug 2023 02:52:12 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9148D60F0C;
	Tue, 15 Aug 2023 02:52:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9148D60F0C
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 9A99E1BF2B6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 02:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D48440869
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 02:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D48440869
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AWNUk0LYi4fW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 02:52:09 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F4B04085E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 02:52:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F4B04085E
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C404B61013;
 Tue, 15 Aug 2023 02:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6ACC433C7;
 Tue, 15 Aug 2023 02:52:07 +0000 (UTC)
Date: Mon, 14 Aug 2023 19:52:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <20230814195206.1d3ac1e0@kernel.org>
In-Reply-To: <20230811200340.577359-2-vadim.fedorenko@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-2-vadim.fedorenko@linux.dev>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692067928;
 bh=fBlx8M6J3Snxii8KHE1eW/jzAOIKz2CzUVfAHu/9/ts=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=t9iFMyLeDP4MDfepY6USEo/x0FM5GK6yxCkWbKdBAvf4yGPHnUdXuty3oeoBY6nCO
 gaqRJKCsFELr+kJXMxHSpTsiTtkn56mBUQRNJj9LlqTi+HxmZH/in0ov3TEKvLjhTw
 GDst/Gkh6SjKTYywrDBpWmhGkV6tEzt81VLSp9oP6NrThOdE1Ridb6joIbqhh8DZIw
 zrgO4k7Zf3V2H7dra8xvR5GHi9NTqdoAzMLvd95YDNxSfxMdgo8FKI3XiYQzR5tsPl
 jGx72s2nHXW65snF5+WR0YruT4iHxzgHPRiCprjz/qOdi8ftKLqaBPm7D1FKEGN9LG
 gPuLAJ8/QCCCA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=t9iFMyLe
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/9] dpll: documentation
 on DPLL subsystem interface
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
Cc: Jiri Pirko <jiri@resnulli.us>, Bart Van Assche <bvanassche@acm.org>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org, Milena Olech <milena.olech@intel.com>,
 Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, 11 Aug 2023 21:03:32 +0100 Vadim Fedorenko wrote:
> +the callback operation. Neverthelessi, there are few required to be

Neverthelessi
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
