Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C78C88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24C8580D1F;
	Tue, 15 Sep 2026 17:18:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QYPIqi4oiIAF; Tue, 15 Sep 2026 17:18:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D82D80D4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492693;
	b=c14eDOoqM+0aI82bnvNCc/ZsudP+QNB+JkP4x8SemCX5wAikpTjiuqL3fg++1NqTT1M/
	 32uHXa3tZ7Xc7d0Qhujn852mWT5C2HSDUuywOVaOzmTxxBZ6PJoCfs5K45HZtTn7Hmbsh
	 RGxB+l69s6yVERCgognMjWHtqSYu0X7IWdGwS87xjNEKadl/26uNpQJipjYZ+CPWAsNGL
	 +HzJKBEgvVvOlmM7RRuDt329OremOjkafYTy75P4M5QlUfUTI2Vg67CY3Ey0ZV6kOjKPm
	 MpcE6jrXEZZ+9kcLIsuIPvxfVuzqgjnq9j1915MmB75f1fCQ8D62s7JtBEb0bQUXMbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C8YtmFrSxxY0AanUwQl01S3XpkP74Rctp5eoGI1AVSo=;
	b=PEmHtI3qaP8CT9iKLw+pXNVt8fFCD6j6AbWrWje6GEhdVd0N7yMUffDflLAQx+B3dR5p
	 JKI/ah2yBlBwHfVWQ9mrbVfuJKgcRucMC8n9sztWkKXcB/edokMOPvTjbpe213nwNJm64
	 8ymjDP/6I8+sDqacQnVcbn1UIHTZb45jsaDVG9flKuzgYv6r4re6GfpZBf30pDc4MCKde
	 Za+RiONDOkMNkH3l3dUfBnToamicdxJvk5xy5cR6e3+rwNoTHyaOozn+Zx+rMBrk+xDiw
	 tKJ61N0Kiglmj0d02KsOCTbd15QktmCLT1cjr9D2VU07kLXMaFDN5vy6ezoI2uKeLDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492693;
	bh=C8YtmFrSxxY0AanUwQl01S3XpkP74Rctp5eoGI1AVSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rk8VfzUY7buHZoHG6qejEoChmEAbnca20Gmrc+z3q7nHOZGQNy/3JwcDtn40nBtkF
	 csnLSKKyf14Lz3kLrPI1Unm6gnYjEayWBFllJmJZvsf/mSzyQVz4O6KJJA1vHrsXQp
	 zNl0s7EAoYzPB2Ys/c+Q1rig2IdyOsyoKlWnVGR4lb7Ay0uKFH9zjCw8ZqVZ04PNaf
	 tOHQog5MnIovA0q6qGK8QuZVYpzg6kWQkPK84iRdQ6+LAsWepvl7e6gcq1GJzsmTM5
	 0tR46J91GDuXWu3rjffepJah1hmm6v0/WZ5uhs59k+1IfMf/JBr7yigsaNUhaHkKBo
	 YSe0VQ42bxQAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D82D80D4A;
	Tue, 15 Sep 2026 17:18:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E3B1259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 15:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5040D401F2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 15:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KdTTGGfflkTc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 15:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 59627401DD
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789486503;
 b=GdtpEgtdLWHNjTgJlAxY9kgE4d5wqCFye3QwL6RW3YRTvqusgW8oEkO/sbX+Nn8ymHdr
 FV6yJYyfKbrUcF2LhqlPWiffoFMIrsGGFT26Rru0KDCs9aHByXfP4WvU7kRTbFYJPglZ6
 uQXVrTQ/7FbyDXEoDbXS45Lsqoj+v+5XvZ+MvPdpkjdBqllL9D/WbuMvUtQHlluej7f6X
 rmir1PN+xFjkGGalswKOXfsNb+pksRUVXJKv320yHQQfVRGisINqlEyhX439gfocanU/h
 RfR129ZHOiU/jIxTy92t+VWheV+mDCYWCp5SY0jj/Sfg++JlxPsXlpr8vHhu6tWncHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789486503;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=C8YtmFrSxxY0AanUwQl01S3XpkP74Rctp5eoGI1AVSo=;
 b=hOTNl+LLPNa9MaeqWQoa8DliHfsxksG0AsimDBfG6jN/HCSDt1sTR8YPKrgteQfKmt0p
 plbN3V5ChL1rmEnA5RFbwRYbwq24caxdD7lV5xjJlLa4blAiAmMaqqfrw+DpbYyhMiQD4
 lAQT6zXjiwl3uhe0dsqCPL+8pUp2tgX+9zaH6J2eEo1JU3GrSjtblRILIt0Pl2ZFw1bnQ
 mtdvPz0HHz8ePOQ/THrHFNeH4Y4uLFglpdEYnOGPAoSbQ5Huot+3c5CYUcpzE9eGMd7x0
 RqQ/67/DK4NfZNIhbU6jvbvmu5o5jS48D8r+a6o/TR12j3q1BF889fACb2ouhaQhM8Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IW909MCL; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IW909MCL
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59627401DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 15:35:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A52C600CB;
 Tue, 15 Sep 2026 15:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D371F000FF;
 Tue, 15 Sep 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486501;
 bh=C8YtmFrSxxY0AanUwQl01S3XpkP74Rctp5eoGI1AVSo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=IW909MCLfVufJ47Dk81WpQU98oBji+YOqUk+hhsJMij2kDBlow3e5+Mk3Hbr39SeX
 4SkVw2pKjycEzdiwb87/aZx1HwR/TgIQBDHvwWIYWw1lLj7em2fDkheTDS4V55TyEd
 jpP8mtDcpwR21X6Lq399/aXjiQ7cCCeDPPnwIYo2PEq5Vfr1JCiT+g+XKhDdL/w2fY
 eyLQlhJPQ+lyWtadRBnhM2HrK4JDgy6xX8LPg+8A9LzyNBRdGHKRyYCPq1FVH2N6hE
 NkP8LxAZTxftQp4KtPk85kAkT40FfUIpxG0eKsaJuK6dPR+3xR4DvGSaWL2xvdsx2x
 lF6KcqN0GFxQQ==
