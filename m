Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96C2C678D5
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Mar 2023 10:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A03960A82;
	Tue,  7 Mar 2023 10:13:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A03960A82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678183989;
	bh=1du1SOn0lyQUEkLW2ITA5jSVO7P8Ecf1Vyt+GwC6Dj4=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mQXskcjWoiPkB3FGD5MKW263sA8Fjm+6+rSUs9mlZJ12iNCh8gGK7Zp9h2PPQ/q+R
	 67PmSDVGSC1B2yaBYYkA4RGxqqGvLqj8fmXPHpnVPYTgnWohSudWP7gBHpxTKtYl4i
	 4W4huYlMdGQeM8/PsXb3y2978yDDAlz0sJWSp+uN8ufFf6YWbcposx4d3YB5mLb919
	 U9+z+Q4XODwQ6ZesbQ7uTJxP91APQpsCD8jGpzMhS3B2VlBqMxL2HonTl+MI7EcnmI
	 UWjQMKKRXrgJOqnPuO9/bzOIMp1p5FD0xD8s6GI/ecb0R+LVymLOzLCX5m5By7U32e
	 f/KDl4jJ2mx/Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S5026NIs9ESg; Tue,  7 Mar 2023 10:13:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1FC060B00;
	Tue,  7 Mar 2023 10:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1FC060B00
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id EBD5F1BF28A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 10:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE384404D3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 10:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE384404D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QWz-3SSM7C8R for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Mar 2023 10:13:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFCAA4013C
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EFCAA4013C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 10:13:02 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A1B6C60027689;
 Tue,  7 Mar 2023 11:12:59 +0100 (CET)
Message-ID: <3ef31c0b-ce40-20d0-7740-5dc0cca278ca@molgen.mpg.de>
Date: Tue, 7 Mar 2023 11:12:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Lin Ma <linma@zju.edu.cn>
References: <ZAcJvkEPqWeJHO2r@calimero.vinschen.de>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZAcJvkEPqWeJHO2r@calimero.vinschen.de>
Subject: Re: [Intel-wired-lan] [REGRESSION] Deadlock since commit
 6faee3d4ee8b ("igb: Add lock to avoid data race")
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
Cc: intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

[Adding regressions@lists.linux.dev]

#regzbot ^introduced: 6faee3d4ee8b

Am 07.03.23 um 10:54 schrieb Corinna Vinschen:
> Hi,
> 
> 
> After patch 6faee3d4ee8b ("igb: Add lock to avoid data race"), we see
> a deadlock scenario when trying to unload the igb module.
> 
> The reproducer is pretty simple:
> 
>    # echo 2 > /sys/class/net/ens5f2/device/sriov_numvfs
>    # modprobe -r igb
> 
> The hang is quite thorough, I assume it's suffering a deadlock between
> the rtnl_lock and the spinlock introduced by 6faee3d4ee8b.
> 
> Any chance you could have a look?
> 
> 
> Thanks,
> Corinna
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
