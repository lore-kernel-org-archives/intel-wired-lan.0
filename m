From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 7 Feb 2022 20:06:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] ice: enable parsing IPSEC
 SPI headers for RSS
In-Reply-To: <20220114233718.67841-1-jesse.brandeburg@intel.com>
References: <20220114233718.67841-1-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB33676D290B3FD574CE160B65FC2C9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Saturday, January 15, 2022 5:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v1] ice: enable parsing IPSEC SPI
> headers for RSS
> 
> The COMMS package can enable the hardware parser to recognize IPSEC
> frames with ESP header and SPI identifier.  If this package is available and
> configured for loading in /lib/firmware, then the driver will succeed in
> enabling this protocol type for RSS.
> 
> This in turn allows the hardware to hash over the SPI and use it to pick a
> consistent receive queue for the same secure flow. Without this all traffic is
> steered to the same queue for multiple traffic threads from the same IP
> address.
> 
> If the package is not available, adding this type will fail, but the failure is
> ignored on purpose as it has no negative affect.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
