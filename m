From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jun 2020 19:16:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error return code
 in ice_add_prof()
In-Reply-To: <20200427121228.12241-1-weiyongjun1@huawei.com>
References: <20200427121228.12241-1-weiyongjun1@huawei.com>
Message-ID: <MWHPR11MB1663790302E561B81C8767078C890@MWHPR11MB1663.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wei Yongjun
> Sent: Monday, April 27, 2020 5:12 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; kernel-janitors at vger.kernel.org; Wei
> Yongjun <weiyongjun1@huawei.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error return code in
> ice_add_prof()
> 
> Fix to return a error code from the error handling case instead of 0, as done
> elsewhere in this function.
> 
> Fixes: 31ad4e4ee1e4 ("ice: Allocate flow profile")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


