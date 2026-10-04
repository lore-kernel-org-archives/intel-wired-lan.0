Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF1FCA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 15:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DDC36070C;
	Mon,  5 Oct 2026 15:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XcdN2a-uv0ay; Mon,  5 Oct 2026 15:26:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5536660657
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791214001;
	b=ITO1iiILLwCEa1ReJiWTm2pneKc63d8Mp72vrXQSobbk43h6j8jM+vuU4wIVhasWC4ar
	 Dp8ErpXL9Ad8wlAXJN/u/oJXiFEdNcSPPeisJam+NvDECvbeoIn24LeL13XP1ekGRByxp
	 CgZLbjSSxNRPJfInAbmUgblpIe/4YVmEwKm+2VKIQOrBOwOuVOwA6yLWs/0hhNXnPB7Bw
	 sKu9NVQkRRH1TeEsuXvr+YlGLXuBfQezVjCLr1iSS+hD3UNSE8MGVI9ppzmpgYTZ0i7IH
	 N/tKr2G7696sT0O78nBSOfbuVgwwaFbvoo2vqcLADF7aWgJ63vajZ9y17aNRZfCtkRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791214001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Bm-Milter-Handled:
	 X-Bm-Transport-Timestamp:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/JUPP2K651TyiY5IxJyeIhiop1q+4AjmYG5wbE+Emdw=;
	b=s4uB7R2qhcVmJcGzT9tqjXrCBFHS6Qk7z1I9cKnocsO8Yb6CVS29YiFv13L6OgoK+Gbc
	 IESjq+YKj/4S1NFjM3rxaY97Djf/EpElXbVf/bqZWBwXfOi2+8lj6jnARXqu8Nl3p5PbO
	 jANgQEre2i+HimqV4JzUxPzarxcnkLN/pOqL24LffnOmLY9c1upbSGID6nfUdqbd9M/i4
	 Ex4Hy2YCgxsGa11JxbbKJVpjJfDmniIq+rUgDdnWYBSGB2gus9mo4zS/u+gdsFuiI5KpL
	 56F49zBk52dCDi6wEUOLD4SlQ4HorwTGKviZIogjp/IlqUkjO1iKXijnDM12pfCUJow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791214001;
	bh=/JUPP2K651TyiY5IxJyeIhiop1q+4AjmYG5wbE+Emdw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QUC522OWmB0kmZ4lhjUu/VpdUISTvSwXZSh5BQeDFMOdZJufhZo3IOxPimP2qoUVz
	 Yn1rODlyriPNYdCaBLh1W3AO9b3zBNwAEN3Z70XiT8RUO0pX36nh8oWuuOW1o/aS2g
	 xuXqV/Y9AcdEZTZ/nL6Jmu7Lv6ERGkmCdBu8O+0DsmBDhIKv7LIJhA0OtZl+nIY1Qu
	 yMRfBKUpQBgROclEPlWLGXgHou/7wn9UCkbrcUMiuq8D3VIS/L7FbAUMYPtk+C8AKt
	 Pbub51R/2a3enR+8yM94Cvol9LfMN7dFgP1joPyggex4N7R2l2K+vpxaFv6b5hrLKV
	 PoEFeXdIILwyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5536660657;
	Mon,  5 Oct 2026 15:26:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4C7C34E
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB02C406C5
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2VhwBxafVs5 for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 19:50:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3748A406C4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791143458;
 b=lzc6CE76NDWhgxyOwCZYaB8rzbbauHTnufQZUHEKykOXsaUqnnw5noS5oAxMyKdyxK2R
 uDOceG01EeGpjiKcqLDV27/s8DzJpwhXX9b2s2JNcbZiJLDM3bfVMFOgU/4IKLp5q/cGI
 gmCBoBzvqWMZvj5bxcNZXqDsAs/OnPFtDxK830k/L2iHsgV+RNM81Cedbd1O+duVMlyow
 kHb/kmQnMKme2g1t1PRD65pol4Hv+QCY3gBIfLi864omU/0AN1QRc8nEE52T1WkO3SEfe
 OaEeSzDi2SOGwsRp87cDd77PYoC4CeVQ/QTHOHkI+fhVY6iSOlLu1pa8aXoaumxGhdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791143458;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-Bm-Milter-Handled:
 X-Bm-Transport-Timestamp;
 bh=/JUPP2K651TyiY5IxJyeIhiop1q+4AjmYG5wbE+Emdw=;
 b=JVFQ2oCI0Cuvm906zIJBFFTfC78V78qsYz8jsJRwJ8tlaBX/IRz8kMA/j1sgpNEpyT0X
 VlOUjvBWmVi+9Jiw4MCdP1vlhJMxrp3v0LPmvD+Jt/Q19Dj9ctGRctS+vJDXDpknVch7e
 yyumyYNGebJa3kfG+hR1Pa+wh2UWrc2T6yrln1+sRkc1JnvmNVtCajMF2t3TsiJBavc5z
 7YwwbhWO/IAYXxk3k/PPMVodlrAoQUG844VpW8rPqyS700Xhp3bLFgoXVa4D6IHMiTdmE
 CvRbitoXoJrbNNh8fyaLJygcNzR6jWbHFZ0PDCgB1FyYGsjHDoUaf/blnptlH9ukbbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=proxmox.com; 
 arc=none smtp.remote-ip=94.136.29.106
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=94.136.29.106;
 helo=proxmox-new.maurer-it.com; envelope-from=t.lamprecht@proxmox.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=proxmox.com
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com
 [94.136.29.106])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3748A406C4
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:50:57 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 807BB47980;
 Sun, 04 Oct 2026 21:44:01 +0200 (CEST)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Don Skidmore <donald.c.skidmore@intel.com>,
 Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Viacheslav Tyryshkin <s@tyryshkin.me>,
 Melissa Romanus <melissa.romanus@proton.me>
