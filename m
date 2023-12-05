Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B461C4167B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Dec 2023 16:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06AD343585;
	Tue,  5 Dec 2023 16:18:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06AD343585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701793109;
	bh=o1bE5FtgEyvRwN4iV4Xa0x6pNYmkRflSJTd7Pbm1U5E=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MWA/vg/FvlIRTx6rmYs/4Xvr6K6ecXrctzQjaS9d7MntbeIvX402H9mTK5h4VQLQA
	 +avmF9QcfjHThF9DGf10CzsS2WQueDHTBePln0aKgCV7Bgfrqxrsrzc3NPQGkjbcmR
	 CQdYyVxxeNlfNvaaQUWuap5XrXkC2wtRHxE833BHrI6Rt71Br0Ai7cUITrv0PgIGPy
	 tuTIWPsyIbOEMHX9qG99xd/CwxTikqIEOVeVaBiLpPd98tN3zsc/9fJvJMaaWSmmaC
	 tKEX+n4PYIU77PG4cMkAJ5bpot8pzrJRmaelj2kgMoG0+UvKWKUuLjWm7Xkhi+ZeNC
	 krlNxrGcAR2gQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SwIDgYNeq4dS; Tue,  5 Dec 2023 16:18:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24B8741A86;
	Tue,  5 Dec 2023 16:18:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24B8741A86
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id AA8571BF3A7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 03:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78D2F60AAD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 03:12:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78D2F60AAD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZLSDRkgoIdh for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Dec 2023 03:12:46 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A4F960AAC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 03:12:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A4F960AAC
X-UUID: b1ae75138d6e4ab4b5b51354363fe8e4-20231205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33, REQID:8ce5544b-bf9c-4849-94e4-0899eb8f545b, IP:5,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-15
X-CID-INFO: VERSION:1.1.33, REQID:8ce5544b-bf9c-4849-94e4-0899eb8f545b, IP:5,
 URL
 :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-15
X-CID-META: VersionHash:364b77b, CLOUDID:805d4afd-4a48-46e2-b946-12f04f20af8c,
 B
 ulkID:231204205248UVJ6B54Y,BulkQuantity:4,Recheck:0,SF:24|17|19|44|66|102,
 TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: b1ae75138d6e4ab4b5b51354363fe8e4-20231205
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
 (envelope-from <chentao@kylinos.cn>) (Generic MTA)
 with ESMTP id 1111733163; Tue, 05 Dec 2023 11:05:43 +0800
Message-ID: <d8b80a17-df0b-459c-ae0a-397693f6a443@kylinos.cn>
Date: Tue, 5 Dec 2023 11:05:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20231204014455.2444734-1-chentao@kylinos.cn>
 <81dbf657-6513-4a8c-a0a9-5a98951c8356@intel.com>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <81dbf657-6513-4a8c-a0a9-5a98951c8356@intel.com>
X-Mailman-Approved-At: Tue, 05 Dec 2023 16:18:20 +0000
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-next] i40e: Use correct buffer
 size in i40e_dbg_command_read
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
Cc: kunwu.chan@hotmail.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, jeffrey.t.kirsher@intel.com,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, shannon.nelson@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Alexander,
Thanks for your reply.

It's my bad, I'll follow your suggestion in v4 patch:
1. keep 'buf' as it defined before.
2. resolve memory leak as your suggestion.
3. make 'bytes_not_copied' as a return value for error path.

Thanks again,
Kunwu
On 2023/12/4 20:51, Alexander Lobakin wrote:
> This is unneeded.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
