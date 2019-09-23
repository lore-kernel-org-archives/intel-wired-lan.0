From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Sep 2019 18:13:05 +0000
Subject: [Intel-wired-lan] [next PATCH S10 08/10] i40e: allow ethtool to
 report SW and FW versions in recovery mode
In-Reply-To: <20190920091724.51767-8-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
 <20190920091724.51767-8-alice.michael@intel.com>
Message-ID: <0d137a7fc4d44c8f89afa4e103a21e51@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, September 20, 2019 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S10 08/10] i40e: allow ethtool to
> report SW and FW versions in recovery mode
> 
> From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> Let ethtool print driver and firmware versions when NIC is in recovery mode.
> Assign i40e_get_drvinfo() operation to ethtool recovery mode operations.
> Previously ethtool did not report driver and firmware versions when NIC was
> in recovery mode.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


