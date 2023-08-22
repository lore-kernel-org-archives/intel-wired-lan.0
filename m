Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC505EE4996
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Aug 2023 15:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F32760776;
	Tue, 22 Aug 2023 15:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F32760776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692717181;
	bh=ru8OzeJNcwyPQXLrUkjq4Wo6u3Hu8/AOcXfKA0xue8I=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YbsqpAjspb7HdmTjDndzqfw/sOBvahS4X6YDWxp4hlEDr/f4/7/I5d1hPCiGzuTyD
	 n7yf75HdB+tuaKZUXR5OPDV3HJ0sw8Nw/qlNnxn+ErncqjitJRio+fnhO16HwG5ZPA
	 EvIMeXNKZl09GBz7SU1yA9BUtTINh1nPufpR+nv5Tr/pNNwQJNNHPtBRwHjTdVF56O
	 zCJhxrZsLPPaxNe0gwlv0+yYnBCMd6dslaxulrJUWhEhmEdwTezGTLuPSHubCK914G
	 baQztyqhPD+si+BaUDDAnFDA6U/1vQ7QSfbcmqd2UFRxkHKOBKlrdt+WH6cIJNOlwv
	 F+pUNcr/o3VhQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nU8Hf3mI-lF8; Tue, 22 Aug 2023 15:13:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95425607B0;
	Tue, 22 Aug 2023 15:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95425607B0
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 34FF31BF348
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 15:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D1DF607B0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 15:12:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D1DF607B0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7NswfD7WvNsj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Aug 2023 15:12:58 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 764E560776
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 15:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 764E560776
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A54BA621E5;
 Tue, 22 Aug 2023 15:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB7CC433C7;
 Tue, 22 Aug 2023 15:12:56 +0000 (UTC)
Date: Tue, 22 Aug 2023 08:12:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20230822081255.7a36fa4d@kernel.org>
In-Reply-To: <ZORRzEBcUDEjMniz@nanopsycho>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230822034003.31628-1-wenjun1.wu@intel.com>
 <ZORRzEBcUDEjMniz@nanopsycho>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692717177;
 bh=SDTz5ot6TCb02ZDMISMKb+snwaqJ5DTq12W2yyBuf38=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jADm5rj0BUxJdpJEZeOBC/lvTE585n4ykOkZs7/TvcOXdl35W2CAYPk15xRMDj9aX
 RfKaOl4qN6VHAsKO70+0J+zRLcfZUwYyVQZXuVxzPkBRb56UTEX6yLC7R2VKoX7Ii3
 Mr1JBSifFsR4uEL61cJdQFF9FloTrc1oNyslGPIz+1Bbwo5swxe+bu/2tc148uQ58t
 ggi3E6CbMe9xfXDzF0A6CmcA7GMTCg3BOxnyt6S5vUdy7y03rHbOi9bT6yeC0CM7OX
 TPAIAeDNowtAEzNf4KtOivvbaGtgVOdLg3FaXjYSVqX1ZfkvQyL1DEZGMLSTUJ/LvY
 qUlfBLmHfyoVw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=jADm5rj0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 qi.z.zhang@intel.com, anthony.l.nguyen@intel.com,
 Wenjun Wu <wenjun1.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 22 Aug 2023 08:12:28 +0200 Jiri Pirko wrote:
> NACK! Port function is there to configure the VF/SF from the eswitch
> side. Yet you use it for the configureation of the actual VF, which is
> clear misuse. Please don't

Stating where they are supposed to configure the rate would be helpful.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
