From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 14 Mar 2022 09:30:03 -0700
Subject: [Intel-wired-lan] [PATCH v2 net-next 0/4] ice: switch: debloat
 packet templates code
In-Reply-To: <20220127154009.623304-1-alexandr.lobakin@intel.com>
References: <20220127154009.623304-1-alexandr.lobakin@intel.com>
Message-ID: <40f168ef-f610-4082-d032-d3625505a323@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alex,

On 1/27/2022 7:40 AM, Alexander Lobakin wrote:
> Note: this will conflict with [1] going through net-next,
> a followup will be sent once accepted.

The series you referenced was accepted and now I'm conflicting as you 
alluded. I'm dropping this version and will await your updated one.

Thanks,

Tony

>  From v1 ([0]):
>   - rebase on top of the latest next-queue (to fix #3 not applying);
>   - adjust the kdoc accordingly to the function proto changes in #3;
>   - no functional changes.
>
> [0] https://lore.kernel.org/netdev/20220124173116.739083-1-alexandr.lobakin at intel.com
> [1] https://lore.kernel.org/netdev/20220127125525.125805-1-marcin.szycik at linux.intel.com
>
> Alexander Lobakin (4):
>    ice: switch: add and use u16[] aliases to ice_adv_lkup_elem::{h,m}_u
>    ice: switch: unobscurify bitops loop in ice_fill_adv_dummy_packet()
>    ice: switch: use a struct to pass packet template params
>    ice: switch: use convenience macros to declare dummy pkt templates
>
>   drivers/net/ethernet/intel/ice/ice_switch.c | 273 ++++++++------------
>   drivers/net/ethernet/intel/ice/ice_switch.h |  12 +-
>   2 files changed, 123 insertions(+), 162 deletions(-)
>
