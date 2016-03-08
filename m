From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Mar 2016 23:09:30 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 1/3] net: ixgbe: fix
	error	handling in tc cls_u32 offload routines.
In-Reply-To: <1457372509-3135-1-git-send-email-sridhar.samudrala@intel.com>
References: <1457372509-3135-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C9B8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Monday, March 07, 2016 9:42 AM
> To: intel-wired-lan at lists.osuosl.org; Fastabend, John R
> <john.r.fastabend@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 net-next 1/3] net: ixgbe: fix error
> handling in tc cls_u32 offload routines.
> 
> Check for handle ids when adding/deleting hash nodes OR adding/deleting
> filter entries and limit them to max number of links or header nodes
> supported(IXGBE_MAX_LINK_HANDLE).
> 
> Start from bit 0 when setting hash table bit-map.(adapter->tables)
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> ---
> 
> Jeff,
> This patchset replaces the following 2 patches that are in your queue.
> https://patchwork.ozlabs.org/patch/591644/
> https://patchwork.ozlabs.org/patch/592194/
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 52 +++++++++++++++++--
> --------
>  1 file changed, 34 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
