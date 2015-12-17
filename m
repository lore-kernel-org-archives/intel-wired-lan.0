From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Dec 2015 16:49:21 +0000
Subject: [Intel-wired-lan] [next PATCH S23 07/13] i40evf: allow
	channel	bonding of VFs
In-Reply-To: <1449705033-4968-8-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-8-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96F0BF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, December 09, 2015 3:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 07/13] i40evf: allow channel
> bonding of VFs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In some modes, bonding would not enslave VF interfaces. This is due to
> bonding calling change_mtu and the immediately calling open. Because of
> the asynchronous nature of the admin queue mechanism, the VF returns -
> EBUSY to the open call, because it knows the previous operation hasn't
> finished yet. This causes bonding to fail with a less-than-useful error
> message.
> 
> To fix this, remove the check for pending operations at the beginning of
> open. But this introduces a new bug where the driver will panic on a quick
> close/open cycle. To fix that, we add a new driver state,
> __I40EVF_DOWN_PENDING, that the driver enters when down is called. The
> driver finally transitions to a fully DOWN state when it receives confirmation
> from the PF driver that all the queues are disabled. This allows open to
> complete even if there is a pending mtu change, and bonding is finally happy.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I06f4c7e435d5bacbfceaa7c3f209e0ff04be21cc
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h          | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 9 +++++----
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 ++
>  3 files changed, 8 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
