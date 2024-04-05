Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B40CD1296
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 Apr 2024 19:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04D0541D8D;
	Fri,  5 Apr 2024 19:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HdlMk-2sA4N0; Fri,  5 Apr 2024 19:34:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41BA641C5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712345665;
	bh=JVB3VfvTOvGRlE6Jx9aTA6sq8pTWqTv0ie7kmTmSdgE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=koizA8F6MRWd1vgIEFB4wGCBNow7B6q5z7QY6vnBSZ5fwyX0Yo1XiBCt46UVOIf+A
	 tjmLmzkEagpHnU1gfqyuEGROrZwRiRINM93cQib+G/WJNbUlpsgQYphdcy582+vFNx
	 lFvNsGU3eWRrneDuxHhngy3/eVuEwquyd6IjBe+Lad2vQU31d2b1f3B4al9QSFU3vg
	 EylmisDh4RhPKaIy1XSsIHfRwjKC0OQMrW4IHyxN9Wf+yJcaPsGSrhnU+G7wn6/R18
	 EdcuLveFqj7a8H2AsMIlq1ePG/MqjiHyX/XylHtfHIdXMjrRD1y6pzWYAMvC6BfPWu
	 CYl+RNKXMNDhg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41BA641C5E;
	Fri,  5 Apr 2024 19:34:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 6BE431BF406
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Apr 2024 17:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 560E141D6F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Apr 2024 17:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fj01X-N_Fqbe for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 Apr 2024 17:56:23 +0000 (UTC)
X-Greylist: delayed 491 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 05 Apr 2024 17:56:23 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2F49F41D6E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F49F41D6E
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a01:37:3000::53df:4ef0:0; helo=bmailout2.hostsharing.net;
 envelope-from=foo00@h08.hostsharing.net; receiver=<UNKNOWN> 
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
 [IPv6:2a01:37:3000::53df:4ef0:0])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F49F41D6E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Apr 2024 17:56:23 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
 by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1D43B2800BB90;
 Fri,  5 Apr 2024 19:48:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 082829926D8; Fri,  5 Apr 2024 19:48:08 +0200 (CEST)
Date: Fri, 5 Apr 2024 19:48:08 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <ZhA5WAYyMQJsAey8@wunner.de>
References: <CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com>
 <Zg_MOG1OufptoRph@wunner.de>
 <cd9edf12-5241-4366-b376-d5ee8f919903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9edf12-5241-4366-b376-d5ee8f919903@gmail.com>
X-Mailman-Approved-At: Fri, 05 Apr 2024 19:34:24 +0000
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=wunner.de
Subject: Re: [Intel-wired-lan] Deadlock in pciehp on dock disconnect
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
Cc: Kurt Kanzenbach <kurt@linutronix.de>, Roman Lozko <lozko.roma@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-pci@vger.kernel.org,
 Christian Marangi <ansuelsmth@gmail.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Sean Christopherson <seanjc@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Apr 05, 2024 at 03:31:34PM +0200, Heiner Kallweit wrote:
> On 05.04.2024 12:02, Lukas Wunner wrote:
> > On Fri, Apr 05, 2024 at 11:14:01AM +0200, Roman Lozko wrote:
> > > Hi, I'm using HP G4 Thunderbolt docking station, and recently (?)
> > > kernel started to "partially" deadlock after disconnecting the dock
> > > station. This results in inability to turn network interfaces on or
> > > off, system can't reboot, `sudo` does not work (guess because it uses
> > > DNS).
> > 
> > unregister_netdev() acquires rtnl_lock(), indirectly invokes
> > netdev_trig_deactivate() upon unregistering some LED, thereby
> > calling unregister_netdevice_notifier(), which tries to
> > acquire rtnl_lock() again.
> > 
> > From a quick look at the source files involved, this doesn't look
> > like something new, though I note LED support for igc was added
> > only recently with ea578703b03d ("igc: Add support for LEDs on
> > i225/i226"), which went into v6.9-rc1.
> 
> It's unfortunate that the device-managed LED is bound to the netdev device.
> Wouldn't binding it to the parent (&pdev->dev) solve the issue?

I'm guessing igc commit ea578703b03d copy-pasted from r8169 commit
be51ed104ba9 ("r8169: add LED support for RTL8125/RTL8126") because
that driver has exactly the same problem. :)

Roman, does the below patch fix the issue?

Note that just changing the devm_led_classdev_register() call isn't
sufficient:  I'm changing the devm_kcalloc() in igc_led_setup() as well
to avoid a use-after-free (memory would already get freed on netdev
unregister but led a little later on pdev unbind).

-- >8 --

diff --git a/drivers/net/ethernet/intel/igc/igc_leds.c b/drivers/net/ethernet/intel/igc/igc_leds.c
index bf240c5..0b78c30 100644
--- a/drivers/net/ethernet/intel/igc/igc_leds.c
+++ b/drivers/net/ethernet/intel/igc/igc_leds.c
@@ -257,13 +257,13 @@ static void igc_setup_ldev(struct igc_led_classdev *ldev,
 	led_cdev->hw_control_get = igc_led_hw_control_get;
 	led_cdev->hw_control_get_device = igc_led_hw_control_get_device;
 
-	devm_led_classdev_register(&netdev->dev, led_cdev);
+	devm_led_classdev_register(&adapter->pdev->dev, led_cdev);
 }
 
 int igc_led_setup(struct igc_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct device *dev = &netdev->dev;
+	struct device *dev = &adapter->pdev->dev;
 	struct igc_led_classdev *leds;
 	int i;
 
