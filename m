From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 22:55:36 +0000
Subject: [Intel-wired-lan] [PATCH S21 09/14] ice: Align to updated AQ
 command formats
In-Reply-To: <20190416173503.29847-10-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
 <20190416173503.29847-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AFCD@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S21 09/14] ice: Align to updated AQ
> command formats
> 
> The current specification has updates to the command formats for manage
> MAC opcodes (opcodes 0x0107 and 0x0108) and get PHY caps (opcode
> 0x0600). Update the code to reflect this.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> squashed
> multiple commits]
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


