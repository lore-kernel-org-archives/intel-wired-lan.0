From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:27:01 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Prevent unsupported
 configurations with XDP
In-Reply-To: <20180730225248.42639-1-anthony.l.nguyen@intel.com>
References: <20180730225248.42639-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB301@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, July 30, 2018 3:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: jakub.kicinski at netronome.com
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Prevent unsupported
> configurations with XDP
> 
> These changes address comments by Jakub Kicinski on commit 38b7e7f8ae82
> ("ixgbe: Do not allow LRO or MTU change with XDP").
> 
> Change the MTU check with XDP to allow any supported value and only
> reject those outside of the range as opposed to rejecting any change when
> XDP is active. In situations where MTU size is not supported, return -EINVAL
> instead of -EPERM.
> 
> Add checks when enabling SRIOV, DCB, or adding L2FW offloaded device as
> they are not supported with XDP.
> 
> CC: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> Added check for L2FW offload and updated description.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 28
> ++++++++++++++++++++++++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |  5 +++++
>  2 files changed, 31 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


