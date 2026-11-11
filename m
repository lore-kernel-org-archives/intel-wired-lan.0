Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F49606A321
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5Sx60kjf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+/T+mmy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B97760743;
	Thu, 12 Nov 2026 16:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mh3vBYaOgAbC; Thu, 12 Nov 2026 16:55:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3E12607E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794502514;
	b=V87QFwrl+DJi8grcj22y1ick7M7r8Wu1XAuV/M+I45++hbxLkNdEL4nK/3DDF3uH5hxM
	 dE8rBivY8zLrI6rgl7uQa4Q8obJW8IX3KwcOutLGzu0FpGsOd72Vyc+uDpHhVSHA+sTjC
	 Qpw6RF1ZbJqBVNbfo3HXX/3m2a5DbvXWjjFi7AP68mNuRii9Wbhkf1kLJmx35N3vdlSup
	 nXWJpZz3JKeYQT9sqETzxAyfk1aLFxFLvsES8V0VM5jvDlrJAZoLcldmTR/cpJpEYIUMO
	 QzbPWW/DA5KXfIedknJNj9t482YVvwiy1fFjMCpnpHbLxUA4AA+uVQHMiP03YyyhD5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794502514;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=hPJTSgl4lSpxHtP18SvOW1H3AlqpcYb2ZHd7KDI91sE=;
	b=jcX0ETsFd5d2z+8P/0bos5O0VHoiwyGg4ewQCdSlp9CLPsrZZJUJoyqN5F1DaDmY7ehM
	 8fyOtBSE/9oNqG03i9ouuZLDHOJ/waQK7+HZXXYw12C1F2/ij7bPbrM3GF25fS8zBkOP5
	 vqs3HJHjObr/oqqDzhrBexTVPinOmWI59BLJdBZQOEt/ubCXxpr+BuOvADfqrve43/VKq
	 9fBHtB76mstcN9ZkXDQjsbhbr/o3yZLqjQJxmcNijkzWPRqmMp2ap/jQKsg2u1QdYGyy9
	 Q0ziL/7piqYZB1d5s1xP2xfhHg/DTiJWS0M+ZnvkgBobZH5U/jpq9zj9fY8d40KfBXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W+/T+mmy";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794502513;
	bh=hPJTSgl4lSpxHtP18SvOW1H3AlqpcYb2ZHd7KDI91sE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=5Sx60kjfL5cr5aC68Cc9FekeiCwL8K0PL1wrq6KCNzk0l9JNzrK9dsO2ONlO9IZWU
	 GGBqcuagp1SAI1R9YsjakDgkUf8jqbzobAnLRTPNU00zVrRF2+sRZn+u1v4DVT8y1x
	 WnahwF1/akmN2DaEROPql21J0XTxlzCPeLoucbF3R8t1t+sTvrTjbvYR4U3fX8Hfw0
	 eL7+KVLGmfdUz006kgdCppoFND8qOH9FMRlW5lFEkJKzfs+29i86EuM9e/AFFS+K98
	 +trlsl5gyLJfD+42z18Tond5SyPjdZnN8Ic9uZ9GQE72/NwTPAo/9M5+hQesh1n7Cc
	 S3tblRTFNzf9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3E12607E7;
	Thu, 12 Nov 2026 16:55:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 569B0EC3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 19:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C05860B5C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 19:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjVXouQkhyz8 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 19:31:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E6F860B34
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+darren.worrall.shopify.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=W+/T+mmy
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E6F860B34
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 19:31:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0EE1A469F2;
 Wed, 11 Nov 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 663221F00A05;
 Wed, 11 Nov 2026 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794425508;
 bh=hPJTSgl4lSpxHtP18SvOW1H3AlqpcYb2ZHd7KDI91sE=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=W+/T+mmyD3X0cIpn1rAgTiINN64y3iqC/UvCFO0wOCUSYsSI7G4GU8EaG0Y25KuW9
 ZHCUBKdAru8o8tIh+JPWiQ6DRmNfBt6OoqdtOplPk67zlcb83fMMJ2B04FrahS0yQy
 UQ5NMg51hjNM4V7iAxH3w5s2zfqkVXksPEHwiVYDBdJXR8/k03N6pDMf2mUZOfwHL3
 kssoqQZFZImR92u2yFdn4rfBVhPimt4P/MaLu1slmhUSLF+ns2jX8Z8v72bJl+KHpa
 AycYA6jPejQ1daE8s/7OUTBpABNYjrz8jOauOkxwV7GkmHPuuP2m+CJlb+brcb1ep2
 G741PvJ3/oY1g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B17D7490A4;
 Wed, 11 Nov 2026 19:31:47 +0000 (UTC)
