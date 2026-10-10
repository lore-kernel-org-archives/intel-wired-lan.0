Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C3BCA9EBD
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 03:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0E8360675;
	Sat, 10 Oct 2026 03:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHStvNWzSs62; Sat, 10 Oct 2026 03:00:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7822760670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791601244;
	b=ay/J/hpX5n/CZCIIgk7vVlQ+aWkso/jBtAI4bNWJZ6CfVuznU6hNFSF1aDzAGjLIV1/g
	 liC1y1KDF2T4CJsR2gxUPQkqpgeTbH3yu5EcBwNFUOwSpR03tYhH76twumn2QIrTQcxaf
	 mvNMAJT7EMgOQy4MfDsnESqBGuk05hxBnAgZDKnpeaASNb4jtM1yYCYUpouOSPMWpNnwi
	 l1o+o1qVEWToahdHG/wwPLLxxTvhe5uRQSDiGfE590g/ZnQQJUEJdlSt8VLAw09DtL757
	 OIlCdnqMEMs+0fd264qmuavbqOEMARwAUQY2pbPvSvI5xm/o7t9+6FGqxyOFKyET04w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791601244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vDtcZj/VCLBdYGH9s88cSPrUid8+FkW8AKAlKKb/4zM=;
	b=oqFMJzEsa+LEBxnEzus6C97prjWlidj1ak7LVIoquJbfHdCt8mqFZeCWpERY5W5jeWwO
	 akproapXlY5+4kjRdh8fT0otZl9QFeGfqmds8PvY6oUKh9rSStUj4UyXYGZdykpAyxRy8
	 hndvpo7U/UWlHQcZqifzLb2n1vbng6AdcEsxS2slVIW7zQKzfUZxgwpjqQnhPAhKfDdrH
	 VYlw9kXyhEyAVAEmszTvfQXQ/XAS5dxt3PU93Qg3Fp200fuZqNV88g169xiulxpx1wiuD
	 TJbBeqa2I16j7nMCOOCEwJ+4SNvk+ljJom7ecdaaPf7aXnTkVeiUSCvRU9XooiK2fgw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791601244;
	bh=vDtcZj/VCLBdYGH9s88cSPrUid8+FkW8AKAlKKb/4zM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5ezdMaG3TPlSNnBb6z6m34kexTDL4ogmiWNSaiIVnmJGH5m6UjdIVqCz9Y4e5Z7JX
	 vBMAm5j526evDyKNYtPsEAMSpXvi1bioyrF/m3IxM5iJK7CCV2cUcQjjnNnGZIJg8/
	 DmScp3TqRxBv/fLaiEWusR1WhELQ7mTPlp3Q36N9B2q4d7bHRp3acD/hHbkqns8u5M
	 ZJ+Qa50dClfiFZ0zat9b3BfxP+7vYe+ti3uPuX8m7U4QFpKh8KFTGS4CZGdiA7zwuR
	 H7rg2MQt0NQDdMERSKGDKmNmEyM6ugIBYhmRuo48P17w/co1uSbwoOk+wA9dcVDjTp
	 oLBVfDvUFjk8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7822760670;
	Sat, 10 Oct 2026 03:00:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A785E75
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 03:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9083640061
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 03:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kbZ9oMXR54S for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 03:00:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A5CDC40004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791601241;
 b=DLg1MhF6ZV4WijtXbOYcmv9HTcoXz4vdsQS5yNXR9g2jb6f1Ie/6+8wrx9ta5fobR8D3
 Ulaefg9IQQcI5Mx2YmXxGWhPwrW9qmJA1KhkG9x9OkfbllXdfS89mmyj0iHaQgStyLBis
 DZ/nfaFuCNT0r9Xb2XhCm6XgtxukQB0HM/NNLMuXIAx36ti3Ew7MCM82jkcHcNfsq0rEK
 nAEkEZl/MgSVWmXPHkvtV+vQD7zvrsPu6RReBJuEN/P2FVyzajGU5MRvI1vTCrDaL5EoC
 V6VSkcuVDeXbuIAGrzF3JfFptHjiAd7dveRxqoN6VMFWsGI88YqivuooDdbhrmTN68w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791601241;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=vDtcZj/VCLBdYGH9s88cSPrUid8+FkW8AKAlKKb/4zM=;
 b=qzZ+8l0ETShkteAJ5DSI0dH/6qk4rhMAeUnw6Es70ZPMPY5O3HOzi0sM5D6JkVS8jyOP
 ejdDoUdResGRq7dOZja+jLSL7gJ3RNHWgiRqCsNYQfdok70wJaK1S5sNW96CWcGc4l0JJ
 XLZUhudnymWC4rBmfj4BUc0xtxJwNHkWqcIUC6aHtRS/2OPc28LvIzhQ3zvrGKxzipDhO
 6pCHPzFzqKoEDBIDRP3UYrV3CwS8JwlqzJdXzPfSvcfR3y2SxDm41UILYrX4SfDb6u2YI
 BYjMjcF5KsQ5R+l6DPrBCnWJg8NtOgzQ4YWO4DfX0zZ3QW1IWNctE3U5rdWbPuUZ07Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=NMof7q+i; 
 arc=none smtp.remote-ip=220.197.31.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=NMof7q+i
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5CDC40004
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=vDtcZj/VCLBdYGH9s88cSPrUid8+FkW8AKAlKKb/4zM=;
 b=NMof7q+i5PPojy4p4j+CqqWCRAEKTTY9vr+ppDzp0sCB0Lveen23SKe0UUW7b7
 gXpUVcmkoVMGhP1T0+27944FS3jh26D/GXrIMhIzDE/QtvBNABM88ALy6q4EAejg
 Lyqi5SDxmgrcBwKtCXd8dC15Y+HCVqJtpe9MlS6ARXk8M=
