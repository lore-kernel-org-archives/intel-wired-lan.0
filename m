Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4465106ACE5
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Mar 2026 19:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CA0B80CE9;
	Thu, 12 Mar 2026 19:40:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PlJo0ROlgSmk; Thu, 12 Mar 2026 19:40:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DCEC80CD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773344450;
	bh=VQ4I1//oujMg/wMbvtHZ1fNg62i5rEhIWcPKRohhj4U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5uRhkQIelFfQ9J+kAwDmuwr1Zh/fHmXRQdykiCTYm9qnSDS7mMZo0JF0N4JNNtXob
	 RsguF928pk8v13aMN17LnBU1TXzqKUIIrdgXSwn6SLQce0o088uBu94/5nGE9hiPUA
	 tdJNZaiBPHgF7rUgMB0PmzlWpFvh9cKWZqRHni1OBYZNMrgks2lGAdJ+O/Mp4OsKM2
	 oY32JcBWyfiiGqvaJguw7bZLD/XnX2MXCnivdlfAgsC42qcO9XxLS7vy8ucJXQVD33
	 puX8iZZ3NIGQlsyx9mzPV+rul+oEMkZutbivdLYd0c1IIODFKkAmlOSi3YVuPjWg/p
	 uCBJXpXA5xPdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DCEC80CD8;
	Thu, 12 Mar 2026 19:40:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 069A3282
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 19:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC52C407BC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 19:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsEbmpP2onRZ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Mar 2026 19:40:48 +0000 (UTC)
X-Greylist: delayed 419 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 12 Mar 2026 19:40:47 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 82239407B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82239407B3
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=116.203.167.152;
 helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=<UNKNOWN> 
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82239407B3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 19:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 4DE582C14A8;
 Thu, 12 Mar 2026 20:33:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id yCwNT8mwVvHB; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 8A34D2C14AA;
 Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3HN7guaAFMsE; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by lithops.sigma-star.at (Postfix) with ESMTP id ABF4A2C14A6;
 Thu, 12 Mar 2026 20:33:42 +0100 (CET)
Date: Thu, 12 Mar 2026 20:33:42 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>, 
 apparmor <apparmor@lists.ubuntu.com>, bpf <bpf@vger.kernel.org>, 
 ceph-devel <ceph-devel@vger.kernel.org>, cocci <cocci@inria.fr>, 
 dm-devel@lists.linux.dev, 
 DRI mailing list <dri-devel@lists.freedesktop.org>, 
 gfs2 <gfs2@lists.linux.dev>, intel-gfx <intel-gfx@lists.freedesktop.org>, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, 
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
 linux-block <linux-block@vger.kernel.org>, 
 linux-bluetooth@vger.kernel.org, 
 linux-btrfs <linux-btrfs@vger.kernel.org>, 
 linux-cifs <linux-cifs@vger.kernel.org>, linux-clk@vger.kernel.org, 
 linux-erofs <linux-erofs@lists.ozlabs.org>, 
 linux-ext4 <linux-ext4@vger.kernel.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-gpio@vger.kernel.org, linux-hyperv <linux-hyperv@vger.kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, 
 linux-leds@vger.kernel.org, linux-media <linux-media@vger.kernel.org>, 
 linux-mips <linux-mips@vger.kernel.org>, 
 linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org, 
 linux-mtd <linux-mtd@lists.infradead.org>, 
 linux-nfs <linux-nfs@vger.kernel.org>, 
 linux-omap <linux-omap@vger.kernel.org>, 
 linux-phy@lists.infradead.org, linux-pm <linux-pm@vger.kernel.org>, 
 linux-rockchip <linux-rockchip@lists.infradead.org>, 
 linux-s390 <linux-s390@vger.kernel.org>, 
 linux-scsi <linux-scsi@vger.kernel.org>, linux-sctp@vger.kernel.org, 
 LSM <linux-security-module@vger.kernel.org>, 
 linux-sh <linux-sh@vger.kernel.org>, 
 linux-sound <linux-sound@vger.kernel.org>, 
 linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>, 
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
 linux-usb@vger.kernel.org, 
 linux-wireless <linux-wireless@vger.kernel.org>, 
 netdev <netdev@vger.kernel.org>, ntfs3 <ntfs3@lists.linux.dev>, 
 samba-technical <samba-technical@lists.samba.org>, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs <v9fs@lists.linux.dev>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1584421372.26258.1773344022512.JavaMail.zimbra@nod.at>
In-Reply-To: <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF148
 (Linux)/8.8.12_GA_3809)
Thread-Topic: Prefer IS_ERR_OR_NULL over manual NULL check
Thread-Index: 0l8CyewQmrWlgaG6N3QgQFfukutRbA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=nod.at
Subject: Re: [Intel-wired-lan] [PATCH 48/61] mtd: Prefer IS_ERR_OR_NULL over
 manual NULL check
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Philipp Hahn" <phahn-oss@avm.de>
> -=09if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
> +=09if (!IS_ERR_OR_NULL(gpiomtd->nwp))

No, please don't.

This makes reading the code not easier.

Thanks,
//richard
