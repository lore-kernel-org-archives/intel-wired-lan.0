From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Apr 2016 21:58:19 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: consolidate the
 configuration	of spoof checking
In-Reply-To: <20160318231114.25773.46384.stgit@localhost6.localdomain6>
References: <20160318225046.25773.35723.stgit@localhost6.localdomain6>
 <20160318231114.25773.46384.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9CF49E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, March 18, 2016 4:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: consolidate the configuration of
> spoof checking
> 
> Consolidate the logic behind configuring spoof checking:
> 
> - move the setting of the MAC, VLAN and Ethertype spoof checking into
> ixgbe_ndo_set_vf_spoofchk().
> 
> - change ixgbe_set_mac_anti_spoofing() to set MAC spoofing per VF similar
> to the VLAN and Ethertype functions - this allows us to call the helper
> functions in ixgbe_ndo_set_vf_spoofchk() for all spoof check types and only
> disable MAC spoof checking when creating MACVLAN.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   40 ++++++--------------
> -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |    2 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |   30 ++--------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c  |   44 +++++++++++++++----
> ----
>  4 files changed, 43 insertions(+), 73 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
