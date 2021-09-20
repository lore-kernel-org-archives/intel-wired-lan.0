From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 20 Sep 2021 22:21:03 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: Add support for
 50G/100G in AIM algorithm
In-Reply-To: <20210920132539.24114-1-mateusz.palczewski@intel.com>
References: <20210920132539.24114-1-mateusz.palczewski@intel.com>
Message-ID: <f6facbbaada21e6e668fd2dd4c04a52f2546b6ec.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-09-20 at 15:25 +0200, Mateusz Palczewski wrote:
> Advanced link speed support was added long back, but adding AIM
> support
> was missed. Adding AIM support for advanced link speed support
> allows the algorithm to take into account 50G/100G link speeds.
> Also, other previous speeds are taken into consideration when
> advanced
> link speeds are supported.
> 
> Signed-off-by: Brett Creeley brett.creeley at intel.com
> Signed-off-by: Mateusz Palczewski mateusz.palczewski at intel.com

Please run checkpatch before sending:

ERROR: Unrecognized email address: 'Brett Creeley 
brett.creeley at intel.com'
#12:
Signed-off-by: Brett Creeley brett.creeley at intel.com

ERROR: Unrecognized email address: 'Mateusz Palczewski 
mateusz.palczewski at intel.com'
#13:
Signed-off-by: Mateusz Palczewski mateusz.palczewski at intel.com

WARNING: please, no space before tabs
#39: FILE: drivers/net/ethernet/intel/iavf/iavf_txrx.c:378:
+#define IAVF_AIM_MULTIPLIER_50G ^I1280$

WARNING: please, no space before tabs
#40: FILE: drivers/net/ethernet/intel/iavf/iavf_txrx.c:379:
+#define IAVF_AIM_MULTIPLIER_40G ^I1024$

WARNING: please, no space before tabs
#41: FILE: drivers/net/ethernet/intel/iavf/iavf_txrx.c:380:
+#define IAVF_AIM_MULTIPLIER_20G ^I512$

WARNING: please, no space before tabs
#42: FILE: drivers/net/ethernet/intel/iavf/iavf_txrx.c:381:
+#define IAVF_AIM_MULTIPLIER_10G ^I256$

WARNING: please, no space before tabs
#43: FILE: drivers/net/ethernet/intel/iavf/iavf_txrx.c:382:
+#define IAVF_AIM_MULTIPLIER_1G  ^I32$

CHECK: Please use a blank line after function/struct/union/enum
declarations
#66: FILE: drivers/net/ethernet/intel/iavf/iavf_txrx.c:404:
+}
+<200b>

CHECK: Please use a blank line after function/struct/union/enum
declarations
#95: FILE: drivers/net/ethernet/intel/iavf/iavf_txrx.c:422:
+}
+<200b>


> ---
>  v2: Removed build issues

Are you building these patches? Issues still exist:

drivers/net/ethernet/intel/iavf/iavf_txrx.c:404:1: error: stray \342 in
program
 
 ^
drivers/net/ethernet/intel/iavf/iavf_txrx.c:404:2: error: stray \200 in
program
 
  ^
drivers/net/ethernet/intel/iavf/iavf_txrx.c:404:3: error: stray \213 in
program
 
   ^
drivers/net/ethernet/intel/iavf/iavf_txrx.c:422:1: error: stray \342 in
program
 
 ^
drivers/net/ethernet/intel/iavf/iavf_txrx.c:422:2: error: stray \200 in
program
 
  ^
drivers/net/ethernet/intel/iavf/iavf_txrx.c:422:3: error: stray \213 in
program


> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 70 +++++++++++++++--
> ----
>  1 file changed, 51 insertions(+), 19 deletions(-)

