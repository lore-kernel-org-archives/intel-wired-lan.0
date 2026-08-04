Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF8C55822
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 06:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E64D80C23;
	Tue,  4 Aug 2026 06:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J3E9S4eIfEup; Tue,  4 Aug 2026 06:04:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C64A80AEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785823496;
	bh=OToM6UP9f/Ux/DqRKNF67jZiev40CWayyioMQcItMHM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CqC3ee+GEk6w7rKoT80fFpO5hDZj6wcaG3wmj0Ls4GjEve4+dX0XmHHfqBkF9uE5F
	 GRSP/e6F7tvAojjt+/HbujCqbsWBTQkf0n1NGhn4Rspfk/AmZbejAhyFwS7P7al2Ye
	 wVKt/K7BqJwqhcmRfX6NTQpZ/RPQwb3mlegZcjSVL0u2yoC32qQ4ojOtIZ0ci2YEtd
	 0KvYaaO/0++EdHcgdAGXQL/eE0isxrkeYN/K4ggbNcmQ8v1z07LSrlGQnpowCvbUUU
	 ohb2ENFlGiyK/dNr/6QRzCqu5gPjxVSUPAJE0QI25HT7qIsy9JhzJsxO/D/qhcOjvj
	 n5iiz3O37TnHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C64A80AEF;
	Tue,  4 Aug 2026 06:04:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 702CF198
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 06:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D5464009E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 06:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5vwkf0kOg2r for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 06:04:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=acelan.kao@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6F3474002B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F3474002B
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F3474002B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 06:04:52 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3793E3F82A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 06:04:51 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ce7dfd33ffso55443795ad.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 03 Aug 2026 23:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785823490; x=1786428290;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OToM6UP9f/Ux/DqRKNF67jZiev40CWayyioMQcItMHM=;
 b=dot0StBbLkgupgJD5T6dez4+tja2b2g3jRPXbe/xvZlUb38A88Gm2wgCwDxIAni5kM
 9jrUmpaAHItrUF+BHtQVwAap6NjfbCj2kMU3QfQFQy07tLtQBXn/o8F9EpRTLttRRh3p
 nfOkCGeuPCSQwJFDBZl0iZ6k7VUspARnZcAGZGxW8PmhDbJvDBXaqnKxq4fbX60NSr9E
 +K8k5iCi+J3jYgx97piZR+FXK1nS9t+46SXys22/LUsrcdojKlXix0vjMMah+FeU8HjD
 xAewVBKok05LmWmpbLkKTYWtmRX4AsL1dspQVpqTuPxj+gGhnAs7lHL4IaCQBDruxGQC
 VSew==
X-Gm-Message-State: AOJu0YyO9c0YpUeLRl9GV9/PoMjnW4qpzjjmOxRYeJIwuBMjcEMeaOSp
 cBd33XadIzlPX2lF7abbrS+HSEZ/SdGGYUwnze+zKY5E+RyPrqfU46lk3e7qpi86canhMfVlRNo
 SHvDqv2xD3MvKdW37lZKyqWUnCd8Ci5kHF2AdoHqmPZv1FWfldOGF6HZHAa0u6VqAqnrnWf/9Jv
 Grk63uiQrSTbOEEW3tckk=
X-Gm-Gg: AR+sD11xhNO4YlRayYpShYk4DJjcomzHAAkHwGcrWyB1cXisT/BwA1YRZ3PJoGsA77E
 PjgLqPxRE+AQc05Se1xzTRgwZF9j29ixBXl28jqxqblcQkaZhNnzEKKFOIbLrRHqphNtXawY7Bz
 RuoieBiT9l322U/hW1yCA/NrnXzJFq0saMz/PWJ96J0SyAKLT0zbrU6C8JrLyicg/tAqXW7ivXz
 61ZLDCPq8f5i16tos1WZGWwlDwR6CLKVXrCZkWg7cJUFJt0KODMmU9LDXLtR8CH7AIn0mJ9kUon
 BHVKdYIfPMURCyp17pJVavBYzS7Gt31LviaTHOi3hPNjA7Tx5bVr827vqOB+Txy8/uF/ZyElDQw
 2kLqzDsp9DI/k0I4OuKPLimEx88XCKVMUdNPOtkmbzbi3GrQ5Zf6pyplh
X-Received: by 2002:a17:903:1b46:b0:2c7:f4bd:91b5 with SMTP id
 d9443c01a7336-2d052088a93mr110902545ad.0.1785823489696; 
 Mon, 03 Aug 2026 23:04:49 -0700 (PDT)
X-Received: by 2002:a17:903:1b46:b0:2c7:f4bd:91b5 with SMTP id
 d9443c01a7336-2d052088a93mr110902395ad.0.1785823489313; 
 Mon, 03 Aug 2026 23:04:49 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net.
 [211.75.139.220]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9ff4f33sm401735ad.25.2026.08.03.23.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 23:04:47 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:04:41 +0800
