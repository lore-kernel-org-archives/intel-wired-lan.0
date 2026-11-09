Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046A606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gMUQsQ0L;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=qzMfd/tW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 185396068D;
	Mon,  9 Nov 2026 02:30:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tL1p74BNCW9e; Mon,  9 Nov 2026 02:30:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 342846066E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794191405;
	b=eHlE1H/HD/GANJgoONL/a0B9fxzWtuff7fR00nfmwoKV3W1nzaZoo9pKQ7s9yDl+N2uG
	 CYa2DNctqUl3wtPATdMMnsei7PSBd1XIkYF++VpJbOjqQBtIMFW269Oiq0vZW7Mn01EHn
	 sHyOfZEZoKzin0hZNs79ovNS+b3/FmMfO5Z9FwzcbwijVlE2a5+b09/oIepk93HpP50ED
	 HN8yoPOvmNGPkrkV02yNKLR4dkAQq5xsTd271gWll6LBk3EXrjpmGjjaivDey9lxRKZlo
	 DhCvq1f8IZUY6hrJixjFsN7oIkW8O/z98k3RnRfxGUtv/tVTwsIo5UMqPG8NwIJpCmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794191405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=J93yaBx7zQqNHymwSqDOniHqyY+PToYJG4eT/KK5h7U=;
	b=NtmfhKj9uhzyJZPniRJGnohJQ1yzaKUSrL+XIFYuoZa3jnDc3SqV5GU7YXfYIvq7nP/C
	 CoE6nblXqKb3X29ESpp1BLzBRwMf/cdWe/kqXi8wzj8lef1VRx33QkihiHR7JJO1uhvn6
	 AdIQ8adBlvVppnEZB22WcPFFssOnV4uZEmKGvaFiec5/bEiCsuygntIJB5XjJJLr16HWJ
	 Epg58RMsVqLWrcYlUW3KzVusb60M485OjmSeyvMLsMNI+UbDjKgzqFdxWAeg5zJ4EjYLP
	 8fbKDyLDdL2+BDkRcNEdwaWuCpVnYU254KUeqfCYLWutgrfBGG5l9FiPxNS8UMRKRLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794191405;
	bh=J93yaBx7zQqNHymwSqDOniHqyY+PToYJG4eT/KK5h7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gMUQsQ0L+M27ujW78xOseP/vSES8lfH3RzX38opPy96wJruwGoDO0iyoogpgrCjdL
	 clxodzLE6QWyLaB/gv+hlmXEv+DeiSd77KzgDj1WLuTJ8sOzcc/KLIvoGtYfm3BXty
	 awCLX0+/UmbW/3tD0daysvtFRDy6CK4bD30T5i6uOrtc08zzkj2QYGizFsAQGPK/Sf
	 bUVzrzjXdUdKpv+FAH87p5OgE69eiTIckvmJ0upAlowEPXT8vLteX8ugseB7SKR4fw
	 QoSs8fUeUs1vnSgQ1PJkTMdfNKhzl/kUz+8fWAPLwXFm3x3iyHfZd1anuCdaLzwd3y
	 c4Fl/GiWtyMjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 342846066E;
	Mon,  9 Nov 2026 02:30:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 073BD235
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 02:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB0AD80E33
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 02:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCmNlkoUaL9q for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 02:30:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 73A3080E22
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=acelan.kao@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=qzMfd/tW
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73A3080E22
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 02:30:01 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B20DC3F193
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 02:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794191398;
 bh=J93yaBx7zQqNHymwSqDOniHqyY+PToYJG4eT/KK5h7U=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=qzMfd/tWp9dcQ/E6nCN8lF3mlq3Exa84tJOIneqx5vHta6JD5ly1OljjGFiT4tL6z
 qtkjU17AJvMOZ2l+5ZEzEFk3uMDgSJtxZq47zXJHLOQAKp0UyUdb4Gt4Z5KfcZBaYy
 9e4LsyV5wVh/c0ASgN/M2iv3cKr0Ynyl45yo77wAxscXuqLgpxLV3rgjhzfCOSDZMs
 3OEFMYAhkZDjUd1KD1t8JqCKKUby8FjtzV5SVhm64rpSDoqTNqtitfBqHCGvioPMqP
 rVFmYcPLPtSgicf4dBYPGlevGFeLKZERGUcZL/qF43pESHy1ax8MvoKTdlPpOe3eGH
 UxcqlF5kmEA5+ScjSJCe46C9Zm77tBw+LfyHDag/xN0dKZqo5dc+y5Sy2QelE0ohFI
 SyG+6C6DAgXdo+0RekXHcSK0yiMFrt1unyj42H6v+QTkUh7T0FudHx3klyASGtJXSb
 C3FUJgkIExhC9vUN5oVQaPXcn71Be7rjAcS1q+eCwGDRik49EiY3cRwvegCIMTA9tf
 prcARkk/6vFTM5B4IuciledBLkVlsvKt7eix04QIyteIuu4kzHWdJGuFs9Yx6XBtBk
 uvNOPX/9YNlg0QEnX7TE6RUyPIfQh8C2hkF6TxX5okgGC66luHL1jKNh9N2ZxoP2ME
 bM8yH9c/nYpPaFBS1EazlMyU=
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd5fd34fee0so213388a12.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 08 Nov 2026 18:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794191397; x=1794796197;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J93yaBx7zQqNHymwSqDOniHqyY+PToYJG4eT/KK5h7U=;
 b=LgkJBVoOdJ8Y7iwwjrjBgJ3VK/4yNBANsW0XJXuPzzD5iKIiyfLaaX/ydxLA6vgtIx
 U3K36L7cAiCO+Pt6BIsDHJxMOxnCzSmGU0nN1LubBL37cQqlm7gepzWv3OUza24PNReR
 LdDEJEvgVM4LnB6ryNBnG5tKWF2SOEzkqZkMGEfPpgwj9UeNyfxBC7QvhbnyD4H0XCl4
 0BeZh8AMTXhBGYaf2R5wqyVp502Uayx9hMRZGybTVrAFMv+0QMh75YJE45Psvv4DTjOi
 ylAr3L/i2nBIGIBOW/sHl1DVEcLlltiFCAJMuTU60HM2DUHb1cB/9epFxIK9bHdcT7Sv
 gdhw==
