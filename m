Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92674109C04E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Mar 2026 17:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB523813D7;
	Wed, 25 Mar 2026 17:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRWfBhIB8Kge; Wed, 25 Mar 2026 17:35:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 32FC7813B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774460102;
	bh=6LvfhXxnMpqu+8Jaxmf8YnU74NbO72vJex03sq4AEB4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QwI0QdyNRVNsEbOyYppyuUzkRbz04nAKCs5NaRxOtQ7YMfD8ZmhqVRpRuj5R2PsvX
	 o4S8ufheg5TFa0wgd0v8TKGnhS9EUyhGRpmHLn7zzlgjCfUT6Y7r8+XpN0GI9ZWmkp
	 ult8EOQbNJsNJLuCMu+fG4Ge8ET7atsnQUlR8D4fDWKry0Zmzwk2UkpzJGLyJSVyu6
	 kXNUWqubEjn9I62Qc+QfV3EDGgawBH/FTyGpc51sIHEal820EmkqIbuDd+H5cntzkB
	 oII+EIAz2qx3Fwuzi3mUprzZnCZBMkqagX5cGkglwSpZrgSYdOvPx/ikkoFidmoWjh
	 fWrJSuSkhJgbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32FC7813B5;
	Wed, 25 Mar 2026 17:35:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A1065353
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 17:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86A6B401D7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 17:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zooSHo0eBQwH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Mar 2026 17:35:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com;
 envelope-from=stfomichev@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CA6FB4009E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA6FB4009E
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA6FB4009E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 17:35:00 +0000 (UTC)
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-1273349c56bso144365c88.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 10:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774460100; x=1775064900;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6LvfhXxnMpqu+8Jaxmf8YnU74NbO72vJex03sq4AEB4=;
 b=eig0WVS1ZyIyYYpXUdBqWnxJCm9MtO+r3V5ckir4/wPaMJhfPsfgTWQrkHRLKys3lV
 fpHTPPL7CPlYjUNK+GF6vEvR/q8Z8mqnD/Rj2FpIhLZ2iYQgFnxyCfYmTP4OGVuQc0li
 acK8b7ofpCqx5l4cFvI9yXgulJA7t6YfwtVWB+fs00nh25sWUuZu00d6xAoibmNHau7i
 7GbJu99hmW/vyaAjXdIF6i9SVIho46WlvAWboWFOL1chSdPk4N/Tfo1rZbAQj7gDhigQ
 RK1qPe/2ikilOfcFTVDryfgMpVvuHs8PuwM/Re5F0UEZ+AaC3G7OGNKWZc2yJY/jzHoo
 dmAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2aGLmWpEFxhGbR1n1dDVL4Y/oMkyWR702Cpf/7ogzb19j36kqRheDuLhpkGemnGiTlvmw9XJXmZEquKj5tc0=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yy6ZxaFVa64fMp+tBhsB2TdSYKJaSIYd/BjDaS3KMIB2tQoF/WX
 t+3977Pa1UxDMdejFFkpqZogxFbVXEVfKtak2fK8JSCsUzDFrSlAjRc=
X-Gm-Gg: ATEYQzxWgjAFnZ1aIQ3lQHBB+dVeU2cjyCrX4qijmaGRGy34aDXpD94sSYdRJM+Q8YP
 +5VMeWk+4Fa7q3JE+p3LEkm/92aO2y/mlYthSDqiRNO5lyjeSRs9YebRDK2jmD+TfIpcYblGqk3
 Yr0HYBAFpIQyB2yjEq1TA1+itG63lnzOtoBQxGwtI4ce6aHjdtjj5Z9k1VFE5/9fPBe01mmZwBb
 wWhX7zuir69wayt8reTEYWjS7H6JKnEC7gblsCrpcyIAYYnUSjxihN7ExKXANB69aqGlj1E4Agu
 chdYP9dKa4Wo22y073CGGkhlHwOvZ++zHXrE4TnSBPOjtUIlh3gKucgI3f5u3JyjcBJiI+k4UEb
 XTTCFyR8qPib5izG7R+FthM9i0ICWgMOFusvaQD2APC7ORRv8k/Vf+zffrmR97IJbRUXr3+pzxf
 bIPZs8hggrAqZR2IiQ8Cw28R6SIgzo8zE8KwTZyq3Pg+kqngZhF9znWHeLudE21K+PcjDuz71DW
 +9W5nFT7tVs7yiwGQ==
