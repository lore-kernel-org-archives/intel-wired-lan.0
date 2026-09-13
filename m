Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651E5C88E65
	for <intel-wired-lan@archiver.kernel.org>; Sun, 13 Sep 2026 14:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC7DD605C7;
	Sun, 13 Sep 2026 14:19:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WGTyJo00lTu1; Sun, 13 Sep 2026 14:19:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E72A7605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789309187;
	b=Z474pvMOz3uXs+jBCuzzIZg6RFxgjfzK8L/hdlm0InIgyTDWFX7BGDUsEL0GyZLBdkpV
	 4BZPWQ8cmX8ICTd7LUFWaZmaDurPxGoBC0qDU1bedpcvGW9jmcyNUjLFLKvoJO+8reDt/
	 ydNRnWZOp/ZTYsFJC+2jnT+jUlSWhV4mcwCqvxVNFsaTrqjWjCNJHNmIkkc4H9Xfh63wc
	 lu9QHas2Eeir4EkZB9wxiynP7DHtSDXIBswr269ov1DrNzLuYcFchOfKq4xoC5dOp+F2L
	 vg+P8gNfA/AcbgLGS3YhGpIkqiR98eFqta1+52aAAQKEnrOgAHnlVQF7y4ExheISPIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789309187;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=A26g259BDrlJHZC7IRx34CchJ/YSK3vSxI7SlfEslyo=;
	b=W9nfune/L4n04tF65KXcdYWs4glI1oZMykzlhfSGl8qdbVZni5f1JJUM3qRGvjS4Nr0e
	 BPrbX1/amBdDOxD3LbdwqjtVC3hqW/k6jMQ9I5DT9qpTB/OzIdAu+D6IbqPVMVW1+afsZ
	 1RsHn5KXFEGRlPUAjhfxx8c4ncw/KuFSR4C74ry4GWeJV0NNkSZKrYjvh5lLxk0cVZruP
	 vcDjhOTkRaog5cpi/Bw+WiKAtQMgU4KzfErcaQl17zCQWqTQeVW8lI6ZqH6lDdiDvPmZJ
	 gigldQF5L03GTnebO0M2cjBSD4HGrMZSth11oKrLVOXap1/ji3sLRqdQez+NvJ3R6Ew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789309186;
	bh=A26g259BDrlJHZC7IRx34CchJ/YSK3vSxI7SlfEslyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ntrDql0ZwlFpQpXmKBWxH56J42uiDX7HhN9nJLVVCxvEzsM7doxLmm/ZyGjMdDxcl
	 emJx/EpUCInICcC2Eew9x38UtE/jcagNbUStLIf3j24PNn8FrlA5vCZti1/h5cFhVS
	 w+tJ7vttjM6cnR970Gj0Rq96cRqYVEmwbsKigvQKDyhNxpDNi1kjptindeee5qe0RS
	 OHHjAudV+qbky3aRMAnAbY7LNFBsD23cu+TFCJwuAtZit24pny0ocnau7n2/yFvmRc
	 aZL3fzWBZEvSZ1oaoXrVR2KG66/wPT9+q+EtJW1J6Xftd9U2NTaiNZQRHfj5SUIprt
	 US1evFeV9QSXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E72A7605DA;
	Sun, 13 Sep 2026 14:19:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13D7032F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 14:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDA0680C12
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 14:19:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1KcXau9FfVE3 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 13 Sep 2026 14:19:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D435980C09
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789309185;
 b=SWTwV3YnyfMf3DmRaHw/wxpqp0H5VkEJw8oaoC2nK+wPC5GcPQ6OVCKjivop9onzCSR9
 NT/a+4i7EGXqJWASFdyJnYtZMur61I7cHo9qa40u7gfhU3yWJtwBHvctXZGN1F495Dine
 JacuCxO2jfRBDt++G6mZCvkwofidH3KAtbvfUw3AQv5OxtRioKT64MMJQDJPlJvKbKWu5
 j0QHXf9QO/gpRUAMfv+LxyIcWNIXnTmzK0BHc50a/WUGOiN+/XtUlisB7qAnCqAWjsFEP
 cX2TuohI12p9lzL44eAn93Nw7riXe98083iIR1e+bd0+gNEa6eoIICCdXf07QvnR+Pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789309185;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=A26g259BDrlJHZC7IRx34CchJ/YSK3vSxI7SlfEslyo=;
 b=dCsSv8LOz3S1TK83zB+MtDXgkgkekjs8UTP3BxbwbNyxZSCAM7AntWpFhj8iHBLeu/S7
 lYQsBdHcBuyRsWRZJyLZ+Zb3aiEbrUlYVwPKhOOA2LWHh2O0/qzUDgSvdBkQV0z4jdRoz
 0HVGBTW30w2OsPa6hrgscVU+EoLUgHXvmW7x7L1cNntXGBUDj5TYi5T14b5GkAr4laic/
 uxz+RbjZCSyKeVS8Ql0lJDJnNFdYiuB9CVGgbUiJNefNi7l1ZgKvaAQ2PihhfvH2ZxGsg
 f+yrEy0BWuhF+vKOFkp7UvaZ6uvKrz/RObsLxD3QpRJDolGI6Kq7SDFsYGY95rOI7RA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="gU5OZv/X"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gU5OZv/X
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D435980C09
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 14:19:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68A5460E39;
 Sun, 13 Sep 2026 14:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447041F000FF;
 Sun, 13 Sep 2026 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789309181;
 bh=A26g259BDrlJHZC7IRx34CchJ/YSK3vSxI7SlfEslyo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gU5OZv/XdNsmCidptMff2vSq77GUciYmNyI/S8Fdk3S3YqBgzKVD3O4S9Ca4xhDJc
 L+xNY+vIhVOc8inYBD8CJ11JZtvmTHjJtVSJK5ukFlw3uPHg1a6DgvfuhZ+qkU3DpQ
 a1/BzdTFW5Jw8fua0mxvpkSGk+ALMY4MgQLshT1wAMZ1R5Pk/0gleIMLnhG11KgK7v
 ChAVd+BFen9ObWOLu6ntCwZR17RIPT5VAnqK2Qzj9/zcXpv5n6laXb6qfvOTYD3vri
 OiXgkiTDk5AvrfY4oHesF28hZ0y8ODolyd84+vqRSivkDKx+oSleYnHNevxJJo6oea
 TFudzyyMU/XSg==
