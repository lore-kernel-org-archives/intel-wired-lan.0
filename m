From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Sep 2020 03:16:44 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: clean up W=1 warnings in
 iavf
In-Reply-To: <20200902204551.2137634-1-jesse.brandeburg@intel.com>
References: <20200902204551.2137634-1-jesse.brandeburg@intel.com>
Message-ID: <DM6PR11MB28905D85D01D85AAAF7932D6BC380@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Wednesday, September 2, 2020 1:46 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net v1] iavf: clean up W=1 warnings in iavf
> 
> Inspired by Lee Jones, this elminates the remaining W=1 warnings
> in iavf.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 24 ++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