Subject: [PATCH iwl-net 0/2] ixgbe: fix MDD handling without VFs
Date: Sun,  4 Oct 2026 21:36:58 +0200
Message-ID: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791143040488
X-Mailman-Approved-At: Mon, 05 Oct 2026 15:25:30 +0000
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

Since v6.17, X550 adapters without VFs can crash the host on an MDD
event, as reported by Melissa on netdev [0], by Viacheslav on
intel-wired-lan [1], and by Proxmox VE users [2].

Patch 1 fixes the NULL pointer dereference, and the out-of-bounds
vfinfo write for events on PF pools with SR-IOV enabled too. Patch 2
stops enabling MDD without VFs, which is how such setups get MDD events
at all. Why the hardware flags PF queues is still unclear to me, all
reports show tx:80000.

For completness sake, on E610, the tx hang path in
ixgbe_handle_mdd_event() looks like it can still reach vfinfo for pools
without a VF if VT mode is enabled without VFs, e.g. with macvlan
offload, that's not fixed here.

Tested on a Supermicro H11DSi-NT with its onboard X550: without this
series RDRXCTL.MDP_EN is set whenever the link is up, also without VFs
or after removing them again. With it, MDD is only enabled while VFs
exist.
Patch 1 is not tested in-depth yet though, as I have no reproducer for
the MDD events themselves, so any testing by the reporters would be more
than welcome.

[0] https://lore.kernel.org/netdev/bqzPMb-F5iRWe7S2DWkQDhsK8u9ZoIaK34sF2pHpAjP6WHFb70Weq3pc8ZIVUoIx2EbPHd6HLBzz1HHd3xb5rxRZ9F3w1L6TQAd87S18CPQ=@proton.me/
[1] https://lore.kernel.org/all/abc23ed3-f194-4546-bf99-7152464b93e2@intel.com/
[2] https://bugzilla.proxmox.com/show_bug.cgi?id=7874

Thomas Lamprecht (2):
  ixgbe: fix NULL pointer dereference on MDD event without VFs
  ixgbe: do not enable MDD without VFs

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)


base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
-- 
2.47.3


