From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:38:30 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Fix a couple off by one bugs
In-Reply-To: <20200131045658.ahliv7jvubpwoeru@kili.mountain>
References: <20200131045658.ahliv7jvubpwoeru@kili.mountain>
Message-ID: <4d2cb89e16e44f619e45d6470ce4b1c4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Dan Carpenter
> Sent: Thursday, January 30, 2020 8:57 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net] ice: Fix a couple off by one bugs
> 
> The hw->blk[blk]->es.ref_count[] array has hw->blk[blk].es.count elements.
> It gets allocated in ice_init_hw_tbls().  So the > should be
> >= to prevent accessing one element beyond the end of the array.
> 
> Fixes: 2c61054c5fda ("ice: Optimize table usage")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