X-Gm-Message-State: APuU4Z8EgAv0F/UhX4ez0KbHf/wM2oXK0r1Ix22gxGSt8XFbzap/M6Wu
 11G3uq/iwz4rot0Ondq4ayfn3XwjHGzaE7f0seWSbEfI3Tw6Fa4s9R+DaDmyLmTeaLtGTurq9vn
 PbjM97KY8bgaCYkwFpD8aJvxRiBS+DpsEc2cTy0CHVlc1mQgPGQlqCybqf+CVO5EqwLJjpK3aYu
 8kAWk7r7eyYmI=
X-Gm-Gg: AYBFou2MQtnZixS0eEUv+6eNlmL5HrfubhncC0Y+O9uTLxUZr/0WzfGoIdIOCJFqunT
 zKkOQy3cyOXEv/ox3o0PumMyrYm++Dyj/ehRGPZ46GxfP/Bp9exk2iSJfvXbGMMMGBUv+Dceq27
 6MjmFXzJ3SEQdchPx1KkIhgovkOXgLhS3AlaI+CAo5vuskFk9VpGu2Qulqq8ikrkeXIqLEQVPzo
 C7gzQjcQMrWVjXfCRw0BJqr39x+MXrutEqMiVLzUJY3vrbLfEvHi3ssMLh3ykWRCzfH9KBMI4eR
 nWppq0Et6nW+McZGElOIMyqOazVaOMptIfi43eTHfXPbH2BajZYpzZkSkfS/4ciDhko89+2nrhq
 SojSl/CPqIUlL1c7Kb4Qlp1+SAyoet4odOxca9EsHOh0RAgIodf+7nCJt4vRvPqDNdN7N9+qX3R
 5gjfd4Sfc5Z3XXUzdoUjLoiHfFGv0=
X-Received: by 2002:a17:90b:2648:b0:3ae:8410:ae6a with SMTP id
 98e67ed59e1d1-3b12d2b0dd1mr2532912a91.22.1794191396882; 
 Sun, 08 Nov 2026 18:29:56 -0800 (PST)
