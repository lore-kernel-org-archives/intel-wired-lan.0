Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C23DC64EDA
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Aug 2023 23:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C74D760E28;
	Thu, 17 Aug 2023 23:36:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C74D760E28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692315407;
	bh=Qh4RFuzEH17Iw1TTAHYf+kmAL6BMciMKQv6rAGSaAWM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3e1bTHkNlitROBfZKD5LaXUC3cSKTHgMZQ6FQt+xcXgzbfJF6XFlK4qRFcgsBDsYd
	 c86Foxcf0LQuNZjS/Z2l4FRS2jEcxziEVonfogCkG/4jIyA5piBujwaPseNclq9+kc
	 tqSWvqztJv7H6pLjcsCPjuM/N3RPB00/rZ5cKq3OTPFsglnIz5s7oK2eLJLKCyxkE+
	 s+4UR83fD3I9LSQpBj0/+TRnGTuXmRYh06xi9rBaEimNZigcq6BebFZYfKARMN17lO
	 IbEc+zFjo3H7TuQmuHb1djWE6HeclTBnAltsYlS+BMWwOlw5j6PWFE/MGiSLpCnt3Y
	 KJYwduvs8TKqQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IqtHELkhMZS8; Thu, 17 Aug 2023 23:36:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id D481860E53;
	Thu, 17 Aug 2023 23:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D481860E53
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 2139A1BF3CE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 23:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECD4A60E53
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 23:36:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECD4A60E53
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9YMZn8jdnHOE for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Aug 2023 23:36:44 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1991360E28
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 23:36:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1991360E28
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 34B3D61D7B;
 Thu, 17 Aug 2023 23:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27221C433C9;
 Thu, 17 Aug 2023 23:36:42 +0000 (UTC)
Date: Thu, 17 Aug 2023 16:36:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Message-ID: <20230817163640.2ad33a4b@kernel.org>
In-Reply-To: <DM6PR11MB4657AD95547A14234941F9399B1AA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-3-vadim.fedorenko@linux.dev>
 <20230814194336.55642f34@kernel.org>
 <DM6PR11MB4657AD95547A14234941F9399B1AA@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692315402;
 bh=RhegQx5uRaKcu1E0Rcckw5IZtC6q56UwuK3vF+HLjhU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oFbxa95Hfo/FdXazIXS1L4w163X1hkyZix7WC7BswVsZltRRJV70Ia5RhDke9RQmW
 v5hMxYFTDPzxcMcC/GvJ3Y6U135ShOZAwlJqQ/LudBbm5whE1X7PpULwONQt8x2GYD
 Az+eOYwcn5MjbP3m/psJ++7Fvg/c/ryL/n91X1rY5W4YzM4jMBtKNSJRV0qKYPc7Wy
 ujm/9LHTqEDTlOq6wzgAehvprfFveA++VHaLyRvgActcHbER5qLtY2rU+RAJeFjmph
 q9Vg1g8N/HCHlJIdko6OagOrS2NcV5TemgTsF+CEdKLCl4DtaFR6661uo6FA/+8WN/
 WpXlldD11n9DQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=oFbxa95H
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 2/9] dpll: spec: Add
 Netlink spec in YAML
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
Cc: Jiri Pirko <jiri@resnulli.us>, Bart Van Assche <bvanassche@acm.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "Olech,
 Milena" <milena.olech@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 17 Aug 2023 18:40:00 +0000 Kubalewski, Arkadiusz wrote:
> >Why are all attributes in a single attr space? :(
> >More than half of them are prefixed with a pin- does it really
> >not scream to you that they belong to a different space?
> 
> I agree, but there is an issue with this, currently:
> 
> name: pin-parent-device
> subset-of: dpll
> attributes:
>   -
>     name: id
>     type: u32
>   -
>     name: pin-direction
>     type: u32
>   -
>     name: pin-prio
>     type: u32
>   -
>     name: pin-state
>     type: u32
> 
> Where "id" is a part of device space, rest attrs would be a pin space..
> Shall we have another argument for device id in a pin space?

Why would pin and device not have separate spaces?

When referring to a pin from a "device mostly" command you can
usually wrap the pin attributes in a nest, and vice versa.
But it may not be needed at all here? Let's look at the commands:

+    -
+      name: device-id-get
+        request:
+          attributes:
+            - module-name
+            - clock-id
+            - type
+        reply:
+          attributes:
+            - id

All attributes are in "device" space, no mixing.

+      name: device-get
+        request:
+          attributes:
+            - id
+        reply: &dev-attrs
+          attributes:
+            - id
+            - module-name
+            - mode
+            - mode-supported
+            - lock-status
+            - temp
+            - clock-id
+            - type

Again, no pin attributes, so pin can be separate?

+    -
+      name: device-set
+        request:
+          attributes:
+            - id

Herm, this one looks like it's missing attrs :S

+    -
+      name: pin-id-get
+        request:
+          attributes:
+            - module-name
+            - clock-id
+            - pin-board-label
+            - pin-panel-label
+            - pin-package-label
+            - pin-type
+        reply:
+          attributes:
+            - pin-id

Mostly pin stuff. I guess the module-name and clock-id attrs can be
copy/pasted between device and pin, or put them in a separate set
and add that set as an attr here. Copy paste is likely much simpler.

+    -
+      name: pin-get
+        request:
+          attributes:
+            - pin-id
+        reply: &pin-attrs
+          attributes:
+            - pin-id
+            - pin-board-label
+            - pin-panel-label
+            - pin-package-label
+            - pin-type
+            - pin-frequency
+            - pin-frequency-supported
+            - pin-dpll-caps
+            - pin-parent-device
+            - pin-parent-pin

All pin.

+    -
+      name: pin-set
+        request:
+          attributes:
+            - pin-id
+            - pin-frequency
+            - pin-direction
+            - pin-prio
+            - pin-state
+            - pin-parent-device
+            - pin-parent-pin

And all pin.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
