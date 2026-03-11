Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936AC112584D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Mar 2026 15:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52B6884670;
	Wed, 11 Mar 2026 15:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRDLCu7hYf7A; Wed, 11 Mar 2026 15:33:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB34384644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773243235;
	bh=G+5qjaihAOE3Wva2YLY8jATPGvyCa7CiJLk7V/SbO+c=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3ga4SlHO3I/8VYJwkEYdu2Pk6OIy/r1+PpCPdr/3mNB8hlmmdkn460+zs3iu0LGS
	 /0MkB1KEbybjjrwK0F0bHn0VOe6DfZlpG4B2gTBF8hO+HVD6gDOuTEHEzd2UszkCmz
	 XprMVFli4zVz14GgPX0mkUVJ1CG+0yxJ2rUZcDyKK2Qo74EXo3HKqTCvJVW5eD//+l
	 ZDlT+g8cExHUC/D7fiAU6+da1ztBL6L1SrnVQXZxRDlTlh6eh/2EK1AnBzG1dEsB/N
	 20PeonC8wK2hFawkSdnhLtNVQFYoPDotuMzxmRL8sSRxU+7GTyCkvbGyA0LyxhpZ//
	 /IBD+rFlHEFAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB34384644;
	Wed, 11 Mar 2026 15:33:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CD718201
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 00:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF01A83126
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 00:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KaTSwl4Zk_-a for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Mar 2026 00:16:30 +0000 (UTC)
X-Greylist: delayed 301 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 11 Mar 2026 00:16:29 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BB63983104
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB63983104
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk;
 envelope-from=linux+intel-wired-lan=lists.osuosl.org@armlinux.org.uk;
 receiver=<UNKNOWN> 
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB63983104
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 00:16:29 +0000 (UTC)
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55974)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <linux@armlinux.org.uk>) id 1w07FF-000000005dP-41aF;
 Wed, 11 Mar 2026 00:16:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1w07FB-000000005hj-1vhz; Wed, 11 Mar 2026 00:16:09 +0000
Date: Wed, 11 Mar 2026 00:16:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
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
 Igor Russkikh <irusskikh@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <abC0Se_cstwTWp9r@shell.armlinux.org.uk>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:33:54 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G+5qjaihAOE3Wva2YLY8jATPGvyCa7CiJLk7V/SbO+c=; b=v5WQ+aGF0sps0WNhC7Zp3i4qfq
 0Hb0SCVWpSXvSr7WdAe2bPHF4KfJ/Ed1eiaiCb8D0oCv1z5xwK7JuLf0tC0l8hY2t6eWn1tcNZSpg
 QYrAEXTacs2n4b4dGxTmR/QZFsu7Xre8GI0M2CDH+d6uoN0gFUU9MJ/Uqp3GyqqaO1XmybhsS5lVz
 KPXBqq6BLZCCQzpQ8jMEzm8MnKJZE/MMCDQxbCe0qlHGv5pHIS812K52VRhLCysEP1IhQjrayukQi
 lGpFnxogge7mHLP+wP8QrSVC+xUyVfKJNzw96REdhpsHijJHvcSndISQsei/F/gJP6wWuF34GUcce
 0I/0wllQ==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.a=rsa-sha256 header.s=pandora-2019 header.b=v5WQ+aGF
Subject: Re: [Intel-wired-lan] [PATCH 38/61] net: Prefer IS_ERR_OR_NULL over
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

On Tue, Mar 10, 2026 at 12:49:04PM +0100, Philipp Hahn wrote:
> diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
> index a8f91a4b7fed0927ee14e408000cd3a2bfb9b09a..09b30b563295c6085dc1358ac361301e5cf6b2a8 100644
> --- a/drivers/net/mdio/mdio-xgene.c
> +++ b/drivers/net/mdio/mdio-xgene.c
> @@ -265,7 +265,7 @@ struct phy_device *xgene_enet_phy_register(struct mii_bus *bus, int phy_addr)
>  	struct phy_device *phy_dev;
>  
>  	phy_dev = get_phy_device(bus, phy_addr, false);
> -	if (!phy_dev || IS_ERR(phy_dev))
> +	if (IS_ERR_OR_NULL(phy_dev))

As noted in reply to your cover message, the check for NULL here is
incorrect - get_phy_device() returns either a valid pointer or an
error pointer, but never NULL.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
