From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Mon, 20 Dec 2021 14:53:34 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/2] e1000e: Separate ADP board
 type from TGP
In-Reply-To: <20211207112306.1290098-1-sasha.neftin@intel.com>
References: <20211207112306.1290098-1-sasha.neftin@intel.com>
Message-ID: <e3219129-dd50-f8c6-986f-97ba05547d0d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/7/2021 13:23, Sasha Neftin wrote:
> We have the same LAN controller on different PCH's. Separate ADP board
> type from a TGP which will allow for specific fixes to be applied for
> ADP platforms.
> 
> Suggested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/e1000.h   |  4 ++-
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 20 +++++++++++++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 33 +++++++++++----------
>   3 files changed, 40 insertions(+), 17 deletions(-)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

