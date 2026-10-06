Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF37CA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 11:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34BC540508;
	Tue,  6 Oct 2026 11:43:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKQxFM9nw1a0; Tue,  6 Oct 2026 11:43:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9452C40500
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791286988;
	b=Iom+vDj5lFsu2EImIej6cjuODfN8hxocFXvV+W/rgu64YyDBNma3E7HkkD+HC3aD7qSp
	 CYR8IKgkBYKvBbcHdne2nbkqSKZYzfcz7CSQNISqcPq/wT9c8LWPeVUYVlbc1wsEmSE9u
	 1RJcCuGAEY8E+zajUNn1n+BsO4nsDITGDLCBgOKkea9rtrC3BzPKrkp0JO5d/UMrACSzD
	 3L78i4N2BnRSsVhwTlSRi1HhL2bbIWpxXr/5wchNm3mqp61FfeH4EZKvUqTK5b94rqqXM
	 p4eEL/EtDj8Oog7qO5LXjR+JnSmFBbIkxZtiKIq69vmYoMwpVVNg8c0q3EYq/tbGR4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791286988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ci8zs/pgsGW58QAglboae0FkmezhyVolvzrI68+fBwY=;
	b=Dr8LN9sioUjyT2BOVIMIwsNMh0qveMSr5E32e39T8AzRmOoDe/Zi+2ksuc+H0/TZ/UL5
	 MZCm9MS+62dHr1Dnp0UjPiN6/oU/WgYbXHet78Y7W4sTu3I5O6KcrUeaZSlyRBKGIaEvN
	 Bx7bo5u/tqTbGwyuLq+khYkLwpaLQt+U2GCvptgGKAg6vGIYXuZAs7DGQxm6eb4a0QUo8
	 iAMeSxsVhsRHNUSfTPZipUyQO9UOvrwW1pjMUtxIjXCT1fGAXvj1VonXq8ebEAHcOX/S+
	 VOrkxdOzWEWGBNqVbeRmqqEupA6sEB2y5eKZX8YGOXbsHgoxyiL31CgtV59SK3BnjdQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791286988;
	bh=ci8zs/pgsGW58QAglboae0FkmezhyVolvzrI68+fBwY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hfv4TprvsTLo8EE/h/+zvsnqKbCnOeGsCSclwY07ARQi9LlKTdKSoDVXljf6XwnZC
	 Cs4cjJK2B2kj1huyLrlPBmq2VRC/pODjaulp9bcTP37izWtKIthRUJgCWd5JAKsinJ
	 H7QXNsBu8pZVl/ti0O2kUQcV1dn/VqbR/iRxR/pKNn9FfZViRnziPmyJ2da3hinZM4
	 N6Lkx+EIdMvYEAVZtgsjRduWmgbQRNrtpfI0MKwbwQ8di8xUB+s9IoRIZxRhNzMNzf
	 Mcn2CQLvzjd44g59NOooTYd4xi/qq/g6jCYdVglMSkq7JXxQm7MyV5y+J2zuzk+mAf
	 owmKd8cDVNlRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9452C40500;
	Tue,  6 Oct 2026 11:43:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A40432F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4007D60716
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:30:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9sQLgMpgXcHK for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 11:30:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3051460778
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791286250;
 b=DrKWpdhk1/cCT0nhk4PDunbQS8I3H1eDkf9tYgZzbWeTwrG2MihX9nnbMp0nq8Uu2BCw
 +mKbfwGwvPALmr+1vzkOIOrK0YxxW4yTOLNHzj4bHuXjM4HTDj0oyBbSFFXNX37maPUIK
 zm8ilK/ftCQGi+Dj8Sau2sRQ2yIWalCDdSDKxvOn9+bPoG3HrzdgEOn2Vy5+gKV+OYwWI
 Edcb9/ZRs4iHFzk8YUoNG/Zg1u18Pd9kp+OHW4x+IDKME3YGU70EbLKtOh8xrxuqmx+cI
 WXNVRU4aFskSpeKKdn1AJ5FLsPcFLas1FC4D8UixIFvnBLSjwVjK5Zs/e3iScek+tQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791286250;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ci8zs/pgsGW58QAglboae0FkmezhyVolvzrI68+fBwY=;
 b=HqNEcj9Ie3IywbIAbN1XwIpT25jRT9IaYLcs7iC+uNsxM8hNnce/uG50QWpet1xndgW6
 V2JyqNoghVuCwgvnqsIoCJTq8ghorpI2MYBNch7SGXV3roB1J01xDA7KD3qHYZcywVoay
 iEq3SJAlc9M41j6LY0epaPyTofKIluIghecxsgESK+UFsPIsjBPTveX1CwTD9xFLwLLTv
 gBAs8fiGWk318EPnnO+Vyj+htIloKuv4ribGnosROIZ/q2SynglfgzNQU6vcdDeTzxuY1
 J+J3HCA/HLlDIiPZ7m+dzvNDIOhVfVAMP37JcAi7yjsgLTvAU3bCkvQjEJKlR9uZGSg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EEQ4K85I; 
 arc=none smtp.remote-ip=192.198.163.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EEQ4K85I
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3051460778
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791286250; x=1822822250;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rJ5QpzyhBiOjL0Ld9zuTpWWDcJOeJeuWBATcSjkHKLY=;
 b=EEQ4K85I7z1VoGmBtQdzFQxcl14THKsU4w3Zs/oGGAKe/6w5IHtEy/Qf
 Fi2P4ya83riZxb1/Jhya4phbGaFgvLoVfa3j+fhw9zpwzTSlBlPt4zIKo
 PwHx479+x5zL0U8E9Uc4xmTHQgrbRDDvZVlL/eI3+/88oTgi4QI9CdeHY
 EKOgBTL2j+O6pieT01MfUWLjewx8KGGasiuUhGbyrZGGonj7GWUnrKHnP
 zB2Y49TgxbvD67CRcBPVzG5u5GmC3OlM21usH42PojsEA7D9ExOdeGXY3
 Pd2eNz8e+rsdBgBImSC3e8VxM40lX1x3BJmkDVSl+Sl86HtHQLiT3iB+/ A==;