X-Received: by 2002:a17:90b:2648:b0:3ae:8410:ae6a with SMTP id
 98e67ed59e1d1-3b12d2b0dd1mr2532895a91.22.1794191396401; 
 Sun, 08 Nov 2026 18:29:56 -0800 (PST)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net.
 [211.75.139.220]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb9677c568sm1201354a12.2.2026.11.08.18.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 18:29:54 -0800 (PST)
Date: Mon, 9 Nov 2026 10:29:49 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Dima Ruinskiy <dima.ruinskiy@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 allen.lan@intel.com, kuba@kernel.org, horms@kernel.org
Subject: Re: [PATCH iwl-next v5] igc: Support ACPI-based MAC passthrough
Message-ID: <avEvuDcC8siMBwk9@acelan-Precision-5480>
References: <20261012194817.10409-1-dima.ruinskiy@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012194817.10409-1-dima.ruinskiy@intel.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 12, 2026 at 10:48:17PM +0300, Dima Ruinskiy wrote:
> Some systems implement a system MAC address object in the ACPI table,
> using either \\_SB.AMAC or \\MACA object names. This system MAC address,
> when enabled, is intended to override the permanent MAC address of the
> any network controller attached via a docking station. The purpose is to
> allow the host PC retain its network identity in a corporate environment,
> regardless of the specific docking station it is connected to. The
> expectation is that only one docking station is attached at a time, or
> that only a single network controller is plugged in at a time.
>
> Implement seamless passthrough of the system MAC address to the
> I225/I226 network controller, by looking up the relevant ACPI object names
> and using them to initialize the MAC address. Limit the lookup only to
> controllers that are Thunderbolt-attached, as these are the only docking
> stations that can pass through an I225/I226 controller to the host.
>
> On systems where the feature is disabled or unsupported, the ACPI objects
> do not exist or do not contain a valid Ethernet MAC, the default MAC
> address of the device is used.
>
> Assisted-by: GitHub-Copilot:claude-opus-4.7
> Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
This patch fix the dock's ethernet hotplug connectivity issue,
please consider to merge it, thanks.

Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

> ---
> Change log
> v4->v5:
> 	align MAC address to 2 bytes (required by helper functions)
> v3->v4:
> 	use pci_is_thunderbolt_attached instead of device id check
> 	explicitly save permanent address when using passthrough mac
> v2->v3:
> 	fix typo that introduced check reversal
> v1->v2:
> 	limit scope to dock device ids
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 70 +++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index f6d1ee75627d..d51e9bcdfc3e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c)  2018 Intel Corporation */
>
> +#include <linux/acpi.h>
> +#include <linux/hex.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/if_vlan.h>
> @@ -7134,6 +7136,58 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
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
> +	u8 buf[ETH_ALEN] __aligned(2);
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
> +		    obj->string.length != sources[i].length ||
> +		    !obj->string.pointer)
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
> +		ACPI_FREE(obj);
> +	}
> +
> +	return mac_found;
> +}
> +
>  /**
>   * igc_probe - Device Initialization Routine
>   * @pdev: PCI device information struct
> @@ -7300,6 +7354,22 @@ static int igc_probe(struct pci_dev *pdev,
>  		/* copy the MAC address out of the NVM */
>  		if (hw->mac.ops.read_mac_addr(hw))
>  			dev_err(&pdev->dev, "NVM Read Error\n");
> +
> +		/* For devices behind a Thunderbolt/USB4 dock, look for a
> +		 * system-provided MAC in the ACPI table
> +		 */
> +		if (pci_is_thunderbolt_attached(pdev) &&
> +		    igc_get_acpi_mac_passthru(hw->mac.addr)) {
> +			/* Set the permanent MAC address. Leave blank if invalid to
> +			 * reflect there is something wrong with the NVM MAC.
> +			 */
> +			if (is_valid_ether_addr(hw->mac.perm_addr))
> +				ether_addr_copy(netdev->perm_addr, hw->mac.perm_addr);
> +			netdev->addr_assign_type = NET_ADDR_STOLEN;
> +			dev_info(&pdev->dev,
> +				 "Using ACPI pass-thru MAC addr %pM\n",
> +				 hw->mac.addr);
> +		}
>  	}
>
>  	eth_hw_addr_set(netdev, hw->mac.addr);
