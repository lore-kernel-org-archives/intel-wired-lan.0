From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sun, 19 Jan 2020 12:02:56 +0100
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Add support for Alder Lake
In-Reply-To: <20200119074601.33324-1-sasha.neftin@intel.com>
References: <20200119074601.33324-1-sasha.neftin@intel.com>
Message-ID: <46e9c8d6-3382-2614-4087-8cfedcdeb9dd@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


Am 19.01.20 um 08:46 schrieb Sasha Neftin:
> Add devices ID's for the next LOM generations that will be
> available on the next Intel Client platform (Alder Lake)
> This patch provides the initial support for these devices
> 
> v1->v2:
> Address comminuty comments

community

> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ethtool.c | 3 ++-
>   drivers/net/ethernet/intel/e1000e/hw.h      | 5 +++++
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 7 +++++++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 7 ++++++-
>   drivers/net/ethernet/intel/e1000e/ptp.c     | 1 +
>   5 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index adce7e319b9e..aac0b7fb6243 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -895,8 +895,8 @@ static int e1000_reg_test(struct e1000_adapter *adapter, u64 *data)
>   	case e1000_pch_lpt:
>   	case e1000_pch_spt:
>   	case e1000_pch_cnp:
> -		/* fall through */

Please split this out, or mention this in a commit message. Also, there 
are more instances. If you want, I can sent a clean-up commit for the 
unnecessary fall-through comments.

[?]


Kind regards,

Paul
