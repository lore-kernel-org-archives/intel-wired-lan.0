From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 12 Aug 2020 10:46:28 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: fix uninitialized variable in
 i40e_set_vsi_promisc
In-Reply-To: <20200812143950.11675-1-sassmann@kpanic.de>
References: <20200812143950.11675-1-sassmann@kpanic.de>
Message-ID: <20200812104628.340a073a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 12 Aug 2020 16:39:50 +0200 Stefan Assmann wrote:
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function ?i40e_set_vsi_promisc?:
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1176:14: error: ?aq_ret? may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   i40e_status aq_ret;

What's your compiler? I don't see it on GCC 10.1.

> In case the code inside the if statement and the for loop does not get
> executed aq_ret will be uninitialized when the variable gets returned at
> the end of the function.

I think it'd be a better fix to make num_vlans unsigned.
