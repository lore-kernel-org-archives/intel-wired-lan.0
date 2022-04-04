From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 4 Apr 2022 15:37:26 -0700
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix error when changing
 ring parameters on ice PF
In-Reply-To: <20220331111526.1333801-1-michal.maloszewski@intel.com>
References: <20220331111526.1333801-1-michal.maloszewski@intel.com>
Message-ID: <05d3d673-6e7a-1139-4043-16495336d18e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 3/31/2022 4:15 AM, Michal Maloszewski wrote:
> Reset is triggered when ring parameters are being changed through
> ethtool and queues are reconfigured for VF's VSI. If ring is changed
> again immediately, then the next reset could be executed before
> queues could be properly reinitialized on VF's VSI. It caused ice PF
> to mess up the VSI resource tree.
>
> Add a check in iavf_set_ringparam for adapter and VF's queue
> state. If VF is currently resetting or queues are disabled for the VF
> return with EAGAIN error.

You've sent this three times as all v1. For the future, please increment 
the version and document the changes between them.

https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220331111526.1333801-1-michal.maloszewski at intel.com/

https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220330200551.1319989-1-michal.maloszewski at intel.com/

https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220330195036.1319631-1-michal.maloszewski at intel.com/

