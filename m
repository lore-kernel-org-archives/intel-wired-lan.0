From: David Miller <davem@davemloft.net>
Date: Tue, 25 Feb 2020 11:13:39 -0800 (PST)
Subject: [Intel-wired-lan] [patch net-next] iavf: use
 tc_cls_can_offload_basic() instead of chain check
In-Reply-To: <20200225121023.6011-1-jiri@resnulli.us>
References: <20200225121023.6011-1-jiri@resnulli.us>
Message-ID: <20200225.111339.990273097730952856.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Pirko <jiri@resnulli.us>
Date: Tue, 25 Feb 2020 13:10:23 +0100

> From: Jiri Pirko <jiri@mellanox.com>
> 
> Looks like the iavf code actually experienced a race condition, when a
> developer took code before the check for chain 0 was put to helper.
> So use tc_cls_can_offload_basic() helper instead of direct check and
> move the check to _cb() so this is similar to i40e code.
> 
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> ---
> This was originally part of "net: allow user specify TC filter HW stats type"
> patchset, but it is no longer related after the requested changes.
> Sending separatelly.

Jeff, do you want me to apply this directly?  If so, please give your ack.

Thanks.
