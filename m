From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon, 24 Jan 2022 18:35:19 +0100
Subject: [Intel-wired-lan] ice: Add support for inner etype in switchdev
In-Reply-To: <20220124173116.739083-6-alexandr.lobakin@intel.com>
References: <20220124173116.739083-1-alexandr.lobakin@intel.com>
 <20220124173116.739083-6-alexandr.lobakin@intel.com>
Message-ID: <20220124173519.739323-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon, 24 Jan 2022 18:31:16 +0100

> From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
> 
> Enable support for adding TC rules that filter on the inner
> EtherType field of tunneled packet headers.
> 
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
> Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>

That one was included by mistake, sorry :c

> ---
>  drivers/net/ethernet/intel/ice/ice_protocol_type.h |   2 +
>  drivers/net/ethernet/intel/ice/ice_switch.c        | 272 ++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c        |  15 +-
>  3 files changed, 277 insertions(+), 12 deletions(-)
> 

--- 8< ---

> -- 
> cgit 1.2.3-1.el7

Thanks,
Al
