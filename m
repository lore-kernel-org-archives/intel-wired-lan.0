Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BB3C05027
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Feb 2023 16:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF07E40888;
	Tue, 14 Feb 2023 16:20:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF07E40888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676391657;
	bh=OMO9uv5HtUTPvmUC/Vg3Ar0twzvXGHh97bnajiasvVc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=0Z7O8oXazjtDihLOlAkkcXJu37it62Icl1VvJHiz/HsYXF1sILHB4BGIT//qOohGk
	 iCWoYcSd1wAN9+JUbVRbrOqG5VRdixDI7KTzzjdmjTpmaHS6DvfNbeNAVoQerPC6MJ
	 QH6cnKAlMP0Q8mO8QDsqtjr1LGW22kUllsVqo7ucEve6QhWe5ojK9+1VrkD6Ryf02K
	 LnGkjCuqqjaYwFgnENKnY7dCjx13Gg40Pk/dlNvuAzlV0cr7cBZ+qW1lMW2v+s2ZRH
	 aEvWVuYBFHLba0p1bFm6BfDPfLs1zJDF+/nSnqlZuW+6Y86nMQreXgAvm3fW1y1E1e
	 ntmwItVDHTrGQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XeLdZ5dBqqoI; Tue, 14 Feb 2023 16:20:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63FA6408EC;
	Tue, 14 Feb 2023 16:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63FA6408EC
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id D54C11BF3A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 12:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A758E40941
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 12:44:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A758E40941
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u1cZfCpXUggz for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Feb 2023 12:44:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EC504091C
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EC504091C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 12:44:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="417371180"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; d="scan'208";a="417371180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 04:44:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="778308573"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; d="scan'208";a="778308573"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com)
 ([10.228.151.145])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 04:44:41 -0800
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 14 Feb 2023 18:00:10 +0530
Message-Id: <20230214123018.54386-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 14 Feb 2023 16:20:51 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676378683; x=1707914683;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OrE22GD7r67H+UcsZxEmeqJh5Yp4voO/0pi2b0/zvnU=;
 b=LP1EVAC0wBy8aUYSQzbxPJAY9lUWxXUaLAixnRIl05Ayf4sEV/h+sGlX
 bo6r3y2vhM4hIRVYC66bn133mzpu44YbS0457EJialCPi10tbaoJJ1w+O
 mB4aHVuDg6LMRMM4LPaVPOHaZ+IT6L6eJcZTYEYWN7ttzpOkZvhBbKObB
 YF4bX2286wrBgEyrc4dRxjIDVE6RLGxsulW2tTun6q4229ZfWqsZiexSi
 Oj/SOw8mbeI37TFFBm9ytqniOjd+pHEmZgqSfqFTfBvbzm8notMwfkfIK
 zPSlcS3g6n1Jl1o8wBUF7lgWJR2mg6Yb7S41cdGULGWsE+WPe4UVOVRq3
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LP1EVAC0
Subject: [Intel-wired-lan] [PATCH intel-next v3 0/8] i40e: support XDP
 multi-buffer
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
Cc: tirthendu.sarkar@intel.com, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, bpf@vger.kernel.org,
 magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This patchset adds multi-buffer support for XDP. Tx side already has
support for multi-buffer. This patchset focuses on Rx side. The last
patch contains actual multi-buffer changes while the previous ones are
preparatory patches.

On receiving the first buffer of a packet, xdp_buff is built and its
subsequent buffers are added to it as frags. While 'next_to_clean' keeps
pointing to the first descriptor, the newly introduced 'next_to_process'
keeps track of every descriptor for the packet. 

On receiving EOP buffer the XDP program is called and appropriate action
is taken (building skb for XDP_PASS, reusing page for XDP_DROP, adjusting
page offsets for XDP_{REDIRECT,TX}).

The patchset also streamlines page offset adjustments for buffer reuse
to make it easier to post process the rx_buffers after running XDP prog.

With this patchset there does not seem to be any performance degradation
for XDP_PASS and some improvement (~1% for XDP_TX, ~5% for XDP_DROP) when
measured using xdp_rxq_info program from samples/bpf/ for 64B packets.

Changelog:
    v2 -> v3:
    - Fixed buffer cleanup for single buffer packets on skb alloc
      failure.
    - Better naming of cleanup function
    - Stop incrementing nr_frags for overflowing packets
 
    v1 -> v2:
    - Instead of building xdp_buff on eop now it is built incrementally.
    - xdp_buff is now added to i40e_ring struct for preserving across
      napi calls. [Alexander Duyck]
    - Post XDP program rx_buffer processing has been simplified.
    - Rx buffer allocation pull out is reverted to avoid performance 
      issues for smaller ring sizes and now done when at least half of
      the ring has been cleaned. With v1 there was ~75% drop for
      XDP_PASS with the smallest ring size of 64 which is mitigated by
      v2 [Alexander Duyck]
    - Instead of retrying skb allocation on previous failure now the
      packet is dropped. [Maciej]
    - Simplified page offset adjustments by using xdp->frame_sz instead
      of recalculating truesize. [Maciej]
    - Change i40e_trace() to use xdp instead of skb [Maciej]
    - Reserve tailroom for legacy-rx [Maciej]
    - Centralize max frame size calculation

Tirthendu Sarkar (8):
  i40e: consolidate maximum frame size calculation for vsi
  i40e: change Rx buffer size for legacy-rx to support XDP multi-buffer
  i40e: add pre-xdp page_count in rx_buffer
  i40e: Change size to truesize when using i40e_rx_buffer_flip()
  i40e: use frame_sz instead of recalculating truesize for building skb
  i40e: introduce next_to_process to i40e_ring
  i40e: add xdp_buff to i40e_ring struct
  i40e: add support for XDP multi-buffer Rx

 drivers/net/ethernet/intel/i40e/i40e_main.c  |  75 ++--
 drivers/net/ethernet/intel/i40e/i40e_trace.h |  20 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c  | 420 +++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h  |  21 +-
 4 files changed, 305 insertions(+), 231 deletions(-)

-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