From: Darren Worrall via B4 Relay
 <devnull+darren.worrall.shopify.com@kernel.org>
Date: Wed, 11 Nov 2026 19:31:39 +0000
Subject: [PATCH iwl-net] idpf: select AUXILIARY_BUS to fix link failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-idpf-auxiliary-bus-v1-1-e76b940fc929@shopify.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSQ6DMAxFr4K8rtUQqeNVKhYZDLhCgcaEUiHu3
 qT9u/enDYQik8C92iDSwsJjyFAfKnC9CR0h+8yglT7XWRmnFk1aeWATP2iToFPqdCV9cf7mIQ+
 nSC2vv9MH8HvAQDM0/0CSfZKby2WpWiOENprg+mKNkTsOR08LvhIlgn3/AmLEkuGiAAAA
X-Change-ID: 20261111-idpf-auxiliary-bus-c0058e27cd9d
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Darren Worrall <darren.worrall@shopify.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2450;
 i=darren.worrall@shopify.com; h=from:subject:message-id;
 bh=RbjW4ti8gsuFIX9ZjzwA73lhgVe0TsMd8tFgxZGXUIc=;
 b=owGbwMvMwCX2T4mx4WrYUgPG02pJDFlfDi1K9b6aINvzofyiZEOjge+28g0e39h3vWQV6XC4+
 NLgt9qbjlIWBjEuBlkxRZZJ28v+mU1q+VUe1bULZg4rE8gQBi5OAZjIBwGG/zmqa/U2nFimHeLt
 Fvcmu3CP2V2N1JI3lYLL1FgsLs1e4MzI8P3FuYc1cy/sZZJTuBTKY7a/aP7m5bMtItdqLI/ab+R
 yjwcA
X-Developer-Key: i=darren.worrall@shopify.com; a=openpgp;
 fpr=92B776FE369284FA775A8ABAFE220180D556A530
X-Endpoint-Received: by B4 Relay for darren.worrall@shopify.com/default
 with auth_id=1491
X-Original-From: Darren Worrall <darren.worrall@shopify.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 16:55:12 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Reply-To: darren.worrall@shopify.com
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Darren Worrall <darren.worrall@shopify.com>

The build can currently fail with

    ld: vmlinux.o: in function `idpf_plug_vport_aux_dev':
    drivers/net/ethernet/intel/idpf/idpf_idc.c:82: undefined reference to `auxiliary_device_init'
    ld: drivers/net/ethernet/intel/idpf/idpf_idc.c:86: undefined reference to `__auxiliary_device_add'
    ld: vmlinux.o: in function `idpf_plug_core_aux_dev':
    drivers/net/ethernet/intel/idpf/idpf_idc.c:223: undefined reference to `auxiliary_device_init'
    ld: drivers/net/ethernet/intel/idpf/idpf_idc.c:227: undefined reference to `__auxiliary_device_add'

if IDPF is enabled but no other driver pulls in AUXILIARY_BUS. We hit
this building a minimal kernel for hosts with IDPF NICs. It can be
reproduced on x86_64 from allnoconfig by enabling PCI, PCI_MSI, NET,
NETDEVICES, ETHERNET, NET_VENDOR_INTEL and IDPF.

Select AUXILIARY_BUS in IDPF, as ICE and I40E already do. The same
link failure was fixed for BNGE in commit d7065436e8a0 ("net: bnge: add
AUXILIARY_BUS to Kconfig dependencies").

Build-tested with that configuration on net-queue (dev-queue,
34a70a40c954) and on mainline (067c5c24cef2): vmlinux fails to link
without this patch and links with it. Boot-tested on bare metal (AMD
EPYC) with a Google Cloud IDPF NIC, using a 6.18.60 kernel carrying the
same change and IDPF built in: idpf probes the NIC and its link comes
up.

Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
Cc: stable@vger.kernel.org # 6.17+
Signed-off-by: Darren Worrall <darren.worrall@shopify.com>
---
The link failure was diagnosed, this patch drafted and the tests above
run with the help of an AI coding assistant. I reviewed the patch and
the test results.
---
 drivers/net/ethernet/intel/idpf/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 586df3a4af..6b59173e0d 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -5,6 +5,7 @@ config IDPF
 	tristate "Intel(R) Infrastructure Data Path Function Support"
 	depends on PCI_MSI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select AUXILIARY_BUS
 	select DIMLIB
 	select LIBIE_CP
 	select LIBETH_XDP

---
base-commit: 34a70a40c954fb8044ecd124840a2c38cd3aa4cc
change-id: 20261111-idpf-auxiliary-bus-c0058e27cd9d

Best regards,
--  
Darren Worrall <darren.worrall@shopify.com>


