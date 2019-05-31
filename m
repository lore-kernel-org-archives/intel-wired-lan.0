From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 May 2019 18:00:09 +0000
Subject: [Intel-wired-lan] [next PATCH S6 5/7] i40e: missing priorities
 for any QoS traffic
In-Reply-To: <20190528175921.30534-5-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
 <20190528175921.30534-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DD5D0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 28, 2019 10:59 AM
> To: alice.micheal at intel.com; intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S6 5/7] i40e: missing priorities for any
> QoS traffic
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> This patch fixes reading f/w lldp agent status at dcb init time.
> It's done by removing direct nvm reading in i40e_update_dcb_config() and
> checking whether f/w lldp agent is disabled via
> I40E_FLAG_DISABLE_FW_LLDP flag in i40e_init_pf_dcb(). The function
> i40e_update_dcb_config() in i40e_main.c is a temporary solution which will
> be later renamed to i40e_init_dcb() in the i40e_dcb module. Also logging was
> extended to make visible if f/w lldp agent is running or not and always log a
> message when dcb was not initialized. Without this patch for new f/w
> versions f/w lldp agent status was always read from nvm as disabled and dcb
> initialization failed without clear reason in logs.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 57 +++++++++++++++++++--
>  1 file changed, 54 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


