From: Don Buchholz <donald.buchholz@intel.com>
Date: Fri, 29 Mar 2019 15:41:22 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Introduce recovery mode support
In-Reply-To: <20190329182639.78880-1-alice.michael@intel.com>
References: <20190329182639.78880-1-alice.michael@intel.com>
Message-ID: <3e0765f9-db9e-291e-cba9-c83c9b389992@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 03/29/2019 11:26 AM, Alice Michael wrote:
> This patch introduces "recovery mode" to the i40e driver. It is
> part of a new Any2Any idea of upgrading the firmware. In this
> approach, it is required for the driver to have support for
> "transition firmware", that is used for migrating from structured
> to flat firmware image. In this new, very basic mode, i40e driver
> must be able to handle particular IOCTL calls from the NVM Update
> Tool and run a small set of AQ commands.
>
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> Signed-off-by: Piotr Marczak <piotr.marczak@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h        |   1 +
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  14 +-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 321 ++++++++++++++++--
>   3 files changed, 305 insertions(+), 31 deletions(-)
>
Tested-by: Don Buchholz <donald.buchholz@intel.com>
