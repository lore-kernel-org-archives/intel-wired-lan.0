From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 3 Mar 2022 07:51:45 +0000
Subject: [Intel-wired-lan] [net-next PATCH 10/25] ice: log an error
 message when eswitch fails to configure
In-Reply-To: <20220223002712.2771809-11-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-11-jacob.e.keller@intel.com>
Message-ID: <MW3PR11MB45543A17FF47EC3B1CF75B749C049@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Jacob Keller
>Sent: Wednesday, February 23, 2022 5:57 AM
>To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
>Subject: [Intel-wired-lan] [net-next PATCH 10/25] ice: log an error message
>when eswitch fails to configure
>
>When ice_eswitch_configure fails, print an error message to make it more
>obvious why VF initialization did not succeed.
>
>Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_sriov.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
