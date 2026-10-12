Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C698CCA9ED1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 09:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F78360618;
	Mon, 12 Oct 2026 09:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NVUJzXZAov_3; Mon, 12 Oct 2026 09:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2919B605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791795719;
	b=J+iRCNav2unloz7nV3KgrOhc2hwo7Ta2RRdp8z0kE15hwX7hpxiyXafzIRSTSca9yxKL
	 +AYZnn5kjm4+QyN8Ce2/xu14Uvolxvm7RrEFgBubX5TkBdd3MSMMutBDp1tWGfY66o5sa
	 0hHPs3A0W2oa8kpP4ck85NnJTOaT2gdZh4M5qUE/vUGUgrgoeOojlIxHrKKT1P2o6cGpd
	 X7dG8aGFS+3j+U+E99Uf/WnLLAeHYfJAvPnaKRvUuv2eDIEUFRc32+N5e74fgaB9Vuo3w
	 z0YJnjLnXxP18e0gE8Gl1/S6oz1I8ZHnUVt3uz/elozgy5qD+qIBE6u7xfJs6MgAyVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791795719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KFxI/qq+kpw+3Ln510VqxPWXh5UrKdc6BHt7MxItub8=;
	b=K8EMG1oUhGDnQrtr3Npt0XjMqMLPcsi9ZAONk+mUo4boEzm4vt8t/C1ZseDPj3doAsUb
	 RYtX5WzHIAmL8kigkK+2R+85jW5NETXfLdwF57e5pQUFTOQwvr6I/aXr18+X16G12CJN2
	 T597QcoZbimBeMb7BzC3qLpGvlD5dO4rMN6ZFpVpVd+kX+T8+VJyqtTGiczwTVuEKBaVP
	 6YpDjT8/QEvRE3uLJ+jIOSaFpPjYoEWdhxrWQaeCorHMd7WLtZRLwoIpqMOgE9BT0DdJG
	 p3ubiX5zFPjPi+BgG6uFr0xJYSsqdQ3i06oTmuoPQb71JB4o9DGPvWmhs10xQSYQjtQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791795719;
	bh=KFxI/qq+kpw+3Ln510VqxPWXh5UrKdc6BHt7MxItub8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NjxopuRv44Cnll+DHA6u5iSxw9NJHKK3+genbuV4ZpVltrDW0TvX7eqLca7Mix/HJ
	 yyKMFuSLGXfn0VD1/ven48B3fFhnS1GLLYPp/F21C0C21JhovNIbxiM+LfpUu6eNRC
	 sEp6T0kJKNtxLioD8U6M4WGNtznp5TyERtAWs7A2J8wL1qGYJOrJSuSFP7IXGufxTS
	 uCn6cXgvIAmcuu28MsEJWapIYcA1iMbdmp11+bwarl9penLUR1DR4m9zIJd4vqTwW2
	 zwJJMoNZ93nJP1hQhsBH/qVKhJwL4oQuxrV7e4Yy1JwC80x3bOh0h6ZVk3Qak+0wnu
	 3O8XsIvEStR6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2919B605FC;
	Mon, 12 Oct 2026 09:01:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C63D105
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 09:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 125BD80A58
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 09:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhfoMT8HT80q for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 09:01:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B45BB80CD8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791795717;
 b=sUVajFlPyaV5ZarwzeifDUSUtD/QWX9uR8R+BfCWPogLwoUEt2wuNQ7ZDU8wszXHgP+l
 MgNYMrF2q9/KddFyb+A3Dfb247FvKbj9xT6WVCrdma4pTTMuhsk9fFlfcOo/2bhN9/zxS
 L+1zAzesA/ld8miLa26k1YxegVAYKwgJhU9umrWy2Aes7XaxvY/0F4QGhPehtTTzHzl2T
 oDwr6F9kxQB8kG40whiRLz7b2tttRH6P012VPsfzVp2aQ35Zu+c38Dx8GI71rqp9Bg/1w
 rKIupiURf5ZoVjJQM9hGhkHD8Un9rQ+wls4cH7ebudQ/XCTHbJ0gCR+GV/YXHG/CxXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791795717;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=KFxI/qq+kpw+3Ln510VqxPWXh5UrKdc6BHt7MxItub8=;
 b=GQTuiiTOgger6iVyAWN2xsdKHmJKS3LXiPyj4zUorBTubORQ1c7oIPuZ89HPWDeBG3sH
 1PejWBLdt8oyjN0x5cMAm0Av6ufBpuvad2jIV1BEcSCqnVBHSLkEpREhCt2pO2NeCoHFf
 XGs4VkFk7QX0uKwOcDarAFcq7SKOrV7xfNcbUwv658oAXJ4Oy9kwgfPuDihruEQkmvUdL
 aE+rlJ3O38eFVmizRPs0hIRdHSXr2pJAn9hnWHoDG+lbKZifeufyyMJE5Ypi0Bl51W85x
 wrcn9XuFsWTJHD9Hzd2OazZtfD249ZdREhXc3R6F4mc8ffp3Ff2WyKofQyTVsg6LBDQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=RQkZDe73; 
 arc=none smtp.remote-ip=220.197.31.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=RQkZDe73
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B45BB80CD8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 09:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=KFxI/qq+kpw+3Ln510VqxPWXh5UrKdc6BHt7MxItub8=;
 b=RQkZDe73x2t4ySLUJ8FUpjBas02deBlTBlx6Jd7p7Q0gSTSEyHPRlwF+JVqeUS
 ikHOTCCwGV/Hq3styQwibtKLQz1gu2tH3C87vvaqMCtbzTxW+rWLD+WgtO44oRhJ
 i6s7TeO8iWwTEiondVXyrh2IyiZ8UE183TiyRaL3gfOiA=