Message-ID: <3163779c-c7cf-4727-8b42-499f6d4d4101@126.com>
Date: Sat, 10 Oct 2026 11:00:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 1/3] ice: attach and detach VF representors
 outside of vf->cfg_lock
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-2-xiaolinkui@126.com>
 <sashiko-outbox-165586@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <sashiko-outbox-165586@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: PikvCgDXB_pHqslqmAATBQ--.23665S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWftw4DAFy3ZF1fAry8AFb_yoWxuFykpF
 WFqFyjyrykXrWSg3srZa18WFyj93WrKFy5Gr18KFWSkan8Crn8Jr43Kayj9FW8A393AF1a
 vF4UZ3s5uF98JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhZ2fUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlAjJoGrJqkh95gAA3v
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
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] ice: UAF in NAPI Rx path due to missing RCU grace period after xa_erase
> - [Medium] net/ice: silent failure to apply VF MAC/VLAN to hardware due to TOCTOU race
> --
> 
> commit 32649319eb3be01d6b10e730f49f29871e5cb572
> Author: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ice: attach and detach VF representors outside of vf->cfg_lock
> 
> This patch moves the detach and attach of VF representors outside of
> the vf->cfg_lock to resolve a lock inversion between cfg_lock, the
> devlink instance lock, and RTNL.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
>> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
>> @@ -789,9 +789,21 @@ void ice_reset_all_vfs(struct ice_pf *pf)
>>   
>>   	/* free VF resources to begin resetting the VSI state */
>>   	ice_for_each_vf(pf, bkt, vf) {
>> +		/* Detach the representor before cfg_lock and attach it after
>> +		 * releasing it again: both take the devlink instance lock and
>> +		 * then RTNL, while __ice_set_vf_mac(), ice_set_vf_port_vlan()
>> +		 * and the representor ethtool reset take cfg_lock under RTNL.
>> +		 * Take cfg_lock once ahead of the detach to wait out a reset
>> +		 * that is already inside the lock; ICE_VF_DIS, raised above,
>> +		 * keeps later ones out.
>> +		 */
>>   		mutex_lock(&vf->cfg_lock);
>> +		mutex_unlock(&vf->cfg_lock);
>>   
>>   		ice_eswitch_detach_vf(pf, vf);
> 
> [Severity: High]
> Does this code leave a window for a use-after-free in the NAPI Rx path?
> 
> During teardown, ice_eswitch_detach() calls unregister_netdev() which
> waits for existing RCU readers. However, the representor pointer remains
> in the eswitch.reprs XArray during and after unregister_netdev().
> 
> Because the pointer is still in the XArray, a concurrent NAPI Rx thread
> calling ice_eswitch_get_target() can successfully fetch it via xa_load()
> even after unregister_netdev() completes.
> 
> The teardown path then removes the pointer via xa_erase() and immediately
> calls ice_repr_destroy(), executing free_netdev() and kfree() with no
> additional RCU grace period. If a NAPI thread fetched the pointer just
> before xa_erase(), it will dereference freed memory.
> 
>> +
>> +		mutex_lock(&vf->cfg_lock);
>> +
>>   		vf->driver_caps = 0;
>>   		ice_vc_set_default_allowlist(vf);
>>   
>>   		ice_vf_fdir_exit(vf);
>>   		ice_vf_fdir_init(vf);
>>   		/* clean VF control VSI when resetting VFs since it should be
>>   		 * setup only when VF creates its first FDIR rule.
>>   		 */
>>   		if (vf->ctrl_vsi_idx != ICE_NO_VSI)
>>   			ice_vf_ctrl_vsi_release(vf);
>>   
>>   		ice_vf_pre_vsi_rebuild(vf);
>>   		if (ice_vf_rebuild_vsi(vf)) {
>>   			dev_err(dev, "VF %u VSI rebuild failed, leaving VF disabled\n",
>>   				vf->vf_id);
>>   			mutex_unlock(&vf->cfg_lock);
>>   			continue;
>>   		}
>>   		ice_vf_post_vsi_rebuild(vf);
>>   
>> +		mutex_unlock(&vf->cfg_lock);
> 
> [Severity: Medium]
> Does this sequence leave a window where a concurrent VF MAC or VLAN update
> can silently fail to apply to the hardware?
> 
> If a user configures the VF MAC, __ice_set_vf_mac() calls
> ice_check_vf_ready_for_cfg() before acquiring vf->cfg_lock.
> 
> If a PF reset occurs simultaneously, ice_reset_all_vfs() sets ICE_VF_DIS
> globally. If this happens right after __ice_set_vf_mac() passes its check,
> __ice_set_vf_mac() will wait to acquire vf->cfg_lock.
> 
> As seen in the lines above, ice_reset_all_vfs() acquires vf->cfg_lock and
> rebuilds the VF VSI using the old MAC address. After ice_reset_all_vfs()
> releases the lock, __ice_set_vf_mac() acquires it, updates the software
> MAC, and calls ice_reset_vf().
> 
> Because ICE_VF_DIS is still set by the PF reset, ice_reset_vf() aborts
> the hardware reprogram. __ice_set_vf_mac() then returns success based on
> its earlier check, leaving the hardware enforcing the old MAC while
> software tools report the new one.
> 
Thank you.  Both reports are about code this series does not touch: the
series only edits ice_sriov.c and ice_vf_lib.c, ice_eswitch.c and
ice_repr.c are unchanged.

 > [High] ice: UAF in NAPI Rx path due to missing RCU grace period after
 > xa_erase

The window is real, but it lives in ice_eswitch_detach(), which neither
this patch nor the other two change:

	ice_eswitch_stop_reprs(pf);
	repr->ops.rem(repr);                    /* unregister_netdev() */
	xa_erase(&pf->eswitch.reprs, repr->id);
	...
	ice_repr_destroy(repr);                 /* free_netdev() + kfree() */

That order is deliberate, and it was chosen for this class of problem:
commit e9942bfe4931 ("ice: Fix use after free during unload with ports in
bridge") moved unregister_netdev() ahead of xa_erase() so that a lookup
racing with the teardown still finds the repr while it is being
unregistered.  Moving that pair, or adding a grace period between the
erase and the destroy, is a change to ice_eswitch_detach() with its own
Fixes: history, not something a cfg_lock ordering fix should carry.

One correction on the mechanism.  ice_eswitch_get_target() is a plain
xa_load() reached from ice_process_skb_fields() when ICE_RX_FLAGS_MULTIDEV
is set on the ring, and a NAPI poll is not an RCU read-side section:
__napi_poll() calls n->poll() directly, and neither net_rx_action() nor
napi_threaded_poll() takes rcu_read_lock().  xa_load() also takes no
reference on the object it returns, so an extra grace period after
xa_erase() would not close this window as the code stands.  The lookup
itself has to be made safe first, and that is a different patch.  I can
send it if you want it.

What this series changes is when ice_eswitch_detach_vf() is called, and
that does not widen the lookup: the NAPI Rx path never took vf->cfg_lock,
so it raced with the detach both before and after.

 > [Medium] net/ice: silent failure to apply VF MAC/VLAN to hardware due
 > to TOCTOU race

The sequence is right, including the outcome: both handlers throw away
the return value of ice_reset_vf(), so once ICE_VF_DIS is up they still
report success while the MAC or VLAN only exists in software.  But every
part of it is baseline.  __ice_set_vf_mac() and ice_set_vf_port_vlan()
call ice_check_vf_ready_for_cfg() outside cfg_lock, ice_reset_vf()'s
ice_is_vf_disabled() test sits after the lock is taken, and ice_free_vfs()
and ice_reset_all_vfs() raise ICE_VF_DIS before entering the loop; the
patch does not move any of the three.  The same window is reachable today
with "echo 0 > sriov_numvfs" in place of a PF reset.

Closing it means changing those two handlers, and probably how the reset
result is reported, which is unrelated to where the detach and the attach
are placed.  I would rather send that on its own than fold it into an
-net series that fixes a lock inversion.

No code change in this series for either report.

