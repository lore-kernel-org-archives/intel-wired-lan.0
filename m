From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Wed, 6 Oct 2021 15:23:48 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/2] e1000e: Separate TGP board
 type from SPT
In-Reply-To: <20210922065449.3780338-1-sasha.neftin@intel.com>
References: <20210922065449.3780338-1-sasha.neftin@intel.com>
Message-ID: <1945444a-ed8a-d230-1334-3c2485ea2f94@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/22/2021 09:54, Sasha Neftin wrote:
> We have a same LAN controller on different PCH.
> Separate TGP board type from SPT will alllow apply specific fixes
> for TGP platforms.
> 
> Suggested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +-
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 20 +++++++++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 45 +++++++++++----------
>   3 files changed, 46 insertions(+), 23 deletions(-)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