To: Dima Ruinskiy <dima.ruinskiy@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 allen.lan@intel.com
Message-ID: <anGApbcat6ka_LyS@acelan-Precision-5480>
References: <20260708134424.3289011-1-dima.ruinskiy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708134424.3289011-1-dima.ruinskiy@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785823491;
 bh=OToM6UP9f/Ux/DqRKNF67jZiev40CWayyioMQcItMHM=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=W9KVmX2BMEo7W+XmQHUFHphdrFaV8xGDm/WOfJpbEjy2FAO64OMeErxMp0+eEKKMr
 9EvfxD3nePfPv0KbX6FWGKAf+9MPzeCBx3bYl9zStxz6Nqro8o3fY7IdVbefRZa9C0
 2V1P6eR56wsyYd36tlijeT+rqxE+/Sq+n/o07ELhQFltOf049iKE7YVC+r7vkWKg4L
 2OEZzZO4YsUm8e3PFxa40mbrP+GF2tewDWSfp0SPV9+5TC/60OMnsRmqHmCwNVPGXN
 gkiS3lE5n+GD87JS10Jnz0qX2X7K4H3PHQDH+t6An34Gfx3db+MMNM0CgRQU2i+ep1
 RQk9DGlPQywtaUFs/hfpugqNibXM3CgY5H7FwNEftc4OavETz07MhzaSiCcyZErcM2
 iH9VLPiNfXkIvULpfOHYxJo1z0yXSF8HEpebx6BQY3Xu0mPRikubn6VgNCG8d6cwtS
 W5leqMT9pavsxtgSFZ1v59g6mUUe7z/DuxJpCmTNSd57Nl3yyYx2wEmUN3Oe3ZwtbU
 qw43Rjd0utGX27XbAwpIR9XrGaABouyQSEHj/HLTcgiaztpvABGZQFlJkWQfal1ZZf
 b8MVfe2WQ31cl9k8CrNJ+kuAZHL7nt8bfjIT6VNHjRZN87zI52l2KWjkuKKQNsLpHi
 LOP49fjvETd+4KCGUMAfW3/Y=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=W9KVmX2B
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: Support ACPI-based MAC
 passthrough
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
From: "Chia-Lin Kao \(AceLan\) via Intel-wired-lan"
 <intel-wired-lan@osuosl.org>
Reply-To: "Chia-Lin Kao \(AceLan\)" <acelan.kao@canonical.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jul 08, 2026 at 04:44:24PM +0300, Dima Ruinskiy wrote:
> Some systems implement a system MAC address object in the ACPI table,
> using either \\_SB.AMAC or \\MACA object names. This system MAC address,
> when enabled, is intended to override the permanent MAC address of the
> network controller.
>
> Implement lookup of the relevant ACPI object names and use them to
> initialize the MAC address.
>
> On systems where the feature is disabled or unsupported, the ACPI objects
> do not exist or do not contain a valid Ethernet MAC, causing a fallback
> to the existing MAC address initialization path.
This patch works as expected and solves the connection issue when the
MAC passthrough feature is enabled.

Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>
> Assisted-by: GitHub-Copilot:claude-opus-4.7
> Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 64 ++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 82800a4a6d6c..83eb8953e954 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -11,6 +11,8 @@
>  #include <net/pkt_sched.h>
>  #include <linux/bpf_trace.h>
>  #include <net/xdp_sock_drv.h>
> +#include <linux/acpi.h>
> +#include <linux/hex.h>
>  #include <linux/pci.h>
>  #include <linux/mdio.h>
>
> @@ -7116,6 +7118,57 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>
> +static bool igc_get_acpi_mac_passthru(u8 *mac)
> +{
> +	static const struct {
> +		const char *name;
> +		acpi_object_type type;
> +		u32 length;
> +	} sources[] = {
> +		{ "\\_SB.AMAC", ACPI_TYPE_BUFFER, 23 },
> +		{ "\\MACA",     ACPI_TYPE_STRING, 22 },
> +	};
> +	struct acpi_buffer buffer;
> +	union acpi_object *obj;
> +	bool mac_found = false;
> +	acpi_status status;
> +	u8 buf[ETH_ALEN];
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_ACPI))
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(sources) && !mac_found; i++) {
> +		buffer.length = ACPI_ALLOCATE_BUFFER;
> +		buffer.pointer = NULL;
> +
> +		status = acpi_evaluate_object(NULL, (char *)sources[i].name,
> +					      NULL, &buffer);
> +		if (ACPI_FAILURE(status))
> +			continue;
> +
> +		obj = buffer.pointer;
> +		if (!obj || obj->type != sources[i].type ||
> +		    obj->string.length != sources[i].length)
> +			goto free_obj;
> +
> +		if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) ||
> +		    obj->string.pointer[21] != '#')
> +			goto free_obj;
> +
> +		if (hex2bin(buf, obj->string.pointer + 9, ETH_ALEN) ||
> +		    !is_valid_ether_addr(buf))
> +			goto free_obj;
> +
> +		ether_addr_copy(mac, buf);
> +		mac_found = true;
> +free_obj:
> +		kfree(obj);
> +	}
> +
> +	return mac_found;
> +}
> +
>  /**
>   * igc_probe - Device Initialization Routine
>   * @pdev: PCI device information struct
> @@ -7279,9 +7332,16 @@ static int igc_probe(struct pci_dev *pdev,
>  	}
>
>  	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
> -		/* copy the MAC address out of the NVM */
> -		if (hw->mac.ops.read_mac_addr(hw))
> +		/* Look for a system-provided MAC in the ACPI table before
> +		 * falling back to reading the address from the NVM.
> +		 */
> +		if (igc_get_acpi_mac_passthru(hw->mac.addr)) {
> +			netdev->addr_assign_type = NET_ADDR_STOLEN;
> +			dev_info(&pdev->dev, "Using ACPI pass-thru MAC addr %pM\n",
> +				 hw->mac.addr);
> +		} else if (hw->mac.ops.read_mac_addr(hw)) {
>  			dev_err(&pdev->dev, "NVM Read Error\n");
> +		}
>  	}
>
>  	eth_hw_addr_set(netdev, hw->mac.addr);
> --
> 2.44.0
>
