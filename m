From: Maloszewski, Michal <michal.maloszewski@intel.com>
Date: Wed, 27 Apr 2022 09:23:44 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: Fix error when
 changing ring parameters on ice PF
In-Reply-To: <36cb895d-aa0b-cf4b-7b0a-74bd63b5be67@intel.com>
References: <20220426203707.149900-1-michal.maloszewski@intel.com>
 <36cb895d-aa0b-cf4b-7b0a-74bd63b5be67@intel.com>
Message-ID: <BL1PR11MB54303576E8B98F77C27D3FA686FA9@BL1PR11MB5430.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Please discard these changes. I accidentally used net-next in git patch format, that's why it has been sent to next-net instead of net. I will correct it asap.

Thanks,
Micha? Ma?oszewski

-----Original Message-----
From: Nguyen, Anthony L <anthony.l.nguyen@intel.com> 
Sent: Tuesday, April 26, 2022 10:39 PM
To: Maloszewski, Michal <michal.maloszewski@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] iavf: Fix error when changing ring parameters on ice PF


On 4/26/2022 1:37 PM, Michal Maloszewski wrote:
> Reset is triggered when ring parameters are being changed through 
> ethtool and queues are reconfigured for VF's VSI. If ring is changed 
> again immediately, then the next reset could be executed before queues 
> could be properly reinitialized on VF's VSI. It caused ice PF to mess 
> up the VSI resource tree.
>
> Add a check in iavf_set_ringparam for adapter and VF's queue state. If 
> VF is currently resetting or queues are disabled for the VF return 
> with EAGAIN error.
>
> Fixes: d732a1844507 ("i40evf: fix crash when changing ring sizes")
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
> v2: Changed unnecessary parentheses

This does not address any of the comments on the netdev patch [1]. If you're making changes, it would be good acknowledge that on the netdev patch.

Also, why the change from net to net-next?

Thanks,

Tony

[1] https://lore.kernel.org/netdev/20220422154752.1fab6496 at kernel.org/

