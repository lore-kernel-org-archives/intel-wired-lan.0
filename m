From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 2 Nov 2021 12:14:50 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Refactor
 iavf_mac_filter struct memory usage
In-Reply-To: <20210830082536.274203-1-jedrzej.jagielski@intel.com>
References: <20210830082536.274203-1-jedrzej.jagielski@intel.com>
Message-ID: <DM8PR11MB562102006F47ED929785D42FAB8B9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: poniedzia?ek, 30 sierpnia 2021 10:26
> To: intel-wired-lan at lists.osuosl.org
> Cc: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>; Jagielski,
> Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Refactor iavf_mac_filter
> struct memory usage
> 
> iavf_mac_filter struct contained couple boolean flags using up more memory
> than is necessary.
> Change the flags to be bitfields in an anonymous struct so all the flags now fit
> in one byte.
> 
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 21c95775509a..3feb9edb8131 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
