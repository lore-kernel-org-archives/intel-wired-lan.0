Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C81C48BF6
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 Mar 2024 14:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA8344144E;
	Mon,  4 Mar 2024 14:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n67XVr-6P4GI; Mon,  4 Mar 2024 14:49:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95D8041193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709563778;
	bh=XgpSqZI8VTYKxdvqODzSX8ByICMsPCDICmVQgFEltPc=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ScngJ2qTH0SJ0Bf4k/94pgmfr9grlgcHno6Z/4dNPZDujip0qA9iPzL9bhkevBVsi
	 p+w3OyGboE+HqOqTjVNvLjKzOuUy7m2meB2YqpqPfCMaNqhEavX+Y+rkDcZ20IOGKI
	 +ni4GY9zOu4HUt/uMeuugx7uUzLiBk2hRxUHCUNzJTVGjFLDKo+kWR8y6/G3pC33vc
	 M3lTI9Yz4YojU40rX+nWlh/4P7jYDActKkypcQp3ZYyjc97ppgHbwG1491uf7XIq+r
	 t9iW3sqxM7vPD9d7C/Jwf6V7nciP603M1MpnRI33jycWdD8QrkjvdXlYhLkTZqDYUe
	 Hvtcums7lqDJQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95D8041193;
	Mon,  4 Mar 2024 14:49:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id B735D1BF2BD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Mar 2024 14:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A208B41193
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Mar 2024 14:49:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BVHe5vB5rCCk for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 Mar 2024 14:49:35 +0000 (UTC)
X-Greylist: delayed 1791 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 04 Mar 2024 14:49:34 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 041AE403A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 041AE403A5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=213.133.104.62;
 helo=www62.your-server.de; envelope-from=daniel@iogearbox.net;
 receiver=<UNKNOWN> 
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 041AE403A5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Mar 2024 14:49:34 +0000 (UTC)
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <daniel@iogearbox.net>)
 id 1rh9A6-000BrI-MO; Mon, 04 Mar 2024 15:19:26 +0100
Received: from [178.197.248.27] (helo=linux.home)
 by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1rh9A4-000A5M-Qh; Mon, 04 Mar 2024 15:19:24 +0100
To: patchwork-bot+netdevbpf@kernel.org,
 Song Yoong Siang <yoong.siang.song@intel.com>
References: <20240303083225.1184165-1-yoong.siang.song@intel.com>
 <170956142658.15074.12322285485014543685.git-patchwork-notify@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c87b4763-09eb-5cc3-c797-20ed8a25be0b@iogearbox.net>
Date: Mon, 4 Mar 2024 15:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <170956142658.15074.12322285485014543685.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27204/Mon Mar  4 10:25:09 2024)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XgpSqZI8VTYKxdvqODzSX8ByICMsPCDICmVQgFEltPc=; b=jXduoCnJcGxL9hNaLYmYL+XCbO
 +jkyio4C6vHsj1MtRWTE5tPc3KK+DiAOwDIlVQrOpdESSPXBKf8NfcXB3GF7nF4HXKlr1l6eRBf5J
 r4P52MCa1Sv3vYUHBVA8k7LY9Kp03JjeQPXKl/TSTnbUjiLOUr7Dv6kBF6EKASNnkU3cSZLDrdEt0
 OI9/Ie2pBcK7IrYCEa35aic+mQ9FQQfvtvzocE7wnvy6EQjFv6w/tZxuuen7rwsJO4HN2mGrA0Giw
 0oAfaxteUJb/b123ucNa0wVfDJYuAyRxZXA8os2+LnYrhM/9lev9S0IKI/hQb39P0nrESrpux3ZbN
 iJpy7Yqw==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iogearbox.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iogearbox.net header.i=@iogearbox.net
 header.a=rsa-sha256 header.s=default2302 header.b=jXduoCnJ
Subject: Re: [Intel-wired-lan] [xdp-hints] Re: [PATCH iwl-next,
 v3 0/2] XDP Tx Hardware Timestamp for igc driver
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
Cc: linux-kselftest@vger.kernel.org, florian.bezdeka@siemens.com,
 ast@kernel.org, andrii@kernel.org, song@kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, sdf@google.com, yonghong.song@linux.dev,
 shuah@kernel.org, mykolal@fb.com, xdp-hints@xdp-project.net,
 vinicius.gomes@intel.com, john.fastabend@gmail.com, jesse.brandeburg@intel.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 hawk@kernel.org, richardcochran@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 eddyz87@gmail.com, jolsa@kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 3/4/24 3:10 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> On Sun,  3 Mar 2024 16:32:23 +0800 you wrote:
>> Implemented XDP transmit hardware timestamp metadata for igc driver.
>>
>> This patchset is tested with tools/testing/selftests/bpf/xdp_hw_metadata
>> on Intel ADL-S platform. Below are the test steps and results.
>>
>> Test Step 1: Run xdp_hw_metadata app
>>   sudo ./xdp_hw_metadata <iface> > /dev/shm/result.log
>>
>> [...]
> 
> Here is the summary with links:
>    - [iwl-next,v3,1/2] selftests/bpf: xdp_hw_metadata reduce sleep interval
>      https://git.kernel.org/bpf/bpf-next/c/01031fd47305

Fyi, Song/others, took in the small, standalone BPF selftest improvement.

Thanks,
Daniel
