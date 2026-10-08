Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768E5CA6007
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 13:10:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 112F140ADA;
	Thu,  8 Oct 2026 13:10:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ie8M3cL4M07q; Thu,  8 Oct 2026 13:10:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 53CC140ACE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791465002;
	b=ncUpX9aZN39VDz0DMwx7DbL3IYaJzNaEboDiQZILu3rDHxYSshJrGy8nEEJFVnyzk5vF
	 JbO3rxhmcaq64wmjUd5kdf6LsXYvNMCZyvlrU0vBbf5dnyP4Ta2SYu5WzdsJVyuHsHjT8
	 V4CXt5a1PhHEjMUzmU2E8FlywHOw6hF7jM4vTpCRT3TpjGOUlgd1NxyGJzVzxhjkmhglD
	 q8ymxOMNE3lQLeyFCDLLovz69CqrZh7eo63yhSQGzqqNwH0DRSTbjrc6gJ7ROOM+XqZKF
	 0Cg/trKJhVi7RJSaHDRHPA4NvWNIeO23ufDViioidWJh0Ao7xTV/pNn4IUJM4sI8SYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791465002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=siovdpcdC1SrJwsnnM3h6lQURmWeA+zUKOaxw7qqDDs=;
	b=hQm9L/IHu24gwXZrAuKIXZePUlmoKhc/BHOMSnGyTeuvjPl/Lb97xeuMNmrLE8pWv3ED
	 mNebs8rCwOn1rrxvgQ6SeulesDHuEUdBUpaEcdwz042ynfKjChUWt72euUUbLx9mN6LrQ
	 3aifG92RBgmu62VvtNqlNps9YF4YwyNHgkBtbAx+d+xe5tDmF6XIW2V451IjnFv81uGkW
	 lS0RsK1p5ipqSiIG0NvTPpQQP5A+K4X91gTKru5jTvAg7fg+TcCtET6RflTEbP8+X/A+r
	 ALSrH7k8hUPBejuXM3OLzjzrdp9RBZVIrD59pNqelbIS8OytcszvCrdiqBJKjVHKwLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791465002;
	bh=siovdpcdC1SrJwsnnM3h6lQURmWeA+zUKOaxw7qqDDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uOQEBn6/bV/OBAUGy4yaGjmXtHJlpFLYx6QBivxbCVgA/8k7Mx1co0T4tqhrTvGR/
	 4KrPQG2iWHk4QqcdfaqfRFztp4fP0kKbf8QzLG28Nsz/vsoXJMeBZztdk/hQhRNLVK
	 lUjaSwvyMl9At5xnAvwUPMMleZdIunVQG+IE3Dqzy6iokLopbLN4lhjjEjyxdjy5PU
	 OMHhs2NNVXdblllJtsXLLvKP7xC5mZ6d4n6JoHpb5HXoDJvO8Bol8Z2gKJxQoptxgV
	 y+ZEODfc4uqW4jY9bXut9nOmo9A1extbJWHwYF14qxUjnX/W7SjN6dMLozRjZODWze
	 pKWUO5UGz8C8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53CC140ACE;
	Thu,  8 Oct 2026 13:10:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FD0675
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10DF360B5D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bMEqTlPRDThF for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 13:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 65BBA60873
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791465000;
 b=g1HEToNs2mbN3aB8Bb1HhhOda7KhGlPKkGfnDUu4i1tNh70qK6aAJVEqZ31N5ssS35JE
 RTy2YGDrDjniwF0XtLbEkGEC0x+8mPwLuIP2DBJl44HiemLzCvJzBa/Ibw5qqRwRYmwT/
 fSGqjoiFazLvYgZLLASKEQtkyfqzvI16+D00rfejlT/u72FDfoVk2QVWKQHTWusluZgpc
 Xp3/ovDCsSEU+xiIZrxqehQOLOHdrZTmB7MXzaEtPOiYK1aOvMhCgrtRav7rMDSJcOvCj
 3bjiSwlYo3UO4oNFuorx2ySAZJh4Kjy2UYhsC4MVp/NB2x0VITkv89UzxrgOjuQ4NMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791465000;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=siovdpcdC1SrJwsnnM3h6lQURmWeA+zUKOaxw7qqDDs=;
 b=qNtosMxAvnjOjEndcauqiPA1N6vYXMS96MAhUjfz56IKZHtO2PHRAD7dEPJk46JcyI22
 HlNxzmuakmWYoiLk9ADBXvK5dsidd/VggKQy9cfq0gKFWtcJRj66x0YEXJT/5JkVckU4/
 XPb3THCDNPpVSA5s7HBd2DhHRWDjlZKHPWgkTM9HDiwM19miuJfSOgnCxhddsA2UqJxJ1
 KP3B9h4RrnKxLhuCY5IfT+N7uNLDm3waHkC7CRLTzDJ4Bh5i+q0kUQMdLgQprDTQ00DXl
 phGe09Cwei6lAX8uBxJV4Qnmix4rCYMDU0D9WR8jGxhJTzME0RKFU5fVVTCtkptL/Kw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=QxNspo7i; 
 arc=none smtp.remote-ip=220.197.31.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=QxNspo7i
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65BBA60873
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=siovdpcdC1SrJwsnnM3h6lQURmWeA+zUKOaxw7qqDDs=;
 b=QxNspo7ii5SwM2c0zCuTbguzqoOZpebpi8IZCFy5gNUOzYoHfg509P5MERdKkC
 6dHYqd5s6W0dYfqwyGizp+g357Kv9uHyiDJiLKoMQH+C3b3mBTVngRAyA5tSya42
 15XpPojvDia+Fms2pGqe8VNiILNdJoPi4BkeKeLrk/Csk=
