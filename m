Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67336CA9EBD
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 02:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E39D840884;
	Sat, 10 Oct 2026 02:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GC0jRX7FEeYA; Sat, 10 Oct 2026 02:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F4554083C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791600193;
	b=Ako5mIe84wrHPFSQxZJQZtwfFkk8ayv5dilIU8MPn6YyNlbQVvbI9LeTkl29AFKl9Y8O
	 glSdJbGVXH5RU/GM18UaL2Mo4kNXt8hzeq03vcqsbcwADUidHjnyS0ZyKzZm7hBaYpGLl
	 /KLnuPUaPreMIAmKKRQg6Y7VQo8Ts0TPIWIUqVSYf9fKnef3J4ou1wghHmlthvZbKGnTJ
	 shRrCFGh4xFtvC2TbkxHwZJUm7mofPJq2c7ah+Ljy1ZGZM52C8WuseJIay9RST9ZOwfKG
	 VHzYrBlaoteHdZyfza2jMfCF4ro42p2jlzju/Tbiig3stJEDzbf0ZACDFkLpAZ+p87w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791600193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8A778y+EHCDdvBAGvePyfYbo2je/GcH8SNuJ7ZUUv1s=;
	b=T2uSx+eQNCCsrFu+0ogClm2yINXciDml/Rtd+FgboFflNtYDeb/s5jWCnFGOQURF80d7
	 4pQ+oR5Cwlf6ksyJC25h+zgJVPabswx9abESaA8D1ILMALYAMcVDlAdq87g6iiuTtpdLV
	 M3jqykrJl9p2/qgprvrutsf4/gZBFPpczfDXHnFUczpSWZ8zgdsIPgiJJrdsq/uBwydYO
	 htmXYBMUQB/WQU7OrMRFusYO6S6g37h9UsfHTmD+G14KIPg9BlBy4yiRPdgfmaPCUIKJu
	 yN/cIcVKVBDn6uKCrNFff2bkoZqt1UnneswGFmLgIn8iXtzaDUHS55r8BruhePHRRxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791600193;
	bh=8A778y+EHCDdvBAGvePyfYbo2je/GcH8SNuJ7ZUUv1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v/HN7nqpOCvxcxQ0nRZ10JwQnejQqeYkQtZeJdqr/xubaJLMurQmdukopyHFYUAtH
	 50OuAOeafjw4t9LTEliZpFRqz5Dbw6xbLasD+0+JjEOg9CZsnCzwxZ42P+OMvoqZuL
	 fmoNsvHDMcz+DcKGTpmS8iw59LlhQyiIGAPwfv6bKhTqWqLvUI6HnI5uivPT/zRxSd
	 ur5Ywy37h1RUvpg2jHfUqbdL9WYAL8ZULaDT+BL2/NJzJEi1opbzqAtf/TUYhm8iTY
	 FygwJQ3GrYwdy56Tw+8UwjzWWRXoooTcu2hqBrzxSjmfvmvw/KutU4O6So3KJi1TNV
	 /1QHXy+kxOZzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F4554083C;
	Sat, 10 Oct 2026 02:43:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BFCAB356
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 02:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5855810C5
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 02:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zbVdY97f744h for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 02:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E182380D1C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791600190;
 b=j8qOBIqwlO9bRtH7nrWf/NrA+ax4J5Dxfhaee6obptVuydNPYh/eVdhNP6C3dxrd84yY
 BIySMKYQvn7mQhvCAPkfhYyzsI1qHi3A9AiJ9gzQqtUScpX9EiHwrglMguxqL3PyQeshq
 LyiHB2jDAjhLgSmePlSR1BFmqpbF/o2IxgLuyV0Ymdn2gBQcJtzxS0v+GDLiAvSzpb80M
 TS/7k3suuhevSdxw3tCB4j0S1piHoDPBJa7YctA3RLYHRdo3QJaqYToXp0Tl6kXKKALQO
 0BK1HpM0fT+Jcs/RvFpGtJfiljqlid+mOWRdtY9Iu3RhdZCA8bS14WBgNcILtoQHBcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791600190;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=8A778y+EHCDdvBAGvePyfYbo2je/GcH8SNuJ7ZUUv1s=;
 b=WUAhEaPnI3v6rNkxzXFtiX4+OAZ0W5gVJr2i/57BWemkeRNrKuKltW4iYN7wfrkfcRUz
 84pBmCO8lKZ52hKeb45zwMDav1olSVFZpQ94q1A14HZLhikw22bOykYrHrf48q2WevBPG
 5nI4bGPm/uYNMfmy/HRW0qW8f108BwJ4BBrA4Ckk1fYJ/limiPQ57uTQ1sUpW+bHHxQ0m
 RegxW6ecAxe9w+pewKhj4twT8CaOAwvRWFdReLrh5m498Dh9v/HagF3iyBiLt1MbAsGyA
 2CJRWeLYUJrQXpJX5u6xZdHBCsLIE0AV+DFSF9xsACmvdrXm6RbUJytGyThaNWRYBcA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=hBZJsTWq; 
 arc=none smtp.remote-ip=117.135.210.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=hBZJsTWq
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E182380D1C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 02:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=8A778y+EHCDdvBAGvePyfYbo2je/GcH8SNuJ7ZUUv1s=;
 b=hBZJsTWqt7kh+8xL19ERcebtfKTlu3kU9JXXU/NamoxeuAcLUZXmVXzApPF72G
 tw2SV6yB2oY0pUVzBW2qLDlNfoqyRsmNOhriGSRQMb6mV8I79eyWVhCirDGKDr2F
 MFCIbXkkrpmL0Cz8FspmH79g7riEO/Q/l++n4tvfXk/JQ=
