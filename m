From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 15 Mar 2022 11:56:39 +0000
Subject: [Intel-wired-lan] [PATCH linux-firmware v3] ice: update ice DDP
 comms package to 1.3.31.0
In-Reply-To: <20220311220230.2430-1-arjun.anantharam@intel.com>
References: <20220311220230.2430-1-arjun.anantharam@intel.com>
Message-ID: <BYAPR11MB3367C73D351EC98E20CB9130FC109@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arjun Anantharam
> Sent: Saturday, March 12, 2022 3:33 AM
> To: intel-wired-lan at lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Anantharam, Arjun
> <arjun.anantharam@intel.com>; Rao, Guruprasad Kudukolly
> <guruprasad.kudukolly.rao@intel.com>
> Subject: [Intel-wired-lan] [PATCH linux-firmware v3] ice: update ice DDP
> comms package to 1.3.31.0
> 
> Update ice DDP comms package file to the latest version: 1.3.31.0
> 
> Highlight of changes since 1.3.20.0:
> 
> - Add Separate Package Type Group for outer IPv4 and IPv6 tunnel packet
> - Add GTPU SCTP ptypes to PTGs mapping
> - Add Multicast support in Flow Director
> - Add profiles for GTPU extension header
> 
> Signed-off-by: Arjun Anantharam <arjun.anantharam@intel.com>
> ---
> v3: Edited highlights of changes in package
> 
>  WHENCE                                        |   2 +-
>  ...ms-1.3.20.0.pkg => ice_comms-1.3.31.0.pkg} | Bin 688388 -> 717176 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)  rename intel/ice/ddp-
> comms/{ice_comms-1.3.20.0.pkg => ice_comms-1.3.31.0.pkg} (75%)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