Message-ID: <df018b17-ffa3-47cb-a259-55a9d1133e93@126.com>
Date: Mon, 12 Oct 2026 17:00:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: do not report success for a VF setting that
 was not applied
To: netdev-bot+sinfo@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261012082910.283229-1-xiaolinkui@126.com>
 <179179405801.2527009.14010952920802573492@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179179405801.2527009.14010952920802573492@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wD375ikocxqYLrEBA--.58567S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFy7AF47uFWkCryDtFyUGFg_yoW5WryrpF
 WYkan0ya1DJFy7Kr92qw4jva4S9rs3GayDWr1rKryUAwn8KF1ayrZaqw1jyasrC393u34S
 9rWDXw1DZFyqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uuv38UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQVfNmrMoaXPIgAA3K
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



On 2026/10/12 16:34, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,
Thanks for the note. The automated check is correct; the commit message is
missing the hardware-testing information. Here it is.

This change was not tested on real hardware, and there is no Tested-by tag
for exactly that reason. The race was found by code inspection of the ndo VF
handlers; it was not reproduced at runtime.

What I verified is limited to build and static checks:

- ice_sriov.o was build tested only, with the native kbuild command line of
   an existing v7.3-rc2 x86_64 build tree (gcc 9.3.0), both with the normal
   -Wall set and with -Wextra added. The diagnostics for the baseline file
   and for the patched file are identical (zero), so the patch adds no new
   warnings. The only new undefined symbol in the object is
   ice_is_vf_disabled(), the helper the patch starts calling.
- checkpatch.pl --strict: 0 errors, 0 warnings, 0 checks.
- The patch applies to e04de0215596 with no offset, and at the object level
   only __ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan()
   gain an ice_is_vf_disabled() call; no other function in the file is
   affected.

I could not run it on hardware: reaching the window needs an ice PF with
SR-IOV enabled and VFs assigned, plus a PF-wide VF reset racing with a VF
configuration request. The reset side is the ice_reset_all_vfs() path, i.e.
a PF-wide reset: a PFR (ethtool --reset <pf> pfr is one way to ask for one)
or a CORER/GLOBR/EMPR completion. The other side is an
"ip link set dev <pf> vf <n> mac|trust|vlan ..." request. I do not have
access to such a system.

For anyone who does have one: on the unpatched baseline the visible symptom
is that "ip link show <pf>" and the VF's devlink port report the new setting
while the hardware and the switch keep using the old one. With the patch the
request should come back with -EINVAL instead of reporting success. I am
happy to run any specific test that is suggested.

No repost was made, as requested. If a v2 is needed for other reasons, I'll
include this information in the commit messages.

Thanks,
Linkui

