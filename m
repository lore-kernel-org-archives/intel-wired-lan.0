Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AEBC678D5
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Mar 2023 13:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17E0B4023E;
	Tue,  7 Mar 2023 13:18:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17E0B4023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678195095;
	bh=aRhWwA59b7MY6XnygqfO6PWn4olNGbqrLu7Y12MhltM=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:Cc:From;
	b=ssC0+ecdrt1wngC3wJGieY2LsZhkk4gEojSCb26Wmz9v3iy6uHI/2/hgNPiodCiiE
	 nSZiHDE3O53x6Bqu5kT42VP9sucn2RlYdMea4bJcRnyCGz/UuITLEQYGKciNt2VTVi
	 BeZkObxk8SJHW1PTCCSN42EgU/iIEAxcOoFG7ktGPp0gWo7lfXbTdqPPOoEs3S94hw
	 PRp/igx1S4buzgHcqhGt+XMp4w5i7TFfRFCmMqr1yELHgtsuD4vwMJ6nuLtrHP6mFU
	 pICoLihTFtWqRgu3SBwuPTlB3WyCq4htz2aoeI87tdLlHSrFV37N5/DfUM93xKuss2
	 CkA9b+D/BlAYw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VupiVPloFvvu; Tue,  7 Mar 2023 13:18:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 651E940276;
	Tue,  7 Mar 2023 13:18:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 651E940276
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6A46F1BF46D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 13:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F9468140C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 13:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F9468140C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oQeYGaRVlOL3 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Mar 2023 13:18:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03508813E1
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03508813E1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 13:18:10 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1pZXCX-0004FP-AK; Tue, 07 Mar 2023 14:17:57 +0100
Message-ID: <f3531259-626c-3182-3dba-7118d0c1445c@leemhuis.info>
Date: Tue, 7 Mar 2023 14:17:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
To: Lin Ma <linma@zju.edu.cn>, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
References: <301b585a.80249.186bbe6cc50.Coremail.linma@zju.edu.cn>
 <20230307130547.31446-1-linma@zju.edu.cn>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230307130547.31446-1-linma@zju.edu.cn>
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1678195091;
 0aab537f; 
X-HE-SMSGID: 1pZXCX-0004FP-AK
Subject: Re: [Intel-wired-lan] [PATCH] igb: revert rtnl_lock() that causes
 deadlock
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: pmenzel@molgen.mpg.de, vinschen@redhat.com,
 intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 07.03.23 14:05, Lin Ma wrote:
> The commit 6faee3d4ee8b ("igb: Add lock to avoid data race") adds
> rtnl_lock to eliminate a false data race shown below
> 
>  (FREE from device detaching)      |   (USE from netdev core)
> igb_remove                         |  igb_ndo_get_vf_config
>  igb_disable_sriov                 |  vf >= adapter->vfs_allocated_count?
>   kfree(adapter->vf_data)          |
>   adapter->vfs_allocated_count = 0 |
>                                    |    memcpy(... adapter->vf_data[vf]
> 
> [...]
> CC: stable@vger.kernel.org
> Fixes: 6faee3d4ee8b ("igb: Add lock to avoid data race")
> Reported-by: Corinna <vinschen@redhat.com>
> Link: https://lore.kernel.org/regressions/3ef31c0b-ce40-20d0-7740-5dc0cca278ca@molgen.mpg.de/

FWIW, that afaics should be:

Link:
https://lore.kernel.org/intel-wired-lan/ZAcJvkEPqWeJHO2r@calimero.vinschen.de/

(that's the parent of the mail above)

> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Ciao, Thorsten
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
