Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDAFCA0EE4
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 Aug 2025 19:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6380C40924;
	Fri, 15 Aug 2025 19:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id unHQg4NZxYct; Fri, 15 Aug 2025 19:26:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8E464092D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1755285992;
	bh=jZSYI0BkoXuNhL8kExnHMzB3D2C3PD4TSB5c7r9JtHs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YUY+wAcO47LJf8LXh88UaFESWDlMbCGMqmlyEaShoVP8UjlEeuNKQCjj1n8tvMVLQ
	 Lzi/EkoYlDkJ/uQkrKb4FTnChcDWZV1V7YKBjg8cgHOEATFyab+GALw+GPB3RzvTQ3
	 mKUQvRCUVWca7IcvtmgsYE4ifomTvNbCvI6WHANEiAb8QzeRcP/BYkr3I1q7Vm6Kne
	 0H0Mp73UoInetDag1vhIfH0OvK0cTvz01fmVquT2TVVICeOri8nANmhqpvcRmdzi5R
	 n7ICqThUGL2nERa5a8LsCv2JSFipSh2UgU1ULtTwH4Vl1jOAlkKoXKfWRgWXUP6dMk
	 GmViQScoUM++Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8E464092D;
	Fri, 15 Aug 2025 19:26:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23531223
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Aug 2025 19:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14C7C4092D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Aug 2025 19:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Usk5vKEvkWC9 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 Aug 2025 19:26:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6668C40924
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6668C40924
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6668C40924
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Aug 2025 19:26:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 725595C68AC;
 Fri, 15 Aug 2025 19:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234DAC4CEEB;
 Fri, 15 Aug 2025 19:26:28 +0000 (UTC)
Date: Fri, 15 Aug 2025 12:26:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Brett
 Creeley <brett.creeley@amd.com>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai Huoqing"
 <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-rdma@vger.kernel.org>, "Gal Pressman" <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, "Shahar Shitrit" <shshitrit@nvidia.com>
Message-ID: <20250815122627.77877d21@kernel.org>
In-Reply-To: <1755111349-416632-5-git-send-email-tariqt@nvidia.com>
References: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
 <1755111349-416632-5-git-send-email-tariqt@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1755285989;
 bh=XThlV1U6bmBUoCCBTZhniQaFumiomKJglFZyqJ8EKMo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RPzsPUfJBr5q5p+iF9vGtPAIahYFabs9abdt4JCY7KxS1BzGSCe6yRc539IhK5VBn
 BHJH/IQp4gyfnkPd1YC/dKSq0GM/dU83SnnwkOxSYvQ4TUUPUuV0CoMUlKZANeCulU
 IXM7O4rn6DuC98dxd83wIL7+Z2YA1qUbe6SKpFDZ796B1oaIbDtehNXYrQJ3NyjTB8
 ThvxZ/TZ1RZHfqz1s2dV1biJs0NzcmsQg3rroH2ODMZvpYx7eLoaDNpgmShfEcB0P1
 15fyszyNz+4TOiZQtxl4cn/2BGzPyxDkB2ruCyy84Yo8ioH+1EZGfD3XjmVyTDdNMw
 8Qx3qtsNsZypw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RPzsPUfJ
Subject: Re: [Intel-wired-lan] [PATCH net-next V3 4/5] devlink: Make health
 reporter error burst period configurable
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

On Wed, 13 Aug 2025 21:55:48 +0300 Tariq Toukan wrote:
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index bb87111d5e16..0e81640dd3b2 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -853,6 +853,9 @@ attribute-sets:
>          type: nest
>          multi-attr: true
>          nested-attributes: dl-rate-tc-bws
> +      -
> +        name: health-reporter-error-burst-period

the "graceful-period" does not have the word "error"
in it. Why is it necessary to include it in this parameter?
What else would be bursting in an error reporter if not errors?

> +        type: u64

could you add a doc: here?

>    -
>      name: dl-dev-stats
>      subset-of: devlink

> +	DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD,	/* u64 */

The _ERR here won't work if you used _ERROR in YAML. 
The naming in the YAML spec must match the C naming exactly.
-- 
pw-bot: cr
