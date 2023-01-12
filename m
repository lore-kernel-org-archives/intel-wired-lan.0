Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED8CC54EBE
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Jan 2023 19:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8A8B40869;
	Thu, 12 Jan 2023 19:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8A8B40869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673550894;
	bh=xz2CpaxkqUy1pe/m7fWvZtqQ55p6Ov/vk5e/aRh5L/g=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YQJlWroTLvAXc4A7HYdc8Ol2P6bdzvpMen3Kli5xUjNQn6H+jHSfBDrl5dXMvqxZY
	 orAyC9WrL0sfGmp7TJTWAtL/8vOZwDhICWGZLS8SDnAnVlKRsyYqMRrrnwm+r6rnA7
	 2g+EUF8xrpHW7YcQwXgiVN4VqgQ7y15HM3ZloJ6MK9K+Q3zOpq2Vfn2TcopWMZLWc8
	 Ndv6bmm0/Q6/PojZvm5ei0R9I+0cfj0uI6ohw02DZPIOo//WRgy9ucX6YFVgh0LxT7
	 PpCe0LKDG1tnvdXF2CvbqfokM/SUcQlZneUwAEXMZODnG2Vt+ZI9LPi4qVeYlDd6oA
	 PMEHxkan1/9tQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfSj5AxD7TAq; Thu, 12 Jan 2023 19:14:53 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 842AD409EB;
	Thu, 12 Jan 2023 19:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 842AD409EB
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id EBBBF1BF3EC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Jan 2023 19:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D25CC81F23
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Jan 2023 19:14:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D25CC81F23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VBPW7eoyAUmR for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Jan 2023 19:14:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E2DC813A4
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E2DC813A4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Jan 2023 19:14:52 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 74B9962167;
 Thu, 12 Jan 2023 19:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2192FC433EF;
 Thu, 12 Jan 2023 19:14:51 +0000 (UTC)
Date: Thu, 12 Jan 2023 11:14:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Palczewski, Mateusz" <mateusz.palczewski@intel.com>
Message-ID: <20230112111450.2eefe7b6@kernel.org>
In-Reply-To: <DM4PR11MB5293E8540016AA8AB2E139F587FD9@DM4PR11MB5293.namprd11.prod.outlook.com>
References: <20230105120518.29776-1-mateusz.palczewski@intel.com>
 <20230105104517.79cd83ed@kernel.org>
 <DM4PR11MB5293E8540016AA8AB2E139F587FD9@DM4PR11MB5293.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1673550891;
 bh=saV/tQHscwTp/w0sksVXGA/Cjas4M75TH/eZPXFxs0E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RD0NuINsZub50eF9vyt2J/qoHyOAvTVyGS7AFlrck+s6ZbAQ7HtY+tn23UAJhzNZY
 9dhpBWfSbm1HuSvLMi7wTBo7h7Ol6rLplebMPIU4t45/iWOO69km8P5q82OALmPLKV
 4n3Or9IeLxelsy1sYX5TleGNtj9p00Aq/f0NTSFFa2ATosWY+KjBlrHxd3/s5pNoW8
 jd1mS+XOV0hkqGooXDaNfn+vXlvUMxc8YMmNYCgb/3y3z6Ip5y8cGPMWtx+XASaKOv
 mfonPHQT6/wyGlQ6R9zikoZdhIKkQ1YIsnj292wUzHN6DX6A0Qx9yiFMxyS9JIXuM3
 FbmQ8m7g1AMmA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RD0NuINs
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Fix deadlock on the
 rtnl_mutex
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "leon@kernel.org" <leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 12 Jan 2023 13:31:06 +0000 Palczewski, Mateusz wrote:
> >Why do cases which jump to err_vectors no need any changes?  
>
> During my testing I saw no issues with cases when goto err_vectors
> were used. Did You manage to have other results? 

I'm just reviewing the code.

Exhaustively testing all the cases is probably very hard,
which is why we generally try to reason about the code
from first principles.

IOW "it didn't fail in my testing" is rarely a sufficient proof
upstream.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