X-Received: by 2002:a05:7301:1e91:b0:2b7:1d38:3596 with SMTP id
 5a478bee46e88-2c15d32adfamr1794122eec.4.1774460099374; 
 Wed, 25 Mar 2026 10:34:59 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ee01373sm211727eec.26.2026.03.25.10.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 10:34:58 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:34:57 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com,
 jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
 bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
Message-ID: <acQcwZOXJjPlVpP6@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com,
 jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
 bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
 <20260323162003.0d155055@kernel.org> <acLUMN1BYkIVyOk8@mini-arch>
 <20260324142114.216fcb01@kernel.org> <acMU93XN02PHmAGi@mini-arch>
 <20260324204440.1752423d@kernel.org> <acP59NM6HZhV9oAe@mini-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acP59NM6HZhV9oAe@mini-arch>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774460100; x=1775064900; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6LvfhXxnMpqu+8Jaxmf8YnU74NbO72vJex03sq4AEB4=;
 b=jKHDTbEsC11IMLl9bdH7eHLh7bnRELKjrQC7loqCO+4U37ZBHjWcIWwXK15ducggwe
 sxKNbolWeADsnMuMOpt15PwyvEAfUNuQsd8mK30k3xa8q7KUBz+2vvMAu6UGIGM4Gli8
 lyByW5uGTyGetHj94CBsbC22MymBb/ZhhBVhOx2jjWv9Bo7G6KkGnfvKjPNrEKCgoUfx
 be/EpJc0KKLNtFIxPK0jQguGziX1tYVZiZc2BbYIv6vmtONEs+Srw1uPR6HDC5FwEs8p
 DzbfWH6uNJDKKWJAJlEZr22OtGpjX76KpWaWZfRpouhYmYtqQwNbq2agdaCBsNmgVtkO
 CBLw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jKHDTbEs
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
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

On 03/25, Stanislav Fomichev wrote:
> On 03/24, Jakub Kicinski wrote:
> > On Tue, 24 Mar 2026 15:49:27 -0700 Stanislav Fomichev wrote:
> > > > > Not sure why cancel+release, maybe you're thinking about the unregister
> > > > > path? This is rtnl_unlock -> netdev_run_todo -> __rtnl_unlock + some
> > > > > extras.
> > > > > 
> > > > > And the flush is here to plumb the addresses to the real devices
> > > > > before we return to the callers. Mostly because of the following
> > > > > things we have in the tests:
> > > > > 
> > > > > # TEST: team cleanup mode lacp                                        [FAIL]
> > > > > #       macvlan unicast address not found on a slave
> > > > > 
> > > > > Can you explain a bit more on the suggestion?  
> > > > 
> > > > Oh, I thought it's here for unregister! Feels like it'd be cleaner to
> > > > add the flush in dev_*c_add() and friends? How hard would it be to
> > > > identify the callers in atomic context?  
> > > 
> > > Not sure we can do it in dev_xc_add because it runs under rtnl :-(
> > > I currently do flush in netdev_run_todo because that's the place that
> > > doesn't hold rtnl. Otherwise flush will get stuck because the work
> > > handler grabs it...
> > 
> > I was thinking of something a'la linkwatch. We can "steal" / "flush"
> > the pending work inline. I guess linkwatch is a major source of races
> > over the years...
> >
> > Does the macvlan + team problem still happens with the current
> > implementation minus the flush? We are only flushing once so only
> > pushing the addresses thru one layer of async callbacks.
> 
> Yes, it does happen consistently when I remove the flush. It also
> happens with my internal v4, so I need to look again at what's going on.
> Not sure whether it's my internal regression or I was just sloppy/lucky
> (since you're correct in pointing out that we flush only once).

Hmm, the test does 'team -d' in the background. That's why it works for
bonding, but not the teaming. I'll update the test to a bunch of
'ip' commands instead of starting a daemon..

> Before I went down the workqueue route, I had a simple
> net_todo_list-like approach: `list_add_tail` on enqueue and
> `while(!list_empty) run_work()` on rtnl_unlock. This had a nice properly of
> tracking re-submissions (by checking whether the device's list_head is
> linked into the list or not) and it was relatively easy to do the
> recursive flush. Let me try get back to this approach and see whether
> it solves the flush? Not sure what wq buys us at this point.

Will still look into that, maybe something similar to the linkwatch as
you mentioned.
