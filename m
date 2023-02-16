Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF1DC61DA4
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Feb 2023 16:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 950AA612AE;
	Thu, 16 Feb 2023 16:17:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 950AA612AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676564232;
	bh=M9wMjJvmpfoJsuPTVikO1GWvixN3ky0zTJkgbEhumPA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=1a5uuQaHuzcsqjGWbB2LrI4inwmK19EqTTL1TVasbIvKMfEfEO9MY4w39IVtwc8wM
	 Y0OU8p0jACxTKMkjEhkFbz3jgXV7h3TVB/PEf+C2lHGfGlejnQXcT2Uv/cFn9bKisV
	 ZlqbPIWoGr6E+XjmAdRcUXi6MG4Nc+lGGdfPT32u9hH1AW4zSi6jdceP8VJIRku4IK
	 YHct/cajIK/7eFCh3URIOKogi39kvOscl9shYf36qRGzSQMEmfbzxajFpeD7VgruLI
	 CqK1dunjm04n1EbPT98v4/VgfEMejch6ddeVlSaSIadUJ9MoP7ll/tza7qqVeK6M4l
	 8BTq5nI6ehn6Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M54oDvq52gm7; Thu, 16 Feb 2023 16:17:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9222E612E8;
	Thu, 16 Feb 2023 16:17:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9222E612E8
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 6B0EE1BF5A5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 14:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 440A5611ED
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 14:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 440A5611ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1545jurOh5Av for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Feb 2023 14:15:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB810611E0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB810611E0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 14:15:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359154729"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; d="scan'208";a="359154729"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2023 06:15:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="738838086"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; d="scan'208";a="738838086"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com)
 ([10.228.151.145])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2023 06:15:21 -0800
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 16 Feb 2023 19:30:35 +0530
Message-Id: <20230216140043.109345-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 16 Feb 2023 16:16:58 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676556926; x=1708092926;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fsJ7tkzoRMYYZP+YP69kJtDBOxvaeo5jJEicj0uNYjI=;
 b=m+nKpEDZojFu/P+CjdwWSr78XkL3Rvagh57ydqDhbgxH/5WFxSCxD8Fk
 Zx4aRAf6F+sbsN4G7uRJNaqo1ziFEcY0fEZy70ltN9BMoKsTnp6yqnlaR
 bn9VD73bxnpEe21NUbm7ELh5psGcFHijFwpnImz05t6+erSsy84J46VUN
 pcMvPegLhNwX24nIxawi1IR/5/PyVVLyWffcU0CQnZrKhBEAIZgzvdvNb
 R26GOVoWSEOFYfHtXgy5nkIeYSgXDA2Woy9rE5LsFsHHhmKfx2QgWqom9
 wWV3GSy3HlxgO7Xxwp6ZEePDjSptL721Wt6kpz0DRpCKiLO9WG9fUxleA
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=m+nKpEDZ
Subject: [Intel-wired-lan] [PATCH intel-next v5 0/8] i40e: support XDP
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
    v4 -> v5:
    - Change s/size/truesize [Tony]
    - Rebased on top of commit 9dd6e53ef63d ("i40e: check vsi type before
      setting xdp_features flag") [Lorenzo]
    - Changed size of on stack variable to u32 from u16.

    v3 -> v4:
    - Added non-linear XDP buffer support to xdp_features. [Maciej]
    - Removed double space. [Maciej]

    v2 -> v3:
    - Fixed buffer cleanup for single buffer packets on skb alloc
      failure.
    - Better naming of cleanup function.
    - Stop incrementing nr_frags for overflowing packets.
 
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

 drivers/net/ethernet/intel/i40e/i40e_main.c  |  78 ++--
 drivers/net/ethernet/intel/i40e/i40e_trace.h |  20 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c  | 420 +++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h  |  21 +-
 4 files changed, 307 insertions(+), 232 deletions(-)

-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
