From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Mon, 20 Dec 2021 14:54:44 +0200
Subject: [Intel-wired-lan] [PATCH v1 2/2] e1000e: Handshake with CSME
 starts from ADL platforms
In-Reply-To: <20211207112342.1290154-1-sasha.neftin@intel.com>
References: <20211207112342.1290154-1-sasha.neftin@intel.com>
Message-ID: <02bdc5ca-157b-f433-cffe-c1329b1018b8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/7/2021 13:23, Sasha Neftin wrote:
> Update the handshake with CSME flow to works starts from the ADL
> platform.
> 
> Fixes: 3e55d231716e ("e1000e: Add handshake with the CSME to support S0ix")
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