Message-ID: <c4f9c654-614a-44c9-b96a-31883df45e4b@126.com>
Date: Sat, 10 Oct 2026 10:42:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 2/3] ice: detach the VF representor when
 ice_start_vfs() fails
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-3-xiaolinkui@126.com>
 <sashiko-outbox-165587@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <sashiko-outbox-165587@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wD337UppslqfFM7BA--.16219S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrWUuryDtr43JF1rCF4rXwb_yoW7WrW3pF
 WvgFyUKryUXa409w4kuw409ry8u3y8KFyUGrn7KF4Fka15Cr10qr12kay7Xw10k3s7Cwn0
 vr4q9wn7uw4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRGhFsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlQvAl2rJpitH6gAA3K
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


On 2026/10/9 21:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ice: ABBA deadlock between pf->vfs.table_lock, devl_lock, and rtnl_lock
> --
> 
> commit e31928012cb273c164e36248e1b33c296e805e8d
> Author: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ice: detach the VF representor when ice_start_vfs() fails
> 
> This commit modifies the error teardown path of ice_start_vfs() to explicitly
> detach the VF representor. This prevents memory leaks, use-after-free
> scenarios, and stale configuration states.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
>> index bf6410c0d85d4..13d97dbd517c8 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> [ ... ]
>> @@ -520,8 +520,27 @@ static int ice_start_vfs(struct ice_pf *pf)
> [ ... ]
>> +		/* Mark the VF disabled before its representor and its VSI go
>> +		 * away, the way ice_free_vfs() does, and take cfg_lock
>> +		 * around it to wait out an ice_reset_vf() already in
>> +		 * progress. pf->state has no ICE_VF_DIS on this path and the
>> +		 * loop leaves ICE_VF_STATE_INIT set, so without the bit a
>> +		 * concurrent ice_reset_vf() would pass ice_is_vf_disabled()
>> +		 * and reach ice_eswitch_update_repr() on a destroyed
>> +		 * representor, or trip WARN_ON(!vsi) in ice_dis_vf_mappings().
>> +		 */
>> +		mutex_lock(&vf->cfg_lock);
>> +		set_bit(ICE_VF_STATE_DIS, vf->vf_states);
>> +		mutex_unlock(&vf->cfg_lock);
>> +
>> +		/* detach outside of cfg_lock, see ice_free_vfs() */
>> +		ice_eswitch_detach_vf(pf, vf);
> 
> [Severity: High]
> Does this introduce an ABBA deadlock involving pf->vfs.table_lock, devl_lock,
> and rtnl_lock?
> 
> ice_start_vfs() runs with pf->vfs.table_lock held. Adding a call to
> ice_eswitch_detach_vf() here establishes a lock acquisition order of:
> 
> table_lock -> devl_lock (acquired in ice_eswitch_detach_vf) -> rtnl_lock
> (acquired via unregister_netdev in ice_repr_rem_vf).
> 
> However, there is an opposing lock acquisition order during TC mqprio
> configuration:
> 
> rtnl_lock (held during ndo_setup_tc) -> devl_lock (acquired in
> ice_tear_down_devlink_rate_tree) -> table_lock (acquired right after
> devl_lock in ice_tear_down_devlink_rate_tree).
> 
> If a user enables SR-IOV, triggering an error in ice_start_vfs(), while
> concurrently configuring TC mqprio, could this opposing lock acquisition
> order result in a deadlock?
> 
>> +
>> +		mutex_lock(&vf->cfg_lock);
>>   		ice_dis_vf_mappings(vf);
>>   		ice_vf_vsi_release(vf);
>> +		mutex_unlock(&vf->cfg_lock);
>> +
>>   		it_cnt--;
>>   	}
>>
> 
Thanks for the review.

