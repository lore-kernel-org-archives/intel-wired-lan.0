Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06913C77B61
	for <intel-wired-lan@archiver.kernel.org>; Sun,  9 Apr 2023 10:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D7FA401AD;
	Sun,  9 Apr 2023 10:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D7FA401AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681036445;
	bh=mLEqdMk6ABSp+JdjV7ghVXuPeYK1NjHxMVVZrCNSdfk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=u7/g5LWXedkaEdZTQndu+bAt50FbTtV+TxdQKUl/j++pQ0jbdnVZS6vh90stMsG0H
	 rnUAEil1jYsQoV5EIHdcRF58CAM8BnRq0rxAdF+V7iEuDXduiW5Sy/Rgeakivayt7g
	 Il9ois6skShrv9/ueLi8Clj4BARpd1lEHFsaXCXbvAfnuGuNwpXwpjEPT9DGaYzKHJ
	 e3atjGXWmYVeQ3W8O6SOFhFvBightYsM9o5V+ODnFpVU3cfEYAbPr8RowCuqBdAO7s
	 QORPqnn0lqJpLIGFi7vIJRVInREHmmX0E9n6x3r+eMGBGWxFTCsWYOiCAYdYvRqzLk
	 s53UXO39ArGEw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bvdXAmpmfA1K; Sun,  9 Apr 2023 10:34:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F62940420;
	Sun,  9 Apr 2023 10:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F62940420
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 64B971BF30D
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Apr 2023 10:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E3C160BE7
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Apr 2023 10:34:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E3C160BE7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bgf28FEIBpWi for <intel-wired-lan@lists.osuosl.org>;
 Sun,  9 Apr 2023 10:34:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9117E60B5C
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9117E60B5C
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Apr 2023 10:34:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D6ABC60BBD;
 Sun,  9 Apr 2023 10:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF634C433EF;
 Sun,  9 Apr 2023 10:34:00 +0000 (UTC)
Date: Sun, 9 Apr 2023 13:33:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20230409103357.GL14869@unreal>
References: <20230407165219.2737504-1-michal.swiatkowski@linux.intel.com>
 <20230407165219.2737504-5-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230407165219.2737504-5-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1681036441;
 bh=2jtZu1Edncu6aACQD010tyMWQ63PHORjITCIJrYVIV0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZENUTnZVkMu7J9cnR3T+PZDP462PHtxWhPWOzt8qqwXELbKTcp/CyLtMNE9uPC1T9
 Xku70rdE5obYB3N+apgMhEKcRgZIG1SDDuXBHa6nCYU4V4GcyQPrGGNnIbWhqT/LIU
 1+cnC22Jwh8FZJlFFAmHZqGTCBAniJXLwmUYwDVSFzidOL0WaJYtQd2A+k5oX1th4G
 owErGraD31wjivLYTkOzmTqUJnagWV/UUPuesG7AEo7s2F+xGaFcBt8VeBbvP8ooP7
 5G01PkPzynGNZz+y8IeH4AWgay5oIrNBE74uKKvrqeoQkwiL3n/c6gaOrkjaPcN9mJ
 S7qwj/HtoahiA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ZENUTnZV
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 4/5] ice: allow matching
 on meta data
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Apr 07, 2023 at 06:52:18PM +0200, Michal Swiatkowski wrote:
> Add meta data matching criteria in the same place as protocol matching
> criteria. There is no need to add meta data as special words after
> parsing all lookups. Trade meta data in the same why as other lookups.
> 
> The one difference between meta data lookups and protocol lookups is
> that meta data doesn't impact how the packets looks like. Because of that
> ignore it when filling testing packet.
> 
> Match on tunnel type meta data always if tunnel type is different than
> TNL_LAST.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> ---
>  .../ethernet/intel/ice/ice_protocol_type.h    |   8 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 158 +++++++-----------
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   4 +
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  29 +++-
>  drivers/net/ethernet/intel/ice/ice_tc_lib.h   |   1 +
>  5 files changed, 95 insertions(+), 105 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
