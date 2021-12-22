From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Dec 2021 14:34:36 +0000
Subject: [Intel-wired-lan] [PATCH net v5] i40e: Fix for displaying
 message regarding NVM version
In-Reply-To: <20211209100435.14378-1-mateusz.palczewski@intel.com>
References: <20211209100435.14378-1-mateusz.palczewski@intel.com>
Message-ID: <BYAPR11MB3367CD7AD31A5FA68E6AC162FC7D9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Thursday, December 9, 2021 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v5] i40e: Fix for displaying message
> regarding NVM version
> 
> When loading the i40e driver, it prints a message like: 'The driver for the
> device detected a newer version of the NVM image v1.x than expected v1.y.
> Please install the most recent version of the network driver.' This is misleading
> as the driver is working as expected.
> 
> Fix that by removing the second part of message and changing it from dev_info
> to dev_dgb.
> 
> Fixes: 4fb29bddb ("i40e: The driver now prints the API version in error
> message")
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v5: Fixed wrong formatting
>  v4: Removed the word "expected' as this might have been misleading
>  v3: Changed the patch after community review
>  v2: Fixed the fixes tag to be 12 digits long
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