Message-ID: <b402a837-2223-4d72-978a-b2108df78334@126.com>
Date: Thu, 8 Oct 2026 21:08:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev-bot+sinfo@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <179057875290.31693.7249107578001642813@kernel.org>
 <d3f4ae98-3340-414b-9bd0-9f4588810821@126.com>
 <547ed917-77fc-4670-974c-4d4fd6fbf3e7@intel.com>
 <0c464819-16ee-4bae-b15c-3337516ef3c9@intel.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <0c464819-16ee-4bae-b15c-3337516ef3c9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_6XplcdqT3fmAg--.45387S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF1xWF18ZF48KFWDXryfXrb_yoW3ZFyDpa
 yFq3Z5Kr4DXw1I9w42vw40q3409a1rKF1UWr1UKrWFkwn8Grn5XrWfK3yj9a4UC393Cw1Y
 vr4qqw1kZFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4c_fUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlQssA2rHletTMQAA3A
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



On 2026/10/7 19:11, Przemek Kitszel wrote:
> On 9/29/26 8:11 PM, Tony Nguyen wrote:
>>
>>
>> On 9/28/2026 12:14 AM, Linkui Xiao wrote:
>>> Hi,
>>>
>>> Thanks for the review. Please find the missing information below.
>>>
>>> - How the issue was discovered:
>>>    Found during manual code inspection of the ice VF setup/teardown 
>>> error paths. It was not reported by syzbot, a static analysis tool, 
>>> or an LLM scan, and was not hit in production.
>>>
>>> - Whether the issue was actually triggered:
>>>    Not actually triggered. It is a theoretical error-path cleanup 
>>> issue found by inspection; no stack trace or error message was observed.
>>>
>>> - Hardware tested:
>>>    Not tested on real hardware. The change was only compile-tested; 
>>> no affected Intel NIC/firmware test was performed.
>>>
>>> The same applies to patch 2/2: it was also found by the same manual 
>>> code inspection, was not triggered at runtime, and was only compile- 
>>> tested, not tested on real hardware.
>>>
>>> If a v3 is needed for other review reasons, I will include this 
>>> information in the commit messages.
>>>
>>> Thanks,
>>> Linkui Xiao
>>>
>>> On 2026/9/28 14:59, netdev-bot+sinfo@kernel.org wrote:
>>>> Hi!
>>>>
>>>> This is an automated message. This series looks like a fix, but its
>>>> commit messages seem to be missing some information:
>>>>
>>>>   - How the issue was discovered, e.g. hit in production, hit during
>>>>     development, syzbot report, manual code inspection, LLM or static
>>>>     analysis tool scan.
>>>>
>>>>   - Whether the issue was actually triggered, or is only theoretical
>>>>     (e.g. found by code inspection). If it was triggered please include
>>>>     the symptoms, like the stack trace or error messages.
>>>>
>>>>   - What hardware the change was tested on. For driver fixes please
>>>>     mention the device (and if relevant firmware version) used for
>>>>     testing, or say that the change was not tested on real hardware.
>>>>
>>>> Please do not repost the series just to address the above. Instead,
>>>> reply to this email with the missing information, so that reviewers
>>>> can take it into account. If the series needs another revision for
>>>> other reasons, please include the information in the commit messages
>>>> then.
>>
>> Hi Jakub,
>>
>> For patches that go through iwl-net, how did you want this handled? It 
>> says to not repost just to address the above, but since this will get 
>> submitted later, did you want the commit updated to make the latter 
>> check happy, did you want me to copy/paste the response to the commit, 
>> or something else?
> 
> In general, I would say it's up to you Tony.
> Perhaps we could decide based on the amount of additional changes.
> 
> For this particular patch sashiko already posted complains:
> https://sashiko.dev/#/patchset/20260928065306.1514795-1-xiaolinkui%40126.com?part=1
> 
> I've encountered the same problem (although during my OOT encounters),
> and the solution is to detach/attach VF representors outside of
> vf->cfg_lock. More rationale by AI follows:
> 
> ice_reset_all_vfs() and ice_free_vfs() call ice_eswitch_detach() and
> ice_eswitch_attach() with vf->cfg_lock held. Both take the devlink
> instance lock and then register or unregister the representor netdev,
> which takes RTNL. ndo_set_vf_mac(), ndo_set_vf_vlan() and the
> representor's ethtool reset take vf->cfg_lock under RTNL, so the order
> is inverted. The ice_check_vf_ready_for_cfg() check in those callers
> runs before vf->cfg_lock is taken, so it doesn't keep them away from a
> reset that is already in progress.
> 
> Detach before taking vf->cfg_lock and attach after releasing it.
> Representors are added and removed only under pf->vfs.table_lock, and
> ice_start_vfs() already attaches without vf->cfg_lock. Both functions
> set ICE_VF_DIS first, so a concurrent ice_reset_vf() bails out before it
> reaches ice_eswitch_update_repr().
Thanks.  That is the AB-BA Sashiko flagged, and v3 does exactly that.  The
series is three patches now, reposted as a new thread whose cover is

   [PATCH iwl-net v3 0/3] ice: fix VF representor lock ordering and teardown
   error paths

