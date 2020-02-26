From: David Miller <davem@davemloft.net>
Date: Wed, 26 Feb 2020 09:01:53 -0800 (PST)
Subject: [Intel-wired-lan] [patch net-next v2] iavf: use
 tc_cls_can_offload_and_chain0() instead of chain check
In-Reply-To: <20200226082157.13848-1-jiri@resnulli.us>
References: <20200226082157.13848-1-jiri@resnulli.us>
Message-ID: <20200226.090153.917262074842828253.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Pirko <jiri@resnulli.us>
Date: Wed, 26 Feb 2020 09:21:57 +0100

> From: Jiri Pirko <jiri@mellanox.com>
> 
> Looks like the iavf code actually experienced a race condition, when a
> developer took code before the check for chain 0 was put to helper.
> So use tc_cls_can_offload_and_chain0() helper instead of direct check and
> move the check to _cb() so this is similar to i40e code.
> 
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> ---
> v1->v2:
> - rebased on top of net-next (using the correct helper name)

Applied, thanks Jiri.
