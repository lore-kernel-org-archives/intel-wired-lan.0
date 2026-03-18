Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE7C10775E6
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 16:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE5E82FF9;
	Wed, 18 Mar 2026 16:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xlc7gO36nKCP; Wed, 18 Mar 2026 16:16:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAB2482835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773850590;
	bh=Dla1BTbyc4l54nWX3/vfHTdXPEelTK/vnnV7aOlfzTg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gdD58kU/SQxOX4k2hsKHNGqJQ5Z4JJEsM921w0Tugh6QPTtIMQ5KGZGbcZuty42xO
	 TiILZr+JEiRfaaxG4G7hKrrH8KKwQ6qTvphmHF+8gCJ/C8+hJ3uRxGLvO9gDOqHuLS
	 pW2nr3W/sPERs9XEBgL8DN59KGH+Q0T1GKwy11Sk4obT7Hb+109eFNRVM60a8cTLeC
	 42YKyLltMUgW4WU40P/91A+G444U2ubIcQ2Wj3TechFD6gfy1xYFHy+rYzaSkg0irW
	 BgIh+1AQZI2c2NvLRCl+7bO8HWhCO/jXVJ3gFloN1Ba5IZtIgoKvBNJ2RuIUMCF3/9
	 74MmL2cu2Ka3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAB2482835;
	Wed, 18 Mar 2026 16:16:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DA681AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 16:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EA7082835
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 16:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ut1EzQhuQNU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 16:16:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=stfomichev@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5F08A822A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F08A822A0
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F08A822A0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 16:16:28 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso101777eec.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 09:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773850587; x=1774455387;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dla1BTbyc4l54nWX3/vfHTdXPEelTK/vnnV7aOlfzTg=;
 b=LDgRflLTLPejFQ2SPvANG0xPd8sGWDX5VuVtQOJK3m8tl7qEAyZRYLMpyDiinN8m5h
 nmmRHyV2ZM7dXGeMcim08whitDVCjHlTNG51bCzxYEMNun2V/QJ9dpjM1unE48tGIStq
 6kZOZ3cDHctCtL3uv//KbjBsEMLCzvcDjutkl2jtfZ2guhVkuf+orrjBnQz6CbvwWduw
 s7CuiGB+UWLCWQtJcehp4puZASQzdHZ/JscnxBahTVMuf4O29RLDP8iSiVXNwIufv3jZ
 7KVr142+4NTwq0qSy4NlCX/WQcrNB/ZDlA+upM7jCcTv51WcxuoxPLlnZgnvaRYBGKnz
 t0ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmaLsuXBfJ3gcYEjXArxpNZw+g9ERd5XrspUugS2l3QCyvd9zgybokn0MQkkQjgzNxX/w3ECatJ2VWj36hXQc=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yy3P0sPMyCH86BtfoBSwS98z5umCxJM1G6+fvVBOSlJKMB2v6AY
 gqquCs6zwVTcMb5JjoSD/fcp/ZYRE+otghDaUBDKOxbRE4pCKLD+KVc=
X-Gm-Gg: ATEYQzx4KbfPHyys9yF0RQ+FdsZ/hECszrvcelMKhkgdmW0ejGhbykZwenbQQLEJ83E
 XGqb/xFASuj/dG0JSY2oIXzSlpnkQKKKY/fb1IDe8eYNCT31FTtlfNyO8al07VLU5CIRV0QUXBx
 Ulgyc9d5hEFtuypBpyybSBFANuSvd2TfLweNqpRlVxEClo7OSbMxc+CnW32Zlq/cQFw1lgmSQDg
 ZU6gZvkGlO575YHCIwpzEOKNYGYg2vs33haAyhzrlCTaZ+Kl9zT7jB33eJqbOZaAkUNNGf4U32u
 USqI0ixSaNYg1EUXAtlEPRLm6D8VkZgG4uLLlMMDW6zfZZlubTuNjMskp+o6BFci0mDRQ6UYxE+
 iIT7sgk+83xxUyayGruQLVqSr64E2npbsGsrap7ac6FIcEeroulQA45UaixW4Ph8fo0usHxYi9O
 mZ7AFw0KSXshrrCTX9dK6RInQdHTH1uYRHHvE0jz9q4TopBINWOjojlfUtzv5bAqVojfVmpH4bG
 EVm/Hgs+ZeNJWmvSw==
