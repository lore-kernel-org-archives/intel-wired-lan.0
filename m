Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA23F46137
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Mar 2026 15:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21C34825C7;
	Mon, 23 Mar 2026 15:03:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id THq6k3VmZruw; Mon, 23 Mar 2026 15:03:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3D7882591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774278231;
	bh=65XL03/5D/OxM0Pku9HxE63oFNPPzZeXqQncP9gzT08=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ZPBMr2OvsSYD+rQkc23+P7zsrK6iVUpqvgDd1fvYctECIP5Os6Xrz6qf3BlD9LIxa
	 uE5iQuo4ssmR1IMO1uRtEOKJGCPvzIhKEva8UZCp8yxTDeevLsRD6R+ManZR5o9QWg
	 I9ftt7GcNLQJBQuc+h7Ims3vUqy2Bf9rsWv5OaciScQLrFIeocUm+Gl7Y+t5hjeXnH
	 4VuIJu/vM/98vkyYazmJstYB8A2+Pr+TrH4BU4Q5PDk+wi7AURr4LnEqu/1Sn94Ghj
	 m1XEgUhfyzZqFEircwmo3YPXjsddWSoKOtbROxqtNStIUAyW1SnkEC85KqVa2XCNbf
	 Q3LgaPZcD8orA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3D7882591;
	Mon, 23 Mar 2026 15:03:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C0A2F4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 15:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DB5E401F2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 15:03:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xVR0st2WRUbd for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Mar 2026 15:03:48 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 601C1400BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 601C1400BE
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 601C1400BE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 15:03:44 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486fe655187so38712455e9.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 08:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774278222; x=1774883022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65XL03/5D/OxM0Pku9HxE63oFNPPzZeXqQncP9gzT08=;
 b=LsTGYI9OQb4/3RtyJC1cKudsXa8+wxpXxKEriBSxX9cVxbLlg7XwaG38KmtHpSEwpc
 8EipvG9aCU7fHY8J3TY3RsfC1WrCzYWitbbM52yhIjtZxiakyw0jeMtqYwVLbLweeC2d
 4tsMAkjgQ11wapFLknQkuVDpnFZOPLoUZkpkTkxzlvVgKWGPg0xcSI61XKbfY6K0ZKno
 r8LZ8qA5nKUytmBqOLKxJxv34KaUMp39Hgy1hzvO/hUUbqaCKAWItKT2fnsWkMN5nlIw
 4JijCdJ56gLThgNv0rMg/SPlsEHV3xPGuXWFtZTmaMfENtgTug5OZ7NZruBLcUmMiHLH
 uyew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVADn2x2uEYSSpCoSkQoMbzGb+2XuujFgav0uNeGjNu1WqXDMZNQPcYm0G3WWLWuRIucTGBXzSTOcA0jVH3ato=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzBj6zAutppU8mKt8F4leZgP/3O7ca4zKqZ8ShpWHdMA+fi8Z7k
 /TC5gP+gNMb66+POHuIGwzRjwU9xcyVXzwpFOiKt8EpoaYfEL4DTSN+5c17XnOXEAGw=
X-Gm-Gg: ATEYQzyWus9Iwgmclw1YtldkkcPaV+rqE11akECFTLvXMfvFU6+Zq28F0J6TnNg8V0n
 d0vZ1jzWbGlZVOArj+Wlgg+liQn1/JQzvC+dusPUIPtjjIe5/mGRaCbG8Sppir2y6GPiLRizXux
 SLaz0QN0YRVK5BRQ7TK5vOZ12ScpUfcWxiX0PQRxhr3P6ftA1DCguatU9lwt8kPFmjL/MZASBEv
 4eoCmW8CfVjC1YWHbo43hfKig0rRFA+0mp6xGpR3sOnChC1Bqa2WvHA5aUCj9j1Geu9UW30K7OT
 jyznGpOQg4LMUlqIU10zNujX/a49ZvhXyrVUELrFa04T3UaIwT0LpWKs5piCixhtDtv7mmxMiUn
 xZJYxbjyQwSQ2nCvK/fEsU6DfCkZhmpKgzJpuAQW0PBl0qJVOhNlFJD2w9lSp6M/DK9y3P7rfWL
 x+bEXPwhEpSStc1lMFOGV6spQAqohQh9w5jbw=
X-Received: by 2002:a05:600c:1d15:b0:485:ae14:8173 with SMTP id
 5b1f17b1804b1-486febb5ffemr174241675e9.1.1774278222241; 
 Mon, 23 Mar 2026 08:03:42 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe6d923fsm464712385e9.1.2026.03.23.08.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:03:41 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:03:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <fc7iebxveew5yi2trlpumcmugwzerixdm536kvgp5hlxmm4zw6@vmcbn76n7fvt>
References: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774278222; x=1774883022;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=65XL03/5D/OxM0Pku9HxE63oFNPPzZeXqQncP9gzT08=;
 b=l858RTMUIcj3xrnGFuFLl4X4I7Suxm3mN8k38WNd/GjpcCvB7yu3Y6P3+GPkgl7CLN
 Oni2wGa+lofBYACw+w+E0rpJzEWE8odwtP8f9my7ahAs9gHQLh2CTUVB+/3Y0zGA7cQJ
 BziL4sDfQlu8F9uA0UfS40fX6wqUGbOOdTpjOteiSUvmjbMx6hyh0TGp5GM8lwauWnTu
 wKSAyaWngrLAHiQ970fF8XoFCJhIaOaYXfM74BzVC7p0I9S4WHZHSlY8MzMeAyY/WF5K
 ABOJi0oGZXWg+lnlEwhBMDmFVFkb/rMOpl3DQNvenhsxbHr/YFmXKpxKcDLE2KVO5z+l
 C5/w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=l858RTMU