From: Simon Horman <horms@kernel.org>
To: dima.ruinskiy@intel.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com, allen.lan@intel.com,
 acelan.kao@canonical.com, kuba@kernel.org
Subject: Re: [PATCH iwl-next v4] igc: Support ACPI-based MAC passthrough
Date: Sun, 13 Sep 2026 15:19:31 +0100
Message-ID: <20260913141931.205787-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910193824.3257378-1-dima.ruinskiy@intel.com>
References: <20260910193824.3257378-1-dima.ruinskiy@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260910193824.3257378-1-dima.ruinskiy@intel.com?part=1
---
igc: Support ACPI-based MAC passthrough

This commit implements support for seamlessly passing through a system MAC
address provided in the ACPI table to an I225/I226 network controller
attached via a Thunderbolt dock.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..abffd385f3e8c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
[ ... ]
> @@ -7106,6 +7108,58 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +static bool igc_get_acpi_mac_passthru(u8 *mac)
> +{
[ ... ]
> +	acpi_status status;
> +	u8 buf[ETH_ALEN];

[Severity: High]
Does this array lack a 16-bit alignment guarantee? 

Because it is declared as a simple byte array on the stack, the compiler is
free to place it at an odd memory address.

> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_ACPI))
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(sources) && !mac_found; i++) {
[ ... ]
> +		if (hex2bin(buf, obj->string.pointer + 9, ETH_ALEN) ||
> +		    !is_valid_ether_addr(buf))
> +			goto free_obj;
> +
> +		ether_addr_copy(mac, buf);

[Severity: High]
Can passing this buffer to is_valid_ether_addr() and ether_addr_copy() cause
an alignment trap on architectures that strictly enforce memory alignment?

Both of these helpers cast the pointer to a u16 pointer to perform 16-bit
memory operations when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set. 
If buf ends up placed at an odd address, this could cause a kernel panic.

Could this be avoided by defining buf as a u16 array or by adding an explicit
__aligned(2) attribute?

> +		mac_found = true;
> +free_obj:
> +		ACPI_FREE(obj);
> +	}
> +
> +	return mac_found;
> +}
> +