I agree that the three lock orders do not converge, but I do not think
this patch introduces the inversion, and the cycle is reachable without
it.

ice_start_vfs() already runs under pf->vfs.table_lock and already takes
devl_lock with that lock held, before any failure can happen. Its
forward loop does

	if (ice_is_eswitch_mode_switchdev(pf)) {
		retval = ice_eswitch_attach_vf(pf, vf);
		...
	}

and ice_eswitch_attach_vf() takes devl_lock() around
ice_eswitch_attach(). The teardown loop unwinds only the VFs whose
attach succeeded -- it walks the VFs in the same order and stops once
it_cnt reaches 0 -- so whenever the ice_eswitch_detach_vf() added here
can reach devl_lock(), an ice_eswitch_attach_vf() has already taken it
earlier in the same call, under the same table_lock. In legacy mode
there are no representors to begin with: ice_eswitch_detach_vf()
returns at its xa_load() before reaching devl_lock(), and nothing
attached either. Either way, table_lock -> devl_lock is not a new pair
here.

The full table_lock -> devl_lock -> rtnl_lock chain is pre-existing
too. The other two callers of the same helper hold table_lock and reach
RTNL through it:

	ice_free_vfs()        table_lock -> ice_eswitch_detach_vf()
	ice_reset_all_vfs()                  -> devl_lock()
	                                     -> repr->ops.rem()
	                                     -> ice_repr_rem_vf()
	                                     -> unregister_netdev()

That is in the baseline, not added by the series, and the opposite
order, rtnl_lock -> devl_lock -> table_lock in
ice_tear_down_devlink_rate_tree() reached from ndo_setup_tc, is equally
untouched. So "echo 0 > sriov_numvfs" racing a TC mqprio configuration
can reach both halves today. This is the same pair that was raised in
the v1 review, and the conclusion has not changed.

That said, the two orders do not converge, and converging them is worth
doing. It means taking devl_lock outside pf->vfs.table_lock in
ice_ena_vfs(), ice_free_vfs() and ice_reset_all_vfs(), plus variants of
ice_eswitch_attach_vf() and ice_eswitch_detach_vf() that expect
devl_lock() to be held, since devl_lock() is a plain mutex and the
helpers take it internally. That is a lock hierarchy change across
three callers and the eswitch API, and it is unrelated to the
cfg_lock -> RTNL inversion this series is about, so I would rather send
it as a separate series than carry it in an iwl-net fix that has to be
backported to stable.

No code change in this series for this report.

Thanks,
Linkui

