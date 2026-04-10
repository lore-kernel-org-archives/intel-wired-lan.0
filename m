Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537F9F459F4
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 15:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 062F2834B9;
	Fri, 10 Apr 2026 15:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rTY1yL-sPhP; Fri, 10 Apr 2026 15:19:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E3DE834BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775834379;
	bh=eTlXD+fEi5OyNbu4TxRTwpDmEzFd2ThBwniicSqJG9M=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gFBImi2AGVqs0r4S7S/ieQi/9vjng0hvYPcrwYZmyQXvhnWNiLLre6MoA/LlqriVv
	 PdHMv8PKw52ELNYPvny2XcpVLsvTCRIOCUCpkdy5LjUU7MYS9OMAfyDrIfSRBJVGY6
	 CJgPHomNinFX6j+zVFnmoNTidsOcodsNVEjWNuVrplOVw+yACt0X2gxPQpI7bTvcvY
	 xgbKDs9xYhTKfmgeHdpe6eUvpzIAKl+5Uh9MIE3QiQl1afNAYWrBLTP9TzaU45iNP8
	 812yvGMVE17WSBYT5Y+mgY60cnOti7sVGhzkP0p1FOe2Seg/YxKH3jdeAF1vLnr98p
	 FwpouWW9zSWWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E3DE834BA;
	Fri, 10 Apr 2026 15:19:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F30A237
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 15:19:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CF28834BA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 15:19:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJK-n2tCUNmD for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 15:19:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=18.9.28.11;
 helo=outgoing.mit.edu; envelope-from=tytso@mit.edu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CDD36834B9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDD36834B9
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDD36834B9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 15:19:34 +0000 (UTC)
Received: from trampoline.thunk.org
 (pool-173-48-116-90.bstnma.fios.verizon.net [173.48.116.90])
 (authenticated bits=0) (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63AFIonm015842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 11:18:51 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
 id 0D7462E00E1; Fri, 10 Apr 2026 11:18:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 Philipp Hahn <phahn-oss@avm.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Date: Fri, 10 Apr 2026 11:18:40 -0400
Message-ID: <177583430870.2758959.6171961359325912353.b4-ty@b4>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-4-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-4-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mit.edu; s=outgoing; 
 t=1775834338; bh=eTlXD+fEi5OyNbu4TxRTwpDmEzFd2ThBwniicSqJG9M=;
 h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=VM9pR3FUqiyu4dGQLYjxtn5fwtIzfU7ySZMp0abbH18xV6/gDABRi9uB743lXz8hh
 DLg+D58JGiw6cmfTe96qrNZsfI1LrX8CH4Z4SZsryjUI4LnJNSYnME68kmTAWN0bac
 +APmObxjmRctPfSGmHJbriSXfrkN55pWYIbiVRfu2y0ECqpOPHSJun6K+BHM+LkVI2
 DM7T+QYmlRWbU/sqPlO03FdXluf2F9iRmmuiDmCsbPLwL4U9izV2zs90P/AyWnNi7/
 WJE2W3FtW9KojAgen2wKI5w3YJJGh4CS8IuF5T47bMgUta6WPQzUW9F7QaunmIRgXz
 enYXQQPwNnobw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=mit.edu
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256
 header.s=outgoing header.b=VM9pR3FU
Subject: Re: [Intel-wired-lan] [PATCH 04/61] ext4: Prefer IS_ERR_OR_NULL
 over manual NULL check
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


On Tue, 10 Mar 2026 12:48:30 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.

Applied, thanks!

[04/61] ext4: Prefer IS_ERR_OR_NULL over manual NULL check
        commit: 1d749e110277ce4103f27bd60d6181e52c0cc1e3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
