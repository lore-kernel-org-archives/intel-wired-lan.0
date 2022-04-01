From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 1 Apr 2022 03:34:05 +0000
Subject: [Intel-wired-lan] [PATCH linux-firmware] ice: Add wireless edge
 file for Intel E800 series driver
In-Reply-To: <20220317175932.78417-1-guruprasad.kudukolly.rao@intel.com>
References: <20220317175932.78417-1-guruprasad.kudukolly.rao@intel.com>
Message-ID: <BYAPR11MB3367B2388F0C417719B3178BFCE09@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Guruprasad Rao
> Sent: Thursday, March 17, 2022 11:30 PM
> To: intel-wired-lan at lists.osuosl.org; Anantharam, Arjun
> <arjun.anantharam@intel.com>; Rao, Guruprasad Kudukolly
> <guruprasad.kudukolly.rao@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Subject: [Intel-wired-lan] [PATCH linux-firmware] ice: Add wireless edge file
> for Intel E800 series driver
> 
> The ice driver can, optionally, load other package files for different
> packet processing pipeline configurations.
> 
> This package includes support for GTPv1, GTPv2 with extension headers,
> eCPRI, ESP and IPsec
> 
> Signed-off-by: Guruprasad Rao <guruprasad.kudukolly.rao@intel.com>
> ---
>  WHENCE                                         |   1 +
>  .../ice_wireless_edge-1.3.7.0.pkg              | Bin 0 -> 717176 bytes
>  2 files changed, 1 insertion(+)
>  create mode 100644 intel/ice/ddp-wireless_edge/ice_wireless_edge-
> 1.3.7.0.pkg
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
