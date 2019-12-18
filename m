From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:29:18 +0000
Subject: [Intel-wired-lan] [PATCH S35 10/15] ice: Enable ip link show on
 the PF to display VF unicast MAC(s)
In-Reply-To: <20191212111307.33566-10-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-10-anthony.l.nguyen@intel.com>
Message-ID: <2434122532aa4f57a4532f8e08a7b476@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 10/15] ice: Enable ip link show on the
> PF to display VF unicast MAC(s)
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when there are SR-IOV VF(s) and the user does "ip link show <pf
> interface>" the VF unicast MAC addresses all show 00:00:00:00:00:00
> if the unicast MAC was set via VIRTCHNL (i.e. not administratively set by the
> host PF).
> 
> This is misleading to the host administrator. Fix this by setting the VF's
> dflt_lan_addr.addr when the VF's unicast MAC address is configured via
> VIRTCHNL. There are a couple cases where we don't allow the
> dflt_lan_addr.addr field to be written. First, If the VF's pf_set_mac field is
> true and the VF is not trusted, then we don't allow the dflt_lan_addr.addr to
> be modified. Second, if the dflt_lan_addr.addr has already been set (i.e. via
> VIRTCHNL).
> 
> Also a small refactor was done to separate the flow for add and delete MAC
> addresses in order to simplify the logic for error conditions and set/clear the
> VF's dflt_lan_addr.addr field.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 199 +++++++++---------
>  1 file changed, 99 insertions(+), 100 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


