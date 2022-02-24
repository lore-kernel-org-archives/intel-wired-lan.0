From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 24 Feb 2022 17:28:22 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ice: Fix re-enablement of FW
 logging after reset
In-Reply-To: <20220224133614.179091-1-jedrzej.jagielski@intel.com>
References: <20220224133614.179091-1-jedrzej.jagielski@intel.com>
Message-ID: <c46a15bfa098e8bcc8c1e7d88ebfaa69610ba7dd.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jedrzej,

On Thu, 2022-02-24 at 13:36 +0000, Jagielski, Jedrzej wrote:
> Device resets such as a CORER disable FW logging, and currently, it
> is
> not re-enabled by the driver after the reset. This means that FW log
> messages are not captured even though FW logging was enabled at
> driver
> load time.
> 
> To fix the issue, call ice_cfg_fw_log() from ice_rebuild() to re-
> enable
> the FW logging after a reset.
> 
> Fixes: 8b97ceb1dc0f ("ice: Enable firmware logging during device
> initialization.")
> Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Can you check the settings for your email. They don't match:

WARNING: From:/Signed-off-by: email name mismatch: 'From: "Jagielski,
Jedrzej" <jedrzej.jagielski@intel.com>' != 'Signed-off-by: Jedrzej
Jagielski <jedrzej.jagielski@intel.com>'