Subject: Re: [Intel-wired-lan] [PATCH net-next] devlink: unify
 devlink_shd_get_priv() into devlink_priv()
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
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Mon, Mar 23, 2026 at 02:21:36PM +0100, przemyslaw.kitszel@intel.com wrote:
>Unify access API to shared devlink priv data with normal devlink.
>
>Thanks to Jiri Piro, we now have ability to create shared devlink
>instances [1]. Introduction series have added usege of those for mlx, but
>without priv data attached to the shared devlink.
>
>Current API makes it possible to access shared devlink instance's priv
>data:
>
>	void *devlink_shd_get_priv(struct devlink *devlink);
>
>but it is easy to to forget (especially during rebase from "before shared
>devlinks" era) and call:
>
>	void *devlink_priv(struct devlink *devlink);
>
>which even has the same signature, so it's hard to catch the error.
>
>New proposed API unifies both calls into one, without any increase in the
>observerd struct size. (Alternative could be to store additional pointer,
>set during devlink_alloc).

You should use some AI corrector :) too many typos.

>
>Unexport the less convenient API call.
>
>[1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'")
>[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us
>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
>sorry that I have not mentioned it during [1] review, it got obvious
>for me only after working with the code
>---
> net/devlink/devl_internal.h |  4 ++++
> net/devlink/core.c          |  3 +++
> net/devlink/sh_dev.c        | 11 ++++++++---
> 3 files changed, 15 insertions(+), 3 deletions(-)
>
>diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
>index 7dfb7cdd2d23..abbe308ee9bd 100644
>--- a/net/devlink/devl_internal.h
>+++ b/net/devlink/devl_internal.h
>@@ -58,6 +58,7 @@ struct devlink {
> 	struct mutex lock;
> 	struct lock_class_key lock_key;
> 	u8 reload_failed:1;
>+	u8 is_shd:1;
> 	refcount_t refcount;
> 	struct rcu_work rwork;
> 	struct devlink_rel *rel;
>@@ -72,6 +73,9 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
> 				struct net *net, struct device *dev,
> 				const struct device_driver *dev_driver);
> 
>+/* Get private data from shared devlink instance */
>+void *devlink_shd_get_priv(struct devlink *devlink);
>+
> #define devl_warn(devlink, format, args...)				\
> 	do {								\
> 		if ((devlink)->dev)					\
>diff --git a/net/devlink/core.c b/net/devlink/core.c
>index eeb6a71f5f56..4c97e2e2c073 100644
>--- a/net/devlink/core.c
>+++ b/net/devlink/core.c
>@@ -232,6 +232,9 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
> 
> void *devlink_priv(struct devlink *devlink)
> {
>+	if (devlink->is_shd)
>+		return devlink_shd_get_priv(devlink);
>+
> 	return &devlink->priv;
> }
> EXPORT_SYMBOL_GPL(devlink_priv);
>diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
>index 9b7456d64b57..450e3218759e 100644
>--- a/net/devlink/sh_dev.c
>+++ b/net/devlink/sh_dev.c
>@@ -31,6 +31,11 @@ static struct devlink_shd *devlink_shd_lookup(const char *id)
> 	return NULL;
> }
> 
>+static struct devlink_shd *devlink_to_shd(struct devlink *devlink)
>+{
>+	return &devlink->priv;
>+}

Can you rather have unexported __devlink_priv() above existing
devlink_priv()?


>+
> static struct devlink_shd *devlink_shd_create(const char *id,
> 					      const struct devlink_ops *ops,
> 					      size_t priv_size,
>@@ -43,13 +48,14 @@ static struct devlink_shd *devlink_shd_create(const char *id,
> 				  &init_net, NULL, driver);
> 	if (!devlink)
> 		return NULL;
>-	shd = devlink_priv(devlink);
>+	shd = devlink_to_shd(devlink);
> 
> 	shd->id = kstrdup(id, GFP_KERNEL);
> 	if (!shd->id)
> 		goto err_devlink_free;
> 	shd->priv_size = priv_size;
> 	refcount_set(&shd->refcount, 1);
>+	devlink->is_shd = 1;
> 
> 	devl_lock(devlink);
> 	devl_register(devlink);
>@@ -137,7 +143,7 @@ void devlink_shd_put(struct devlink *devlink)
> 	struct devlink_shd *shd;
> 
> 	mutex_lock(&shd_mutex);
>-	shd = devlink_priv(devlink);
>+	shd = devlink_to_shd(devlink);
> 	if (refcount_dec_and_test(&shd->refcount))
> 		devlink_shd_destroy(shd);
> 	mutex_unlock(&shd_mutex);
>@@ -159,4 +165,3 @@ void *devlink_shd_get_priv(struct devlink *devlink)
> 
> 	return shd->priv;
> }
>-EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
>-- 
>2.39.3
>
