From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 13 Aug 2020 13:46:27 -0700
Subject: [Intel-wired-lan] [PATCH v2] i40e: fix return of uninitialized
 aq_ret in i40e_set_vsi_promisc
In-Reply-To: <20200813112638.12699-1-sassmann@kpanic.de>
References: <20200813112638.12699-1-sassmann@kpanic.de>
Message-ID: <20200813134627.4dd521cc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 13 Aug 2020 13:26:38 +0200 Stefan Assmann wrote:
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function ?i40e_set_vsi_promisc?:
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1176:14: error: ?aq_ret? may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   i40e_status aq_ret;
> 
> In case the code inside the if statement and the for loop does not get
> executed aq_ret will be uninitialized when the variable gets returned at
> the end of the function.
> 
> Avoid this by changing num_vlans from int to u16, so aq_ret always gets
> set. Making this change in additional places as num_vlans should never
> be negative.
> 
> Fixes: 37d318d7805f ("i40e: Remove scheduling while atomic possibility")
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>

Acked-by: Jakub Kicinski <kuba@kernel.org>

Good enough - in general unless you're trying to save space using types
other than unsigned int is not really worth it, and can slow the code
down - since 2B arithmetic is actually slowest on modern CPUs. But it's
not a fast path, so doesn't matter much.