with the per-patch changes under "Changes in v3:" in each patch:

  1/3 ice: attach and detach VF representors outside of vf->cfg_lock   (new)
  2/3 ice: detach the VF representor when ice_start_vfs() fails   (was 1/2)
  3/3 ice: free the VF MSI-X vectors when VF start fails   (was 2/2)

1/3 is new and is the "same problem" you describe.  ice_free_vfs() and
ice_reset_all_vfs() are where the inversion was introduced: fff292b47ac1
turned the single ice_eswitch_release() that ice_free_vfs() made before its
loop into a per-VF detach under cfg_lock, and c9663f79cd82 did the same to
the ice_eswitch_rebuild() call in ice_reset_all_vfs().  1/3 moves the detach
ahead of cfg_lock in both loops, and in ice_reset_all_vfs() the attach back
after the unlock.  It also takes cfg_lock once before the detach, so that a
reset which is already inside the lock is waited out instead of being left
with a window: ICE_VF_DIS, raised before both loops, keeps later resets out,
but not one that got in ahead of it, and that one can reach
ice_eswitch_update_repr() while ice_repr_destroy() is freeing the
representor it looks up, which is free_netdev() + kfree() with no RCU grace
period.  2/3 is the original ice_start_vfs() fix with the same reordering,
plus the disabled marking described below.  3/3 is the MSI-X leak, the same
three calls, with its Fixes: tag corrected.  Tony, if you would rather keep
the -net series at two patches, say so and I will drop 1/3.

The edge that had to go is cfg_lock -> RTNL.  ice_eswitch_detach_vf() takes
devl_lock() and then RTNL through ice_repr_rem_vf() -> unregister_netdev(),
while __ice_set_vf_mac(), ice_set_vf_port_vlan() and the representor's
ethtool reset take cfg_lock with RTNL already held.  The representor itself
does not need cfg_lock there: it is created and destroyed under
pf->vfs.table_lock, and ice_free_vfs(), ice_reset_all_vfs() and
ice_start_vfs() all run with that lock held.

On the ice_start_vfs() path I kept cfg_lock around the rest of the teardown,
because the ICE_VF_DIS half of the rationale does not hold there.
ice_free_vfs() and ice_reset_all_vfs() raise ICE_VF_DIS before they 
touch any
VF, the SR-IOV enable path never does (the clear_bit() in ice_ena_vfs() has
no matching set), and the VFs unwound by that loop already reached
ICE_VF_STATE_INIT, so "ip link set dev <pf> vf N ..." still passes
ice_check_vf_ready_for_cfg() and can run ice_reset_vf() against the VSI that
ice_vf_vsi_release() is tearing down.

That is why 2/3 marks the VF disabled under cfg_lock before the detach.  As
you said, ice_check_vf_ready_for_cfg() runs before the lock is taken, so it
does not keep a reset that is already in progress away; the check that does
keep one out is the ice_is_vf_disabled() test ice_reset_vf() makes after
taking cfg_lock.  Taking cfg_lock once before the detach waits that one out
while its representor is still attached, and the bit keeps later ones from
reaching ice_eswitch_update_repr().  Without it a reset already past its own
check could xa_load() the representor while ice_repr_destroy() frees it, and
that is free_netdev() + kfree(), with no RCU grace period in between.

v3 also carries the origin and testing information netdev-bot asked for, in
the commit messages, since the series is being reposted anyway.  2/3 changed
code, and in 3/3 the call in the teardown loop moved inside cfg_lock, so I
did not carry over the Reviewed-by tags from Tomasz Lichwala and Aleksandr
Loktionov.  Tomasz's nit on the eswitch attach failure path is in: the IRQs
are freed before the VSI is released there, and the teardown loop keeps that
order too.  The release_vsi label of ice_init_vf_vsi_res() still 
releases the
VSI first, because the !vsi path has to skip that call.

The v3 series was posted here:
https://lore.kernel.org/netdev/20261008125754.3520773-2-xiaolinkui@126.com/

