From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Mar 2017 18:28:54 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: clean macvlan MAC filter table
 on	VF reset
In-Reply-To: <20170328182754.3607.1614.stgit@localhost6.localdomain6>
References: <20170328182754.3607.1614.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A959@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Tuesday, March 28, 2017 11:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: clean macvlan MAC filter table on
> VF reset
> 
> Flush the macvlan filters on VF reset to avoid conflict with other VFs that may
> end up using the same MAC address.
> 
> The main change here is the call to ixgbe_set_vf_macvlan() with index 0.
> 
> Moved ixgbe_set_vf_macvlan() in front of ixgbe_vf_reset_event() to avoid
> adding a  prototype.
> 
> Reported-by: Sritej Kanakadandi Sritej Rama <skanakad@cisco.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |  105 ++++++++++++--------
> ----
>  1 file changed, 53 insertions(+), 52 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


