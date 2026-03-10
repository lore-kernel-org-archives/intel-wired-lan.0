Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369E1EB1070
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11D6E6064D;
	Tue, 10 Mar 2026 15:28:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W0dR-ydxyqVl; Tue, 10 Mar 2026 15:28:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8195F60B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156504;
	bh=tqNoaL94Dj4pObM+6pGSr4RMsIJmELh6Cj7p3cxJGxE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o/sdfKspmG/HibJ3LnP+04Y5CXH8w7J5PdL7ORpqqnvEJCGSOGCmo9fBMop+gPlaY
	 4s7RKQO+JlB5A3ZWMVZp++WrTN+7He2oZspfgvqkdiMbBuVKegCTXh1wjDXRfSRZC1
	 5FLO/W7gFOnxLejr3rdAPaFUgyyIceGoeUqDlVa3EbxvPr3t0oWOF2e/kvdougYJCp
	 nm4dZirmTwiQpVgQlq4jW2QE+OYOgyXJd8dziJI/hfq3/Yihp4ilhbIqJp56AdMoFv
	 ekTL17+K6h3erhdnwc4bqfdq2XcaiB76Thv96j9Gi+/n2pNRsn/ulsxE5Oi0gYF+Vc
	 /G1AiEaZgrfww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8195F60B48;
	Tue, 10 Mar 2026 15:28:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8767035C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 14:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D91060ADB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 14:28:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eW5FeS6o9sri for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 14:28:15 +0000 (UTC)
X-Greylist: delayed 2576 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 10 Mar 2026 14:28:15 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 460F360AD9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 460F360AD9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.189.157.229;
 helo=kylie.crudebyte.com; envelope-from=linux_oss@crudebyte.com;
 receiver=<UNKNOWN> 
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 460F360AD9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 14:28:15 +0000 (UTC)
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
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
 Philipp Hahn <phahn-oss@avm.de>, Philipp Hahn <phahn-oss@avm.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>
Date: Tue, 10 Mar 2026 14:45:07 +0100
Message-ID: <2401874.ElGaqSPkdT@weasel>
In-Reply-To: <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:28:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=tqNoaL94Dj4pObM+6pGSr4RMsIJmELh6Cj7p3cxJGxE=; b=BSv+5VTSyPyrhpKWnMZVCjZEvG
 yrk6LWxlGwnUUZjquKMol+ljVUIUp9jBraubgLqBi4cKz4hniKCf9rIQTsThme1FexxEN+zxKvsgC
 uvMYbDhkYi+shFX+PLCD/IMwmjSpYMDJbZGsateoQvss1ByMiB7n5CokueqpdePTp7697ajozqLcL
 QNNNvSzTIj5kMR2wUJSupi5THJtiu7VhPmFy8ePRrdnRpYFSOebiyO3IlTbeTGO/MmRM5PEIBBHLD
 zejwvm6ItsldfqTIXTc6O0Z/soDk0el6lSZ+MrXBoszSWB5pdQE71J71rNLjrXAAIRkB6hWfEOV6d
 5s2EICAGfy5rFvZnPzPqZQFNMJmMF1OtxV9pY8V9U1rZXYRb0+cWjl6X1xLcFCZOiZcoHLob301cc
 kRokX7oWqU/2ExVyAy+qxf6eKje0uvqaOqv9hMGZ5ryaSKPC2aKAIJfnAVSBvJS/v1i4KIjPZc3rm
 OWRlN9QVYisM4o3VWUWhQE9QLOSHJzH7XsIe7kcAxjAHPZYtil03PpuGESYai0z/ycOzdMPXNnK8s
 RUYQ5R4xdnnK/uIBRJ5tLN+fwlf+9zGkqtXzZ7Db2ibQTV2JC6OBFoQ9ds8aqQ/KGsNN9Qx1u7AAn
 wqTFHtO0j/nTwkXDvMBIt3or3MQXIgQCujiNGxQ00=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=crudebyte.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=crudebyte.com header.i=@crudebyte.com
 header.a=rsa-sha256 header.s=kylie header.b=BSv+5VTS
Subject: Re: [Intel-wired-lan] [PATCH 06/61] 9p: Prefer IS_ERR_OR_NULL over
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

On Tuesday, 10 March 2026 12:48:32 CET Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Eric Van Hensbergen <ericvh@kernel.org>
> To: Latchesar Ionkov <lucho@ionkov.net>
> To: Dominique Martinet <asmadeus@codewreck.org>
> To: Christian Schoenebeck <linux_oss@crudebyte.com>
> Cc: v9fs@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  fs/9p/fid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

"fs/9p" in the subject on this one, please, not just "9p".

Except of that:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index
> 0d6138bee2a3d1ab565ab2d210c0a3f3bf97e4e3..3bb7ef4380e972a2d9ab67eb4aab6cc5b
> fe2eea7 100644 --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -27,7 +27,7 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry
> *dentry) struct p9_fid *fid, *nfid;
> 
>  	fid = v9fs_fid_lookup(dentry);
> -	if (!fid || IS_ERR(fid))
> +	if (IS_ERR_OR_NULL(fid))
>  		return fid;
> 
>  	nfid = clone_fid(fid);