X-CSE-ConnectionGUID: 3O/1XiFIQ4GY0bfDe77/0Q==
X-CSE-MsgGUID: c1wWz6ZNTyeCxKM2ZFQC6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="27710"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="27710"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:30:49 -0700
X-CSE-ConnectionGUID: jfMyv6oQSvG0wZAZd18Riw==
X-CSE-MsgGUID: 3W4bqqUmRtmgp4gFHkGt4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280370482"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 04:30:48 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 0/2] ice: offload not fragmented ip packets
Date: Tue,  6 Oct 2026 12:47:02 +0200
Message-ID: <20261006104704.3584666-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,

OVS in default mode adds tc flower filters with "ip_flags nofrag". ice
rejects any match on control flags, so these flows can't be offloaded
and all IP traffic goes through the slow path.

HW has a metadata flag that says whether a packet is fragmented (IPv4
or IPv6). Use it to offload the "not fragmented" case. Matching on
fragments isn't supported, because it would need different training
packets and would break L4 matching. Tunneled filters are also
rejected, as the flag can come from either the outer or the inner IP
header.

The first patch is a preparation: all 32 bits of the tc flower flags
are already used, so the field is extended to u64 and the defines use
BIT_ULL(). The second patch adds the nofrag match.

Example:
$ tc filter add dev $VF_PR ingress protocol ip prio 1 flower \
    src_mac 0a:7a:c1:6b:8e:1c dst_mac be:9d:68:58:51:d8 \
    ip_flags nofrag skip_sw \
    action mirred egress redirect dev $VF2_PR

Tested with iperf traffic between OVS bridge ports in switchdev mode.
All packets are offloaded.

Michal Swiatkowski (2):
  ice: extend tc flags field to u64
  ice: allow matching on no_frag ip packets

 drivers/net/ethernet/intel/ice/ice_main.c     |  2 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |  7 ++
 drivers/net/ethernet/intel/ice/ice_switch.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 51 +++++++++++---
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   | 67 ++++++++++---------
 6 files changed, 85 insertions(+), 44 deletions(-)

-- 
2.49.0

