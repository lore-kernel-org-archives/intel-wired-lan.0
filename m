From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 1 Mar 2022 15:06:08 -0800
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix re-enablement of FW
 logging after reset
In-Reply-To: <20220228123928.278014-1-jedrzej.jagielski@intel.com>
References: <20220228123928.278014-1-jedrzej.jagielski@intel.com>
Message-ID: <622d12a7-2667-c01e-3bfa-7fddf50a2b45@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 2/28/2022 4:39 AM, Jedrzej Jagielski wrote:
> From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
>
> Device resets such as a CORER disable FW logging, and currently, it is
> not re-enabled by the driver after the reset. This means that FW log
> messages are not captured even though FW logging was enabled at driver
> load time.
>
> To fix the issue, call ice_cfg_fw_log() from ice_rebuild() to re-enable
> the FW logging after a reset.
>
> Fixes: 8b97ceb1dc0f ("ice: Enable firmware logging during device initialization.")
> Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: fix incorrect git mail config

I still see the same issue:

From:/Signed-off-by: email name mismatch: 'From: "Jagielski, Jedrzej" 
<jedrzej.jagielski@intel.com>' != 'Signed-off-by: Jedrzej Jagielski 
<jedrzej.jagielski@intel.com>'

