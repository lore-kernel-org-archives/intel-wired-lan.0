From: Don Buchholz <donald.buchholz@intel.com>
Date: Thu, 9 Aug 2018 20:02:34 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: firmware recovery mode
In-Reply-To: <20180731160410.50028-1-sebastianx.basierski@intel.com>
References: <20180731160410.50028-1-sebastianx.basierski@intel.com>
Message-ID: <73d532f5-609c-8743-0137-def05ed5debb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 07/31/2018 09:04 AM, Sebastian Basierski wrote:
> Add check for FW NVM recovery mode during driver initialization and
> service task. If in recovery mode, log message and unregister device
>
> Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> ---
>   .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 12 ++++++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 41 +++++++++++++++++++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 ++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 15 +++++++
>   4 files changed, 72 insertions(+)
>

Tested-by:  Don Buchholz <donald.buchholz@intel.com>


