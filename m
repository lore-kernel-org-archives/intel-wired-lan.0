From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2020 17:14:46 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: mark PM functions as
 __maybe_unused
In-Reply-To: <20200728014153.44834-1-weiyongjun1@huawei.com>
References: <20200728014153.44834-1-weiyongjun1@huawei.com>
Message-ID: <BN6PR1101MB2145FF1C418319180C16CA058C700@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wei Yongjun
> Sent: Monday, July 27, 2020 6:42 PM
> To: Hulk Robot <hulkci@huawei.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Jakub Kicinski <kuba@kernel.org>; Alexei
> Starovoitov <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>;
> Jesper Dangaard Brouer <hawk@kernel.org>; John Fastabend
> <john.fastabend@gmail.com>; Abodunrin, Akeem G
> <akeem.g.abodunrin@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; Wei Yongjun
> <weiyongjun1@huawei.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] ice: mark PM functions as
> __maybe_unused
> 
> In certain configurations without power management support, the following
> warnings happen:
> 
> drivers/net/ethernet/intel/ice/ice_main.c:4214:12: warning:
>  'ice_resume' defined but not used [-Wunused-function]
>  4214 | static int ice_resume(struct device *dev)
>       |            ^~~~~~~~~~
> drivers/net/ethernet/intel/ice/ice_main.c:4150:12: warning:
>  'ice_suspend' defined but not used [-Wunused-function]
>  4150 | static int ice_suspend(struct device *dev)
>       |            ^~~~~~~~~~~
> 
> Mark these functions as __maybe_unused to make it clear to the compiler
> that this is going to happen based on the configuration, which is the standard
> for these types of functions.
> 
> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


