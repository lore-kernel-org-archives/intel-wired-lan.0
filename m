Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49285CE7A8C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 25 Sep 2023 15:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9F7E80F05;
	Mon, 25 Sep 2023 15:55:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9F7E80F05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695657354;
	bh=AQNsB2DtttNKbxQKNtkJZP/llmwU1/WaAQZXsVWyRlY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=CvYKNI0dsvRpphCfjsEh+kvkkrLg7GhiK094kPE8/yRf3Dby3IFmncDJlzSmHTcZf
	 bZs6D/4FGQ1QV5k+sDKPbXb0Lh2UW1xKhcescYUw1oDo7lRKFIqQXvoToMd1fRaAgL
	 s9l+LIyGjKCUnysK8h5dFhOaebjv6+vimd8U0bzZDDDsdlQypbdn7s3d96xerO0F7G
	 vhDCgziXdLNViafoqoGhIVUGiVcZ1RMcK97StAx8a7whCAKACAq2rkuvZgh7mL+yPV
	 Itw/D8JPREZLr+aqay9jbiwXXStTaTXkzBlFA4sGAm8o7qVV8InW7AUWIQWngcYLWP
	 w9vWr7S+rDHMA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s5QtMZJHFyqt; Mon, 25 Sep 2023 15:55:53 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 438CA80F0F;
	Mon, 25 Sep 2023 15:55:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 438CA80F0F
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8AB0B1BF408
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Sep 2023 15:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68CC541A2A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Sep 2023 15:55:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68CC541A2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8YCqFhAjhADn for <intel-wired-lan@lists.osuosl.org>;
 Mon, 25 Sep 2023 15:55:50 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D615F419D6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Sep 2023 15:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D615F419D6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id DBFC0CE0F58;
 Mon, 25 Sep 2023 15:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9A6C433C8;
 Mon, 25 Sep 2023 15:55:41 +0000 (UTC)
From: Arnd Bergmann <arnd@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 25 Sep 2023 17:55:24 +0200
Message-Id: <20230925155538.526317-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1695657345;
 bh=rN0uGksTsjjZcDvJoDF3ojsWN3x8dp/ouj45xZwSJk0=;
 h=From:To:Cc:Subject:Date:From;
 b=ZeSxKHD8awdCQpyc+AmXEnCINpiHWRHmuxMjQHRNleoNgUimp12V6NimZJ5leP2Dl
 VigvkgTW4Z4na1THj7U3QaABkK7I5SMzHdb3EK6rm7R/6/EDXS/GIGMn2QS/hRtDl0
 JLVSRoBLUooPh6JdJpwCXonRKeNCtnO/qXVjAP5QFzVvL+cgMD2JD3X1ugwDCLciYF
 XPKTF9DSiXymyKdPKn8pskySFsg1hlX96ZJsKpsczl0LwtB9DZcPLJZgsoedO6eqYY
 lFZP4DpxMe0Zr3itYNaBICeggTRwyqEVDvs+MZFrHon2+XX4JJLZPx/hZ1t8DCnwB4
 ah8irPdxmaw7g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ZeSxKHD8
Subject: [Intel-wired-lan] [PATCH] ice: require PTP clock for building
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
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>,
 Michal Michalik <michal.michalik@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, Joshua Hay <joshua.a.hay@intel.com>,
 linux-kernel@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Arnd Bergmann <arnd@arndb.de>

A previous fix added PTP as an optional dependency, which was correct as
of commit 87758511075ec ("igc: fix build errors for PTP"), but this
has recently changed with the PTP code getting more deeply integrated
into the ICE driver.

Trying to build ICE when PTP is disabled results in this internal link failure
as the local functions are left out of the driver:

ERROR: modpost: "ice_is_clock_mux_present_e810t" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_is_phy_rclk_present" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_cgu_get_pin_name" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_get_cgu_state" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_is_cgu_present" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_get_cgu_rclk_pin_info" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_cgu_get_pin_type" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_cgu_get_pin_freq_supp" [drivers/net/ethernet/intel/ice/ice.ko] undefined!

I tried rearranging the code to allow building it again, but this was getting
too complicated for an outsider, so just enforce the dependency to fix randconfig
builds again, until someone wants to clean this up again.

In practice, any configuration that includes this driver is also going to
want PTP clocks anyway.

Fixes: 8a3a565ff210a ("ice: add admin commands to access cgu configuration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index e6684f3cc0ce0..c452ecf89b984 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -278,7 +278,7 @@ config ICE
 	tristate "Intel(R) Ethernet Connection E800 Series Support"
 	default n
 	depends on PCI_MSI
-	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on PTP_1588_CLOCK
 	depends on GNSS || GNSS = n
 	select AUXILIARY_BUS
 	select DIMLIB
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
