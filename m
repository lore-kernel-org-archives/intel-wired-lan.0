From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 18 Jan 2022 16:10:59 +0100
Subject: [Intel-wired-lan] [PATCH net-next] ice: Add support for inner
 etype in switchdev
In-Reply-To: <20220116090142.2934-1-martyna.szapar-mudlaw@intel.com>
References: <20220116090142.2934-1-martyna.szapar-mudlaw@intel.com>
Message-ID: <20220118151059.25721-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
Date: Sun, 16 Jan 2022 10:01:43 +0100

> Enable support for adding TC rules that filter on the inner
> EtherType field of tunneled packet headers.
> 
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>

Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>

> ---
>  .../ethernet/intel/ice/ice_protocol_type.h    |   2 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 272 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  15 +-
>  3 files changed, 277 insertions(+), 12 deletions(-)

--- 8< ---

> -- 
> 2.31.1

Thanks!
Al
