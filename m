From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Thu, 19 May 2022 10:03:23 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix adding ADq filter to
 TC0
In-Reply-To: <20220429122708.978369-1-jedrzej.jagielski@intel.com>
References: <20220429122708.978369-1-jedrzej.jagielski@intel.com>
Message-ID: <MN2PR11MB36143756B2546DC32C4EF3F98ED09@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedzej Jagielski
> Sent: Friday, April 29, 2022 5:57 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix adding ADq filter to TC0
> 
> From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> 
> Procedure of configure tc flower filters erroneously allows to create filters
> on TC0 where unfiltered packets are also directed by default.
> Issue was caused by insufficient checks of hw_tc parameter specifying the
> hardware traffic class to pass matching packets to.
> 
> Fix checking hw_tc parameter which blocks creation of filters on TC0.
> 
> Fixes: 2f4b411a3d67 ("i40e: Enable cloud filters via tc-flower")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: fix commit msg
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
Tested-by: Bharathi Sreenivas<bharathi.sreenivas@intel.com>