Subject: Re: [PATCH] ixgbe: fix incomplete ACI command buffer backup on retry
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn, kuba@kernel.org
Date: Tue, 15 Sep 2026 15:34:59 +0000
Message-ID: <178948649971.22033.11309152117855565563@kernel.org>
In-Reply-To: <20260912013403.2818191-1-xiaolinkui@126.com>
References: <20260912013403.2818191-1-xiaolinkui@126.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 15 Sep 2026 17:17:36 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] Commit message overstates the impact of the fixed bug.
- [Low] Commit message names the wrong ice function as the reference
  implementation.

--

ixgbe: fix incomplete ACI command buffer backup on retry

The patch replaces the kmalloc() plus single-byte store in
ixgbe_aci_send_cmd() with kmemdup() so the whole indirect command buffer
is saved before an EBUSY retry, skips the backup when buf_size is 0, and
keys the restore off buf_cpy instead of buf. The code change itself looks
correct; the questions below are about the changelog only, so the diff
hunks are snipped.

> So every retry hands the firmware a buffer whose content, apart from the
> first byte, is uninitialized slab memory, and on a read command the
> caller's buffer is overwritten with that garbage when the retry finally
> gives up.

[Severity: Medium]
Can the firmware actually see that garbage?  In
ixgbe_aci_send_cmd_execute() the buffer only reaches the HIBA registers
when the descriptor carries LIBIE_AQ_FLAG_RD:

drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:ixgbe_aci_send_cmd_execute() {
	...
	if (desc->flags & cpu_to_le16(LIBIE_AQ_FLAG_RD)) {
		for (i = 0; i < buf_size / 4; i++)
			IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), ((u32 *)buf)[i]);
	...
}

The backup/restore path only runs for the opcodes listed in
ixgbe_should_retry_aci_send_cmd_execute(): disable_rxen, get_phy_caps,
get_link_status and get_link_topo.  disable_rxen and get_link_topo pass
(NULL, 0), and the two that do pass a buffer (ixgbe_aci_get_phy_caps()
and ixgbe_aci_get_link_info()) build their descriptor with
ixgbe_fill_dflt_direct_cmd_desc(), which sets only LIBIE_AQ_FLAG_SI.
LIBIE_AQ_FLAG_RD is OR-ed in only by set_phy_cfg, the NVM write,
nvm_pkg_data and nvm_pass_component_tbl paths, none of which are
retryable.

Also, on both EBUSY exits ixgbe_aci_send_cmd_execute() returns before the
"Write a response values to a buf" block, so buf is not touched by an
EBUSY attempt and the restore is effectively a no-op there.

Would it be more accurate to describe the effect as the caller's output
buffer being filled with uninitialized slab bytes once retries are
exhausted, rather than as garbage being handed to the firmware on every
retry?  As written the message suggests a functional firmware
interaction problem, which affects how this reads for stable triage.

> Use kmemdup() to copy the whole buffer, exactly like the equivalent
> ice_sq_send_cmd() already does.

[Severity: Low]
Is ice_sq_send_cmd() the right reference here?  That function is the
low-level control queue submit routine, the counterpart of
ixgbe_aci_send_cmd_execute(), and it has no buffer backup.  The
kmemdup()-based backup and restore-on-EBUSY logic lives in
ice_sq_send_cmd_retry() in drivers/net/ethernet/intel/ice/ice_common.c:

drivers/net/ethernet/intel/ice/ice_common.c:ice_sq_send_cmd_retry() {
	...
	if (is_cmd_for_retry) {
		if (buf) {
			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
			if (!buf_cpy)
				return -ENOMEM;
		}
	...
		if (buf_cpy)
			memcpy(buf, buf_cpy, buf_size);
	...
}

Could the changelog name ice_sq_send_cmd_retry() instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912013403.2818191-1-xiaolinkui%40126.com