X-Received: by 2002:a05:7022:6a5:b0:128:d471:8c1 with SMTP id
 a92af1059eb24-1299ba3e555mr1770451c88.17.1773850586365; 
 Wed, 18 Mar 2026 09:16:26 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-129b41289e7sm3582603c88.10.2026.03.18.09.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:16:25 -0700 (PDT)
Date: Wed, 18 Mar 2026 09:16:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com,
 jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
 bestswngs@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Message-ID: <abrP2NavLA4f5iHE@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com,
 jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
 bestswngs@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-3-sdf@fomichev.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318150305.123900-3-sdf@fomichev.me>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773850587; x=1774455387; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dla1BTbyc4l54nWX3/vfHTdXPEelTK/vnnV7aOlfzTg=;
 b=Z6ZRSvzLzllHal0qk1uZgCNeGuNgOAfC0k172hofQy+mXtUFHzmpAMzDFeO1+6djyb
 /UFMHzOeQiL1dKbxbO/6plw6eup+Z71snbP4BRSKLHg/kQBdcxds63enZDQKLI5QlFeo
 zZ3GKjEHwPHApHQie/t7eE3pYTj9LHlFJCvbHnt4L/XNGoeeDrpTbP5tvEpA2C3MuO4v
 vHYCUHQuq7GrTAREHio6FP/g3mb9/W0LT10pIg5Tr8PreGYuyrEH7eGNK+Whkm0TJcW6
 xRsMC9gjfGvIp7Bl3PS7quT+VlcuvaLBYZNq0OUdXgJMa8e7ZFY5WXTIujNMsyKk7RRq
 QPiQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Z6ZRSvzL
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 02/13] wifi: cfg80211: use
 __rtnl_unlock in nl80211_pre_doit
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

On 03/18, Stanislav Fomichev wrote:
> nl80211_pre_doit acquires rtnl_lock and then wiphy_lock, releasing
> rtnl while keeping wiphy_lock held until post_doit. With the
> introduction of rx_mode_wq and its flush in netdev_run_todo, calling
> rtnl_unlock here creates a circular lock dependency:
> 
>   Chain exists of:
>     (wq_completion)rx_mode_wq --> rtnl_mutex --> &rdev->wiphy.mtx
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(&rdev->wiphy.mtx);
>                                  lock(rtnl_mutex);
>                                  lock(&rdev->wiphy.mtx);
>     lock((wq_completion)rx_mode_wq);
> 
> Switch to __rtnl_unlock to skip netdev_run_todo in nl80211_pre_doit.
> This seems safe because we run before the op.
> 
> Link: http://lore.kernel.org/netdev/69b5ad67.a00a0220.3b25d1.001a.GAE@google.com
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/wireless/nl80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 2225f5d0b124..ce5f25d4c87e 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -18192,7 +18192,7 @@ static int nl80211_pre_doit(const struct genl_split_ops *ops,
>  		__release(&rdev->wiphy.mtx);
>  	}
>  	if (!(internal_flags & NL80211_FLAG_NEED_RTNL))
> -		rtnl_unlock();
> +		__rtnl_unlock();
>  
>  	return 0;
>  out_unlock:
> -- 
> 2.53.0
> 

ERROR: modpost: "__rtnl_unlock" [net/wireless/cfg80211.ko] undefined!

Gonna re-run local nipa ingest locally to see if anything else pops up.

---
pw-bot: cr
